`/** @jsx React.DOM */`
R = React.DOM

@TasksTableHeaderFilter = React.createClass

  getInitialState: ->
    data: []
    name: 'filter'


  getInitialState: (props) ->
    props = props || this.props
    name: props.name

  componentWillReceiveProps: (newProps, oldProps) ->
    @.setState(@.getInitialState(newProps))

  iconClick: ->
    console.log 'click'
    @.setState filter_popup_opened: !@.state.filter_popup_opened

  render: ->
    R.span({}, [
      R.span({onClick: @.iconClick}, @.state.name),
      TasksTableHeaderFilterPopup()
    ])

