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
    data: props.data
    filter_popup_opened: props.filter_popup_opened


  # пробрасываем параметры из всплывающего окна наверх по цепочке зависимостей
  onChangeFilterParams: (params) ->
    @.props.onChangeFilterParams(
      params
    )


  handlePopupToggle: (current_popup_state) ->
    console.log 'income state', current_popup_state
    @.setState filter_popup_opened: current_popup_state


  componentWillReceiveProps: (newProps, oldProps) ->
    @.setState(@.getInitialState(newProps))


  handleClick: (e) ->
    e.preventDefault()
#    $(document).trigger('tasks_table:filter_popup:change_display')
#    @.setState filter_popup_opened: !@.state.filter_popup_opened


  componentDidMount: ->
#    $(document).on('tasks_table:filter_popup:change_display', (e) =>
#      @.setState filter_popup_opened: false
#    )
    $el = $('.js-popup-layout').append('<div></div>')
    filter_component_params = {
      parent: '.js-custom-popup',
      opened: @.state.filter_popup_opened,
      onPopupSubmit: @.onChangeFilterParams,
      onPopupToggle: @.handlePopupToggle,
      filter_opts: @.props.filter_opts[@.props.name]
    }

    @.React.renderComponent(TasksTableHeaderFilterPopupTitleBeta(filter_component_params), $el[0])

  render: ->
    console.log 'render state', @.state.filter_popup_opened
    cx = React.addons.classSet
    icon_css = cx(
      'm-active': @.state.filter_popup_opened == true
      'fa fa-filter js-custom-popup': true

    )

#    filter_component_params = { opened: @.state.filter_popup_opened, onPopupSubmit: @.onChangeFilterParams, onPopupCancel: @.handlePopupCancel, filter_opts: @.props.filter_opts[@.props.name] }


#    filter_dom = if @.props.name == 'started_at'
#                    [R.span({onClick: @.handleClick, className: icon_css}),
#                    TasksTableHeaderFilterPopupStartedAt(filter_component_params)]
#                  else if @.props.name == 'title'
#                    [R.span({onClick: @.handleClick, className: title_icon_css})]
##                     TasksTableHeaderFilterPopupTitle(filter_component_params)]
#                  else if @.props.name == 'executor'
#                    [R.span({onClick: @.handleClick, className: icon_css}),
#                     TasksTableHeaderFilterPopupExecutor(filter_component_params)]
#                  else if @.props.name == 'inspector'
#                    [R.span({onClick: @.handleClick, className: icon_css}),
#                     TasksTableHeaderFilterPopupExecutor(filter_component_params)]
    filter_dom = [R.span({onClick: @.handleClick, className: icon_css})]

    R.span({className: 'table-filter'}, filter_dom)
