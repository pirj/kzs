$ ->
  window.app.tasks =
    order_tasks_list:
      form: '.js-tasks-order-task-form'

    order_tasks_form:
      container: '.js-tasks-main-form'
      add_task_btn: '.js-tasks-add-task'

    task:
      container: '.js-task-container'
      remove_btn: '.js-task-remove'
      inputs_container: '.js-task-form-fields'
      html_container: '.js-task-form-inserted-values'

    create_modal:
      elem: '.js-tasks-add-modal'
      form_container: '.js-tasks-modal-form'
      cancel: '.js-tasks-modal-cancel-btn'
      submit: '.js-tasks-modal-save-btn'


    add_task_btn: '.js-tasks-add-task'
    task_remove_btn: '.js-task-remove'
    main_form_container: '.js-tasks-main-form'
    add_task_modal: '.js-tasks-add-modal'
    modal_task_container: '.js-tasks-modal-form'
    modal_cancel_btn: '.js-tasks-modal-cancel-btn'
    modal_add_new_btn: '.js-tasks-modal-add-new-task-btn'
    modal_save_btn: '.js-tasks-modal-save-btn'
    task_form:
      task_container: '.js-task-container'
      inputs_container: '.js-task-form-fields'
      html_container: '.js-task-form-inserted-values'

  T = app.tasks
  T.create_modal.$elem = $(T.create_modal.elem)
  T.create_modal.$form_container = $(T.create_modal.form_container)

  T.$add_task_modal =  $(T.add_task_modal)
  T.$add_task_modal_task_container = T.$add_task_modal.find(T.modal_task_container)
  T.$main_form_container =  $(T.main_form_container)

  # hide all inputs by on after page loaded
  $(T.main_form_container).find('input, textarea, select').closest('.form-group').hide()

  # создание новой таски в модальном окне
  $(document).on('click', T.order_tasks_form.add_task_btn, (e) ->
    e.preventDefault()
    # replace '0' to 'now timestamp' in task-form
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')

    html_source = $(@).data('fields').replace(regexp, time)

    # вставляем данный код в модальное окно
    T.create_modal.$form_container.html(html_source)

    # показываем форму, скрываем все остальное
    T.create_modal.$form_container.find(T.task.html_container).hide()
    T.create_modal.$form_container.find('.js-datepicker').datepicker(global.datepicker)
    T.create_modal.$form_container.find(T.task.inputs_container).show()

    T.create_modal.$elem.modal('show')
  )

  # при клике на кнопку сабмита
  $(document).on('click', T.modal_save_btn, (e) ->
    e.preventDefault()
    # apply all inserted values to inputs and  labels
    _$inputs = T.$add_task_modal_task_container.find('input, textarea, select')
    _.each(_$inputs, (input) ->
      $elem = $(input)
      val = $elem.val()

      $elem.attr('value', val)
      console.log val
      $target = $elem.closest(T.task_form.task_container).find("#{T.task_form.html_container} .#{$elem.data('target')}")
      $target.text(val)
    )

    # hide form inputs
    T.$add_task_modal_task_container.find(T.task_form.inputs_container).hide()

    # show form decorated labels
    T.$add_task_modal_task_container.find(T.task_form.html_container).show()

    # move this inputs to main form
    T.$main_form_container.append(T.$add_task_modal_task_container.html())

    T.$add_task_modal.modal('hide')
  )

  # remove inserted task from main-form
  $(document).on('click', T.task_remove_btn, (e) ->
    $(e.target).closest('.js-task-container').empty()
  )

  # hide modal window by 'cancel' btn
  $(document).on('click', T.modal_cancel_btn, ->
    $(T.add_task_modal).modal('hide')
  )

  # submit form on task checked over ajax

  $(document).on('ifChecked ifUnchecked', "#{T.order_tasks_list.form} input", (e) ->
    e.preventDefault()
    e.stopImmediatePropagation()

    if e.type is 'ifChecked'

      $tasks = $('.js-tasks-order-task-form' + ' input[type=checkbox]')
      $completed_tasks = $('.js-tasks-order-task-form' + ' input[type=checkbox]:checked') #throw RuntimeException("exit")#('Ошибка!')

      if $tasks.length-$completed_tasks.length==0
        if confirm("Вы уверены? Отменить невозможно!")
          $(e.target).closest('.j-task').addClass('m-task-completed')
          $form = $(e.target).closest(T.order_tasks_list.form)
          $form.submit()
        else
          location.reload()
      else
        $(e.target).closest('.j-task').addClass('m-task-completed')
        $form = $(e.target).closest(T.order_tasks_list.form)
        $form.submit()
    else
      $(e.target).closest('.j-task').removeClass('m-task-completed')
      $form = $(e.target).closest(T.order_tasks_list.form)
      $form.submit()

  )



