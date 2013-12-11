$(document).ready(function(){

    $('#permit_way_bill').on("change", function() {                 // putev list only transport
        $('#permit_drivers_chosen').toggle();
    });

    $("#permit_start_date, #permit_expiration_date, #permit_date").datepicker({ dateFormat: "dd-mm-yy" });

    var permit = {
            type: '#user',

            setType: function (type) {
          //  console.log(type);
            document.location.hash = type;
            permit.type = type;
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
        },

        getType: function() {
            return permit.type;
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

        if ($('#new_permit').size() == 0 ) {

            //place to editing

        }

        else

        {
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
        };


    })(document.location.hash);


    var clear = {
        vehicle: function() {
            document.getElementById('permit_vehicle_attributes_model').value = '';
            document.getElementById('permit_vehicle_attributes_register_document').value = '';
            document.getElementById('permit_vehicle_attributes_sn_number').value = '';
            document.getElementById('permit_vehicle_attributes_sn_region').value = '';
        },
        user: function() {
            document.getElementById('permit_user_attributes_first_name').value = '';
            document.getElementById('permit_user_attributes_middle_name').value = '';
            document.getElementById('permit_user_attributes_last_name').value = '';
            document.getElementById('permit_user_attributes_position').value = '';
        },
        daily: function() {
            document.getElementById('permit_daily_pass_attributes_last_name').value = '';
            document.getElementById('permit_daily_pass_attributes_first_name').value = '';
            document.getElementById('permit_daily_pass_attributes_middle_name').value = '';
            document.getElementById('permit_daily_pass_attributes_id_type').value = '';
            document.getElementById('permit_daily_pass_attributes_id_sn').value = '';
            document.getElementById('permit_daily_pass_attributes_vehicle').value = '';
            document.getElementById('permit_daily_pass_attributes_object').value = '';
            document.getElementById('permit_daily_pass_attributes_person').value = '';
            document.getElementById('permit_daily_pass_attributes_issued').value = '';
            document.getElementById('permit_daily_pass_attributes_date').value = '';
            document.getElementById('permit_daily_pass_attributes_guard_duty').value = '';
        }
    }


    $('#new_permit').submit(function( event ) {                                 //submit

        function baddata(){
            alert('Заполните необходимые поля!');

        }

       event.preventDefault();

        var thisType = permit.getType();

        switch(thisType) {
            case '#vehicle':
                clear.user();
                clear.daily();
                if (document.getElementById('permit_start_date').value && document.getElementById('permit_expiration_date').value) {
                    document.newPermitForm.submit();
                }
                else {

                    baddata();
                }
            break;

            case '#daily':
                clear.user();
          //      clear.daily();
                clear.vehicle();

                if (document.getElementById('permit_daily_pass_attributes_middle_name').value&&document.getElementById('permit_daily_pass_attributes_first_name').value) {
                    document.newPermitForm.submit();
                }
                else {
                    baddata();
                }
            break;

            case '#user':

                clear.daily();
                clear.vehicle();

                if (document.getElementById('permit_start_date').value && document.getElementById('permit_expiration_date').value) {
                    document.newPermitForm.submit();
                }
                else {

                    baddata();
                }

            break;

        }




    })
	
});