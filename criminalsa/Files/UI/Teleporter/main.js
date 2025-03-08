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
		</div>
	`);

	$(".ButtonClose").on("click",function(){
		mta.triggerEvent("Teleporter:UI");
	});
});

function clearTeleporter(){
	$(".NavbarItem").empty();
}

function insertTeleporterStuff(type,type2,name,icon){
	$(".NavbarItem").append(`<div class='Navbar-Items' id='${type2}' onclick="teleportClick('${type}','${type2}')"> <div class='Navbar-Item-Text'><i class='${icon}'></i> ${name}</div>`);
}

function teleportClick(type,name){
	mta.triggerEvent("Teleport:Teleport:C",type,name);
}