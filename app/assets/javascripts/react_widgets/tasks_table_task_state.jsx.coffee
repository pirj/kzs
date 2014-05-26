`/** @jsx React.DOM */`
R = React.DOM

@TasksTableTaskState = React.createClass

  getDefaultProps: ->
    state_title: 'UFO'

  getInitialState: (props) ->
    props = props || this.props
    state_title: props.state_title


  componentWillReceiveProps: (newProps, oldProps) ->
    @.setState(@.getInitialState(newProps))




  translatedName: ->
    I18n.t(@.state.state_title, { scope: 'activerecord.tasks/task.state'})


  className: ->
    class_name = switch @.state.state_title
      when 'UFO' then 'label-default'
      when 'formulated' then 'label-warning'
      when 'activated' then 'label-blue'
      when 'paused' then 'label-gray'
      when 'executed' then 'label-success'
      when 'paused' then 'label-default'

    class_name += ' label'



  render: ->
    R.span({className: @.className()}, @.translatedName())

