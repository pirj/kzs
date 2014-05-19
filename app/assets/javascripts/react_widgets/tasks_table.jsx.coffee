`/** @jsx React.DOM */`
R = React.DOM

@TasksTable = React.createClass

  getDefaultProps: ->
    url: '/api/tasks'

  getInitialState: ->
    data: []

  componentWillMount: ->
    $.ajax
      url: @props.url
      dataType: "json"
      success: ((data) ->
        @setState data: data['data']
        return
      ).bind(this)
      error: ((xhr, status, err) ->
        console.error @props.url, status, err.toString()
        return
      ).bind(this)



  render: ->

    render_data = @.state.data.map( (el) ->
      R.p({}, [
        R.span({}, el.title),
        R.span({}, el.checked),
        R.span({}, el.start_date),
        R.span({}, el.duration),
      ])
    )

    console.log JSON.stringify(@.state.data)
    R.div({className: 'vit-class'}, [
      R.p({}, @.props.name),
      R.p({}, @.props.url),
      { render_data }
    ])
