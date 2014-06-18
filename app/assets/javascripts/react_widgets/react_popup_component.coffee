`/** @jsx React.DOM */`

R = React.DOM

@ReactPopupComponent = React.createClass
  mixins: [PopupMixin]

  getDefaultProps: ->
    body: ''


  render: ->
    @.renderPopup(@.props.body)
