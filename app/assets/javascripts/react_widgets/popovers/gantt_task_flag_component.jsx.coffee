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
#    console.log(@)/
    if @.state.opened==true
      $('.task_flag'+@.props.parent).addClass('active');
    if @.state.opened == false
      $('.task_flag'+@.props.parent).removeClass('active');

    if @.state.opened==true
      data = @.props.json.data
      task_id = @.props.json.task_id
      window.task_date = @.props.json.date
      current_date = moment(@.props.json.date, 'DD-MM-YYYY')

      header = R.div({},
        R.div({className: 'row'},[
            R.div({className: 'col-sm-9 col-sm-offset-1 text-gray'}, current_date.format('DD MMMM, dddd'))
          ]
        )
      )

      items = data.map((el) ->
        R.div({className: 'popover-content-item b-offset-sm'}, [
          R.div({className: 'row'},[
            R.div({className: 'col-sm-1'}, R.input({type: 'checkbox', checked: el.checked})),
            R.div({className: 'col-sm-11'}, R.a({className: 'link-sea-green', href: "/tasks/#{task_id}"}, el.name))
          ]),
          R.div({className: 'row'}, [
            R.div({className: 'col-sm-1'}, R.div({className: 'text-help'}, 'суть')),
            R.div({className: 'col-sm-11'}, R.p({className: 'text-cloud'}, el.description))
          ]),
        ])
      )

      bottom_links =
        R.div({className: 'popover-footer nav nav-justified'}, [
            R.li({}, R.a({className: 'col-sm-4 btn text-center', href: "/tasks/#{task_id}"}, 'Открыть задачу') ),
            R.li({}, R.a({className: 'col-sm-4 btn text-center', href: "/tasks/#{task_id}/edit"}, 'Править дела') ),
            R.li({}, R.a({className: 'col-sm-4 btn text-center', onClick: @.popoverHide}, [ R.span({className: 'fa fa-ban'}), R.span({}, 'Отмена') ]) )
        ])

    @.renderPopover([header, items, bottom_links])

