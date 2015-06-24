// JavaScript Document

var looking_for_timer = 0;
var looking_for_slideup = function () {
	$(".looking-for ul.hidden").slideUp(500);
};
var looking_for_slidedown = function () {
	$(".looking-for ul.hidden").slideDown(500);
};
var location_timer = 0;
var location_slideup = function () {
	$(".choose-location ul").slideUp('normal',function(){
		$(".locations").addClass("no-border");
		$(".choose-location").removeClass("choose-location-open");
	});
};
var location_slidedown = function () {
	$(".locations").removeClass("no-border");
	$(".choose-location").addClass("choose-location-open");
	$(".choose-location ul").slideDown('normal');
};
var tools_timer = 0;
var tools_slideup = function () {
	$(".site-tools").removeClass("site-tools-open");
	$(".site-tools ul").slideUp('normal');
};
var tools_slidedown = function () {
	$(".site-tools").addClass("site-tools-open");
	$(".site-tools ul").slideDown('normal');
};
var news_strip=0;
var news_slider_stop=0;
var news_strip_stop=0;
var font_size = 62.5;

$('.dropdown').click(function (){
	$(this).find('ul:first').slideToggle('normal');																	
});

$(document).ready(function(){
	$(".home_search label").css("left","10px");
	$(".search_field").focus(function(){
		$(".home_search label").css("left","-999em");
	}).blur(function(){
		if(this.value==""){
			$(".home_search label").css("left","10px");
		}
	});
	$(".languages-nav").addClass("languages-nav-script");
	$(".looking-for").mouseover(function () {
		clearTimeout(looking_for_timer);
		looking_for_timer = setTimeout("looking_for_slidedown()", 300);
	}).mouseout(function () {
		clearTimeout(looking_for_timer);
		looking_for_timer = setTimeout("looking_for_slideup()", 300);							 
	});
	$(".choose-location").hover(function () {
		clearTimeout(location_timer);
		location_timer = setTimeout("location_slidedown()", 400);
	},function () {
		clearTimeout(location_timer);
		location_timer = setTimeout("location_slideup()", 400);	
	});
	$(".site-tools").hover(function () {
		clearTimeout(tools_timer);
		tools_timer = setTimeout("tools_slidedown()", 400);
	},function () {
		clearTimeout(tools_timer);
		tools_timer = setTimeout("tools_slideup()", 400);	
	});
	news_strip = $(".news-strip ul li");
	for(i=1;i<news_strip.length;i++){
		$(".news-strip ul li:eq("+i+")").hide();
	}
	$(".latest_news_left").click(function(){
		$(".news-strip ul").animate({"top":"30px"},250,function(){			
			$(".news-strip ul li").hide();
			$(".news-strip ul li:eq("+news_strip_stop+")").show();														
		});
		news_strip_stop--;
		if(news_strip_stop==-1){
			news_strip_stop=news_strip.length-1;
		};
		$(".news-strip ul").animate({"top":0},250);
	});
	
	setInterval("latest_news_right()", 5000);
	
	var news_slider_navs = $(".news-slider ul li");
	var newssliderWidth = (news_slider_navs.length - 3) *315;
	var slideAreaWidth = 386; //total width minus width of scrubber with padding
	var slideRatio = newssliderWidth/slideAreaWidth;
	$(".news-slider-nav .arrow-left").addClass('active');
	$(".news-slider-nav .arrow-left").click(function(){
		$(".stop").removeClass("active");
		if(news_slider_stop!=0){
			news_slider_stop--;
			$(".stop:eq("+news_slider_stop+")").addClass("active");
			$(".news-slider ul").animate({left:-1*news_slider_stop*315},500,"easeInOutCirc");
			$(".scroller").animate({"left":-1*news_slider_stop*315/(-1 * slideRatio)}, 500,"easeInOutCirc");
		}
		checkArrowState();
	});
	$(".news-slider-nav .arrow-right").click(function(){
		var elements = $(".news-slider ul");
		var stops = elements.children()
		stops = stops.length-3;
		if(news_slider_stop<stops){
			news_slider_stop++;
			$(".stop").removeClass("active");
			$(".stop:eq("+news_slider_stop+")").addClass("active");
			$(".news-slider ul").animate({left:-1*news_slider_stop*315},500,"easeInOutCirc");
			$(".scroller").animate({"left":-1*news_slider_stop*315/(-1 * slideRatio)}, 500,"easeInOutCirc");
		}
		checkArrowState();
	});
	for (i=0;i<news_slider_navs.length;i++){
		$(".arrow-right").before('<li class="stop"><img src="images/news_slider_dot.gif" alt="" title="" rel="'+i+'" /></li>');	
	}
	$(".stop:eq(0)").addClass("active");
	$(".stop").click(function() {
		$(".stop").removeClass("active");
		news_slider_stop = $(this).addClass("active").children().attr("rel");
		$(".news-slider ul").animate({left:-1*news_slider_stop*315},500,"easeInOutCirc");
		var elements = $(".news-slider ul");
		var stops = elements.children()
		stops = stops.length-3;
		if(news_slider_stop > stops) {
			$(".scroller").animate({"left":-1*stops*315/(-1 * slideRatio)}, 500,"easeInOutCirc");
		} else {
			$(".scroller").animate({"left":-1*news_slider_stop*315/(-1 * slideRatio)}, 500,"easeInOutCirc");
		}
	});
	$(".scroller").draggable({axis: "x", containment: "parent", 'drag': function () {	
		$(".news-slider ul").css("left", parseFloat($(".scroller").css("left"))* -1 * slideRatio);
		var news_slider_check = -1 * (parseFloat($(".news-slider ul").css("left")) / 315);
		news_slider_check = Math.round(news_slider_check);
		if (news_slider_check != news_slider_stop) {
			news_slider_stop = news_slider_check;
			$(".stop").removeClass("active");
			$(".stop:eq("+news_slider_stop+")").addClass("active");
		}
		checkArrowState();
	}});
	function checkArrowState(){		
		if(-1*news_slider_stop*315/(-1 * slideRatio) < 386){	
			$(".news-slider-nav .arrow-right").removeClass('active');
		}else{
			$(".news-slider-nav .arrow-right").addClass('active');
		}
		if(news_slider_stop!=0){
			$(".news-slider-nav .arrow-left").removeClass('active');
		}else{
			$(".news-slider-nav .arrow-left").addClass('active');
		}
	}
	
	$(".print-page").click(function(){print();});
	if(readCookie('fontsize')){
		font_size = Number(readCookie('fontsize'));		
		$("body").css("font-size",font_size+"%");
		if(font_size==50.5){
			$(".font-down").css("opacity","0.2");
		}
		if(font_size==74.5){
			$(".font-up").css("opacity","0.2");
		}
	}
	$(".font-up").click(function(){
		if(font_size!=74.5){
			$(this).css("opacity","1");
			$(".font-down").css("opacity","1");
			font_size+=4;
			$("body").css("font-size",font_size+"%");
			if(font_size==74.5){
				$(this).css("opacity","0.2");
			}
			createCookie('fontsize',font_size,0);
		}
	});
	$(".font-down").click(function(){
		if(font_size!=50.5){									   			
			$(this).css("opacity","1");
			$(".font-up").css("opacity","1");
			font_size-=4;
			$("body").css("font-size",font_size+"%");
			if(font_size==50.5){
				$(this).css("opacity","0.2");
			}
			createCookie('fontsize',font_size,0);
		}
	});
	$("#li"+contentId).addClass("active");
	if(authenticated){
	    $("li.HideAuthenticated").remove();
	} else {
	    $("li.HideAnonymous").remove();
	};
	$(".file-list .titlelink").hover(function(){$(this).next().removeClass("abstract");},function(){$(this).next().addClass("abstract");});
	$(".bios .full").css({"display":"none"});
	$(".read_more").css("visibility","visible").click( function () {
        var temp = $(this).parent();
        $(this).next(".full").css("display","inline");
        $(this).hide();
    });
    $(".read_less").click( function () {
        var temp = $(this).parent();
        $(this).parent().hide();
        $(temp).prev(".read_more").show();
    }); 
});	

