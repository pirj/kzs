`/** @jsx React.DOM */`
R = React.DOM

@TasksTableHeaderFilterPopupExecutor = React.createClass

  getDefaultProps: ->
    opened: false
    filter_opts: {
                    data: [ { id: '0', text: 'Unknown User' } ]
                    input_names: ['']
                  }


  getInitialState: (props) ->
    props = props || this.props
    opened: props.opened


  componentWillReceiveProps: (newProps, oldProps) ->
    @.setState(@.getInitialState(newProps))

  handleSubmit: (e) ->
    e.preventDefault()
    @.props.onPopupSubmit(
      $(@.refs.popup_filter_form.getDOMNode()).serializeObject()
    )


  componentDidUpdate: ->
#    $('.js-select2').select2('data', @.props.filter_opts.data)

  componentDidMount: ->
    $('.js-select2').select2(
      multiple: true
      width: '100%'
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

  handleCancel: ->
    console.log 'clicked'
    @.setState(opened: !@.state.opened)

  popupClassName: ->
    class_name = ['popup']
    class_name.push 'hidden' unless @.state.opened
    class_name.join(' ')


  render: ->
    input_name = try
                    @.props.filter_opts.input_names[0]
                  catch
                    ''


    R.div({className: @.popupClassName()}, [
      R.h5({}, 'форма для фильтра'),
      R.form({ref: 'popup_filter_form', onSubmit: @.handleSubmit, class: 'form-horizontal'}, [
        R.div({}, [
          R.input({name: input_name, className: 'js-select2', multiple: 'multiple'})
        ]),
        R.input({type: 'submit', onClick: @.handleSubmit, value: 'применить', className: 'btn'}),
        R.a({href: '#', onClick: @.handleCancel, className: 'btn'}, 'отмена')
      ])
    ])

