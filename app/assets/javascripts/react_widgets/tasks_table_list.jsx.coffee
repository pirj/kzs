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
    data: props.data
    checked_all: props.checked_all


  componentWillReceiveProps: (newProps, oldProps) ->
    @.setState(@.getInitialState(newProps))


  render: ->

    render_data = @.state.data.map((el) =>
      TasksTableRow({column_names: @.state.column_names, data: el, checked: @.state.checked_all})
    )

    R.tbody({ref: 'task_rows'}, render_data)

