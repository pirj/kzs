`/** @jsx React.DOM */`
R = React.DOM

@TasksTableHeaderFilter = React.createClass

  getInitialState: (props) ->
    props = props || this.props
    name: props.name || 'filter'
    data: props.data || []
    filter_popup_opened: false

  # пробрасываем параметры из всплывающего окна наверх по цепочке зависимостей
  onChangeFilterParams: (params) ->
    @.props.onChangeFilterParams(
      params
    )


  componentWillReceiveProps: (newProps, oldProps) ->
    @.setState(@.getInitialState(newProps))

  iconClick: ->
    @.setState filter_popup_opened: !@.state.filter_popup_opened

  render: ->
    R.span({}, [
      R.span({onClick: @.iconClick}, @.state.name),
      TasksTableHeaderFilterPopup({ opened: @.state.filter_popup_opened, onPopupSubmit: @.onChangeFilterParams })
    ])
