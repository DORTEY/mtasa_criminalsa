function formatSecondsToTime(seconds){
	//let y = Math.floor(seconds / 31536000);
	let mo = Math.floor((seconds % 31536000) / 2628000);
	let d = Math.floor(((seconds % 31536000) % 2628000) / 86400);
	let h = Math.floor((seconds % (3600 * 24)) / 3600);
	let m = Math.floor((seconds % 3600) / 60);
	let s = Math.floor(seconds % 60);

	//let yDisplay = y > 0 ? y + (y === 1 ? " year, " : " years, ") : "";
	let moDisplay = mo > 0 ? mo + (mo === 1 ? " mo, " : " mo, ") : "";
	let dDisplay = d > 0 ? d + (d === 1 ? " d, " : " d, ") : "";
	let hDisplay = h > 0 ? h + (h === 1 ? " h, " : " h, ") : "";
	let mDisplay = m > 0 ? m + (m === 1 ? " m " : " m, ") : "";
	let sDisplay = s > 0 ? s + (s === 1 ? " s" : " s ") : " 0 s";
	return moDisplay + dDisplay + hDisplay + mDisplay + sDisplay;
}


function getRandomInt(min,max){
	min=Math.ceil(min);
    max=Math.floor(max);
    return Math.floor(Math.random()*(max-min+1))+min;
}


function checkIfImageExists(url,callback){
	const img=new Image();
	img.src=url;
	
	if(img.complete){
	  	callback(true);
	}else{
		img.onload=()=>{
			callback(true);
		};
	  
		img.onerror=()=>{
			callback(false);
		};
	}
}