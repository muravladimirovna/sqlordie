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
		<div class="container p-0 _curr_tab-wrap row">	
			<div id="contactform" class="col-md-6 col-12 d-flex justify-content-center">
				<form action="" class="contactus">	
					<div class="col-12 input-group">
						<div class="ajaxresp"></div>
					</div>		
					<div class="col-12 input-group">
						<label>Тема</label>
						<input type="text" name="subject" value="">
					</div>
					<div class="col-12 input-group">
						<label>Сообщение</label>
						<textarea name="message"></textarea>
					</div>
					<div class="col-12 input-group">
						<div class="g-recaptcha" data-sitekey="6LcUll4UAAAAALSq8rZSQDEObVNId_TsvzhmhjJJ"></div>
					</div>
					<div class="col-12 input-group">
						<input type="submit" class="btn btn-success _ajax_btn" data-action="sendMail" value="Сохранить">
					</div>
				</form>
			</div>
			<div class="col-md-6 col-12">
				<p>Здесь Вы можете задать вопрос разработчику или сообщить о проблеме.<br>Ответ на Ваше письмо придет на почту, указанную при регистрации.</p>
			</div>			
		</div>
	</div> 
</main>

<div class="modals">
</div>

<?printfooter();?> 

</body>
</html>