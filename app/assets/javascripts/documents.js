

$(document).ready(function(){
    var controller = $('table').attr('id')

    function CloseAllTR(controller){

            _.each(document.getElementById(controller).getElementsByClassName('opened'), function(td){

                td.classList.remove('opened');
    //            console.log(td.classList);
            })

    }

    $(".dynamic-table tbody tr").click(function(){                      //открытие
        var docId = this.id;


        if(this.className!=='opened'){
            var self = this;

            if (document.getElementById(controller).getElementsByClassName('opened')) {
                CloseAllTR(controller);
            }

            if (!this.getElementsByTagName('iframe')[0].src){
                this.getElementsByTagName('iframe')[0].src = '/'+ controller +'/'+ docId + '.pdf';
            }

            self.classList.add('opened');
                  //className classList stopImmediatePropagation(' ' ,....,...).
          //  self.className += ' opened' ;            //className classList src="/<%= @controller %>/<%= document.id %>.pdf"

        }
    });

    $(".dynamic-table .inform-hide").on('click', function(){                  //закрытие

        event.stopPropagation()

        CloseAllTR(controller);

    });


    $(".dynamic-table tbody td.not_this").click(function(e){
        e.stopPropagation()
    });


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



    $('#document_organization_ids').chosen();


    $("#document_organization_ids").chosen().change(function() {
        $("#new_document").validate().element("#document_organization_ids");
    });

    $("#document_approver_ids").chosen({max_selected_options: 1}).change(function() {
        $("#new_document").validate().element("#document_approver_ids");
				if ($(this).val() == null) {
            $('#approver_info').hide();
        } else {
						var field = "approver_info"
						$.ajax({
		            url: "/document/executor_phone",
		            type: "GET",
		            data: {user: +$(this).val(), field: field}
		        }).done(function() {
							    $('#approver_info').show();
						}).fail(function() {
								    alert( "error" );
						})
        }
    });

    $("#document_executor_ids").chosen({max_selected_options: 1}).change(function() {
        $("#new_document").validate().element("#document_executor_ids");
				if ($(this).val() == null) {
            $('#executor_info').hide();
        } else {
						var field = "executor_info"
						$.ajax({
		            url: "/document/executor_phone",
		            type: "GET",
		            data: {user: +$(this).val(), field: field},
		        }).done(function() {
							    $('#executor_info').show();
						}).fail(function() {
								    alert( "error" );
						})
        }
    });


    $('#select_all_organizations').click(function(){
        $('#document_organization_ids').find("option").attr('selected', 'selected');
        $("#document_organization_ids").trigger("chosen:updated");
    });


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


function myFunction(elem) {
    if ($('.document_operation:checked').length == 1) {
        $( "input[name$='prepare'], #create_copy_link, #edit_link, #approve_link, #send_link, #reply_link, #delete_link" ).removeClass('disabled').addClass('');

        $("#create_copy_link").attr("href", "/documents/" + elem.val() + "/copy");
        $("#edit_link").attr("href", "/documents/" + elem.val() + "/edit");
        $("#approve_link").attr("href", "/documents/" + elem.val() + "/approve");
        $("#send_link").attr("href", "/documents/" + elem.val() + "/send_document");
        $("#reply_link").attr("href", "/documents/" + elem.val() + "/reply");

    } else {
        $( "input[name$='prepare'], #create_copy_link, #edit_link, #approve_link, #send_link, #reply_link, #delete_link" ).removeClass('btn-success').addClass('');
    }
};

$('#delete_link').click(function() {
    $.post(this.href, { _method: 'delete' }, null, "script");
    return false;
});
$(function() {
    $("#text-search input").keyup(function() {                                                              //?
        $.get($("#text-search").attr("action"), $("#text-search").serialize(), null, "script");
        return false;
    });
});