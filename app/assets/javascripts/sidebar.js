$(document).ready(function () {




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