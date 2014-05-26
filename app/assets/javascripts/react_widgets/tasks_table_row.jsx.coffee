`/** @jsx React.DOM */`
R = React.DOM

@TasksTableRow = React.createClass

  getDefaultProps: ->
    checked: false
    data: {}
    column_names: ['title']

  getInitialState: (props) ->
    props = props || this.props
    checked: props.checked
    data: props.data
    column_names: props.column_names

  componentWillReceiveProps: (newProps, oldProps) ->
    @.setState(@.getInitialState(newProps))


  formatData: (col_name) ->
    obj = @.state.data
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

  handleCheckboxChange: (e) ->
    console.log e.target

  render: ->
    render_data = R.tr({ref: 'row'},
        [
          R.td({}, R.input({type: 'checkbox', checked: @.state.checked, name: "task_#{@.state.data.id}", className: 'js-icheck-off', onChange: @.handleCheckboxChange})),
          @.state.column_names.map((col_name) =>
            R.td({}, @.formatData(col_name))
          )
        ]
      )

    render_data
