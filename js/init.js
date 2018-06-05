function fillTable(wrap, data){
	if(wrap != "" && wrap.length > 0 && data != ""){
    	wrap.show().find("table tbody").html("");
    	wrap.show().find("table thead").html("");
    	$.each(data,function(i,row){
    		if(i == 0){
    			var container = wrap.find("table thead");
    		}else{
    			var container = wrap.find("table tbody");
    		}
    		container.append("<tr>");
    		$.each(row,function(j,cell){
    			container.find("tr:last-child").append("<td>");
    			container.find("tr:last-child td").last().text(cell);
    		});
       	});
    }
}

function getTasksList() {
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
		    	wrap = $("#all_tasks_table").html("");
		    	$.each(data, function(i, row){
		    		var tr_item = $("<a>").addClass('tr_item _manager_select_task').attr("href", "#").data({"id": row.id, "info": JSON.stringify(row)});
		    		tr_item.append($("<div>").addClass("td_item p-2").text(i+1)).append($("<div>").addClass("td_item p-2").text(row.task));
	    			wrap.append(tr_item);
		       	});
		    }
        },
        error: function(){
            console.log("Ошибка отправки запроса");
        },
    });
}

$(document).ready(function(){

	$("body").on("click","._ajax_btn",function(e){
		e.preventDefault();

		var _this = this,
		data = $(this).closest("form").serialize(),
		action = $(this).data("action");

		$("#ajaxresp").html("");

		$.ajax({
            url: "ajax/api.php",
            data: {
            	data: data,
            	action: action
            },
            //dataType: 'json',
            cache: false,
            type: "POST",
            success: function(data){
            	if(data){
            		$("#ajaxresp").html(data);
            		if(action == "login" || action=="regUser"){
            			document.location.href="lk.php";
            		}else if(action == "saveTask" || action == "removeTask") {
            			//if(action == "removeTask") {
        					$("._edit_task").val("").prop("readonly", true);
        					$("._edit_task_btns").prop("disabled", true);
        					$("._manager_select_task").removeClass("active");
        				//}
            			getTasksList();
            		}
            	}else{ 
            		if(action == "login"){
            			alert("Ошибка авторизации. Пожалуйста, проверьте введенные данные!");
            		}else{
            			alert("Ошибка сервера. Status Code:500");
            		}
            	}
            },
            error: function(){
                console.log("Ошибка отправки запроса");
            },
        });
	});


	$("body").on("click",".ajax_img",function(e){
		e.preventDefault();
	    if($(this).closest("form").find('input[type=file]').length > 0 && $('input[type=file]').get(0).files.length > 0){
	    	var files = $('input[type=file]').get(0).files,
			data = new FormData();
		    data.append( 'uploadfile', files[0] );
		
		    $.ajax({
		        url: 'ajax/api.php',
		        type: 'POST',
		        data: data,
		        cache: false,
		        dataType: 'text',
		        processData: false, // Не обрабатываем файлы (Don't process the files)
		        contentType: false, // Так jQuery скажет серверу что это строковой запрос
		        success: function( respond, textStatus, jqXHR ){
		            if( typeof respond.error === 'undefined' ){
		                // Файлы успешно загружены, делаем что нибудь здесь
				
		                $("#ajaxresp").html(respond);
		            }
		            else{
		                console.log('ОШИБКИ ОТВЕТА сервера: ' + respond.error );
		            }
		        },
		        error: function( jqXHR, textStatus, errorThrown ){
		            console.log('ОШИБКИ AJAX запроса: ' + textStatus );
		        }
		    });
		}

	});

	$("#task_select").on("change",function(e){
		e.preventDefault();
		var data = $(this).find("option:selected").data();
		$("#db_info").html(data.dbinfo);
		$("#task_text").html(data.task);
		$($("[name='viewtable']").data("result")).hide();
		$($("[name='userquery']").data("result")).hide();
		$('#sqltext').val("");
		$("#alert_result").hide();
		$("[name='userquery'], [name='viewtable']").removeAttr("disabled");
	});

	$("body").on("click", "[name='viewtable']", function(e){
		e.preventDefault();
		var query = $("#task_select option:selected").data('qer'),
		wrap = $($(this).data("result")),
		this_ = this;
		console.log(query);
		$.ajax({
	        url: "ajax/api.php",
	        data: {
	        	query: query,
	        	action: "getResultTable"
	        },
	        dataType: 'json',
	        type: "GET",
	        success: function(data){
	        	fillTable(wrap,data);
	        	$(this_).attr("disabled","disabled");
	        },
	        error: function(){
	            console.log("Ошибка отправки запроса");
	        },
	    });
	});

	function getGroups(){
	    $.ajax({
	        url: 'ajax/api.php?action=getGroups',
	        type: 'POST',
	        dataType: 'json',
	        processData: false, // Не обрабатываем файлы (Don't process the files)
	        contentType: false, // Так jQuery скажет серверу что это строковой запрос
	        success: function( respond ){
        		$("#groupslist").html("");
	        	$.each(respond,function(i,el){
	        		var item = $("<option>").val(el.id).html(el.name);
	        		console.log(item);
	            	$("#groupslist").append(item);
	        	})
	           

	        },
	        error: function( jqXHR, textStatus, errorThrown ){
	            console.log('ОШИБКИ AJAX запроса: ' + textStatus );
	        }
	    });
	}
	getGroups()


});

function ctrlEnter(event, formElem){
	if((event.ctrlKey) && ((event.keyCode == 0xA)||(event.keyCode == 0xD))){
    	formElem.submit.click();
    }
}

