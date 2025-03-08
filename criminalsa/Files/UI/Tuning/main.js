var antiDoubleClick=false;

var ColorType=null;
var SelectedTuning=null;


$(document).ready(function(){
	$(".MainUI").empty();
	$(".MainUI").append(`
		<div class="SecondUI">
			<div class="Title-Bar">
				<div class="Title-Title">N/A</div>
				<button class="ButtonClose"><i class="fas fa-xmark"></i></button>
			</div>

			<div class="Navbar" id="SortItems">
				<div class="NavbarItem"></div>
			</div>
		</div>

		<div class="ThirdUI">
			<div class="ThirdUI-Bar">
				<div class="ThirdUI-Title">N/A</div>
			</div>

			<input type="text" id="search" maxlength="5" oninput="searchTuning()" placeholder="N/A">




			<div class="Colorpicker" display: none;>
				<div id="color_picker_container">
					<canvas id="color_block" height="120" width="150"></canvas>
					<canvas id="hue_bar" height="120" width="30"></canvas>
				</div>
				<div class="select_container">
					
				</div>
			</div>

			<div class="TuningList" id="SortTuning" display: none;>
				<div class="TuningListItem"></div>
			</div>

			<button class="Button" id="Buy"> </button>
		</div>
	`);
	$(".ThirdUI").css("display","none");

	$("#Buy").hide();
	$("#Buy").css("top","55vh");
	$("#Buy").css("left","50%");
	$("#Buy").css("transform","translatex(-50%)");
	$("#Buy").css("width","32vh");
	

	$(".ButtonClose").on("click",function(){
		mta.triggerEvent("Tuning:UI");
	});

	$("#Buy").on("click",function(){
		if(SelectedTuning && SelectedTuning!==null){
			mta.triggerEvent("Tuning:Tuningpart:C","Buy",SelectedTuning);
		}
	});










	/* COLORPICKER */
	const hueBarState = {x: 0,y: 0};

	const colorBlock = document.getElementById("color_block");
	const ctx_colorBlock = colorBlock.getContext("2d");
	const colorBlockWidth = colorBlock.width;
	const colorBlockHeight = colorBlock.height;

	const hueBar = document.getElementById("hue_bar");
	const ctx_hueBar = hueBar.getContext("2d");
	const hueBarWidth = hueBar.width;
	const hueBarHeight = hueBar.height;

	const colorBlockState = {x: 0,y: 0};
	const colorPickerState = {drag: false,rgbaColor: "rgba(255,0,0,1)"};

	ctx_colorBlock.rect(0, 0, colorBlockWidth, colorBlockHeight);
	fillColorBlockGradient();

	ctx_hueBar.rect(0, 0, hueBarWidth, hueBarHeight);
	const grd1 = ctx_hueBar.createLinearGradient(0, 0, 0, colorBlockHeight);
	grd1.addColorStop(0, "rgba(255, 0, 0, 1)");
	grd1.addColorStop(0.17, "rgba(255, 255, 0, 1)");
	grd1.addColorStop(0.34, "rgba(0, 255, 0, 1)");
	grd1.addColorStop(0.51, "rgba(0, 255, 255, 1)");
	grd1.addColorStop(0.68, "rgba(0, 0, 255, 1)");
	grd1.addColorStop(0.85, "rgba(255, 0, 255, 1)");
	grd1.addColorStop(1, "rgba(255, 0, 0, 1)");
	ctx_hueBar.fillStyle = grd1;
	ctx_hueBar.fill();

	function clickOnHueBar(e) {
	hueBarState.x = e.offsetX;
	hueBarState.y = e.offsetY;
	let imageData = ctx_hueBar.getImageData(hueBarState.x, hueBarState.y, 1, 1)
		.data;
	colorPickerState.rgbaColor =
		"rgba(" + imageData[0] + "," + imageData[1] + "," + imageData[2] + ",1)";
	fillColorBlockGradient();
	changeColorVariable();
	}

	function fillColorBlockGradient() {
	ctx_colorBlock.fillStyle = colorPickerState.rgbaColor;
	ctx_colorBlock.fillRect(0, 0, colorBlockWidth, colorBlockHeight);

	let grdWhite = ctx_hueBar.createLinearGradient(0, 0, colorBlockWidth, 0);
	grdWhite.addColorStop(0, "rgba(255,255,255,1)");
	grdWhite.addColorStop(1, "rgba(255,255,255,0)");
	ctx_colorBlock.fillStyle = grdWhite;
	ctx_colorBlock.fillRect(0, 0, colorBlockWidth, colorBlockHeight);

	let grdBlack = ctx_hueBar.createLinearGradient(0, 0, 0, colorBlockHeight);
	grdBlack.addColorStop(0, "rgba(0,0,0,0)");
	grdBlack.addColorStop(1, "rgba(0,0,0,1)");
	ctx_colorBlock.fillStyle = grdBlack;
	ctx_colorBlock.fillRect(0, 0, colorBlockWidth, colorBlockHeight);
	}

	function mousedownColorBlock(e) {
	e.preventDefault();
	colorPickerState.drag = true;
	changeColorVariable(e);
	}

	function mousemoveColorBlock(e) {
	if (colorPickerState.drag) {
		changeColorVariable(e);
	}
	}

	function mouseupColorBlock(e) {
	colorPickerState.drag = false;
	}

	function mouseoutColorBlock(e) {
	//! testing
	colorPickerState.drag = false;
	}

	function mousedownHueBar(e) {
	e.preventDefault();
	colorPickerState.drag = true;
	clickOnHueBar(e);
	}

	function mousemoveHueBar(e) {
	if (colorPickerState.drag) {
		clickOnHueBar(e);
	}
	}

	function mouseupHueBar(e) {
	colorPickerState.drag = false;
	}

	function mouseoutHueBar(e) {
	colorPickerState.drag = false;
	}

	function changeColorVariable(e) {
	if (e) {
		colorBlockState.x = e.offsetX;
		colorBlockState.y = e.offsetY;
	}
	let imageData = ctx_colorBlock.getImageData(colorBlockState.x,colorBlockState.y,1,1).data;
		colorPickerState.rgbaColor ="rgba(" + imageData[0] + "," + imageData[1] + "," + imageData[2] + ",1)";
		if(ColorType){
			mta.triggerEvent("Tuning:Show:Color",ColorType,imageData[0],imageData[1],imageData[2])
		}
	}

	hueBar.addEventListener("mouseout", mouseoutHueBar, false); //! testing
	hueBar.addEventListener("mousedown", mousedownHueBar, false);
	hueBar.addEventListener("mouseup", mouseupHueBar, false);
	hueBar.addEventListener("mousemove", mousemoveHueBar, false);

	colorBlock.addEventListener("mouseout", mouseoutColorBlock, false); //! testing
	colorBlock.addEventListener("mousedown", mousedownColorBlock, false);
	colorBlock.addEventListener("mouseup", mouseupColorBlock, true);
	colorBlock.addEventListener("mousemove", mousemoveColorBlock, false);

});


