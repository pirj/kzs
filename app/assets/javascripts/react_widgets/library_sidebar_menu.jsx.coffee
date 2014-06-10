`/** @jsx React.DOM */`

###
menu_obj =
  [
    id: header_id
    title: header_text
    parent: parent_header_id
  ]


  Рендер подразумевает следующую структуру документа
  .js-library-row
    ... (some elements)
      .js-library-header TITLE
      .js-library-subheader TITLE
      ...
        .js-library-subheader TITLE
###
R = React.DOM

@LibrarySidebarMenu = React.createClass

  getInitialState: ->
    menu_obj = {}

  build_menu_obj: ->
    # выбираем заголовки только те, что относятся к заголовкам разделам, но не примерам
    headers =  $('.js-library-header')
    subheaders = $('.js-library-subheader')
    # главные ноды в меню
    new_menu_obj = []
    _.each(headers,  (el) ->
      obj =
        id: el.id
        title: el.textContent
        parent_id: null

      new_menu_obj.push obj
    )

    _.each(subheaders, (el) ->
      console.log el
      obj =
        id: el.id
        title: el.textContent
        parent_id: $(el).closest('.js-library-row').find('.js-library-header')[0].id
      new_menu_obj.push obj
    )

    window.arr = new_menu_obj

    @.setState menu_obj: new_menu_obj


  componentDidMount: ->
    @.build_menu_obj()



  render: ->
    @.state.menu_obj
    items = []

    if _.isArray(@.state.menu_obj)
      items = @.state.menu_obj.map((el, i) =>
        if el.parent_id == null
          content = []
          content.push R.a({href: "##{el.id}"}, el.title)
          submenu = _.where(@.state.menu_obj, {parent_id: el.id})
          if submenu.length
            content.push R.ul({}, submenu.map((sub_el) =>
              R.li({}, R.a({href: "##{sub_el.id}"}, sub_el.title))
            ))
          R.li({}, content)
      )
    R.div({}, items)