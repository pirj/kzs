$(function() {

    $(".attachments-carousel").jCarouselLite({
        btnNext: ".icon-right-open",
        btnPrev: ".icon-left-open",
        width: 900
    });

    $('#j-history').hide();

    $('.dropdown-menu .status-history').on('click', function(){

        var parent = $(this).closest('.dropdown-menu');

        parent.addClass('history');

        if ($(this).closest('.dropdown-menu.on')) {
            parent.animate({
                width: "380px"
            }, 300)
                .css(
                    "padding", "0 25px 12px"
                );
            $('#j-status').hide();
            $('#j-history').show();

        }
        return false;
    });
    $('.dropdown-menu .back-btn').on('click', function(){
        $(this).closest('.dropdown-menu').removeClass('history').animate({
            width: "190px"
        }, 500).css(
                "padding", "0"
            );
        $('#j-history').hide()
        $('#j-status').show();

        return false;
    });

    $('.add_task_button').on('click', function(){
				alert();
				
				

        return false;
    });


		
		
});