<?
//dbconnect
$host = "localhost";

$dbase_r = "srv72360_prov"; # БАЗА ТОЛЬКО НА ЧТЕНИЕ
$user_r = "srv72360_user"; # ТАБЛИЦЫ laptop, pc, printer, product
$password_r = "sqluser";

$dbase_rw = "srv72360_sqlex"; # БАЗА С ПОЛНЫМ ДОСТУПОМ
$user_rw = "srv72360_root"; # ТАБЛИЦЫ answers, qer, tasks, users
$password_rw = "123456";

$dbcon_r = new mysqli($host, $user_r, $password_r, $dbase_r);
$dbcon_r->set_charset('utf8');

$dbcon_rw = new mysqli($host, $user_rw, $password_rw, $dbase_rw);
$dbcon_rw->set_charset('utf8');

if (!$dbcon_r OR !$dbcon_rw){
	echo "Ошибка: Невозможно установить соединение с MySQL.".'<br>';
	echo "<p>Произошла ошибка при подсоединении к MySQL!</p>";
	exit;
}

	error_reporting(0);
	session_start();

	header("Cache-Control: no-store, no-cache, must-revalidate");
	header("Cache-Control: post-check=0, pre-check=0", false);


$login = $_SESSION['login'];

function fetchtable($q,$count,$name){
	echo '<div class="panel panel-default"><span>Полученная таблица:</span><table class="table table-hover">';
			while($line = $q->fetch_array(MYSQLI_ASSOC)){ # преобразование запроса пользователя в массив
				if ($i != true){
					for($a = 0; $a<$count; $a++){
						echo '<td style="font-weight: bold;">'.$name[$a].'</td>';
					}
					$i=true;
				}								
				echo "<tr>";
				foreach ($line as $col_value){										 
					echo "<td>".substr($col_value,0,15)."</td>";
				}
				echo "</tr>";
			}
		echo '</table> 
	</div>';
}

function mysqli_field_name($res, $field_offset){
	$properties = mysqli_fetch_field_direct($res, $field_offset);
	return is_object($properties) ? $properties->name : null;
}


	$result = $dbcon_rw -> query("SELECT id,qer FROM qer WHERE id = '".$_SESSION["option"]."';");
	$answer = $result -> fetch_array();


	#забор содержимого формы для ввода запроса и преобразование в понятный для SQL интерпретатора формат
	if(isset($_POST["submit"]) AND isset($_SESSION["option"])){
		$str = mb_strtolower(stripslashes($_POST["sql"]), 'UTF-8'); #добавил перевод в регистр
		$title = ($_POST["sql"]); //**		
		$qer = $dbcon_r->query($str); # построение запроса пользователя для вывода на экран
		$qer2 = $dbcon_r->query($answer['qer']); # построение оригинального запроса на основе выбранного option
		$qer3= $dbcon_r->query($str); # построение запроса пользователя для	проверки на верность			
		if (!$qer){
			if($_POST['type'] == 'alert'){
				echo '<div class="alert alert-danger">Некорректный запрос: '.$dbcon_r->error.'</div></div></div></main>';
			}
			exit;
		}else{				
			$count = $qer->field_count;	# определяем количество столбцов запроса пользователя	
			$pline = $qer2->fetch_array(); 				//*
			$sline = $qer3->fetch_array(); 
			$buf1 = $qer2->num_rows; # определяем количество строк в выборке
			$buf2 = $qer3->num_rows; # определяем количество строк в выборке пользователя
			if($buf1 == $buf2){
				foreach($sline as $col_value){
					if ($sline == $pline){
						$e = true;
					}else{
						$e=false;
					}
				}
			}else{
				$e = false;
			} 
		}
						# ПОВТОРНАЯ ПРОВЕРКА
		if($e==true){
			
			$qer = $dbcon_rw->query($str); # построение запроса пользователя для вывода на экран
			$qer2 = $dbcon_rw->query($answer['qer']); # построение оригинального запроса на основе выбранного option
			$qer3= $dbcon_rw->query($str); # построение запроса пользователя для	проверки на верность	
		
			$count = $qer->field_count;	# определяем количество столбцов запроса пользователя	
			$pline = $qer2->fetch_array(); 				//*
			$sline = $qer3->fetch_array(); 
			$buf1 = $qer2->num_rows; # определяем количество строк в выборке
			$buf2 = $qer3->num_rows; # определяем количество строк в выборке пользователя
			if($buf1 == $buf2){
				foreach($sline as $col_value){
					if ($sline == $pline){
						$e2 = true;
					}else{
						$e2 = false;
					}
				}
			}else{
				$e2 = false;
			} 
		}
		
		if($_POST['type'] == 'alert'){
			//echo '<div class="alert" style="text-align:center;">';
			if ($e2 == true){	# ПРОВЕРКА НА ВЕРНОСТЬ					 		
				$answ = $dbcon_rw->query("update answers set ".$login." = '".$str."' where num = ".$_SESSION["option"].";");
				echo '<div class="alert alert-success">Запрос верный!</div>';	
			}elseif($e==true){
				echo '<div class="alert alert-warning">Запрос не точный!</div>';
			}
			else{
				echo '<div class="alert alert-danger">Запрос не верный!</div>';
			}
		}else{
			//echo '</div>';
			//echo '<div class="results_wrapper"><div>';
				$qer = $dbcon_r->query($str); 
				if ($qer){ # ЕСЛИ ЗАПРОС ПОЛЬЗОВАТЕЛЯ КОРРЕКТЕН
					for($i = 0; $i<$count; $i++){
						$fname[$i] = mysqli_field_name($qer,$i);
					}
					fetchtable($qer,$count,$fname);
				}
				//echo '<div class="" id="#trueresult"></div>';
			//echo '</div>';
			//echo '<div class="col-sm-5" id="truetable"></div></div>';
		}
} 
?>
