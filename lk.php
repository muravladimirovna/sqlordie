<?php

require_once("autoload.php");

$user = new User();
$auth = $user->isAuth();

printhead(); ?>

<body class="wrapper">

	<?php printheader($auth); ?>		 

	<main class="d-flex flex-column justify-content-between">
		<div class="middle p-4"></div>

		<div class="tasks">	
			<div class="container">	
				<h1>Личный кабинет</h1><hr>
				<div class="col-12" id="ajaxresp"></div>
				<div class="lk_wrapper d-flex align-items-stretch justify-content-between col-12 p-0">
					<div class="col-3 d-flex flex-column justify-content-between p-0">	
						<label for="btn1" class="thumbnail">
							<img data-src="holder.js/300x400" src="<?='img/'.$_SESSION['user']['avatar'];?>" alt="<?='img/'.$avatars[$login];?>">
						</label>
						<form action="" method="POST" enctype=multipart/form-data>
							<input class="btn btn-default" type="file" name="uploadfile" value="" style="float:left;display:none;" id="btn1">
							<!-- <label for="btn1" class="btn btn-default" style="float:left;">Выберите файл</label> -->
							<input class="btn btn-warning ajax_img" value="Загрузить" name="download" id="btn2" data-action="download">
						</form>
					</div> 

					<div class="col-3 panellk d-flex justify-content-between p-0">
						
						<?php  
						if(isset($auth) and !empty($auth)){
							$userinfo = json_decode($auth);
						} ?>
						
						<div class="panel panel-default lk p-3">
							<h4>Логин: <font color="#5cb85c" id="user_login"> <?= $userinfo->{"login"}; ?> </font> </h4>
							<h4>Имя: <font color="#5cb85c" id="user_name"> <?= $userinfo->{"name"}; ?> </font> </h4>
							<h4>Фамилия: <font color="#5cb85c" id="user_lastname"> <?= $userinfo->{"lastname"}; ?> </font> </h4>
							<h4>Группа: <font color="#5cb85c" id="user_group"> <?= $userinfo->{"group"}; ?> </font> </h4>
							<h4>Результат: <font color="#5cb85c" id="user_score"> <?= $userinfo->{"score"}; ?> </font> </h4>
							<h4>Рейтинг: <font color="#5cb85c" id="user_position"> <?= $userinfo->{"position"}; ?> </font> </h4>
						</div>
						<form>
							<input type="hidden" name="id" value="<?= $userinfo->{"id"}; ?>">
							<a href="#" class="btn btn-default _ajax_btn del_acc" data-action="removeUser"><b style="color:#d08080;">Удалить</b> свой аккаунт</a>
						</form>
					</div>
					<div class="col-5 panellk p-0">
						<form class="panel panel-default head-lk p-4 d-flex flex-column justify-content-between">
							<span style="border:none;" class="p-0">Изменение пароля</span>
						
							<div class="d-flex align-items-center justify-content-between inputpas">
								<span class="col-5">Старый пароль:</span> 
								<input class="form-control col-7" name="old_pass" type="password" size="15" maxlength="15">
							</div>
							<div class="d-flex align-items-center justify-content-between inputpas">
								<span class="col-5">Новый пароль:</span> 
								<input class="form-control col-7" name="new_pass_1" type="password" size="15" maxlength="15">
							</div>
							<div class="d-flex align-items-center justify-content-between inputpas">
								<span class="col-5">Повторите пароль:</span> 
								<input class="form-control col-7" name="new_pass_2" type="password" size="15" maxlength="15">
							</div>
							<input class="btn btn-default _ajax_btn" id="change" type="button" name="submit" value="Изменить" data-action="changePassword" style="width: 100%;">
							
						</form>
					</div>
					</div>
				</div>
			<br clear="all">
			<hr>
		</div>
		<?php printfooter(); ?>
		</div>
		</main>
	</body>
</html>