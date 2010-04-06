window.addEvent('domready', function(){

	var nS4 = new noobSlide({
		box: $('spotlight'),
		items: $$('#spotlight div'),
		size: 480,
		handles: $$('#nav a'),
		autoPlay: true,
		onWalk: function(currentItem,currentHandle){
			this.handles.removeClass('active');
			currentHandle.addClass('active');
			currentHandle.addEvent('click',function(event){event.stop();});	
		}
	});

	$('search').addEvent('submit', function(event){
		tag = encodeURIComponent($('tag').value.clean().replace(" ", "+", "gi"));
		document.location='/'+tag;
		event.stop();
	});

	$('tag').addEvent('focus', function(){
		this.set('value','');
	})
	
/*	$.expr[':'].external = function(obj){
	    return !obj.href.match(/^mailto\:/)
	            && (obj.hostname != location.hostname);
	};

	var GB_ANIMATION = true;
	$('a:external').click(function(){
//			var t = this.title || this.innerHTML || this.href;
	//		GB_show(t,this.href,470,600);
	alert(this.href);
			return false;
		});
	*/
	
	$$('a[href!=""]').each(function(link){
	        var siteregex = /^(http:\/\/)([a-z]*\.)?(mashup.cancaonova)/i;
	        if(link.readAttribute('href').startsWith('http://') &&
	          !link.readAttribute('href').match(siteregex)){
	            link.writeAttribute('target','_blank');
	            link.writeAttribute('rel','external');
	        }
	    });

	    $$('a[rel="external"]').each(function(link){
	        if(link.readAttribute('href') != '' && link.readAttribute('href') != '#'){
	            link.writeAttribute('target','_blank');
	        }
	    });
	
})


