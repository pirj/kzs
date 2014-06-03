class Gantt
  constructor: (dom, id) ->
    that = this
    @.gantt = gantt
    $.ajaxSetup beforeSend: (xhr) ->
      xhr.setRequestHeader "X-CSRF-Token", $("meta[name=\"csrf-token\"]").attr("content")
#      console.log 'xhr.setRequestHeader "X-CSRF-Token", $("meta[name=\"csrf-token\"]").attr("content")'
#      console.log $("meta[name=\"csrf-token\"]").attr("content")

      return

    @.initCustomFields()                              #определяем свои поля
    gantt.init(dom)
                                       #Инициализация модуля Гант
    if id
      @.getTask(id)
    else
      $(document).on "tasks_table:collection:update_data", (e, data) ->
        gantt.clearAll()
        gantt.parse({data: data})

    @.createTimeline()

    ########################################## далее обработчики событий ###############################################

    gantt.attachEvent "onAfterTaskDelete", (id, item) ->                                        #обработчик на удаление
      request = $.ajax(
        url: '/api/tasks/' + id
        type: 'DELETE'
      )

      request.done (status) =>
        console.log (status)
        return

    gantt.attachEvent "onTaskDblClick", (id, e) ->                                                 #двойной клик
      e.preventDefault()
      request = $.ajax(
        url: "/tasks/#{id}/"
        type: 'GET'
        dataType: "script"
      )

      request.done (data, textStatus, jqXHR) =>
#        window.app.GanttView.displayPage(data);
        return

      request.fail (jqXHR, textStatus, errorThrown) ->
        console.log('request failed ' + textStatus)
        console.log(errorThrown)
        return
      e.preventDefault()

    gantt.attachEvent "onAfterTaskUpdate", (id, item) ->                                           #обработчик для перетаскиваний и растягиваний
      that.editTask(item)

    gantt.attachEvent "onBeforeTaskSelected", (id,item) ->
      return false
    gantt.attachEvent "onMouseMove", (taskId, e) ->
      if taskId!=null and e.target.classList.contains('gantt_task_content')
        control = e.target.previousElementSibling
        control.style.display = 'block'
        left = e.offsetX
        control.style.left = left + 'px'

        e.target.onmouseout = (e) ->
          control.style.display = 'none'
        e.target.onclick = (e) ->
          task = gantt.getTask(taskId)
          delta = Math.floor(left/gantt.config.min_column_width)
          need = gantt.calculateEndDate(task.start_date,delta,gantt.config.scale_unit)
          console.log(need)


      #----------------------------------------------- раздел для маштабирования
    $(document).on "click", "#month", ->
      gantt.config.step = 1;
      gantt.config.show_grid = false;
      gantt.config.date_scale = "%F %Y";
      gantt.config.subscales = [
        {unit:"day", step:1, date:"%d"}
      ];
      that.resizeGant('month')
      return
    $(document).on "click", "#year", ->

      gantt.config.subscales = []
      gantt.config.scale_unit = "month";
      gantt.config.date_scale = "%Y"
      that.resizeGant('year')
      return
    $(document).on "click", "#day", ->
      gantt.config.step = 1;
      gantt.config.date_scale = "%d %F"
      gantt.config.subscales = [
        {unit:"hour", step:1, date:"%h"}
      ];
      that.resizeGant('day')
      return
    $('#gantt_here .gantt_data_area').on 'scroll', (e) ->
      y = $(this)[0].scrollTop
      window.app.scrollTable(y)

    $(document).on "tasks_table:collection:update_subtasks", (e, id, data) =>


      console.log [data]
      console.log 'wasd'

      console.log id
      @.gantt.parse({data: [data[0]]})
      @.gantt.open(id)


      ############################################ далее методы класса ####################################################

  initCustomFields: () =>              #!!!
    #колонки слева
    gantt.config.columns=[
#      {name:"checkbox",       label:"",  tree:true, width:34 },
      {name:"title",       label:"Заголовок",  tree:true, width:170 },
      {name:"start_date", label:"Начало", align: "left", width:170 },
      {name:"inspector",   label:"Инспектор",   align: "left", width:170 },
      {name:"state",   label:"Статус",   align: "left", width:170 }
    ];
    gantt.config.task_height = 6;
    gantt.config.min_column_width = 54
    gantt.config.scale_unit = "month";
    gantt.config.step = 1;
    gantt.config.show_grid = false;
    gantt.config.date_scale = "%F %Y";
    gantt.config.subscales = [
      {unit:"day", step:1, date:"%d"}
    ];

    #таск в таблице
    gantt.templates.task_text = (start, end, task) ->
      ''

    # модальное окно
    gantt.locale.labels.section_title = "Заголовок"
    gantt.locale.labels.section_details = "Описание"
    gantt.locale.labels.section_period = "Дата"
    gantt.config.drag_move = false;
    gantt.config.show_links = false;
    gantt.config.drag_progress = false;
    gantt.config.drag_links = false;
    gantt.config.drag_resize = false;
    gantt.config.lightbox["task_sections"] = [
      {
        name: "title"
        height: 30
        map_to: "title"
        type: "textarea"
        focus: true
      }
      {
        name: "details"
        height: 70
        map_to: "description"
        type: "textarea"
        focus: true
      }
      {
        name: "period"
        height: 72
        type: "time"
        map_to: "auto"
      }
    ]

    gantt.templates.task_class = (start, end, task) ->
      task.state

  createTimeline: ->
    gantt.attachEvent "onGanttRender", ->
      $(".gantt-timeline").append "<div class=\"js-gantt-timeline\"><div class=\"js-gantt-timeline-label\">Сегодня</div></div>"
      return
    return

  getTasks: () =>             #получение данных  (и парсинг)
    request = $.ajax(
      url: '/api/tasks/'
      type: 'GET'
      dataType: "json"
    )

    request.done (data) ->
      gantt.parse(data)
      return

    request.fail (status) ->
      console.log('request failed ' + status)
      return

  getTask: (id) =>
    request = $.ajax(
      url: '/api/tasks/'+id
      type: 'GET'
      dataType: "json"
    )
    request.done (data) ->
      gantt.parse({data: [data.task]})
      return

    request.fail (status) ->
      console.log('request failed ' + status)
      return

  editTask: (data) =>              #!!!
