`/** @jsx React.DOM */`

R = React.DOM

@FlagPopover = React.createClass
  mixins: [PopoverMixin]

  propTypes:
    json: React.PropTypes.object

  getDefaultProps: ->
    json: {}
    data: []


  render: ->
#    console.log @.props.json
    data = @.props.json.data
    task_id = @.props.json.task_id
    current_date = moment(@.props.json.date, 'DD-MM-YYYY')



    header = R.div({},[
      R.div({className: 'row'},
        R.div({className: 'col-sm-9 col-sm-offset-3'}, current_date)
      ),
      R.hr({})
    ])
    items = data.map((el) ->
      R.div({className: 'popover-content'}, [
        R.div({className: 'row'},[
          R.div({className: 'col-sm-3'}, R.input({type: 'checkbox', checked: el.checked})),
          R.div({className: 'col-sm-9'}, R.h3({className: 'text-sea-green'}, el.name))
        ]),
        R.div({className: 'row'}, [
          R.div({className: 'col-sm-3'}, R.div({className: 'text-help'}, 'суть')),
          R.div({className: 'col-sm-9'}, R.p({}, el.description))
        ]),
        R.hr({})
      ])
    )

    bottom_links = [
      R.div({className: 'row'}, [
        R.a({className: 'col-sm-4 link text-center', href: "/tasks/#{task_id}"}, 'Открыть задачу'),
        R.a({className: 'col-sm-4 link text-center', href: "/tasks/#{task_id}/edit"}, 'Править дела'),
        R.a({className: 'col-sm-4 link text-center', onClick: @.popoverHide}, [ R.span({className: 'fa fa-ban'}), R.span({}, 'Отмена') ])
      ])
    ]

    @.renderPopup([header, items, bottom_links])

