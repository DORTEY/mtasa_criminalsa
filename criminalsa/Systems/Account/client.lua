addRemoteEvents{"RegisterLogin:UI","RegisterLogin:Login:C","RegisterLogin:Register:C","RegisterLogin:Language",
"RegisterLogin:CheckName","RegisterLogin:CheckPromoter","RegisterLogin:Callback:C:Name","RegisterLogin:Callback:C:Promoter","RegisterLogin:CheckAccount:C",
"RegisterLogin:RememberMe",

"RegisterLogin:Callback:C:ForgotAccount","RegisterLogin:CheckForgotSerial","RegisterLogin:ResetPassword:C",
};--addEvents


local RememberMe=false;
local RememberMeName="";
local RememberMePassword="";
local RememberMeLaguage=0;

local RandomCam,CamData,CamTimer,CamTimerDuration,CurrentCamID=0,nil,nil,15*1000,nil;


addEventHandler("onClientResourceStart_Custom",resourceRoot,function()
	triggerServerEvent("RegisterLogin:TriggerUI",localPlayer);
end)

local function updateUI()
	setTimer(function()
		if(isElement(BrowserUI))then
			local jsonString=toJSON(Translation[getElementData(localPlayer,"Language")]);jsonString=jsonString:gsub('\\','\\\\');jsonString=jsonString:gsub('"','\\"');
			--[[ executeBrowserJavascript(Browser,"setLanguageRegisterLogin('"..Server.Name.."','"..jsonString.."');"); ]]

			executeBrowserJavascript(Browser,[[
				setLanguageRegisterLogin(']]..Server.Name..[[',']]..jsonString..[[');
			]]);
		end
	end,250,1);
end


