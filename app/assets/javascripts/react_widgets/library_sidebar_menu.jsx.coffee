`/** @jsx React.DOM */`

###
menu_obj =
  [
    id: header_id
    link: #header_id
    title: header_text
    parent: parent_header_id
  ]
###
R = React.DOM

@LibrarySidebarMenu = React.createClass

  props:
    header: 'h2'
    subheader: 'h3'


  getInitialState: ->
    menu_obj = {}

  build_menu_obj: ->
    console.log headers =  $(@.props.header)


  componentDidMount: ->
    @.build_menu_obj()



  render: ->
    @.state.menu_obj