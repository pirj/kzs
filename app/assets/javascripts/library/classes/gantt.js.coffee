#classes



class Gantt
  constructor: (dom) ->
#    gantt.config.scale_unit = "year" #задел на маштабирование
#    gantt.config.step = 1
#    gantt.config.date_scale = "%Y"
    gantt.init(dom)
#    this.addTasks(tasks)
    this.getJSON()
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