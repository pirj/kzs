class Gantt
  constructor: (dom) ->

    @.initCustomFields()           #определяем свои поля

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

    that = this

    gantt.attachEvent "onAfterTaskDrag", (id) ->     #обработчик на перетаскивание

      data = @.getTask(id)
      that.editTask(data, id)


    gantt.attachEvent "onAfterTaskAdd", (id, item) ->    #обработчик на создание задачи
#      console.log(item)
      that.createTask(item)

  ############################################ далее методы класса ####################################################

  initCustomFields: () ->

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




  editTask: (data, id) ->
    taskData =
      tasks_task:
        finished_at: data.end_date
        id: data.id
        started_at: data.start_date
        text: "Paste\r\n"
        title: "Вася Рогов"

    request = $.ajax(
      url: '/api/tasks/' + id
      type: 'PUT'
      dataType: "json"
      data: taskData
    )

    request.done (status) =>
      console.log (status)
    return


  getTasks: () ->
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


  createTask: (data) ->
    request = $.ajax(
      url: '/api/tasks/'
      type: 'POST'
      dataType: "json"
      data: data
    )

    request.done (data) =>
#      this.createTasks(data)
      gantt.render
      return

    request.fail (status) ->
      console.log('request failed ' + status)
      return


  reloadGantt: () =>
#    @.getTasks()                    #TODO: нужен ли повторный запрос?
    gantt.render


############################################ Поток выполнения  ###################################################
$ ->
  if $('#gantt_here').length >0
    gantt = new Gantt("gantt_here")

