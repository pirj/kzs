`/** @jsx React.DOM */`

###
Как работает?

  Этот компонент связвается с parent по уникальному имени класса.
  Связь происходит при инициализации,в то самое время навешиваются и все события и т.д.

  При клике на parent переключаем state между состояниями «показывать» и «скрыть».

  При клике вне попапа и parent скрываем окно
###

R = React.DOM


@ReactPopupComponent = React.createClass

  getDefaultProps: ->
    parent: ''


  getInitialState: ->
    opened: false

  componentDidMount: ->
    $(@.props.parent).children().on('click', =>
      @.handleParentClick()
    )

    @.handleOutsideClick( => @.setState opened: false)


  handleOutsideClick: (callback)->
    popup = @.refs.popup.getDOMNode()
    event = (e) =>
      el = $(e.target);
      unless el.closest(popup).length || el.closest(@.props.parent).length
        callback()
        #off()

    document.body.addEventListener('click', event, false)


  handleParentClick: ->
    @.setState opened: !@.state.opened


  render: ->
    cx = React.addons.classSet
    className = cx(
      'hidden': @.state.opened==false
      'js-react-popup-component': true
    )
    R.div({
      className: className
      ref: 'popup',
      dangerouslySetInnerHTML: {__html: @.props.body}
    })