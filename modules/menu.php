<?/*
function printmenu(){?>
<header>
	<div class="container">
		<nav class="navbar navbar-default" role="navigation">
			<div class="container-fluid">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
						<span class="sr-only"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
					</button>
					<div class="navbar-brand" href="#">SQL</div>
				</div>
				<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav">
					<li><a href="index.php"  style="display:none;">На главную</a></li>
					<li><a href="sqlex.php">Практические задания</a></li>
					<li><a href="esqlex.php"  style="display:none;">Операторы модификации данных</a></li>
					<li><a href="#" style="display:none;">О разработчике</a></li>
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown">
					<a href="#" class="dropdown-toggle ghost" data-toggle="dropdown">
							<div id="icon">
								<span class="glyphicon glyphicon-user"></span>
							</div>
						<? if($_SESSION['dostup']==true){?>
							<?echo $_SESSION['name'];
						}else{?>
							<?
							echo "Гость";
							}?>
						<b class="caret"></b>
					</a>
					<ul class="dropdown-menu">
						<?if($_SESSION['dostup']==true){?>
							<li><a href="lk.php">Личный кабинет</a></li>
							<?if($_SESSION["admindostup"]==true){?>
								<li><a href="adminpanel.php">Панель управления</a></li>
							<?}?>
						<li class="divider"></li>
						<li><a href="viiti.php">Выйти</a></li>
						<?}else{?>
							<li><a href="login.php">Войти</a></li>
							<li class="divider"></li>
							<li><a href="registration.php">Зарегистрироваться</a></li>
						<?}?>
					</ul>
					</li>
				</ul>
				</div>
			</div>
		</nav>
	</div>
	<!--div class="navbar-fixed-bottom" style="position: absolute;">
		<p>© Company 2017</p>
	</div-->
</header>
	<?
}*/
?> 