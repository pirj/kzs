# constant and variables

url =
  meteo:
    spb: 'http://api.openweathermap.org/data/2.5/weather?id=498817&mode=json&units=metric'
    krn: 'http://api.openweathermap.org/data/2.5/weather?id=540771&mode=json&units=metric'
  positions: '/dashboard.json'

default_widgets= [
  {"col":1,"row":1,"size_x":1,"size_y":1,"name":"Документооборот","class":"widget-docs","href":"/documents"},
  {"col":2,"row":1,"size_x":1,"size_y":1,"name":"Пропуска","class":"widget-admission","href":"/permits"},
  {"col":3,"row":1,"size_x":1,"size_y":1,"name":"Организации и сотрудники","class":"widget-org","href":"/organizations"},
  {"col":4,"row":1,"size_x":1,"size_y":1,"name":"Библиотека","class":"widget-library disable"},
  {"col":5,"row":1,"size_x":1,"size_y":1,"name":"Охрана","class":"widget-security disable"},
  {"col":4,"row":3,"size_x":1,"size_y":1,"name":"Профиль","class":"widget-profile disable"},
  {"col":1,"row":2,"size_x":1,"size_y":1,"name":"Чат","class":" widget-chat disable"},
  {"col":5,"row":2,"size_x":2,"size_y":2,"name":"Погода","class":"widget-weather"},

]
# functions

requestFunc = (url, type, protect) ->

  if protect
    $.ajaxSetup beforeSend: (xhr) ->
      xhr.setRequestHeader "X-CSRF-Token", $("meta[name=\"csrf-token\"]").attr("content") #settings?
      return

  _request = $.ajax(
    url: url
    type: type
    dataType: "json"
  )
  _request

# objects

class Dashboard
  settings:
    widget_margins: [10, 10]
    widget_base_dimensions: [140, 140]
    max_size_x: 6
    max_cols: 6
    min_cols: 6
    resize:
      enabled: true
    avoid_overlapped_widgets: true
    autogenerate_stylesheet: true

  create: (dom) =>
    this.body = dom.gridster(
      this.settings
    ).data('gridster');

  constructor: (obj) ->
    obj

  serialize: =>
    this.body.serialize()

  addwidget: (widget) ->
    this.body.add_widget("<li class='"+widget.class+ " widget'>"+
    (if widget.href then "<a href='"+widget.href+"'>" else '')+'<span class="widget-name">' +
    widget.name+ '</span>'+(if widget.href then '</a>' else '')+'</li>', widget.size_x, widget.size_y,widget.col,widget.row)

  loading: =>
    that = this
    _.each default_widgets, (widget)->
      that.addwidget(widget)                                    #TODO: weater disable

  editon: =>
    console.log(this)
    this.body.enable()
    this.body.enable_resize()
    $('.widget a').on 'click', ->
      return false

  editoff: =>
    this.body.disable()
    this.body.disable_resize()

# start flow

$ ->
  dashboard = new Dashboard
  dashboard.create($(".gridster > ul"))
  dashboard.loading()
  dashboard.editoff()


  $('#edit-current-desktop').on 'click', dashboard.editon
