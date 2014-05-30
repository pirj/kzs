`/** @jsx React.DOM */`
R = React.DOM

@TasksTable = React.createClass

  getDefaultProps: ->
    url: '/api'
    filter_opts: {}

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
        data = data['data']
        $(document).trigger('tasks_table:collection:update_data', [data])
        @setState data: data
        return
      ).bind(this)
      error: ((xhr, status, err) ->
        console.error @props.url, status, err.toString()
        return
      ).bind(this)

  componentWillMount: ->
    @.getDataFromServer()

    $(document).on('tasks_actions:update_success', => @.getDataFromServer())


  onChangeSearchParams: (params) ->
    @.state = search_params: params
    @.getDataFromServer()



  render: ->
    table_css = 'table new '
    render_data = @.state.data.map( (el) ->
      R.p({}, [
        R.span({}, el.title),
        R.span({}, el.checked),
        R.span({}, el.start_date),
        R.span({}, el.duration),
      ])
    )

    column_names = ['title', 'started_at', 'finished_at', 'executor', 'inspector', 'state']

    R.table({className: table_css, id: 'table_here'}, [
      TasksTableHeader({column_names: column_names, onChangeFilterParams: @.onChangeSearchParams, filter_opts: @.props.filter_opts}),
      R.div({}, TasksTableList({column_names: column_names, data: @.state.data}))
    ])
