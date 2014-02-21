$ ->
  window.app =
    add_btn: '.js-filter-add-row-btn'
    default_row_source: '.js-filter-option-row-source'
    query_source: '.js-filter-row-query-source'
    filter_container: '.js-filter-container'
    query_container: '.js-filter-query'
    attribute_select: '.js-filter-attribute'

  # закрываем инпуты, чтобы они не передавались на сервер
  $("#{app.default_row_source} input, #{app.default_row_source} select").prop('disabled', 'disabled')
  $("#{app.query_source} input, #{app.query_source} select").prop('disabled', 'disabled')

  # search filter
  # by timeout updating search result count
  timer_id = 0
  $(document).on('keyup blur', '.js-filter-form', ->
    clearTimeout(timer_id)
    timer_id = setTimeout( ->
      data = $('.js-filter-form').serializeArray()
      $.ajax
        data: data
        dataType: 'script'
        type: 'POST'
        url: $('.js-filter-form').data('url')

    , 500)
  )

  $(document).on('filter:update', ->
    $("#{app.filter_container} input,  #{ app.filter_container} select").prop('disabled', '')
  )

  # добавляем новую строку с выбором «атрибута поиска» и самим поисковым полем
  $(document).on('click', app.add_btn, ->
    # html-template должен быть обернут в js класс со словом source, сам этот класс не переносится, а вставляется только его содержимое
    $(@).before($(app.default_row_source).html())
    $(document).trigger('filter:update')
  )

  # меняем имя стринга так, чтобы отправлять на сервер для поиска отправлялось с префиксом из селекта
  $(document).on('change', "#{app.filter_container} #{app.query_container} select", ->
    $elem = $(@)
    $query_container = $elem.closest(app.query_container)
    $input = $query_container.find('input')

    input_name = "q[#{$input.data('name')}_#{$elem.val()}]"
    $input.prop('name', input_name)
    console.log $input.prop('name')
  )

  # выбираем новый атрибут поиска «дата» или «название»
  # и заменяем текущую строку с поисковой строкой на подходящую
  $(document).on('change', app.attribute_select, ->
    $elem = $(@)
    $query_container = $elem.next(app.query_container)
    $new_query_html = $("#{app.query_source}[data-type='#{$elem.val()}']").html()

    $query_container.html($new_query_html)
  )