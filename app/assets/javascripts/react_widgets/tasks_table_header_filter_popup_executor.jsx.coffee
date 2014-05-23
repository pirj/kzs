`/** @jsx React.DOM */`
R = React.DOM

@TasksTableHeaderFilterPopupExecutor = React.createClass

  getDefaultProps: ->
    opened: false
    filter_opts: {
                    data: [ { id: '0', text: 'Unknown User' } ]
                    input_names: ['']
                  }

  handleSubmit: (e) ->
    e.preventDefault()
    console.log 'submited'
    console.log window.form = @.refs.popup_filter_form.getDOMNode()
    @.props.onPopupSubmit(
      $(@.refs.popup_filter_form.getDOMNode()).serializeObject()
    )


  componentDidUpdate: ->
#    $('.js-select2').select2('data', @.props.filter_opts.data)

  componentDidMount: ->
    $('.js-select2').select2(
      query: (query) =>
        data =
          results: []
        $.each @.props.filter_opts.data, ->
          if query.term.length is 0 or @text.toUpperCase().indexOf(query.term.toUpperCase()) >= 0
            data.results.push
              id: @.id
              text: @.title
          return
        query.callback data
    )

  render: ->
    input_name = try
                    @.props.filter_opts.input_names.first
                  catch
                    ''

    class_name = 'popup '
    class_name += (if @.props.opened then "" else "hidden")
    R.div({className: class_name}, [
      R.h5({}, 'форма для фильтра'),
      R.form({ref: 'popup_filter_form', onSubmit: @.handleSubmit, class: 'form-horizontal'}, [
        R.div({}, [
          R.input({name: input_name, className: 'form-control js-select2', multiple: 'multiple'})
        ]),
        R.input({type: 'submit', onClick: @.handleSubmit, value: 'применить', className: 'btn'}),
        R.link({href: '#', onClick: @.handleCancel, className: 'btn'}, 'отмена')
      ])
    ])

