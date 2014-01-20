$ ->
  $window = $(window)

  # Запускаем code pretty:
  window.prettyPrint and prettyPrint()

  # replace backslashes to nil word.
  # backslashes come from multiple lines slim partials.
  $.each($('.prettyprint'), ->
    $(@).html($(@).html().replace(/\\/g, ''))
  )

  console.log 'highlighter on'