$ ->
  # run code pretty:
  window.prettyPrint and prettyPrint()

  # active boostrap tooltips
  $(".js-label-hint").tooltip(
    placement: 'right'
  )

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
    placeholder_text_multiple: " "
    placeholder_text_single: " "
    disable_search: true
  )

  # chosen-search
  $( ".js-chosen-search" ).chosen(
    disable_search_threshold: 1
    no_results_text: "Ничего не найдено."
    placeholder_text_multiple: " "
    placeholder_text_single: " "
  #  disable_search: true !use chosen-container-single-nosearch
  )

  # button
  #$('.js-open').on "click", ->
  #  document.location = $(this).attr "href"

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
    $('.dropdown.header .dropdown-toggle:not("calculated")').on('click.dropdown.data-api', (e) ->
      elem = @
      parent = elem.parentElement
      menu = elem.parentElement.getElementsByClassName('dropdown-menu')[0]

      header_w = elem.offsetWidth
      items_w = menu.offsetWidth

      if items_w > 0
        ws = [header_w, items_w]
        width = _.last(ws.sort())
        elem.style.width = "#{width}px"
        menu.style.width = "#{width}px"
        parent.classList.add('calculated')
    )
  )()

