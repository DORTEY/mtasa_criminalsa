var antiDoubleClick=false;

var CrimeCoins=0;

var CratePrices={
	[1]:999999999,
	[2]:999999999,
	[3]:999999999,
	[4]:999999999,
	[5]:999999999,
	[6]:999999999,
	[7]:999999999,
	[8]:999999999,
};

var CaseItems={
	[1]:[
		{item:"Weapon_24_4",amount:[1,1],itemText:"Printstream",img:"../../Images/Crates/Items/Weapon_24_4.png",},
		{item:"Weapon_34_4",amount:[1,1],itemText:"Hyper Beast",img:"../../Images/Crates/Items/Weapon_34_4.png",},
		{item:"Weapon_34_15",amount:[1,1],itemText:"Western",img:"../../Images/Crates/Items/Weapon_34_15.png",},
		{item:"Weapon_25_16",amount:[1,1],itemText:"Spectrum",img:"../../Images/Crates/Items/Weapon_25_16.png",},
		{item:"Weapon_34_17",amount:[1,1],itemText:"Miku",img:"../../Images/Crates/Items/Weapon_34_17.png",},
		{item:"Weapon_30_26",amount:[1,1],itemText:"Asiimov",img:"../../Images/Crates/Items/Weapon_30_26.png",},
		{item:"Weapon_34_6",amount:[1,1],itemText:"TiiTree",img:"../../Images/Crates/Items/Weapon_34_6.png",},
		{item:"Weapon_25_15",amount:[1,1],itemText:"Snakeskin Red",img:"../../Images/Crates/Items/Weapon_25_15.png",},
		{item:"Weapon_25_17",amount:[1,1],itemText:"Urban",img:"../../Images/Crates/Items/Weapon_25_17.png",},
		{item:"Weapon_30_24",amount:[1,1],itemText:"Vulcan",img:"../../Images/Crates/Items/Weapon_30_24.png",},
		{item:"Weapon_24_7",amount:[1,1],itemText:"Purple Bird",img:"../../Images/Crates/Items/Weapon_24_7.png",},
		{item:"Weapon_30_25",amount:[1,1],itemText:"Wasteland Rebel",img:"../../Images/Crates/Items/Weapon_30_25.png",},
		{item:"Weapon_34_13",amount:[1,1],itemText:"Vice",img:"../../Images/Crates/Items/Weapon_34_13.png",},
		{item:"Weapon_34_16",amount:[1,1],itemText:"Medusa",img:"../../Images/Crates/Items/Weapon_34_16.png",},
		{item:"Weapon_25_2",amount:[1,1],itemText:"Caritas",img:"../../Images/Crates/Items/Weapon_25_2.png",},
		{item:"Weapon_25_5",amount:[1,1],itemText:"Heaven Guard",img:"../../Images/Crates/Items/Weapon_25_5.png",},
		{item:"Weapon_25_12",amount:[1,1],itemText:"Nukestripe Maroon",img:"../../Images/Crates/Items/Weapon_25_12.png",},
		{item:"Weapon_31_4",amount:[1,1],itemText:"Cyrex",img:"../../Images/Crates/Items/Weapon_31_4.png",},
		{item:"Weapon_34_14",amount:[1,1],itemText:"Dodgers",img:"../../Images/Crates/Items/Weapon_34_14.png",},
		{item:"Weapon_30_23",amount:[1,1],itemText:"Safari Mesh",img:"../../Images/Crates/Items/Weapon_30_23.png",},
		{item:"Weapon_24_6",amount:[1,1],itemText:"Overdrive",img:"../../Images/Crates/Items/Weapon_24_6.png",},
		{item:"Weapon_34_12",amount:[1,1],itemText:"Thunderbolt",img:"../../Images/Crates/Items/Weapon_34_12.png",},
		{item:"Weapon_31_5",amount:[1,1],itemText:"Demolition V1",img:"../../Images/Crates/Items/Weapon_31_5.png",},
		{item:"Weapon_24_8",amount:[1,1],itemText:"Arctic Combat",img:"../../Images/Crates/Items/Weapon_24_8.png",},
		{item:"Weapon_31_6",amount:[1,1],itemText:"Demolition V2",img:"../../Images/Crates/Items/Weapon_31_6.png",},
		{item:"Weapon_25_3",amount:[1,1],itemText:"Fractal Blue",img:"../../Images/Crates/Items/Weapon_25_3.png",},
		{item:"CrimeCoin",amount:[45,45],itemText:"Crime coin",img:"../../Images/Crates/Items/CrimeCoin.png",},
		{item:"Cash",amount:[1500,2000],itemText:"Cash",img:"../../Images/Crates/Items/Cash.png",},
	],
	[2]:[
		{item:"Skin_30019",amount:[1,1],itemText:"Female Custom #19",img:"../../Images/Crates/Items/Skin_30019.png",},
		{item:"Skin_30023",amount:[1,1],itemText:"Female Custom #23",img:"../../Images/Crates/Items/Skin_30023.png",},
		{item:"Skin_30029",amount:[1,1],itemText:"Female Custom #29",img:"../../Images/Crates/Items/Skin_30029.png",},
		{item:"Skin_30030",amount:[1,1],itemText:"Female Custom #30",img:"../../Images/Crates/Items/Skin_30030.png",},
		{item:"Skin_30032",amount:[1,1],itemText:"Female Custom #32",img:"../../Images/Crates/Items/Skin_30032.png",},
		{item:"Skin_30035",amount:[1,1],itemText:"Female Custom #35",img:"../../Images/Crates/Items/Skin_30035.png",},
		{item:"Skin_40017",amount:[1,1],itemText:"Male Custom #17",img:"../../Images/Crates/Items/Skin_40017.png",},
		{item:"CrimeCoin",amount:[45,45],itemText:"Crime coin",img:"../../Images/Crates/Items/CrimeCoin.png",},
		{item:"Cash",amount:[1500,2000],itemText:"Cash",img:"../../Images/Crates/Items/Cash.png",},
	],
	[3]:[
		{item:"Wheel_1879",amount:[1,1],itemText:"Wheel #1879",img:"../../Images/Items/Wheel_1879.png",},
		{item:"Wheel_1882",amount:[1,1],itemText:"Wheel #1882",img:"../../Images/Items/Wheel_1882.png",},
		{item:"Wheel_1901",amount:[1,1],itemText:"Wheel #1901",img:"../../Images/Items/Wheel_1901.png",},
		{item:"Wheel_1903",amount:[1,1],itemText:"Wheel #1903",img:"../../Images/Items/Wheel_1903.png",},
		{item:"Wheel_1904",amount:[1,1],itemText:"Wheel #1904",img:"../../Images/Items/Wheel_1904.png",},
		{item:"Wheel_1911",amount:[1,1],itemText:"Wheel #1911",img:"../../Images/Items/Wheel_1911.png",},
		{item:"Wheel_1931",amount:[1,1],itemText:"Wheel #1931",img:"../../Images/Items/Wheel_1931.png",},
		{item:"Wheel_1932",amount:[1,1],itemText:"Wheel #1932",img:"../../Images/Items/Wheel_1932.png",},
		{item:"Wheel_1933",amount:[1,1],itemText:"Wheel #1933",img:"../../Images/Items/Wheel_1933.png",},
		{item:"CrimeCoin",amount:[20,20],itemText:"Crime coin",img:"../../Images/Crates/Items/CrimeCoin.png",},
		{item:"CrimeCoin",amount:[40,40],itemText:"Crime coin x2",img:"../../Images/Crates/Items/CrimeCoinX2.png",},
		{item:"Cash",amount:[1000,1500],itemText:"Cash",img:"../../Images/Crates/Items/Cash.png",},
	],
};

