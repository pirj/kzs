window.app = {}
window.global =
  chosen:
    disable_search_threshold: 1
    no_results_text: "Ничего не найдено."
    placeholder_text_multiple: " "
    placeholder_text_single: " "
    disable_search: true
    display_selected_options: false
    search_contains: true

  chosen_search:
    disable_search_threshold: 1
    no_results_text: "Ничего не найдено."
    placeholder_text_multiple: " "
    placeholder_text_single: " "
    display_selected_options: false
    search_contains: true

  datepicker:
    showOtherMonths: true
    dateFormat: "dd.mm.yy"
    minDate: new Date()


# Исполнение js-кода внутри кастомного контекста
window.eval_js_in_context = (data, context) ->
  (->
    eval data
  ).apply context

window.app.enable_welcome = ->
  $('.js-welcome-screen').modal('show')
  $('.modal-backdrop').removeClass().addClass('modal-backdrop-white in')
  if $('.js-welcome-screen').find('.js-screen-user-actions').length > 0
    $(document).one 'click', '.js-screen-exit', (e) ->
      $('.modal, .modal-backdrop-white').fadeOut(1000, -> $(@).modal('hide').remove())
  else
    $('.modal, .modal-backdrop-white').delay(1500).fadeOut(1000, -> $(@).modal('hide').remove())


$ ->
  # run code pretty:
  window.prettyPrint and prettyPrint()

  # active boostrap tooltips
  $(".js-label-hint").tooltip( placement: 'right' )
  $(".js-tooltip").tooltip( placement: 'top' )

  # replace backslashes to nil word.
  # backslashes come from multiple lines slim partials.
  $.each($('.prettyprint'), ->
    $(@).html($(@).html().replace(/\\/g, ''))
  )

  # chosen-search
  $( ".js-chosen-search" ).filter(':visible').chosen( global.chosen_search )
  $( ".js-chosen" ).filter(':visible').chosen( global.chosen )

  # dropdown
  $('.dropdown-toggle').dropdown()

  # datepicker
  $('.js-datepicker').not('.js-deadline').datepicker(global.datepicker)
  date = $('.js-datepicker.js-deadline').datepicker( "getDate" )
  data_days = $('.js-datepicker.js-deadline').data('days')
  max_date = $('.js-datepicker.js-deadline').datepicker( "option", "maxDate" )
  opts = _.extend(global.datepicker, minDate: date + data_days, max_date )
  $( '.js-datepicker.js-deadline' ).datepicker(opts)


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

  # Initialize checkboxes by iCheck plugin
  if jQuery.fn.iCheck != undefined
    $('input[type="checkbox"], input[type="radio"]').not('.js-icheck-off input').iCheck(
      checkboxClass: 'icheckbox_flat-green checkbox-inline'
      radioClass: 'iradio_flat-green radio-inline'
    )


  # custom initialize popover
  $('.js-document-state-link').on('click', ->
    $('.js-document-state-link').popover('destroy').filter(@).popover(html: true, animation: false).popover('show').trigger('document_state:show')
  )

  # set strong 'height' and 'width' for popover wrapper
  $('.js-document-state-link').on('document_state:show', ->
    popover = $(@).next().find('.js-document-state-popover')
    popover.css('height': popover.height(), width: popover.width() )
  )

  # popover-over
  clearPopover = () ->
    $('.js-popover-content').hide()
    $('.js-popover').removeClass('active')
    return

  $('.js-popover').on('click', (e) ->
    e.preventDefault()
    target = this.dataset.target

    $('.js-popover-content[data-target=' + target + ']').toggle()
    $(this).toggleClass('active')
  )
  $('.js-popover-close').on('click', (e) ->
    clearPopover()
  )

  # CLEAR PAGE

  $(document).click (e) ->

    return if $(e.target).closest('.js-popover-content').length || $(e.target).closest('.js-popover').length
    clearPopover()

    event.stopPropagation()
    return




  # click on 'back' button
  $(document).on('click', '.js-document-state-back-link', ->
    $(@).closest('.popover').prev().popover('show').trigger('document_state:show')
  )

  # close this 'cancel button' popover
  $(document).on('click', '.js-document-state-close-popover', ->
    $(@).closest('.popover').prev().popover('destroy')
  )

  # initialize styling file attach button with file-title near attach button
  $('.js-filestyle-with-title').filestyle()

  # БЛОК АКТИВАЦИИ КЛАССОВ
  user_conform = new ConformingView()
