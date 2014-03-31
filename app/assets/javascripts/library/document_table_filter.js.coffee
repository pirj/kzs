window.app.table_filter =
  container: '.js-table-filter'
  table:
    btn: '.js-table-filter-activate-btn'
    filled_form: '.js-table-filter-filled-form'
    filled_form_class: 'label-gray'
    active_btn_class: 'label-blue'

  form:
    container: '.js-table-filter-form'
    clear_btn: '.js-document-filter-clear-btn'

  status_bar:
    container: '.js-table-filter-status-bar'
    clear_btn: '.js-table-filter-status-bar-clear-btn'
    change_btn: '.js-table-filter-status-bar-change-btn'



  # переключаем видимость у формы, с которой работаем
  # здесь у метода выставлем -> чтобы контекст был данный объект
  # elem — кнопка, к которой привязана поисковая часть формы
  toggle_form: (elem) ->
    $target = @.find_form(elem)
    # скрывем все формы кроме текущей и переключаем статус текущей
    $(@.form.container).not($target).hide()
    $($target).toggle()
    @.init_plugins()

  # ищем форму, связанную с заголовком формы (elem)
  find_form: (elem) ->
    target = $(elem).data('target')
    $(@.container).find(@.form.container).filter("[data-target='#{target}']")

  # находим кнопку, которая активирует форму с фильтром
  find_activate_btn: (form) ->
    target = $(form).data('target')
    $(@.container).find(@.table.btn).filter("[data-target='#{target}']")



  # управляем стилями кнопок переключения поисковых форм
  toggle_activate_btns_style: (elem) ->
    $elem = $(elem)
    $(@.table.btn).not(elem).removeClass(@.table.active_btn_class)
    $elem.toggleClass(@.table.active_btn_class)

    if $elem.hasClass(@.table.filled_form_class)
      # удаляем класс, чтобы при активации кнопки подсвечивать ее активным цветом
      # и чтобы этот класс не перекрывал свойство активной кнопки
      $elem.removeClass(@.table.filled_form_class)


  # управляем видимостью информационного блока к фильтру
  toggle_status_bar: ->
    if $(@.form.container).filter(':visible').length > 0
      $(@.status_bar.container).hide()
    else
      $(@.status_bar.container).show()

  # проставляем всем формам и активирующим кнопкам статус «активно»
  # если внутри форм хотя бы одно поле заполнено
  toggle_filled_form_status: (elem) ->
    $forms = $(@.form.container)
    # пробежимся по каждому инпуту
    _.each($forms, (form) =>
      $form = $(form)
      # все инпуты,работающие на поиск содержат в названии параметр 'q'
      $inputs = $form.find('input, textarea, select').filter('[name*="q"]').not('input[type=submit]')
      # соеденим все заполненные значения вместе
      sum_vals = _.map($inputs, (input) -> $(input).val() ).join('')
      # не выбираем кнопку, у которой есть активный класс. Потому что данный алгоритм срабатывает после того,
      # как кнопке причислен активный класс,
      # а значит ей не нужно обновлять статус «заполнены ли у нее фильтрующие поля»
      $btn = @.find_activate_btn(form).not(".#{@.table.active_btn_class}")
      # если хотя бы одно поле заполнено,то длина суммарного значения более 0
      if sum_vals.length > 0
        $btn.addClass("#{@.table.filled_form_class} #{@.table.filled_form.replace('.','')}")
      # если поля пустые, то убираем класс выбранных значений
      else
        $btn.removeClass("#{@.table.filled_form_class} #{@.table.filled_form.replace('.','')}")
    )

  # очищаем инпуты внутри формы
  clear_inputs: (form) ->
    $form = $(form)
    $form.find('input, select, textarea').not('input[type=submit]').val('')


  # инициализация плагинов chosen и других
  init_plugins: ->
    $(@.container).find('.js-chosen').filter(':visible').chosen(global.chosen)
    $(@.container).find('.js-chosen-search').filter(':visible').chosen(global.chosen_search)



$ ->
  F = app.table_filter

  # клик по кнопке «имя фильтра»
  $(document).on('click', F.table.btn, (e) =>
    e.preventDefault()
    $target = $(e.target).closest(F.table.btn)
    F.toggle_form($target)

    # вначале выставляем цвет активной кнопке
    # а потом пробегаемся по неактивным кнопкам и проставляем им статус заполненности фильтра
    F.toggle_activate_btns_style($target)
    F.toggle_filled_form_status($target)
    F.toggle_status_bar()
  )

  # клик по кнопке «очистить»
  $(document).on('click', F.form.clear_btn, (e) =>
    e.preventDefault()

    $target = $(e.target).closest(F.form.clear_btn)
    $form = $target.closest(F.form.container)

    F.clear_inputs($form)
    $form.find('input[type=submit]').trigger('click')
  )

  # клик по кнопке «сбросить» направленной на весь фильтр
  $(document).on('click', F.status_bar.clear_btn, (e) =>
    e.preventDefault()

    $forms = $(F.form.container)

    F.clear_inputs($forms)
    $forms.first().find('input[type=submit]').trigger('click')
  )

  # клик по кнопке «изменить» направленной на весь фильтр
  $(document).on('click', F.status_bar.change_btn, (e) =>
    e.preventDefault()
    $(F.table.btn).filter(F.table.filled_form).first().trigger('click')
    F.toggle_status_bar()
  )