$(document).ready(function(){
	$(".MainUI").empty();
	$(".MainUI").append(`
		<div class="SecondUI">
			<div class="Title-Bar">
				<div class="Title-Title">N/A</div>
			</div>

			<div class="Navbar">
				<div class="NavbarItem"></div>
			</div>

			<button class="Button" id="ButtonClose"> N/A </button>
		</div>

		<div class="ThirdUI">
			<div class="ThirdUI-Bar">
				<div class="ThirdUI-Title">N/A</div>

				<button class="ThirdUI-Bar-OpenCodeRedeemButton"><i class='fas fa-check-circle'></i> Redeem</button>
				<input type="text" id="redeem" maxlength="15" placeholder="code" style="display: none;">

				<div class="CrimeCoins-Text"><img class="CrimeCoins-Img" src="../../Images/Items/CrimeCoin.png"><span>0</span></div>
			</div>

			<div class="ThirdUIList">
				<div class="ThirdUIList-Item"></div>

				<div class="Achievement-Container">
					<img class="Achievement-Img" src="../../Images/Tropy.png"></img>
					<div class="Achievement-Title"></div>
					<div class="Achievement-Description"></div>

					<div class="AchievementBar-Text"></div>
					<div class="AchievementBar">
						<div class="AchievementBar-Progress"></div>
					</div>

					<div class="AchievementReached-Text"></div>

					<div class="Achievement-Container2">
						<div class="Achievement-Sites"></div>
					</div>
				</div>
			</div>

			<div class="ThirdUIList2">
				<div class="ThirdUIList2-ItemBox-Container">
					<div class="ThirdUIList2-Item"></div>
				</div>

				<div class="ThirdUIList2-CratesBox-Container">
					<div class="ThirdUIList2-Crate"></div>
				</div>

				<div class="Crate" style="display: none;">
					
				</div>
			</div>

			<div class="ThirdUI-Navbar">
				<div class="ThirdUI-NavbarItem"></div>
			</div>
		</div>
	`);
	$(".ThirdUI").css("display","none");
	$(".ThirdUI-Navbar").css("display","none");
	$(".Title-Title").css("font-size","1.8vh");
	$(".Achievement-Container").css("display","none");

	/* Buttons */
	$("#ButtonClose").css("top","90vh");
	$("#ButtonClose").css("left","50%");
	$("#ButtonClose").css("transform","translateX(-50%)");
	$("#ButtonClose").css("width","31vh");




	$("#ButtonClose").click(function(){
		if(!antiDoubleClick){
			mta.triggerEvent("Userpanel:UI");
		}
	});

	document.onkeyup=function(event){
		if(event.key.toLowerCase()=="f1"){
			if(!antiDoubleClick){
				mta.triggerEvent("Userpanel:UI");
			}
		}
	}


	$(".ThirdUI-Bar-OpenCodeRedeemButton").on("click",function(){
		if($(".ThirdUI-Bar input").is(":visible")){
			mta.triggerEvent("Userpanel:RedeemCode:C",$("#redeem").val());
		}else{
			$(".ThirdUI-Bar input").css("display","block");
		}
	});
});

