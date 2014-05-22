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


  componentWillReceiveProps: (newProps, oldProps) ->
    @.setState(@.getInitialState(newProps))

  handleClick: (e) ->
    e.preventDefault()
    e.stopPropagation()
    console.log 'click'
    @.setState filter_popup_opened: !@.state.filter_popup_opened



  render: ->
    icon_css = 'fa fa-filter '
    icon_css += 'm-active' if @.state.filter_popup_opened



    filter_dom = if @.props.name == 'started_at'
                    [R.span({onClick: @.handleClick, className: icon_css}),
                    TasksTableHeaderFilterPopupStartedAt({ opened: @.state.filter_popup_opened, onPopupSubmit: @.onChangeFilterParams })]
                  else if @.props.name == 'title'
                    [R.span({onClick: @.handleClick, className: icon_css}),
                     TasksTableHeaderFilterPopupTitle({ opened: @.state.filter_popup_opened, onPopupSubmit: @.onChangeFilterParams })]
                  else if @.props.name == 'executors'
                    [R.span({onClick: @.handleClick, className: icon_css}),
                     TasksTableHeaderFilterPopupExecutor({ opened: @.state.filter_popup_opened, onPopupSubmit: @.onChangeFilterParams, filter_opts: @.props.filter_opts[@.props.name] })]

    R.span({className: 'table-filter'}, filter_dom)
