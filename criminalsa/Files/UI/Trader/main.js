var antiDoubleClick=false;

var SelectedItem;

$(document).ready(function(){
	$(".MainUI").empty();
	$(".MainUI").append(`
		<div class="SecondUI">
			<div class="Title-Bar">
				<div class="Title-Title">N/A</div>
			</div>

			<input type="text" id="search" maxlength="5" oninput="searchItem()" placeholder="N/A">

			<div class="LevelBar-Text"></div>
			<div class="LevelBar">
				<div class="LevelBar-Progress"></div>
			</div>

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
			<div class="Information-Bar" id="Amount-Bar">
				<input type="number" id="amount" spellcheck="false" placeholder="N/A" oninput="maxAmountLimit()">
			</div>
			<div class="Information-Bar" id="OwnAmount-Bar">
				<div class="Information-Title"><span class="MaskWhite" id="OwnItemAmount"> N/A </span></div>
			</div>

			<img class="ItemIcon" id="Icon" src="../../Images/Transparent.png">

			<button class="Button" onclick="traderItem('buy')" id="Buy"> N/A </button>
			<button class="Button" onclick="traderItem('sell')" id="Sell"> N/A </button>
		</div>
	`);
	$(".ThirdUI").css("display","none");
	/* Buttons */
	$("#Buy").css("top","28vh");
	$("#Buy").css("left","50%");
	$("#Buy").css("transform","translateX(-50%)");
	$("#Buy").css("width","28vh");

	$("#Sell").css("top","34vh");
	$("#Sell").css("left","50%");
	$("#Sell").css("transform","translateX(-50%)");
	$("#Sell").css("width","28vh");

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
	$("#Amount-Bar").css("top","8vh");
	$("#Amount-Bar").css("left","18vh");
	$("#OwnAmount-Bar").css("top","13vh");
	$("#OwnAmount-Bar").css("left","25vh");
	$("#OwnAmount-Bar").css("width","8vh");


	$("#ButtonClose").click(function(){
		mta.triggerEvent("Trader:UI");
	});
});


function setLanguageTrader(servername,title,searchbar,amountbar,           button_leaveUI,button_buy,button_sell){
	$(".Title-Title").html("<span>"+servername+"</span> - "+title+"");

	$("#Buy").html(`<i class="fas fa-money-bill"></i> ${button_buy}`);
	$("#Sell").html(`<i class="fas fa-money-bill"></i> ${button_sell}`);
	$("#ButtonClose").html(`<i class="fas fa-right-from-bracket"></i> ${button_leaveUI}`);

	$("#search").attr("placeholder",searchbar);
	$("#amount").attr("placeholder",amountbar);
}


function loadItemsInTraderList(item,name,timestamp,onlyincrates,           luaTbl){
	var Datas=JSON.parse(luaTbl)[0];
	SelectedItem=null;

	if(timestamp && timestamp>0){
		$('.NavbarItem').append(`<div class='Navbar-Items' onclick="selectTraderItem('${item}')"> <div class='Navbar-Item-Text'> ${name} </div> <div class='Navbar-Item-Text-Limited MaskRed'> <i class="far fa-clock"></i> </div> </div>`);
	}else{
		if(onlyincrates=="true"){
			$('.NavbarItem').append(`<div class='Navbar-Items' onclick="selectTraderItem('${item}')"> <div class='Navbar-Item-Text'> ${name} </div> <div class='Navbar-Item-Text-OnlyInCrates MaskRed'> <i class="fas fa-treasure-chest"></i> </div> </div>`);
		}else{
			$('.NavbarItem').append(`<div class='Navbar-Items' onclick="selectTraderItem('${item}')"> <div class='Navbar-Item-Text'> ${name} </div> </div>`);
		}
	}

	searchItem();

	$(".Navbar-Items").click(function(){
		$(this).addClass("Navbar-Items-Active");
		$(".Navbar-Items").not(this).removeClass("Navbar-Items-Active");
	});

	$(".LevelBar").css("display","block");
	$(".LevelBar-Text").css("display","block");

	$(".LevelBar-Text").text(Datas[0]);
	if(Number(Datas[2])!==9999999999){
		$(".SecondUI input").css("top","13vh");
		$(".Navbar").css("top","18vh");
		$(".Navbar").css("height","70vh");
		
		var Progress=Number(Datas[1])/Number(Datas[2])*100;
		if(Progress && Progress==0){
			$(".LevelBar-Progress").css("display","none");
		}else if(Progress && Progress>100){
			$(".LevelBar-Progress").css("display","block");
			$(".LevelBar-Progress").css("width","100%");
		}else{
			$(".LevelBar-Progress").css("display","block");
			$(".LevelBar-Progress").css("width",Progress+"%");
		}
	}else{
		$(".SecondUI input").css("top","8vh");
		$(".Navbar").css("top","13vh");
		$(".Navbar").css("height","75vh");

		$(".LevelBar").css("display","none");
		$(".LevelBar-Text").css("display","none");
	}
}

function showTraderItemDetails(item,name,price,notbuyable,notsellable,timestamp,onlyincrates,ownitemamount){
	SelectedItem=item;

	$(".ThirdUI").css("display","block");

	$(".ThirdUI-Title").html(`${name}`);
	$("#Price").html(`${price}`);

	$("#amount").val(1);
	$("#OwnItemAmount").text(ownitemamount)

	if(timestamp && timestamp>0){
		$("#Limited-Bar").css("display","block");
		$("#Limited-Text").html(`${formatSecondsToTime(timestamp)}`);
	}else{
		$("#Limited-Bar").css("display","none");
	}

	if(onlyincrates && onlyincrates=="true"){
		$(".ThirdUI").css("display","none");
	}else{
		if(notbuyable && notbuyable=="false"){
			$("#Buy").hide();
		}else{
			$("#Buy").show();
		}
		if(notsellable && notsellable=="false"){
			$("#Sell").hide();
	
			$("#Buy").css("top","34vh");
			$("#Buy").css("left","50%");
			$("#Buy").css("transform","translateX(-50%)");
			$("#Buy").css("width","28vh");
		}else{
			$("#Buy").css("top","28vh");
			$("#Buy").css("left","50%");
			$("#Buy").css("transform","translateX(-50%)");
			$("#Buy").css("width","28vh");
	
			$("#Sell").show();
		}
	
	
	
		checkIfImageExists(`../../Images/Items/${item}.png`,(exists)=>{
			if(exists){
				document.getElementById("Icon").src="../../Images/Items/"+item+".png";
			}else{
				document.getElementById("Icon").src="../../Images/Transparent.png";
			}
		});
	}
}

function selectTraderItem(item){
	if(!antiDoubleClick){
		TraderCooldownSwitch(500);
		mta.triggerEvent("Trader:Load",item);
	}
}

function traderItem(type){
	if(!antiDoubleClick){
		TraderCooldownSwitch(500);
		if(SelectedItem){
			mta.triggerEvent("Trader:BuySell:C",type,SelectedItem,$("#amount").val());
		}
	}
}

function maxAmountLimit(){
	var input=$("#amount");
	var LastInput=1;

	if(input.val().length>4){
		input.val(LastInput)
	}
}





function TraderCooldownSwitch(time){
	antiDoubleClick=true;

	setTimeout(function(){
		antiDoubleClick=false;
	},time);
}








function searchItem(){
	input=document.getElementById("search");
	filter=input.value.toUpperCase();
	searchItems=document.getElementById("SortItems");
	Info=searchItems.getElementsByClassName("Navbar-Item-Text");
	
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