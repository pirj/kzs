$ ->
  window.app =
    filter_form: '.js-filter-form'
    add_btn: '.js-filter-add-row-btn'
    remove_row_btn: '.js-filter-row-remove-btn'
    default_row_source: '.js-filter-option-row-source'
    query_source: '.js-filter-row-query-source'
    filter_container: '.js-filter-container'
    query_row_container: '.js-filter-row'
    query_container: '.js-filter-query'
    attribute_select: '.js-filter-attribute'

  # закрываем инпуты, чтобы они не передавались на сервер
  $("#{app.default_row_source} input, #{app.default_row_source} select").prop('disabled', 'disabled')
  $("#{app.query_source} input, #{app.query_source} select").prop('disabled', 'disabled')

  # search filter
  # by timeout updating search result count
  timer_id = 0
  $(document).on('keyup blur change filter:update', app.filter_form, ->
    clearTimeout(timer_id)
    timer_id = setTimeout( ->
      data = $(app.filter_form).serializeArray()
      $.ajax
        data: data
        dataType: 'script'
        type: 'POST'
        url: $(app.filter_form).data('url')

    , 200)
  )

  # всем инпутам и селектам выставляем свойство disabled, чтобы не отправлять лишнее на сервер
  $(document).on('filter:update', ->
    $("#{app.filter_container} input,  #{ app.filter_container} select").prop('disabled', '')
  )

  # добавляем новую строку с выбором «атрибута поиска» и самим поисковым полем
  $(document).on('click', app.add_btn, ->
    # html-template должен быть обернут в js класс со словом source, сам этот класс не переносится, а вставляется только его содержимое
    $(@).before($(app.default_row_source).html())
    $(app.filter_form).trigger('filter:update')
  )

  # удаляем текущую строку с параметрами фильтрации
  $(document).on('click', app.remove_row_btn, ->
    $(@).closest(app.query_row_container).empty()
  )

  # меняем имя стринга так, чтобы отправлять на сервер для поиска отправлялось с префиксом из селекта
  $(document).on('change', "#{app.filter_container} #{app.query_container} select", ->
    $elem = $(@)
    $query_container = $elem.closest(app.query_container)
    $input = $query_container.find('input')

    input_name = "q[#{$input.data('name')}_#{$elem.val()}]"
    $input.prop('name', input_name)

    $(app.filter_form).trigger('filter:update')
  )

  # выбираем новый атрибут поиска «дата» или «название»
  # и заменяем текущую строку с инпутом на подходящую
  $(document).on('change', "#{app.filter_container} #{app.attribute_select}", ->
    $elem = $(@)
    $query_container = $elem.closest(app.query_row_container).find(app.query_container)
    $new_query_html = $("#{app.query_source}[data-type='#{$elem.val()}']").html()

    $query_container.html($new_query_html)
    $(app.filter_form).trigger('filter:update')
  )

  # обрабатываем клики на стилизованных чекбоксах
  $(document).on('ifChanged', "#{app.filter_container} input[type=checkbox]", ->
    $(app.filter_form).trigger('filter:update')
  )

