`/** @jsx React.DOM */`

R = React.DOM

@FlagPopup = React.createClass
  mixins: [PopupMixin]

  getDefaultProps: ->
    body: ''


  render: ->
    @.renderPopup(@.props.body)
