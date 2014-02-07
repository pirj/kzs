$ ->
  # select checkboxes to select tables rows and update 'actions' UIcontrol.
  ids = []
  $(".js-row-select").on('change', ->
    id = $(@).val()
    $(".js-update-element[data-target=document]").empty()

    # if checked
    if $(this).is(":checked")
      ids.push id
      ids = ids.filter( (e, i, ids) -> ids.lastIndexOf(e) == i )
      $.ajax
        type: "GET"
        url: "/documents/action_list"
        datatype: "js"
        data:
          ids: ids


    # if deckecked
    else
      num = ids.indexOf(id)
      ids.remove(num, num)
      ids = ids.filter( (e, i, ids) -> ids.lastIndexOf(e) == i )
      if ids.length > 0
        $.ajax
          type: "GET"
          url: "/documents/action_list"
          datatype: "js"
          data:
            ids: ids

    return
  )
