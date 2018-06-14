function base_url(segment){
   pathArray = window.location.pathname.split( '/' );
   indexOfSegment = pathArray.indexOf(segment);
   return window.location.origin + pathArray.slice(0,indexOfSegment).join('/') + '/';
}

var editIcon = $("<span>").html('<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512"><path d="M402.6 83.2l90.2 90.2c3.8 3.8 3.8 10 0 13.8L274.4 405.6l-92.8 10.3c-12.4 1.4-22.9-9.1-21.5-21.5l10.3-92.8L388.8 83.2c3.8-3.8 10-3.8 13.8 0zm162-22.9l-48.8-48.8c-15.2-15.2-39.9-15.2-55.2 0l-35.4 35.4c-3.8 3.8-3.8 10 0 13.8l90.2 90.2c3.8 3.8 10 3.8 13.8 0l35.4-35.4c15.2-15.3 15.2-40 0-55.2zM384 346.2V448H64V128h229.8c3.2 0 6.2-1.3 8.5-3.5l40-40c7.6-7.6 2.2-20.5-8.5-20.5H48C21.5 64 0 85.5 0 112v352c0 26.5 21.5 48 48 48h352c26.5 0 48-21.5 48-48V306.2c0-10.7-12.9-16-20.5-8.5l-40 40c-2.2 2.3-3.5 5.3-3.5 8.5z"/></svg>');

function getGroups(){
    $.ajax({
        url: 'ajax/api.php?action=getGroups',
        type: 'POST',
        dataType: 'json',
        processData: false, // Не обрабатываем файлы (Don't process the files)
        contentType: false, // Так jQuery скажет серверу что это строковой запрос
        success: function( respond ){
    		$("select#groupslist, select.groupslist").selectpicker('destroy').html("");
        	$.each(respond,function(i,el){
        		var item = $("<option>").val(el.id).html(el.name);
        		console.log(item);
            	$("#groupslist, .groupslist").append(item);
        	})
        	$("#groupslist, .groupslist").selectpicker();

        },
        error: function( jqXHR, textStatus, errorThrown ){
            console.log('ОШИБКИ AJAX запроса: ' + textStatus );
        }
    });
}

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

function getDbList() {
	// получение списка баз данных
	$.ajax({
        url: "ajax/api.php",
        data: {
        	action: "getDbList"
        },
        dataType: 'json',
        type: "GET",
        success: function(data){
			if(data != ""){
				allTasks = data;
		    	wrap = $("#dblist").html("");
		    	$.each(data, function(i, row){
		    		var input = $("<input>").addClass("_create_task_radio").prop({"type":"radio","name":"db","value":row.id,"id":"dbs-"+i});
		    		var label = $("<label>").prop('for', 'dbs-'+i);
		    		label.text(row.name).prepend(input);
	    			wrap.append(label);
		       	});
		    }
        },
        error: function(){
            console.log("Ошибка отправки запроса");
        },
    });
}

function getGroupList() {
	// получение списка баз данных
	$.ajax({
        url: "ajax/api.php",
        data: {
        	action: "getGroups"
        },
        dataType: 'json',
        type: "GET",
        success: function(data){
			if(data != ""){
				allTasks = data;
		    	wrap = $("#dblist").html("");
		    	$.each(data, function(i, row){
		    		var input = $("<input>").addClass("_create_task_radio").prop({"type":"radio","name":"db","value":row.id,"id":"dbs-"+i});
		    		var label = $("<label>").prop('for', 'dbs-'+i);
		    		label.text(row.name).prepend(input);
	    			wrap.append(label);
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

		var url = base_url() + "ajax/api.php";

		$.ajax({
            url: url,
            data: {
            	data: data,
            	action: action
            },
            //dataType: 'json',
            cache: false,
            type: "POST",
            success: function(data){
            	if(data){
            		$("#ajaxresp, .ajaxresp").html(data);
            		if(action == "login" || action=="regUser"){
            			setTimeout(()=>{
            				document.location.href="lk.php";
            			}, 1000)
            			
            		}else if(action == "saveTask" || action == "removeTask" || action == "createTask") {
    					$("._edit_task").val("").prop("readonly", true);
    					$("._edit_task_btns").prop("disabled", true);
    					$("._manager_select_task").removeClass("active");
            			getTasksList();
            		} else if(action == "createDb") {
						getDbList()
            		} else if(action == "saveUser") {
						$("._users_groups .dropdown-menu li.selected").trigger("click");
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

	getGroups();


});

function ctrlEnter(event, formElem){
	if((event.ctrlKey) && ((event.keyCode == 0xA)||(event.keyCode == 0xD))){
    	formElem.submit.click();
    }
}

$("body").on("click", "._curr_tab-link a", function(e){
	e.preventDefault();
	$("#ajaxresp, .ajaxresp").html("");
	var wrap = $(this).closest("._curr_tab-wrap");
	wrap.find("._curr_tab-link a, ._curr_tab_one").removeClass("active");
	$($(this).addClass("active").attr("href")).addClass("active");

});
