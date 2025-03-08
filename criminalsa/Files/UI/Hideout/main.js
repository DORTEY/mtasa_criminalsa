var antiDoubleClick=false;
var SelectedCategory;
var ButtonTextUpgrade;
var Requirements;
var Benefits;
var TimerBitcoin;

var ButtonPutIn;
var ButtonTake;
var ButtonGenerator;
var ButtonBitcoin;
var ButtonWorkbench;
var ButtonArmory;
var ButtonGarage;
var ButtonMoneywash;
var ButtonDufflebag;
var ButtonHideout;
var ButtonWardrobe;

$(document).ready(function(){
	$(".MainUI").empty();
	$(".MainUI").append(`
		<div class="SecondUI">
			<div class="Title-Bar">
				<div class="Title-Title">N/A</div>
				<button class="ButtonClose"><i class="fas fa-xmark"></i></button>
			</div>

			<div class="Navbar">
				<div class="NavbarItem"></div>
			</div>

			<div class="ThirdUI">
				
			</div>
		</div>
	`);

	$(".ButtonClose").on("click",function(){
		mta.triggerEvent("Hideout:UI");
	});
});


function setLanguageHideout(servername,title,requirements,benefits,category_generator,category_bitcoin,category_workbench,category_armory,category_garage,category_moneywash,category_dufflebag,category_hideout,category_wardrobe,           level_generator,level_bitcoin,level_workbench,level_armory,level_garage,level_moneywash,level_dufflebag,level_hideout,level_wardrobe,           button_take,button_putin){
	$(".Title-Title").html("<span>"+servername+"</span> - "+title+"");
	Requirements=requirements;
	Benefits=benefits;
	ButtonTake=button_take;
	ButtonPutIn=button_putin;


	Categories=[
		{icon:"fas fa-car-battery",text:category_generator,level:level_generator,id:"Generator"},
		{icon:"fas fa-brands fa-bitcoin",text:category_bitcoin,level:level_bitcoin,id:"Bitcoin"},
		{icon:"fas fa-screwdriver-wrench",text:category_workbench,level:level_workbench,id:"Workbench"},
		{icon:"fas fa-garage",text:category_garage,level:level_garage,id:"Garage"},
		{icon:"fas fa-washing-machine",text:category_moneywash,level:level_moneywash,id:"Moneywash"},
		{icon:"fas fa-gun",text:category_armory,level:level_armory,id:"Armory"},
		{icon:"fas fa-backpack",text:category_dufflebag,level:level_dufflebag,id:"Dufflebag"},
		{icon:"fas fa-warehouse-full",text:category_hideout,level:level_hideout,id:"Hideout"},
		{icon:"fas fa-person-dress",text:category_wardrobe,level:level_wardrobe,id:"Wardrobe"},
	];
}


