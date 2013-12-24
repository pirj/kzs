$(function () {

    var documentAr = {

    }



    $(".attachments-carousel").jCarouselLite({
        btnNext: ".icon-right-open",
        btnPrev: ".icon-left-open",
        width: 900
    });

    $('.addDocuments').hide();

    $('.addDocBut').on('click', function(e) {
        e.preventDefault();
        $('.addDocuments').slideToggle();
    })



    $('#j-history').hide();


    $('.dropdown-menu .status-history').on('click', function () {

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

    $('.dropdown-menu .back-btn').on('click', function () {
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
        save: function () {

            if (document.getElementById('textTask').value == "") {
                alert('пустая задача!');
                return false
            }
            else {
                var text = document.getElementById('textTask').value;
                var regexp, time;
                time = new Date().getTime();
                regexp = new RegExp($('.add_task_button').data('id'), 'g');
                return $('.add_task_button').before($('.add_task_button').data('fields').replace(regexp, time));
            }
        },
        clear: function () {
        }
    }


    bubbleForm.dom.find('.icon-block-1').on('click', function (e) {
            e.preventDefault();
            bubbleForm.clear();
            bubbleForm.dom.hide();
        }
    );
    bubbleForm.dom.find('.icon-ok').on('click', function (e) {
        e.preventDefault();
        bubbleForm.save()
        bubbleForm.dom.hide();
    });

});