#    console.log(data)
    request = $.ajax(
      url: '/api/tasks/'+data.id
      type: 'PUT'
      dataType: "json"
      data:
        authenticity_token: $("meta[name=\"csrf-token\"]").attr("content")
        task:
          finished_at: data.finished_at
          started_at: data.started_at
    )

    request.done (data) =>
      gantt.render
      return

    request.fail (status) ->
      console.log('request failed ' + status)
      return

  reloadGantt: () =>
    @.getTasks()                    #TODO: нужен ли повторный запрос?
    gantt.render

  resizeGant: (scale) =>
    gantt.config.scale_unit = scale
    gantt.config.step = 1

    switch scale
      when 'year'
        b = '%Y'
      when 'month'
        b = '%m'
      when 'day'
        b = '%d'
      when 'hour'
        b = '%H'
      else

    gantt.render()

  addTask: (a) =>
    gantt.addTask(
      id: a.id
      title: a.title
      description: a.description
      start_date: a.start_date
      duration: a.duration
      )

  displayForm: (form) =>
    # запиливаем пришедшую форму в модальное окно
    $modalContainer = $("#taskForm")
    $formContainer = $(".js-new-task")
    $formContainer.html form
    $("<button type='button' class='btn btn-default' data-dismiss='modal'>Отмена</button>").appendTo ".js-buttons-place"
    $modalContainer.modal 'show'
    $(".modal-backdrop.in").hide()
    $formContainer.find(".js-datepicker").datepicker global.datepicker
    $(".js-chosen").chosen global.chosen

  displayPage: (page) =>
    $modalContainer = $("#taskForm")
    $formContainer = $(".js-new-task")
    $formContainer.html page

    $("<button type='button' class='btn btn-default' data-dismiss='modal'>Отмена</button>").appendTo ".js-buttons-place"
    $modalContainer.modal 'show'

    $(".modal-backdrop.in").hide()
    $('input[type="checkbox"], input[type="radio"]').not('.js-icheck-off input, .js-icheck-off').iCheck(
      checkboxClass: 'icheckbox_flat-green checkbox-inline'
      radioClass: 'iradio_flat-green radio-inline'
      disabledClass: 'js-ichecked-input'
    )

  clearForm: () =>
    $modalContainer = $("#taskForm")
    $modalContainer.modal 'hide'

  scrollY: (y) =>
    $('#gantt_here .gantt_data_area').scrollTop(y)

  modSampleHeight:  =>
    headHeight = 200
    table = document.getElementsByClassName("js-tasks-table")[0]
    sch = document.getElementById("gantt_here")
    sch.style.height = document.documentElement.clientHeight - $(table).offset().top

    table.style.height = sch.style.height

    gantt.setSizes()
    return

########################################################### Поток выполнения  ###################################################
$ ->
  if $('#gantt_here').length
    window.app.GanttView = new Gantt("gantt_here")

  if $('#gantt_here_local').length
    dom  = $('#gantt_here_local')
    id = dom.data('gantt')
    window.app.GanttView = new Gantt("gantt_here_local", id)