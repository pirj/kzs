`/** @jsx React.DOM */`
R = React.DOM

@TasksTable = React.createClass

  getDefaultProps: ->
    url: '/api/tasks'

  getInitialState: ->
    data: []
    search_params: {}

  getDataFromServer: ->
    $.ajax
      url: @props.url
      dataType: "json"
      data:
        q: @.state.search_params
      success: ((data) ->
        @setState data: data['data']
        return
      ).bind(this)
      error: ((xhr, status, err) ->
        console.error @props.url, status, err.toString()
        return
      ).bind(this)

  componentWillMount: ->
    @.getDataFromServer()


  onChangeSearchParams: (params) ->
    console.log window.app=params
    @.state = search_params: params
    @.getDataFromServer()



  render: ->

    render_data = @.state.data.map( (el) ->
      R.p({}, [
        R.span({}, el.title),
        R.span({}, el.checked),
        R.span({}, el.start_date),
        R.span({}, el.duration),
      ])
    )

    column_names = ['title', 'start_date', 'duration']

    R.table({className: 'vit-table'}, [
      TasksTableHeader({column_names: column_names, onChangeFilterParams: @.onChangeSearchParams}),
      TasksTableList({column_names: column_names, data: @.state.data})
])
