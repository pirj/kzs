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

  formatData: (col_name, obj) ->
    data = obj[col_name]
    # если на сервере в БД не записано значение, то приходит в json значение null
    if data != null
      result = data

      # если передана дата в UTC, то преобразуем ее
      _date = new Date(data)
      if !isNaN(_date) && col_name.search(/_at$|deadline/) > -1
        result = moment(_date).format('L')
      else if col_name.search(/title$|name$/) > -1
        result = R.a({href: "/tasks/#{obj.id}", className: 'link'}, data)
      else if col_name.search(/user|executor|approver|creator|inspector/) > -1
        title = try
                  data.title
                catch
                  ''
        result = R.a({href: '#', className: 'link link-dashed'}, title)

      else if col_name.search(/state|status/) > -1
        title = try
                  I18n.t(data, { scope: 'activerecord.tasks/task.state' })
                catch
                  ''
        result = R.span({className: 'label label-default'}, title)

      return result

  render: ->
    render_data = @.state.data.map((el) =>
      R.tr({},
        @.state.column_names.map((col_name) =>
          R.td({}, @.formatData(col_name, el))
        )
      )
    )

    R.tbody({}, render_data)

