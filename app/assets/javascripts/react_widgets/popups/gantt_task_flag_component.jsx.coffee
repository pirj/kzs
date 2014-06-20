`/** @jsx React.DOM */`

R = React.DOM

@FlagPopup = React.createClass
  mixins: [PopupMixin]


  getDefaultProps: ->
    opened: false

  render: ->
    @.renderPopup(@.props.json)

