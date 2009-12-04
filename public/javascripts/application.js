// Mouseovers
$(document).ready(function () {
	$(".snuffContentWrap").bind("mouseenter",function(event){
   		$(this).find('img').css({ margin:"-100px 0px 0px 0px", fontWeight:"bolder" });
    }).bind("mouseleave",function(event){
		$(this).find('img').css({ margin:"0px 0px 0px 0px", fontWeight:"bolder" });
    });	
});

// Ajax pick
$(document).ready(function () {
	$('.pickme').click(function(){ 
	
		$.ajax({
		    type: 'PUT',  //post
				data: ({
					'item_id' : $(this).parent().children('input').eq(0).get(0).value,
					'user_id' : $(this).parent().children('input').eq(1).get(0).value, 
					'authenticity_token' : AUTH_TOKEN }),
            	dataType: 'script', 
            	complete: function(request){
            },
            url: '/collections'
		})
		
		return false;
	});
});

//http://docs.jquery.com/Plugins/livequery#Download
