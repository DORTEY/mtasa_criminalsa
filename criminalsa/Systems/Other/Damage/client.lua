addRemoteEvents{"Hospital:UI","Damage:Bloodscreen:C"};--addEvent


local BrowserUI,Browser=nil,nil;

local DeathTimerTillStart,DeathTimer,TimerHitmarker,TimerWallbug=nil,nil,nil,nil;
local KilledBy,AimingTarget=nil,{};
local ShootDelay={};
local ScreenHitX,ScreenHitY=nil,nil;


addEventHandler("Hospital:UI",root,function(type,time,killer)
	if(type)then--appear
		if(killer and killer~="")then
			KilledBy=killer;
		else
			KilledBy="";
		end


		BrowserUI=guiCreateBrowser(0,0,GLOBALscreenX,GLOBALscreenY,true,true,false,nil);
		Browser=guiGetBrowser(BrowserUI);

		addEventHandler("onClientBrowserCreated",Browser,function()
			loadBrowserURL(Browser,"http://mta/local/Files/UI/Deathscreen/main.html");
			focusBrowser(Browser);

			executeBrowserJavascript(Browser,"resetDeathscreen();");

			addEventHandler("onClientBrowserDocumentReady",BrowserUI,function(url)
				local x,y,z=getElementPosition(localPlayer);
				local Sound=playSound(":"..RESOURCE_NAME.."/Files/Audio/Wasted.mp3",false);
				setSoundVolume(Sound,1.0);

				if(isTimer(DeathTimerTillStart))then
					killTimer(DeathTimerTillStart);
					DeathTimerTillStart=nil;
				end

				executeBrowserJavascript(Browser,"deathscreenStart('1','"..time.."');");

				DeathTimerTillStart=setTimer(function()
					setClickedState(localPlayer,false);
					setCameraMatrix(x,y,z+5,x,y,z);

					executeBrowserJavascript(Browser,"deathscreenStart('2','"..time.."');");

					DeathTimer=setTimer(function()
						time=time-1;

						triggerServerEvent("Hospital:UpdateTime",localPlayer);
						executeBrowserJavascript(Browser,"updateDeathscreen('"..time.."','"..KilledBy.."');");

						if(time==0)then
							if(isTimer(DeathTimerTillStart))then
								killTimer(DeathTimerTillStart);
								DeathTimerTillStart=nil;
							end
							if(isTimer(DeathTimer))then
								killTimer(DeathTimer);
								DeathTimer=nil;
							end
							triggerServerEvent("Hospital:Respawn",localPlayer);
						end
					end,1000,time)
				end,2000,1)
			end)
		end)
	else--disappear
		if(isElement(BrowserUI))then
			destroyElement(BrowserUI);
			BrowserUI=nil;
		end

		if(isTimer(DeathTimerTillStart))then
			killTimer(DeathTimerTillStart);
			DeathTimerTillStart=nil;
		end

		if(isTimer(DeathTimer))then
			killTimer(DeathTimer);
			DeathTimer=nil;
		end
	end
end)



addEventHandler("onClientPlayerDamage",root,function(attacker,weapon,bodypart,loss)
	if(attacker and weapon and bodypart and loss)then
		if(getElementData(localPlayer,"Player:Data:Savezone"))then
			cancelEvent();
		end
		if(getElementData(attacker,"Player:Data:Savezone"))then
			cancelEvent();
		end
		if(attacker==localPlayer)then
			if(Weapon.DamagesOnPlayer[weapon])then
				if(source~=localPlayer)then
					if(getPlayerNotExistingJsonValue(localPlayer,"Settings","Hitbell")and getPlayerJsonValue(localPlayer,"Settings","Hitbell")>0)then
						local soundFile=playSound(":"..RESOURCE_NAME.."/Files/Audio/Hitbell/"..getPlayerJsonValue(localPlayer,"Settings","Hitbell")..".mp3");
						setSoundVolume(soundFile,0.6);
					end
				end
				cancelEvent();
				triggerServerEvent("Damage:Trigger:FromPlayerToPlayer",source,source,weapon,bodypart,loss);
			end
		elseif(source==localPlayer)then
			if(Weapon.DamagesOnPlayer[weapon])then
				cancelEvent();
			end
		end
	end
end)




--weapon delays & hitmarker
function drawHitmarker()
	dxDrawImage(ScreenHitX-10,ScreenHitY-10,20,20,":"..getResourceName(getThisResource()).."/Files/Images/Hitmarker/"..getPlayerJsonValue(localPlayer,"Settings","Hitmarker")..".png",0,0,0,tocolor(255,255,255,255));
end

addEventHandler("onClientPlayerWeaponFire",localPlayer,function(weap,_,_,hitX,hitY,hitZ,hitElem)
	if(Weapon.Delays[weap])then
		local delay=Weapon.Delays[weap];
		toggleControl("fire",false);
		toggleControl("action",false);
		setPedControlState("fire",false);
		setPedControlState("action",false);
		ShootDelay[weap]=setTimer(function()
			toggleControl("fire",true);
			toggleControl("action",true);
		end,delay,1)
	end

	if(hitElem)then
		if(getElementType(hitElem)=="player" or getElementType(hitElem)=="ped" or getElementType(hitElem)=="vehicle")then
			if(not(getPlayerNotExistingJsonValue(localPlayer,"Settings","Hitmarker")))then
				return;
			end
			if(getPlayerJsonValue(localPlayer,"Settings","Hitmarker")==0)then
				return;
			end
			if(isTimer(TimerHitmarker))then
				return;
			end

			ScreenHitX,ScreenHitY=getScreenFromWorldPosition(hitX,hitY,hitZ);

			removeEventHandler("onClientRender",root,drawHitmarker);
			addEventHandler("onClientRender",root,drawHitmarker);

			TimerHitmarker=setTimer(function()
				removeEventHandler("onClientRender",root,drawHitmarker);

				if(isTimer(TimerHitmarker))then
					killTimer(TimerHitmarker);
					TimerHitmarker=nil;
				end
			end,300,1)
		end
	end
end)

