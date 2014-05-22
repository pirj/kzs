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

  formatData: (data) ->
    # если на сервере в БД не записано значение, то приходит в json значение null
    if data != null
      result = data
      # если передана дата в UTC, то преобразуем ее
      _date = new Date(data)
      unless isNaN(_date)
        result = moment(_date).format('L')

      return result

  render: ->
    render_data = @.state.data.map((el) =>
      R.tr({},
        @.state.column_names.map((col_name) =>
          R.td({}, @.formatData(el[col_name]))
        )
      )
    )

    R.tbody({}, render_data)

