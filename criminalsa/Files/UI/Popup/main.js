var PopupType=null;

$(document).ready(function(){
	$(".MainUI").empty();
	$(".MainUI").append(`
		<div class="SecondUI">
			<div class="Title-Bar">
				<div class="Title-Title">N/A</div>
			</div>

			<div class="Text"></div>
		</div>
	`);
});

function popupUI(type,button_accept,button_decline,text){
	PopupType=type;

	$(".SecondUI").append(`
		<button class="Button" onclick="selectPopupFunction('${PopupType}','Accept')" id="Accept"> ${button_accept} </button>
		<button class="Button" onclick="selectPopupFunction('${PopupType}','Decline')" id="Decline"> ${button_decline} </button>
	`);

	$(".Text").html(`${text}`);

	/* Buttons */
	$("#Accept").css("top","25vh");
	$("#Accept").css("left","2vh");
	$("#Accept").css("width","17vh");

	$("#Decline").css("top","25vh");
	$("#Decline").css("left","21vh");
	$("#Decline").css("width","17vh");
}
function selectPopupFunction(type,type2){
	mta.triggerEvent("Popup:Function",type,type2);
}