local WAYPOINT=false;

local RADAR_MAP_WIDTH=6000;
local RADAR_MAP_HEIGHT=6000;
local RADAR_PixelsPerMeter=GLOBALscreenY/6000;

local RADAR_TOPLEFT_WX=-3000;
local RADAR_TOPLEFT_WY=3000;
local RADAR_MAP_FILE= ":criminalsa/Files/Images/Radar/Map.png";

local RADAR_TOOLTIP={};


function drawRadar()
	if(not(isLoggedin()))then
		return;
	end
	if(getElementDimension(localPlayer)>0)then
        RADAR_TOGGLE=false;
		return;
	end
	if(isMainMenuActive())then
		return;
	end
	if(isPedDead(localPlayer))then
		return;
	end
	if(isClickedState(localPlayer)==true)then
		return;
	end
	if(getPedWeapon(localPlayer)==34 and isPedAiming(localPlayer))then
		return;
	end
	
	if(RADAR_TOGGLE)then
		local playerX,playerY,playerZ=getElementPosition(localPlayer);
		local playerROT=getPedRotation(localPlayer);
		local mapX,mapY=getMapFromWorldPosition(playerX,playerY);
		
		if(fileExists(RADAR_MAP_FILE))then
			dxDrawImage(GLOBALscreenX/2-RADAR_PixelsPerMeter*RADAR_MAP_WIDTH*1/2*1,GLOBALscreenY/2-RADAR_PixelsPerMeter*RADAR_MAP_HEIGHT*1/2*1,RADAR_PixelsPerMeter*RADAR_MAP_WIDTH*1,RADAR_PixelsPerMeter*RADAR_MAP_HEIGHT*1,RADAR_MAP_FILE,0,0,0,tocolor(255,255,255,getPlayerMapOpacity()),false);
		end

		--Draw Player arrow
		if(fileExists(":"..RESOURCE_NAME.."/Files/Images/Radar/Blips/Arrow.png"))then
			dxDrawImage(mapX-8,mapY-8,18,18,":"..RESOURCE_NAME.."/Files/Images/Radar/Blips/Arrow.png",(-playerROT)%360,0,0,normalColor,true);
		end
		
		
		--Draw Areas
		for _,v in ipairs(getElementsByType("radararea"))do
			local areaX,areaY=getElementPosition(v);
			local areaSX,areaSY=getRadarAreaSize(v);
			local areaR,areaG,areaB,areaA=getRadarAreaColor(v);
			if(isRadarAreaFlashing(v))then
				areaA=areaA*math.abs(getTickCount()%1000-500)/500;
			end
			
			local hx1,hy1=getMapFromWorldPosition(areaX,areaY+areaSY);
			local hx2,hy2=getMapFromWorldPosition(areaX+areaSX,areaY);
			local areaMapX=hx2-hx1;
			local areaMapY=hy2-hy1;
			
			dxDrawRectangle(hx1,hy1,areaMapX,areaMapY,tocolor(areaR,areaG,areaB,areaA),false);
		end
		
		--Draw Blips
		for _,v in ipairs(getElementsByType("blip"))do
			if(getElementInterior(localPlayer)==getElementInterior(v)and getElementDimension(localPlayer)==getElementDimension(v))then
				if(not(getElementData(v,"Blip:Data:OnlyMinimap")))then
					local icon=getBlipIcon(v)or 0;
					local blipSize=getBlipSize(v)or 20;
					
					local blipR,blipG,blipB,blipA=getBlipColor(v);
					
					local blipX,blipY,_=getElementPosition(v);
					blipMapX,blipMapY=getMapFromWorldPosition(blipX,blipY);
					

					local halfsize=blipSize/2;
					if(fileExists(":"..RESOURCE_NAME.."/Files/Images/Radar/Blips/"..icon..".png"))then
						if(isCursorOnElement(blipMapX-halfsize,blipMapY-halfsize,blipSize,blipSize))then
							if(icon==1 and blipX==playerX and blipY==playerY)then
							else
								dxDrawImage(blipMapX-halfsize,blipMapY-halfsize,blipSize*1.1,blipSize*1.1,":"..RESOURCE_NAME.."/Files/Images/Radar/Blips/"..icon..".png",0,0,0,tocolor(blipR,blipG,blipB,blipA),false);
							end
						else
							if(icon==1 and blipX==playerX and blipY==playerY)then
							else
								dxDrawImage(blipMapX-halfsize,blipMapY-halfsize,blipSize,blipSize,":"..RESOURCE_NAME.."/Files/Images/Radar/Blips/"..icon..".png",0,0,0,tocolor(blipR,blipG,blipB,blipA),false);
							end
						end
					end
				end
			end
		end

		--Click functions
		if(isCursorShowing())then
			if(getKeyState("mouse1")and getKeyState("lshift"))then--Admin Teleport
				if(Admin[tonumber(getElementData(localPlayer,"AdminLevel"))].Permissions.TeleportTroughF11)then
					fadeCamera(false);

					local cursorX,cursorY=getCursorPosition();
					cursorX,cursorY=cursorX*GLOBALscreenX,cursorY*GLOBALscreenY;

					local MapX,MapY=cursorToMapPositionF11(cursorX,cursorY);
					local TeleX,TeleY=mapToWorldPositionF11(MapX,MapY);

					setTimer(function()
						local TeleZ=getGroundPosition(TeleX,TeleY,500);

						if(isPedInVehicle(localPlayer))then
							local veh=getPedOccupiedVehicle(localPlayer);
							if(veh)then
								setElementPosition(veh,TeleX,TeleY,TeleZ+8);
							end
						else
							setElementPosition(localPlayer,TeleX,TeleY,TeleZ+2);
						end
						fadeCamera(true);
					end,1000,1)
				end
			--[[ elseif(getKeyState("mouse1")and not getKeyState("lshift"))then--Set GPS Waypoint
				if(not(WAYPOINT))then
					setGPSClear();

					local cursorX,cursorY=getCursorPosition();
					cursorX,cursorY=cursorX*GLOBALscreenX,cursorY*GLOBALscreenY;

					local MapX,MapY=cursorToMapPositionF11(cursorX,cursorY);
					local TeleX,TeleY=mapToWorldPositionF11(MapX,MapY);
					local TeleZ=getGroundPosition(TeleX,TeleY,100);
					setGPSPosition(TeleX,TeleY,TeleZ);

					WAYPOINT=true;
				end ]]
			--[[ elseif(getKeyState("mouse2"))then--Delete GPS Waypoint
				if(WAYPOINT)then
					WAYPOINT=false;

					setGPSClear();
				end ]]
			end
		end

		--tooltips
		for _,v in ipairs(getElementsByType("blip"))do
			local size=getBlipSize(v)or 20;
			
			local blipX,blipY,_=getElementPosition(v);
			local xx,yy=getMapFromWorldPosition(blipX,blipY);
			
			local halfsize=size/2;
			
			RADAR_TOOLTIP[v]=getElementData(v,"Blip:Data:Tooltip")or nil;
			
			if(RADAR_TOOLTIP[v])then
				if(not(getElementData(v,"Blip:Data:OnlyMinimap")))then
					local sX,sY,_,_,_=getCursorPosition();
					if(isCursorOnElement(xx-halfsize,yy-halfsize,size,size))then
						dxDrawRectangle((sX*GLOBALscreenX)+20*Gsx,(sY*GLOBALscreenY),(dxGetTextWidth(RADAR_TOOLTIP[v],1.20*Gsx,"default-bold")),20*Gsy,tocolor(0,0,0,120),false);
						dxDrawText(RADAR_TOOLTIP[v],(sX*GLOBALscreenX)+20*Gsx,(sY*GLOBALscreenY),(dxGetTextWidth(RADAR_TOOLTIP[v],1.20*Gsx,"default-bold")),cursorY,tocolor(255,255,255,255),1.20*Gsx,"default-bold");
						break;
					end
				end
			end
		end

		--location bottom left
		dxDrawRectangle(20*Gsx,1015*Gsy,380*Gsx,40*Gsy,tocolor(0,0,0,140));
		if(isCursorShowing())then
			local cursorX,cursorY=getCursorPosition();
			cursorX,cursorY=cursorX*GLOBALscreenX,cursorY*GLOBALscreenY;

			local MapX,MapY=cursorToMapPositionF11(cursorX,cursorY);
			local finalX,finalY=mapToWorldPositionF11(MapX,MapY);
			local finalZ=getGroundPosition(finalX,finalY,500);

			dxDrawText(getZoneName(finalX,finalY,finalZ,true).." ("..getZoneName(finalX,finalY,finalZ)..")",20*Gsx+5,(1025*Gsy-250*Gsy+17.5),20*Gsx+5+380*Gsx-10,1025*Gsy+250*Gsy,tocolor(255,255,255,255),1.50*Gsy,"sans","center","center",true,false,false,true,true);
		else
			dxDrawText(getZoneName(playerX,playerY,playerZ,true).." ("..getZoneName(playerX,playerY,playerZ)..")",20*Gsx+5,(1025*Gsy-250*Gsy+17.5),20*Gsx+5+380*Gsx-10,1025*Gsy+250*Gsy,tocolor(255,255,255,255),1.50*Gsy,"sans","center","center",true,false,false,true,true);
		end
	end
