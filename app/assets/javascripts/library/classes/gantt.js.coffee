#classes

#wasd =
#  tasks_task:
##    created_at: "2014-04-18T14:03:27Z"
#    finished_at: "2014-04-29T00:00:00Z"
#    id: 1
#    organization_id: 3
#    started_at: "2014-04-14T00:00:00Z"
#    text: "Paste\r\n"
#    title: "Мазафака"
#    gantt.config.scale_unit = "year" #задел на маштабирование
#    gantt.config.step = 1
#    gantt.config.date_scale = "%Y"
#    updated_at: "2014-04-23T13:12:12Z"

class Gantt
  constructor: (dom) ->

    gantt.config.types["meeting"] = "type_id"           #определяем свой тип задач
    gantt.locale.labels["type_meeting"] = "Meeting"


    gantt.init(dom)                                     #Инициализация модуля Гант
    @.getJSON()                                         #получение данных

    @.initModal()


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
      console.log @
      data = @.getTask(id)

      that.editTask(data, id)

  ############################################ далее методы класса ####################################################
  initModal: () ->
    gantt.form_blocks["my_editor"] =
      render: (sns) ->
        "<div class='dhx_cal_ltext'>Заголовок&nbsp;<input type='text'><br/>Текст&nbsp;<input type='text'></div>"

      set_value: (node, value, task) ->
        node.childNodes[1].value = value or ""
        node.childNodes[4].value = task.users or ""
        return

      get_value: (node, task) ->
        task.users = node.childNodes[4].value
        node.childNodes[1].value

      focus: (node) ->
        a = node.childNodes[1]
        a.select()
        a.focus()
        return

    gantt.config.lightbox.sections = [
      {
        name: "description"
        height: 200
        map_to: "text"
        type: "my_editor"
        focus: true
      }
      {
        name: "time"
        height: 72
        type: "duration"
        map_to: "auto"
      }
    ]


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
#      console.log this
      this.addTasks(data)
      return

    request.fail (status) ->
      console.log('request failed ' + status)
      return

############################################ Поток выполнения  ###################################################
$ ->
  if $('#gantt_here').length >0
    gantt = new Gantt("gantt_here")

