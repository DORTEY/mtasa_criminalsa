const TYPES={
	["success"]: {
	  	["icon"]: "fal fa-check-circle",
		["color"]: "rgba(60,255,60,1)",
	},
	["error"]: {
	  	["icon"]: "fal fa-times-circle",
		["color"]: "rgba(255,60,60,1)",
	},
	["info"]: {
		["icon"]: "fal fa-circle-info",
	  	["color"]: "rgba(2,160,168,1)",
  	},
	["warning"]: {
		["icon"]: "fal fa-triangle-exclamation",
	  	["color"]: "rgba(255,255,60,1)",
  	},
	["achievement"]: {
		["icon"]: "fal fa-trophy",
	  	["color"]: "rgba(0,240,255,1)",
  	},
};

$(document).ready(function(){
	$(".NotifyUI").append(`
		<div class="Notify">
			<div class="Notify-Items-Container">
				<div class="NotifyItem"></div>
			</div>
		</div>
	`);

	$(".KillfeedUI").append(`
		<div class="KillfeedItem"></div>
	`);
});

function showNotify(text,type,time){
	const Notify=$(`<div>
		<div class="Notify-Items" style="border-left: 0.2vh solid ${TYPES[type]["color"]};">

			<span class="Icon"><i class="${TYPES[type]["icon"]}" style="color: ${TYPES[type]["color"]};"></i></span>
			<span class="MaskWhite" style="letter-spacing: 0.08vh;">${text}</span>
		</div>
	</div>`).prependTo(".NotifyItem");

	setTimeout(()=>{
		Notify.fadeOut("slow");
	},time);
}

function showKillfeed(text){
	const Killfeed=$(`<div>
		<div class="Killfeed-Items" style="border-right: 0.2vh solid rgba(255,60,60,1);">

			<span class="Icon"><i class="fas fa-skull MaskRed"></i></span>
			<span class="MaskWhite" style="letter-spacing: 0.08vh;">${text}</span>
		</div> </div>
	`).prependTo(".KillfeedItem");

	setTimeout(()=>{
		Killfeed.fadeOut("slow");
	},10000);
}