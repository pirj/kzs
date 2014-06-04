`/** @jsx React.DOM */`
R = React.DOM

@TasksTableList = React.createClass

  getDefaultProps: ->
    data: [{title: 'hi'}]
    column_names: ['title']
    checked_all: false


  getInitialState: (props) ->
    props = props || this.props
    column_names: props.column_names
    original_data: props.data
    data: @.formatData(props.data)
    checked_all: props.checked_all

  formatData: (data) ->
    console.log _.groupBy(data, (attr) ->
      attr.parent_id
    )
    _.map(data, (el) ->
      {
        id: el.id
        data: el
        checked: false
      }
    )

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


  componentWillReceiveProps: (newProps, oldProps) ->
    @.setState(@.getInitialState(newProps))


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

  getSubtasks: (id) ->
    collection = _.findWhere(@.props.subtasks, {id: id})
    unless collection == undefined
      collection.subtasks
    else
      []



  render: ->
    window.arr = @.state.data

    render_data = @.state.data.map((el) =>
      [
        TasksTableRow({column_names: @.state.column_names, data: el, checked: el.data.checked, opened: el.data.opened, checked_row: @.handleRowCheck, type: 'root', on_opened: @.handleQuerySubtasks }),
        @.getSubtasks(el.id).map((sub_el) =>
          TasksTableRow({column_names: @.state.column_names, data: sub_el, checked: el.checked, type: 'sub', checked_row: @.handleRowCheck })
        )
      ]
    )

    R.tbody({ref: 'task_rows'}, render_data)


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

