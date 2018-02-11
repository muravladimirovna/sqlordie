<?php
require_once("autoload.php");
printhead(); ?>
<body class="login_wrap">
<? printheader(); ?>
	<main>
		<div id="loginform">
			<form class="col-10 col-sm-6 col-md-4 p-4">
				<div class="input-group" id="inputlog">
					<span class="input-group-addon col-12 col-sm-4">Логин:</span>
					<input class="form-control login col-12 col-sm-8" name="login" type="text">
				</div>
				<div class="input-group" id="inputpass">
					<span class="input-group-addon col-12 col-sm-4">Пароль:</span>
					<input class="form-control password col-12 col-sm-8" name="password" type="password">
				</div>	
				<input type="submit" name="l_send" class="ajax_btn btn btn-default navbar-btn" id="inputsend" value="Войти" data-action="login">				
			<a href="registration.php">Зарегистрироваться</a>
			</form>	
		</div>
	</main>
	<? printfooter(); ?>
</body>
</html>