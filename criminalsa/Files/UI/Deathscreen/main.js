var StartTimer=null;

$(document).ready(function(){
	$(".MainUI").empty();
	$(".MainUI").append(`
		<img class="Banner" src="../../Images/Logo.png">

		<div class="SecondUI">
			<i class="fas fa-heart-pulse Heart MaskRed"></i>

			<i class="fas fa-skull KilledBy MaskAqua"></i>
			<div class="KilledBy-Text MaskWhite"></div>


			<div class="TimerBar">
				<div class="Time">00:00</div>

				<div class="TimerBar-Progress"></div>
			</div>
		</div>
	`);
});

function deathscreenStart(type,time){
	if(type=="1"){
		$(".KilledBy").hide();
		$(".KilledBy-Text").hide();
		$(".TimerBar").hide();

		$(".TimerBar-Progress").width("100%");
		
		StartTimer=time;
	}else if(type=="2"){
		$(".Time").text(new Date(StartTimer*1000).toISOString().substr(14,5));

		$(".Time").fadeIn("slow");
		$(".TimerBar").fadeIn("slow");
	}
}

function updateDeathscreen(time,killer){
	if(time){
		$(".Time").text(new Date(time*1000).toISOString().substr(14,5));

		var progressWidth=(time/StartTimer)*100;
		$(".TimerBar-Progress").width(progressWidth+"%");

		var random=getRandomInt(1,13);
		if(random>10){
			$(".Heart").css("animation","pulse 1s linear infinite");
		}else{
			$(".Heart").css("animation","pulse 2s linear infinite");
		}

		if(killer && killer!==""){
			$(".KilledBy").fadeIn("slow");
			$(".KilledBy-Text").fadeIn("slow");

			$(".KilledBy-Text").html(`${killer}`);
		}
	}
}

function resetDeathscreen(){
	$(".KilledBy").hide();
	$(".KilledBy-Text").hide();
	$(".TimerBar").hide();
}