end
addEventHandler("onClientRender",root,drawRadar,false,"high")

addEventHandler("onClientPreRender",root,function()
	if(not(isLoggedin()))then
		return;
	end
	if(getElementInterior(localPlayer)>0 or getElementInterior(localPlayer)>0 and getElementDimension(localPlayer)~=14)then
		return;
	end
	if(getElementDimension(localPlayer)>0 and getElementDimension(localPlayer)~=14)then
		return;
	end
	if(isMainMenuActive())then
		return;
	end
	if(isPedDead(localPlayer))then
		return;
	end
	if(isClickedState(localPlayer)==true)then
		return;
	end
	if(not(HUD_STATUS))then
		return;
	end

	if(RADAR_TOGGLE)then
		--GPS
		local gps=getGPSPositionsMax();
		if(gps and #gps>0)then
			for i,v in pairs(gps)do
				if(v.marker and getElementDimension(v.marker)==getElementDimension(localPlayer)and getElementInterior(v.marker)==getElementInterior(localPlayer))then
					local blipX,blipY=getMapFromWorldPosition(v.posX,v.posY);
					local next=gps[i+1];
					if(blipX and blipY and next)then
						local x,y=getMapFromWorldPosition(next.posX,next.posY);
						if(x and y)then
							dxDrawLine(blipX,blipY,x,y,tocolor(0,120,255,200),5,true);
						end
					end
				end
			end

			local next=gps[2];
			if(next)then
				local x,y=getMapFromWorldPosition(next.posX,next.posY);
				if(x and y and blip and isElement(blip))then
					local bx,by=getElementPosition(blip);
					bx,by=getMapFromWorldPosition(bx,by);
					dxDrawLine(x,y,bx,by,tocolor(0,120,255,200),5,true);
				end
			end
		else
			if(WAYPOINT)then
				WAYPOINT=false;

				setGPSClear();
			end
		end
	end
end)

addEventHandler("onClientRender",root,function()--tooltips
	if(RADAR_TOGGLE)then
		
	end
end)

bindKey("F11","UP",function()
	if(getElementInterior(localPlayer)>0 or getElementInterior(localPlayer)>0 and getElementDimension(localPlayer)~=14)then
		return;
	end
	if(getElementDimension(localPlayer)>0 and getElementDimension(localPlayer)~=14)then
		return;
	end

	RADAR_TOGGLE=not RADAR_TOGGLE;
	
	if(RADAR_TOGGLE)then
		if(not(isLoggedin()))then
			return;
		end
		if(isPedDead(localPlayer))then
			return;
		end
		if(isClickedState(localPlayer)==true)then
			return;
		end
		showChat(false);
		showCursor(true);
		RadarStatus=true;
	else
		showChat(true);
		showCursor(false);
		RadarStatus=false;
	end
end)


addEventHandler("onClientPedWasted",root,function()
	if(source==localPlayer)then
		if(RADAR_TOGGLE)then
			showChat(true);
			RADAR_TOGGLE=false;
		end
		if(RadarStatus)then
			RadarStatus=false;
		end
	end
end)






function cursorToMapPositionF11(fallback)
	if(isCursorShowing())then
		local cx,cy=getCursorPosition();
		cx,cy=cx*GLOBALscreenX,cy*GLOBALscreenY;
		return cx-GLOBALscreenX/2,cy-GLOBALscreenY/2;
	elseif fallback then
		return GLOBALscreenX/2-GLOBALscreenX/2,GLOBALscreenY/2-GLOBALscreenY/2;
	end
end

function mapToWorldPositionF11(posX,posY)
	local mapToWorldX=posX*6000/GLOBALscreenY;
	local mapToWorldY=posY*-6000/GLOBALscreenY;

	return mapToWorldX,mapToWorldY;
end
function worldToMapPositionF11(worldX,worldY)
	local worldToMapX=worldX/(6000/GLOBALscreenY);
	local worldToMapY=worldY/(-6000/GLOBALscreenY);

	return worldToMapX,worldToMapY;
end

function getMapFromWorldPosition(worldX,worldY)
	local mapX=GLOBALscreenX/2-RADAR_PixelsPerMeter*RADAR_MAP_WIDTH*1/2*1+RADAR_PixelsPerMeter*(worldX-RADAR_TOPLEFT_WX);
	local mapY=GLOBALscreenY/2-RADAR_PixelsPerMeter*RADAR_MAP_HEIGHT*1/2*1+RADAR_PixelsPerMeter*(RADAR_TOPLEFT_WY-worldY);
	
	return mapX,mapY;
end