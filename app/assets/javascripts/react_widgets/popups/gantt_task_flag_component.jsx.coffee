`/** @jsx React.DOM */`

R = React.DOM

@FlagPopup = React.createClass
  mixins: [PopupMixin]

#  console.log('wasd')

  getDefaultProps: ->
    opened: false

  render: ->
    @.renderPopup(@.props.body)

