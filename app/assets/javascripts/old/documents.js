 
	function jsonTr() {
		current_row.hide();
		$.getJSON( "/documents/" + document_id + ".json", function(data) {
			
			if (data.sn){
			  doc_serial = "<p class='value'><a href='#'>" + data.sn + "</a> / " + data.date + "</p>"
			}
			else {
			  doc_serial = "отсутсвует"
			}
			
			if (data.executor){
			  document_executor = data.executor
			}
			else {
			  document_executor = "отсутсвует"
			}
			
//			$("<tr class='inform'><td colspan='9'><div class='inform-wrap collapse status'><ul class='doc-info'></ul></div></td></tr>").insertAfter(current_row);
//			$("<li><span class='title'>Номер и дата:</span>" + doc_serial + "</li>").appendTo('.inform td ul');
//			$("<li><span class='title'>Тема:</span><p class='value'><a class='h4' href='/documents/" + document_id + "'> " + data.title + "</a></p></li>").appendTo('.inform td ul');
//			$("<li><p class='exp_fromto'><a href='#'>"  + data.sender_organization + "</a> &rarr; <a href='#'>" + data.organization + "</a></p></li>").appendTo('.inform td ul');
//			$("<li><span>Исполнитель</span><p class='exp_exec'><a href='#'>" + document_executor + "</a></p></li>").appendTo('.inform td ul');
//			$("<li><span>Отправитель</span><p class='exp_exec'><a href='#'>" + data.sender + "</a></p></li>").appendTo('.inform td ul');
//			$("<li><span style='text-align: right;'>Контрольное <br> лицо</span><p class='exp_exec'><a href='#'>" + data.approver + "</a></p></li>").appendTo('.inform td ul');
//
            $("<tr class='inform'><td colspan='9'><div class='col-md-8'><ul class='doc-info'></ul><div class='nav-pills nav controls'><a href='/documents/" + document_id + "' class='btn btn-default'>Открыть</a></div></div><div class='col-md-4'><div class='view-main-doc'><div class='overlay'><a href='#' target='blank' class='zoom'></a></div><a href='' class='icon-chat-empty'></a></div></div></td></tr>").insertAfter(current_row);
            $("<li><span class='title'>Номер и дата:" + data.data.date + "</span></p></li>").appendTo('.inform td ul');
			$("<li><span class='title'>Тема:</span><div class='value'><a class='h4' href='/documents/" + document_id + "'> " + data.title + "</a><ol class='breadcrumb'><li><a href='#'>ООО «Циклон»</a></li><li><a href='#'>ОАО «Метрострой»</a></li></ol></div></li>").appendTo('.inform td ul');
			$("<li><span class='title valign-mid'>Исполнитель:</span><div class='user value'><span class='photo'> <img alt='' src='data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAMAAABEpIrGAAAATlBMVEXz9PaAnq2Foa/29vjy8/WNp7SSqreOqLWPqbZ9m6rV3uOIpLHv8fOzxM3j6ey8y9Pq7vB6majI1Nre5OmetcCswMmWrrpwkqKiuMKnusXLnEwGAAABH0lEQVQ4y5WS2a6DMAxEiRMvWSEspf3/H72gAo2EebgjJJY5TOSRu//KWWsfPWdLfucQBt1PrizRG+8hDlqIS8HXKMyInoJVgAJms3eR90WJGAH5EMagJPRvOoH4Cu4GpIVeVwJkZYj5d4TUfE9w2fApNL0yRm/kIszYaQlyEqICo+eDEIbRKj1U/hIi0RR3B4YZdnO7EPLQjHedMUH8ZgCl9scLSBmQZSPUIXdgAhRmQSwqkNJyNAF9UnctmKPrSElp2pW3kbOnPNzssERoqsZlso3dhdlX5EZozPzbiZIFSRr7Wyf0x0GBifguIfpM1m0FmiisihCm0pUX8JOkfsK+J/IIYMzdDBfwe6DzHrFbj7eWoOsDr928Vv+ouuY/yfASuYyFl+0AAAAASUVORK5CYII=' /></span><a href='#' class='name ' data-toggle='dropdown'>" + document_executor + "</a></div></li>").appendTo('.inform td ul');
			$("<li><span class='title valign-mid'>Исполнитель:</span><div class='user value'><span class='photo'><img alt='' src='data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAMAAABEpIrGAAAATlBMVEXz9PaAnq2Foa/29vjy8/WNp7SSqreOqLWPqbZ9m6rV3uOIpLHv8fOzxM3j6ey8y9Pq7vB6majI1Nre5OmetcCswMmWrrpwkqKiuMKnusXLnEwGAAABH0lEQVQ4y5WS2a6DMAxEiRMvWSEspf3/H72gAo2EebgjJJY5TOSRu//KWWsfPWdLfucQBt1PrizRG+8hDlqIS8HXKMyInoJVgAJms3eR90WJGAH5EMagJPRvOoH4Cu4GpIVeVwJkZYj5d4TUfE9w2fApNL0yRm/kIszYaQlyEqICo+eDEIbRKj1U/hIi0RR3B4YZdnO7EPLQjHedMUH8ZgCl9scLSBmQZSPUIXdgAhRmQSwqkNJyNAF9UnctmKPrSElp2pW3kbOnPNzssERoqsZlso3dhdlX5EZozPzbiZIFSRr7Wyf0x0GBifguIfpM1m0FmiisihCm0pUX8JOkfsK+J/IIYMzdDBfwe6DzHrFbj7eWoOsDr928Vv+ouuY/yfASuYyFl+0AAAAASUVORK5CYII=' /></span><a href='#' class='name ' data-toggle='dropdown'>" + data.sender + "</a></div></li>").appendTo('.inform td ul');

//			if (data.attachments.length != 0){
				$("<li class='attach'><span class='title'>Приложения:</span><ul class='value attach-list'><li class='pic'><i></i><a href='#'>Фотография001.jpg</a></li><li class='doc'><i></i><a href='#'>Контракт-пример.doc</a></li><li class='xls'><i></i><a href='#'>Расчет эргономических пока.xls</a></li><li class='pdf'><i></i><a href='#'>Новые показатели.pdf</a></li><li><a href='#' class='else-link'>и еще 4 файла</a></li></ul></li>").appendTo('.inform td ul');
//				$.each(data.attachments, function(i,attachment_file_name){
//						$("<p class='exp_attach'>" + data.attachments[i].attachment_file_name + "</p></li>").appendTo('.attach');
//				});
//			}
			$('<iframe class="doc-sample" src="/documents/' + document_id + '.pdf"/></iframe>').appendTo('.inform td .view-main-doc');
			// $("<input class='btn btn-success btn-large' data-confirm='Вы уверены?' id='send_link' name='send' type='submit' value='Отправить'>").appendTo('.inform td');
			// $('<a href="/documents/' + document_id + '" class="btn btn-disabled" data-method="delete" data-confirm="Вы уверены?">Удалить</a>').appendTo('.inform td');
//			$('<a href="/documents/' + document_id + '" class="btn btn-success">Открыть</a>').appendTo('.inform td');
//			$('.label').filter(":hidden").clone().appendTo(".inform td div");
//			$('.control').filter(":hidden").clone().prependTo(".inform td");

			$( "input[name$='prepare'], #create_copy_link, #edit_link, #approve_link, #send_link, #reply_link, #delete_link" ).removeClass('disabled').addClass('btn-success');

			$("#create_copy_link").attr("href", "/documents/" + document_id + "/copy");
			$("#edit_link").attr("href", "/documents/" + document_id + "/edit");
			$("#approve_link").attr("href", "/documents/" + document_id + "/approve");
			$("#send_link").attr("href", "/documents/" + document_id + "/send_document");
			$("#reply_link").attr("href", "/documents/" + document_id + "/reply");

			full_control = $(".inform td").find(':checkbox')
			$(document).find(':checkbox').not(full_control).prop('checked', null);
			full_control.prop('checked', true);
			$('.inform').on("click", function() {
				$(this).hide();
				current_row.show();
				$( "#create_copy_link, #edit_link, #approve_link, #send_link, #reply_link, #delete_link" ).removeClass('btn-success').addClass('disabled');
				$( "#create_copy_link, #edit_link, #approve_link, #send_link, #reply_link, #delete_link" ).attr("href", "");
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
	
	$('#new_document').validate({
		
	   ignore: ":hidden:not(select)", 
		
       rules:{
            "document[title]":{
                required: true
            },	
            "document[organization_ids][]":{
                required: true
            },

			"document[approver_ids][]":{
                required: true
            },

			"document[executor_ids][]":{
                required: true
            },

			"document[text]":{
                required: true
            }

       },

       messages:{

            "document[title]":{
                required: "Укажите тему письма"
            },

            "document[organization_ids][]":{
                required: "Укажите тему организацию-получателя"
            },

			"document[approver_ids][]":{
                required: "Укажите контрольное лицо"
            },

			"document[executor_ids][]":{
                required: "Укажите исполнителя"
            },

			"document[text]":{
                required: "Заполните текст письма"
            }

       }

    });
	

	
	// $('#select_all_documents').on("click", function() {	
	// 	checked = $("#document_confidential").is(':checked')
	// 	  if (checked == true) {
	// 		$('#document_recipient_id').show();
	// 	  } else {
	// 	    $('#document_recipient_id').hide();
	// 	  }
	// });
	
	
	
	
	
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


	$(".dynamic-table tbody tr").click(appendTr);
	$(".dynamic-table tbody td.not_this").click(function(e){
	    e.stopPropagation()
	})
	
	$('#document_organization_ids').chosen();
	
	
	$("#document_organization_ids").chosen().change(function() {
	        $("#new_document").validate().element("#document_organization_ids");
	});
	
	$("#document_approver_ids").chosen({max_selected_options: 1}).change(function() {
	        $("#new_document").validate().element("#document_approver_ids");
	});
	
	$("#document_executor_ids").chosen({max_selected_options: 1}).change(function() {
	        $("#new_document").validate().element("#document_executor_ids");
	});
	
	
	$('#select_all_organizations').click(function(){
		$('#document_organization_ids').find("option").attr('selected', 'selected');
		$("#document_organization_ids").trigger("chosen:updated");
	});
	
	// $('#select_all_documents').on("click", function() {	
	// 	$(document).find(':checkbox').prop('checked', this.checked);
	// 	myFunction();
	// });
	
	$('.document_operation, #select_all_documents').on("change", function() {
		$(document).find(':checkbox').not(this).prop('checked', null);
		elem = $(this)
		myFunction(elem);
	});
	
	$('#text-search_button').on("click", function() {	
		$('#text-search').submit();
	});
	
	$('.add_documents').on("click", function() {	
		$('.list_to_add_documents').toggle();
		return false
	});
	
	
	
	
});



$(function() {
    $( "#datepicker, #document_deadline, #task_list_deadline" ).datepicker({ dateFormat: "dd-mm-yy" });
});

// function myFunction(elem) {
//   	if ($('.document_operation:checked').length == 1) {
// 	$( "input[name$='prepare'], #create_copy_link, #edit_link, #approve_link, #send_link, #reply_link, #delete_link" ).removeClass('disabled').addClass('btn-success');
// 	$("#edit_link").attr("href", "/documents/" + elem.val() + "/edit");
// 	$("#create_copy_link").attr("href", "/documents/" + elem.val() + "/copy");
// 	$("#reply_link").attr("href", "/documents/" + elem.val() + "/reply");
// 	$("#delete_link").attr("href", "/documents/" + elem.val() + "/delete");
//   } else if ($('.document_operation:checked').length > 1)  {
// 	$( "input[name$='prepare'], #approve_link, #send_link" ).removeClass('disabled').addClass('btn-success');
// 	$( "#create_copy_link, #edit_link, #reply_link, #reply_link, #delete_link" ).removeClass('btn-success').addClass('disabled');
//   } else {
//     $( "input[name$='prepare'], #create_copy_link, #edit_link, #approve_link, #send_link, #reply_link, #delete_link" ).removeClass('btn-success').addClass('disabled');
//   }
// };

function myFunction(elem) {
  	if ($('.document_operation:checked').length == 1) {
	$( "input[name$='prepare'], #create_copy_link, #edit_link, #approve_link, #send_link, #reply_link, #delete_link" ).removeClass('disabled').addClass('btn-success');
	
	$("#create_copy_link").attr("href", "/documents/" + elem.val() + "/copy");
	$("#edit_link").attr("href", "/documents/" + elem.val() + "/edit");
	$("#approve_link").attr("href", "/documents/" + elem.val() + "/approve");
	$("#send_link").attr("href", "/documents/" + elem.val() + "/send_document");
	$("#reply_link").attr("href", "/documents/" + elem.val() + "/reply");
	
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

