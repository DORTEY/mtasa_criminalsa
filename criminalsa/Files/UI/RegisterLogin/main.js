var antiDoubleClick=false;

var timerName=null;
var timerPW=null;
var timerPromote=null;
var timerSecret=null;

var nameTaken=false;
var promoterExists=false;
var secretFilled=false;

var secretQuestion=null;
var Questions=[];
var forgotQuestion=null;

var Translation;

var selectedLanguage=0;

$(document).ready(function(){
	$(".MainUI").empty();
	$(".MainUI").append(`
		<img class="Banner" src="../../Images/Logo.png">
		<div class="SecondUI">
			<div class="Title-Bar">
				<div class="Title-Title">N/A</div>
			</div>

			<div class="Sites">
				<button tabindex="-1" class="SiteButton" id="Login"><div class="SiteTooltip" id="LoginTooltip">N/A</div><i class="far fa-user"></i></button>
				<button tabindex="-1" class="SiteButton" id="Register"><div class="SiteTooltip" id="RegisterTooltip">N/A</div><i class="far fa-user-plus"></i></button>
				<button tabindex="-1" class="SiteButton" id="Password"><div class="SiteTooltip" id="PasswordTooltip">N/A</div><i class="far fa-question"></i></button>
			</div>
			<div class="ThirdUI">

			</div>
		</div>
	`);

	$(".ThirdUI").append(`
		<div id="LoginUI">
			<div class="Username">
				<i class="InputIcon fal fa-user MaskAqua" id="LoginIcon-Username"></i>
				<input type="text" id="LogUsername" maxlength="15" spellcheck="false" placeholder="N/A">
			</div>
			<div class="Password">
				<i class="InputIcon fal fa-lock-alt MaskAqua" id="LoginIcon-Password" onclick="showHidePW('Login')"></i>
				<input type="password" id="LogPassword" maxlength="50" spellcheck="false" placeholder="N/A">
			</div>

			<div class="Checkboxes" id="Languages">
				<div class="Checkbox-Text MaskAqua">Language</div>
				<label class="checkbox-item"><span class="checkbox-text MaskWhite">English</span>
					<input class="Language" id="Login-0" type="radio" name="languageLogin" checked>
					<span class="checkmark"></span>
				</label>
				<label class="checkbox-item"><span class="checkbox-text wMaskWhite">German</span>
					<input class="Language" id="Login-1" type="radio" name="languageLogin">
					<span class="checkmark"></span>
				</label>
				<label class="checkbox-item"><span class="checkbox-text wMaskWhite">Polski</span>
					<input class="Language" id="Login-2" type="radio" name="languageLogin">
					<span class="checkmark"></span>
				</label>
				<label class="checkbox-item"><span class="checkbox-text wMaskWhite">Brazil</span>
					<input class="Language" id="Login-3" type="radio" name="languageLogin">
					<span class="checkmark"></span>
				</label>
			</div>

			<div class="Checkboxes" id="RememberMe">
				<div class="Checkbox-Text MaskAqua">Remember login?</div>
				<label class="checkbox-item"><span class="checkbox-text MaskWhite">Yes</span>
					<input class="SaveLogin" id="Save" type="checkbox" name="rememberMe" checked>
					<span class="checkmark"></span>
				</label>
			</div>

			<div class="LoginButton">
				<button class="Button"> N/A </button>
			</div>
		</div>

		<div id="RegisterUI">
			<div class="Username">
				<i class="InputIcon fal fa-user MaskAqua" id="RegisterIcon-Username"></i>
				<input type="text" id="RegUsername" maxlength="15" spellcheck="false" placeholder="N/A" oninput="checkNameAvailable(),checkPromoterExisting()">
			</div>
			<div class="Password">
				<i class="InputIcon fal fa-lock-alt MaskAqua" id="RegisterIcon-Password" onclick="showHidePW('Register')"></i>
				<input type="password" id="RegPassword" maxlength="50" spellcheck="false" placeholder="N/A" oninput="checkPasswordsMatching(),checkPromoterExisting()">
			</div>
			<div class="Password2">
				<i class="InputIcon fal fa-lock-alt MaskAqua" id="RegisterIcon-Password2" onclick="showHidePW('Register')"></i>
				<input type="password" id="RegPassword2" maxlength="50" spellcheck="false" placeholder="N/A" oninput="checkPasswordsMatching(),checkPromoterExisting()">
			</div>
			<div class="Promote">
				<i class="InputIcon fal fa-user MaskAqua" id="RegisterIcon-Promote"></i>
				<input type="text" id="Promoter" maxlength="15" spellcheck="false" placeholder="N/A" oninput="checkPromoterExisting()">
			</div>

			<div class="dropdown-container" id="RegSecretDropdown">
				<div class="dropdown-select-button" onclick="toggleRegisterLoginDropDown()"><span id="RegSecretQuestion">N/A</span>
					<span id="dropdown-arrow"><i class="fa-solid fa-caret-down"></i></span>
				</div>
				<div class="dropdown-item-list">
					<button class="dropdown-item" onclick="selectSecret(1)" id="RegSecret-1">N/A</button>
					<button class="dropdown-item" onclick="selectSecret(2)" id="RegSecret-2">N/A</button>
					<button class="dropdown-item" onclick="selectSecret(3)" id="RegSecret-3">N/A</button>
					<button class="dropdown-item" onclick="selectSecret(4)" id="RegSecret-4">N/A</button>
					<button class="dropdown-item" onclick="selectSecret(5)" id="RegSecret-5">N/A</button>
					<button class="dropdown-item" onclick="selectSecret(6)" id="RegSecret-6">N/A</button>
				</div>
			</div>
			<div class="SecretAnswer">
				<i class="InputIcon fal fa-question MaskAqua" id="RegisterIcon-SecretAnswer" onclick="showHidePW('SecretAnswer')"></i>
				<input type="text" id="SecretAnswerr" maxlength="30" spellcheck="false" placeholder="N/A" oninput="checkSecretAnswerIsFilled()">
			</div>

			<div class="Languages-Container">
				<div class="Checkboxes" id="Languages">
					<div class="Checkbox-Text MaskAqua">Language</div>
					<label class="checkbox-item"><span class="checkbox-text MaskWhite">English</span>
						<input class="Language" id="Register-0" type="radio" name="languageRegister" checked>
						<span class="checkmark"></span>
					</label>
					<label class="checkbox-item"><span class="checkbox-text MaskWhite">German</span>
						<input class="Language" id="Register-1" type="radio" name="languageRegister">
						<span class="checkmark"></span>
					</label>
					<label class="checkbox-item"><span class="checkbox-text MaskWhite">Polski</span>
						<input class="Language" id="Register-2" type="radio" name="languageRegister">
						<span class="checkmark"></span>
					</label>
					<label class="checkbox-item"><span class="checkbox-text MaskWhite">Brazil</span>
						<input class="Language" id="Register-3" type="radio" name="languageRegister">
						<span class="checkmark"></span>
					</label>
				</div>
			</div>

			<div class="RegisterButton">
				<button class="Button" onclick="checkPasswordsMatching(),checkNameAvailable(),checkPromoterExisting(),checkSecretAnswerIsFilled()"> N/A </button>
			</div>
		</div>

		<div id="PasswordUI">
			<div class="Serial">
				<i class="InputIcon fal fa-user MaskAqua" id="ForgotIcon-Serial"></i>
				<input type="text" id="ForgotSerial" maxlength="35" spellcheck="false" placeholder="N/A" oninput="checkForgotSerial()">
			</div>

			<div class="dropdown-container" id="ForgotDropdown">
               	<div class="dropdown-select-button"><span id="ForgotSecretQuestion"></span>
               	</div>
            </div>
			<div class="SecretAnswer">
				<i class="InputIcon fal fa-question MaskAqua" id="ForgotIcon-SecretAnswer" onclick="showHidePW('ForgotAnswer')"></i>
				<input type="text" id="ForgotSecretAnswerr" maxlength="15" spellcheck="false" placeholder="N/A">
			</div>
			<div class="Password">
				<i class="InputIcon fal fa-lock-alt MaskAqua" id="ForgotIcon-Password" onclick="showHidePW('Forgot')"></i>
				<input type="password" id="ForgotPassword" maxlength="15" spellcheck="false" placeholder="N/A">
			</div>

			<div class="ForgotButton">
				<button class="Button"> N/A </button>
			</div>
		</div>
	`);

	//Login
	$("#LoginUI .Username input").css("top","3vh");
	$("#LoginUI .Password input").css("top","9vh");
	$("#LoginIcon-Username").css("top","3vh");
	$("#LoginIcon-Password").css("top","9vh");

	//Register
	$("#LoginUI").hide();
	$("#RegisterUI .Username input").css("top","3vh");
	$("#RegisterUI .Password input").css("top","9vh");
	$("#RegisterUI .Password2 input").css("top","15vh");
	$("#RegisterUI .Promote input").css("top","21vh");
	$("#RegisterUI .SecretAnswer input").css("top","29vh");
	$("#RegisterIcon-Username").css("top","3vh");
	$("#RegisterIcon-Password").css("top","9vh");
	$("#RegisterIcon-Password2").css("top","15vh");
	$("#RegisterIcon-Promote").css("top","21vh");
	$("#RegisterIcon-SecretAnswer").css("top","29vh");
	$("#RegSecretDropdown").css("top","22vh");

	//Forgot password
	$("#PasswordUI .Serial input").css("top","3vh");
	$("#PasswordUI .SecretAnswer input").css("top","14vh");
	$("#PasswordUI .Password input").css("top","20vh");
	$("#ForgotIcon-Serial").css("top","3vh");
	$("#ForgotIcon-SecretAnswer").css("top","14vh");
	$("#ForgotIcon-Password").css("top","20vh");
	$("#ForgotDropdown").css("top","6vh");


    //Sites
	$(".SiteButton").on("click",function(){
		if(!antiDoubleClick){
			$("#"+this.id).addClass("SiteActive");
			$(".SiteButton").not("#"+this.id).removeClass("SiteActive");

			if(this.id=="Login"){
				$("#RegisterUI").fadeOut("fast");
				$("#LoginUI").fadeIn("fast");
				$("#PasswordUI").fadeOut("fast");
				RegisterLoginCooldownSwitch(300);
			}else if(this.id=="Register"){
				$("#RegisterUI").fadeIn("fast");
				$("#LoginUI").fadeOut("fast");
				$("#PasswordUI").fadeOut("fast");
				RegisterLoginCooldownSwitch(300);
			}else if(this.id=="Password"){
				$("#RegisterUI").fadeOut("fast");
				$("#LoginUI").fadeOut("fast");
				$("#PasswordUI").fadeIn("fast");
				RegisterLoginCooldownSwitch(300);
			}

			document.getElementById(this.id+"-"+selectedLanguage).checked=true;
		}
	});

	$(".Language").click(function(){
		selectedLanguage=this.id;

		if(this.id=="Register-0"){
			selectedLanguage=0;
		}else if(this.id=="Register-1"){
			selectedLanguage=1;
		}else if(this.id=="Register-2"){
			selectedLanguage=2;
		}else if(this.id=="Register-3"){
			selectedLanguage=3;
		}else if(this.id=="Login-0"){
			selectedLanguage=0;
		}else if(this.id=="Login-1"){
			selectedLanguage=1;
		}else if(this.id=="Login-2"){
			selectedLanguage=2;
		}else if(this.id=="Login-3"){
			selectedLanguage=3;
		}

		mta.triggerEvent("RegisterLogin:Language",selectedLanguage);
	});
	$(".SaveLogin").click(function(){
		var Save=document.getElementById("Save").checked;
		mta.triggerEvent("RegisterLogin:RememberMe",Save,$("#LogUsername").val().toString(),$("#LogPassword").val().toString(),selectedLanguage);
	});


	//Register
	$(".RegisterButton .Button").css("top","45vh");

	$(".RegisterButton .Button").click(function(){
		if($("#RegPassword").val()===$("#RegPassword2").val()){//matching
			if(nameTaken){//name taken
				nameAlreadyTaken(true);
			}else{//name not taken
				if(promoterExists || promoterExists===""){
					if(secretQuestion && secretQuestion!==null && $("#SecretAnswerr").val()!==""){
						mta.triggerEvent("RegisterLogin:Register:C",$("#RegUsername").val(),$("#RegPassword").val(),$("#Promoter").val(),secretQuestion,$("#SecretAnswerr").val());
					}
			 	}else{
					promoterExist(false);
				}
			}
		}else{//not matching
			checkPasswordsMatching();
		}
	});

	//Login
	$(".LoginButton .Button").css("top","45vh");

	$(".LoginButton .Button").click(function(){
		var Save=document.getElementById("Save").checked;
		if(Save){
			mta.triggerEvent("RegisterLogin:RememberMe",Save,$("#LogUsername").val(),$("#LogPassword").val(),selectedLanguage);
		}
		mta.triggerEvent("RegisterLogin:Login:C",$("#LogUsername").val(),$("#LogPassword").val());
	});

	//Forgot
	$(".ForgotButton .Button").css("top","45vh");

	$(".ForgotButton .Button").click(function(){
		if(forgotQuestion && forgotQuestion!==null && $("#ForgotSecretAnswerr").val()!==""){
			mta.triggerEvent("RegisterLogin:ResetPassword:C",$("#ForgotSerial").val(),$("#ForgotPassword").val(),$("#ForgotSecretAnswerr").val());
		}
	});
});

