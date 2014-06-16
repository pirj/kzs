`/** @jsx React.DOM */`

R = React.DOM


#PopupMixin =
  

@ReactPopupComponent = React.createClass

  getDefaultProps: ->
    parent: ''


  getInitialState: ->
    opened: false

  componentDidMount: ->
    $(@.props.parent).on('click', =>
      @.handleParentClick()
    )

    @.handleOutsideClick( => @.setState opened: false)


  handleOutsideClick: (callback)->
    popup = @.refs.popup.getDOMNode()
    event = (e) =>
      el = $(e.target);
      unless el.closest(popup).length || el.hasClass(@.props.parent.replace('.',''))
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
    R.div({className: className, ref: 'popup'}, 'react popup component rendered')