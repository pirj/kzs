(($) ->
  methods =
    init: (options) ->
      @each ->
        $(window).bind "click.js-popover", methods.show
        return

    show: ->
      e.preventDefault()
      target = $('.js-popover').dataset.target
      $sourcePopover = $('.js-popover-content[data-target=' + target + ']')

      $('.js-popover').toggleClass('active')
      if $('.js-popover').hasClass('active')
        $sourcePopover.clone(true).appendTo(document.body).addClass('cloned')
        $('.cloned').show().find('form').css
          maxWidth: "740px",
          width: "740px"
        $sourcePopover.hide()
      else
        $('.cloned').remove()

    placement: ->
      popoverClone = $(".js-popover-content.cloned")
      activeBtnHeight = $('.js-popover').outerHeight()
      activeBtnWidth = $('.js-popover').outerWidth()
      activeBtnOffset = $('.js-popover').offset()
      popoverHeight = popoverClone.outerHeight()
      popoverWidth = popoverClone.outerWidth()
      currentTop = activeBtnOffset.top
      currentLeft = activeBtnOffset.left
      docHeight = $(document).outerHeight()
      docWidth = $(document).outerWidth()

      offset = popoverClone.offset()
      vert = 0.5 * docHeight - currentTop
      vertPlacement = (if vert > 0 then "bottom" else  "top")
      horiz = 0.5 * docWidth - currentLeft
      horizPlacement = (if horiz > 0 then "right" else "left")
      placement = (if Math.abs(horiz) > Math.abs(vert) then horizPlacement else vertPlacement)
      popoverClone.addClass(placement)



      if popoverClone.hasClass('bottom')
        popoverClone.css
          top:  currentTop + activeBtnHeight + "px"
          left: (currentLeft + activeBtnWidth/2) - popoverWidth/2  + "px"
      else if popoverClone.hasClass('top')
        popoverClone.css
          top:  currentTop - activeBtnHeight/2 - popoverHeight + "px"
          left: (currentLeft + activeBtnWidth/2) - popoverWidth/2  + "px"
      else if popoverClone.hasClass('right')
        popoverClone.css
          top:  currentTop - popoverHeight/2 + activeBtnHeight/2 + "px"
          left: currentLeft + activeBtnWidth + activeBtnHeight/2 + "px"
      else if popoverClone.hasClass('left')
        popoverClone.css
          top:  currentTop - popoverHeight/2 + activeBtnHeight/2 + "px"
          left: currentLeft - popoverWidth - activeBtnHeight/2 + "px"
      else if popoverClone.hasClass('bottom left')
        popoverClone.css
          top:  currentTop - popoverHeight/2 + activeBtnHeight/2 + "px"
          left: currentLeft - popoverWidth - activeBtnHeight/2 + "px"

      # ...
    hide: ->
      $('.js-popover-content').hide()
      $('.js-popover').removeClass('active')
      return

      # ...
    update: (content) ->


      # ...


  $.fn.popover = (method) ->
  return
) jQuery