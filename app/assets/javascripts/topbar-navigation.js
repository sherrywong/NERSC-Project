$(function() {
    
    // DOESN'T WORK D:
    /*
    $("#upe_logo").click(function(event) {
    	event.preventDefault();
    	$.ajax({
    		url: "/",
    		dataType: "json",
    		success: function(response) {
    			$("#main-content").html(response.html);
    		}
    	});
    }); 
    */
    $("#studentservices").click(function(event) {
	event.preventDefault();
        $(".active").removeClass("active");
	$.ajax({
	    url: "/student_services",
	    dataType: "json",
	    success: function(response) {
		$("#main-content").html(response.html);
	    }
	});
        $(this).parent().addClass("active");
    });

    $("#industryservices").click(function(event) {
	event.preventDefault();
        $(".active").removeClass("active");
	$.ajax({
	    url: "/industrial_relations",
	    dataType: "json",
	    success: function(response) {
		$("#main-content").html(response.html);
	    }
	});
        $(this).parent().addClass("active");
    });

    $("#aboutus").click(function(event) {
	event.preventDefault();
        $(".active").removeClass("active");
	$.ajax({
	    url: "/about_us",
	    dataType: "json",
	    success: function(response) {
		$("#main-content").html(response.html);
	    }
	});
        $(this).parent().addClass("active");
    });

    $("#events").click(function(event) {
	event.preventDefault();
        $(".active").removeClass("active");
	$.ajax({
	    url: "/events",
	    dataType: "json",
	    success: function(response) {
		$("#main-content").html(response.html);
	    }
	});
        $(this).parent().addClass("active");
    });

    $("#members").click(function(event) {
	event.preventDefault();
        $(".active").removeClass("active");
	$.ajax({
	    url: "/members",
	    dataType: "json",
	    success: function(response) {
		$("#main-content").html(response.html);
	    }
	});
        $(this).parent().addClass("active");
    });

    $("#login").click(function() {
       if ($(".dropdown-menu").is(":visible")) {
       		$(".dropdown-menu").slideUp();
       } else {
    		$(".dropdown-menu").slideDown();
       }
    });

    $(".dropdown-menu").click(function(e) {
       if (e.stopPropagation) {
          e.stopPropagation();
       }
    });

    $(document).click(function() {
       if ($(".dropdown-menu").is(":visible")) {
           $(".dropdown-menu").slideUp();
       }
    });
    
    $(".login_input").hover(function() {
    	$(this).css("background-color", "#FFFFFF");
    }, function() {
    	$(this).css("background-color", "#CCC");
    });
});