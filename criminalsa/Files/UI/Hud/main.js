/* var CurrentWeapon=null; */
var CurrentMoneyBooster=0;

$(document).ready(function(){
	CurrentMoneyBooster=0;

	$(".MainUI").empty();
	$(".MainUI").append(`
		<div class="DateTime-Container">
			<div class="DateTime" style="letter-spacing: 0.08vh;"></div>
			<div class="DateTime-Container-Text"><span id="Time" style="letter-spacing: 0.08vh;">N/A</span> | <span id="Date" style="letter-spacing: 0.08vh;">N/A</span></div>
		</div>

		<div class="Hud" id="Cash"> <div class="Hud-Text"> <span class="MaskWhite" id="Money"  style="letter-spacing: 0.08vh;"> </span> </div> </div>
		<div class="Hud" id="Black"> <div class="Hud-Text"> <span class="MaskWhite" id="MoneyBlack" style="letter-spacing: 0.08vh;"> </span> </div> </div>

		
		<div class="Hud Hud-Text-Ammo" id="Ammo"> <span class="MaskWhite" id="wAmmo" style="letter-spacing: 0.08vh;"> </span> </div>

		<div class="Booster-Container">
			<div class="Booster-Container-Item"></div>
		</div>
	`);
});
/* <img class="Hud" id="Weapon" src="../../Images/Hud/Weapons/0.png"> */
function showHUD(time,date,money,bmoney,weapon,ammo){
	Icons=[
		{icon: "<i class='far fa-circle-dollar MaskAqua'></i>"},//money
		{icon: "<i class='far fa-sack-dollar MaskRed'></i>"},//money
	];

	$("#Time").html(time);
	$("#Date").html(date);
	$("#Money").html(money+" <i class='fas fa-angles-left Hud-Icon MaskAqua'></i> "+Icons[0].icon);
	$("#MoneyBlack").html(bmoney+" <i class='fas fa-angles-left Hud-Icon MaskRed'></i> "+Icons[1].icon);

	/* if(CurrentWeapon!==weapon){
		CurrentWeapon=weapon;
		document.getElementById("Weapon").src="../../Images/Hud/Weapons/"+weapon+".png";
	} */
	if(weapon>16){
		$("#wAmmo").html(ammo);
		$(".Hud#Ammo").fadeIn("fast");
	}else{
		$(".Hud#Ammo").fadeOut("fast");
	}
}

function loadHUDboosters(booster_money_item,booster_money_duration, booster_items_item,booster_items_duration){
	$(".Booster-Container-Item").empty();
	if(booster_money_item>0){
		$(".Booster-Container-Item").append(`
			<div class="BoosterIcon">
				<img class="BoosterIcon-Img" src='../../Images/Items/MoneyBooster${booster_money_item}.png'></img>
				<div class="BoosterIcon-Text" style="letter-spacing: 0.08vh;"> ${formatSecondsToTime(booster_money_duration)} </div>
			</div>
		`);
	}
	if(booster_items_item>0){
		$(".Booster-Container-Item").append(`
			<div class="BoosterIcon">
				<img class="BoosterIcon-Img" src='../../Images/Items/ItemBooster${booster_items_item}.png'></img>
				<div class="BoosterIcon-Text" style="letter-spacing: 0.08vh;"> ${formatSecondsToTime(booster_items_duration)} </div>
			</div>
		`);
	}
}