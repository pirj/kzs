gantt._render_task_control = function(task,width) {
    var control_container = document.createElement('div');
    control_container.className = 'gantt_task_control';
    control_container.innerHTML = '+';

    return control_container;

}

gantt._render_task_notifications = function (task, width) {

    var notifications_container = document.createElement('div');
    notifications_container.className = "task_notifications_container";
    var summe = 26; //здесь надо добавить кол-во оповещений для каждого таска
    notifications_container.innerHTML = '';

    return notifications_container;
};
gantt._render_task_flags = function (task, width) {


    //_.where(listOfPlays, {author: "Shakespeare", year: 1611});



    var flag_container = document.createElement('div');
    flag_container.className = "task_flag_container";
    // сколько чеклистов
    var compressFlags = [];
    if (task.checklists.length) {
        for (var i = 0; i < task.checklists.length; i++) {

            var Flags = task.checklists[i].checklist_items;
            compressFlags = (_.groupBy(Flags, 'deadline'));
            //для новых значений

            for (var j=0; j < task.checklists[i].checklist_items.length; j++){

                flag_container.appendChild(this._render_task_flag(task.checklists[i].checklist_items[j], task.start_date, width, compressFlags));

            }
        }

    }

    return flag_container;
};

gantt._render_task_flag = function(flag, task_started_at, width, json) {

    var offset_left,  x_pos_end, x_pos_start;
    if (flag.deadline===null) {
        x_pos_start = gantt.posFromDate(gantt.date.parseDate(task_started_at, 'xml_date')) ;
        offset_left = width;
    }
    else
    {
         x_pos_end = gantt.posFromDate(gantt.date.parseDate(flag.deadline, 'xml_date'));
            x_pos_start = gantt.posFromDate(gantt.date.parseDate(task_started_at, 'xml_date'));
         offset_left = x_pos_end-x_pos_start -1;
    }

    var div =document.createElement('div');
    div.title = flag.name;
    uniq_flag_class_name = (new Date()).getTime();
    div.className = "task_flag " + uniq_flag_class_name;

    if (flag.checked === true) {
       div.classList.add('f-checked')
    }
    if (flag.checked === false) {
        div.classList.add('f-unchecked')
    }
    div.style.cssText = [
        "left:" + offset_left + "px"
    ].join(";");

    // тут инициализируем react component и крепим его на popover-layout
    // json_of_all_flags — json всех пунктов в данном флажке
        $('.js-popover-layout').append("<div id="+uniq_flag_class_name+"></div>");

    elem = $('#'+uniq_flag_class_name)
        //    React.renderComponent(ReactPopoverComponent({parent: '.uniq_name' data: json_of_all_flags}), elem)

    // и флажку нужно выставить класс .uniq_name


    body = 'id: '+flag.id+', deadline: '+flag.deadline+', checked: '+flag.checked+', description: '+flag.description+', name: '+flag.name


//    var toggle_flag = function(status, parent){
//
//        console.log(a);
//
//        if (status==true){
//       $('.task_flag'+parent).addClass('active');
//        } else {
//            $('.task_flag'+parent).removeClass('active');
//
//        }
//
//    };

    var parent_class_name = '.' + uniq_flag_class_name;

    var current_flag_json = {
        data: json[flag.deadline],
        date: flag.deadline,
        task_id: flag.task_id
    };

    React.renderComponent(
        FlagPopover({parent: parent_class_name, json: current_flag_json}),
        elem[0]
    );
    return div;
};
/* @tag */
gantt._render_task_content = function(task, width){




    var select_task = function(a){


//        $(document).trigger('tasks_table:collection:uncheck_all');
//        var data = [];
//        data.push(task);


//
        if (a==true){

//            if (document.getElementsByName('task_'+task.id)[0].checked == false) {
//                $(document.getElementsByName('task_'+task.id)[0]).trigger('click');
//                return true
//            }

//        $(document).trigger('tasks_table:collection:change_checked', [task]);
//            var data = [task.id];
//            gantt.customSelect(data);
        }
          return true

    };
    var content = document.createElement("div");
    if(this._get_safe_type(task.type) != this.config.types.milestone)
        content.innerHTML = this.templates.task_text(task.start_date, task.end_date, task);



    var uniq_control_class_name = (new Date()).getTime() + 'control';
    content.className = "gantt_task_content " + uniq_control_class_name;

    var parent_class_name = '.' + uniq_control_class_name;
    $('.js-popover-layout').append("<div id="+uniq_control_class_name+"></div>");
    var elem = $('#'+uniq_control_class_name)
    React.renderComponent(
        GanttTaskSQPlus({parent: parent_class_name, body: 'body!', json: task, onPopoverToggle: select_task}),
        elem[0]
    );

    //content.style.width = width + 'px';
    return content;
};




gantt._render_task_element = function(task){
    var pos = this._get_task_pos(task);

    var cfg = this.config;
    var height = this._get_task_height();
    var padd = Math.floor((this.config.row_height - height)/2);
    if(task.type == cfg.types.milestone && cfg.link_line_width > 1){
        //little adjust milestone position, so horisontal corners would match link arrow when thickness of link line is more than 1px
        padd += 1;
    }

    var div = document.createElement("div");
    var width = gantt._get_task_width(task);

    var type = this._get_safe_type(task.type);

    div.setAttribute(this.config.task_attribute, task.id);
    //use separate div to display content above progress bar

    div.appendChild(gantt._render_task_notifications(task,width));
    div.appendChild(gantt._render_task_control(task,width));
    div.appendChild(gantt._render_task_content(task, width));


//    ADDDEDDDD @TAGIR


    div.appendChild(gantt._render_task_flags(task, width));
    div.className = this._combine_item_class("gantt_task_line",
        this.templates.task_class(task.start_date, task.end_date, task),
        task.id);


    div.style.cssText = [
        "left:" + pos.x + "px",
        "top:" + (padd + pos.y) + 'px',
        "height:" + height + 'px',
        "line-height:" + height + 'px',
        "width:" + width + 'px'
    ].join(";");

    var side = this._render_leftside_content(task);
    if(side) div.appendChild(side);

    side = this._render_rightside_content(task);
    if(side) div.appendChild(side);

    if(cfg.show_progress && type != this.config.types.milestone){
        this._render_task_progress(task,div, width);
    }


    if(!this.config.readonly){
        if(cfg.drag_resize && !this._is_flex_task(task) && type != this.config.types.milestone){
            gantt._render_pair(div, "gantt_task_drag", task, function(css){
                var el = document.createElement("div");
                el.className = css;
                return el;
            });
        }
        if(cfg.drag_links){
            gantt._render_pair(div, "gantt_link_control", task, function(css){
                var outer = document.createElement("div");
                outer.className = css;
                outer.style.cssText = [
                    "height:" + height + 'px',
                    "line-height:" + height + 'px'
                ].join(";");
                var inner = document.createElement("div");
                inner.className = "gantt_link_point";
                outer.appendChild(inner);
                return outer;
            });
        }
    }
    return div;
};


gantt.customSelect = function(scope){


    function select(id) {

        if (id) {
            if(id.id){
                $('.gantt_task_row[task_id='+id.id+']').addClass('gantt_selected');
            } else {
                $('.gantt_task_row[task_id='+id+']').addClass('gantt_selected');
            }

        }

    }

    $('.gantt_task_row').removeClass('gantt_selected');
    _.each(scope, function(id){ select(id); });

    return true
};
