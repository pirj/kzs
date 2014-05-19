`/** @jsx React.DOM */`
R = React.DOM

@TasksTableHeader = React.createClass

  getInitialState: ->
    data: []
    column_names: ['title']


  getInitialState: (props) ->
    props = props || this.props
    column_names: props.column_names

  componentWillReceiveProps: (newProps, oldProps) ->
    @.setState(@.getInitialState(newProps))


  render: ->
    render_data = @.state.column_names.map( (col_name) =>
      R.td({},
        R.span({}, col_name),
        TasksTableHeaderFilter({name: 'filter'}) if col_name == 'start_date'
      )
    )

    html = if render_data.length
      render_data
    else
      R.p({}, 'empty columns')

    R.thead({}, [
      R.tr({}, html)
    ])

