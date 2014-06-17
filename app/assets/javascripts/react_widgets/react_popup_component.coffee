`/** @jsx React.DOM */`

R = React.DOM


@ReactPopupComponent = React.createClass

  getDefaultProps: ->
    parent: ''


  getInitialState: ->
    opened: false

  componentDidMount: ->
    console.log $(@.props.parent).children()
    $(@.props.parent).children().on('click', =>
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
    console.log 'click'
    @.setState opened: !@.state.opened


  render: ->
    cx = React.addons.classSet
    className = cx(
      'hidden': @.state.opened==false
      'js-react-popup-component': true
    )
    console.log @.state.opened
    R.div({
      className: className
      ref: 'popup',
      dangerouslySetInnerHTML: {__html: @.props.body}
    })