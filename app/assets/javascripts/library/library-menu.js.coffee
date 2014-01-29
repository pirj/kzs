$ ->
  ( ->
    # find all top-heading h2
    # and render main link.
    # by each top-heading find subheading h5
    # and for each subheading render sub-link.
    # $('h2').not('.bs-example h2').first().parent('div').find('h5').not('.bs-example h5')

    window.library = {}
    menu = [] # this html will be rendered

    library.link_to = (id, title) ->
      id = id ? '#'
      id = id.replace('#','') ? ''
      "<li><a href='#{id}'>#{title}</a></li>"

    # all top-headers
    $headers = $('h2').not('.bs-example h2')

    menu.push('<ul class="lib-menu">')
#    menu.push('asd')
    # construct headers-link and sub-headers link
    _.each($headers, (h) ->
      $h = $(h)
      menu.push( library.link_to($h.attr('id'), $h.text()) )
      $subhs = $h.parents('.row').first().find('h5').not('.bs-example h5')

      console.log $subhs

      if $subhs.length > 0
        menu.push('<li><ul class="">')
        _.each($subhs, (subh) ->
          $subh = $(subh)
          menu.push( library.link_to($subh.attr('id'), $subh.text()) )
        )
        menu.push('</ul></li>')
    )

    menu.push('</ul>')
    console.log menu.join('')
    # render menu
    $('.js-library-menu').html(menu.join(''))
  )()
