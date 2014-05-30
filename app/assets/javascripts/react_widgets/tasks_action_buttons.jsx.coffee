`/** @jsx React.DOM */`
R = React.DOM

@TasksActionButtons = React.createClass

  getDefaultProps: ->
    url: ''
    actions: []


  getInitialState: ->
    obj = {}
    return enable_actions: @.props.actions.map((action) -> obj[action] = false )



  render: ->
    console.log @.state
    R.div({},[
      R.a({href: '#', className: 'fa fa-play btn btn-default'}, '')
    ])