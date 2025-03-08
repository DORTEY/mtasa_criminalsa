var antiDoubleClick=false;

var SelectedItem=null;

let ColorR=0;
let ColorG=0;
let ColorB=0;

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

			<input type="text" id="search" maxlength="5" oninput="searchVehicle()" placeholder="N/A">

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
			<div class="Information-Bar" id="Seats-Bar">
				<div class="Information-Title"><i class="fas fa-seat-airline MaskAqua"></i> <span class="MaskWhite" id="Seats"> N/A </span></div>
			</div>
			<div class="Information-Bar" id="DriveType-Bar">
				<div class="Information-Title"><i class="fas fa-tire MaskAqua"></i> <span class="MaskWhite" id="DriveType"> N/A </span></div>
			</div>
			<div class="Information-Bar" id="Speed-Bar">
				<div class="Information-Title"><i class="fas fa-gauge-max MaskAqua"></i> <span class="MaskWhite" id="Speed"> N/A </span></div>
			</div>

			<div class="Container-Colors">
				
			</div>

			<div class="dropdown-container" id="CouponDropdown">
				<div class="dropdown-select-button" onclick="toggleVehicleshopDropDown()"><span id="CouponSelect">N/A</span>
					<span id="dropdown-arrow"><i class="fa-solid fa-caret-down"></i></span>
				</div>
				<div class="dropdown-item-list">
					
				</div>
			</div>

			<button class="Button" onclick="vehicle('buy')" id="Buy"> N/A </button>
			<button class="Button" onclick="vehicle('test')" id="Test"> N/A </button>
		</div>
	`);
	$(".ThirdUI").css("display","none");
	$(".Title-Title").css("font-size","1.7vh");
	/* Buttons */
	$("#Buy").css("top","33vh");
	$("#Buy").css("left","50%");
	$("#Buy").css("transform","translateX(-50%)");
	$("#Buy").css("width","28vh");

	$("#Test").css("top","39vh");
	$("#Test").css("left","50%");
	$("#Test").css("transform","translateX(-50%)");
	$("#Test").css("width","28vh");

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
	$("#Seats-Bar").css("top","8vh");
	$("#Seats-Bar").css("left","18vh");
	$("#DriveType-Bar").css("top","14vh");
	$("#DriveType-Bar").css("left","2vh");
	$("#DriveType").css("text-transform","uppercase");
	$("#Speed-Bar").css("top","14vh");
	$("#Speed-Bar").css("left","18vh");
	/* Colors */
	Colors=[
		{r:"0",g:"0",b:"0"},
		{r:"255",g:"255",b:"255"},
		{r:"255",g:"60",b:"60"},
		{r:"255",g:"255",b:"60"},
		{r:"0",g:"120",b:"255"},
		{r:"200",g:"60",b:"255"},
	];
	Colors.forEach((value,index)=>{
		$(".Container-Colors").append(`
			<button tabindex="-1" class="ColorButton" onclick="changeVehicleshopColor('${value.r}','${value.g}','${value.b}')" style="color: rgba(${value.r},${value.g},${value.b},1);"><i class='fas fa-circle'></i></button>
		`);
	});

	/* Color */
	$(".ColorButton").on("click",function(){
		$(this).addClass("CategorieActive");
		$(".ColorButton").not(this).removeClass("CategorieActive");
	});

	/* Coupons */
	$("#CouponDropdown").css("top","26vh");

	/* Rotate */
	window.addEventListener("mousemove",VehicleshopMouseMove);
    window.addEventListener("mousedown",VehicleshopMouseDown);
    window.addEventListener("mouseup",VehicleshopMouseUp);


	$("#ButtonClose").click(function(){
		mta.triggerEvent("Vehicleshop:UI");
	});
});


function setLanguageVehicleshop(servername,title,searchbar,selectcoupon,           button_leaveUI,button_buy,button_test){
	SelectedItem=null;
	SelectedCoupon="none";
	
	$(".Title-Title").html("<span>"+servername+"</span> - "+title+"");

	$("#Buy").html(`<i class="fas fa-money-bill"></i> ${button_buy}`);
	$("#Test").html(`<i class="fas fa-steering-wheel"></i> ${button_test}`);
	$("#ButtonClose").html(`<i class="fas fa-right-from-bracket"></i> ${button_leaveUI}`);

	$("#search").attr("placeholder",searchbar);

	$("#CouponSelect").text(selectcoupon);
}


function loadVehiclesInCarhouseList(id,name,timestamp){
	SelectedItem=null;

	if(timestamp && timestamp>0){
		$('.NavbarItem').append(`<div class='Navbar-Items' onclick="selectCarhouseVehicle('${id}')"> <div class='Navbar-Item-Text'> ${name} </div> <div class='Navbar-Item-Text-Limited MaskRed'> <i class="far fa-clock"></i> </div> </div>`);
	}else{
		$('.NavbarItem').append(`<div class='Navbar-Items' onclick="selectCarhouseVehicle('${id}')"> <div class='Navbar-Item-Text'> ${name} </div> </div>`);
	}

	searchVehicle();

	$(".Navbar-Items").click(function(){
		$(this).addClass("Navbar-Items-Active");
		$(".Navbar-Items").not(this).removeClass("Navbar-Items-Active");
	});
}

function showCarhouseVehicleDetails(id,name,price,seats,drivetype,speed,timestamp){
	SelectedItem=id;

	$(".ThirdUI").css("display","block");

	$(".ThirdUI-Title").html(`${name}`);
	$("#Price").html(`${price}`);
	$("#Seats").html(`${seats}`);
	$("#DriveType").html(`${drivetype}`);
	$("#Speed").html(`${speed}`);

	if(timestamp && timestamp>0){
		$("#Limited-Bar").css("display","block");
		$("#Limited-Text").html(`${formatSecondsToTime(timestamp)}`);
	}else{
		$("#Limited-Bar").css("display","none");
	}
}

function changeVehicleshopColor(r,g,b){
	ColorR=r;
	ColorG=g;
	ColorB=b;
	mta.triggerEvent("Vehicleshop:Show:PreviewColor",r,g,b);
}


function selectCarhouseVehicle(id){
	if(!antiDoubleClick){
		VehicleshopCooldownSwitch(500);
		mta.triggerEvent("Vehicleshop:LoadDatas",id);
	}
}

function vehicle(type){
	if(SelectedItem){
		mta.triggerEvent("Vehicleshop:BuyTest:C",type,SelectedItem,SelectedCoupon);
	}
}

function loadVehicleshopCoupons(item,name){
	Coupons[item]=name;

	$(".dropdown-item-list").append(`<button class="dropdown-item" onclick="selectVehicleshopCoupon('${item}')">${name}</button>`);
}




function toggleVehicleshopDropDown(){
	const dropDownActive=$(".dropdown-item-list").css("display")==="block";
	if(dropDownActive){
		$(".dropdown-item-list").hide();
	  	$("#dropdown-arrow").html(`<i class="fa-solid fa-caret-down"></i>`);

		$("#Buy").show();
		$("#Test").show();
	}else{
		$(".dropdown-item-list").show();
		$("#dropdown-arrow").html(`<i class="fa-solid fa-caret-up"></i>`);

		$("#Buy").hide();
		$("#Test").hide();
	}
}

function selectVehicleshopCoupon(id){
	$("#CouponSelect").text(Coupons[id]);
	SelectedCoupon=id;
	mta.triggerEvent("Vehicleshop:SelectCoupon",id);
	mta.triggerEvent("Vehicleshop:LoadDatas",SelectedItem);

	setTimeout(()=>{
		toggleVehicleshopDropDown();
	},0);
}

function VehicleshopMouseMove(e){
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
        if(RotLeftMouseButtonPressed && elementUnderCursor.id=="Vehicleshop"){
            mta.triggerEvent("Vehicleshop:Show:Rotate",RotDirection,mouseSpeed);
		}else if(!RotLeftMouseButtonPressed && elementUnderCursor.id=="Vehicleshop"){
			mta.triggerEvent("Vehicleshop:Show:Rotate");
        }
    }else if(e.pageX>RotOldX){
        RotDirection="right";
        if(RotLeftMouseButtonPressed && elementUnderCursor.id=="Vehicleshop"){
			mta.triggerEvent("Vehicleshop:Show:Rotate",RotDirection,mouseSpeed);
		}else if(!RotLeftMouseButtonPressed && elementUnderCursor.id=="Vehicleshop"){
			mta.triggerEvent("Vehicleshop:Show:Rotate");
		}
    }
  
    RotTimestamp=now;
    RotLastMouseX=e.screenX;
  
    RotOldX=e.pageX;
}
function VehicleshopMouseDown(e){
    const elementUnderCursor=document.elementFromPoint(e.clientX,e.clientY);
    if(e.button===0 && elementUnderCursor.id=="Vehicleshop"){
        RotLeftMouseButtonPressed=true;
    }
}
function VehicleshopMouseUp(e){
    if(e.button===0){
        RotLeftMouseButtonPressed=false;
    }
}





function VehicleshopCooldownSwitch(time){
	antiDoubleClick=true;

	setTimeout(function(){
		antiDoubleClick=false;
	},time);
}









function searchVehicle(){
	input=document.getElementById("search");
	filter=input.value.toUpperCase();
	searchVehicles=document.getElementById("SortItems");
	Info=searchVehicles.getElementsByClassName("Navbar-Item-Text");
	
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