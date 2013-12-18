$(document).ready(function(){
	
	if ($('#permit_permit_type_vehicle').attr('checked') == "checked"){
	  $('#permit_user_fields').hide();
		$('#permit_vehicle_fields').show();
		$('#temporary_permit_fields').hide();
		$('#permit_user_id').val('');
		$('#permit_drivers').chosen(); 
	}
	else if ($('#permit_permit_type_user').attr('checked') == "checked"){
	  $('#permit_user_fields').show();
		$('#permit_vehicle_fields').hide();
		$('#temporary_permit_fields').hide();
	}
	else if ($('#permit_permit_type_daily').attr('checked') == "checked"){
	  $('#permit_user_fields').hide();
		$('#permit_vehicle_fields').hide();
		$('#temporary_permit_fields').show();
	}
	
  $("#permit_start_date, #permit_expiration_date, #permit_date").datepicker({ dateFormat: "dd-mm-yy" });
	
	$('#user_type').on("click", function() {
	  $('#permit_user_fields').show();
		$('#permit_vehicle_fields').hide();
		$('#date_fields').show();
		$('#temporary_permit_fields').hide();
		inputs = $('#permit_vehicle_fields :input, #permit_temporary_fields :input')	
		inputs.each(function() {
		  $(this).removeAttr('value');
		});
	});
	
	$('#vehicle_type').on("click", function() {
	  $('#permit_user_fields').hide();
		$('#permit_vehicle_fields').show();
		$('#date_fields').show();
		$('#temporary_permit_fields').hide();
		$('#permit_user_id').val('');
		$('#permit_drivers').chosen();
		inputs = $('#permit_user_fields :input, #permit_temporary_fields :input')	
		inputs.each(function() {
		  $(this).removeAttr('value');
		});
	});
	
	$('#daily_pass').on("click", function() {
	  $('#permit_user_fields').hide();
		$('#permit_vehicle_fields').hide();
		$('#date_fields').hide();
		$('#temporary_permit_fields').show();
		$('#permit_vehicle_vehicle_body, #permit_vehicle_brand').val('');
		inputs = $('#permit_vehicle_fields :input, #permit_temporary_fields :input')	
		inputs.each(function() {
		  $(this).removeAttr('value');
		});
	});

	
	// $('#temporary').on("click", function() {
	//     $('#permanent_fields').hide();
	// 	$('#permit_start_date, #permit_expiration_date').val('');
	// 	$('#temoporary_fields').show();
	// });
	// 
	// 
	// $('#permanent').on("click", function() {
	// 	$('#permanent_fields').show();
	// 	$('#temoporary_fields').hide();
	// 	$('#permit_date').val('');
	// });
	
	$('#permit_way_bill').on("change", function() {
		$('#permit_drivers_chosen').toggle();
	});
	
	
});