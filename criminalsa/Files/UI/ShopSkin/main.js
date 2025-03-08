var SelectedItem=null;

var SelectedCoupon="none";
var Coupons=[];

//rotation
var RotTimestamp;
var RotLastMouseX;
let RotDirection="";
let RotOldX=0;
let RotLeftMouseButtonPressed=false;


$(document).ready(function(){
	$(".MainUI").empty();
	$(".MainUI").append(`
		<div class="SecondUI">
			<div class="Title-Bar">
				<div class="Title-Title">N/A</div>
			</div>

			<input type="text" id="search" maxlength="5" oninput="searchSkin()" placeholder="N/A">

			<div class="Navbar" id="SortItems">
				<div class="NavbarItem"></div>
			</div>

			<button class="Button" id="ButtonClose"> N/A </button>
		</div>

		<div class="ThirdUI">
			<div class="ThirdUI-Bar">
				<div class="ThirdUI-Title">N/A</div>
			</div>

			<div class="Information-Bar" id="Limited-Bar">
				<div class="Information-Title MaskRed" id="Limited-Title"> Limited time </div>
				<div class="Information-Title"><i class="fas fa-clock MaskRed"></i> <span class="MaskWhite" id="Limited-Text"> N/A </span></div>
			</div>

			<div class="Information-Bar" id="Price-Bar">
				<div class="Information-Title"><i class="fas fa-dollar-sign MaskAqua"></i> <span class="MaskWhite" id="Price"> N/A </span></div>
			</div>

			<div class="dropdown-container" id="CouponDropdown">
				<div class="dropdown-select-button" onclick="toggleSkinshopDropDown()"><span id="CouponSelect">N/A</span>
					<span id="dropdown-arrow"><i class="fa-solid fa-caret-down"></i></span>
				</div>
				<div class="dropdown-item-list">
					
				</div>
			</div>

			<button class="Button" onclick="skinshopFunction()" id="Buy"> N/A </button>
		</div>
	`);
	$(".ThirdUI").css("display","none");
	/* Buttons */
	$("#Buy").css("top","34vh");
	$("#Buy").css("left","50%");
	$("#Buy").css("transform","translateX(-50%)");
	$("#Buy").css("width","28vh");

	$("#ButtonClose").css("top","90vh");
	$("#ButtonClose").css("left","50%");
	$("#ButtonClose").css("transform","translateX(-50%)");
	$("#ButtonClose").css("width","31vh");

	/* Display informations */
	$("#Limited-Bar").css("display","none");
	$("#Limited-Bar").css("top","-10vh");
	$("#Limited-Bar").css("left","50%");
	$("#Limited-Bar").css("transform","translateX(-50%)");
	$("#Limited-Bar").css("width","35vh");
	$("#Limited-Bar").css("height","6vh");
	$("#Limited-Bar").css("background","repeating-linear-gradient(-55deg,rgba(56, 56, 56, 0.36),rgba(56, 56, 56, 0.36) 1.0vh,rgba(56, 56, 56, 0.4), 1.0vh,rgba(56, 56, 56, 0.4) 2.0vh)");
	$("#Limited-Bar").css("background-color","rgb(0, 0, 0)");

	$("#Price-Bar").css("top","8vh");
	$("#Price-Bar").css("left","2vh");

	/* Coupons */
	$("#CouponDropdown").css("top","22vh");

	/* Rotate */
	window.addEventListener("mousemove",SkinshopMouseMove);
    window.addEventListener("mousedown",SkinshopMouseDown);
    window.addEventListener("mouseup",SkinshopMouseUp);


	$("#ButtonClose").click(function(){
		mta.triggerEvent("SkinShop:UI");
	});
});


function setLanguageShopSkin(servername,title,searchbar,selectcoupon,           button_leaveUI,button_buy){
	SelectedItem=null;
	SelectedCoupon="none";

	$(".Title-Title").html("<span>"+servername+"</span> - "+title+"");

	$("#Buy").html(`<i class="fas fa-money-bill"></i> ${button_buy}`);
	$("#ButtonClose").html(`<i class="fas fa-right-from-bracket"></i> ${button_leaveUI}`);

	$("#search").attr("placeholder",searchbar);

	$("#CouponSelect").text(selectcoupon);
}

const GenderIcons={
	["male"]:{
	  	["icon"]: "fas fa-mars",
		["color"]: "rgba(80,190,240,1)",
	},
	["female"]:{
	  	["icon"]: "fas fa-venus",
		["color"]: "rgba(255,15,135,1)",
	},
};
function loadSkinsInShopList(item,name,icon,timestamp,onlyincrates){
	SelectedItem=null;

	if(timestamp && timestamp>0){
		$('.NavbarItem').append(`<div class='Navbar-Items' onclick="selectShopSkin('${item}')"> <div class="Navbar-Item-Icon-Gender"> <i style="color: ${GenderIcons[icon]["color"]};" class="${GenderIcons[icon]["icon"]}"></i> </div> <div class='Navbar-Item-Text'> ${name} </div> <div class='Navbar-Item-Text-Limited MaskRed'> <i class="far fa-clock"></i> </div> </div>`);
	}else{
		if(onlyincrates=="true"){
			$('.NavbarItem').append(`<div class='Navbar-Items' onclick="selectShopSkin('${item}')"> <div class="Navbar-Item-Icon-Gender"> <i style="color: ${GenderIcons[icon]["color"]};" class="${GenderIcons[icon]["icon"]}"></i> </div> <div class='Navbar-Item-Text'> ${name} </div> <div class='Navbar-Item-Text-OnlyInCrates MaskRed'> <i class="fas fa-treasure-chest"></i> </div> </div>`);
		}else{
			$('.NavbarItem').append(`<div class='Navbar-Items' onclick="selectShopSkin('${item}')"> <div class="Navbar-Item-Icon-Gender"> <i style="color: ${GenderIcons[icon]["color"]};" class="${GenderIcons[icon]["icon"]}"></i> </div> <div class='Navbar-Item-Text'> ${name} </div> </div>`);
		}
	}

	searchSkin();

	$(".Navbar-Items").click(function(){
		$(this).addClass("Navbar-Items-Active");
		$(".Navbar-Items").not(this).removeClass("Navbar-Items-Active");
	});
}