addEventHandler("RegisterLogin:UI",root,function(type)
	if(type)then--appear
		BrowserUI=guiCreateBrowser(0,0,GLOBALscreenX,GLOBALscreenY,true,true,false,nil);
		Browser=guiGetBrowser(BrowserUI);
		addEventHandler("onClientBrowserCreated",Browser,function()
			loadBrowserURL(Browser,"http://mta/local/Files/UI/RegisterLogin/main.html");
			focusBrowser(Browser);

			addEventHandler("onClientBrowserDocumentReady",BrowserUI,function(url)
				LOADED_CEF=LOADED_CEF+1;
				
				executeBrowserJavascript(Browser,[[
					$('.Title-Title').html('<span>]]..Server.Name..[[</span> - Registration');
					document.getElementById('RegUsername').value=']]..getPlayerName(localPlayer)..[[';);
				]]);

				triggerServerEvent("RegisterLogin:CheckAccount:S",localPlayer);--check is user already existing(UI pages)

				updateUI();

				if(fileExists(":"..RESOURCE_NAME.."/ClientFiles/username.txt")and fileExists(":"..RESOURCE_NAME.."/ClientFiles/password.txt"))then
					--Username
					local DataFileUsername=fileOpen(":"..RESOURCE_NAME.."/ClientFiles/username.txt");
					local SavedUsername=tostring(fileRead(DataFileUsername,fileGetSize(DataFileUsername)));
					fileClose(DataFileUsername);
					--Password
					local DataFilePassword=fileOpen(":"..RESOURCE_NAME.."/ClientFiles/password.txt");
					local SavedPassword=tostring(fileRead(DataFilePassword,fileGetSize(DataFilePassword)));
					local getHashPassword=decodeString("base64",SavedPassword,{key="KFSJIFNZABZATAXZ",iv="XCUZAGXTZGXAHAAN"});
					fileClose(DataFilePassword);

					executeBrowserJavascript(Browser,[[
						document.getElementById('LogUsername').value=']]..SavedUsername..[[';
						document.getElementById('RegUsername').value=']]..getPlayerName(localPlayer)..[[';
						RemberMeCorrect('true');

						document.getElementById('LogPassword').value=']]..getHashPassword..[[';
					]]);
				else
					executeBrowserJavascript(Browser,[[
						document.getElementById('LogUsername').value=']]..getPlayerName(localPlayer)..[[';
						document.getElementById('RegUsername').value=']]..getPlayerName(localPlayer)..[[';
						RemberMeCorrect('false');
					]]);
				end

				if(fileExists(":"..RESOURCE_NAME.."/ClientFiles/language.txt"))then
					local DataFileLanguage=fileOpen(":"..RESOURCE_NAME.."/ClientFiles/language.txt");
					local SavedLanguage=tonumber(fileRead(DataFileLanguage,fileGetSize(DataFileLanguage)));
					fileClose(DataFileLanguage);

					executeBrowserJavascript(Browser,[[
						openCorrectPage('language');
					]]);
					updateUI();
				end
			end)
		end)
		setLoginRegisterStuff(true);
		setUIdatas("set","cursor");
	else--disappear
		if(isElement(BrowserUI))then
			destroyElement(BrowserUI);
			BrowserUI=nil;
			setUIdatas("rem","cursor");
		end

		if(RememberMe)then
			if(fileExists(":"..RESOURCE_NAME.."/ClientFiles/username.txt"))then
				fileDelete(":"..RESOURCE_NAME.."/ClientFiles/username.txt");
			end
			local DataFileUsername=fileCreate(":"..RESOURCE_NAME.."/ClientFiles/username.txt");
			fileWrite(DataFileUsername,tostring(RememberMeName));
			fileClose(DataFileUsername);

			if(fileExists(":"..RESOURCE_NAME.."/ClientFiles/password.txt"))then
				fileDelete(":"..RESOURCE_NAME.."/ClientFiles/password.txt");
			end
			local DataFilePassword=fileCreate(":"..RESOURCE_NAME.."/ClientFiles/password.txt");
			local HashPassword=encodeString("base64",RememberMePassword,{key="KFSJIFNZABZATAXZ",iv="XCUZAGXTZGXAHAAN"});
			fileWrite(DataFilePassword,HashPassword);
			fileClose(DataFilePassword);

			if(fileExists(":"..RESOURCE_NAME.."/ClientFiles/language.txt"))then
				fileDelete(":"..RESOURCE_NAME.."/ClientFiles/language.txt");
			end
			local DataFileLanguage=fileCreate(":"..RESOURCE_NAME.."/ClientFiles/language.txt");
			fileWrite(DataFileLanguage,tostring(RememberMeLaguage));
			fileClose(DataFileLanguage);
		else
			if(fileExists(":"..RESOURCE_NAME.."/ClientFiles/username.txt"))then
				fileDelete(":"..RESOURCE_NAME.."/ClientFiles/username.txt");
			end
			if(fileExists(":"..RESOURCE_NAME.."/ClientFiles/password.txt"))then
				fileDelete(":"..RESOURCE_NAME.."/ClientFiles/password.txt");
			end
			if(fileExists(":"..RESOURCE_NAME.."/ClientFiles/language.txt"))then
				fileDelete(":"..RESOURCE_NAME.."/ClientFiles/language.txt");
			end
		end


		--bind some keys to funcs
		bindKey("M","DOWN",getCursor);
		bindKey("RALT","DOWN",getCursor);

		--trigger some events
		triggerServerEvent("Rob:ATM:Sync:Effects:S",localPlayer);
		triggerServerEvent("Rob:SprunkATM:Sync:Effects:S",localPlayer);
		triggerServerEvent("Rob:Load:Bots:Container",localPlayer);
		triggerServerEvent("Rob:Load:Bots:Jewelery",localPlayer);

		triggerServerEvent("Bosses:Load:Bots:S",localPlayer);

		--cam stuff
		setLoginRegisterStuff(nil);
	end
end)

addEventHandler("RegisterLogin:Register:C",root,function(name,password,promoter,secretQ,secretA)
	local discordID=returnDiscordID();
	triggerServerEvent("RegisterLogin:Register:S",localPlayer,tostring(name),tostring(password),tostring(promoter),tonumber(secretQ),tostring(string.lower(secretA)),tostring(discordID));
end)
addEventHandler("RegisterLogin:Login:C",root,function(name,password)
	local discordID=returnDiscordID();
	triggerServerEvent("RegisterLogin:Login:S",localPlayer,tostring(name),tostring(password),tostring(discordID));
end)
addEventHandler("RegisterLogin:ResetPassword:C",root,function(serial,password,answer)
	triggerServerEvent("RegisterLogin:ResetPassword:S",localPlayer,tostring(serial),tostring(password),tostring(string.lower(answer)));
end)

addEventHandler("RegisterLogin:CheckName",root,function(name)
	triggerServerEvent("RegisterLogin:Callback:S:Name",localPlayer,tostring(name));
end)
addEventHandler("RegisterLogin:CheckPromoter",root,function(name)
	triggerServerEvent("RegisterLogin:Callback:S:Promoter",localPlayer,tostring(name));
end)
addEventHandler("RegisterLogin:CheckForgotSerial",root,function(serial)
	triggerServerEvent("RegisterLogin:Callback:S:ForgotAccount",localPlayer,tostring(serial));
end)

