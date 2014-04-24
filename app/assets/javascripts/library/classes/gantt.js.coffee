class Gantt
  constructor: (dom) ->

    @.initNewClass()           #определяем свой тип задач

    console.log gantt.config
    gantt.init(dom)                                     #Инициализация модуля Гант
    @.getJSON()                                         #получение данных

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
#      console.log @
      data = @.getTask(id)

      that.editTask(data, id)

  ############################################ далее методы класса ####################################################

  initNewClass: () ->
#    gantt.config.types["meeting"] = "type_id"
    gantt.config.types["meeting"] = "meeting"
    gantt.locale.labels["type_meeting"] = "Meeting"

#    console.log(gantt.config)

    gantt.locale.labels.section_title = "Subject"
    gantt.locale.labels.section_details = "Details"
    gantt.locale.labels.section_period = "Time period"
    gantt.config.lightbox["task_sections"] = [
      {
        name: "title"
        height: 20
        map_to: "text"
        type: "textarea"
        focus: true
      }
      {
        name: "details"
        height: 70
        map_to: "details"
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
      return "meeting_task"  if task.type is gantt.config.types.meeting
      ""

    gantt.templates.task_text = (start, end, task) ->
      return "Meeting: <b>" + task.text + "</b>"  if task.type is gantt.config.types.meeting
      task.text

    gantt.templates.rightside_text = (start, end, task) ->
      return task.text  if task.type is gantt.config.types.milestone
      ""



  editTask: (data, id) ->
    console.log data
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

  addTasks: (data) ->

#    _.each data.data, (task, key) ->                                          #преобразовываем все таски к новому типу
#      task.type = 'meeting'

    gantt.parse(data)

  getJSON: () ->
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
#      console.log data
      this.addTasks(data)
      return

    request.fail (status) ->
      console.log('request failed ' + status)
      return

############################################ Поток выполнения  ###################################################
$ ->
  if $('#gantt_here').length >0
    gantt = new Gantt("gantt_here")

