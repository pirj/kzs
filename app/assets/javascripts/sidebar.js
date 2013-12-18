$(document).ready(function () {




    $('.menu-dir div.menu-link').click(function () {
        var childDir = $(this).next();

        childDir.toggleClass('open');



        var counter =  childDir.children('.menu-link').length;
        console.log(counter);

        childDir.css({'height': (counter*50)+'px'});

        $('.l-page__column').mouseleave(function() {
            childDir.removeClass('open');
            //childDir.css({'height': 0});
        });
    });

});