<?
/*
$host = "localhost";

$dbase_r = "srv72360_prov"; # БАЗА ТОЛЬКО НА ЧТЕНИЕ
$user_r = "srv72360_user"; # ТАБЛИЦЫ laptop, pc, printer, product
$password_r = "sqluser";

$dbase_rw = "srv72360_sqlex"; # БАЗА С ПОЛНЫМ ДОСТУПОМ
$user_rw = "srv72360_root"; # ТАБЛИЦЫ answers, qer, tasks, users
$password_rw = "123456";

$dbase_edt = "srv72360_editdb"; # БАЗА С ПОЛНЫМ ДОСТУПОМ
$user_edt = "srv72360_root"; #
$password_edt = "123456";

$dbcon_r = new mysqli($host, $user_r, $password_r, $dbase_r);
$dbcon_rw = new mysqli($host, $user_rw, $password_rw, $dbase_rw);
$dbcon_edt = new mysqli($host, $user_edt, $password_edt, $dbase_edt);

$dbcon_r->set_charset('utf8');
$dbcon_rw->set_charset('utf8');
$dbcon_edt->set_charset('utf8');

if (!$dbcon_r OR !$dbcon_rw OR !$dbcon_edt){
	echo "Ошибка: Невозможно установить соединение с MySQL.".'<br>';
	echo "<p>Произошла ошибка при подсоединении к MySQL!</p>";
	exit;
}
 error_reporting(0);
 session_start();

	//header("Content-type: text/plain; charset=windows-1251");
	header("Cache-Control: no-store, no-cache, must-revalidate");
	header("Cache-Control: post-check=0, pre-check=0", false);

	function my_array($con, $q, $key, $value){
		$array = array();
		$querys = $con->query($q);
		$r = $querys->num_rows;
		if ($r > 0){
			while ($l = $querys->fetch_array()){
				$ans = $l["$value"]; # указываются в опострофах
				$i = $l["$key"];
				$array[$i] = $ans;
			}
		}
		return $array;
	}

	# ВЫБОРКА ИЗ БД И ЗАПИСЬ В АССОЦИАТИВНЫЙ МАССИВ 'ЛОГИН'->'КОЛ-ВО РЕШЕННЫХ ЗАДАНИЙ'
	$q = "SELECT login,score FROM users WHERE dostup<>'admin' ORDER BY score DESC;";
	$sarr = my_array($dbcon_rw,$q,'login','score');

	$q = "SELECT login,name FROM users WHERE dostup<>'admin' ORDER BY score DESC;";
	$name = my_array($dbcon_rw,$q,'login','name');

	$q = "SELECT login,family FROM users WHERE dostup<>'admin' ORDER BY score DESC;";
	$family = my_array($dbcon_rw,$q,'login','family');

	$q = "SELECT login,avatar FROM users WHERE dostup<>'admin' ORDER BY score DESC;";
	$avatars = my_array($dbcon_rw,$q,'login','avatar');	

	$result = $dbcon_rw->query("SELECT * FROM users WHERE login='".$_SESSION['login']."';");
	$scores = $result->fetch_array();

	$result = $dbcon_rw->query("select count(*) from users where score>".$scores['score'].";");
	$pos = $result->fetch_array();	

	echo '<div class="panel panel-default">';
		echo '<a href="lk.php"><div class="score_avatar" style="background-image: url(img/';
		echo $_SESSION['avatar'];
		echo ')"></div></a>';
		echo '<div><span>Результат:<span>';
		echo $scores['score'];
		echo '</span></span><span>Рейтинг:<span>';
		echo $pos[0]+1;
		echo '</span></span></div></div><div class="panel panel-default">';
		echo '<div class="score-heading">Текущий рейтинг</div><div class="panel panel-default" id="score"><div class="score_list">';
				$i = 1;
				foreach ($sarr as $key => $value){	
					echo '<div class="score_panel"><div style="background-image: url(img/';
					echo $avatars[$key];
					echo ')" title="';
					echo $name[$key];
					echo ' ';
					echo $family[$key];
					echo '"></div>';
					echo '<div style="width:50px; overflow: hidden;" title="';
					echo $key;
					echo '">'.substr($key,0,7).'</div><div title="'.$i.' место">'.$value.'</div></div>';
				$i++;
				}
			echo '</div></div></div>';*/
?>