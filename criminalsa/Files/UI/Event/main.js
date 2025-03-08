var antiDoubleClick=false;

$(document).ready(function(){
	$(".MainUI").empty();
	$(".MainUI").append(`
		<div class="SecondUI">
			<div class="Title-Bar">
				<div class="Title-Title">N/A</div>
				<button class="ButtonClose"><i class="fas fa-xmark"></i></button>
			</div>

			<div class="Timer-Bar">
				<div class="Timer-Title"><i class="fas fa-clock MaskRed"></i> <span class="MaskWhite" id="Timer-Text"> N/A </span></div>
			</div>

			<div class="SecondUIList">
				<div class="SecondUIList-Item"></div>
			</div>
		</div>
	`);
	/* Display informations */
	$(".Timer-Bar").css("display","none");


	$(".ButtonClose").click(function(){
		mta.triggerEvent("Event:UI");
	});
});


function setLanguageEvent(servername,title){
	$(".Title-Title").html("<span>"+servername+"</span> - "+title+"");
}


function loadEventstandItems(item,name,price,           button_buy,           timestamp){
	if(timestamp && timestamp>0){
		$(".Timer-Bar").css("display","block");
		$("#Timer-Text").html(`${formatSecondsToTime(timestamp)}`);
	}else{
		$(".Timer-Bar").css("display","none");
	}

	$('.SecondUIList-Item').append(`<div class='SecondUIList-ItemBox'> <div class='SecondUIList-ItemTitle MaskAqua'>${name}</div> <div class='SecondUIList-ItemText MaskAqua'>${price}</div> <img class='SecondUIList-Icon' src='../../Images/Items/${item}.png'> <button class='Button' onclick="eventBuy('${item}')">${button_buy}</button> </div> </div>`);
}

function eventBuy(item){
	if(!antiDoubleClick){
		EventCooldownSwitch(500);
		mta.triggerEvent("Event:Buy:C",item);
	}
}





function EventCooldownSwitch(time){
	antiDoubleClick=true;

	setTimeout(function(){
		antiDoubleClick=false;
	},time);
}