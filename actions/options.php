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
	# ВЫБОРКА ИЗ БД НОМЕРОВ РЕШЕННЫХ ЗАДАНИЙ
	$arr = array();
	$result = $dbcon_rw->query("SELECT num FROM answers WHERE ".$login."<>'false';");
	$r = $result->num_rows;
	if ($r > 0) {
		while ($l = $result->fetch_array()){
			$old = $l['num'];
			$arr[] = $old;
			}
		}
	# ПОДСЧЕТ И ЗАПИСЬ В БД КОЛИЧЕСТВА РЕШЕННЫХ ЗАДАНИЙ 
	$userscore = count($arr);
	$answ = $dbcon_rw->query("update users set score = ".$userscore." where login = '".$login."';");	

echo '<option';

if(!isset($_SESSION['option'])){ 
	echo ' selected'; 
} 

echo ' disabled>№</option>';

$result = $dbcon_rw->query("SELECT id FROM tasks");
$task_col = $result->num_rows; 
for($t=1;$t<=$task_col;$t++){
	echo '<option ';
 	if($_SESSION["option"]==$t){
		echo ' selected';
	} 
	echo " value=\"$t\"";
	echo '>';
 	echo $t;
	for($i=0;$i<count($arr);$i++){
		if($arr[$i]==$t){
			echo ' -> Ok';
		}
	}
	echo '</option>';
}	?>