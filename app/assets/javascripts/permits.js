$(document).ready(function(){
    $("#permit_start_date, #permit_expiration_date").datepicker({ dateFormat: "dd-mm-yy" });

	$('#permit_permit_type').on("change", function() {
		  if ($('#permit_permit_type option:selected').val() == "user") {
			$('#permit_user_id').show();
			$('#permit_vehicle_id').hide();
		  } else {
		    $('#permit_user_id').hide();
			$('#permit_vehicle_id').show();
		  }	
	});
	
	
});