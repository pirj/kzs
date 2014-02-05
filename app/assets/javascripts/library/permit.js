//$(document).ready(function(){
//    $("#permit_start_date, #permit_expiration_date, #permit_date").datepicker({ dateFormat: "dd-mm-yy" });
//
//    var permit = {
//        type: '#user',
//        setType: function (type) {
//            document.location.hash = type;
//            permit.type = type;
//            switch(type) {
//                case '#user':
//                    $('#permit_user_fields').show();
//                    $('#permit_vehicle_fields').hide();
//                    $('#date_fields').show();
//                    $('#temporary_permit_fields').hide();
//                    $('h1').html('Новый пропуск на сотрудника');
//                    break;
//
//                case '#vehicle':
//                    $('#permit_user_fields').hide();
//                    $('#permit_vehicle_fields').show();
//                    $('#date_fields').show();
//                    $('#temporary_permit_fields').hide();
//                    $('h1').html('Новый пропуск на ТС');
//                    $('#permit_drivers').chosen({max_selected_options: 3});
//
//                    break;
//                case '#daily':
//                    $('#permit_user_fields').hide();
//                    $('#permit_vehicle_fields').hide();
//                    $('#date_fields').hide();                     //ne srabotalo
//                    $('#temporary_permit_fields').show();
//                    $('h1').html('Разовый пропуск');
//                    break;
//
//
//            }
//        },
//
//        getType: function() {
//            return permit.type;
//        }
//
//
//
//    };
//
//    $('#user_type').on("click", function() {
//        permit.setType('#user');
//    });
//
//    $('#vehicle_type').on("click", function() {
//        permit.setType('#vehicle');
//    });
//
//    $('#daily_pass').on("click", function() {
//        permit.setType('#daily');
//    });
//
//
//    (function initialization(type){
//
//        if ($('#new_permit').size() == 0 ) {
//
//            //place to editing
//
//        }
//
//        else
//
//        {
//            if (type == "") {
//                //   permit.setType('#user');
//                $('#user_type').click();
//            }
//            else if (type == "#user")  {
//                //  permit.setType(type);
//
//                $('#user_type').click();
//            }
//            else if (type == "#vehicle"){
//                $('#vehicle_type').click();
//            }
//            else if (type == "#daily"){
//                $('#daily_pass').click();
//            };
//        };
//
//
//    })(document.location.hash);
//
//
//    var clear = {
//        vehicle: function() {
//            _.each(document.getElementById('permit_vehicle_fields').getElementsByTagName('input'), function(w){
//                w.disabled = true
//
//            })
//            _.each(document.getElementById('permit_vehicle_fields').getElementsByTagName('select'), function(w){
//                w.disabled = true
//
//            })
//        },
//        user: function() {
//            _.each(document.getElementById('permit_user_fields').getElementsByTagName('input'), function(w){
//                w.disabled = true
//            })
//
//            _.each(document.getElementById('permit_user_fields').getElementsByTagName('select'), function(w){
//                w.disabled = true
//            })
//        },
//        daily: function() {
//            _.each(document.getElementById('temporary_permit_fields').getElementsByTagName('input'), function(w){
//                w.disabled = true
//              //  w.input = '';
//            })
//            _.each(document.getElementById('temporary_permit_fields').getElementsByTagName('select'), function(w){
//                w.disabled = true
//
//            })
//        }
//    }
//
//
//    $('#submitButton').click(function( event ) {                                 //submit
//
//
//        event.preventDefault();
//
//        var thisType = permit.getType();
//
//        switch(thisType) {
//            case '#vehicle':
//
//                clear.user();
//                clear.daily();
//              //  $(".actions [name='commit']").submit();
//                $('#new_permit').submit();
//                break;
//
//            case '#daily':
//                clear.user();
//                clear.vehicle();
//                $('#new_permit').submit();
//                break;
//
//            case '#user':
//
//                clear.daily();
//                clear.vehicle();
//                $('#new_permit').submit();
//
//                break;
//
//        }
//
//
//
//
//    })
//
//    $('#permit_way_bill').on("change", function() {                 // putev list only transport
//        if (document.getElementById('permit_way_bill').checked) {
//            $('#permit_drivers_chosen').hide();
//        }else{
//            $('#permit_drivers_chosen').show();
//        }
//
//    });
//
//});