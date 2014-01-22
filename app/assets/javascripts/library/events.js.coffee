$ ->
  # run code pretty:
  window.prettyPrint and prettyPrint()

  # replace backslashes to nil word.
  # backslashes come from multiple lines slim partials.
  $.each($('.prettyprint'), ->
    $(@).html($(@).html().replace(/\\/g, ''))
  )



  $( ".js-datepicker" ).datepicker(
    showOtherMonths: true
    dateFormat: "dd-mm-yy"
  )
  $( ".js-chosen" ).chosen()

  # events to colorizing input and it icon
  $(document).on('focusin', '.input-group input, .js-input-with-icon', (e) ->
    e.stopPropagation()
    $('.input-group').removeClass('active')
    $(@).parent('.input-group').toggleClass('active')
  )

  $(document).on('focusout', '.input-group input, .js-input-with-icon', (e) ->
    e.stopPropagation()
    $('.input-group').removeClass('active')
  )
  # =========
