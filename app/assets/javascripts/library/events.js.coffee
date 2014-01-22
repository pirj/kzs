$ ->
  # run code pretty:
  window.prettyPrint and prettyPrint()

  # replace backslashes to nil word.
  # backslashes come from multiple lines slim partials.
  $.each($('.prettyprint'), ->
    $(@).html($(@).html().replace(/\\/g, ''))
  )



  $( ".js-datepicker" ).datepicker({ dateFormat: "dd-mm-yy" })
  $( ".js-chosen" ).chosen()