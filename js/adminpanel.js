var allTasks;

$(document).ready(function(){

	getTasksList();

	getDbList();

	$("body").on("click", "._manager_select_task", function(e) {
		e.preventDefault();
		var task = JSON.parse($(this).data("info"));
		$("._edit_task_id").val(task.id);
		$("._edit_task_text").val(task.task);
		$("._edit_task_answ").val(task.qer);
		$("._remove_task_btn, ._edit_task_btn").prop("disabled", false);
		$("._save_task_btn").prop("disabled", true);
		$("._edit_task").prop("readonly", true);
		$("#ajaxresp").html("");
		$("._manager_select_task").removeClass("active");
		$(this).addClass("active");
	});

	$("body").on("input", "._edit_task", function(e) {
		e.preventDefault();
		$("._save_task_btn").prop("disabled", false);
	});

	$("body").on("click", "._edit_task_btn", function(e) {
		e.preventDefault();
		$("._edit_task").prop("readonly", false);
	});

	$("body").on("click", "._show_task_create_form", function(e) {
		e.preventDefault();
		$(this).closest("._show_task_create_wrap").addClass("active");
	});

	$("body").on("change", "._users_groups", function(e) {
		e.preventDefault();

		var action = "getGroupList",
		groupid = $(this).val(),
		order = "users.id ASC"; 

	    $("#userslist").html("");

	    $.ajax({
	        url: 'ajax/api.php',
	        data: {
	        	action: action,
	        	groupid: groupid,
	        	order: order
	        },
	        type: 'POST',
	        dataType: 'json',
	        success: function( respond ) {
	    		var thead = $("<tr>").append($("<th>").text("№")).append($("<th>").text("Имя")).append($("<th>").text("Фамилия")).append($("<th>").text("Логин")).append($("<th>").text("Ответы")).append($("<th>").text("Удалить")),
	    		table = $("<table>").addClass("table").append($("<thead>").append(thead)),
	    		tbody = $("<tbody>");

	        	$.each(respond,function(i,el){
	        		var item = $("<tr>").append($("<td>").text(i+1)).append($("<td>").text(el.name)).append($("<td>").text(el.lastname)).append($("<td>").text(el.login)).append($("<td>").text(el.score));
	        		tbody.append(item);
	        	});

	        	$(table).append(tbody);
	        	$("#userslist").append(table);
	        	$('#userslist > table').DataTable();
	        },
	        error: function( jqXHR, textStatus, errorThrown ) {
	            console.log('ОШИБКИ AJAX запроса: ' + textStatus );
	        }
	    });
	});


})