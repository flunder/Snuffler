$(document).ready(function () {
	
	var range;
	if ($('#results > div').attr('class') != 'snuffWrapLarge') { range = 100; } else { range = 40; }
	
	$(".snuffContentWrap").bind("mouseenter",function(event){
   	$(this).find('img').animate({ marginTop : "-="+range }, 100 ); 
  }).bind("mouseleave",function(event){
		$(this).find('img').animate({ marginTop : "+="+range }, 300 ); 
	})
	
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
