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
		tag = $('tag').value.clean().replace(" ", "+", "gi");
		document.location='/'+tag;
		event.stop();
	});

	$('tag').addEvent('focus', function(){
		this.set('value','');
	})
	
})


