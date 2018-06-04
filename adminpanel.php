<?

require_once("autoload.php");

$user = new User();
$auth = $user->isAuth();

$sqlex = new SqlEx();
$tasks = $sqlex->getTasks();

$manager = new Manager();

printhead(); ?>

<body class="wrapper">
<? printheader($auth); ?>

<main>
	<div class="middle p-4"></div>
	<div class="tasks">	
		<div class="container">	

		<ul class="nav nav-pills">
			<li class="" style="border-radius: 5px;"><a href="#" style="color: white;">Задания</a></li>
			<li class=""><a href="users.php" style="color:black;">Пользователи</a></li>
		</ul>
		<div class="tab-content" style="padding-top: 15px;">
			<div class="col-md-6 col-sm-12 col-xs-12">
				<div id="all_tasks_table" class="panel-default all_tasks_table">
				</div>
			</div>
			<div class="panel-default col-md-8 col-sm-12 col-xs-12" id="tasks">
				<h1>Изменение заданий</h1><hr>
				<ul class="nav nav-pills nav-stacked">
					<!-- создание combobox для выбора заданий -->
					<div class="col-12 p-0">
						<div  class="panel panel-default p-4">			

							<!-- создание combobox для выбора заданий -->
							<form class="input-group" name="sql_form" action="" method="get">
								<!-- <select name="option" class="form-control task_num" style="width: 100px;" onchange="getTask();"> -->
								<select name="option" class="form-control task_num" id="task_select">
										<option value="" disabled>№</option>
								</select>
								
								<div class="select_number p-2">Выбeрите номер задания</div>
							</form>
							
							<!-- <div class="alert task_text" style="margin-bottom: 0px;" id="task_text"></div> -->
							
						</div>	
					</div>	
				
					<br clear="all">	  
					<br> 
					<form name="read_form" method="post">
						<textarea readonly name="task_text" class="well well-lg" id="task_text" style="margin-right:1%;width: 49%;float: left;resize:none;"></textarea>
						<textarea readonly name="answ_text" class="well well-lg" id="answ_text" style="margin-right:1%;width: 49%;float: left;resize:none;"></textarea>
						<br> 
						<div class="btn-group"> 
							<input class="btn btn-default" type="submit" name="save" value="Сохранить">
							<input class="btn btn-warning" type="submit" name="delete" value="Удалить">
						</div>
					</form>		 				
				</ul>
				<!-- <h1>Добавление заданий</h1><hr>
				<ul class="nav nav-pills nav-stacked">

					<form name="read_form" method="post">
						<textarea name="task_text2" class="well well-lg" <?textareastyle()?>></textarea>
						<textarea name="answ_text2" class="well well-lg" <?textareastyle()?>></textarea>
						<select class="form-control" name="db" multiple>
							<option disabled>Выберите номер бд</option>
							<option value="1">1</option></option>
							<option value="2">2</option></option>
							<option value="2">3</option></option>
						</select>
						<br>
						<input type="submit" class="btn btn-default" name="save2" value="Добавить">
					</form>
					<br>
				</ul> -->
			</div>
		</div>
	</div>

	<?printfooter();?> 

	<script src="js/adminpanel.js"></script>
</body>
</html>