function setLanguageTuning(servername,title,searchbar){
	$(".Title-Title").html("<span>"+servername+"</span> - "+title+"");

	$("#search").attr("placeholder",searchbar);
}


function loadCategoriesInTuningList(id,icon,name,price){
	if(price && price>0){
		if(icon.includes("fa")){
			$('.NavbarItem').append(`<div class='Navbar-Items' onclick="selectTuningCategory('${id}','${name}','${price}')"> <i class='${icon} Navbar-Item-Icon'></i> <div class='Navbar-Item-Text'> ${name} </div> </div>`);
		}else if(icon.includes("svg")){
			$('.NavbarItem').append(`<div class='Navbar-Items' onclick="selectTuningCategory('${id}','${name}','${price}')"> <img class='Navbar-Item-Img' src='../../UI/Images/${icon}'> <div class='Navbar-Item-Text'> ${name} </div> </div>`);
		}
	}else{
		if(icon.includes("fa")){
			$('.NavbarItem').append(`<div class='Navbar-Items' onclick="selectTuningCategory('${id}','${name}','0')"> <i class='${icon} Navbar-Item-Icon'></i> <div class='Navbar-Item-Text'> ${name} </div> </div>`);
		}else if(icon.includes("svg")){
			$('.NavbarItem').append(`<div class='Navbar-Items' onclick="selectTuningCategory('${id}','${name}','0')"> <img class='Navbar-Item-Img' src='../../UI/Images/${icon}'> <div class='Navbar-Item-Text'> ${name} </div> </div>`);
		}
	}

	$(".Navbar-Items").click(function(){
		$(this).addClass("Navbar-Items-Active");
		$(".Navbar-Items").not(this).removeClass("Navbar-Items-Active");
	});
}
function selectTuningCategory(id,title,price){
	if(!antiDoubleClick){
		TuningCooldownSwitch(300);

		ColorType=null;
		SelectedTuning=null;

		$(".Colorpicker").hide();
		$(".TuningList").hide();
		$(".TuningListItem").empty();

		if(id=="Bodycolor"){
			SelectedTuning=id;

			$(".ThirdUI").css("display","block");
			$("#search").hide();
			$(".Colorpicker").show();

			$("#Buy").show();
			$("#Buy").html("<i class='fas fa-cart-shopping'></i> "+price+"");
			ColorType=id;
		}else if(id=="Lightcolor"){
			SelectedTuning=id;

			$(".ThirdUI").css("display","block");
			$("#search").hide();
			$(".Colorpicker").show();

			$("#Buy").show();
			$("#Buy").html("<i class='fas fa-cart-shopping'></i> "+price+"");
			ColorType=id;
		}else{
			$(".ThirdUI").css("display","block");
			$("#search").show();
			$(".TuningList").show();

			$("#Buy").show();
			$("#Buy").html("<i class='fas fa-cart-shopping'></i> 0");

			mta.triggerEvent("Tuning:Load:Parts",id);
		}

		$(".ThirdUI-Title").html(`${title}`);
		
	}
}

function loadTuningParts(id,name,price){
	$('.TuningListItem').append(`<div class='TuningList-Items' onclick="selectTuningPart('${id}','${price}')"> <div class='TuningList-Item-Text MaskWhite'> ${name} </div> <div class='TuningList-Item-Text2 MaskAqua'>${price}</div> </div>`);

	$(".TuningList-Items").click(function(){
		$(this).addClass("TuningList-Items-Active");
		$(".TuningList-Items").not(this).removeClass("TuningList-Items-Active");
	});
}
function selectTuningPart(id,price){
	if(!antiDoubleClick){
		TuningCooldownSwitch(300);
		SelectedTuning=id;

		mta.triggerEvent("Tuning:Tuningpart:C","Show",id);

		$("#Buy").html("<i class='fas fa-cart-shopping'></i> "+price+"");
	}
}





function TuningCooldownSwitch(time){
	antiDoubleClick=true;

	setTimeout(function(){
		antiDoubleClick=false;
	},time);
}








function searchTuning(){
	input=document.getElementById("search");
	filter=input.value.toUpperCase();
	searchVehicles=document.getElementById("SortTuning");
	Info=searchVehicles.getElementsByClassName("TuningList-Item-Text");
	
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