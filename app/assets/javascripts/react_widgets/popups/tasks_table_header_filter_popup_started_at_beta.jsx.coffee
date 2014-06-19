`/** @jsx React.DOM */`
R = React.DOM

@TasksTableHeaderFilterPopupStartedAtBeta = React.createClass

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
      R.form({ref: 'popup_filter_form', onSubmit: @.handleSubmit, className: 'form form-horizontal'}, [
        R.div({className: 'row popup-body'},

          R.div({className: 'col-sm-6'},
            R.div({className: 'row'}, [
              R.label({className: 'control-label col-sm-2'}, 'от'),
              R.div({className: 'col-sm-10'},
                R.div({className: 'input-group'}, [
                  R.div({className: 'input-group-icon'}, R.span({className: 'fa fa-calendar'})),
                  R.input({name: 'started_at_gteq', type: 'text', className: 'form-control js-datepicker'})
                ]),
              )
            ])
          ),

          R.div({className: 'col-sm-6 form-group'},
            R.div({className: 'row'}, [
              R.label({className: 'control-label col-sm-2'}, 'до'),
              R.div({className: 'col-sm-10'},
                R.div({className: 'input-group'}, [
                  R.div({className: 'input-group-icon'}, R.span({className: 'fa fa-calendar'})),
                  R.input({name: 'started_at_lteq', type: 'text', className: 'form-control js-datepicker'})
                ])
              )
            ])
          )

        )
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
