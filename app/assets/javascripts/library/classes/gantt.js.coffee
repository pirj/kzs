tasks =
  data: [
    {
      id: 1
      text: "Project #1"
      start_date: "01-04-2013"
      duration: 11
      progress: 0.6
      open: true
    }
    {
      id: 2
      text: "Task #1"
      start_date: "03-04-2013"
      duration: 5
      progress: 1
      open: true
      parent: 1
    }
    {
      id: 3
      text: "Task #2"
      start_date: "02-04-2013"
      duration: 7
      progress: 0.5
      open: true
      parent: 1
    }
    {
      id: 4
      text: "Task #2.1"
      start_date: "03-04-2013"
      duration: 2
      progress: 1
      open: true
      parent: 3
    }
    {
      id: 5
      text: "Task #2.2"
      start_date: "04-04-2013"
      duration: 3
      progress: 0.8
      open: true
      parent: 3
    }
    {
      id: 6
      text: "Task #2.3"
      start_date: "05-04-2013"
      duration: 4
      progress: 0.2
      open: true
      parent: 3
    }
  ]



#classes



class Gantt
  constructor: (dom) ->
#    gantt.config.scale_unit = "year" #задел на маштабирование
#    gantt.config.step = 1
#    gantt.config.date_scale = "%Y"
    gantt.init(dom)
    this.addTasks(tasks)
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

    request.done (data) ->
      console.log data
      return

    request.fail (status) ->
      console.log('request failed ' + status)
      return

# start flow
$ ->
  if $('#gantt_here')>0

    gantt = new Gantt("gantt_here")