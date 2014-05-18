gantt._render_now_line = function (task, width) {
//    console.log(width)
// ;
//    console.log(task.started_at);

var flag_container = document.createElement('div');

// сколько чеклистов
for (var i = 0; i < task.checklist_items.length; i++) {


  for (var j=0; j < task.checklist_items[i].length; j++){
  flag_container.appendChild(this._render_task_flag(task.checklist_items[i][j], task.start_date));
}

}


return flag_container;

//
//    return document.createElement('p');
};