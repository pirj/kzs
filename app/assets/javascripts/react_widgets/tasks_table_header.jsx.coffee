`/** @jsx React.DOM */`
R = React.DOM

@TasksTableHeader = React.createClass

  getInitialState: (props) ->
    props = props || this.props
    column_names: props.column_names || ['title']
    data: props.data || []
    filter_params: {}

  componentWillReceiveProps: (newProps, oldProps) ->
    @.setState(@.getInitialState(newProps))


  # формируем объект параметров фильтрации.
  # вместе собираются все параметры из всех фильтров
  onChangeFilterParams: (params) ->
    @.props.onChangeFilterParams(
      _.extend(@.state.filter_params, params)
    )

  render: ->
    render_data = @.state.column_names.map( (col_name) =>
      R.td({},
        R.span({}, col_name),
        TasksTableHeaderFilter({name: 'filter', onChangeFilterParams: @.onChangeFilterParams}) if col_name == 'start_date'
      )
    )

    html = if render_data.length
      render_data
    else
      R.p({}, 'empty columns')

    R.thead({}, [
      R.tr({}, html)
    ])

