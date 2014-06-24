`/** @jsx React.DOM */`
R = React.DOM

@TasksTableHeaderFilter = React.createClass

  getDefaultProps: ->
    name: ''
    data: []
    filter_opts: {}
    filter_popup_opened: false

  getInitialState: (props) ->
    props = props || this.props
    name: props.name
    data: props.data
    filter_popup_opened: props.filter_popup_opened


  # пробрасываем параметры из всплывающего окна наверх по цепочке зависимостей
  onChangeFilterParams: (params) ->
    @.props.onChangeFilterParams(
      params
    )


  onPopupCancel: (opened) ->
    @.setState filter_popup_opened: opened


  componentWillReceiveProps: (newProps, oldProps) ->
    @.setState(@.getInitialState(newProps))


  handleClick: (e) ->
    e.preventDefault()
    $(document).trigger('tasks_table:filter_popup:change_display')
    @.setState filter_popup_opened: !@.state.filter_popup_opened


  componentDidMount: ->
    $(document).on('tasks_table:filter_popup:change_display', (e) =>
      @.setState filter_popup_opened: false
    )

  render: ->
    icon_css = 'fa fa-filter '
    icon_css += 'm-active' if @.state.filter_popup_opened

    filter_component_params = { opened: @.state.filter_popup_opened, onPopupSubmit: @.onChangeFilterParams, onPopupCancel: @.onPopupCancel, filter_opts: @.props.filter_opts[@.props.name] }


    filter_dom = if @.props.name == 'started_at'
                    [R.span({onClick: @.handleClick, className: icon_css}),
                    TasksTableHeaderFilterPopupStartedAt(filter_component_params)]
                  else if @.props.name == 'title'
                    [R.span({onClick: @.handleClick, className: icon_css}),
                     TasksTableHeaderFilterPopupTitle(filter_component_params)]
                  else if @.props.name == 'executor'
                    [R.span({onClick: @.handleClick, className: icon_css}),
                     TasksTableHeaderFilterPopupExecutor(filter_component_params)]
                  else if @.props.name == 'inspector'
                    [R.span({onClick: @.handleClick, className: icon_css}),
                     TasksTableHeaderFilterPopupExecutor(filter_component_params)]

    R.span({className: 'table-filter'}, filter_dom)
