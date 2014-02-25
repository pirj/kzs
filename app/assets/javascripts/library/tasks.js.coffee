$ ->
  window.app.tasks =
    add_task_btn: '.js-tasks-add-task'
    task_remove_btn: '.js-task-remove'
    main_form_container: '.js-tasks-main-form'
    add_task_modal: '.js-tasks-add-modal'
    modal_task_container: '.js-tasks-modal-form'
    modal_cancel_btn: '.js-tasks-modal-cancel-btn'
    modal_add_new_btn: '.js-tasks-modal-add-new-task-btn'
    modal_save_btn: '.js-tasks-modal-save-btn'


  T = app.tasks
  T.$add_task_modal =  $(T.add_task_modal)
  T.$add_task_modal_task_container = T.$add_task_modal.find(T.modal_task_container)
  T.$main_form_container =  $(T.main_form_container)

  # Open modal for new T.
  $(document).on('click', T.add_task_btn, (e) ->
    e.preventDefault()
    # replace '0' to 'now timestamp' in task-form
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')

    T.$add_task_modal_task_container.html($(@).data('fields').replace(regexp, time))
    T.$add_task_modal.modal('show')
  )


  # Add edited task to hidden area in parent-model form
  $(document).on('click', T.modal_save_btn, (e) ->
    e.preventDefault()
    # apply all inserted values to inputs and  labels
    _$inputs = T.$add_task_modal_task_container.find('input, textarea, select')
    _.each(_$inputs, (input) ->
      $elem = $(input)
      val = $elem.val()

      $elem.attr('value', val)
      $target = $elem.closest('.js-task-container').find(".js-task-form-inserted-values .#{$elem.data('target')}")
      $target.text(val)
    )

    # hide form inputs
    T.$add_task_modal_task_container.find('.js-task-form-fields').hide()

    # show form labels
    T.$add_task_modal_task_container.find('.js-task-form-inserted-values').show()

    # move this inputs to main form
    T.$main_form_container.append(T.$add_task_modal_task_container.html())

    T.$add_task_modal.modal('hide')
  )

  # remove inserted task to main-form
  $(document).on('click', T.task_remove_btn, (e) ->
    $(e.target).closest('.js-task-container').empty()
  )




