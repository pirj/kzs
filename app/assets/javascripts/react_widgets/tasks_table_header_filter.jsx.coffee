`/** @jsx React.DOM */`
R = React.DOM

@TasksTableHeaderFilter = React.createClass

  popup_nested_name: ''

  getDefaultProps: ->
    name: ''
    data: []
    filter_opts: {}
    filter_popup_opened: false

  getInitialState: (props) ->
    props = props || this.props
    data: props.data
    filter_popup_opened: props.filter_popup_opened


  # пробрасываем параметры из всплывающего окна наверх по цепочке зависимостей
  onChangeFilterParams: (params) ->
    @.props.onChangeFilterParams(
      params
    )


  handlePopupToggle: (current_popup_state) ->
    @.setState filter_popup_opened: current_popup_state


  componentWillReceiveProps: (newProps, oldProps) ->
    @.setState(@.getInitialState(newProps))


  handleClick: (e) ->
    e.preventDefault()


  componentDidMount: ->
    $el = $('<div></div>').appendTo('.js-popup-layout')

    @.popup_nested_name = "js-tasks-table-filter-popup-#{(new Date()).getTime()}"
    popup_nested_name_class_name = ".#{@.popup_nested_name}"

    filter_component_params = {
      parent: popup_nested_name_class_name,
      opened: @.state.filter_popup_opened,
      onPopupSubmit: @.onChangeFilterParams,
      onPopupToggle: @.handlePopupToggle,
      filter_opts: @.props.filter_opts[@.props.name]
    }

    popupClassName = @.choosePopupRenderer()
    if _.isFunction(popupClassName)
      React.renderComponent(popupClassName(filter_component_params), $el[0])


  choosePopupRenderer: ->
    if @.props.name == 'title'
      TasksTableHeaderFilterPopupTitleBeta
    else if @.props.name == 'started_at'
      TasksTableHeaderFilterPopupStartedAtBeta
    else if @.props.name == 'executor'
      TasksTableHeaderFilterPopupUsersBeta



  render: ->
    cx = React.addons.classSet
    icon_css = cx(
      'm-active': @.state.filter_popup_opened == true
      'fa fa-filter': true
    )

    icon_css += " #{@.popup_nested_name}"



    filter_dom = if ['title', 'started_at', 'executor', 'inspector'].indexOf(@.props.name) > -1
      [R.span({onClick: @.handleClick, className: icon_css})]

    R.span({className: 'table-filter'}, filter_dom)
