<?

require_once("autoload.php");

$user = new User();
$auth = $user->isAuth();

$sqlex = new SqlEx();
$tasks = $sqlex->getTasks();

printhead(); ?>

<body class="wrapper">
<? printheader($auth); ?>
	<main class="d-flex flex-column justify-content-between">
		<div class="middle p-4"></div>

		<div class="tasks">
			<div class="container d-flex flex-wrap p-0">	

				<div class="col-md-2 col-sm-12 col-xs-12 p-0" id="scoreTable">
					<div class="panel panel-default col-md-12 col-md-offset-0 col-sm-4 col-sm-offset-2 col-xs-6 p-0" id="userinfo">
						<a href="lk.php">
							<div class="score_avatar"></div>
						</a>
						<div class="rating_info p-3">
							<span>Результат: <span id="tscore"></span> </span>
							<span>Рейтинг: <span id="trating"></span> </span>
						</div>
					</div>
					<div class="score_wrap panel panel-default col-md-12 col-md-offset-0 col-sm-3 col-sm-offset-1 col-xs-6 p-3">
						<div class="rating_info score-heading">Текущий рейтинг</div>
						<div class="panel panel-default" id="score">
							<div class="score_list" id="score_list"></div>
						</div>
					</div>
				</div>

				<div class="col-md-5 col-sm-6 col-xs-12">
					<div class="panel panel-default p-4">
						<div class="panel-heading p-0">
							Описание базы данных
						</div>
						<div class="panel-body db_info p-0" id="db_info"></div>
					</div>
				</div>
				<div class="col-md-5 col-sm-6 col-xs-12 p-0">
					<div  class="panel panel-default p-4">			

						<!-- создание combobox для выбора заданий -->
						<form class="input-group" name="sql_form" action="" method="get">
							<!-- <select name="option" class="form-control task_num" style="width: 100px;" onchange="getTask();"> -->
							<select name="option" class="form-control task_num" id="task_select">
									<option value="" disabled>№</option>
							</select>

							
							<div class="select_number p-2">Выбeрите номер задания</div>
						</form>
						
						<div class="alert task_text" style="margin-bottom: 0px;" id="task_text"></div>
						
						<!--создание формы ввода запроса -->
						<form class="textarea">
							<input type="hidden" name="query" value=\'\'>
							<textarea  name="uquery" class="well well-lg sql p-3" id="sqltext" oncopy="return false;" onpaste="return false;"></textarea>
							<input type="button" class="btn btn-default navbar-btn runquery" id="btntext1" data-result="#results_wrapper" name="userquery" value="Выполнить" disabled>
						</form>
						
						<!-- создание кнопки показа правильного ответа -->
						<form name="form_btn_true" action="" method="post">
							<input type="button" class="btn btn-info navbar-btn runquery" id="btntext2" data-result="#truetable" name="viewtable" value="Показать правильный результат" disabled> 
						</form> 

					</div>	
				</div>	
			</div>
		</div>


		<div class="results">
			<div class="container p-4">	
			<div class="title">Результаты выполнения</div><!-- 
				<div class="alert" style="text-align:center;"> -->
				<div id="alert_result" class="alert" style="display: none; text-align: center;"></div>
				<div class="results_wrapper">
					<div id="results_wrapper" style="display: none;">						
						<div class="panel panel-default">
							<span>Результат выполнения запроса:</span>
							<table class="table table-hover">
								<thead></thead>
								<tbody></tbody>
							</table>
						</div>
					</div>
					<div id="truetable" class="" style="display: none;">
						<div class="panel panel-default">
							<span>Правильная таблица:</span>
							<table class="table table-hover">
								<thead></thead>
								<tbody></tbody>
							</table>
						</div>
					</div>	
				</div>
			</div>	<!--container-->
		</main>
		<?printfooter();?> 
	<script src="js/sqlex.js"></script>
	<script>
		
	

		

		function results(){
			console.log($('.well.well-lg.sql').val());
			$.ajax({
	            url: 'actions/answerTable.php',
	            data: {
	            	type: 'alert',
	            	submit: true,
	            	sql: $('.well.well-lg.sql').val()
	            },
	            type: 'POST',
	            success: function(data){
	               // console.log(data);
	                $('#alert_result').html(data);
	                truetable();
	            },
	            error: function(){
	                console.log('error resultss');
	            },
	        });
	        $.ajax({
	            url: 'actions/answerTable.php',
	            data: {
	            	type: 'table',
	            	submit: true,
	            	sql: $('.well.well-lg.sql').val()
	            },
	            type: 'POST',
	            success: function(data){
	                //console.log(data);
	                $('#results_wrapper').html(data);
	                setTask();
	                scoreTable();
	            },
	            error: function(){
	                console.log('error resultss');
	            },
	        });
	        truetable();
		}
	</script>

</body>

</html>
