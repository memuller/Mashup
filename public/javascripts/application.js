document.observe("dom:loaded", function() {
	Shadowbox.init();
	
	Event.observe('search','submit',function(event){
		tag = encodeURIComponent($F('tag').gsub(' ','+'))
		document.location='/'+tag;
		Event.stop(event)
	})
	
	Event.observe('tag','focus',function(){this.clear()})

	if($('videos_thumbnails')){
		set_ajax_show($('videos_thumbnails'),'video')
		set_ajax_pag($('videos_nav'),'video')
		$('videos_nav').getElementsByClassName('ajax-loader')[0].update('<img src="/images/ajax-loader.gif" style="display:none"/>')
	}
	if($('photos_thumbnails')){
		set_ajax_show($('photos_thumbnails'),'photo')
		set_ajax_pag($('photos_nav'),'photo')
		$('photos_nav').getElementsByClassName('ajax-loader')[0].update('<img src="/images/ajax-loader.gif" style="display:none"/>')
	}

	var cookie = readCookie("style");
	var title = cookie ? cookie : getPreferredStyleSheet();
	setActiveStyleSheet(title);
	Event.observe('layout','change',function(){
		setActiveStyleSheet(this.value);
  		createCookie("style", getActiveStyleSheet(), 365);
  	})
});

document.observe('onunload', function(){
  var title = getActiveStyleSheet();
  createCookie("style", title, 365);
})


function set_ajax_pag(nav,which){
	nav_childs = nav.childElements()
	nav_childs.each(function(item){
		if(item.getAttribute('class')!=='show'){
		item.observe('click',function(event){
			page_ajax(item,which)	
			Event.stop(event)
		})
		}
	})
}

function set_ajax_show(nav,which){
	links = nav.childElements()	
	links.each(function(item) {
		item.observe("click",function(event){
			if(which == 'video') show_video(this.readAttribute('id'),this.readAttribute('title'), this.href.toQueryParams().contributed)
			else show_photo(this)
			Event.stop(event);})
	});
}

function page_ajax(item,which){
	temp = item.readAttribute('href').toQueryParams()
	query = $H(item.readAttribute('href').toQueryParams()).toQueryString()
	tag = document.location.href.split("/")
        tag = tag[3]
        if(tag)	tag = '/'+tag
	if(getPage(item.readAttribute('href'))>0){
	
		new Ajax.Request(which+'/page/'+temp['page']+tag, {
		 		onSuccess: function(transport) {
				transport
				up_link(item)
		 		},
			onLoading: function(transport){
				item.ancestors()[0].getElementsByClassName('ajax-loader')[0].update('<img src="/images/ajax-loader.gif"/>')
			},
			onComplete: function(transport){
				item.ancestors()[0].getElementsByClassName('ajax-loader')[0].update('')			
			}
		});	
	}
}

function up_link(obj){
	page_goto = getPage(obj.readAttribute('href'))
	
	if (obj.readAttribute('class') == 'before'){
		page_current = page_goto + 1
		page_next = page_current 
		page_before = page_current - 2
	}else{
		page_current = page_goto - 1
		page_next = page_current + 2
		page_before = page_current
	}

	obj.ancestors()[0].getElementsByTagName('span')[0].update('p&aacute;gina ' + page_goto)
	link = obj.ancestors()[0].getElementsByTagName('a')
	link[0].writeAttribute('href',link[0].readAttribute('href').sub('page='+(page_current-1),'page='+page_before))
	link[1].writeAttribute('href',link[1].readAttribute('href').sub('page='+(page_current+1),'page='+page_next))
	
	class_before = (page_before==0) ? 'before disable' : 'before'
	link[0].writeAttribute('class',class_before)
}

function show_video(id,title,contributed){
	if (contributed == 'true'){ 
		badge = "<div id='hidden_content_media_id#!ID!#providerYoutube_index_blacklisted' style='display: none;'></div><a class='negative_video' id='videos_content_type' href='#' onclick=\"new Ajax.Updater('hidden_content_media_id#!ID!#providerYoutube_index_blacklisted', '/blacklisted?media_id=#!ID!#&amp;provider=Youtube', {asynchronous:true, evalScripts:true, onComplete:function(request){RedBox.addHiddenContent('hidden_content_media_id#!ID!#providerYoutube_index_blacklisted'); }, onLoading:function(request){RedBox.loading();}}); return false;\"></a>"
		badge = badge.replace(/#!ID!#/g, id);
	}else{
		badge = "<img src='/images/icon-pomba.gif' alt='Vídeo Oficial' title='Vídeo Oficial' style='float:right'>"
	}
	
	if($("video_badge"))
		$("video_badge").update(badge);
	$("videos_content").update("<p>"+title+"</p><object width='640' height='385' codebase='http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,40,0' classid='clsid:d27cdb6e-ae6d-11cf-96b8-444553540000'> <param value='true' name='allowFullScreen'/><param name='wmode' value='opaque'/> <param value='http://www.youtube.com/watch/v/"+id+"&autoplay=1&rel=0&color1=0xb1b1b1&color2=0xcfcfcf&hl=en&feature=player_embedded&fs=1' name='src'/> <embed width='640' height='385' allowfullscreen='true' src='http://www.youtube.com/v/"+id+"&autoplay=1&rel=0&color1=0xb1b1b1&color2=0xcfcfcf&hl=en&feature=player_embedded&fs=1' wmode='opaque' type='application/x-shockwave-flash'/> </object>");
}

function getPage(url){
	return parseInt(url.toQueryParams()['page'])
}

function show_photo(object){
	parans = object.readAttribute('href').toQueryParams()
	$("photos_content").update("<a href='"+parans.link+"'><img src='http://static.flickr.com/"+parans.photo+".jpg' "+$(object).readAttribute('class')+"></a> <h3> "+$(object).readAttribute('title')+" </h3>");
}

function setActiveStyleSheet(title) {
  var i, a, main;
  for(i=0; (a = document.getElementsByTagName("link")[i]); i++) {
    if(a.getAttribute("rel").indexOf("style") != -1 && a.getAttribute("title")) {
      a.disabled = true;
      if(a.getAttribute("title") == title) a.disabled = false;
    }
  }
}

function getActiveStyleSheet() {
  var i, a;
  for(i=0; (a = document.getElementsByTagName("link")[i]); i++) {
    if(a.getAttribute("rel").indexOf("style") != -1 && a.getAttribute("title") && !a.disabled) return a.getAttribute("title");
  }
  return null;
}

function getPreferredStyleSheet() {
  var i, a;
  for(i=0; (a = document.getElementsByTagName("link")[i]); i++) {
    if(a.getAttribute("rel").indexOf("style") != -1
       && a.getAttribute("rel").indexOf("alt") == -1
       && a.getAttribute("title")
       ) return a.getAttribute("title");
  }
  return null;
}

function createCookie(name,value,days) {
  if (days) {
    var date = new Date();
    date.setTime(date.getTime()+(days*24*60*60*1000));
    var expires = "; expires="+date.toGMTString();
  }
  else expires = "";
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