--[[ addEventHandler("onClientPlayerWeaponSwitch",localPlayer,function()
	local Weapon=getPedWeapon(localPlayer)or 0;
	if(isTimer(ShootDelay[Weapon]))then
		toggleControl("fire",false);
	else
		toggleControl("fire",true);
	end
end) ]]

--bloodscreen
local bloodAlpha=0;
addEventHandler("Damage:Bloodscreen:C",root,function()
	bloodAlpha=255;
end)

addEventHandler("onClientRender",root,function()
	if(not(isLoggedin()))then
		return;
	end
	
	if(bloodAlpha>0)then
		if(getPlayerJsonValue(localPlayer,"Settings","EffectsBloodscreen")>0)then
			dxDrawImage(0,0,GLOBALscreenX,GLOBALscreenY,":"..RESOURCE_NAME.."/Files/Images/Bloodscreen/"..getPlayerJsonValue(localPlayer,"Settings","EffectsBloodscreen")..".png",0,0,0,tocolor(255,255,255,bloodAlpha));
			bloodAlpha=math.max(0,bloodAlpha-3);
		end
	end
end)





--Bots
addEventHandler("onClientPedDamage",root,function(attacker,weapon,bodypart,loss)
	if(attacker and weapon and bodypart and loss)then
		if(attacker==localPlayer)then
			if(getElementData(source,"Ped:Data:Godmode"))then
				cancelEvent();
			else
				if(Weapon.DamagesOnPed[weapon])then
					if(getPlayerNotExistingJsonValue(localPlayer,"Settings","Hitbell")and getPlayerJsonValue(localPlayer,"Settings","Hitbell")>0)then
						local soundFile=playSound(":"..RESOURCE_NAME.."/Files/Audio/Hitbell/"..getPlayerJsonValue(localPlayer,"Settings","Hitbell")..".mp3");
						setSoundVolume(soundFile,0.4);
					end
					cancelEvent();

					local x1,y1,z1=getPedBonePosition(localPlayer,8);
					local x2,y2,z2=getPedBonePosition(source,8);
					local Line=isLineOfSightClear(x1,y1,z1,x2,y2,z2,true,false,false,true,false,true);
					if(Line)then
						triggerServerEvent("Damage:Trigger:FromPlayerToPed",source,source,weapon,bodypart,loss,true);
					else
						triggerServerEvent("Damage:Trigger:FromPlayerToPed",source,source,weapon,bodypart,0,false);
					end
				end
			end
		elseif(source==localPlayer)then
			if(Weapon.DamagesOnPed[weapon])then
				cancelEvent();
			end
		end
	end
end)

addEventHandler("onClientPedWeaponFire",root,function(weapon)
    if(getElementData(source,"Bot:Data:Rob")or getElementData(source,"Bot:Data:Bosses"))then
        triggerServerEvent("Damage:Trigger:Ped",localPlayer,weapon);
    end
end)



--anti wallbug
addEventHandler("onClientPlayerTarget",root,function(elem)
	if(elem)then
		if(getElementType(elem))then
			AimingTarget={getElementType(elem),elem};
		else
			AimingTarget={};
		end
	else
		AimingTarget={};
	end
end)
addEventHandler("onClientRender",root,function()
	if(not(isLoggedin()))then
		return;
	end
	if(getElementData(localPlayer,"Player:Data:isMining"))then
		return;
	end
	
	if(AimingTarget and AimingTarget[1]=="ped" and AimingTarget[2])then
		local x1,y1,z1=getPedBonePosition(localPlayer,8);
		local x2,y2,z2=getPedBonePosition(AimingTarget[2],8);

		local Line=isLineOfSightClear(x1,y1,z1,x2,y2,z2,true,false,false,true,false,true);
		if(not(Line))then
			toggleControl("fire",false);
			toggleControl("action",false);
			setPedControlState("fire",false);
			setPedControlState("action",false);

			local sx,sy=getScreenFromWorldPosition(x2,y2,z2+0.5,1000,true);
			dxDrawText("Shooting not available",sx,sy+35,sx,sy,tocolor(255,60,60,255),1,"default-bold","center","center",false,false,true,true);
		else
			local Weapon=getPedWeapon(localPlayer)or 0;
			if(isTimer(ShootDelay[Weapon]))then
				toggleControl("fire",false);
				toggleControl("action",false);
				setPedControlState("fire",false);
				setPedControlState("action",false);
			else
				toggleControl("fire",true);
				toggleControl("action",true);
			end
		end
	else
		local Weapon=getPedWeapon(localPlayer)or 0;
		if(isTimer(ShootDelay[Weapon]))then
			toggleControl("fire",false);
			toggleControl("action",false);
			setPedControlState("fire",false);
			setPedControlState("action",false);
		else
			toggleControl("fire",true);
			toggleControl("action",true);
		end
	end
end)