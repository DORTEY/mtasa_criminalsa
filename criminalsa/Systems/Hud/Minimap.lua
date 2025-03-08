addRemoteEvents{"Minimap:Load"};--addEvent


local RadiusTable={
	["Plane"]=260,
	["Helicopter"]=220,
	["NormalVehicles"]=150,
	["OnFoot"]=100,
}
local getRadarRadius=function()
	if(isPedInVehicle(localPlayer))then
		local veh=getPedOccupiedVehicle(localPlayer);
		if(veh and isElement(veh))then
			if(Vehicle.Types["Plane"][getElementModel(veh)or getElementData(veh,"Vehicle:Data:ID")])then
				return RadiusTable["Plane"];
			elseif(Vehicle.Types["Helicopter"][getElementModel(veh)or getElementData(veh,"Vehicle:Data:ID")])then
				return RadiusTable["Helicopter"];
			else
				return RadiusTable["NormalVehicles"];
			end
		else
			return RadiusTable["OnFoot"];
		end
	else
		return RadiusTable["OnFoot"];
	end
end

local getVectorRotation=function(x,y,x1,y1)
    local rot=6.2831853071796-math.atan2(x1-x,y1-y)%6.2831853071796;
    return -rot;
end

local getRotation=function()
    local x,y,_,rx,ry=getCameraMatrix();
    local result=getVectorRotation(x,y,rx,ry);
	
    return result;
end

local isColliding=function(x1,y1,w1,h1,x2,y2,w2,h2)
    local horizontal=(x1<x2)~=(x1+w1<x2)or(x1>x2)~=(x1>x2+w2);
    local vertical=(y1<y2)~=(y1+h1<y2)or(y1>y2)~=(y1>y2+h2);
	
    return(horizontal and vertical);
end

local getPointFromDistanceRotation=function(x,y,distance,angel)
    local x1=math.cos(math.rad(90-angel))*distance;
    local y1=math.sin(math.rad(90-angel))*distance;
    return x+x1,y+y1;
end



setMinimapSettings=function()
	RADAR_TARGET_MAP=dxCreateRenderTarget(380*Gsx*2,380*Gsx*2,true);
	RADAR_TARGET_RENDER=dxCreateRenderTarget(380*Gsx*3,380*Gsx*3,true);
	RADAR_IMAGE=dxCreateTexture(":"..RESOURCE_NAME.."/Files/Images/Radar/Map.png");


	radarPositionCenter={20*Gsx,790*Gsy,380*Gsx,250*Gsy}
end

addEventHandler("Minimap:Load",root,function()
	setMinimapSettings();
end)


