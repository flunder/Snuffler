$(document).ready(function () {
	
	range = 0; // initalize global var
	var interval;
	
	if ($('#results div[class*="snuff"]').attr('class') != 'snuffWrapLarge') { 
		interval = 0;
		range = 100; 
	} else { 
		interval = 700;
		range = 40; 
	}
	
	var config = {    
	     sensitivity: 3, // number = sensitivity threshold (must be 1 or higher)    
	     interval: interval, // number = milliseconds for onMouseOver polling interval    
	     over: pullUp, 
	     timeout: 500, // number = milliseconds delay before onMouseOut    
	     out: pullDown 
	};
	
	$(".snuffName").hoverIntent(config)	
	
	// flash messages 
	$('.flashmsg').delay(6000).slideUp(300);
	
});

function pullUp() {
	$(this).parent().find('img').animate({ marginTop : "-="+range }, 100 ); 
}

function pullDown() {
  	$(this).parent().find('img').animate({ marginTop : "+="+range }, 300 ); 
}

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
/*	
	$('.next').click(function(){
		
		$.ajax({
		    type: 'PUT',  //post
				data: ({
					'item_id' : 'x',
					'user_id' : 'y', 
					'authenticity_token' : AUTH_TOKEN }),
            	dataType: 'script', 
            	complete: function(request){
            },
            url: '/next'
		})
		return false;
	})
*/
});

//http://docs.jquery.com/Plugins/livequery#Download