function setLanguageUserpanel(servername,title,           button_leaveUI){
	$(".Title-Title").html("<span>"+servername+"</span> - "+title+"");

	$("#ButtonClose").html(`<i class="fas fa-right-from-bracket"></i> ${button_leaveUI}`);
}

function setCrimeCoinValue(value){
	$(".CrimeCoins-Text span").text(value);

	CrimeCoins=Number(value);
}
function setUserpanelCratePrices(crate,price){
	CratePrices[Number(crate)]=Number(price);
}

function loadCategoriesInUserpanel(icon,name,id){
	$(".NavbarItem").append(`<div class='Navbar-Items' onclick="selectUserpanelCategory('${id}','${name}')"> <div class='Navbar-Item-Text'> <i class="${icon}"> </i> ${name} </div> </div>`);

	$(".Navbar-Items").click(function(){
		$(this).addClass("Navbar-Items-Active");
		$(".Navbar-Items").not(this).removeClass("Navbar-Items-Active");
	});
}
function selectUserpanelCategory(id,name){
	if(!antiDoubleClick){
		UserpanelCooldownSwitch(500);

		$(".ThirdUI").css("display","block");
		/*Crate stuff*/
		$(".ThirdUIList2-CratesBox-Container").css("display","none");
		$(".Crate").empty();
		$(".Crate").css("display","none");
		/*-----------*/

		$(".ThirdUI-Title").html(`${name}`);

		mta.triggerEvent("Userpanel:LoadItems",id);

		if(id=="Character"){
			$(".ThirdUIList").css("top","9vh");
			$(".ThirdUIList").css("left","3vh");
			$(".ThirdUIList").css("width","129vh");
			$(".ThirdUIList").css("height","84vh");

			$(".ThirdUI-Navbar").css("display","none");
			$(".ThirdUIList2").css("display","none");
			$(".Achievement-Container").css("display","none");
		}else if(id=="Levels"){
			$(".ThirdUIList").css("top","9vh");
			$(".ThirdUIList").css("left","3vh");
			$(".ThirdUIList").css("width","129vh");
			$(".ThirdUIList").css("height","84vh");

			$(".ThirdUI-Navbar").css("display","none");
			$(".ThirdUIList2").css("display","none");
			$(".Achievement-Container").css("display","none");
		}else if(id=="Achievements"){
			$(".ThirdUIList").css("top","9vh");
			$(".ThirdUIList").css("left","42vh");
			$(".ThirdUIList").css("width","89vh");
			$(".ThirdUIList").css("height","84vh");

			$(".ThirdUI-Navbar").css("display","block");
			$(".ThirdUIList2").css("display","none");
			$(".Achievement-Container").css("display","none");
		}else if(id=="Settings"){
			$(".ThirdUIList").css("top","9vh");
			$(".ThirdUIList").css("left","42vh");
			$(".ThirdUIList").css("width","89vh");
			$(".ThirdUIList").css("height","84vh");

			$(".ThirdUI-Navbar").css("display","block");
			$(".ThirdUIList2").css("display","block");
			$(".Achievement-Container").css("display","none");
		}else if(id=="Premium"){
			$(".ThirdUIList").css("top","9vh");
			$(".ThirdUIList").css("left","42vh");
			$(".ThirdUIList").css("width","89vh");
			$(".ThirdUIList").css("height","84vh");

			$(".ThirdUI-Navbar").css("display","block");
			$(".ThirdUIList2").css("display","block");
			$(".Achievement-Container").css("display","none");
		}else if(id=="Effects"){
			$(".ThirdUIList").css("top","9vh");
			$(".ThirdUIList").css("left","42vh");
			$(".ThirdUIList").css("width","89vh");
			$(".ThirdUIList").css("height","84vh");

			$(".ThirdUI-Navbar").css("display","block");
			$(".ThirdUIList2").css("display","block");
			$(".Achievement-Container").css("display","none");
		}else if(id=="Shaders"){
			$(".ThirdUIList").css("top","9vh");
			$(".ThirdUIList").css("left","42vh");
			$(".ThirdUIList").css("width","89vh");
			$(".ThirdUIList").css("height","84vh");

			$(".ThirdUI-Navbar").css("display","block");
			$(".ThirdUIList2").css("display","block");
			$(".Achievement-Container").css("display","none");
		}
	}
}

