$(document).ready(function(){

    $('#permit_way_bill').on("change", function() {                 // putev list only transport
        $('#permit_drivers_chosen').toggle();
    });

    $("#permit_start_date, #permit_expiration_date, #permit_date").datepicker({ dateFormat: "dd-mm-yy" });

    var permit = {

        setType: function (type) {
          //  console.log(type);
            document.location.hash = type;

            switch(type) {
                case '#user':
                    $('#permit_user_fields').show();
                    $('#permit_vehicle_fields').hide();
                    $('#date_fields').show();
                    $('#temporary_permit_fields').hide();
                    break;

                case '#vehicle':
                    $('#permit_user_fields').hide();
                    $('#permit_vehicle_fields').show();
                    $('#date_fields').show();
                    $('#temporary_permit_fields').hide();
                    $('#permit_drivers').chosen({max_selected_options: 3});

                    break;
                case '#daily':
                    $('#permit_user_fields').hide();
                    $('#permit_vehicle_fields').hide();
                    $('#date_fields').hide();                     //ne srabotalo
                    $('#temporary_permit_fields').show();
                    break;


            }
        }

    };

	$('#user_type').on("click", function() {
        permit.setType('#user');
	});
	
	$('#vehicle_type').on("click", function() {
        permit.setType('#vehicle');
	});
	
	$('#daily_pass').on("click", function() {
        permit.setType('#daily');
	});


    (function initialization(type){

        if (type == "") {
         //   permit.setType('#user');
            $('#user_type').click();
        }
        else if (type == "#user")  {
          //  permit.setType(type);

            $('#user_type').click();
        }
        else if (type == "#vehicle"){
            $('#vehicle_type').click();
        }
        else if (type == "#daily"){
            $('#daily_pass').click();
        };

    })(document.location.hash);
	
});