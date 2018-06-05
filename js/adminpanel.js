var allTasks;

$(document).ready(function(){

	getTasksList();

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

	$("body").on("click", ".show-btn", function(e) {
		e.preventDefault();
		$(this).closest(".create_task-wrap").addClass("active");
	});


})