$(document).ready(function(){
	
	  if ($('#permit_permit_type_vehicle').attr('checked') == "checked"){
		  $('#permit_user_fields').hide();
			$('#permit_vehicle_fields').show();
			$('#permit_user_id').val('');
			$('#permit_drivers').chosen({max_selected_options: 3}); 
		}
		else {
		  $('#permit_user_fields').show();
			$('#permit_vehicle_fields').hide();
		}
	
    $("#permit_start_date, #permit_expiration_date, #permit_date").datepicker({ dateFormat: "dd-mm-yy" });
	
	$('#user_type').on("click", function() {
		$('#permit_user_fields').show();
		$('#permit_vehicle_fields').hide();
		$('#permit_vehicle_vehicle_body, #permit_vehicle_brand').val('');
		inputs = $('#permit_vehicle_fields :input')	
		inputs.each(function() {
		  $(this).val('');
		});
	});
	
	$('#vehicle_type').on("click", function() {
	  $('#permit_user_fields').hide();
		$('#permit_vehicle_fields').show();
		$('#permit_user_id').val('');
		$('#permit_drivers').chosen({max_selected_options: 3});
		inputs = $('#permit_user_fields :input')	
		inputs.each(function() {
		  $(this).val('');
		});
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
	
	$('#permit_way_bill').on("change", function() {
		$('#permit_drivers_chosen').toggle();
	});
	
	
});