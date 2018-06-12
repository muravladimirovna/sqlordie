<?php
class User {

    function __construct() {
      	
      	require("config.php");
      	require_once("class.connection.php");

      	$this->db = new Connection();
      	$this->manager_email = $manager_email;
      	$this->manager_password = $manager_password;
      	$this->manager_email_to = $manager_email_to;
      	$this->secret_key = $secret_key;
		$this->mailSMTP = new SendMailSmtpClass($this->manager_email, $this->manager_password, 'ssl://smtp.yandex.ru', 465, "utf-8");

      	if(isset($_SESSION['user']) and !empty($_SESSION['user'])){
      		foreach ($_SESSION['user'] as $key => $value) {
      			$this->$key = $value;
      		}
      	}

	}


	function Authorize($data){

		if(isset($data) and !empty($data)){

			 header("Content-type: text/plain; charset=windows-1251");
			 header("Cache-Control: no-store, no-cache, must-revalidate");
			 header("Cache-Control: post-check=0, pre-check=0", false);

			if(isset($data["login"]) and !empty($data["login"])){
				$login = $data["login"]; 
			} 
			if(isset( $data["password"]) and !empty( $data["password"])){
				$password = $data["password"]; 
			}
			if(!isset($login) || !isset($password)){
				return "<font color=\"red\">Не все поля заполнены</font>"; 
			}
			//если логин и пароль введены,то обрабатываем их, чтобы теги и скрипты не работали, мало ли что люди могут ввести
			$login = stripslashes($login);
			$login = htmlspecialchars($login);
			$password = stripslashes($password);
			$password = htmlspecialchars($password);
			//удаляем лишние пробелы
			$login = trim($login);
			$password = trim($password);
			//извлекаем из базы все данные о пользователе с введенным логином
			$q = "SELECT users.id, users.name, users.lastname, users.login, users.password, users.avatar, users.score, users_groups.group_id, groups.name as 'group', users_roles.role_id as 'role' FROM (((users INNER JOIN users_groups ON users.id = users_groups.user_id) INNER JOIN groups ON groups.id = users_groups.group_id) INNER JOIN users_roles ON users.id = users_roles.user_id)  WHERE users.login='".$login."' ;";
			$result = $this->db->dbcon_rw->query($q);
			if(!$result) return false;
			$myrow = $result->fetch_array(MYSQLI_ASSOC);
			if (empty($myrow["password"])){	//если пользователя с введенным логином не существует
				$_SESSION['dostup'] = false; 
				return false;
			}else{
				if($myrow["password"] == $password){
					unset($_SESSION['user']);
					foreach($myrow as $key=>$value){
						$_SESSION['user'][$key] = $value;
						$this->$key = $value;
					}
					return json_encode($_SESSION['user']);
				}else{	//если пароли не сошлись
					unset($_SESSION['user']);
					return false;
					exit();
				}
			}	
		}
	}

	function isAuth(){
		if (isset($_SESSION['user']['login']) and isset($_SESSION['user']['id'])){
			if(empty($_SESSION['user']['login']) || empty($_SESSION['user']['id'])){
				header('Location: ../login.php'); // Если пусты, то выводим форму входа
			}else{
				$result = $this->db->dbcon_rw->query("UPDATE users SET score = (SELECT COUNT(num) FROM answers WHERE " . $_SESSION['user']['login'] . " <> '') WHERE login = '" . $_SESSION['user']['login'] . "' ;");
				if(!$result) return false;
				$result = $this->db->dbcon_rw->query("SELECT id, score FROM users WHERE id = '" . $_SESSION['user']['id'] . "' ;");
				if(!$result) return false;
				$myrow = $result->fetch_array(MYSQLI_ASSOC);
				if(isset($myrow['score']) and !empty($myrow['score'])){
					$_SESSION['user']['score'] = $myrow['score'];
				}
				$result = $this->db->dbcon_rw->query("select count(*) as count from users where score >" . $_SESSION['user']['score'] . ";");
				if(!$result) return false;
				$pos = $result->fetch_array(MYSQLI_ASSOC);
				if(isset($pos['count']) and !empty($pos['count'])){
					$_SESSION['user']['position'] = $pos['count'];
				}
				return json_encode($_SESSION['user']);
			}
		}else{
			header('Location: ../login.php');
		}
	}

	function downloadImg($file){
		if(isset($file) and !empty($file)){
			$q = "UPDATE users SET avatar = '".$file['name']."' WHERE login='".$this->login."';";
			$uploadfile = "img/".basename($file['name']); 
			$result = move_uploaded_file($file["tmp_name"], $uploadfile);
			// хрен его знает, что не так
			if($result){
				$res = $this->db->dbcon_rw->query($q);
				if($res){
					echo "<font color=\"green\">Файл упешно загружен</font>";
					unlink($_SESSION["filename"]);
					$_SESSION["filename"] = $uploadfile;
					$_SESSION['user']['avatar'] = $file['name'];
				}elseif(isset($_POST["download"])){
						echo "<font color=\"yellow\">Путь не добавлен в базу данных, но файл загружен</font>";
				}
			}elseif(isset($_POST["uploadfile"])) {
				echo "<font color=\"red\">Файл не загружен,максимальный размер файла 2 мб</font>";
			}
			echo "<br>";
		}
	}