function loadSubCategoriesInUserpanel(icon,name,id){
	$(".ThirdUI-NavbarItem").append(`<div class='ThirdUI-Navbar-Items' onclick="selectUserpanelSubCategory('${id}')"> <div class='ThirdUI-Navbar-Item-Text'> <i class="${icon}"> </i> ${name} </div> </div>`);

	$(".ThirdUI-Navbar-Items").click(function(){
		$(this).addClass("ThirdUI-Navbar-Items-Active");
		$(".ThirdUI-Navbar-Items").not(this).removeClass("ThirdUI-Navbar-Items-Active");
	});
}
function selectUserpanelSubCategory(id){
	if(!antiDoubleClick){
		UserpanelCooldownSwitch(500);
		mta.triggerEvent("Userpanel:LoadItems2",id);
	}
}

function loadSubCategoryItemsInUserpanel(type,icon,title,name,id,type2){
	$(".ThirdUIList2-CratesBox-Container").css("display","none");
	$(".Crate").css("display","none");
	if(icon.includes("fa")){
		$(".ThirdUIList2-Item").append(`<div class='ThirdUIList2-ItemBox' onclick="changeSettingInUserpanel('${type}','${type2}','${id}')"> <div class='ThirdUIList2-ItemIcon MaskAqua'> <i class='${icon}'></i> </div> <div class='ThirdUIList2-ItemTitle MaskWhite'>${title}</div> <div class='ThirdUIList2-ItemText MaskWhite'>${name}</div> </div>`);
	}else{
		$(".ThirdUIList2-Item").append(`<div class='ThirdUIList2-ItemBox' onclick="changeSettingInUserpanel('${type}','${type2}','${id}')"> <img class='ThirdUIList2-ItemImg' src='../../${icon}.png'></img> <div class='ThirdUIList2-ItemTitle MaskWhite'>${title}</div> <div class='ThirdUIList2-ItemText MaskWhite'>${name}</div> </div>`);
	}
}
function loadSubCategoryCratesInUserpanel(type,image,name,id,text){
	$(".ThirdUIList2-CratesBox-Container").css("display","block");
	$(".Crate").css("display","none");
	$(".ThirdUIList2-Crate").append(`<div class='ThirdUIList2-CratesBox' onclick="openCrateUserpanel('${id}','${text}')"> <img class='ThirdUIList2-CratesBox-Img' src='../../${image}.png'></img> <div class='ThirdUIList2-ThirdUIList2-CratesBox-Text MaskWhite'>${name}</div> </div>`);
}
function changeSettingInUserpanel(id,type,value){
	mta.triggerEvent("Userpanel:ChangeSetting:C",id,type,value);
}

function openCrateUserpanel(value,text){
	if(!antiDoubleClick){
		if(value){//value = crate tier
			$(".ThirdUIList2-CratesBox-Container").css("display","none");
			$(".Crate").empty();
			$(".Crate").css("display","block");
			$(".Crate").append(`
				<div class="Crate-Spinner-Container">
					<div class="Crate-Raffle">
						<div class="Crate-Raffle-Holder">
							<div class="Crate-Spin" style="margin-left: 0px;">
							</div>
						</div>
					</div>
				</div>

				<div class="Crate-PossibleRewards-Container">
					<div class="PossibleRewardsItem"></div>
				</div>
				<div class="Crate-RewardHistory-Container">
					<div class="RewardHistoryItem"></div>
				</div>
			`);
			$(".Crate").append(`<button class="CrateSpinnerButton" onclick="openCrateSpinner('${value}')"> ${text} </button>`);
			
			for(const[k,v]of Object.entries(CaseItems[value])){
				$(".PossibleRewardsItem").append(`
					<div class="Crate-PossibleRewards-Items">
						<img class="Crate-PossibleRewards-Item-Img" src="${v.img}">
						<div class="Crate-PossibleRewards-Item-Text">${v.itemText}</div>
					</div>
				`);
			}
		}
	}
}

