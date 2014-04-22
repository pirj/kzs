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
#    updated_at: "2014-04-23T13:12:12Z"

class Gantt
  constructor: (dom) ->
#    gantt.config.scale_unit = "year" #задел на маштабирование
#    gantt.config.step = 1
#    gantt.config.date_scale = "%Y"
    gantt.init(dom)
    this.getJSON()

    gantt.attachEvent "onAfterTaskDelete", (id, item) ->
      request = $.ajax(
        url: '/api/tasks/' + id
        type: 'DELETE'
      )

      request.done (status) =>
        console.log (status)
        return

    gantt.attachEvent "onAfterTaskDrag", (id) ->
      newData = this.getTask(id)
      console.log newData
      taskData =
        tasks_task:
          finished_at: newData.end_date
          id: newData.id
          organization_id: 3
          started_at: newData.start_date
          text: "Paste\r\n"
          title: "Мазафака"

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

# start flow
$ ->
  if $('#gantt_here').length >0
    gantt = new Gantt("gantt_here")

