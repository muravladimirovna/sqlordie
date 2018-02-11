<?/*function printhead(){
	?> 
	<!DOCTYPE html>
	<html>
		<head>
			<title>Sql-Or-Die</title>
			<meta charset="UTF-8">
			<meta name="viewport" content="width=device-width, initial-scale=1">

			<?
			$dir = "stylesheets/";
			$files = scandir($dir);   
			foreach($files as $file){  
				if(($file !== '.') AND ($file !== '..')){
				   $file = $dir.$file;
				   echo '<link rel="stylesheet" href="'.$file.'" >';
				}
			}
			?>
			<!-- Latest compiled and minified CSS -->
			<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.css">
			<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

			<!-- Optional theme -->
			<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

			<meta http-equiv="Content-Style-Type" content="text/css">
			<meta charset="utf-8">
		</head>
		<?
	session_start();

	
$_SESSION["sql"] = $_POST["sql"];
error_reporting (0);
}*/?>