function showShopSkinDetails(id,name,price,timestamp,onlyincrates){
	SelectedItem=id;

	$(".ThirdUI").css("display","block");

	$(".ThirdUI-Title").html(`${name}`);
	$("#Price").html(`${price}`);

	if(timestamp && timestamp>0){
		$("#Limited-Bar").css("display","block");
		$("#Limited-Text").html(`${formatSecondsToTime(timestamp)}`);
	}else{
		$("#Limited-Bar").css("display","none");
	}

	if(onlyincrates && onlyincrates=="true"){
		$(".ThirdUI").css("display","none");
	}
}

function selectShopSkin(item){
	mta.triggerEvent("SkinShop:LoadDatas",item);
}

function skinshopFunction(){
	if(SelectedItem){
		mta.triggerEvent("SkinShop:Buy:C",SelectedItem,SelectedCoupon);
	}
}

function loadSkinshopCoupons(item,name){
	Coupons[item]=name;

	$('.dropdown-item-list').append(`<button class="dropdown-item" onclick="selectVehicleshopCoupon('${item}')">${name}</button>`);
}




function toggleSkinshopDropDown(){
	const dropDownActive=$(".dropdown-item-list").css("display")==="block";
	if(dropDownActive){
		$(".dropdown-item-list").hide();
	  	$("#dropdown-arrow").html(`<i class="fa-solid fa-caret-down"></i>`);

		$("#Buy").show();
	}else{
		$(".dropdown-item-list").show();
		$("#dropdown-arrow").html(`<i class="fa-solid fa-caret-up"></i>`);

		$("#Buy").hide();
	}
}

function selectVehicleshopCoupon(id){
	$("#CouponSelect").text(Coupons[id]);
	SelectedCoupon=id;
	mta.triggerEvent("SkinShop:SelectCoupon",id);
	mta.triggerEvent("SkinShop:LoadDatas",SelectedItem);

	setTimeout(()=>{
		toggleSkinshopDropDown();
	},0);
}

function SkinshopMouseMove(e){
    if(RotTimestamp===null){
        RotTimestamp=Date.now();
        RotLastMouseX=e.screenX;
        return;
    }
  
    var now = Date.now();
    var dt =  now - RotTimestamp;
    let dx = RotLastMouseX - e.screenX;
    if (e.screenX > RotLastMouseX) {
        dx = e.screenX - RotLastMouseX;
    }
    var mouseSpeed = Math.round(dx / dt * 100);
  
    RotTimestamp=now;
    RotLastMouseX=e.screenX;
  
    const elementUnderCursor=document.elementFromPoint(e.clientX,e.clientY);
    if(e.pageX<RotOldX){
        RotDirection="left";
        if(RotLeftMouseButtonPressed && elementUnderCursor.id=="SkinShop"){
            mta.triggerEvent("SkinShop:Show:Rotate",RotDirection,mouseSpeed);
		}else if(!RotLeftMouseButtonPressed && elementUnderCursor.id=="SkinShop"){
			mta.triggerEvent("SkinShop:Show:Rotate");
        }
    }else if(e.pageX>RotOldX){
        RotDirection="right";
        if(RotLeftMouseButtonPressed && elementUnderCursor.id=="SkinShop"){
			mta.triggerEvent("SkinShop:Show:Rotate",RotDirection,mouseSpeed);
		}else if(!RotLeftMouseButtonPressed && elementUnderCursor.id=="SkinShop"){
			mta.triggerEvent("SkinShop:Show:Rotate");
		}
    }
  
    RotTimestamp=now;
    RotLastMouseX=e.screenX;
  
    RotOldX=e.pageX;
}
function SkinshopMouseDown(e){
    const elementUnderCursor=document.elementFromPoint(e.clientX,e.clientY);
    if(e.button===0 && elementUnderCursor.id=="SkinShop"){
        RotLeftMouseButtonPressed=true;
    }
}
function SkinshopMouseUp(e){
    if(e.button===0){
        RotLeftMouseButtonPressed=false;
    }
}






function searchSkin(){
	input=document.getElementById("search");
	filter=input.value.toUpperCase();
	searchSkins=document.getElementById("SortItems");
	Info=searchSkins.getElementsByClassName("Navbar-Item-Text");
	
	for(i=0; i<Info.length; i++){
		txtValue=Info[i].innerText;
		if(txtValue.toUpperCase().indexOf(filter)>-1){
		   	Info[i].parentElement.style.display="block";
		}else{
			Info[i].parentElement.style.display="none";
			txtValue=Info[i].innerText;
		}
	}
	searchInput=input.value;
}