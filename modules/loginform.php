<?function printloginform(){?>
	<div id="loginform">
		<form class="" action="action_log.php" method="post">
			<div class="input-group" id="inputlog">
				<span class="input-group-addon">Логин:</span>
				<input class="form-control login" name="login" type="text">
			</div>
			<div class="input-group" id="inputlog">
				<span class="input-group-addon">Пароль:</span>
				<input class="form-control password" name="password" type="password">
			</div>	
			<input name="l_send" class="btn btn-default navbar-btn" id="inputlog" value="Войти" onclick="login();">
		<a href="registration.php">Зарегистрироваться</a>
		</form>	
	</div>
<?}?>