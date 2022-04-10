({
	test: function(component,event,helper){
		var a=event.getSource().get("v.label");
		alert(a);
	},
	scriptsLoaded: function(component,event,helper){
		console.log('javascript successful');
		$('#carousel-example-generic').carousel({
			pause: true,
			interval: 3000
		});

	},
	/*aa:function(component,event,helper){
		$('#myModal1').modal({backdrop: 'static'});
	}*/
})