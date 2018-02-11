<?php
class Connection {

    function __construct() {
      	
      	require("config.php");

		$dbcon_r = new mysqli($host, $user_r, $password_r, $dbase_r);
		$dbcon_rw = new mysqli($host, $user_rw, $password_rw, $dbase_rw);
		$dbcon_edt = new mysqli($host, $user_edt, $password_edt, $dbase_edt);
		
		$dbcon_r->set_charset('utf8');
		$dbcon_rw->set_charset('utf8');
		$dbcon_edt->set_charset('utf8');

		if (!$dbcon_r || !$dbcon_rw || !$dbcon_edt){
			echo "Ошибка: Невозможно установить соединение с MySQL.".'<br>';
			echo "<p>Произошла ошибка при подсоединении к MySQL!</p>";
			exit;
		}else{
			$this->dbcon_r = $dbcon_r;
			$this->dbcon_rw = $dbcon_rw;
			$this->dbcon_edt = $dbcon_edt;
			session_start();
		}
	}
}
?>