`/** @jsx React.DOM */`
R = React.DOM

@TasksTableHeaderFilter = React.createClass

  getDefaultProps: ->
    name: 'filter'
    data: []
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
    state_txt = if @.state.filter_popup_opened then 'opened' else 'hidden'
    text = "#{@.state.name} --> #{state_txt}"
    R.span({className: 'table-filter'}, [
      R.span({onClick: @.handleClick, className: icon_css}),
      TasksTableHeaderFilterPopup({ opened: @.state.filter_popup_opened, onPopupSubmit: @.onChangeFilterParams })
    ])
