$('table').html("<%=j render :partial => 'table', :@documents => @documents %>");

$('.document_operation').on("change", function() {
	elem = $(this)
	myFunction(elem);
});

$('#select_all_documents').on("click", function() {	
	$(document).find(':checkbox').prop('checked', this.checked);
	myFunction();
});

$(function() {
	var searchString = $("#query").val();
	if ($("tr").length <= 1){
		$('#document_table').html("<tr class='inform'><td colspan='9'>По запросу &laquo;"+ searchString +"&raquo; - ничего не найдено.</td></tr>");
	}
});
$("tbody tr").click(appendTr);
$("tbody td.not_this").click(function(e){
    e.stopPropagation()
});

