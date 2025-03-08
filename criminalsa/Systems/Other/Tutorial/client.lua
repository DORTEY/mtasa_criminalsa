addRemoteEvents{"Tutorial:ShowStuff"};--addEvents


local Blip=nil;
local Pickup=nil;

local TutorialStep=nil;


addEventHandler("Tutorial:ShowStuff",root,function()
	if(isElement(Blip))then
		destroyElement(Blip);
		Blip=nil;
	end
	if(isElement(Pickup))then
		destroyElement(Pickup);
		Pickup=nil;
	end

	TutorialStep=tonumber(getPlayerJsonValue(localPlayer,"Stats","Tutorial"))or 0;
	
	if(Tutorial[TutorialStep])then

		if(Tutorial[TutorialStep].Current)then
			if(Tutorial[TutorialStep].Current.Blip and Tutorial[TutorialStep].Current.Coords)then
				TutorialCoords=Tutorial[TutorialStep].Current.Coords;

				Blip=createBlip(TutorialCoords[1],TutorialCoords[2],TutorialCoords[3],TutorialCoords[4],22,Server.Color.RGB[1],Server.Color.RGB[2],Server.Color.RGB[3]);
				setElementData(Blip,"Blip:Data:Tooltip",loc(localPlayer,"Tutorial:Title"));
			end

			if(Tutorial[TutorialStep].Current.Pickup and Tutorial[TutorialStep].Current.Coords)then
				TutorialCoords=Tutorial[TutorialStep].Current.Coords;

				Pickup=createPickup(TutorialCoords[1],TutorialCoords[2],TutorialCoords[3],3,1318,0);
				if(Tutorial[TutorialStep].Current.Dimension==tonumber(0))then
					setElementDimension(Pickup,0);
				else
					setElementDimension(Pickup,tonumber(getElementData(localPlayer,"Player:Data:TempID")));
				end
			end
		end

	end
end)


addEventHandler("onClientRender",root,function()
	if(not(isLoggedin()))then
		return;
	end
	if(isPedDead(localPlayer))then
		return;
	end
	if(getPedWeapon(localPlayer)==34 and isPedAiming(localPlayer))then
		return;
	end
	if(RADAR_TOGGLE)then
		return;
	end
    
    if(tonumber(getPlayerJsonValue(localPlayer,"Stats","Tutorial")) and Tutorial[tonumber(getPlayerJsonValue(localPlayer,"Stats","Tutorial"))])then
		dxDrawRectangle(1600*Gsx,475*Gsy,300*Gsx,20*Gsy,tocolor(0,0,0,140),false);
		dxDrawText("#ffffff"..loc(localPlayer,"Tutorial:Title"),3470*Gsx,475*Gsy,30*Gsx,30*Gsy,tocolor(0,0,0,255),1.30*Gsx,"default-bold","center",_,_,_,false,true,_);

		dxDrawRectangle(1600*Gsx,500*Gsy,300*Gsx,110*Gsy,tocolor(0,0,0,140),false);
		dxDrawText(loc(localPlayer,"Tutorial:Step:"..tonumber(getPlayerJsonValue(localPlayer,"Stats","Tutorial"))),3470*Gsx,1080*Gsy,30*Gsx,30*Gsy,tocolor(0,0,0,255),1.10*Gsx,"default-bold","center","center",_,_,false,true,_);
		
		dxDrawText("#ffffff"..loc(localPlayer,"Tutorial:Reward")..": "..Server.Color.HEX..comma_value(Tutorial[tonumber(getPlayerJsonValue(localPlayer,"Stats","Tutorial"))].Current.RewardMoney),3600*Gsx,590*Gsy,30*Gsx,30*Gsy,tocolor(0,0,0,255),1*Gsx,"default-bold","center",_,_,_,false,true,_);
		dxDrawText("#ffffff"..tonumber(getPlayerJsonValue(localPlayer,"Stats","Tutorial")).."/"..Server.Color.HEX.. #Tutorial,3200*Gsx,590*Gsy,30*Gsx,30*Gsy,tocolor(0,0,0,255),1*Gsx,"default-bold","center",_,_,_,false,true,_);
		

		if(Tutorial[tonumber(getPlayerJsonValue(localPlayer,"Stats","Tutorial"))].Current)then
			if(Tutorial[tonumber(getPlayerJsonValue(localPlayer,"Stats","Tutorial"))].Current.Text and Tutorial[tonumber(getPlayerJsonValue(localPlayer,"Stats","Tutorial"))].Current.Coords)then
				TutorialCoords=Tutorial[tonumber(getPlayerJsonValue(localPlayer,"Stats","Tutorial"))].Current.Coords;

				local px,py,pz=getElementPosition(localPlayer);
				local Distance=#(Vector3(TutorialCoords[1],TutorialCoords[2],TutorialCoords[3])-Vector3(getElementPosition(localPlayer)));
				if(Distance>1 and Distance<=5000)then
					local sx,sy=getScreenFromWorldPosition(TutorialCoords[1],TutorialCoords[2],TutorialCoords[3]+0.95,0.06);
					if not sx then return end
					local scale=1/(0.3*(Distance/150));
					dxDrawText(loc(localPlayer,"Tutorial:Title").." ("..Server.Color.HEX..math.floor(Distance).."m#ffffff)",sx,sy-30,sx,sy-30,tocolor(255,255,255,255), math.min((Distance)*1,1.2),"default-bold","center","bottom",false,false,false,true);
				end
			end
		end
	end
end)