$(document).ready(function(){
	
	$('#new_statement').validate({
		
	   ignore: ":hidden:not(select)", 
		
       rules:{




            "statement[document_ids][]":{
                required: true,
            },	
            "statement[approver_ids][]":{
                required: true,
            },

            "statement[title]":{
                required: true,
            },

       },

       messages:{

            "statement[document_ids][]":{
                required: "Выберите распоряжение"
            },

            "statement[approver_ids][]":{
                required: "Выберите согласующих лиц",
            },

			"statement[title]":{
                required: "Укажите заголовок акта",
            },

       }

    });
	
	$("#statement_document_ids").chosen({max_selected_options: 1}).change(function() {
	        $("#new_statement").validate().element("#statement_document_ids");
	});
	
	$("#statement_approver_ids").chosen().change(function() {
	        $("#new_statement").validate().element("#statement_approver_ids");
	});
	
		
});


