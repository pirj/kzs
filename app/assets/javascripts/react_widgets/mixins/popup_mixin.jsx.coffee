`/** @jsx React.DOM */`

###
  React Mixin для отрисовки popup окон

  интерфейс использования
    parent — класс родительского элемента, клики по которому активируют popup
    renderPopup(html) — метод для отрисовки popup с любым html контентом

###

R = React.DOM


@PopupMixin =

  placement: null
  # API ZONE

  # обработка кликов снаружи всплывающего окна
  handleOutsideClick: (callback)->
    popup = @.refs.popup.getDOMNode()
    event = (e) =>
      el = $(e.target);
      unless el.closest(popup).length || el.closest(@.props.parent).length
        callback()
    document.body.addEventListener('click', event, false)


  # вешаем обработчики кликов на родителе или вне попапа
  popupDidMount: ->
    $(document).on('mouseup', @.props.parent, => @.handleParentClick() )
    @.handleOutsideClick(=> @.popupHide())

  # убираем все ивенты при уничтожении компонента
  popupDidUmnount: ->
    document.body.removeEventListener('click')

  # метод обрабатывающий клик по родительской кнопки для данного окна
  #
  # внутри также идет расчет местоположения текущего всплывающего окна,
  # т.к.возможно асинхронное поведение,
  # это когда всплывающее окно рисуется первее родительской кнопки
  handleParentClick: ->
    console.log @.props.parent
    @._calculatePosition() if @.refs.hasOwnProperty('popup')
    @.setState opened: !@.state.opened


  # метод скрытия всплывающего окна
  popupHide: (e=null)->
    e.preventDefault() if _.isObject(e)
    @.setState opened: false


  # переключаем состояние всплывающего окна
  popupToggle: ->
    @.props.onPopupToggle(@.state.opened)

  # рендерим попап и передаем готовый html внутрь
  renderPopupHtml: (body) ->
    R.div({
      className: @._popupClassName()
      ref: 'popup'
    },[
      R.span({className: 'arrow'}),
      R.div({dangerouslySetInnerHTML: {__html: body}})
    ])

  # рендерим попап и передаем react-dom массив
  renderPopup: (body) ->
    R.div({
      className: @._popupClassName()
      ref: 'popup'
    },[
      R.span({className: 'arrow'}),
      R.div({},body)
    ])


  # ==================================================================================


  # DEFAULT ZONE

  # наклеиваем взаимодействие с пользователем, после того, как компонент отрисовался
  # в этот момент уже есть dom и к нему можно обращаться
  # тесты показали, что эти методы выполняются первее методов, вызванных из потомка, где подключается mixin
  componentDidMount: ->
    @.popupDidMount()

  componenDidUnmount: ->
    @.popupDidUmnount()

  # после перерисовки компонента отсылаем текущий статус всем компонентам,
  # которые подписаны на это свойство
  componentDidUpdate: ->
    @.popupToggle()

  getDefaultProps: ->
    parent: ''
    onPopupToggle: ->

  getInitialState: ->
    opened: false

  propTypes:
    onPopupToggle: React.PropTypes.func

  # ==================================================================================


  # PRIVATE ZONE

  # возвращает css имя классов для контейнера всплывающего окна
  _popupClassName: ->
    cx = React.addons.classSet
    className = cx(
      'm-active': @.state.opened == true
      'js-react-popup-component popover': true
    )

    className += " #{@.placement}"



  _calculatePosition: ->
    $parent = $(@.props.parent)
    $popup = $(@.refs.popup.getDOMNode())

    $popup.css({width: '550px'})

    activeBtnHeight = $parent.outerHeight()
    activeBtnWidth = $parent.outerWidth()
    activeBtnOffset = $parent.offset()

    currentTop = activeBtnOffset.top
    currentLeft = activeBtnOffset.left

    popoverCloneOffset = $popup.offset()
    popoverHeight = $popup.outerHeight()
    popoverWidth = $popup.outerWidth()
    docHeight = $(document).outerHeight()
    docWidth = $(document).outerWidth()

    offset = $popup.offset()
    vert = 0.5 * docHeight - currentTop
    vertBalance = docHeight - currentTop
    vertPlacement = (if vert > 0 then "bottom" else  "top")

    horiz = 0.5 * docWidth - currentLeft
    horizBalance = docWidth - currentLeft
    horizPlacement = (if horiz > 0 then "right" else "left")

    aslantPlacement = (
      if currentLeft > horizBalance and currentTop > vertBalance
        "top-left"
      else if currentLeft > horizBalance and currentTop < vertBalance
        "bottom-left"
      else if currentLeft < horizBalance and currentTop > vertBalance
        "top-right"
      else
        "bottom-right"
    )

    placement = (
      if docHeight - (popoverCloneOffset.top + popoverHeight) < 0 || docHeight - (vertBalance + popoverHeight) < 0 || docWidth - (popoverCloneOffset.left + popoverWidth) < 0 || docWidth - (horizBalance + popoverWidth) < 0
        aslantPlacement
      else
        if Math.abs(horiz) > Math.abs(vert)
          horizPlacement
        else
          vertPlacement
    )
    #положение можно задать напрямую в placement = "right" например
    @.placement = placement

    #arrow position formula
    balancePopoverWidth = popoverWidth - activeBtnWidth
    arrowPosRight = balancePopoverWidth + activeBtnWidth / 2
    arrowPosLeft = popoverWidth - balancePopoverWidth - activeBtnWidth / 2

    if $popup.hasClass('bottom')
      $popup.css
        top: currentTop + activeBtnHeight + "px"
        left: (currentLeft + activeBtnWidth / 2) - popoverWidth / 2 + "px"
    else if $popup.hasClass('top')
      $popup.css
        top: currentTop - activeBtnHeight / 2 - popoverHeight + "px"
        left: (currentLeft + activeBtnWidth / 2) - popoverWidth / 2 + "px"
    else if $popup.hasClass('right')
      $popup.css
        top: currentTop - popoverHeight / 2 + activeBtnHeight / 2 + "px"
        left: currentLeft + activeBtnWidth + activeBtnHeight / 2 + "px"
    else if $popup.hasClass('left')
      $popup.css
        top: currentTop - popoverHeight / 2 + activeBtnHeight / 2 + "px"
        left: currentLeft - popoverWidth - activeBtnHeight / 2 + "px"
    else if $popup.hasClass('bottom-left')
      $popup.css
        top: currentTop + activeBtnHeight + "px"
        left: (currentLeft - popoverWidth) + activeBtnWidth + "px"
      $popup.find('.arrow').css
        left: arrowPosRight + "px"
    else if $popup.hasClass('bottom-right')
      $popup.css
        top: currentTop + activeBtnHeight + "px"
        left: currentLeft + "px"
      $popup.find('.arrow').css
        left: arrowPosLeft + "px"
    else if $popup.hasClass('top-left')
      $popup.css
        top: currentTop - activeBtnHeight / 2 - popoverHeight + "px"
        left: (currentLeft - popoverWidth) + activeBtnWidth + "px"
      $popup.find('.arrow').css
        left: arrowPosRight + "px"
    else if $popup.hasClass('top-right')
      $popup.css
        top: currentTop - activeBtnHeight / 2 - popoverHeight + "px"
        left: currentLeft + "px"
      $popup.find('.arrow').css
        left: arrowPosLeft + "px"


  # ==================================================================================