function setHideoutStuff(upgrade_generator,upgrade_bitcoin,upgrade_workbench,upgrade_armory,upgrade_garage,upgrade_moneywash,upgrade_dufflebag,upgrade_hideout,upgrade_wardrobe){
	ButtonGenerator=upgrade_generator;
	ButtonBitcoin=upgrade_bitcoin;
	ButtonWorkbench=upgrade_workbench;
	ButtonArmory=upgrade_armory;
	ButtonGarage=upgrade_garage;
	ButtonMoneywash=upgrade_moneywash;
	ButtonDufflebag=upgrade_dufflebag;
	ButtonHideout=upgrade_hideout;
	ButtonWardrobe=upgrade_wardrobe;


	$(".NavbarItem").empty();
	Categories.forEach((value,index)=>{
		$(".NavbarItem").append(`
			<div class='Navbar-Items' id='${value.id}'> <div class='Navbar-Item-Text'><i class='${value.icon}'></i></div>${value.text} <span>${value.level}</span></div>
		`);
    });
	$("#"+SelectedCategory).addClass("Navbar-Items-Active");updateHideoutButtons();


	$(".Navbar-Items").click(function(){
		SelectedCategory=this.id;
		mta.triggerEvent("Hideout:CurrentSide",SelectedCategory);
		
		$(this).addClass("Navbar-Items-Active");
		$(".Navbar-Items").not(this).removeClass("Navbar-Items-Active");

		if(!antiDoubleClick){
			HideoutCooldownSwitch(300);

			if(this.id=="Generator"){
				$(".ThirdUI").empty();
				$(".ThirdUI").append(`
					<button class="Button" id="Upgrade"> </button>
				`);

				$("#Upgrade").css("top","40vh");
				$("#Upgrade").css("left","50%");
				$("#Upgrade").css("transform","translateX(-50%)");
				$("#Upgrade").click(function(){
					mta.triggerEvent("Hideout:Upgrade:C",SelectedCategory);
				});
			}else if(this.id=="Bitcoin"){
				$(".ThirdUI").empty();
				$(".ThirdUI").append(`
					<div class="Amount-Bar">
						<div class="Amount-Title"><i class="fas fa-brands fa-bitcoin MaskAqua"></i> <span class="MaskWhite" id="AmountBitcoin">x0</span></div>
					</div>
					<div class="Timer-Bar">
						<div class="Timer-Title"><i class="fas fa-clock MaskAqua"></i> <span class="MaskWhite" id="TimerBitcoin">0h 0m 0s</span></div>
					</div>
					
					<div class="Benefits"> <span class="Benefits-Title">${Benefits}</span>
						<div class="BenefitItem"></div>
					</div>
					<div class="Requirements"> <span class="Requirements-Title">${Requirements}</span>
						<div class="RequirementItem"></div>
					</div>

					<button class="Button" id="Take"> </button>
					<button class="Button" id="Upgrade"> </button>
				`);
				mta.triggerEvent("Hideout:Load:RequirementsBenefits",SelectedCategory);

				$("#Take").css("top","8vh");
				$("#Take").css("left","30vh");
				$("#Take").css("width","22vh");
				$("#Upgrade").css("top","40vh");
				$("#Upgrade").css("left","50%");
				$("#Upgrade").css("transform","translateX(-50%)");
				$("#Take").click(function(){
					mta.triggerEvent("Hideout:Take:C",SelectedCategory);
				});
				$("#Upgrade").click(function(){
					mta.triggerEvent("Hideout:Upgrade:C",SelectedCategory);
				});
			}else if(this.id=="Workbench"){
				$(".ThirdUI").empty();
				$(".ThirdUI").append(`
					<div class="Benefits"> <span class="Benefits-Title">${Benefits}</span>
						<div class="BenefitItem"></div>
					</div>
					<div class="Requirements"> <span class="Requirements-Title">${Requirements}</span>
						<div class="RequirementItem"></div>
					</div>

					<button class="Button" id="Upgrade"> </button>
				`);
				mta.triggerEvent("Hideout:Load:RequirementsBenefits",SelectedCategory);

				$("#Upgrade").css("top","40vh");
				$("#Upgrade").css("left","50%");
				$("#Upgrade").css("transform","translateX(-50%)");
				$("#Upgrade").click(function(){
					mta.triggerEvent("Hideout:Upgrade:C",SelectedCategory);
				});
			}else if(this.id=="Armory"){
				$(".ThirdUI").empty();
				$(".ThirdUI").append(`
					<div class="Benefits"> <span class="Benefits-Title">${Benefits}</span>
						<div class="BenefitItem"></div>
					</div>
					<div class="Requirements"> <span class="Requirements-Title">${Requirements}</span>
						<div class="RequirementItem"></div>
					</div>

					<div class="ItemList">
						<div class="ArmoryQueue"></div>
					</div>

					<div class="ItemList2">
						<div class="SkinList"></div>
					</div>

					<button class="Button" id="Upgrade"> </button>
				`);
				mta.triggerEvent("Hideout:Load:RequirementsBenefits",SelectedCategory);
				mta.triggerEvent("Hideout:Load:Armory");

				$("#Upgrade").css("top","40vh");
				$("#Upgrade").css("left","50%");
				$("#Upgrade").css("transform","translateX(-50%)");
				$("#Upgrade").click(function(){
					mta.triggerEvent("Hideout:Upgrade:C",SelectedCategory);
				});
			}else if(this.id=="Garage"){
				$(".ThirdUI").empty();
				$(".ThirdUI").append(`
					<div class="Benefits"> <span class="Benefits-Title">${Benefits}</span>
						<div class="BenefitItem"></div>
					</div>
					<div class="Requirements"> <span class="Requirements-Title">${Requirements}</span>
						<div class="RequirementItem"></div>
					</div>

					<button class="Button" id="Upgrade"> </button>
				`);
				mta.triggerEvent("Hideout:Load:RequirementsBenefits",SelectedCategory);

				$("#Upgrade").css("top","40vh");
				$("#Upgrade").css("left","50%");
				$("#Upgrade").css("transform","translateX(-50%)");
				$("#Upgrade").click(function(){
					mta.triggerEvent("Hideout:Upgrade:C",SelectedCategory);
				});
			}else if(this.id=="Moneywash"){
				$(".ThirdUI").empty();
				$(".ThirdUI").append(`
					<div class="Benefits"> <span class="Benefits-Title">${Benefits}</span>
						<div class="BenefitItem"></div>
					</div>
					<div class="Requirements"> <span class="Requirements-Title">${Requirements}</span>
						<div class="RequirementItem"></div>
					</div>

					<div class="ItemList">
						<div class="ItemListItem"></div>
					</div>

					<button class="Button" id="PutIn"> </button>
					<button class="Button" id="Upgrade"> </button>
				`);
				mta.triggerEvent("Hideout:Load:RequirementsBenefits",SelectedCategory);
				mta.triggerEvent("Hideout:Load:Laundry");

				$("#PutIn").css("top","2vh");
				$("#PutIn").css("left","30vh");
				$("#PutIn").css("width","22vh");
				$("#Upgrade").css("top","40vh");
				$("#Upgrade").css("left","50%");
				$("#Upgrade").css("transform","translateX(-50%)");
				$("#PutIn").click(function(){
					mta.triggerEvent("Hideout:PutInLaundry:C",SelectedCategory);
				});
				$("#Upgrade").click(function(){
					mta.triggerEvent("Hideout:Upgrade:C",SelectedCategory);
				});
			}else if(this.id=="Dufflebag"){
				$(".ThirdUI").empty();
				$(".ThirdUI").append(`
					<div class="Benefits"> <span class="Benefits-Title">${Benefits}</span>
						<div class="BenefitItem"></div>
					</div>
					<div class="Requirements"> <span class="Requirements-Title">${Requirements}</span>
						<div class="RequirementItem"></div>
					</div>

					<button class="Button" id="Upgrade"> </button>
				`);
				mta.triggerEvent("Hideout:Load:RequirementsBenefits",SelectedCategory);

				$("#Upgrade").css("top","40vh");
				$("#Upgrade").css("left","50%");
				$("#Upgrade").css("transform","translateX(-50%)");
				$("#Upgrade").click(function(){
					mta.triggerEvent("Hideout:Upgrade:C",SelectedCategory);
				});
			}else if(this.id=="Hideout"){
				$(".ThirdUI").empty();
				$(".ThirdUI").append(`
					<div class="Benefits"> <span class="Benefits-Title">${Benefits}</span>
						<div class="BenefitItem"></div>
					</div>
					<div class="Requirements"> <span class="Requirements-Title">${Requirements}</span>
						<div class="RequirementItem"></div>
					</div>

					<button class="Button" id="Upgrade"> </button>
				`);
				mta.triggerEvent("Hideout:Load:RequirementsBenefits",SelectedCategory);

				$("#Upgrade").css("top","40vh");
				$("#Upgrade").css("left","50%");
				$("#Upgrade").css("transform","translateX(-50%)");
				$("#Upgrade").click(function(){
					mta.triggerEvent("Hideout:Upgrade:C",SelectedCategory);
				});
			}else if(this.id=="Wardrobe"){
				$(".ThirdUI").empty();
				$(".ThirdUI").append(`
					<div class="Benefits"> <span class="Benefits-Title">${Benefits}</span>
						<div class="BenefitItem"></div>
					</div>
					<div class="Requirements"> <span class="Requirements-Title">${Requirements}</span>
						<div class="RequirementItem"></div>
					</div>

					<div class="ItemList">
						<div class="ItemListItem"></div>
					</div>

					<div class="ItemList2">
						<div class="ItemListItem2"></div>
					</div>

					<button class="Button" id="Upgrade"> </button>
				`);
				mta.triggerEvent("Hideout:Load:RequirementsBenefits",SelectedCategory);
				mta.triggerEvent("Hideout:Load:PedSkins");

				$("#Upgrade").css("top","40vh");
				$("#Upgrade").css("left","50%");
				$("#Upgrade").css("transform","translateX(-50%)");
				$("#Upgrade").click(function(){
					mta.triggerEvent("Hideout:Upgrade:C",SelectedCategory);
				});
			}
		}
	});
}

