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

    var bubbleForm = {
        dom: $('#bubbleForm'),
        save: function() {

            if (document.getElementById('textTask').value==""){
                alert('пустая задача!');
                return false
            }
            else
            {
                var text = document.getElementById('textTask').value;
                document.getElementById('textTask').value="";
                document.getElementById('inputs').innerHTML = document.getElementById('inputs').innerHTML + "<textarea  placeholder='введите задачу' rows='5'>"+ text +"</textarea>";
            }


        },
        clear: function() {}
    }

    $('.add_task_button').on('click', function(){
        bubbleForm.dom.show();
        return false;
    });

    bubbleForm.dom.find('.icon-block-1').on('click',function(e){
        e.preventDefault();
        bubbleForm.clear();
        bubbleForm.dom.hide();
        }
    );
    bubbleForm.dom.find('.icon-ok').on('click', function(e){
        e.preventDefault();
        bubbleForm.save()
        bubbleForm.dom.hide();
    });

});