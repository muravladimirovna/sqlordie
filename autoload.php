<?php 
// require_once("classes/class.connection.php");
require_once("classes/class.user.php");
require_once("classes/class.users.php");
require_once("classes/class.sqlex.php");
require_once("classes/class.manager.php");
require_once("classes/SendMailSmtpClass.php");

$dir = "modules/";
	$files = scandir($dir);   
	foreach($files as $file){  
		if(($file !== '.') AND ($file !== '..')){
		   $file = $dir.$file;
		   #echo $file; echo '<br>';
		   require_once($file);
		}
	}
?>