function updateHideoutButtons(){
	if(SelectedCategory=="Generator"){
		ButtonTextUpgrade=ButtonGenerator;
	}else if(SelectedCategory=="Bitcoin"){
		ButtonTextUpgrade=ButtonBitcoin;
	}else if(SelectedCategory=="Workbench"){
		ButtonTextUpgrade=ButtonWorkbench;
	}else if(SelectedCategory=="Armory"){
		ButtonTextUpgrade=ButtonArmory;
	}else if(SelectedCategory=="Garage"){
		ButtonTextUpgrade=ButtonGarage;
	}else if(SelectedCategory=="Moneywash"){
		ButtonTextUpgrade=ButtonMoneywash;
	}else if(SelectedCategory=="Dufflebag"){
		ButtonTextUpgrade=ButtonDufflebag;
	}else if(SelectedCategory=="Hideout"){
		ButtonTextUpgrade=ButtonHideout;
	}else if(SelectedCategory=="Wardrobe"){
		ButtonTextUpgrade=ButtonWardrobe;
	}
	
	$("#PutIn").html("<i class='fas fa-hand'></i> "+ButtonPutIn+"");
	$("#Take").html("<i class='fas fa-hand'></i> "+ButtonTake+"");
	$("#Upgrade").html("<i class='fas fa-circle-up'></i> Upgrade ("+ButtonTextUpgrade+")");
}

