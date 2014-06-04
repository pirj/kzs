`/** @jsx React.DOM */`
R = React.DOM

@TasksTableList = React.createClass

  data: []

  getDefaultProps: ->
    data: []
    column_names: ['title']
    checked_all: false


#  getInitialState: ->


  formatData: (data) ->
    console.log data
    if data.length
      formatedData = _.groupBy(data, (attr) ->
        attr.parent_id
      )
      console.log formatedData || []
  #    _.map(data, (el) ->
  #      {
  #        id: el.id
  #        data: el
  #        checked: false
  #      }
  #    )
      formatedData
    else
      data

  handleRowCheck: (id) ->
    # копируем коллекцию и работаем с копией,
    # обновляя в ней атрибуты нужных нам объектов
    new_data = @.state.data
    finded_obj = _.findWhere(new_data,{id: id})
    i = new_data.indexOf(finded_obj)
    new_data[i].checked = !new_data[i].checked

    @.changeCheckedRows(new_data)

    @.setState data: new_data


  # метод создания ивента с чекнутыми задачами
  # фильтрует задачи только сортированными
  # в событии передает коллекцию чекнутых объектов
  changeCheckedRows: (data) ->
    # фильтруем только те задачи, которые имеют checked: true
    checked = _.where(data, {checked: true})
    $(document).trigger('tasks_table:collection:change_checked', [checked])
    checked


#  componentWillReceiveProps: (newProps, oldProps) ->
#    @.setState(@.getInitialState(newProps))


  # обрабатываем выделение всех строк
  # обрабатываем копию данных
  # бросаем событие «строки чекнуты»
  # меняем статус,что приводит к перерисовке
  checkAllRows: ->
    new_data = _.map(@.state.data, (el) =>
      el.checked = !@.state.checked_all
      el
    )

    @.changeCheckedRows(new_data)

    @.setState
      data: new_data
      checked_all: !@.state.checked_all



  componentDidMount: ->
    $(document).on('tasks_table:collection:check_all', (e) =>
      @.checkAllRows()
    )

    $(document).on('tasks_table:collection:change_checked', (e, data) ->
      data
    )

  componentWillReceiveProps: (newProps, oldProps) ->
    data = newProps.data
    @.data = _.groupBy(data, (obj) ->
      obj.parent_id
    )

    console.log @.data


  render_task_with_subtasks: (obj) ->
    subtasks = if @.data.hasOwnProperty(obj.id) then @.data[obj.id] else []
    console.log subtasks
    # нужна рекурсия в отрисовке
    [
      TasksTableRow({column_names: @.props.column_names, data: obj, checked: obj.checked, opened: obj.opened, checked_row: @.handleRowCheck, type: 'root', on_opened: @.handleQuerySubtasks }),
      subtasks.map((sub_el) =>
#        TasksTableRow({column_names: @.state.column_names, data: sub_el, checked: el.checked, type: 'sub', checked_row: @.handleRowCheck })
        R.tr({}, R.td({colSpan: @.props.column_names.length}, 'подзадачи есть'))
      )
    ]

  render: ->
    unless _.keys(@.data).length
      rows = R.tr({}, R.td({colSpan: @.props.column_names.length},'данные загружаются...'))
    else
      collection = @.data['null']
      rows = collection.map((obj) =>
        @.render_task_with_subtasks(obj)
      )

#    render_data = @.state.data.map((el) =>
#      console.log el
#      [
#        TasksTableRow({column_names: @.state.column_names, data: el, checked: el.data.checked, opened: el.data.opened, checked_row: @.handleRowCheck, type: 'root', on_opened: @.handleQuerySubtasks }),
#        @.getSubtasks(el.id).map((sub_el) =>
#          TasksTableRow({column_names: @.state.column_names, data: sub_el, checked: el.checked, type: 'sub', checked_row: @.handleRowCheck })
#        )
#      ]
#    )

    R.tbody({ref: 'task_rows'}, rows)


###

  obj:{
    id: 5
    data: {}
    checked: true
  }

  obj = _.findWhere(arr, {id: 5})
  i = arr.indexOf(obj)
  obj[i].checked = true

###

