# constant and variables

url =
  meteo:
    spb: 'http://api.openweathermap.org/data/2.5/weather?id=498817&mode=json&units=metric'
    krn: 'http://api.openweathermap.org/data/2.5/weather?id=540771&mode=json&units=metric'
  positions: '/dashboard.json'
  save: '/save_desktop_configuration'

default_widgets= [
  {"col":1,"row":1,"size_x":1,"size_y":1,"name":"Документы","class":"widget-docs","href":"/documents"},
  {"col":2,"row":1,"size_x":1,"size_y":1,"name":"Пропуска","class":"widget-admission","href":"/permits"},
  {"col":3,"row":1,"size_x":1,"size_y":1,"name":"Организации и сотрудники","class":"widget-org","href":"/organizations"},
  {"col":4,"row":1,"size_x":1,"size_y":1,"name":"Библиотека","class":"widget-library disable"},
  {"col":5,"row":1,"size_x":1,"size_y":1,"name":"Охрана","class":"widget-security disable"},
  {"col":4,"row":3,"size_x":1,"size_y":1,"name":"Профиль","class":"widget-profile disable"},
  {"col":1,"row":2,"size_x":1,"size_y":1,"name":"Чат","class":" widget-chat disable"},
  {"col":5,"row":2,"size_x":2,"size_y":2,"name":"Погода","class":"widget-weather","meteo":""},

]
template =
  widget: "<li class='{{class}} widget'>{{#href}}<a href='{{href}}'>{{/href}}<span class='widget-name'>{{name}}</span>{{#href}}</a>{{/href}}</li>"
# functions

weather = {

}

sendRequest = (url, type, protect, data) ->

  if protect
    $.ajaxSetup beforeSend: (xhr) ->
      xhr.setRequestHeader "X-CSRF-Token", $("meta[name=\"csrf-token\"]").attr("content") #settings?
      return

  _request = $.ajax(
    url: url
    type: type
    dataType: "json"
    data: (if type=='POST' then {'data': data} else '')
  )

  _request                       #TODO: done - need?

# Classes

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

  constructor: (dom) ->
    this.body = dom.gridster(     #body == object gridster || widgets == grister.widgets
      this.settings
    ).data('gridster')
    this.loading()
    this.editoff()

  save: =>
    newData = (this.body.serialize()) #JSON.stringify

    _.each default_widgets, (a) ->

    _.each newData, (widget, wKey) ->
      _.each widget, (prop, key) ->
        default_widgets[wKey][key] = prop

    sendRequest(url.save, 'POST', true, JSON.stringify(default_widgets))

    this.editoff()
    (callback = () ->
      $('.js-btns .btn').toggle()
    )()

  addwidget: (widget) ->

    html = Mustache.to_html(template.widget, widget)
    this.body.add_widget(html, widget.size_x,widget.size_y,widget.col,widget.row)

  get: (n) =>                   #n  - number dashboard
    $.when(sendRequest(url.positions, 'GET', true))#.then (data, textStatus) ->

  loading: =>
    that = this

    $.when(sendRequest(url.positions, 'GET', true)).then (data, textStatus) ->

      if data.desktop_conf is null
        a = default_widgets
      else
        a = data.desktop_conf
      _.each a, (widget)->
        that.addwidget(widget)

      _.each that.body.$widgets, (w) ->

        if w.classList.contains('widget-weather')

          weather.widget = w



    (->
      $('.js-btns .js-dashboard-save').hide()
      $('.js-btns .js-dashboard-cancel').hide()
    )()
                  #TODO: weater disable

  editon: =>

    this.body.enable()
    this.body.enable_resize()
    $('.widget a').on 'click', (e) ->
      e.preventDefault()
      #return false

    (callback = () ->
      $('.js-btns .btn').toggle()
    )()

    $('h1').html('Режим редактирования')
    #console.log(this.body.$widgets[7])
    #this.body.disable_resize(this.body.$widgets[7]);
  editoff: =>

    this.body.disable() if $(".gridster > ul")
    this.body.disable_resize() if this.body.disable_resize()
    $('h1').html('Главный рабочий стол')


    $('.widget a').on 'click', (e) ->
      console.log(this.href)
      document.location = this.href
  cancel: =>

    this.editoff()
    (callback = () ->
      $('.js-btns .btn').toggle()
    )()
# start flow
$ ->

  if document.location.pathname == "/"
    dashboard = new Dashboard($(".gridster > ul"))
#   dashboard.loading()
#   dashboard.editoff()
    $('.js-dashboard-edit').on 'click', dashboard.editon
    $('.js-dashboard-save').on 'click', dashboard.save
    $('.js-dashboard-cancel').on 'click', dashboard.cancel