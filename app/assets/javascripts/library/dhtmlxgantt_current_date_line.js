gantt.templates.scale_cell_class = function(date){
    //gantt-timeline
    var time_now = new Date();
    var clean_dates = date.setHours(0, 0, 0, 0);

    if( clean_dates == time_now.setHours(0, 0, 0, 0)){
        console.log('B');
        return 'gantt-timeline';
    }

    //weekend day highlight
    if(date.getDay()==0||date.getDay()==6){
        console.log('A');
        return "weekend";
    }

};

gantt.templates.task_cell_class = function(item,date){
    if(date.getDay()==0||date.getDay()==6){
        return "weekend" ;
    }
};