`/** @jsx React.DOM */`
R = React.DOM

@TasksTableHeaderFilterPopup = React.createClass

  getDefaultProps: ->
    opened: false

  handleSubmit: (e) ->
    e.preventDefault()
    @.props.onPopupSubmit(
      $(@.refs.popup_filter_form.getDOMNode()).serializeObject()
    )

  render: ->
    class_name = 'd-popup '
    class_name += (if @.props.opened then "" else "hidden")
    R.div({className: class_name}, [
      R.h5({}, 'форма для фильтра'),
      R.form({ref: 'popup_filter_form', onSubmit: @.handleSubmit}, [
        R.div({}, [
          R.input({name: 'started_at_gteq', type: 'date'})
          R.input({name: 'started_at_lteq', type: 'date'})
        ]),
        R.input({type: 'submit', onClick: @.handleSubmit, value: 'применить'})
      ])
    ])