function openCorrectPage(page,language){
	if(page=="true"){//existing
		$("#Login").addClass("SiteActive");
		$("#Register").removeClass("SiteActive");

		$("#RegisterUI").hide();
		$("#LoginUI").show();
		$("#PasswordUI").hide();

		//document.getElementById("Login-"+selectedLanguage).checked=true;
	}else if(page=="false"){//not existing
		$("#Login").removeClass("SiteActive");
		$("#Register").addClass("SiteActive");

		$("#RegisterUI").show();
		$("#LoginUI").hide();
		$("#PasswordUI").hide();

		//document.getElementById("Register-"+selectedLanguage).checked=true;
	}else if(page=="language" && language && language!==""){
		selectedLanguage=language;

		document.getElementById("Login-"+language).checked=true;
		document.getElementById("Register-"+language).checked=true;
	}
}

function RemberMeCorrect(bool){
	if(bool=="true"){
		document.getElementById("Save").checked=true;
	}else{
		document.getElementById("Save").checked=false;
	}
}
function showHidePW(type){
	if(type=="Register"){
		if($("#RegPassword")[0].type==="password"){
			$("#RegPassword")[0].type="text";
			$("#RegPassword2")[0].type="text";
		}else{
			$("#RegPassword")[0].type="password";
			$("#RegPassword2")[0].type="password";
		}
	}else if(type=="Login"){
		if($("#LogPassword")[0].type==="password"){
			$("#LogPassword")[0].type="text";
		}else{
			$("#LogPassword")[0].type="password";
		}
	}else if(type=="Forgot"){
		if($("#ForgotPassword")[0].type==="password"){
			$("#ForgotPassword")[0].type="text";
		}else{
			$("#ForgotPassword")[0].type="password";
		}
	}else if(type=="ForgotAnswer"){
		if($("#ForgotSecretAnswerr")[0].type==="password"){
			$("#ForgotSecretAnswerr")[0].type="text";
		}else{
			$("#ForgotSecretAnswerr")[0].type="password";
		}
	}else if(type=="SecretAnswer"){
		if($("#SecretAnswerr")[0].type==="password"){
			$("#SecretAnswerr")[0].type="text";
		}else{
			$("#SecretAnswerr")[0].type="password";
		}
	}
}
function checkNameAvailable(){
	mta.triggerEvent("RegisterLogin:CheckName",$("#RegUsername").val());
}
function checkPromoterExisting(){
	mta.triggerEvent("RegisterLogin:CheckPromoter",$("#Promoter").val());
}
function nameAlreadyTaken(state){
	if(state===true){//taken
		$("#RegisterUI .Username input").css("color","var(--red)");
		$("#RegisterIcon-Username").css("color","var(--red)");
		$("#RegisterIcon-Username").css("animation","shakee 0.7s infinite linear");
		clearTimeout(timerName);
		nameTaken=true;
	}else{//not taken
		$("#RegisterUI .Username input").css("color","var(--green)");
		$("#RegisterIcon-Username").css("color","rgba(255,255,255,1)");
		$("#RegisterIcon-Username").css("animation","none");
		clearTimeout(timerName);
		timerName=setTimeout(()=>{
			$(".Username input").css("color","rgba(255,255,255,1)");
			clearTimeout(timerName);
		},1000);
		nameTaken=false;
	}
}
function checkPasswordsMatching(){
	if($("#RegPassword").val()!==$("#RegPassword2").val() || $("#RegPassword").val()===""){//not matching
		$("#RegisterUI .Password input").css("color","var(--red)");
		$("#RegisterUI .Password2 input").css("color","var(--red)");
		$("#RegisterIcon-Password").css("color","var(--red)");
		$("#RegisterIcon-Password").css("animation","shakee 0.7s infinite linear");
		$("#RegisterIcon-Password2").css("color","var(--red)");
		$("#RegisterIcon-Password2").css("animation","shakee 0.7s infinite linear");
		clearTimeout(timerPW);
	}else{//matching
		$("#RegisterUI .Password input").css("color","var(--green)");
		$("#RegisterUI .Password2 input").css("color","var(--green)");
		$("#RegisterIcon-Password").css("animation","none");
		$("#RegisterIcon-Password").css("color","rgba(255,255,255,1)");
		$("#RegisterIcon-Password2").css("animation","none");
		$("#RegisterIcon-Password2").css("color","rgba(255,255,255,1)");
		clearTimeout(timerPW);
		timerPW=setTimeout(()=>{
			$("#RegisterUI .Password input").css("color","rgba(255,255,255,1)");
			$("#RegisterUI .Password2 input").css("color","rgba(255,255,255,1)");
			clearTimeout(timerPW);
		},1000);
	}
}
function promoterExist(state){
	if(state===true || $("#Promoter").val()===""){//exist
		$("#RegisterUI .Promote input").css("color","var(--green)");
		$("#RegisterIcon-Promote").css("color","rgba(255,255,255,1)");
		$("#RegisterIcon-Promote").css("animation","none");
		clearTimeout(timerPromote);
		timerPromote=setTimeout(()=>{
			$("#RegisterUI .Promote input").css("color","rgba(255,255,255,1)");
			clearTimeout(timerPromote);
		},1000);
		promoterExists=true;
	}else{//not existing
		$("#RegisterUI .Promote input").css("color","var(--red)");
		$("#RegisterIcon-Promote").css("color","var(--red)");
		$("#RegisterIcon-Promote").css("animation","shakee 0.7s infinite linear");
		clearTimeout(timerPromote);
		promoterExists=false;
	}
}
function checkSecretAnswerIsFilled(){
	if($("#SecretAnswerr").val()!==""){//filled
		$("#RegisterUI .SecretAnswer input").css("color","var(--green)");
		$("#RegisterIcon-SecretAnswer").css("color","rgba(255,255,255,1)");
		$("#RegisterIcon-SecretAnswer").css("animation","none");
		clearTimeout(timerSecret);
		timerSecret=setTimeout(()=>{
			$("#RegisterUI .SecretAnswer input").css("color","rgba(255,255,255,1)");
			clearTimeout(timerSecret);
		},1000);
		secretFilled=true;
	}else{//empty
		$("#RegisterUI .SecretAnswer input").css("color","var(--red)");
		$("#RegisterIcon-SecretAnswer").css("color","var(--red)");
		$("#RegisterIcon-SecretAnswer").css("animation","shakee 0.7s infinite linear");
		clearTimeout(timerSecret);
		secretFilled=false;
	}
}

