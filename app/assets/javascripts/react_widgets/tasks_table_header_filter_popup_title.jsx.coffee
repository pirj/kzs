`/** @jsx React.DOM */`
R = React.DOM

@TasksTableHeaderFilterPopupTitle = React.createClass

  getDefaultProps: ->
    opened: false

  handleSubmit: (e) ->
    e.preventDefault()
    @.props.onPopupSubmit(
      $(@.refs.popup_filter_form.getDOMNode()).serializeObject()
    )




  render: ->
    class_name = 'popup '
    class_name += (if @.props.opened then "" else "hidden")
    R.div({className: class_name}, [
      R.h5({}, 'форма для фильтра'),
      R.form({ref: 'popup_filter_form', onSubmit: @.handleSubmit, class: 'form-horizontal'}, [
        R.div({}, [
          R.input({name: 'title_cont', type: 'text', className: 'form-control'})
        ]),
        R.input({type: 'submit', onClick: @.handleSubmit, value: 'применить', className: 'btn'}),
        R.link({href: '#', onClick: @.handleCancel, className: 'btn'}, 'отмена')
      ])
    ])

