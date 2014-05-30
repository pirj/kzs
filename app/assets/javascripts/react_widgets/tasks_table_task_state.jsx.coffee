`/** @jsx React.DOM */`
R = React.DOM

@TasksTableTaskState = React.createClass

  getDefaultProps: ->
    state_title: 'UFO'
    is_active: false

  getInitialState: (props) ->
    props = props || this.props
    state_title: props.state_title
    is_active: props.is_active


  componentWillReceiveProps: (newProps, oldProps) ->
    @.setState(@.getInitialState(newProps))




  translatedName: ->
    I18n.t(@.state.state_title, { scope: 'activerecord.tasks/task.state'})


  className: ->
    class_name = []
    class_name.push switch @.state.state_title
      when 'UFO' then 'label-default'
      when 'formulated' then 'label-orange '
      when 'activated' then 'label-blue'
      when 'paused' then 'label-gray'
      when 'executed' then 'label-green'
      when 'cancelled' then 'label-asphalt'

    class_name.push 'label'
    class_name.push 'm-label-active' if @.state.is_active

    class_name.join(' ')




  render: ->
    R.span({className: @.className()}, @.translatedName())

