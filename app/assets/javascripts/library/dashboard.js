


$(function () {

    if ($('.wrapper').hasClass('m-dashboard-page') ){

    $.ajaxSetup({
        beforeSend: function (xhr) {
            xhr.setRequestHeader('X-CSRF-Token',
                $('meta[name="csrf-token"]').attr('content'));
        }
    });
    var request = $.ajax({
        url: "/dashboard.json",
        type: "GET",
        dataType: "json"
    });

    request.done(function (response) {
        if (response.desktop_conf[0]) {
            var i = 0;
            _.each(document.getElementsByClassName('widget'), function (widget) {

                if (response.desktop_conf[i]) {
                    widget.setAttribute('data-row', response.desktop_conf[i][0]);
                    widget.setAttribute('data-col', response.desktop_conf[i][1]);
                    widget.setAttribute('data-sizex', response.desktop_conf[i][2]);
                    widget.setAttribute('data-sizey', response.desktop_conf[i][3]);
                }

                i++

            });
        }
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

    console.log(gridster);
    var widgets = $('.gridster li');

  //  gridster.disable(widgets);
 //   gridster.disable_resize(widgets);





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

    $('#edit-current-desktop').bind('click',function () {

        $('.edit-nav').show();

        //   $('.main-desktop-title').html(' <div class="row-fuild clearfix edit-nav"><div class="col-md-3 column"><span class="edit-mode clearfix dropdown"><a type="button" class="ajax-link" href="#" id="dropdownMenu1" data-toggle="dropdown">Главный рабочий стол</a><ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu2"><li><a class="icon-pencil" href="#">Переименовать</a></li><li><a class="icon-trash" href="#">Удалить</a></li><li><a class="icon-block-1" href="#">Отмена</a></li><li class="other-desktop"><span class="title">Другие столы</span><a class="rename" href="#">Диспетчерская</a><span class="widgets-count">12 виджетов</span><a class="rename" href="#">Общение</a><span class="widgets-count">3 виджета</span></li><li class="dropdown-arr"></li><li><a class="icon-plus-1" href="#">Добавить рабочий стол</a></li></ul><i>(режим редактирования)</i></span></div><div class="col-md-3 col-md-offset-3 column"><button class="btn default-primary save" type="button">Сохранить изменения</button></div><div id="exit-edit" class="col-md-3 column"><a type="button" href="#">Выйти из режима редактирования</a></div></div><div class="row clearfix add-widget"><div class="col-md-9 col-md-offset-2 column"><a class="add-widget-btn" href="#"><span class="icon-plus-1"></span>Добавить виджет на рабочий стол</a></div></div>');
        $('.page.full').addClass('editing');
        widgets.append('<span class="icon-resize-full-alt" data-toggle="tooltip" data-placement="left" title="Перемещение виджета по рабочему столу зажав левую кнопку мыши"></span><span class="icon-resize-full" data-toggle="tooltip" data-placement="left" title="Изменение размера виджета зажав левую кнопку мыши на нижней и правой границе виджета"></span><span class="icon-cancel-circled" title="Удалить виджет"></span>');
        gridster.enable(widgets);
        gridster.enable_resize(widgets);


        $('.wrapper .widget a').on('click', function () {
            return false
        });


//save current position widgets

        $('.save').click(function () {

            var data = new Array();

            //var newdata = gridster.serialize(widgets);

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
                data: data
            });

            $('#exit-edit a').click();

        });


    })/*.data('gridster')*/;

//cancel
    $('#cancel-edit-current-desktop').bind('click', function () {

    });
// Exit edit-mode
    $('#exit-edit a').on('click',function () {
        //   $('.main-desktop-controls').html('<h3>Главный рабочий стол</h3>');
        $('.widget a').on('click', function () {
            document.location = this.href;
        });

        $('.wrapper').removeClass('editing');
        $('.edit-nav').hide();
        $('.icon-resize-full-alt, .icon-resize-full, .icon-cancel-circled').remove();
        gridster.disable(widgets);
        gridster.disable_resize(widgets);
    })/*.data('gridster');*/
    }
});

