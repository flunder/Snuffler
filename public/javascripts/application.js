$(document).ready(function () {
	$(".snuffContentWrap").bind("mouseenter",function(event){
   		$(this).find('img').css({ margin:"-100px 0px 0px 0px", fontWeight:"bolder" });
    }).bind("mouseleave",function(event){
		$(this).find('img').css({ margin:"0px 0px 0px 0px", fontWeight:"bolder" });
    });
	
});


