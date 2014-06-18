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

  componentDidMount: ->
    $(@.props.parent).children().on('click', =>
      @.handleParentClick()
    )

    @.handleOutsideClick(=> @.setState opened: false )


  handleOutsideClick: (callback)->
    popup = @.refs.popup.getDOMNode()
    event = (e) =>
      el = $(e.target);
      unless el.closest(popup).length || el.closest(@.props.parent).length
        callback()
    #off()

    document.body.addEventListener('click', event, false)


  componenDidUnmount: ->
    document.body.removeEventListener('click')


  handleParentClick: ->
    @.setState opened: !@.state.opened


  renderPopup: (body) ->
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