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
		$("#ajaxresp, .ajaxresp").html("");
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

	//$("body").on("changed.bs.select", "select._users_groups", function(e) {
	$("body").on("click", "._users_groups .dropdown-menu li", function(e) {
		
		e.preventDefault();

		var action = "getGroupList",
		groupid = $("select._users_groups").val(),
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
	    		var thead = $("<tr>").append($("<th>").text("№")).append($("<th>").text("Имя")).append($("<th>").text("Фамилия")).append($("<th>").text("Логин")).append($("<th>").text("Ответы")).append($("<th>").text("")),
	    		table = $("<table>").addClass("table").append($("<thead>").append(thead)),
	    		tbody = $("<tbody>");

	        	$.each(respond,function(i,el){
	        		var edit = $("<form>").append($("<input>").prop({"type":"hidden","name":"id","value":el.id}));
	        		edit.append($("<input>").prop({"type":"hidden","name":"login","value":el.login}));
	        		edit.append($("<input>").prop({"type":"hidden","name":"name","value":el.name}));
	        		edit.append($("<input>").prop({"type":"hidden","name":"group_id","value":el.group_id}));
	        		edit.append($("<input>").prop({"type":"hidden","name":"lastname","value":el.lastname}));
	        		edit.append($("<span>").addClass("svg svg-edit _edit_user_btn"));
	        		var item = $("<tr>").append($("<td>").text(i+1)).append($("<td>").text(el.name)).append($("<td>").text(el.lastname)).append($("<td>").text(el.login)).append($("<td>").text(el.score)).append($("<td>").html(edit));
	        		tbody.append(item);
	        	});

	        	$(table).append(tbody);
	        	$("#userslist").append(table);
	        	$('#userslist > table').DataTable();	
	        	$(".dataTables_wrapper select").selectpicker();
				//$(".edit-icon").html(editIcon);	
	        },
	        error: function( jqXHR, textStatus, errorThrown ) {
	            console.log('ОШИБКИ AJAX запроса: ' + textStatus );
	        }
	    });
	});

	$("body").on("click", "._edit_user_btn", function(e) {
		e.preventDefault();
		var form = $("#edit_user");
		$("#ajaxresp, .ajaxresp").html("");

		$.fancybox.open(form.html());

		var form = $(".fancybox-inner #edit_user-form");

		_this = $(this).closest("form"),
		name = _this.find("input[name='name']").val(),
		lastname = _this.find("input[name='lastname']").val(),
		login = _this.find("input[name='login']").val(),
		id = _this.find("input[name='id']").val(),
		group_id = _this.find("input[name='group_id']").val();

		form.find("input[name='name']").prop("value", name);
		form.find("input[name='lastname']").prop("value", lastname);
		form.find("input[name='login']").prop("value", login);
		form.find("input[name='id']").prop("value", id);
		form.find("select[name='group_id'] option[value='" + group_id + "']").prop("selected", true);
	})


})