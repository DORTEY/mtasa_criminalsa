var antiDoubleClick=false;

var ItemAmount=null;
var cacheCount=null;
var cacheItem=null;

$(document).ready(function(){
	$(".MainUI").empty();
	$(".MainUI").append(`
		<div class="SecondUI">
			<img class='FarmArea' src='../../Images/Job/Tree.png'>

			<div class="ItemSpawnArea"></div>
		</div>
	`);
});

function fillJobCollectorItems(item,amount){
	cacheItem=item;
	ItemAmount=Number(amount);
	cacheCount=ItemAmount;
	
	$(".FarmArea").attr("src","../../Images/Job/Tree.png");
	$(".ItemSpawnArea").empty();

	setTimeout(()=>{
		var Spawn1=document.querySelector(".ItemSpawnArea");
		var width1=Spawn1.offsetWidth;
		var height1=Spawn1.offsetHeight;

		for(let i=0; i<cacheCount; i++){
			randomTop1=getRandomInt(0,height1);
			randomLeft1=getRandomInt(0,width1);

			$(".ItemSpawnArea").append(`
				<img class="Item" id="ItemID-${i}" src="../../Images/Job/${cacheItem}.png" onclick="collectCollectorItem('${cacheItem}','ItemID-${i}')">
			`);
			$(`#ItemID-${i}`).css("top",randomTop1+"px");
			$(`#ItemID-${i}`).css("left",randomLeft1+"px");

			$(`#ItemID-${i}`).attr("top",randomTop1+"px");
			$(`#ItemID-${i}`).attr("left",randomLeft1+"px");
			
			if(getRandomInt(1,10)>=7){
				$(`#ItemID-${i}`).css("transform","rotate(35deg)");
			}
		}
	},250);
}

function collectCollectorItem(item,id){
	if(!antiDoubleClick){
		CollectorCooldownSwitch(500);

		$("#"+id).hide();

		cacheCount=cacheCount-1;

		if(cacheCount==0){
			mta.triggerEvent("Job:"+item+"Collector:UI",null,ItemAmount);
			cacheCount=null;
			cacheItem=null;
		}
	}
}






function CollectorCooldownSwitch(time){
	antiDoubleClick=true;

	setTimeout(function(){
		antiDoubleClick=false;
	},time);
}