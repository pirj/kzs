`/** @jsx R */`

R = React.DOM

@RangeDatepicker = React.createClass(
  displayName: "DatePicker"
  getDefaultProps: ->
    start_date_input_name: "start_date"
    finish_date_input_name: "finish_date"
    can_earlier_than_today: true
    start_date_min_date: null
    finish_date_max_date: null

  componentDidMount: ->
    _this = this
    $(".js-react-datepicker").datepicker _.extend(global.datepicker,
      onSelect: ->
        _this.handleChange()
        return
    )
    @handleChange()
    return

  renderStartEndDatePicker: (className, inputName) ->
    R.div
      className: "col-sm-2" + " " + className
    , R.div(
        className: "input-group"
      , R.div(
          className: "input-group-icon"
        , R.span(className: "fa fa-calendar")), R.input(
          className: "datepicker optional form-control js-react-datepicker form-control"
          name: inputName
          ref: className
          onChange: @handleChange
        ))

  handleChange: (e) ->
    today = new Date()
    todayDate = today.setHours(0)
    todayDate = today.setMinutes(0)
    today.setSeconds 0
    today.setMilliseconds 0
    startDateVal = @refs.start_date.getDOMNode().value
    finishDateVal = @refs.finish_date.getDOMNode().value
    startDate = moment(startDateVal, "DD.MM.YYYY")
    finishDate = moment(finishDateVal, "DD.MM.YYYY")
    startDateMINdate = undefined
    finishDateMAXdate = undefined
    if startDay.length > 10
      startDateMINdate = moment(@props.start_date_min_date)
      finishDateMAXdate = moment(@props.finish_date_max_date)
    else
      startDateMINdate = moment(@props.start_date_min_date, "DD.MM.YYYY")
      finishDateMAXdate = moment(@props.finish_date_max_date, "DD.MM.YYYY")
    if startDate > today
      $(@refs.finish_date.getDOMNode()).datepicker "option", "minDate", startDate._d
    else if ((startDateMINdate > today) and (@props.can_earlier_than_today is false)) or ((@props.start_date_min_date?) and (startDateVal is ""))
      $(@refs.start_date.getDOMNode()).datepicker "option", "minDate", startDateMINdate._d
      $(@refs.finish_date.getDOMNode()).datepicker "option", "minDate", startDateMINdate._d
    else if (startDate < today) and (@props.can_earlier_than_today is false)
      $(@refs.start_date.getDOMNode()).datepicker "option", "minDate", today
      $(@refs.finish_date.getDOMNode()).datepicker "option", "minDate", today
    else if (startDateMINdate > today) and (@props.can_earlier_than_today is true)
      $(@refs.start_date.getDOMNode()).datepicker "option", "minDate", null
      $(@refs.finish_date.getDOMNode()).datepicker "option", "minDate", startDate._d
    else
      $(@refs.finish_date.getDOMNode()).datepicker "option", "minDate", today

    @refs.finish_date.getDOMNode().value = ""  if startDate > finishDate  if startDateVal isnt "" and finishDateVal isnt ""
    send_obj =
      start_date: @refs.start_date.getDOMNode().value
      finish_date: @refs.finish_date.getDOMNode().value

    event_name = @props.nested_name + ".date_selection.date_range_component"
    $(document).trigger event_name, send_obj
    return

  render: ->

    #      console.log('render!');
     #R.div {}, [
     # @renderStartEndDatePicker("start_date", @props.start_date_input_name)
     # @renderStartEndDatePicker("finish_date", @props.finish_date_input_name)
    #]

    React.DOM.div({className: "row"},  [
      this.renderStartEndDatePicker("start_date", @.props.start_date_input_name)
      this.renderStartEndDatePicker("finish_date", @.props.finish_date_input_name)

    ]);
)