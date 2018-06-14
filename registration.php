<?php
require_once("autoload.php");
printhead(); ?>
<body class="login_wrap">
<? printheader(); ?>
	<main class="container">
		<div class="" id="loginform">
			<form class="col-10 col-sm-8 col-md-6 col-lg-4 p-4 navbar-form navbar-left" name="reg" action="action_reg.php" method="post" id="regform">
				<div id="ajaxresp"></div>
				<div class="input-group p-1" id="inputname">
					<span class="input-group-addon col-12 col-sm-4">Имя:</span>
					<input class="form-control col-12 col-sm-8" name="name" type="text" size="15" maxlength="15" required>
				</div>
				<div class="input-group p-1" id="inputln">
					<span class="input-group-addon col-12 col-sm-4">Фамилия:</span>
					<input class="form-control col-12 col-sm-8" name="lastname" type="text" size="15" maxlength="15" required>
				</div>
				<div class="input-group p-1" id="inputlog">
					<span class="input-group-addon col-12 col-sm-4" name="login" type="text" maxlength="15">Логин:</span>
					<input class="form-control col-12 col-sm-8" name="login" type="text" maxlength="15" required>
				</div>
				<div class="input-group p-1" id="inputlog">
					<span class="input-group-addon col-12 col-sm-4" name="login" type="text" maxlength="15">E-mail:</span>
					<input class="form-control col-12 col-sm-8" name="email" type="text" maxlength="15" required>
				</div>
				<div class="input-group p-1" id="inputpass">
					<span class="input-group-addon col-12 col-sm-4" name="password" type="password" maxlength="15">Пароль:</span>
					<input class="form-control col-12 col-sm-8" name="password" type="password" maxlength="15" required>
				</div>	
				<div class="input-group p-1" id="inputsel">
					<span class="input-group-addon col-12 col-sm-4" name="password" type="password" maxlength="15">Группа:</span>
					<select name="groups" id="groupslist" class="selectpicker1"></select>
				</div>	
				<div class="input-group p-1 d-flex justify-content-end">	
					<input name="send" type="submit" class="btn btn-default navbar-btn _ajax_btn" id="inputlog" value="Зарегистрироваться" data-action="regUser"><br>
				</div>
				
			</form>	
		</div>
	</main>
	<? printfooter(); ?>
</body>
</html>