function openCrateSpinner(crate){
	if(!antiDoubleClick){
		let CrateTier=Number(crate);

		if(CaseItems[CrateTier]){
			if(CrimeCoins>=CratePrices[Number(crate)]){
				$(".CrateSpinnerButton").css("pointer-events","none");
				$(".Crate-Spin").css({
					transition:"sdf",
					"margin-left":"0vh"
				},10).html("");

				for(var i=0;i<101;i++){
					/* var element='<div id="CardNumber'+i+'" class="Crate-Item" style="background-image:url('+CaseItems[CrateTier][1].img+');"></div>'; */

					var Random=getRandomInt(0,Object.keys(CaseItems[CrateTier]).length-1);
					element='<div id="CardNumber'+i+'" class="Crate-Item" style="background-image:url('+CaseItems[CrateTier][Random].img+');"> </div>';
					$(element).appendTo(".Crate-Spin");
				}
				mta.triggerEvent("Userpanel:Crate:Opening:C","Coin",CrateTier);

				setTimeout(function(){
					UserpanelCooldownSwitch(9500);

					var count;

					if(CrateTier==1){
						var Random=getRandomInt(1,550);

						if(Random>0 && Random<=2){
							count=0;
							getCaseReward(CrateTier,CaseItems[CrateTier][count].itemText,CaseItems[CrateTier][count].img, CaseItems[CrateTier][count].amount[0],CaseItems[CrateTier][count].amount[1],CaseItems[CrateTier][count].item);
						}else if(Random>2 && Random<=4){
							count=1;
							getCaseReward(CrateTier,CaseItems[CrateTier][count].itemText,CaseItems[CrateTier][count].img, CaseItems[CrateTier][count].amount[0],CaseItems[CrateTier][count].amount[1],CaseItems[CrateTier][count].item);
						}else if(Random>4 && Random<=6){
							count=2;
							getCaseReward(CrateTier,CaseItems[CrateTier][count].itemText,CaseItems[CrateTier][count].img, CaseItems[CrateTier][count].amount[0],CaseItems[CrateTier][count].amount[1],CaseItems[CrateTier][count].item);
						}else if(Random>6 && Random<=8){
							count=3;
							getCaseReward(CrateTier,CaseItems[CrateTier][count].itemText,CaseItems[CrateTier][count].img, CaseItems[CrateTier][count].amount[0],CaseItems[CrateTier][count].amount[1],CaseItems[CrateTier][count].item);
						}else if(Random>8 && Random<=10){
							count=4;
							getCaseReward(CrateTier,CaseItems[CrateTier][count].itemText,CaseItems[CrateTier][count].img, CaseItems[CrateTier][count].amount[0],CaseItems[CrateTier][count].amount[1],CaseItems[CrateTier][count].item);
						}else if(Random>10 && Random<=12){
							count=5;
							getCaseReward(CrateTier,CaseItems[CrateTier][count].itemText,CaseItems[CrateTier][count].img, CaseItems[CrateTier][count].amount[0],CaseItems[CrateTier][count].amount[1],CaseItems[CrateTier][count].item);
						}else if(Random>12 && Random<=14){
							count=6;
							getCaseReward(CrateTier,CaseItems[CrateTier][count].itemText,CaseItems[CrateTier][count].img, CaseItems[CrateTier][count].amount[0],CaseItems[CrateTier][count].amount[1],CaseItems[CrateTier][count].item);
						}else if(Random>14 && Random<=16){
							count=7;
							getCaseReward(CrateTier,CaseItems[CrateTier][count].itemText,CaseItems[CrateTier][count].img, CaseItems[CrateTier][count].amount[0],CaseItems[CrateTier][count].amount[1],CaseItems[CrateTier][count].item);
						}else if(Random>16 && Random<=20){
							count=8;
							getCaseReward(CrateTier,CaseItems[CrateTier][count].itemText,CaseItems[CrateTier][count].img, CaseItems[CrateTier][count].amount[0],CaseItems[CrateTier][count].amount[1],CaseItems[CrateTier][count].item);
						}else if(Random>20 && Random<=25){
							count=9;
							getCaseReward(CrateTier,CaseItems[CrateTier][count].itemText,CaseItems[CrateTier][count].img, CaseItems[CrateTier][count].amount[0],CaseItems[CrateTier][count].amount[1],CaseItems[CrateTier][count].item);
						}else if(Random>25 && Random<=30){
							count=10;
							getCaseReward(CrateTier,CaseItems[CrateTier][count].itemText,CaseItems[CrateTier][count].img, CaseItems[CrateTier][count].amount[0],CaseItems[CrateTier][count].amount[1],CaseItems[CrateTier][count].item);
						}else if(Random>30 && Random<=35){
							count=11;
							getCaseReward(CrateTier,CaseItems[CrateTier][count].itemText,CaseItems[CrateTier][count].img, CaseItems[CrateTier][count].amount[0],CaseItems[CrateTier][count].amount[1],CaseItems[CrateTier][count].item);
						}else if(Random>35 && Random<=40){
							count=12;
							getCaseReward(CrateTier,CaseItems[CrateTier][count].itemText,CaseItems[CrateTier][count].img, CaseItems[CrateTier][count].amount[0],CaseItems[CrateTier][count].amount[1],CaseItems[CrateTier][count].item);
						}else if(Random>40 && Random<=45){
							count=13;
							getCaseReward(CrateTier,CaseItems[CrateTier][count].itemText,CaseItems[CrateTier][count].img, CaseItems[CrateTier][count].amount[0],CaseItems[CrateTier][count].amount[1],CaseItems[CrateTier][count].item);
						}else if(Random>45 && Random<=50){
							count=14;
							getCaseReward(CrateTier,CaseItems[CrateTier][count].itemText,CaseItems[CrateTier][count].img, CaseItems[CrateTier][count].amount[0],CaseItems[CrateTier][count].amount[1],CaseItems[CrateTier][count].item);
						}else if(Random>50 && Random<=65){
							count=15;
							getCaseReward(CrateTier,CaseItems[CrateTier][count].itemText,CaseItems[CrateTier][count].img, CaseItems[CrateTier][count].amount[0],CaseItems[CrateTier][count].amount[1],CaseItems[CrateTier][count].item);
						}else if(Random>65 && Random<=80){
							count=16;
							getCaseReward(CrateTier,CaseItems[CrateTier][count].itemText,CaseItems[CrateTier][count].img, CaseItems[CrateTier][count].amount[0],CaseItems[CrateTier][count].amount[1],CaseItems[CrateTier][count].item);
						}else if(Random>80 && Random<=95){
							count=17;
							getCaseReward(CrateTier,CaseItems[CrateTier][count].itemText,CaseItems[CrateTier][count].img, CaseItems[CrateTier][count].amount[0],CaseItems[CrateTier][count].amount[1],CaseItems[CrateTier][count].item);
						}else if(Random>95 && Random<=110){
							count=18;
							getCaseReward(CrateTier,CaseItems[CrateTier][count].itemText,CaseItems[CrateTier][count].img, CaseItems[CrateTier][count].amount[0],CaseItems[CrateTier][count].amount[1],CaseItems[CrateTier][count].item);
						}else if(Random>110 && Random<=125){
							count=19;
							getCaseReward(CrateTier,CaseItems[CrateTier][count].itemText,CaseItems[CrateTier][count].img, CaseItems[CrateTier][count].amount[0],CaseItems[CrateTier][count].amount[1],CaseItems[CrateTier][count].item);
						}else if(Random>125 && Random<=150){
							count=20;
							getCaseReward(CrateTier,CaseItems[CrateTier][count].itemText,CaseItems[CrateTier][count].img, CaseItems[CrateTier][count].amount[0],CaseItems[CrateTier][count].amount[1],CaseItems[CrateTier][count].item);
						}else if(Random>150 && Random<=175){
							count=21;
							getCaseReward(CrateTier,CaseItems[CrateTier][count].itemText,CaseItems[CrateTier][count].img, CaseItems[CrateTier][count].amount[0],CaseItems[CrateTier][count].amount[1],CaseItems[CrateTier][count].item);
						}else if(Random>175 && Random<=200){
							count=22;
							getCaseReward(CrateTier,CaseItems[CrateTier][count].itemText,CaseItems[CrateTier][count].img, CaseItems[CrateTier][count].amount[0],CaseItems[CrateTier][count].amount[1],CaseItems[CrateTier][count].item);
						}else if(Random>200 && Random<=225){
							count=23;
							getCaseReward(CrateTier,CaseItems[CrateTier][count].itemText,CaseItems[CrateTier][count].img, CaseItems[CrateTier][count].amount[0],CaseItems[CrateTier][count].amount[1],CaseItems[CrateTier][count].item);
						}else if(Random>225 && Random<=250){
							count=24;
							getCaseReward(CrateTier,CaseItems[CrateTier][count].itemText,CaseItems[CrateTier][count].img, CaseItems[CrateTier][count].amount[0],CaseItems[CrateTier][count].amount[1],CaseItems[CrateTier][count].item);
						}else if(Random>250 && Random<=275){
							count=25;
							getCaseReward(CrateTier,CaseItems[CrateTier][count].itemText,CaseItems[CrateTier][count].img, CaseItems[CrateTier][count].amount[0],CaseItems[CrateTier][count].amount[1],CaseItems[CrateTier][count].item);
						}else if(Random>275 && Random<=350){
							count=26;
							getCaseReward(CrateTier,CaseItems[CrateTier][count].itemText,CaseItems[CrateTier][count].img, CaseItems[CrateTier][count].amount[0],CaseItems[CrateTier][count].amount[1],CaseItems[CrateTier][count].item);
						}else{
							count=27;
							getCaseReward(CrateTier,CaseItems[CrateTier][count].itemText,CaseItems[CrateTier][count].img, CaseItems[CrateTier][count].amount[0],CaseItems[CrateTier][count].amount[1],CaseItems[CrateTier][count].item);
						}
					}
					if(CrateTier==2){
						var Random=getRandomInt(1,250);

						if(Random>0 && Random<=10){
							count=0;
							getCaseReward(CrateTier,CaseItems[CrateTier][count].itemText,CaseItems[CrateTier][count].img, CaseItems[CrateTier][count].amount[0],CaseItems[CrateTier][count].amount[1],CaseItems[CrateTier][count].item);
						}else if(Random>10 && Random<=20){
							count=1;
							getCaseReward(CrateTier,CaseItems[CrateTier][count].itemText,CaseItems[CrateTier][count].img, CaseItems[CrateTier][count].amount[0],CaseItems[CrateTier][count].amount[1],CaseItems[CrateTier][count].item);
						}else if(Random>20 && Random<=30){
							count=2;
							getCaseReward(CrateTier,CaseItems[CrateTier][count].itemText,CaseItems[CrateTier][count].img, CaseItems[CrateTier][count].amount[0],CaseItems[CrateTier][count].amount[1],CaseItems[CrateTier][count].item);
						}else if(Random>30 && Random<=40){
							count=3;
							getCaseReward(CrateTier,CaseItems[CrateTier][count].itemText,CaseItems[CrateTier][count].img, CaseItems[CrateTier][count].amount[0],CaseItems[CrateTier][count].amount[1],CaseItems[CrateTier][count].item);
						}else if(Random>40 && Random<=50){
							count=4;
							getCaseReward(CrateTier,CaseItems[CrateTier][count].itemText,CaseItems[CrateTier][count].img, CaseItems[CrateTier][count].amount[0],CaseItems[CrateTier][count].amount[1],CaseItems[CrateTier][count].item);
						}else if(Random>50 && Random<=60){
							count=5;
							getCaseReward(CrateTier,CaseItems[CrateTier][count].itemText,CaseItems[CrateTier][count].img, CaseItems[CrateTier][count].amount[0],CaseItems[CrateTier][count].amount[1],CaseItems[CrateTier][count].item);
						}else if(Random>60 && Random<=70){
							count=6;
							getCaseReward(CrateTier,CaseItems[CrateTier][count].itemText,CaseItems[CrateTier][count].img, CaseItems[CrateTier][count].amount[0],CaseItems[CrateTier][count].amount[1],CaseItems[CrateTier][count].item);
						}else if(Random>70 && Random<=150){
							count=7;
							getCaseReward(CrateTier,CaseItems[CrateTier][count].itemText,CaseItems[CrateTier][count].img, CaseItems[CrateTier][count].amount[0],CaseItems[CrateTier][count].amount[1],CaseItems[CrateTier][count].item);
						}else{
							count=8;
							getCaseReward(CrateTier,CaseItems[CrateTier][count].itemText,CaseItems[CrateTier][count].img, CaseItems[CrateTier][count].amount[0],CaseItems[CrateTier][count].amount[1],CaseItems[CrateTier][count].item);
						}
					}
					if(CrateTier==3){
						var Random=getRandomInt(1,250);

						if(Random>0 && Random<=5){
							count=0;
							getCaseReward(CrateTier,CaseItems[CrateTier][count].itemText,CaseItems[CrateTier][count].img, CaseItems[CrateTier][count].amount[0],CaseItems[CrateTier][count].amount[1],CaseItems[CrateTier][count].item);
						}else if(Random>5 && Random<=10){
							count=1;
							getCaseReward(CrateTier,CaseItems[CrateTier][count].itemText,CaseItems[CrateTier][count].img, CaseItems[CrateTier][count].amount[0],CaseItems[CrateTier][count].amount[1],CaseItems[CrateTier][count].item);
						}else if(Random>10 && Random<=15){
							count=2;
							getCaseReward(CrateTier,CaseItems[CrateTier][count].itemText,CaseItems[CrateTier][count].img, CaseItems[CrateTier][count].amount[0],CaseItems[CrateTier][count].amount[1],CaseItems[CrateTier][count].item);
						}else if(Random>15 && Random<=20){
							count=3;
							getCaseReward(CrateTier,CaseItems[CrateTier][count].itemText,CaseItems[CrateTier][count].img, CaseItems[CrateTier][count].amount[0],CaseItems[CrateTier][count].amount[1],CaseItems[CrateTier][count].item);
						}else if(Random>20 && Random<=25){
							count=4;
							getCaseReward(CrateTier,CaseItems[CrateTier][count].itemText,CaseItems[CrateTier][count].img, CaseItems[CrateTier][count].amount[0],CaseItems[CrateTier][count].amount[1],CaseItems[CrateTier][count].item);
						}else if(Random>25 && Random<=35){
							count=5;
							getCaseReward(CrateTier,CaseItems[CrateTier][count].itemText,CaseItems[CrateTier][count].img, CaseItems[CrateTier][count].amount[0],CaseItems[CrateTier][count].amount[1],CaseItems[CrateTier][count].item);
						}else if(Random>35 && Random<=45){
							count=6;
							getCaseReward(CrateTier,CaseItems[CrateTier][count].itemText,CaseItems[CrateTier][count].img, CaseItems[CrateTier][count].amount[0],CaseItems[CrateTier][count].amount[1],CaseItems[CrateTier][count].item);
						}else if(Random>45 && Random<=55){
							count=7;
							getCaseReward(CrateTier,CaseItems[CrateTier][count].itemText,CaseItems[CrateTier][count].img, CaseItems[CrateTier][count].amount[0],CaseItems[CrateTier][count].amount[1],CaseItems[CrateTier][count].item);
						}else if(Random>55 && Random<=65){
							count=8;
							getCaseReward(CrateTier,CaseItems[CrateTier][count].itemText,CaseItems[CrateTier][count].img, CaseItems[CrateTier][count].amount[0],CaseItems[CrateTier][count].amount[1],CaseItems[CrateTier][count].item);
						}else if(Random>65 && Random<=80){
							count=9;
							getCaseReward(CrateTier,CaseItems[CrateTier][count].itemText,CaseItems[CrateTier][count].img, CaseItems[CrateTier][count].amount[0],CaseItems[CrateTier][count].amount[1],CaseItems[CrateTier][count].item);
						}else if(Random>80 && Random<=200){
							count=10;
							getCaseReward(CrateTier,CaseItems[CrateTier][count].itemText,CaseItems[CrateTier][count].img, CaseItems[CrateTier][count].amount[0],CaseItems[CrateTier][count].amount[1],CaseItems[CrateTier][count].item);
						}else{
							count=11;
							getCaseReward(CrateTier,CaseItems[CrateTier][count].itemText,CaseItems[CrateTier][count].img, CaseItems[CrateTier][count].amount[0],CaseItems[CrateTier][count].amount[1],CaseItems[CrateTier][count].item);
						}
					}
				},250);
			}
		}
	}
}

