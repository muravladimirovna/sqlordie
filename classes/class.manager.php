<?php
class Manager {

    function __construct() {
      	
      	require_once("class.connection.php");
      	
      	$this->db = new Connection();

      	$this->isAdmin();

		$this->tasks = $_SESSION["tasks"];
      	$this->sqlex = new SqlEx();
		$this->user = new User();
		$this->users = new Users();
	}

	function isAdmin(){
		if(isset($_SESSION["user"]["id"]) and !empty($_SESSION["user"]["id"])){
			$result = $this->db->dbcon_rw->query("SELECT * FROM users_roles WHERE user_id = '". $_SESSION["user"]["id"] ."' AND role_id = 1 ;");

			if($result->num_rows > 0){
				$_SESSION["tasks"] = $_SESSION["tasks"] ? $_SESSION["tasks"] : $this->sqlex->getTasks();
				return true;
			}else{
				header("Location: lk.php"); 
			}
		}else{
			header("Location: login.php"); 
		}
	}

	function saveTask() {
		$task_id = $_SESSION["task_id"];
		$task_text = !empty($_REQUEST["task_text"]) ? $this->db->dbcon_rw->real_escape_string(mb_strtolower($_REQUEST["task_text"])) : "";
		$answ_text = !empty($_REQUEST["answ_text"]) ? $this->db->dbcon_rw->real_escape_string(mb_strtolower($_REQUEST["answ_text"])) : "";

		if(!empty($task_text) && !empty($answ_text)) {

			$_SESSION["task_text"] = $task_text;
			$_SESSION["answ_text"] = $answ_text;

			$result = $this->db->dbcon_rw->query("update tasks set task = '".$task_text."' where id = '".$task_id."';");
			if($result) {
				$result = $this->db->dbcon_rw->query("update qer set qer = '".$answ_text."' where id = '".$task_id."';");
				if($result) {
					return json_encode(['success' => true, 'result' => ['task_text' => $task_text, 'answ_text' => $answ_text] ]);
				} else {				
					return json_encode(['success' => false, 'result' => ['task_text' => $task_text, 'answ_text' => $answ_text] ]);
				}
			} else {
				return json_encode(['success' => false, 'result' => ['task_text' => $task_text, 'answ_text' => $answ_text] ]);
			}
		}
	}

	function removeTask() {
		$task_id = $_SESSION["task_id"];

		$result = $this->db->dbcon_rw->query("DELETE FROM qer WHERE id = '"  .$task_id . "';");
		if($result) {
			$result = $this->db->dbcon_rw->query("DELETE FROM tasks WHERE id = '".  $task_id . "';");
			if($result) {
				$result = $this->db->dbcon_rw->query("DELETE FROM answers WHERE num = '".  $task_id . "';");
				if($result) {
					$_SESSION["task_text"] = '';
					$_SESSION["answ_text"] = '';

					$count = $this->db->dbcon_rw->query("SELECT count(id) as count FROM tasks;");
					$count = $count ? $count->fetch_array(MYSQLI_ASSOC) : false;
					$array = ['success' => true, 'result' => ['next' => $count ? $count['count'] + 1 : false] ];
					return json_encode($array);
				} else {
					return json_encode(['success' => false, 'result' => false, 'message' => "DELETE FROM answers WHERE num = '".$task_id."';"]);
				}
			} else {
				return json_encode(['success' => false, 'result' => false, 'message' => "DELETE FROM tasks WHERE id = '".$task_id."';"]);
			}
		} else {
			return json_encode(['success' => false, 'result' => false, 'message' => "DELETE FROM qer WHERE id = '".$task_id."';"]);
		}
	}




} ?>