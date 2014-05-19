`/** @jsx React.DOM */`
R = React.DOM

@TasksTableHeaderFilterPopup = React.createClass

  getInitialState: ->


  getInitialState: (props) ->
    props = props || this.props

  componentWillReceiveProps: (newProps, oldProps) ->
    @.setState(@.getInitialState(newProps))

  render: ->
    R.span({}, 'filter popup')

