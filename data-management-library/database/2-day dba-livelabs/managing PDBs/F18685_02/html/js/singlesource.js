var options = [];

function singleSource() {
	if(options.length-1) {
		$('#dropdown').append("<select id=\"select\"></select>");				
		for(var i=0; i<options.length; i++) 
			$('#select').append("<option value=\"" + options[i].class_name + "\">" + options[i].display_name + "</option>");
		$('#select').change(function() {
			window.location.search = this.value;
		});			
		var query = window.location.search.split('?')[1];			
		if (query == undefined || !$('.' + query).length) {				
			query = options[0].class_name;
		}
		$("#select>option").each(function() { $('.' + this.value).hide(); });	//hides all	
		$('.' + query).show();
		$('#select>option[value="' + query + '"]').attr("selected", "selected");	
	}	
}

function addOption(class_name, option_name) {
	options.push({class_name: class_name, display_name: option_name});	
}