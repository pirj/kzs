`/** @jsx React.DOM */`

###
  React Mixin для отрисовки popup окон

  интерфейс использования
    parent — класс родительского элемента, клики по которому активируют popup
    renderPopup(html) — метод для отрисовки popup с любым html контентом

###

R = React.DOM


@PopupMixin =

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
    $(document).on('click', @.props.parent, => @.handleParentClick() )
    @.handleOutsideClick(=> @.PopupHide())

  # убираем все ивенты при уничтожении компонента
  popupDidUmnount: ->
    document.body.removeEventListener('click')

  # метод скрытия всплывающего окна
  handleParentClick: ->
    @.setState opened: !@.state.opened


  # метод скрытия всплывающего окна
  PopupHide: ->
    @.setState opened: false


  # переключаем состояние всплывающего окна
  popupToggle: ->
    @.props.onPopupToggle(@.state.opened)

  # рендерим попап и передаем готовый html внутрь
  renderPopupHtml: (body) ->
    R.div({
      className: @._popupClassName()
      ref: 'popup',
      dangerouslySetInnerHTML: {__html: body}
    })

  # рендерим попап и передаем react-dom массив
  renderPopup: (body) ->
    R.div({
      className: @._popupClassName()
      ref: 'popup'
    }, body)


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
      'hidden': @.state.opened == false
      'js-react-popup-component': true
    )
  # ==================================================================================