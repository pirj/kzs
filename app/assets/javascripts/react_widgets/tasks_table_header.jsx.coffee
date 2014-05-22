`/** @jsx React.DOM */`
R = React.DOM

@TasksTableHeader = React.createClass

  getInitialState: (props) ->
    props = props || this.props
    column_names: props.column_names || ['title']
    data: props.data || []
    filter_params: {}
    filter_opts: {}

  componentWillReceiveProps: (newProps, oldProps) ->
    @.setState(@.getInitialState(newProps))


  # формируем объект параметров фильтрации.
  # вместе собираются все параметры из всех фильтров
  onChangeFilterParams: (params) ->
    @.props.onChangeFilterParams(
      _.extend(@.state.filter_params, params)
    )

  translatedName: (title) ->
    I18n.t(title, { scope: 'tasks/tasks.table.headers'})

  render: ->

    render_data = @.state.column_names.map( (col_name) =>
      R.th({},
        R.span({}, @.translatedName(col_name)),
        TasksTableHeaderFilter({name: col_name, onChangeFilterParams: @.onChangeFilterParams, filter_opts: @.props.filter_opts})
      )
    )

    html = if render_data.length
      render_data
    else
      R.p({}, 'empty columns')

    R.thead({}, [
      R.tr({}, html)
    ])

