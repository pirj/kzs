window.app = {}
window.app.documents =
  selected_actions: []
  actions_by_rows: (checkbox) ->
    current_actions = $(checkbox).parents('tr').data('server-actions')
    result = []
    # if checked
    if $(checkbox).is(":checked")
      unless app.documents.selected_actions.length > 0
        app.documents.selected_actions = _.intersection(current_actions)
      else
        app.documents.selected_actions = _.intersection(app.documents.selected_actions, current_actions)
      result = app.documents.selected_actions
    else
      all_checkboxes = $(checkbox).parents('table').find('.js-row-select').filter(':checked')
      _selected_actions = []
      _.each(all_checkboxes, (checkbox) ->
        actions = $(checkbox).parents('tr').data('server-actions')
        unless _selected_actions.length > 0
          _selected_actions = _.intersection(actions)
        else
          _selected_actions = _.intersection(_selected_actions, actions)
      )
      result = _selected_actions

    result

  render_actions_list: (actions) ->
    $list = $('.js-documents-actions-list')
    $list.empty()
    console.log actions
    out = []
    _.each(actions, (action) ->
      link = switch action
        when 'edit' then window.app.documents.render_edit_link()
        else window.app.documents.render_change_state_link(action)

      out.push(link)
    )
    $list.html out.join('')

  render_edit_link: ->
    $el = $('table .js-row-select:checked')
    if $el.length == 1
      id = $el.parents('tr').data('id')
      "<li><a href='/documents/#{id}/edit'>редактировать</a></li>"
    else
      ''

  render_change_state_link: (action)->
    $els = $('table .js-row-select:checked')
    if $els.length > 0
      ids = []
      _.each($els, (el) ->
        id = $(el).parents('tr').data('id')
        console.log id
        ids.push(id)
      )
      console.log ids
      _ids = ids.join(',')
      "<li><a href='/documents/batch?document_ids[]=#{_ids}&state=#{action}'>#{action}</a></li>"
    else
      ''



$ ->
  # select checkboxes to select tables rows and update 'actions' UIcontrol.
  # in each rows saves actions for it document.
  # if select several rows, than filtering it actions to same.

  $(".js-row-select").on('change', ->
    actions = app.documents.actions_by_rows(@)
    app.documents.render_actions_list(actions)
#    current_actions = $(@).parents('tr').data('server-actions')
#    # if checked
#    if $(this).is(":checked")
#      unless selected_actions.length > 0
#        selected_actions = _.intersection(current_actions)
#      else
#        selected_actions = _.intersection(selected_actions, current_actions)
#
#    else
#      all_checkboxes = $(@).parents('table').find('.js-row-select:checked')
#      _selected_actions = []
#      _.each(all_checkboxes, (checkbox) ->
#        actions = $(checkbox).parents('tr').data('server-actions')
#        unless _selected_actions.length > 0
#          _selected_actions = _.intersection(actions)
#          console.log _selected_actions
#        else
#          _selected_actions = _.intersection(_selected_actions, actions)
#          console.log _selected_actions
#      )
#      _selected_actions
  )



#  ids = []
#  $(".js-row-select").on('change', ->
#    id = $(@).val()
#    $(".js-update-element[data-target=document]").empty()
#
#    # if checked
#    if $(this).is(":checked")
#      ids.push id
#      ids = ids.filter( (e, i, ids) -> ids.lastIndexOf(e) == i )
#      $.ajax
#        type: "GET"
#        url: "/documents/action_list"
#        datatype: "js"
#        data:
#          ids: ids
#
#
#    # if deckecked
#    else
#      num = ids.indexOf(id)
#      ids.remove(num, num)
#      ids = ids.filter( (e, i, ids) -> ids.lastIndexOf(e) == i )
#      if ids.length > 0
#        $.ajax
#          type: "GET"
#          url: "/documents/action_list"
#          datatype: "js"
#          data:
#            ids: ids
#
#    return
#  )
