`/** @jsx React.DOM */`

###
  React Mixin для отрисовки popup окон

  интерфейс использования
    parent — класс родительского элемента, клики по которому активируют popup
    renderPopup(html) — метод для отрисовки popup с любым html контентом

###

R = React.DOM


@PopupMixin =

  getDefaultProps: ->
    parent: ''

  getInitialState: ->
    opened: false

  propTypes:
    onPopupToggle: React.PropTypes.func

  # обработка кликов снаружи всплывающего окна
  handleOutsideClick: (callback)->
    popup = @.refs.popup.getDOMNode()
    event = (e) =>
      el = $(e.target);
      unless el.closest(popup).length || el.closest(@.props.parent).length
        callback()
    document.body.addEventListener('click', event, false)


  # наклеиваем взаимодействие с пользователем, после того, как компонент отрисовался
  # в этот момент уже есть dom и к нему можно обращаться
  componentDidMount: ->
    $(document).on('click', @.props.parent, =>
      @.handleParentClick()
    )

    @.handleOutsideClick(=> @.PopupHide() )

  componenDidUnmount: ->
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


  # после перерисовки компонента отсылаем текущий статус всем компонентам,
  # которые подписаны на это свойство
  componentDidUpdate: ->
    @.popupToggle()


  renderPopupHtml: (body) ->
    cx = React.addons.classSet
    className = cx(
      'hidden': @.state.opened == false
      'js-react-popup-component': true
    )
    R.div({
      className: className
      ref: 'popup',
      dangerouslySetInnerHTML: {__html: body}
    })


  renderPopup: (body) ->
    cx = React.addons.classSet
    className = cx(
      'hidden': @.state.opened == false
      'js-react-popup-component': true
    )
    R.div({
      className: className
      ref: 'popup'
    }, body)