function getCaseReward(crate,title,image,amountmin,amountmax,item){
	$(".Crate-Spin").css({
		transition: "all 8s cubic-bezier(.08,.6,0,1)"
	});

	$("#CardNumber70").css({
		"background-image": "url("+image+")"
	});

	setTimeout(function(){
		$("#CardNumber70").addClass("Crate-Item-Win");
		
		var winAmount="";
		if(!item.includes("Weapon_")&& !item.includes("Skin_")){
			winAmount=getRandomInt(amountmin,amountmax);
		}

		$(".RewardHistoryItem").append(`
			<div class="Crate-RewardHistory-Items">
				<img class="Crate-RewardHistory-Item-Img" src="${image}">
				<div class="Crate-RewardHistory-Item-Text">${title}</div>
				<div class="Crate-RewardHistory-Item-Text2">${winAmount}</div>
			</div>
		`);

		mta.triggerEvent("Userpanel:Crate:Opening:C","GiveItem",crate,item,winAmount,title);

		$(".Crate-RewardHistory-Container").fadeIn("slow");
	},8500);
	setTimeout(function(){
		$(".CrateSpinnerButton").css("pointer-events","all");
	},9000);
	
	$(".Crate-Spin").css('margin-left','-6770px');
}

function loadAchievementItemsInUserpanel(title,desc,reachedText,current,currentTier,luaTbl){
	var Datas=JSON.parse(luaTbl)[0];
	var Level=Number(currentTier);

	$(".Achievement-Container").css("display","block");
	$(".AchievementBar").css("display","block");
	$(".AchievementReached-Text").css("display","none");
	
	$(".Achievement-Title").text(title);
	$(".Achievement-Description").text(desc);

	if(current!=="nil" && Datas.Requirement[Level]){
		var Progress=Number(current)/Number(Datas.Requirement[Level])*100;
		if(Progress && Progress==0){
			$(".AchievementBar-Progress").css("display","none");
		}else if(Progress && Progress>100){
			$(".AchievementBar-Progress").css("display","block");
			$(".AchievementBar-Progress").css("width","100%");
		}else{
			$(".AchievementBar-Progress").css("display","block");
			$(".AchievementBar-Progress").css("width",Progress+"%");
		}
		$(".AchievementBar-Text").text(current+" / "+Datas.Requirement[Level]);
		$(".AchievementBar-Text").css("display","block")
	}else{
		$(".AchievementBar").css("display","none");
		$(".AchievementBar-Text").css("display","none");
	}

	if(Datas.Reward[Level]&& Datas.Reward[Level].Money){
		$(".Achievement-Sites").empty();
		$(".Achievement-Sites").append(`
			<button tabindex="-1" class="Achievement-SiteButton"><div class="Achievement-SiteButton-Icon"><i class='far fa-circle-dollar MaskAqua'></i></div> <div class="Achievement-SiteButton-Reward">+${Datas.Reward[Level].Money}</div></button>
		`);
		$(".Achievement-Container2").css("display","block");

		if(Datas.Reward[Level]&& Datas.Reward[Level].Item && Datas.Reward[Level].Item[0]){
			$(".Achievement-Sites").append(`
				<button tabindex="-1" class="Achievement-SiteButton"><img class="Achievement-SiteButton-Img" src="../../Images/Items/${Datas.Reward[Level].Item[0]}.png"> <div class="Achievement-SiteButton-Reward">+${Datas.Reward[Level].Item[1]}</div></button>
			`);
		}
	}else if(Datas.Reward[Level]&& Datas.Reward[Level].Item && Datas.Reward[Level].Item[0]){
		$(".Achievement-Sites").empty();
		$(".Achievement-Sites").append(`
			<button tabindex="-1" class="Achievement-SiteButton"><img class="Achievement-SiteButton-Img" src="../../Images/Items/${Datas.Reward[Level].Item[0]}.png"> <div class="Achievement-SiteButton-Reward">+${Datas.Reward[Level].Item[1]}</div></button>
		`);
		$(".Achievement-Container2").css("display","block");
	}else{
		$(".Achievement-Sites").empty();
		$(".Achievement-Container2").css("display","none");
		$(".AchievementReached-Text").css("display","block");
		$(".AchievementReached-Text").text(reachedText);
	}
}





function UserpanelCooldownSwitch(time){
	antiDoubleClick=true;

	setTimeout(function(){
		antiDoubleClick=false;
	},time);
}