<?php
if(!function_exists("printhead")){
	function printhead(){  
		echo '<!DOCTYPE html>
		<html>
			<head>
				<title>Sql-Or-Die</title>
				<meta charset="UTF-8">
				<meta name="viewport" content="width=device-width, initial-scale=1">
				<link rel="icon" type="image/png" href="/sql_redisign/img/sql.png" />

				<!-- Latest compiled and minified CSS -->
				<!-- link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css" -->
				<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.3/css/bootstrap.min.css" integrity="sha384-Zug+QiDoJOrZ5t4lssLdxGhVrurbmBWopoEl+M6BdEfwnCJZtKxi1KgxUyJq13dy" crossorigin="anonymous">
				<!-- Optional theme -->
				<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
				<link rel="stylesheet" href="stylesheets/style.css">
				<link rel="stylesheet" href="stylesheets/jquery.fancybox.min.css">
				<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.12.4/css/bootstrap-select.min.css">
				<meta http-equiv="Content-Style-Type" content="text/css">
				<meta charset="utf-8">
				<script src="https://www.google.com/recaptcha/api.js"></script>
			</head>';

	}
} 

if(!function_exists("printheader")){
	function printheader($auth = ""){
	echo '<header>
			<nav class="navbar navbar-default navbar-expand-lg navbar-light bg-light" role="navigation">
				<div class="container">
					<div class="navbar-brand site_logo" href="#"></div>
					<button type="button" class="navbar-toggler" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="#navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
						<span class="navbar-toggler-icon"></span>
					</button>
					<div class="collapse navbar-collapse" id="navbarSupportedContent">
					<ul class="nav navbar-nav mr-auto">
						<li class="nav-item p-3"><a href="index.php"  style="display:none;">На главную</a></li>
						<li class="nav-item p-3"><a href="sqlex.php">Практические задания</a></li>
						<li class="nav-item p-3"><a href="esqlex.php" disabled>Операторы модификации данных</a></li>
						<li class="nav-item p-3"><a href="contacts.php" >О разработчике</a></li>
					</ul>
					<ul class="nav navbar-nav navbar-right">
						<li class="dropdown">
						<a href="#" class="dropdown-toggle ghost" data-toggle="dropdown">
								<div id="icon" style="background-image: url(img/' . $_SESSION["user"]["avatar"] .')" class="icon d-flex justify-content-around align-items-center"></div>';
								if(isset($_SESSION["user"]) and count($_SESSION["user"]) > 0){
									echo $_SESSION["user"]["name"];
								}else{
									echo "Гость";
								}
				  echo '<b class="caret"></b>
						</a>
						<ul class="dropdown-menu">';
						if(isset($_SESSION["user"]) and count($_SESSION["user"]) > 0){
							echo '<li class="p-2"><a href="lk.php">Личный кабинет</a></li>';
							if(intval($_SESSION["user"]["role"]) == 1){
								echo '<li class="p-2"><a href="adminpanel.php">Панель управления</a></li>';
							}
					  		echo '<li class="p-2" class="divider"></li>
								  <li class="p-2"><a href="ajax/api.php?action=exit">Выйти</a></li>';
							}else{
								
								echo '<li class="p-2"><a href="login.php">Войти</a></li>
									 <li class="divider"></li>
									 <li class="p-2"><a href="registration.php">Зарегистрироваться</a></li>';
							}
				  echo '</ul>
							</li>
						</ul>
					</div>
				</div>
			</nav>
		<input type="hidden" name="userdata" value=\''.$auth.'\'">
	</header>';
	}
}

if(!function_exists("printfooter")){
	function printfooter(){ 
		echo '<footer>
				<script src="js/jquery-3.1.1.min.js"></script>
				<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
				<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.3/js/bootstrap.min.js" integrity="sha384-a5N7Y/aK3qNeh15eJKGWxsqtnX/wWdSZSKp+81YjTmS15nvnvxKHuzaWwXHDli+4" crossorigin="anonymous"></script>
			  	<script src="js/jquery.fancybox.min.js"></script>
				<script src="js/jquery.DataTables.min.js"></script>
			  	<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.12.4/js/bootstrap-select.min.js"></script>
				<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.12.4/js/i18n/defaults-*.min.js"></script>
			  	<script src="js/init.js"></script>
				<!-- script src="js/bootstrap.js"></script>
				<script src="js/bootstrap-tab.js"></script-->
				<div class="footer p-4" style="position: relative; bottom:0;">
					<div class="container">
						<p>© taviak 2016 - ' . date("Y") . '</p>
					</div>
				</div>
			</footer>';
	}
}
?>
