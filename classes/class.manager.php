<?php
class Manager {

    function __construct() {
      	
      	require_once("class.connection.php");
      	
      	$this->db = new Connection();

      	//$this->isAdmin();

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

	function saveTask($data = false) {
		if(!empty($data)) {
			$task_id = $data["task_id"] ? $data["task_id"] : "";
			$task_text = !empty($data["task_text"]) ? urldecode($this->db->dbcon_rw->real_escape_string(mb_strtolower($data["task_text"]))) : "";
			$answ_text = !empty($data["answ_text"]) ? urldecode($this->db->dbcon_rw->real_escape_string(mb_strtolower($data["answ_text"]))) : "";

			if(!empty($task_text) && !empty($answ_text) && !empty($task_id)) {

				$result = $this->db->dbcon_rw->query("update tasks set task = '".$task_text."' where id = '".$task_id."';");
				if($result) {
					$result = $this->db->dbcon_rw->query("update qer set qer = '".$answ_text."' where id = '".$task_id."';");
					if($result) {
						return '<div class="alert alert-success" role="alert">Изменения успешно сохранены!</div>'; // json_encode(['success' => true, 'result' => ['task_text' => $task_text, 'answ_text' => $answ_text] ]);
					} else {				
						return '<div class="alert alert-danger" role="alert">Ошибка при сохранении ответа</div>'; // json_encode(['success' => false, 'result' => ['task_text' => $task_text, 'answ_text' => $answ_text] ]);
					}
				} else {
					return '<div class="alert alert-danger" role="alert">Ошибка при сохранении задания</div>';
				}
			}
		}
	}

	function createTask($data = false) {
		if(!empty($data)) {
			$task_text = !empty($data["task_text"]) ? urldecode($this->db->dbcon_rw->real_escape_string(mb_strtolower($data["task_text"]))) : "";
			$answ_text = !empty($data["answ_text"]) ? urldecode($this->db->dbcon_rw->real_escape_string(mb_strtolower($data["answ_text"]))) : "";
			$db = !empty($data["db"]) ? intval($data["db"]) : "";

			if(!empty($task_text) && !empty($answ_text) && !empty($db)) {

				$result = $this->db->dbcon_rw->query("insert into `tasks`(task, db) values ('".$task_text."','".$db."');");
				if($result) {
					$result = $this->db->dbcon_rw->query("insert into `qer`(qer) values ('".$answ_text."');");
					if($result) {
						return '<div class="alert alert-success" role="alert">Задание успешно сохранено!</div>';
					} else {				
						return '<div class="alert alert-danger" role="alert">Ошибка при сохранении ответа</div>';
					}
				} else {
					return '<div class="alert alert-danger" role="alert">Ошибка при сохранении задания</div>';
				}
			}
			return '<div class="alert alert-danger" role="alert">Не все поля заполнены!</div>';
		}
	}

	function removeTask($data = false) {
		$task_id = $data["task_id"];
		if(!empty($task_id)) {
			$result = $this->db->dbcon_rw->query("DELETE FROM qer WHERE id = '"  .$task_id . "';");
			if($result) {
				$result = $this->db->dbcon_rw->query("DELETE FROM tasks WHERE id = '".  $task_id . "';");
				if($result) {
					return  '<div class="alert alert-success" role="alert">Задание удалено!</div>';
				} else {
					return '<div class="alert alert-danger" role="alert">Ошибка при удалении задания</div>';
				}
			} else {
				return '<div class="alert alert-danger" role="alert">Ошибка при удалении ответа</div>';
			}
		} else {
			return '<div class="alert alert-danger" role="alert">Ошибка при удалении ответа</div>';
		}
	}

	function updateAnswers() {		
		// $result = $this->db->dbcon_rw->query("SELECT id,answers FROM users;");
	}

	function createDb($data = false) {
		if(!empty($data)) {
			$db_info = !empty($data["db_info"]) ? urldecode($this->db->dbcon_rw->real_escape_string(mb_strtolower($data["db_info"]))) : "";
			$db_name = !empty($data["db_name"]) ? urldecode($this->db->dbcon_rw->real_escape_string(mb_strtolower($data["db_name"]))) : "";

			if(!empty($db_info) && !empty($db_name)) {
				$result = $this->db->dbcon_rw->query("insert into `db`(info, name) values ('".$db_info."','".$db_name."');");
				if($result) {
					return '<div class="alert alert-success" role="alert">База данных успешно сохранена!</div>';
				} else {
					return '<div class="alert alert-danger" role="alert">Ошибка при сохранении базы данных</div>';
				}
			}
			return '<div class="alert alert-danger" role="alert">Не все поля заполнены!</div>';
		}
	}



} ?>