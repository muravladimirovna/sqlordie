<?/*
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

	$num = $_POST['num'];

	$result = $dbcon_rw -> query("SELECT id,qer FROM qer WHERE id = '".$num."';");
	$answer = $result -> fetch_array();

	function mysqli_field_name($res, $field_offset){
		$properties = mysqli_fetch_field_direct($res, $field_offset);
		return is_object($properties) ? $properties->name : null;
	}

	$qer = $dbcon_r->query($answer['qer']);
	echo '<div class="panel panel-default"><span>Правильная таблица:</span><table class="table table-hover">';
	 $count = $qer->field_count;
	 while ( $prov = $qer -> fetch_array(MYSQLI_ASSOC) ){	
	 	if ($bi != true){
	 		for($b = 0; $b<$count; $b++){
	 			echo '<td style="font-weight: bold;">';
	 			echo mysqli_field_name($qer,$b);
	 			echo '</td>'; //генерация правильной таблицы задания
	 		}
	 		$bi = true;
	 	}										
		echo "<tr>";
		foreach ($prov as $col_value){
		echo "<td>$col_value</td>";
		}
		echo '</tr>';
	}
	echo '</table></div>';*/
?>