`/** @jsx React.DOM */`

R = React.DOM

@GanttTaskSQPlus = React.createClass
  mixins: [PopoverMixin]

  propTypes:
    json: React.PropTypes.object

  getDefaultProps: ->
    json: {}


  render: ->
    el = @.props.json
    json = @.props.json

    open_link = R.a({className: 'btn'}, [R.span({className: 'fa'}), R.span({}, 'Открыть задачу')])
    add_subtask_link = R.a({className: 'btn', href: '/tasks/task_id/edit#add_subtask'}, [R.span({className: 'fa fa-plus'}), R.span({}, 'Добавить подзадчу')])
    add_checklist_item_link = R.a({className: 'btn', href: '/tasks/task_id/edit#add_checklist_item'}, [R.span({className: 'fa fa-plus'}), R.span({}, 'Добавить подзадчу')])
    edit_link = R.a({className: 'btn', href: '/tasks/task_id/edit'}, [R.span({className: 'fa fa-pen'}), R.span({}, 'Редактировать задачу')])
    cancel_link = R.a({className: 'btn', onClick: @.popoverHide}, [R.span({className: 'fa fa-ban'}), R.span({}, 'Отмена')])


    items = R.div({className: 'btn-group-vertical'},[
              open_link,
              add_subtask_link,
              add_checklist_item_link,
              edit_link,
              cancel_link
            ])

    @.renderPopover(items)
