$(document).ready(function(){
	var addItem = $('.add-list .form-container').html();
	
	$('#add_new_lic').on('click', function() {
		$(addItem).appendTo().parent();
	});
	$('.form-container .delete').on('click', function() {
		$(this).parent('.form-container').remove();
	});
});