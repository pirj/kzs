gantt._render_task_control = function(task,width) {
    var control_container = document.createElement('div');
    control_container.className = 'gantt_task_control';
    control_container.innerHTML = '+';
    return control_container;

}

gantt._render_task_flags = function (task, width) {

    var flag_container = document.createElement('div');
    flag_container.className = "task_flag_container";
    // сколько чеклистов
    for (var i = 0; i < task.checklist_items.length; i++) {
        for (var j=0; j < task.checklist_items[i].length; j++){
            flag_container.appendChild(this._render_task_flag(task.checklist_items[i][j], task.start_date, width));
        }
    }
    return flag_container;
};

gantt._render_task_flag = function(flag, task_started_at, width) {

    var offset_left,  x_pos_end, x_pos_start;
    if (flag.finished_at===null) {
        x_pos_start = gantt.posFromDate(gantt.date.parseDate(task_started_at, 'xml_date')) ;
//        x_pos_end = gantt.posFromDate(gantt.date.parseDate(flag.finished_at, 'xml_date'));
        offset_left = width;
    }
    else
    {
         x_pos_end = gantt.posFromDate(gantt.date.parseDate(flag.finished_at, 'xml_date'));
            x_pos_start = gantt.posFromDate(gantt.date.parseDate(task_started_at, 'xml_date'));
         offset_left = x_pos_end-x_pos_start -1;
    }

    var div =document.createElement('div');
    div.className = "task_flag";
    if (flag.checked === true) {
       div.classList.add('f-checked')
    }
    if (flag.checked === false) {
        div.classList.add('f-unchecked')
    }
    div.style.cssText = [
        "left:" + offset_left + "px"
    ].join(";");
    return div;
}
/* @tag */


gantt._render_task_element = function(task){
    var pos = this._get_task_pos(task);

    var cfg = this.config;
    var height = this._get_task_height();
//    console.log(cfg)
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