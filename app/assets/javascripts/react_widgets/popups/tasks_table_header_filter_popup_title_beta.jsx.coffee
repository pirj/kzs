`/** @jsx React.DOM */`
R = React.DOM

@TasksTableHeaderFilterPopupTitleBeta = React.createClass

  mixins: [PopupMixin]

  handleSubmit: (e) ->
    e.preventDefault()
    @.props.onPopupSubmit(
      $(@.refs.popup_filter_form.getDOMNode()).serializeObject()
    )
    @.PopupHide()

  handleCancel: ->
    @.PopupHide()

  render: ->
    popup_body = [
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
    ]

    @.renderPopup(popup_body)