function drawMinimap()
	if(not(isLoggedin()))then
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
		return;
	end
	if(HUD_TOGGLE)then
		return;
	end
	if(getElementData(localPlayer,"Player:Data:isTeleporting"))then
		return;
	end
	
	if(RADAR_IMAGE and RADAR_TARGET_RENDER)then
		--Health
		local health=math.floor(getElementHealth(localPlayer))or 0;
		local healthAmount=176/100*health;

		dxDrawRectangle(20*Gsx,1050*Gsy,185*Gsx,20*Gsy,tocolor(0,0,0,160),false);--BG
		dxDrawRectangle(24*Gsx,1054*Gsy,healthAmount*Gsx,13*Gsy,tocolor(200,0,0,200),false);
		--Armor
		local armor=math.floor(getPedArmor(localPlayer))or 0;
		local armorAmount=176/100*armor;

		dxDrawRectangle(212*Gsx,1050*Gsy,185*Gsx,20*Gsy,tocolor(0,0,0,160),false);--BG
		dxDrawRectangle(216*Gsx,1054*Gsy,armorAmount*Gsx,13*Gsy,tocolor(200,200,200,200),false);
		if(getElementDimension(localPlayer)>0)then
			return;
		end



		if(fileExists(":"..RESOURCE_NAME.."/Files/Images/Radar/Map.png"))then
			dxSetTextureEdge(RADAR_IMAGE,"border",tocolor(50,75,100,255));
		end
		dxDrawBorder(20*Gsx,790*Gsy,380*Gsx,250*Gsy,2,tocolor(0,0,0,150));
		
		playerX,playerY,playerZ=getElementPosition(localPlayer);
		
		local playerRotation=getElementRotation(localPlayer);
		local rx,ry,rz=getElementRotation(localPlayer);
		local _,_,camZ=getElementRotation(getCamera());
		local playerMapX,playerMapY=(3000+playerX)/6000*3072,(3000-playerY)/6000*3072;
		local streamDistance,pRotation=getRadarRadius(),getRotation();
		local mapRadius=streamDistance/6000*3072*6;
		local mapX,mapY,mapWidth,mapHeight=playerMapX-mapRadius,playerMapY-mapRadius,mapRadius*2,mapRadius*2;
		
		dxSetRenderTarget(RADAR_TARGET_MAP,true);
		dxDrawRectangle(0,0,380*Gsx*2,380*Gsx*2,tocolor(50,75,100,255),false);
		if(fileExists(":"..RESOURCE_NAME.."/Files/Images/Radar/Map.png"))then
			dxDrawImageSection(0,0,380*Gsx*2,380*Gsx*2,mapX,mapY,mapWidth,mapHeight,RADAR_IMAGE,0,0,0,tocolor(255,255,255,255),false);
		end
		
		--Draw Areas
		for _,v in ipairs(getElementsByType("radararea"))do
			local areaX,areaY=getElementPosition(v);
			local areaWidth,areaHeight=getRadarAreaSize(v);
			local areaMapX,areaMapY,areaMapWidth,areaMapHeight=(3000+areaX)/6000*3072,(3000-areaY)/6000*3072,areaWidth/6000*3072,-(areaHeight/6000*3072);
			if(isColliding(playerMapX-mapRadius,playerMapY-mapRadius,mapRadius*2,mapRadius*2,areaMapX,areaMapY,areaMapWidth,areaMapHeight))then
				local areaR,areaG,areaB,areaA=getRadarAreaColor(v);
				if(isRadarAreaFlashing(v))then
					areaA=areaA*math.abs(getTickCount()%1000-500)/500;
				end
				local mapRatio=380*Gsx*2/(mapRadius*2);
				local areaMapX,areaMapY,areaMapWidth,areaMapHeight=(areaMapX-(playerMapX-mapRadius))*mapRatio,(areaMapY-(playerMapY-mapRadius))*mapRatio,areaMapWidth*mapRatio,areaMapHeight*mapRatio;
				dxSetBlendMode("modulate_add");
				dxDrawRectangle(areaMapX,areaMapY,areaMapWidth,areaMapHeight,tocolor(areaR,areaG,areaB,areaA),false);
				dxSetBlendMode("blend");
			end
		end
		
		dxSetRenderTarget(RADAR_TARGET_RENDER,true);
		dxDrawImage(380*Gsx/2,380*Gsx/2,380*Gsx*2,380*Gsx*2,RADAR_TARGET_MAP,math.deg(-pRotation),0,0,tocolor(255,255,255,255),false);
		
		--Draw Blips
		table.sort(getElementsByType("blip"),function(b1,b2)
			return getBlipOrdering(b1)<getBlipOrdering(b2);
		end)
		
		for _,v in ipairs(getElementsByType("blip"))do
			if(not(getElementData(v,"Blip:Data:OnlyF11Map")))then
				local blipX,blipY,blipZ=getElementPosition(v);
				if(localPlayer~=getElementAttachedTo(v)and getElementInterior(localPlayer)==getElementInterior(v)and getElementDimension(localPlayer)==getElementDimension(v))then
					local blipDistance=getDistanceBetweenPoints2D(blipX,blipY,playerX,playerY);
					local maxDist=getBlipVisibleDistance(v);
					if(blipDistance<=maxDist)then
						local blipRotation=math.deg(-getVectorRotation(playerX,playerY,blipX,blipY)-(-pRotation))-180;
						local blipRadius=math.min((blipDistance/(streamDistance*6))*380*Gsx,380*Gsx);
						local distanceX,distanceY=getPointFromDistanceRotation(0,0,blipRadius,blipRotation);
						local blipIcon=getBlipIcon(v);
						local blipX,blipY=380*Gsx*1.5+(distanceX-(20/2)),380*Gsx*1.5+(distanceY-(20/2));
						local blipSize=getBlipSize(v)or 20;
						
						bR,bG,bB=getBlipColor(v);
						
						dxSetBlendMode("modulate_add");
						if(blipIcon==0)then
							if(playerZ and blipZ)then
								if(math.abs(playerZ-blipZ)>3)then
									IMAGE=blipZ>playerZ and "0_up" or "0_down";
								else
									IMAGE="0";
								end
								if(fileExists(":"..RESOURCE_NAME.."/Files/Images/Radar/Blips/"..IMAGE..".png"))then
									dxDrawImage(blipX,blipY,blipSize+2,blipSize+2,":"..RESOURCE_NAME.."/Files/Images/Radar/Blips/"..IMAGE..".png",0,0,0,tocolor(bR,bG,bB,255),false);
								end
							end
						else
							if(fileExists(":"..RESOURCE_NAME.."/Files/Images/Radar/Blips/"..blipIcon..".png"))then
								dxDrawImage(blipX,blipY,blipSize+2,blipSize+2,":"..RESOURCE_NAME.."/Files/Images/Radar/Blips/"..blipIcon..".png",0,0,0,tocolor(bR,bG,bB,255),false);
							end
						end
						dxSetBlendMode("blend");
					end
				end
			end
		end
		
		--Draw Player arrow
		dxSetRenderTarget();
		dxDrawImageSection(20*Gsx,790*Gsy,380*Gsx,250*Gsy,380*Gsx/2+(380*Gsx*2/2)-(380*Gsx/2),380*Gsx/2+(380*Gsx*2/2)-(250*Gsy/2),380*Gsx,250*Gsy,RADAR_TARGET_RENDER,0,-90,0,tocolor(255,255,255,255));
		if(fileExists(":"..RESOURCE_NAME.."/Files/Images/Radar/Blips/Arrow.png"))then
			dxDrawImage((20*Gsx+(380*Gsx/2))-10,(790*Gsy+(250*Gsy/2))-10,20,20,":"..RESOURCE_NAME.."/Files/Images/Radar/Blips/Arrow.png",camZ-rz,0,0);
		end
		
		--Draw Zonename
		dxDrawRectangle(18.5*Gsx,762*Gsy,383*Gsx,25*Gsy,tocolor(0,0,0,140));
		dxDrawText(Server.Color.HEX..""..getZoneName(playerX,playerY,playerZ,false).." #ffffff("..getZoneName(playerX,playerY,playerZ,true)..")",20*Gsx+5,510*Gsy,20*Gsx+5+380*Gsx-10,790*Gsy+250*Gsy,tocolor(255,255,255,255),1.1*Gsy,"default-bold","center","center",true,false,false,true,true);
		--GPS
		--[[ local gps=getGPSPositions();
		if(gps and #gps>0)then
			for i,v in pairs(gps)do
				if(v.marker and getElementDimension(v.marker)==getElementDimension(localPlayer)and getElementInterior(v.marker)==getElementInterior(localPlayer))then
					local xx,yy=getElementPosition(localPlayer);
					local x,y=worldToMapPosition(v.posX,v.posY);

					local next=gps[i+1];
					if(next)then
						local x2,y2=worldToMapPosition(next.posX,next.posY);
						dxDrawLine(x,y,x2,y2,tocolor(0,120,255),5);
					end
				end
			end

			local v=gps[2];
			if(v)then
				local x,y=worldToMapPosition(v.posX,v.posY)
				if(x and y and v.marker and getElementDimension(v.marker)==getElementDimension(localPlayer)and getElementInterior(v.marker)==getElementInterior(localPlayer)and blip and isElement(blip))then
					local p1,p2=getElementPosition(localPlayer);
					local b1,b2=getElementPosition(blip);
					local bx,by=worldToMapPosition(b1,b2);

					dxDrawLine(x,y,bx,by,tocolor(0,120,255),5,true);
				end
			end
		end ]]
	end
end
addEventHandler("onClientRender",root,drawMinimap,false,"high")

function worldToMapPosition(worldX, worldY)
	if worldX and worldY then
		local worldToMapX = worldX / ( 6000/900*Gsx) + 900*Gsx/2
		local worldToMapY = worldY / (-6000/1840*Gsy) + 1840*Gsy/2

		return worldToMapX, worldToMapY
	end
	return 0, 0
end