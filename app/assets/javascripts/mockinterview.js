$(function() {
    $(".datepicker").datepicker( { minDate: "+2D", maxDate: "+1M" });
    
    $(".ui-selectee").click(function() {
	if ($(this).hasClass("ui-selected")) {
	    $(this).removeClass("ui-selected");
	} else {
	    $(this).addClass("ui-selected");
	}
    });
    
    // Validation (Only works with input fields)
    $.validator.addMethod("selectCheck", function(value, element) {
    	return ($(".ui-selected").length <= 3);
    }, "You may only choose up to three preferences.");
    
    $("#mockint_form").submit(function() {
		$(this).validate();    
    	var valid = $(this).valid();
    
		if (valid && $(".ui-selected").length <= 3) {
			for (var i=0; i < $(".ui-selected").length; i=i+1) {
			var pictureID = $(".ui-selected")[i].id;
			var idToQuery = "#pref"+(i+1);
			$(idToQuery).val(pictureID);
			}
		} 
		
		return valid;
    });
});
