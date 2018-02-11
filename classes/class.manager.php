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
			$result = $this->db->dbcon_rw->query("SELECT * FROM users_roles WHERE user_id = '". $_SESSION["user"]["id"] ."'' AND role_id = 1 ;");
			if($result->num_rows > 0){
				$_SESSION["tasks"] = $_SESSION["tasks"] ? $_SESSION["tasks"] : $this->sqlex->getTasks();
				return true;
			}else{
				header("Location: ../lk.php"); 
			}
		}else{
			header("Location: ../login.php"); 
		}
	}



} ?>