$(function () {

    if ($('.wrapper').hasClass('js-dashboard-page2')) {          //вместо роутинга


        function meteoReq() {
            var Request = $.ajax({
                url: 'http://api.openweathermap.org/data/2.5/weather?id=540771&mode=json&units=metric', //540771 kronstadt //498817 spb
                type: "GET",
                dataType: "json"
            });

            return Request;
        }








        var weather =  new Object;



        console.log(weather.req);


        $.ajaxSetup({

        });
        var requestCoord = $.ajax({
            url: "/dashboard.json",
            type: "GET",
            dataType: "json",
            settings: {beforeSend: function (xhr) {
                xhr.setRequestHeader('X-CSRF-Token',
                    $('meta[name="csrf-token"]').attr('content'));}
            }
        });

        requestCoord.done(function (response) {
           // console.log(response)
        });


        var gridster = $(".gridster > ul").gridster(
            {
                widget_margins: [10, 10],
                widget_base_dimensions: [140, 140],

                max_size_x: 6,
                max_size_y: 4,
                max_cols: 6,
                resize: {
                    enabled: true
                },
                avoid_overlapped_widgets: true,
                autogenerate_stylesheet: true

            }
        ).data('gridster');




        var widgets = $('.gridster li');



        gridster.disable(widgets);
        gridster.disable_resize(widgets);


        //ищем блок погоды
        _.each(gridster.$widgets, function (w) {
            if (w.classList.contains('widget-weather')) {
                weather.widget = w;
            };
        });



        meteoReq().done(function (response) {              //узнали погоду
            weather.today = response;
     //   console.log(weather.today );

        document.getElementsByClassName('j-temp')[0].childNodes[0].innerHTML = weather.today.main.temp.toFixed(1) + '°C';
        document.getElementsByClassName('j-status')[0].innerHTML = weather.today.weather[0].description;


           // console.log($('.j-temp'));
                //.text(weather.today.main.temp);   weather.widget
        });



        function saveWidget() {
            var newdata = gridster.serialize(widgets);
            console.log();
            var request = $.ajax({
                url: "/save_desktop_configuration",
                type: "POST",
                dataType: "json",
                data: {wasd: '123'}
            });



            $('#exit-edit a').click();

        };

       // console.log(weather.widget);

        gridster.disable_resize(weather.widget);












// Click mouse and ...




        console.log(document.getElementsByClassName('widget'));
        widgets.mousedown(function(e){
            console.log(e);

            editTime = setTimeout(function(){
                console.log(123);
            }, 1500);
        });

        $('.widget').mouseup(function(){
            clearTimeout(editTime)
        });


















// Add widget
        $('.add-widget-btn').on('click', function () {
            gridster.add_widget('<li class="new">The HTML of the widget...</li>', 1, 1);
        });

// Remove widget
        gridster.$el
            .on('click', '.icon-cancel-circled', function () {
                gridster.remove_widget($(this).parent('li'));
            });


        $('.widget.disable').on('click', function () {
            return false;
        });


// Enter edit-mode

        $('#edit-current-desktop').bind('click', function () {

            $('.edit-nav').show();
            $('.page.full').addClass('editing');

            gridster.enable_resize();
            _.each(widgets, function(w) {
                if (w.classList.contains('widget-weather')) {
                    w.removeChild(_.last(w.childNodes))
                }
            });

            gridster.enable(widgets);

            $('.wrapper .widget a').on('click', function () {
                return false
            });

 //save current position widgets

            $('.save').on('click', saveWidget());



        })/*.data('gridster')*/;

//cancel
        $('#cancel-edit-current-desktop').bind('click', function () {

        });
// Exit edit-mode
        $('#exit-edit a').on('click', function () {
            //   $('.main-desktop-controls').html('<h3>Главный рабочий стол</h3>');
            $('.widget a').on('click', function () {
                document.location = this.href;
            });

            $('.wrapper').removeClass('editing');
            $('.edit-nav').hide();
            $('.icon-resize-full-alt, .icon-resize-full, .icon-cancel-circled').remove();
            gridster.disable(widgets);
            gridster.disable_resize(widgets);
        })
        /*.data('gridster');*/
    }
});