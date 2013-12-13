//DOM Ready
$(function(){ 
    $(".gridster ul").gridster({
        widget_margins: [10, 10],
        widget_base_dimensions: [140, 140],
        resize: {
            enabled: true 
        }
    }).data('gridster');

    var gridster = $(".gridster ul").gridster().data('gridster');

    gridster.disable($('.gridster ul li'));
    gridster.disable_resize($('.gridster ul li'));
// Add widget
    $('.add-widget-btn').live('click', function() {
		gridster.add_widget('<li class="new">The HTML of the widget...</li>', 1, 1);
	});	

// Remove widget
    gridster.$el
        .live('click', '.icon-cancel-circled', function() {
            gridster.remove_widget($(this).parent('li'));
    });
// Enter edit-mode
    $('#edit-current-desktop').bind('click', function(){
        $('.main-desktop-title').html(' <div class="row-fuild clearfix edit-nav"><div class="col-md-3 column"><span class="edit-mode clearfix dropdown"><a type="button" class="ajax-link" href="#" id="dropdownMenu1" data-toggle="dropdown">Главный рабочий стол</a><ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu2"><li><a class="icon-pencil" href="#">Переименовать</a></li><li><a class="icon-trash" href="#">Удалить</a></li><li><a class="icon-block-1" href="#">Отмена</a></li><li class="other-desktop"><span class="title">Другие столы</span><a class="rename" href="#">Диспетчерская</a><span class="widgets-count">12 виджетов</span><a class="rename" href="#">Общение</a><span class="widgets-count">3 виджета</span></li><li class="dropdown-arr"></li><li><a class="icon-plus-1" href="#">Добавить рабочий стол</a></li></ul><i>(режим редактирования)</i></span></div><div class="col-md-3 col-md-offset-3 column"><button class="btn default-primary save" type="button">Сохранить изменения</button></div><div id="exit-edit" class="col-md-3 column"><a type="button" href="#">Выйти из режима редактирования</a></div></div><div class="row clearfix add-widget"><div class="col-md-9 col-md-offset-2 column"><a class="add-widget-btn" href="#"><span class="icon-plus-1"></span>Добавить виджет на рабочий стол</a></div></div>');
        $('.main-desktop-title').removeClass('main-desktop-title').addClass('main-desktop-controls');
        $('.gridster li').append('<span class="icon-resize-full-alt" title="Перемещение виджета по рабочему столу зажав левую кнопку мыши"></span><span class="icon-resize-full" title="Изменение размера виджета зажав левую кнопку мыши на нижней и правой границе виджета"></span><span class="icon-cancel-circled" title="Удалить виджет"></span>');
        gridster.enable($('.gridster li'));
        gridster.enable_resize($('.gridster li'));
    }).data('gridster');
// Exit edit-mode
    $('#exit-edit a').live('click', function(){
        $('.main-desktop-controls').html('<h3>Главный рабочий стол</h3>');
        $('.main-desktop-controls').removeClass('main-desktop-controls').addClass('main-desktop-title');
        $('.icon-resize-full-alt, .icon-resize-full, .icon-cancel-circled').remove();
        gridster.disable($('.gridster ul li'));
        gridster.disable_resize($('.gridster ul li'));
    }).data('gridster');
});     