addEventHandler("RegisterLogin:Callback:C:Name",root,function(state)
	if(state==true)then--taken
		executeBrowserJavascript(Browser,[[
			nnameAlreadyTaken(true);
		]]);
	else--not taken
		executeBrowserJavascript(Browser,[[
			nnameAlreadyTaken(false);
		]]);
	end
end)
addEventHandler("RegisterLogin:Callback:C:Promoter",root,function(state)
	if(state==true)then--exist
		executeBrowserJavascript(Browser,[[
			promoterExist(true);
		]]);
	else--doesnt exist
		executeBrowserJavascript(Browser,[[
			promoterExist(false);
		]]);
	end
end)

addEventHandler("RegisterLogin:Callback:C:ForgotAccount",root,function(answerType)
	if(answerType)then--exist
		executeBrowserJavascript(Browser,[[
			forgotSecretAnswer(']]..answerType..[[');
		]]);
	else--doesnt exist
		executeBrowserJavascript(Browser,[[
			forgotSecretAnswer();
		]]);
	end
end)

addEventHandler("RegisterLogin:CheckAccount:C",root,function(type)--check is user already existing(UI pages)
	setTimer(function()
		if(isElement(BrowserUI))then
			if(fileExists(":"..RESOURCE_NAME.."/ClientFiles/language.txt"))then
				local DataFileLanguage=fileOpen(":"..RESOURCE_NAME.."/ClientFiles/language.txt");
				local SavedLanguage=tonumber(fileRead(DataFileLanguage,fileGetSize(DataFileLanguage)));
				fileClose(DataFileLanguage);

				executeBrowserJavascript(Browser,[[
					openCorrectPage('language',']]..SavedLanguage..[[');
				]]);

				if(Translation[tonumber(SavedLanguage)])then
					setElementData(localPlayer,"Language",tonumber(SavedLanguage));
					RememberMeLaguage=SavedLanguage;
				else
					RememberMeLaguage=0;
				end
			else
				RememberMeLaguage=0;
			end
			
			executeBrowserJavascript(Browser,[[
				openCorrectPage(']]..type..[[','0');
			]]);
		end
	end,500,1);
end)

addEventHandler("RegisterLogin:Language",root,function(language)
	if(Translation[tonumber(language)])then
		setElementData(localPlayer,"Language",tonumber(language));

		updateUI();
	else
		setElementData(localPlayer,"Language",tonumber(0));

		updateUI();
	end
end)


addEventHandler("RegisterLogin:RememberMe",root,function(save,name,password,language)
	if(save=="1")then--save
		RememberMe=true;
		RememberMeName=tostring(name);
		RememberMePassword=tostring(password);
		RememberMeLaguage=tonumber(language);
	elseif(save=="0")then--dont save
		RememberMe=false;
	end
end)


function setLoginRegisterStuff(type)
	if(type)then
		guiSetInputMode("no_binds");
		guiSetInputMode("no_binds_when_editing");
		fadeCamera(true);

		setElementDimension(localPlayer,0);
		setElementInterior(localPlayer,0);
		setElementPosition(localPlayer,RegisterLogin.SpawnPositionInUI);
		setElementFrozen(localPlayer,true);

		RandomCam=math.random(1,#RegisterLogin.CamPositions);
		Data=RegisterLogin.CamPositions[RandomCam];
		smoothMoveCamera(Data[1],Data[2],Data[3], Data[4],Data[5],Data[6],  Data[7],Data[8],Data[9], Data[10],Data[11],Data[12], CamTimerDuration);

		CamTimer=setTimer(function()
			RandomCam=math.random(1,#RegisterLogin.CamPositions);
			Data=RegisterLogin.CamPositions[RandomCam];
			smoothMoveCamera(Data[1],Data[2],Data[3], Data[4],Data[5],Data[6],  Data[7],Data[8],Data[9], Data[10],Data[11],Data[12], CamTimerDuration);
		end,CamTimerDuration,0)
	else
		if(isTimer(CamTimer))then
			killTimer(CamTimer);
			CamTimer=nil;
		end
		setTimer(function()
			stopSmoothMoveCamera();
		end,100,1)
	end
end