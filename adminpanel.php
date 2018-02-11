<?php

require_once("autoload.php");

$user = new User();
$auth = $user->isAuth();

printhead();  ?>

<main>
	<div class="middle p-4"></div>
	<div class="tasks">	
		<div class="container">	

	
	<?				if(isset($_POST["save"])){
						$ge = $_SESSION["ge"];
						$str = $_POST["task_text"];
						$answ = mb_strtolower(stripslashes($_POST["answ_text"]), 'UTF-8'); 
						$_SESSION["task_text"] = $str;
						$_SESSION["answ_text"] = $answ;
						$result1 = $dbcon_rw->query("update tasks set task = '".$str."' where id = '".$ge."';");
						$result2 = $dbcon_rw->query("update qer set qer = '".$answ."' where id = '".$ge."';");
						echo "<font color=\"green\">Текст задания успешно изменён</font><br>";
						}				

					if(isset($_POST["delete"])){
						$ge = $_SESSION["ge"];
						$result = $dbcon_rw->query("DELETE FROM qer WHERE id = '".$ge."';");
						$result = $dbcon_rw->query("DELETE FROM tasks WHERE id = '".$ge."';");
						$result = $dbcon_rw->query("DELETE FROM answers WHERE num = '".$ge."';");
						$_SESSION["task_text"] = '';
						$_SESSION["answ_text"] = '';
						# ЕСЛИ УДАЛЕНО НЕ ПОСЛЕДНЕЕ ЗАДАНИЕ, "ПОДОДВИГАЕМ" ВСЕ СЛЕДУЮЩИЕ ЗАДАНИЯ ВВЕРХ
						if($ge != $maxid-1){ 
							for($i=$ge+1;$i<$maxid;$i++){ 	# ЧТОБЫ НУМЕРАЦИЯ ЗАДАНИЙ НЕ НАРУШАЛАСЬ
								$l=$i-1;					# ЗНАЮ, ЧТО КРИВО, НО ЧТО ПОДЕЛАТЬ
								$result = $dbcon_rw->query("update qer set id = '".$l."' where id = '".$i."';");
								$result = $dbcon_rw->query("update tasks set id = '".$l."' where id = '".$i."';");
								$result = $dbcon_rw->query("update answers set num = '".$l."' where num = '".$i."';");
							}
						}
						$maxid = $maxid -1;
					}	

					if(isset($_POST["save2"])){
						$ge = $_SESSION["ge"];
						$str = $_POST["task_text2"];
						if(isset($_POST["db"])){
							$db = $_POST["db"];
						}else{
							$db = 1;
						}
						$answ2 = mb_strtolower(stripslashes($_POST["answ_text2"]), 'UTF-8'); 
						$_SESSION["task_text2"] = $str;
						$_SESSION["answ_text2"] = $answ2;
						$_SESSION["db_text2"] = $_POST["db"];
						$result1 = $dbcon_rw->query("INSERT INTO tasks(id,task,db) VALUES ('".$maxid."','".$str."','".$db."');");
						$result2 = $dbcon_rw->query("INSERT INTO qer(id,qer) VALUES ('".$maxid."','".$answ2."');");
						$result1 = $dbcon_rw->query("INSERT INTO answers(num) VALUES ('".$maxid."');");
						$maxid = $maxid+1; 
						$_SESSION["maxid"] = $maxid;
					}
					# СОЗДАЕМ АССОЦИАТИВНЫЙ МАССИВ ЗАДАНИЙ 'НОМЕР' -> 'ТЕКСТ'
					$q = "SELECT id,task FROM tasks;";
					$tasks = my_array($dbcon_rw,$q, 'id', 'task');
					# СОЗДАЕМ АССОЦИАТИВНЫЙ МАССИВ ОТВЕТОВ 'НОМЕР' -> 'ТЕКСТ'
					$q = "SELECT id,qer FROM qer;";
					$answers = my_array($dbcon_rw,$q, 'id', 'qer');
				
				?>

		<ul class="nav nav-pills">
			<li class="" style="border-radius: 5px;"><a href="#" style="color: white;">Задания</a></li>
			<li class=""><a href="users.php" style="color:black;">Пользователи</a></li>
		</ul>
		<div class="tab-content" style="padding-top: 15px;">
		<div class="panel-default" id="tasks">
			<h1>Изменение заданий</h1><hr>
			<ul class="nav nav-pills nav-stacked">
				<!-- создание combobox для выбора заданий -->
				<form class="input-group" name="sql_form" action="" method="get">
					<select name="option" class="form-control task_num" style="width: 100px;" onchange="getTask();"></select>
					<script>
						function setTask(){
							$.ajax({
					            url: 'actions/options.php',
					            data: { },
					            type: 'POST',
					            success: function(data){
					                //console.log(data);
					                $('.form-control.task_num').html(data);
					            },
					            error: function(){
					                console.log('error option');
					            },
					        });
						}
						setTask();
						function getTask(){
							//console.log($('select.form-control.task_num').val());
					        $('#alert_result').empty();
					        $('#results_wrapper').empty();
					        $('#truetable').empty();
					        $('#sqltext').val('');
							$.ajax({
					            url: 'actions/taskinfo.php',
					            data: {
					            	go: 'task',
					            	num: $('select.form-control.task_num').val()
					            },
					            type: 'POST',
					            success: function(data){
					                console.log(data);
					                //$('#task_text').html(data);
					            },
					            error: function(){
					                console.log('error task');
					            },
					        });
							$.ajax({
					            url: 'actions/taskinfo.php',
					            data: {
					            	go: 'qer',
					            	num: $('select.form-control.task_num').val()
					            },
					            type: 'POST',
					            success: function(data){
					                //console.log(data);
					                $('#db_info').html(data);
					            },
					            error: function(){
					                console.log('error qer');
					            },
					        });
						}
					</script>
					<div class="select_number">Выбeрите номер задания</div>
				</form>
			
				<br clear="all">	  
				<br> 
				<form name="read_form" method="post">
					<textarea readonly name="task_text" class="well well-lg" id="task_text" style="margin-right:1%;width: 49%;float: left;resize:none;"></textarea>
					<textarea readonly name="answ_text" class="well well-lg" id="answ_text" style="margin-right:1%;width: 49%;float: left;resize:none;"></textarea>
					<br> 
					<div class="btn-group">
						<input class="btn btn-default" type="submit" name="modify" value="Изменить"> 
						<input class="btn btn-default" type="submit" name="save" value="Сохранить">
						<input class="btn btn-warning" type="submit" name="delete" value="Удалить">
					</div>
				</form>		 				
			</ul>
			<h1>Добавление заданий</h1><hr>
			<ul class="nav nav-pills nav-stacked">
<?php			# ВЫВОД ТЕКСТА ЗАДАНИЯ
				$_SESSION["task_text2"] = $task_text2;	
				$_SESSION["answ_text2"] = $answ_text2;			?>
				<form name="read_form" method="post">
<?					if(isset($_POST["save2"])){
					
					echo "Номер задания: ".$maxid; ?>
<?					echo "<font color=\"green\"><br>Задание успешно добавлено</font><br>";
					}else{
						echo"Номер задания: ".$maxid;
					}?>		<br>
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
			</ul>
		</div>
	</div>
</div>
<?printfooter();
	
	?>
</body>
</html>