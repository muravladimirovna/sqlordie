var allTasks;
$(document).ready(function(){

	// получение списка заданий
	$.ajax({
        url: "ajax/api.php",
        data: {
        	action: "getTasks"
        },
        dataType: 'json',
        type: "GET",
        success: function(data){
			if(data != ""){
				allTasks = data;
		    	wrap = $("#all_tasks_table");
		    	$.each(data, function(i, row){
		    		var tr_item = $("<div>").addClass('tr_item').data("id", row.id);
		    		tr_item.append($("<div>").addClass("td_item p-2").text(row.id)).append($("<div>").addClass("td_item p-2").text(row.task));
	    			wrap.append(tr_item);
		       	});
		    }
        },
        error: function(){
            console.log("Ошибка отправки запроса");
        },
    });

	// получение списка заданий
	function getScoreList(){
		$.ajax({
	        url: "ajax/api.php",
	        data: {
	        	action: "getGroupList"
	        },
	        dataType: 'json',
	        type: "GET",
	        success: function(data){
	        	$("#score_list").html("");
	        	$.each(data,function(i,el){
	        		$("#score_list").append("<div>");
	        		$("#score_list > div").last().addClass("score_panel d-flex justify-content-between align-items-center p-1").append("<div>").append("<div>").append("<div>");
	        		$("#score_list > div").last().find("div").first().css("background-image","url('img/"+el.avatar+"')");
	        		$("#score_list > div").last().find("div:nth-child(2)").css("overflow","hidden").attr("title", el.name + " " + el.lastname).text(el.login);
	           		$("#score_list > div").last().find("div").last(2).text(el.score);
	           	});
	        },
	        error: function(){
	            console.log("Ошибка отправки запроса");
	        },
	    });
	};
	getScoreList();


	$("body").on("click", "[name='userquery']", function(){
		var num = $("#task_select").val(),
		query = $("#task_select option:selected").data('qer'),
		uquery = $('#sqltext').val(),
		wrap = $($("[name='viewtable']").data("result")),
		uwrap = $($("[name='userquery']").data("result"));
		if(uquery != ""){
			$.ajax({
		        url: "ajax/api.php",
		        data: {
		        	num: num,
		        	query: query,
		        	uquery: uquery,
		        	action: "compareResult"
		        },
		        dataType: 'json',
		        type: "GET",
		        success: function(data){
		        	$("#alert_result").show().html(data.message);
		        	fillTable(uwrap, data.user);
		        	fillTable(wrap, data.true);
		        	$("#task_select option:selected").removeClass("false").addClass("true").attr("disabled","disabled");
		        	//$("[name='userquery'], [name='viewtable'], #sqltext").attr("disabled","disabled");
		        	getScoreList();
		        },
		        error: function(){
		            console.log("Ошибка отправки запроса");
		        },
		    });
		}else{
			alert("Введите текст запроса!");
		}
	});

	var userdata = JSON.parse($("[name='userdata']").val());
	$("#userinfo .score_avatar").css("background-image","url('img/" + userdata.avatar + "')");
	$("#userinfo #tscore").text(userdata.score);
	$("#userinfo #trating").text(userdata.position);
	
})