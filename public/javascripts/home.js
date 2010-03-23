window.addEvent('domready', function(){

	$('search').addEvent('submit', function(event){
		tag = $('tag').value.clean().replace(" ", "+", "gi");
		document.location='/'+tag;
		event.stop();
	});

	$('tag').addEvent('focus', function(){
		this.set('value','');
	})
	
})