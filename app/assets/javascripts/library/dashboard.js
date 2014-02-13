$(function () {

    if ($('.wrapper').hasClass('m-dashboard-page')) {

        var weather = {}
        weather.req = $.ajax({
            url: 'http://api.openweathermap.org/data/2.5/weather?id=498817&mode=json&units=metric',
            type: "GET",
            dataType: "json"
        });

        weather.req.done(function (response) {
            //        console.log(response);
        });

        $.ajaxSetup({
            beforeSend: function (xhr) {
                xhr.setRequestHeader('X-CSRF-Token',
                    $('meta[name="csrf-token"]').attr('content'));
            }
        });
        var requestCoord = $.ajax({
            url: "/dashboard.json",
            type: "GET",
            dataType: "json"
        });

        requestCoord.done(function (response) {
            //     console.log(response)
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


        gridster.disable_resize(weather.widget);


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

            $('.save').click(function () {

                var data = new Array();

                var newdata = gridster.serialize(widgets);

                _.each(document.getElementsByClassName('widget'), function (widget) {

                    var name = widget.classList[1];
                    var Ar = new Array;
                    Ar.push(widget.getAttribute('data-row'))
                    Ar.push(widget.getAttribute('data-col'))
                    Ar.push(widget.getAttribute('data-sizex'))
                    Ar.push(widget.getAttribute('data-sizey'))

                    data.push(Ar)
                })
//            var data = {widgets: {docs: [1,2,4,5], mops: [1,2,4,5], loks: [1,2,4,5]}}

                data = {
                    widgets: data
                }

                var request = $.ajax({
                    url: "/save_desktop_configuration",
                    type: "POST",
                    dataType: "json",
                    data: newdata
                });

                $('#exit-edit a').click();

            });


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