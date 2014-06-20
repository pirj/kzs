`/** @jsx React.DOM */`
R = React.DOM

@TasksTableHeaderFilterPopupUsersBeta = React.createClass

  mixins: [PopupMixin]

  propTypes:
    filter_opts: React.PropTypes.object

  handleSubmit: (e) ->
    e.preventDefault()
    @.props.onPopupSubmit(
      $(@.refs.popup_filter_form.getDOMNode()).serializeObject()
    )
    @.popupHide()

  handleCancel: ->
    @.popupHide()


  componentDidMount: ->
    $('.js-select2').select2(
      multiple: true
      width: '100%'
      containerCssClass: 'select2-black-mode'
      dropdownCssClass: 'select2-black-mode'
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
                    @.props.filter_opts.input_names[0]
                  catch
                    ''


    popup_body = [
      R.h5({className: 'popup-header'}, 'Фильтр по полю'),
      R.form({ref: 'popup_filter_form', onSubmit: @.handleSubmit, className: 'form-vertical'}, [
        R.div({className: 'popup-body'}, [
          R.input({name: input_name, className: 'js-select2', multiple: 'multiple'})
        ]),
        R.a({href: '#', onClick: @.handleSubmit, className: 'popup-btn'},[
          R.span({className: 'popup-fa fa fa-check-circle'})
          R.span({}, 'применить')
        ]),
        R.a({href: '#', onClick: @.handleCancel, className: 'popup-btn'},[
          R.span({className: 'popup-fa fa fa-ban'})
          R.span({}, 'отменить')
        ])
      ])
    ]

    @.renderPopup(popup_body)

