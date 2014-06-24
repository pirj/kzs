`/** @jsx React.DOM */`
R = React.DOM

@TasksTableHeaderFilterPopoverTitleBeta = React.createClass

  mixins: [PopoverMixin]

  handleSubmit: (e) ->
    e.preventDefault()
    @.props.onPopoverSubmit(
      $(@.refs.popover_filter_form.getDOMNode()).serializeObject()
    )
    @.popoverHide()

  handleCancel: ->
    @.popoverHide()

  render: ->
    popover_body = [
      R.h5({className: 'popover-title'}, 'Фильтр по полю'),
      R.form({ref: 'popover_filter_form', onSubmit: @.handleSubmit, class: 'form-horizontal'}, [
        R.div({className: 'popover-form'}, [
          R.input({name: 'title_cont', type: 'text', className: 'form-control'})
        ]),
        R.div({className: 'btn-group-vertical'},[
          R.a({href: '#', onClick: @.handleSubmit, className: 'btn'}, [
            R.span({className: 'popover-fa fa fa-check-circle'})
            R.span({}, 'применить')
          ]),
          R.a({href: '#', onClick: @.handleCancel, className: 'btn'}, [
            R.span({className: 'popover-fa fa fa-ban'})
            R.span({}, 'отменить')
          ])
        ])
      ])
    ]

    @.renderPopover(popover_body)

