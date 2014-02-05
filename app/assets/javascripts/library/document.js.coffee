$ ->
  # select checkboxes to select tables row
  #
  ids = []
  $(".js-row-select").on('change', ->
    console.log $(@)
    id = $(@).val()
    $(".js-update-element[data-target=document]").empty()

    # if checked
    if $(this).is(":checked")
      ids.push id
      console.log ids
      $.ajax
        type: "GET"
        url: "/documents/action_list"
        datatype: "js"
        data:
          ids: ids


    # if deckecked
    else
      num = ids.indexOf(id)
      console.log num
      ids.remove(num, num)
      console.log ids
      if ids.length > 0
        $.ajax
          type: "GET"
          url: "/documents/action_list"
          datatype: "js"
          data:
            ids: ids

    return
  )
