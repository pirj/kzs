 
	function jsonTr() {
		current_row.hide();
		$.getJSON( "/documents/" + document_id + ".json", function(data) {
			
			
			
			if (data.sn){
			  doc_serial = "<p class='exp_date'><a href='#'>" + data.sn + "</a> / " + data.date + "</p>"
			}
			else {
			  doc_serial = "отсутсвует"
			}
			
			$("<tr class='inform'><td colspan='9'><div class='inform-wrap'><ul class='expanded'></ul></div></td></tr>").insertAfter(current_row);
			$("<li><span>Тип:</span><p class='exp_type'>" + data.type + "</p></li><li><span>Номер и дата:</span>" + doc_serial + "</li>").appendTo('.inform td ul');
			$("<li><span>Тема:</span><p class='exp_title'><a href='/documents/" + document_id + "'>" + data.title + "</a></p></li>").appendTo('.inform td ul');
			$("<li><p class='exp_fromto'><a href='#'>"  + data.sender_organization + "</a> &rarr; <a href='#'>" + data.organization + "</a></p></li>").appendTo('.inform td ul');
			$("<li><span>Исполнитель:</span><p class='exp_exec'><a href='#'>" + data.executor + "</a></p></li>").appendTo('.inform td ul');
			$("<li><span>Отправитель:</span><p class='exp_exec'><a href='#'>" + data.sender + "</a></p></li>").appendTo('.inform td ul');
			if (data.attachments.length != 0){
				$("<li class='attach'><span>Приложения:</span></li>").appendTo('.inform td ul');
				$.each(data.attachments, function(i,attachment_file_name){
						$("<p class='exp_attach'>" + data.attachments[i].attachment_file_name + "</p></li>").appendTo('.attach');
				});
			}
			$("<img class='doc_sample' src='assets/blanc-sample.png'>").appendTo('.inform td div');
			$("<input class='btn btn-success btn-large' data-confirm='Вы уверены?' id='send_link' name='send' type='submit' value='Отправить'>").appendTo('.inform td');
			// $('<a href="/documents/' + document_id + '" class="btn btn-disabled" data-method="delete" data-confirm="Вы уверены?">Удалить</a>').appendTo('.inform td');
			$('<a href="/documents/' + document_id + '" class="btn btn-success">Открыть</a>').appendTo('.inform td');
			$('.label').filter(":hidden").clone().appendTo(".inform td div");
			$('.control').filter(":hidden").clone().prependTo(".inform td");
			
			$('.inform').on("click", function() {	
				$(this).hide();
				current_row.show();
			});
			
			
	});
	};

	function appendTr() {
	current_row = $(this).closest('tr');
	document_id = $(this).find('.document_id').html();
	if (!!$(current_row).next(".inform").length){
			$(".inform").remove();
			}
	else if (!!$(".inform").not(current_row).length){
		$(".inform").not(current_row).remove();
	  	jsonTr();
	  	$( "tr:hidden" ).not(this).show(0);
			}
	else {
			jsonTr();
	}

};


$(document).ready(function(){
	

	

	
	$('#select_all_documents').on("click", function() {	
		checked = $("#document_confidential").is(':checked')
		  if (checked == true) {
			$('#document_recipient_id').show();
		  } else {
		    $('#document_recipient_id').hide();
		  }
	});
	
	
	
	$('#document_executor_id').on("change", function() {
		  if ($('#document_executor_id option:selected').val() == "") {
			$('#executor_tel').hide();
		  } else {
		    $('#executor_tel').show();
		  }
		$.ajax({
		    url: "/document/executor_phone",
		    type: "GET",
		    data: 'user=' + $('#document_executor_id option:selected').val(),
		  })		
});


	$(".documents_table tbody tr").click(appendTr);
	$(".documents_table tbody td.not_this").click(function(e){
	    e.stopPropagation()
	})
	
	$('#document_organization_ids').chosen();
	$('#document_approver_ids, #document_executor_ids').chosen({max_selected_options: 1});
	
	$('#select_all_organizations').click(function(){
		$('#document_organization_ids').find("option").attr('selected', 'selected');
		$("#document_organization_ids").trigger("chosen:updated");
	});
	
	$('#select_all_documents').on("click", function() {	
		$(document).find(':checkbox').prop('checked', this.checked);
		myFunction();
	});
	
	$('.document_operation').on("change", function() {
		elem = $(this)
		myFunction(elem);
	});
	
	$('#text-search_button').on("click", function() {	
		$('#text-search').submit();
	});
	
	
});



$(function() {
    $( "#datepicker" ).datepicker();
});

function myFunction(elem) {
  	if ($('.document_operation:checked').length == 1) {
	$( "input[name$='prepare'], #create_copy_link, #edit_link, #approve_link, #send_link, #reply_link, #delete_link" ).removeClass('disabled').addClass('btn-success');
	$("#edit_link").attr("href", "/documents/" + elem.val() + "/edit");
	$("#create_copy_link").attr("href", "/documents/" + elem.val() + "/copy");
	$("#reply_link").attr("href", "/documents/" + elem.val() + "/reply");
	$("#delete_link").attr("href", "/documents/" + elem.val() + "/delete");
  } else if ($('.document_operation:checked').length > 1)  {
	$( "input[name$='prepare'], #approve_link, #send_link" ).removeClass('disabled').addClass('btn-success');
	$( "#create_copy_link, #edit_link, #reply_link, #reply_link, #delete_link" ).removeClass('btn-success').addClass('disabled');
  } else {
    $( "input[name$='prepare'], #create_copy_link, #edit_link, #approve_link, #send_link, #reply_link, #delete_link" ).removeClass('btn-success').addClass('disabled');
  }
};
$('#delete_link').click(function() {
    $.post(this.href, { _method: 'delete' }, null, "script");
    return false;
  });
$(function() {
  $("#text-search input").keyup(function() {
    $.get($("#text-search").attr("action"), $("#text-search").serialize(), null, "script");
    return false;
  });
});