	function removeUser($id = ""){
		$id = !empty($id) ? $id : $_SESSION['user']['id'];
		$result = $this->db->dbcon_rw->query("DELETE FROM users WHERE id = '".$id."';");
		$result = $result ? $this->db->dbcon_rw->query("ALTER TABLE answers DROP ".$login.";") : $result;
		if($result){
			if ($id == $_SESSION['user']['id']) {
				unset($_SESSION['user']);
				session_destroy();
				header("Location: ../login.php");
			}
			return $id;
		}
		
	}

	function changePassword($data, $id = ""){
		$id = !empty($id) ? $id : $_SESSION['user']['id'];
		$old_pass = ($data["old_pass"] and $data["old_pass"] == $_SESSION["user"]["password"]) ? $data["old_pass"] : "";
		$new_pass = ($data["new_pass_1"] and $data["new_pass_2"] and $data["new_pass_1"] == $data["new_pass_2"]) ? $data["new_pass_1"] : "";

		if(!$old_pass) return "<font color='red'>Неправильно указан старый пароль</font>";
		if(!$new_pass) return "<font color='red'>Введенные пароли не совпадают</font>";

		//$new_pass = stripslashes($new_pass);
		//$new_pass = htmlspecialchars($new_pass);

		$result = $this->db->dbcon_rw->query("update users set password = '" . $new_pass . "' where id = '" . $id . "';");
		if($result){
			$_SESSION['user']['password'] = $new_pass;
			return "<font color='green'>Пароль успешно изменён!</font>";
		}else{
			return false;
		}
			
	}

	function unlogin(){
		unset($_SESSION["user"]);
		session_destroy();
		header("Location: ../sqlex.php"); 
	}

	function regUser($data){
		if(isset($data["name"]) and !empty($data["name"]) and isset($data["lastname"]) and !empty($data["lastname"]) and isset($data["login"]) and !empty($data["login"]) and isset($data["password"]) and !empty($data["password"])){

			$name = urldecode($this->db->dbcon_rw->real_escape_string($data["name"]));
			$lastname = urldecode($this->db->dbcon_rw->real_escape_string($data["lastname"]));
			$login = urldecode($this->db->dbcon_rw->real_escape_string($data["login"]));
			$password = urldecode($this->db->dbcon_rw->real_escape_string($data["password"]));
			$email = urldecode($this->db->dbcon_rw->real_escape_string($data["email"]));

			$result_1 = $this->db->dbcon_rw->query("INSERT INTO users (login, password, name, lastname, email, score, avatar) values ('".$login."','".$password."','".$name."','".$lastname."','". $email ."', '0', 'default-user.png');");
			if($result_1){
				/*$result_2 = $this->db->dbcon_rw->query("ALTER TABLE answers ADD ".$login." VARCHAR( 200 ) NOT NULL DEFAULT ''; ");
				if(!$result_2){
					$result_3 = $this->db->dbcon_rw->query("DELETE FROM users WHERE login = '".$login."';");
					return false;
				}*/
				return $this->Authorize($data);
			}else{ 
				return json_encode(array(
					"success" => false,
					"message" => "<font color='red'>Ошибка записи ячейки</font>"
				));
			}
		}else{
			return false;
		}
					
	}

	function getUserAnswers($user_id = false) {
		if(empty($user_id) && empty($_SESSION['user'])) return false;

		$user_id = $user_id ? $user_id : $_SESSION['user']['id'];	

		$answers =  $this->db->dbcon_rw->query("SELECT answers FROM `users` WHERE id = " . $user_id . "; ");
		$user_answers = $answers ? $answers->fetch_array(MYSQLI_ASSOC) : false;
		$user_answers = $user_answers ? unserialize($user_answers["answers"]) : false;
		return $user_answers;
	}

	function sendMail($data) {	
		if (isset($data['g-recaptcha-response'])) {
		    $url_to_google_api = "https://www.google.com/recaptcha/api/siteverify";
		    $query = $url_to_google_api . '?secret=' . $this->secret_key . '&response=' . $data['g-recaptcha-response'] . '&remoteip=' . $_SERVER['REMOTE_ADDR'];
		    $response = json_decode(file_get_contents($query));
		    if ($response->success) {
				$subject = $data['subject'] ? $data['subject'] : "Письмо с сайта sql";
				$message = $data['message'] ? $data['message'] : false;
				if($message) {
					$user_from = !empty($this->name) ? $this->name . ' ' . $this->lastname : "John Doe";			
					$from = [$user_from, $this->manager_email];
					$to = $this->manager_email_to;		
					// $mailSMTP->addFile("test.jpg");
					$result =  $this->mailSMTP->send($to, 'Тема письма', 'Текст письма', $from); 		
					if($result === true) echo '<div class="alert alert-success">Письмо успешно отпралено</div>';
					else echo '<div class="alert alert-danger">Не удалось отправить письмо: ' . $result . '</div>';
				} else echo '<div class="alert alert-danger">Не удалось отправить письмо</div>';
				
		    } else {
		        echo '<div class="alert alert-danger">Извините но похоже вы робот ¯\(0_0)/¯</div>';
		    }
		} else {
		    echo '<div class="alert alert-danger"Вы не прошли валидацию reCaptcha</div>';
		}
	}


} ?>