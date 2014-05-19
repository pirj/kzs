`/** @jsx React.DOM */`
R = React.DOM

@TasksTableList = React.createClass

  getInitialState: ->
    data: [{title: 'hi'}]
    column_names: ['title']


  getInitialState: (props) ->
    props = props || this.props
    column_names: props.column_names
    data: props.data

  componentWillReceiveProps: (newProps, oldProps) ->
    @.setState(@.getInitialState(newProps))


  render: ->
    render_data = @.state.data.map((el) =>
      R.tr({className: 'vit-table-tr'},
        @.state.column_names.map((col_name) ->
          R.td({}, el[col_name])
        )
      )
    )

    R.tbody({}, render_data)

