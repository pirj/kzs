`/** @jsx React.DOM */`
R = React.DOM

@TasksAddSubtask = React.createClass
  getDefaultProps: ->
    opened: false


  getInitialState: (props) ->
    props = props || this.props
    {liked: props.opened}

  handleClick: ->
    console.log 'click'

    this.setState({opened: !this.state.opened});

  translatedName: ->
    I18n.t(@.state.state_title, { scope: 'activerecord.tasks/task.state'})



  render: ->
    status = 'btn ' +
    (if this.state.opened
      'opened'
    else 'closed')

    popup_status = 'popup ' +
    (if this.state.opened
      ''
    else 'hidden')

    button = R.span({className: status, onClick: @handleClick}, 'Добавить подзадачу')
    popup = R.div({className: popup_status}, 'wasd')
    R.div(className: ' ', [button, popup])