function forgotSecretAnswer(id){
	if(id){
		forgotQuestion=Questions[Number(id)];
		$("#ForgotSecretQuestion").text(Questions[Number(id)]);
	}else{
		forgotQuestion=null;
	}
}
function checkForgotSerial(){
	mta.triggerEvent("RegisterLogin:CheckForgotSerial",$("#ForgotSerial").val());
}


function setLanguageRegisterLogin(servername,luaTranslation){
	var Datas=JSON.parse(luaTranslation);

	Datas.reduce((acc,value,index)=>{
		Translation=value;
		return Translation;
	},{});
	Questions[1]=Translation["UI:RegisterLogin:SecretQuestion1"];
	Questions[2]=Translation["UI:RegisterLogin:SecretQuestion2"];
	Questions[3]=Translation["UI:RegisterLogin:SecretQuestion3"];
	Questions[4]=Translation["UI:RegisterLogin:SecretQuestion4"];
	Questions[5]=Translation["UI:RegisterLogin:SecretQuestion5"];
	Questions[6]=Translation["UI:RegisterLogin:SecretQuestion6"];

	$(".Title-Title").html("<span>"+servername+"</span> - "+Translation["UI:RegisterLogin:Title"]+"");
	
	$("#LogUsername").attr("placeholder",Translation["UI:RegisterLogin:Username"]);
	$("#LogPassword").attr("placeholder",Translation["UI:RegisterLogin:Password"]);

	$("#RegUsername").attr("placeholder",Translation["UI:RegisterLogin:Username"]);
	$("#RegPassword").attr("placeholder",Translation["UI:RegisterLogin:Password"]);
	$("#RegPassword2").attr("placeholder",Translation["UI:RegisterLogin:Password2"]);
	$("#Promoter").attr("placeholder",Translation["UI:RegisterLogin:Promoter"]);

	$("#RegSecretQuestion").text(Translation["UI:RegisterLogin:SelectSecret"]);
	$("#RegSecret-1").text(Questions[1]);
	$("#RegSecret-2").text(Questions[2]);
	$("#RegSecret-3").text(Questions[3]);
	$("#RegSecret-4").text(Questions[4]);
	$("#RegSecret-5").text(Questions[5]);
	$("#RegSecret-6").text(Questions[6]);
	$("#SecretAnswerr").attr("placeholder",Translation["UI:RegisterLogin:SecretAnswer"]);

	$("#ForgotSecretAnswerr").attr("placeholder",Translation["UI:RegisterLogin:SecretAnswer"]);
	$("#ForgotSerial").attr("placeholder",Translation["UI:RegisterLogin:Username"]);
	$("#ForgotPassword").attr("placeholder",Translation["UI:RegisterLogin:PasswordNew"]);

	$("#LoginTooltip").html(Translation["UI:RegisterLogin:ButtonLogin"]);
	$("#RegisterTooltip").html(Translation["UI:RegisterLogin:ButtonRegister"]);
	$("#PasswordTooltip").html(Translation["UI:RegisterLogin:ButtonForgotPassword"]);

	$(".LoginButton .Button").html(`<i class="far fa-sign-in"></i> ${Translation["UI:RegisterLogin:ButtonLogin"]}`);
	$(".RegisterButton .Button").html(`<i class="far fa-user-plus"></i> ${Translation["UI:RegisterLogin:ButtonRegister"]}`);
	$(".ForgotButton .Button").html(`<i class="far fa-rotate-right"></i> ${Translation["UI:RegisterLogin:ButtonForgotPassword"]}`);
}




function toggleRegisterLoginDropDown(){
	const dropDownActive=$(".dropdown-item-list").css("display")==="block";
	if(dropDownActive){
		$(".dropdown-item-list").hide();
	  	$("#dropdown-arrow").html(`<i class="fa-solid fa-caret-down"></i>`);

		$(".Languages-Container").show();
		$(".RegisterButton").show();
		$(".SecretAnswer").show();
	}else{
	  	$(".dropdown-item-list").show();
	  	$("#dropdown-arrow").html(`<i class="fa-solid fa-caret-up"></i>`);

		$(".Languages-Container").hide();
		$(".RegisterButton").hide();
		$(".SecretAnswer").hide();
	}
}

function selectSecret(id){
	$("#RegSecretQuestion").text(Questions[id]);
	secretQuestion=id;

	setTimeout(()=>{
		toggleRegisterLoginDropDown();
	},0);
}



function RegisterLoginCooldownSwitch(time){
	antiDoubleClick=true;

	setTimeout(function(){
		antiDoubleClick=false;
	},time);
}