<?php
class SqlEx {

    function __construct() {
      	
      	require_once("class.connection.php");
      	
      	$this->db = new Connection();

	}

	function updateTable(){
		$q = "SELECT id, login FROM users";
		if ($stmt = $this->db->dbcon_rw->prepare($q)) {
		    $stmt->execute();
		    $stmt->bind_result($id, $login);
		    while ($stmt->fetch()) {
		    	if(!$text){
		    		$asked = (bool)$asked ;
		    	}
		        $users[] = array('id'=>$id, 'login'=>$login);
		    }
		    $stmt->close();
		}else{
			return false;
		}

		foreach($users as &$user){
			$query = "SELECT num as 'id', ". $user['login'] ." as 'answer' FROM answers";
			if ($stmt = $this->db->dbcon_rw->prepare($query)) {
			    $stmt->execute();
			    $stmt->bind_result($id, $answer);
			    while ($stmt->fetch()) {
			        $user['answers'][$id] = (bool)$answer ? str_replace('\n', '', $answer) : false;
			    }
			    $stmt->close();
			}else{
				$user['answers'] = false;
			}

			$user['answers'] = serialize($user['answers']);

			$res = $this->db->dbcon_rw->query("UPDATE users SET answers= '". $user['answers'] ."' WHERE id = ". $user['id']);
			if($res) $user['success'] = true;
				else $user['success'] = false;
		}
		$this->db->dbcon_rw->close();
		return $users;
	}


	function getTasks($text = false, $login = "", $close = true){
		$login = $login ? $login : $_SESSION['user']['login'];
		$tasks = array();
		$query = "SELECT tasks.id, tasks.task, tasks.db, qer.qer, db.info as 'dbinfo', answers.". $login ." as 'asked' FROM ((tasks INNER JOIN qer ON tasks.id = qer.id) INNER JOIN db ON db.id = tasks.db) INNER JOIN answers ON answers.num = tasks.id";
		if ($stmt = $this->db->dbcon_rw->prepare($query)) {
		    $stmt->execute();
		    $stmt->bind_result($id, $task, $db, $qer, $dbinfo, $asked);
		    while ($stmt->fetch()) {
		    	if(!$text){
		    		$asked = (bool)$asked ;
		    	}
		        $tasks[] = array('id'=>$id, 'task'=>$task, 'db'=>$db, 'qer'=>$qer, 'dbinfo'=>$dbinfo, 'asked'=>$asked);
		    }
		    $stmt->close();
		}else{
			unset($_SESSION["tasks"]);
			return false;
		}
		if($close) $this->db->dbcon_rw->close();

		$_SESSION["tasks"] = $tasks;
		return json_encode($tasks);
	}


	function getResultTable($query, $conn = ""){
		$conn = $conn ? $conn : $this->db->dbcon_r;
		if(isset($query) and !empty($query)){
			$query = mb_strtolower(stripslashes($query));
			$result = $conn->query($query);
			if(!$result){
				return '<div class="alert alert-danger">Некорректный запрос: '. $conn->error.'</div></div></div></main>';
			};
			$count = $result->field_count;
			$table = array();
			$flag = true;
			while ($row = $result->fetch_array(MYSQLI_ASSOC)){	
			 	if ($flag){
			 		for($i = 0; $i < $count; $i++){
			 			$prop = $result->fetch_field_direct($i);
			 			$table[0][] = $prop->name;
			 		}
			 		$flag = false;
			 	}	
			 	$table[] = $row;
			}
			if(count($table) > 0){
				return json_encode($table);
			}
		}else{
			return false;
		}
	}

	function compareResult($query, $uquery, $conn = ""){
		$conn = $conn ? $conn : "";
		$ttable = $this->getResultTable($query, $conn);
		$utable = $this->getResultTable($uquery, $conn);
		if(!$utable){
			return array(
				'message' => '<div class="alert alert-danger">Некорректный запрос!</div>',
				'user' => "",
				'true' => json_decode($ttable)
				);
		};
		$ttable = json_decode($ttable);
		$utable = json_decode($utable);
		if(!$utable){
			return array(
				'message' => '<div class="alert alert-danger">Некорректный запрос!</div>',
				'user' => "",
				'true' => $ttable
				);
		};
		// кол-во столбцов
		$tcolumn = count($ttable[0]);
		$ucolumn = count($utable[0]);
		// кол-во строк
		$trow = count($ttable);
		$urow = count($utable);

		$flag = true;

		if($tcolumn == $ucolumn and $trow == $urow){
			foreach($ttable as $n=>$row){
				if($flag){
					$j = -1;
					foreach($row as $m=>$cell){
						$utable[$n] = (array)$utable[$n];
						$ttable[$n] = (array)$ttable[$n];
						if($flag and $utable[$n][$m] == $ttable[$n][$m]){
							$flag = true;
						}else{
							$flag = false;
							break;
						}
					}
				}else{
					break;
				}
			};
			if($flag){
				return array(
					'message' => '<div class="alert alert-success">Запрос верный!</div>',
					'user' => $utable,
					'true' => $ttable,
					'check' => true
					);
			}else{
				return array(
					'message' => '<div class="alert alert-warning">Запрос не точный!</div>',
					'user' => $utable,
					'true' => $ttable
					);
			};
		}else{
			return array(
				'message' => '<div class="alert alert-danger">Запрос не верный!</div>',
				'user' => $utable,
				'true' => $ttable
				);
		}
	}

	function checkTask($num, $query){
		if($num){
			$query = $query ? mb_strtolower(stripslashes($query)) : "";
			$result = $this->db->dbcon_rw->query("update answers set ". $_SESSION['user']['login'] ." = '".$query."' where num = '". $num ."' ;");
			if($result){
				$_SESSION['user']['score'] = $_SESSION['user']['score'] ? intval($_SESSION['user']['score']) + 1 : 1;
				$result = $this->db->dbcon_rw->query("update users set score = '". $_SESSION['user']['score'] ."' where id = ". $_SESSION['user']['id'].";");
				if($result){
					return true;
				}else{
					return false;
				}
			}else{
				return false;
			}
		}else{
			return false;
		}
	}




}
?>