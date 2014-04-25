class Gantt
  constructor: (dom) ->
    that = this

    @.initCustomFields()           #определяем свои поля
#    that.resizeGant('year')
    gantt.init(dom)                                     #Инициализация модуля Гант

    @.getTasks()                                         #получение данных


    ########################################## далее обработчики событий ###############################################
    gantt.attachEvent "onAfterTaskDelete", (id, item) ->  #обработчик на удаление
      request = $.ajax(
        url: '/api/tasks/' + id
        type: 'DELETE'
      )

      request.done (status) =>
        console.log (status)
        return



#    gantt.attachEvent "onAfterTaskDrag", (id) ->     #обработчик на перетаскивание
#
#      data = @.getTask(id)
#      that.editTask(data, id)


#    gantt.attachEvent "onAfterTaskAdd", (id, item) ->    #обработчик на создание задачи
##      console.log(item)
#      that.createTask(item)

    gantt.attachEvent "onAfterTaskUpdate", (id, item) ->
#      console.log(item)
      that.editTask(item)

    $(document).on "click", "#month", ->
      that.resizeGant('month')
      return
    $(document).on "click", "#year", ->
      that.resizeGant('year')
      return
    $(document).on "click", "#day", ->
      that.resizeGant('day')
      return





  ############################################ далее методы класса ####################################################

  initCustomFields: () =>              #!!!

                                                                                   #колонки слева
    gantt.config.columns=[
      {name:"title",       label:"Заголовок",  tree:true, width:170 },
      {name:"start_date", label:"Начало", align: "center" },
      {name:"end_date",   label:"Окончание",   align: "center" }
      {name:"add" }
    ];

    gantt.templates.task_text = (start, end, task) ->                 #таск в таблице
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

  getTasks: () =>              #!!!

    $.ajaxSetup beforeSend: (xhr) ->
      xhr.setRequestHeader "X-CSRF-Token", $("meta[name=\"csrf-token\"]").attr("content")
      return

    request = $.ajax(
      url: '/api/tasks/'
      type: 'GET'
      dataType: "json"
#      data: (if type=='POST' then {'data': data} else '')
    )

    request.done (data) =>
      gantt.parse(data)
      return

    request.fail (status) ->
      console.log('request failed ' + status)
      return


  createTask: (data) =>           #!!!
    request = $.ajax(
      url: '/api/tasks/'
      type: 'POST'
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
#    @.getTasks()                    #TODO: нужен ли повторный запрос?
    gantt.render


  resizeGant: (scale) =>            #!!!
    gantt.config.scale_unit = scale #"year" #задел на маштабирование
    gantt.config.step = 1

    switch scale
      when 'year'
        b = '%Y'
      when 'month'
        b = '%m'
      when 'day'
        b = '%d'
      else

    gantt.config.date_scale = b #"%Y"
    gantt.render()
#    gantt.init($('#gantt_here'))

  addTask: (a) =>
    gantt.addTask(
      id: a.id
      title: a.title
      description: a.description
      start_date: a.start_date
#      end_date: JSON.parse(JSON.stringify(a.finished_at)).substring(0, 10)
      duration: a.duration
      )

#    gantt.render()
#    gantt.refreshTask(a.id)
#    console.log (JSON.parse(JSON.stringify(a.started_at))).substring(0, 10)

############################################ Поток выполнения  ###################################################
$ ->
  if $('#gantt_here').length >0
    window.app.ganttView = new Gantt("gantt_here")

#    console.log(window.app.ganttView)