function updateHideoutTimers(type,timer,amount){
	if(type=="Bitcoin"){
		TimerBitcoin=timer;


		$("#TimerBitcoin").html(formatSecondsToTime(TimerBitcoin));
		$("#AmountBitcoin").html("x"+amount);
	}
}

function laundryQueue(count,amount,time){
	$('.ItemListItem').append(`<div class='ItemList-Items'> <div class='ItemList-Item-Text MaskAqua'>${amount}</div> <div class='ItemList-Item-Text2 MaskWhite'>${formatSecondsToTime(time)}</div> <button class="ButtonTake" onclick="hideoutTakeLaundry('${count}')"> <i class='fas fa-hand MaskWhite'></i> </button> </div>`);
}
function hideoutTakeLaundry(id){
	if(!antiDoubleClick){
		HideoutCooldownSwitch(300);
		mta.triggerEvent("Hideout:TakeLaundry:C",id);
	}
}

function hideoutPedSkinList(count,id,name){
	$('.ItemListItem').append(`<div class='ItemList-Items'> <div class='ItemList-Item-Text MaskAqua'>${name}</div> <div class='ItemList-Item-Text2 MaskWhite'>${id}</div> <button class="ButtonDelete" ondblclick="hideoutDeletePedSkin('${count}')"> <i class='fas fa-trash-can MaskWhite'></i> </button> <button class="ButtonTake" onclick="hideoutWearPedSkin('${id}')"> <i class='fas fa-hand MaskWhite'></i> </button> </div>`);
}
function hideoutPedSkinListQueue(count,id,name,time){
	$('.ItemListItem2').append(`<div class='ItemList2-Items'> <div class='ItemList-Item-Text MaskAqua'>${formatSecondsToTime(time)}</div> <div class='ItemList-Item-Text2 MaskWhite'>${name}</div> <button class="ButtonTake" onclick="hideoutGrabQueueSkin('${count}')"> <i class='fas fa-hand MaskWhite'></i> </button> </div>`);
}
function hideoutWearPedSkin(id){
	if(!antiDoubleClick){
		HideoutCooldownSwitch(300);
		mta.triggerEvent("Hideout:Wardrobe:WearSkin:C",id);
	}
}
function hideoutDeletePedSkin(id){
	if(!antiDoubleClick){
		HideoutCooldownSwitch(300);
		mta.triggerEvent("Hideout:Wardrobe:DeleteSkin:C",id);
	}
}
function hideoutGrabQueueSkin(id){
	if(!antiDoubleClick){
		HideoutCooldownSwitch(300);
		mta.triggerEvent("Hideout:Wardrobe:GrabQueueSkin:C",id);
	}
}

function armoryList(name,id){
	$('.ArmoryQueue').append(`<div class='ItemList-Items' onclick="hideoutWearWeaponSkin('${id}')"> <div class='ItemList-Item-Text MaskAqua'>${name}</div> <button class='ButtonTake' onclick="hideoutTakeWeapon('${id}')"> <i class='fas fa-hand MaskWhite'></i> </button> </div>`);

	$(".ItemList-Items").click(function(){
		$(this).addClass("ItemList-Items-Active");
		$(".ItemList-Items").not(this).removeClass("ItemList-Items-Active");
	});
}
function hideoutWearWeaponSkin(id){
	if(!antiDoubleClick){
		HideoutCooldownSwitch(500);
		mta.triggerEvent("Hideout:Load:WeaponSkins",id);
	}
}
function weaponSkinList(item,name){
	$('.SkinList').append(`<div class='ItemList2-Items' onclick="hideoutEquipWeaponSkin('${item}')"> <div class='ItemList2-Item-Text MaskAqua'>${name}</div> <button class="ButtonTake" onclick="hideoutEquipWeaponSkin('${item}')"> <i class='fas fa-hand MaskWhite'></i> </button> </div>`);
}
function hideoutEquipWeaponSkin(weapon){
	mta.triggerEvent("Hideout:TakeWeaponSkin:C",weapon);
}

function hideoutTakeWeapon(id){
	if(!antiDoubleClick){
		HideoutCooldownSwitch(500);
		mta.triggerEvent("Hideout:TakeWeapon:C",id);
	}
}





function HideoutCooldownSwitch(time){
	antiDoubleClick=true;

	setTimeout(function(){
		antiDoubleClick=false;
	},time);
}