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
    class_name = 'popup popup-right '
    class_name += (if @.props.opened then "" else "hidden")
    R.div({className: class_name}, [
      R.h5({className: 'popup-header'}, 'Фильтр по полю'),
      R.form({ref: 'popup_filter_form', onSubmit: @.handleSubmit, class: 'form-horizontal'}, [
        R.div({className: 'popup-body'}, [
          R.input({name: 'title_cont', type: 'text', className: 'form-control'})
        ]),

        R.a({href: '#', onClick: @.handleSubmit, className: 'popup-btn'}, [
          R.span({className: 'popup-fa fa fa-check-circle'})
          R.span({}, 'применить')
        ]),
        R.a({href: '#', onClick: @.handleCancel, className: 'popup-btn'}, [
          R.span({className: 'popup-fa fa fa-ban'})
          R.span({}, 'отменить')
        ])
      ])
    ])

