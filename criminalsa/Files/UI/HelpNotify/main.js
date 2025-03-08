$(document).ready(function(){
	$(".MainUI").append(`
		<div class="help-notify-background"></div>
		<div class="loader loader-1">
	   		<div class="loader-outter"></div>
	   		<div class="loader-inner"></div>
		</div>
	 	<div class="inner-circle-small" id="help-input-key">N/A</div>
	 	<div class="help-text" id="help-text">N/A text</div>
	`);
});

function openHelpNotify(state,key,text){
	if(state=="true"){
		if(key && text){
			$(".inner-circle-small").text(key);
			$(".help-text").text(text);
		}
	}
}