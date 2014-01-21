$(document).ready(function () {

    var panel = $('.l-page__column');           //определяем панель

    $('#main-b').on('click', function (e) {         //логика главной кнопки
        e.preventDefault();

        if (panel.hasClass('m-open')) {
            document.location.href = '/';
        }
        else {
            panel.addClass('m-open');
        }

    });

    var removeId = 0;


    function closeSidebar() {

        removeId = setTimeout(function() {
     //       $('.l-page__column').removeClass('m-open');
     //       $('.menu-dir').removeClass('open');
     //       $('.child-dir').css({'height': '0px'});

        }, 800)
    }


    panel.mouseleave(function(){closeSidebar()});

    panel.mouseenter(function(){clearTimeout(removeId)
    })




    $('.menu-dir div.menu-link').click(function () {                //логика работы раскрывающихся папок

        var childDir = $(this).next();


        if (panel.hasClass('m-open')) {
            if (childDir.parent().hasClass('open')) {
                childDir.parent().toggleClass('open');
                childDir.css({'height': 0});
            }
            else {
                childDir.parent().toggleClass('open');
                var counter = childDir.children('.menu-link').length;
                childDir.css({'height': ((counter + 1) * 50) + 'px'});
            }
            /*$('.l-page__column').mouseleave(function () {
                childDir.parent().removeClass('open');
                childDir.css({'height': '0px'});
            });*/
        }
        else {
            document.location.href = childDir.find('.menu-link')[0].getAttribute('href');
        }


    });

});