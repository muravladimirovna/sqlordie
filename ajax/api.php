<?php
require_once("../autoload.php");

$sqlex = new SqlEx();
$user = new User();
$users = new Users();
$manager = new Manager();

$action = "";
$data = array();

if(isset($_REQUEST['action']) and !empty($_REQUEST['action'])){
	$action = $_REQUEST['action'];
	unset($_REQUEST['action']);
	if(isset($_REQUEST['data']) and !empty($_REQUEST['data'])){
		$data_ = explode('&',$_REQUEST['data']);
		foreach ($data_ as $key => $value) {
			$temp = explode('=',$value);
			if(!empty($temp[0])){
				$data[$temp[0]] = $temp[1];
			}
		}
	}

}elseif(isset($_FILES['uploadfile']) and !empty($_FILES['uploadfile'])){
	$action ="download";
}else{
	return false;
}

switch ($action) {
    case "login":
        $result = $user->Authorize($data);
        break;
    case "download":
	    if(isset($_FILES['uploadfile']) and !empty($_FILES['uploadfile'])){
			$result = $user->downloadImg($_FILES['uploadfile']);
	    }
	    break;
	case "removeUser":
		$id = $data['id'] ? $data['id'] : "";
		$result = $user->removeUser($id);
		break;
	case "changePassword":
		$result = $user->changePassword($data);
		break;
	case "getTasks":
		$result = $sqlex->getTasks();
		break;
	case "getGroupList":
		$id = $data['id'] ? $data['id'] : $_REQUEST["groupid"];
		$order = $_REQUEST["order"] ? $_REQUEST["order"] : "users.score DESC";
		$result = $users->getGroupList($id, $order);
		break;
	case "getResultTable":
		$query = $_REQUEST["query"] ? $_REQUEST["query"] : "";
		$result = $sqlex->getResultTable($query);
		unset($_REQUEST["query"]);
		break;
	case "compareResult":
		$query = $_REQUEST["query"] ? $_REQUEST["query"] : "";
		$uquery = $_REQUEST["uquery"] ? $_REQUEST["uquery"] : "";
		if($query and $uquery){
			$result = $sqlex->compareResult($query, $uquery);
			if($result){
				$result = $sqlex->compareResult($query, $uquery, $sqlex->db->dbcon_rw);
				if(isset($result["check"]) and $result["check"]){
					$res = $sqlex->checkTask($_REQUEST["num"], $uquery);
				}				
				if($result){
					$result = json_encode($result);
				}else{
					$result = false;
				}
			}
			unset($_REQUEST["query"]);
			unset($_REQUEST["uquery"]);
		}
		break;
	case "exit":
		$result = $user->unlogin();
		break;
	case "regUser":
		if(isset($data["name"]) and !empty($data["name"]) and isset($data["lastname"]) and !empty($data["lastname"]) and isset($data["login"]) and !empty($data["login"]) and isset($data["password"]) and !empty($data["password"])){
			$result = $user->regUser($data);
		}else{
			$result = false;
		}
		break;
	case "getGroups":
		$result = $users->getGroups();
		break;
	case "saveTask":
		if(!empty($data))
			$result = $manager->saveTask($data);
		break;
	case "createTask":
		if(!empty($data))
			$result = $manager->createTask($data);
		break;
	case "removeTask":
		if(!empty($data))
			$result = $manager->removeTask($data);
		break;
	case "getDbList":
		$result = $sqlex->getDbList();
		break;
	case "createDb":
		if(!empty($data))
			$result = $manager->createDb($data);
		break;
	case "saveUser":
		if(!empty($data))
			$result = $manager->saveUser($data);
		break;
	case "sendMail":
		if(!empty($data))
			$result = $user->sendMail($data);
		break;
}

if(isset($result) and $result){
	echo $result;
}

