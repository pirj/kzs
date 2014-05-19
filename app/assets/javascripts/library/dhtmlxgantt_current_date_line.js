gantt.templates.scale_cell_class = function(date){
    var time_now = new Date("2014, 04, 16");
    var clean_dates = date.setHours(0, 0, 0, 0);

    if( clean_dates == time_now.setHours(0, 0, 0, 0)){
        return 'gantt-timeline';
    }

};
