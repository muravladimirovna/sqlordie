<?php
class Users {

    function __construct() {
      	
      	require_once("class.connection.php");

      	$this->db = new Connection();

    }



	function getUsersList($q = ""){
		if(empty($q)) return false;
		
		if ($stmt = $this->db->dbcon_rw->prepare($q)){
		    $stmt->execute();
		    $stmt->bind_result($id, $name, $lastname, $login, $password, $avatar, $score, $group_id, $group, $role);
		    $users = array();

		    while ($stmt->fetch()) {
		        $users[] = array(
		        	'id' => $id, 
		        	'login' => $login, 
		        	'password' => $password, 
		        	'name' => $name, 
		        	'lastname' => $lastname, 
		        	'avatar' => $avatar, 
		        	'score' => $score, 
		        	'group_id' => $group_id, 
		        	'group' => $group, 
		        	'role' => $role
	        	);
		    }
		    $stmt->close();
		}else{
			return false;
		}
		$this->db->dbcon_rw->close();
		if(count($users) > 0){
			return json_encode($users);
		}else{
			return false;
		}
	}

	function getGroupList($groupid = "", $order = "users.score DESC"){
		if(!empty($groupid)) {
			$groupid = !empty($groupid) ? $groupid : $_SESSION['user']['group_id'];

			$q = "SELECT users.id, users.name, users.lastname, users.login, users.password, users.avatar, users.score, users_groups.group_id, groups.name as 'group', users_roles.role_id as 'role' FROM (((users INNER JOIN users_groups ON users.id = users_groups.user_id) INNER JOIN groups ON groups.id = users_groups.group_id) INNER JOIN users_roles ON users.id = users_roles.user_id) WHERE users_groups.group_id = " . $groupid . " GROUP BY users.id ORDER BY " . $order . " ;";

			return $this->getUsersList($q);
		}
	}

	function getGroups(){
		if ($stmt = $this->db->dbcon_rw->prepare("SELECT id, name FROM groups ORDER BY id DESC")){
		    $stmt->execute();
		    $stmt->bind_result($id, $name);
		    $groups = array();

		    while ($stmt->fetch()) {
		        $groups[] = array(
		        	'id' => $id, 
		        	'name' => $name
	        	);
		    }
		    $stmt->close();
		}else{
			return false;
		}
		$this->db->dbcon_rw->close();
		return json_encode($groups);
	}



} ?>