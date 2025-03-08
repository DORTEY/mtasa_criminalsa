var antiDoubleClick=false;

$(document).ready(function(){
	$(".MainUI").empty();
	$(".MainUI").append(`
		<div class="SecondUI">
			<div class="Title-Bar">
				<div class="Title-Title">N/A</div>
			</div>

			<div class="ListItems">
				<div class="ListItems-Item"></div>
			</div>

			<div class="Loading">
				
			</div>
		</div>
	`);

	document.onkeyup=function(event){
		if(event.key.toLowerCase()=="i"){
			mta.triggerEvent("Inventory:UI");
		}
	}
});

function loadIventoryItems(item,name,amount){
	$('.ListItems-Item').append(`<div class="ItemBox" ondblclick="selectInventoryIten('${item}')"> <div class="ItemBoxTooltip" style="letter-spacing: 0.05vh;">${name}</div>  <div class='Item-Amount'>${amount}</div>  <img class='Item-Icon' src='../../Images/Items/${item}.png'></div> </div>`);
}

function selectInventoryIten(item){
	if(!antiDoubleClick){
		InventoryCooldownSwitch(500);

		mta.triggerEvent("Inventory:UseItem:C",item);
	}
}



function InventoryCooldownSwitch(time){
	antiDoubleClick=true;

	setTimeout(function(){
		antiDoubleClick=false;
	},time);
}