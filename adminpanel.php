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
			<div class="tab-content row" style="padding-top: 15px;">
				<div class="col-md-6 col-sm-12 col-xs-12" style="padding-left: 0;">
					<div id="all_tasks_table" class="panel panel-default scrollbar all_tasks_table"></div>
				</div>
				<div class="panel panel-default col-md-6 col-sm-12 col-xs-12 edit_task-wrap" id="tasks">
					<h3 class="panel-heading">Редактирование заданий</h3>
					
					<form name="edit_task" method="post" class="edit_task-form">
						<input type="hidden" name="task_id" class="_edit_task_id" value="">
						<div class="col-12 p-0">
							<textarea readonly name="task_text" class="well well-lg scrollbar _edit_task _edit_task_text" id="task_text"></textarea>
						</div>
						<div class="col-12 p-0">
							<textarea readonly name="answ_text" class="well well-lg scrollbar _edit_task _edit_task_answ" id="answ_text"></textarea>
						</div>
						<div class="btn-group edit_task_btns-wrap"> 
							<input class="btn btn-default _edit_task_btns _save_task_btn _ajax_btn" type="submit" name="save" value="Сохранить" data-action="saveTask" disabled>
							<input class="btn btn-info _edit_task_btns _edit_task_btn" type="submit" name="edit" value="Изменить" disabled>
							<input class="btn btn-warning _edit_task_btns _remove_task_btn _ajax_btn" type="submit" name="delete" value="Удалить" data-action="removeTask" disabled>
						</div>
					</form>		 
				</div>
				<br clear="all">
				<div id="ajaxresp" class="manager_resp m-4"></div>
				<div class="panel panel-default col-12 create_task-wrap">
					<span class="btn btn-primary show-btn _show_task_create_form">Добавить задание</span>
					<form name="create_task" method="post" class="create_task-form">
						<div class="col-12 row p-0">
							<!-- <input type="hidden" name="db" class="_create_task_db" value=""> -->
							<div class="col-md-4 col-12">							
								<label for="db-1">
									<input type="radio" name="db" value="1" id="db-1" class="_create_task_radio" required>База данный 1
								</label>					
								<label for="db-2">
									<input type="radio" name="db" value="2" id="db-2" class="_create_task_radio" required>База данный 2
								</label>
							</div>
							<div class="col-md-8 col-12 p-0">
								<div class="col-12 p-0">
									<textarea name="task_text" class="well well-lg scrollbar _create_task _create_task_text" id="task_text" required></textarea>
								</div>
								<div class="col-12 p-0">
									<textarea name="answ_text" class="well well-lg scrollbar _create_task _create_task_answ" id="answ_text" required></textarea>
								</div>
								<div class="btn-group create_task_btns-wrap"> 
									<input class="btn btn-default _ajax_btn" type="submit" name="save" value="Сохранить" data-action="createTask">
								</div>
							</div>
						</div>
					</form>		 				
				
				</div>
			</div>
		</div>
	</div>
</main>

<?printfooter();?> 
<script src="js/adminpanel.js"></script>
</body>
</html>