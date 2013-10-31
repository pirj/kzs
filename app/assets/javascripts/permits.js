$(document).ready(function(){
    $("#permit_start_date, #permit_expiration_date, #permit_date").datepicker({ dateFormat: "dd-mm-yy" });
	
	$('#user_type').on("click", function() {
		$('#permit_user_fields').show();
		$('#permit_vehicle_fields').hide();
		$('#permit_vehicle_vehicle_body, #permit_vehicle_brand').val('');
	});
	
	$('#vehicle_type').on("click", function() {
	    $('#permit_user_fields').hide();
		$('#permit_vehicle_fields').show();
		$('#permit_user_id').val('');
	});
	
	$('#temporary').on("click", function() {
	    $('#permanent_fields').hide();
		$('#permit_start_date, #permit_expiration_date').val('');
		$('#temoporary_fields').show();
	});
	
	
	$('#permanent').on("click", function() {
		$('#permanent_fields').show();
		$('#temoporary_fields').hide();
		$('#permit_date').val('');
	});
	
	$('#permit_drivers').chosen({max_selected_options: 3});
	
	
	
	
});