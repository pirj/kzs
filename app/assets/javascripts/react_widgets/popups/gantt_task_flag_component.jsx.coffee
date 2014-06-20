`/** @jsx React.DOM */`

R = React.DOM

@FlagPopup = React.createClass
  mixins: [PopupMixin]

  propTypes:
    json: React.PropTypes.object

  getDefaultProps: ->
    opened: false
    json: {}
    data: []


  render: ->

    data = [@.props.json]

    items = data.map((el) ->
      [
        R.div({className: 'row'},[
          R.div({className: 'col-sm-3'}, R.input({type: 'checkbox', checked: el.checked})),
          R.div({className: 'col-sm-9'}, R.h3({}, el.name))
        ]),
        R.div({className: 'row'}, [
          R.div({className: 'col-sm-3'}, R.div({className: 'text-help'}, 'суть')),
          R.div({className: 'col-sm-9'}, R.p({}, el.description))
        ]),
        R.hr({})
      ])

    bottom_links = [
      R.div({className: 'row'}, [
        R.a({className: 'col-sm-4 link text-center', href: "/tasks/task_id"}, 'Открыть задачу'),
        R.a({className: 'col-sm-4 link text-center', href: "/tasks/task_id/edit"}, 'Править дела'),
        R.a({className: 'col-sm-4 link text-center', onClick: @.popupHide}, [ R.span({className: 'fa fa-ban'}), R.span({}, 'Отмена') ])
      ])
    ]

    @.renderPopup([items, bottom_links])

