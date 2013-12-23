$(document).ready(function () {



    function slideOff(){ $('.l-page__column').mouseleave(function() {
        setTimeout(function(){
            $('.l-page__column').removeClass('m-open');
            $('.menu-dir').removeClass('open');
            $('.child-dir').css({'height': '0px'});

        }, 700)         //оставлять если мышка вернулась!

    })};


$('#main-b').on('click', function(e) {
    e.preventDefault();

        var panel = $('.l-page__column');

    if (panel.hasClass('m-open')){

      document.location.href = '/';

       // panel.removeClass('m-open');
    }
    else {
        panel.addClass('m-open');
       // alert();
    }

slideOff();




   // return false
} );


    $('.menu-dir div.menu-link').click(function () {
        var childDir = $(this).next();

        if (childDir.parent().hasClass('open')) {
            childDir.parent().toggleClass('open');
            childDir.css({'height': 0});
        }
        else {

        childDir.parent().toggleClass('open');
        var counter =  childDir.children('.menu-link').length;


        childDir.css({'height': ((counter+1)*50)+'px'});

        }
        $('.l-page__column').mouseleave(function() {
            childDir.parent().removeClass('open');
            childDir.css({'height': '0px'});
        });
    });

});