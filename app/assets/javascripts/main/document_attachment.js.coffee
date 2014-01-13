jQuery ->
  $('form').on 'click', '.remove_fields', (event) ->
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('fieldset').remove()
    event.preventDefault()

  $('form').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
    text = '<header>Задача '+$('.taskCard fieldset').length+'</header>'
    $('.taskCard fieldset:last').prepend(text)
    $(".task_deadline").datepicker(dateFormat: "dd.mm.yy")
    event.preventDefault()

  $('form').on 'click', '.add_fields2', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
    $(".task_deadline").datepicker(dateFormat: "dd.mm.yy")
    event.preventDefault()