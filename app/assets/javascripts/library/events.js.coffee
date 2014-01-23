$ ->
  # run code pretty:
  window.prettyPrint and prettyPrint()

  # replace backslashes to nil word.
  # backslashes come from multiple lines slim partials.
  $.each($('.prettyprint'), ->
    $(@).html($(@).html().replace(/\\/g, ''))
  )

  # dropdown
  $('.dropdown-toggle').dropdown()

  # datepicker
  $( ".js-datepicker" ).datepicker(
    showOtherMonths: true
    dateFormat: "dd-mm-yy"
  )

  # chosen
  $( ".js-chosen" ).chosen(
    disable_search_threshold: 1
    no_results_text: "Ничего не найдено."
  )

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

  # set same width for header and dropdown in .dropdown.header
  # because of .dropdown-menu position is set to absolute, than .dropdown width not equal .dropdown-menu
  # the design requirements is the same width of header and dropdown-menu
  # when .dropdown-menu is hidden, it width is equal 0.
  # than calculate it width, when dropdown-menu will be opening
  (->
    $('.dropdown.header .dropdown-toggle').on('click.dropdown.data-api', (e) ->
      console.log 'open'
      width = @.parentElement.getElementsByClassName('dropdown-menu')[0].offsetWidth
      if width > 0
        @.parentElement.style.width = "#{width}px"
    )


  )()

