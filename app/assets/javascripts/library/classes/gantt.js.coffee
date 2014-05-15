class Gantt
  constructor: (dom) ->
    that = this
    $.ajaxSetup beforeSend: (xhr) ->
      xhr.setRequestHeader "X-CSRF-Token", $("meta[name=\"csrf-token\"]").attr("content")
      return

    @.initCustomFields()                              #определяем свои поля
    gantt.init(dom)                                     #Инициализация модуля Гант
    @.getTasks()

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
#        console.log(data)

#        window.app.GanttView.displayPage(data);
        return

      request.fail (jqXHR, textStatus, errorThrown) ->
        console.log('request failed ' + textStatus)
        console.log(errorThrown)
        return

      e.preventDefault()


    gantt.attachEvent "onAfterTaskUpdate", (id, item) ->                                           #обработчик для перетаскиваний и растягиваний
      that.editTask(item)

      #----------------------------------------------- раздел для маштабирования
    $(document).on "click", "#month", ->
      that.resizeGant('month')
      return
    $(document).on "click", "#year", ->
      that.resizeGant('year')
      return
    $(document).on "click", "#day", ->
      that.resizeGant('day')
      return
    $(document).on "click", "#hour", ->
      that.resizeGant('hour')
      return


  ############################################ далее методы класса ####################################################

  initCustomFields: () =>              #!!!
    #колонки слева
    gantt.config.columns=[
      {name:"checkbox",       label:"",  tree:true, width:34 },
      {name:"title",       label:"Заголовок",  tree:true, width:170 },
      {name:"start_date", label:"Начало", align: "left" },
      {name:"inspector",   label:"Инспектор",   align: "left" },
      {name:"state",   label:"Статус",   align: "left" }
#      {name:"add" }
    ];
    #таск в таблице
    gantt.templates.task_text = (start, end, task) ->
      task.title
    # модальное окно
    gantt.locale.labels.section_title = "Заголовок"
    gantt.locale.labels.section_details = "Описание"
    gantt.locale.labels.section_period = "Дата"
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

#  createTask: (data) =>           #!!!
#    request = $.ajax(
#      url: '/api/tasks/'
#      type: 'POST'
#      dataType: "json"
#      data:
#        tasks_task: data
#    )
#
#    request.done (data) =>
#      gantt.render
#      return
#
#    request.fail (status) ->
#      console.log('request failed ' + status)
#      return

  editTask: (data) =>              #!!!
    request = $.ajax(
      url: '/api/tasks/'+data.id
      type: 'PUT'
      dataType: "json"
      data:
        tasks_task: data
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

    gantt.config.date_scale = b
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
#    modalContainer.empty()


########################################################### Поток выполнения  ###################################################
$ ->
  if $('#gantt_here').length
    window.app.GanttView = new Gantt("gantt_here")
