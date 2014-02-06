#grouped collection select filterj-car-type

jQuery ->




  $("#permit_way_bill").on "change", ->
    $(".permit_drivers").toggle()



#  carBrands = $('#permit_vehicle_fields optgroup' )
#
#  $('#permit_vehicle_attributes_vehicle_body').change ->
#
#     #active-result result-selected
#
#    carBrancdGroup = $('#permit_vehicle_attributes_brand_chosen .chosen-results .group-result')
#
#
#    selectedType = $('#permit_vehicle_attributes_vehicle_body_chosen .chosen-single')[0].children[0].innerText #удаляем обертку
#
#    targetMark = _.filter(carBrands, (list) ->
#      return list.label is selectedType
#    )

  #$('permit_vehicle_attributes_brand_chosen').



#  states = $('#person_state_id').html()
#  console.log(states)
#  $('#person_country_id').change ->
#    country = $('#person_country_id :selected').text()
#    escaped_country = country.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
#    options = $(states).filter("optgroup[label=#{escaped_country}]").html()
#    console.log(options)
#    if options
#      $('#person_state_id').html(options)
#      $('#person_state_id').parent().show()
#    else
#      $('#person_state_id').empty()
#      $('#person_state_id').parent().hide()