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
		<div class="container p-0 _curr_tab-wrap">	

			<ul class="nav nav-pills curr_tabs">
				<li class="_curr_tab-link"><a href="#manage_tasks" class="active">Задания</a></li>
				<li class="_curr_tab-link"><a href="#manage_users">Пользователи</a></li>
			</ul>

			<div class="tab-content row _curr_tab_one col-12 active" id="manage_tasks">
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
				<div class="panel panel-default col-12 create_task-wrap _show_task_create_wrap">
					<span class="btn btn-primary show-btn _show_task_create_form">Добавить задание</span>
					<form name="create_task" method="post" class="create_task-form">
						<div class="col-12 row p-0">
							<div class="col-md-4 col-12 db_radio-wrap" id="dblist"></div>
							<div class="col-md-8 col-12 p-0">
								<div class="col-12 p-0">
									<label>Текст задания</label>
									<textarea name="task_text" class="well well-lg scrollbar _create_task _create_task_text" id="task_text" required></textarea>
								</div>
								<div class="col-12 p-0">
									<label>Текст запроса</label>
									<textarea name="answ_text" class="well well-lg scrollbar _create_task _create_task_answ" id="answ_text" required></textarea>
								</div>
								<div class="btn-group create_task_btns-wrap"> 
									<input class="btn btn-default _ajax_btn" type="submit" name="save" value="Сохранить" data-action="createTask">
								</div>
							</div>
						</div>
					</form>		 				
				</div>
				<div class="panel panel-default col-12 create_task-wrap _show_task_create_wrap">
					<span class="btn btn-primary show-btn _show_task_create_form">Добавить базу данных</span>
					<form name="create_task" method="post" class="create_task-form">
						<div class="col-12 row">							
							<div class="col-12">
								<div class="col-12 p-0">
									<label>Название базы данных</label>
									<textarea name="db_name" class="well well-lg scrollbar _create_task _create_task_text" id="task_text" required></textarea>
								</div>
								<div class="col-12 p-0">
									<label>Описание базы данных</label>
									<textarea name="db_info" class="well well-lg scrollbar _create_task _create_task_answ" id="answ_text" required></textarea>
								</div>
								<div class="btn-group create_task_btns-wrap"> 
									<input class="btn btn-default _ajax_btn" type="submit" name="save" value="Сохранить" data-action="createDb">
								</div>
							</div>
						</div>
					</form>	
				</div>
			</div>

			<div class="tab-content row _curr_tab_one col-12" id="manage_users">
				<div class="col-2">
					<select name="group" id="groupslist" class="_users_groups"></select>
				</div>
				<div class="col-10">
					<div id="userslist" class="panel panel-default"></div>
				</div>
			</div>
		</div>
	</div> 
</main>

<?printfooter();?> 
<script src="js/adminpanel.js"></script>
<script src="js/jquery.DataTables.min.js"></script>

</body>
</html>