function latest_news_right(){
	$(".news-strip ul").animate({"top":"30px"},250,function(){			
		$(".news-strip ul li").hide();
		$(".news-strip ul li:eq("+news_strip_stop+")").show();														
	});
	news_strip_stop++;
	if(news_strip_stop==news_strip.length){
		news_strip_stop=0;
	};
	$(".news-strip ul").animate({"top":0},250);
}

var clearview = {
	src: '/swf/clearview.swf'
	,wmode: 'transparent'
};

sIFR.activate(clearview); // From revision 209 and onwards

sIFR.replace(clearview, {
	selector: '.news-slider li h3'
	,css: {
		'.sIFR-root': { 'color': '#878684', 'text-transform': 'uppercase'   }
 	}
});

var clearview_center = {
	src: '/swf/clearview_center.swf'
	,wmode: 'transparent'
};

sIFR.activate(clearview_center); // From revision 209 and onwards

sIFR.replace(clearview_center, {
	selector: '.looking-for h4'
	,css: {
		'.sIFR-root': { 'color': '#FFFFFF' }
 	}
});

sIFR.replace(clearview_center, {
	selector: '.related-info h4'
	,css: {
		'.sIFR-root': { 'color': '#333333' }
 	}
});

var twidth = 0;
var liNum = 0;
var banner = -1;
$('.nav li').each(function (i, element){
	var ele = $(element);
	ele.css('width', ele.width());
	twidth += Number(ele.width());
	liNum = i + 1;
	if(ele.hasClass('active')){
		$('.inner .info:first').addClass('section' + i);
		banner = i;
	}				
});
if(banner == -1){
	$('.inner .info:first').addClass('section1');
}
$('.nav li').css('margin-right', Math.floor( ($('.nav').width() - twidth) / liNum) );
if(jQuery.browser.version == '6.0'){
	$('.nav li').hover(
		function () {
			$(this).css('border-bottom', '2px solid #d47c18');
		}, 
		function () {
			$(this).css('border-bottom', '2px solid #ffffff');
		}
	);
}
sIFR.defaultSharpness = 400;
sIFR.replace(clearview, {
	selector: '.nav li',
	css: {
		'.sIFR-root': { 
			'color': '#5F81AA', 
			'text-transform': 'uppercase', 
			'text-align': 'center'
		},
		'a': { 
			'color': '#5F81AA',
			'text-decoration': 'none'
						
		},
		'a:hover': { 
			'color': '#5F81AA',
			'text-decoration': 'none'
		}
	}
});
if($('.news-slider ul li').length < 4){
	$('.news-scroll').hide();
	$('.news-slider-nav').hide();
}
var k = 0;
var colorArray = new Array('#5f81aa', '#c8504f', '#7ea190');
$('.news-slider li').each(function (i, element){
									
	var ele = $(element);
	ele.find('.slidecolor').css('background-color',colorArray[k]);
	if(k >= 2){ 
		k = 0;
	}else{
		k++;
	}
});

// Cookie helper fuctions
function createCookie(name,value,days) {
  if (days) {
    var date = new Date();
    date.setTime(date.getTime()+(days*24*60*60*1000));
    var expires = "; expires="+date.toGMTString();
  }
  else var expires = "";
  document.cookie = name+"="+value+expires+"; path=/";
}
 
function readCookie(name) {
  var nameEQ = name + "=";
  var ca = document.cookie.split(';');
  for(var i=0;i < ca.length;i++) {
    var c = ca[i];
    while (c.charAt(0)==' ') c = c.substring(1,c.length);
    if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
  }
  return null;
}


// this must be replaced after launch, this is for Client Reviews only - THIS WHOLE SECTION, CHANGE TEMPLATES


if ( $('.related-info').length == 0 ){
	$('.right-management-bottom:first').css('width', 756);	
	$('.right-management-content:first').css('width', 846);	
	$('.right-management-top:first').css('width', 846);	
}














