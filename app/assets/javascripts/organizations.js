$(document).ready(function(){
	var addItem = $('.add-list .form-container').html();
	
	$('#add_new_lic').on('click', function() {
		$(addItem).appendTo().parent();
	});
	$('.form-container .delete').on('click', function() {
		$(this).parent('.form-container').remove();
	});


    $('.js-select-collection').chosen()



/* table logic   */


    var controller = 'organizations';//document.getElementsByTagName('table')[0].id;



    console.log(controller);

    function CloseAllTR(controller){
        _.each(document.getElementById(controller).getElementsByClassName('opened'), function(td){
            td.classList.remove('opened');
        })
    }


    $(".dynamic-table tbody tr").click(function(){                      //открытие



        if(this.className!=='opened'){
            var self = this;

            if (document.getElementById(controller).getElementsByClassName('opened')) {
                CloseAllTR(controller);
            }

            self.classList.add('opened');
        }
    });

    $(".dynamic-table .inform-hide").on('click', function(){                  //закрытие
        event.stopPropagation();
        CloseAllTR(controller);
    });

    $(".dynamic-table tbody td.not_this").click(function(e){
        e.stopPropagation();
    });



});