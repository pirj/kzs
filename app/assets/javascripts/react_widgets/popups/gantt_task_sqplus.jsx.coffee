`/** @jsx React.DOM */`

R = React.DOM

@GanttTaskSQPlus = React.createClass
  mixins: [PopupMixin]

  propTypes:
    json: React.PropTypes.object

  getDefaultProps: ->
    json: {}


  render: ->
    el = @.props.json
    json = @.props.json

    open_link = R.a({href: '/tasks/'+json.id}, [R.span({className: 'fa'}), R.span({}, 'Открыть задачу')])
    add_subtask_link = R.a({href: '/tasks/'+json.id+'#add_subtask'}, [R.span({className: 'fa fa-plus'}), R.span({}, 'Добавить подзадчу')])
    add_checklist_item_link = R.a({href: '/tasks/'+json.id+'/edit#add_checklist_item'}, [R.span({className: 'fa fa-plus'}), R.span({}, 'Добавить дело')])
    edit_link = R.a({href: '/tasks/'+json.id+'/edit'}, [R.span({className: 'fa fa-pen'}), R.span({}, 'Редактировать задачу')])
    cancel_link = R.a({onClick: @.popupHide}, [R.span({className: 'fa fa-ban'}), R.span({}, 'Отмена')])


    items = R.div({className: 'row'},[
              open_link,
              add_subtask_link,
              add_checklist_item_link,
              edit_link,
              cancel_link
            ])

    @.renderPopup(items)

