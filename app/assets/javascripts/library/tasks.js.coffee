$ ->
  window.app.tasks =
    add_task_btn: '.js-tasks-add-task'


  ( ->
    $(document).on('click', @.add_task_btn, ->

    )

  )(app.tasks)