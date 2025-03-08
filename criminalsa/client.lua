GLOBALscreenX,GLOBALscreenY=guiGetScreenSize();
Gsx=GLOBALscreenX/1920;
Gsy=GLOBALscreenY/1080;


HUD_TOGGLE=false;
RADAR_TOGGLE=false;
SERVER_TIME=0;
SERVER_SLOTS=0;
VEHICLE_HORNS={};




setOcclusionsEnabled(false);--disable map glitches if something is custom mapped
setAmbientSoundEnabled("general",false);
setAmbientSoundEnabled("gunfire",false);--disable default gtasa gunfire from npc's
engineSetAsynchronousLoading(true,true);
setPedTargetingMarkerEnabled(false);--disable right click marker above target ped/player
setWorldSpecialPropertyEnabled("burnflippedcars",false);
--[[ setAircraftMaxVelocity(5555); ]]
setInteriorSoundsEnabled(false);

function returnDiscordID()
	local ID=nil;
	if(isDiscordRichPresenceConnected())then
		local getDiscordID=getDiscordRichPresenceUserID();
        if(getDiscordID~="")then
			ID=getDiscordID;
        end
	end

	return ID;
end

addEventHandler("onClientResourceStart",resourceRoot,function()--disable gtasa ped voice
	for _,v in ipairs(getElementsByType("player"))do
		setPedVoice(v,"PED_TYPE_DISABLED");
	end
	for _,v in ipairs(getElementsByType("ped"))do
		setPedVoice(v,"PED_TYPE_DISABLED");
	end

	setPedVoice(localPlayer,"PED_TYPE_DISABLED");
end)

function setUIdatas(type,cursor,window)
	if(type=="set")then
		if(cursor=="cursor")then
			showCursor(true);
			showChat(false);
			setClickedState(localPlayer,true);
		end
	elseif(type=="rem")then
		if(cursor=="cursor")then
			showCursor(false);
			showChat(true);
			setTimer(function()
				setClickedState(localPlayer,false);
			end,150,1)
		end

		if(window)then--needed for DGS UI's
			if(isElement(UI.Window[1]))then
				destroyElement(UI.Window[1]);
			end
			if(isElement(UI.Window[2]))then
				destroyElement(UI.Window[2]);
			end
			if(isElement(UI.Window[3]))then
				destroyElement(UI.Window[3]);
			end
			if(isElement(UI.Window[4]))then
				destroyElement(UI.Window[4]);
			end
		end
	end
end

function getCursor()
	if(not(isLoggedin()))then
		return;
	end
	if(isClickedState(localPlayer)==true)then
		return;
	end
	
	showCursor(not(isCursorShowing()));
end



addEvent("Sync:ServerDatas:C",true)
addEventHandler("Sync:ServerDatas:C",root,function(time,slots)
	SERVER_TIME=time;
	SERVER_SLOTS=slots;
end)


function isPedAiming(thePedToCheck)
	if(isElement(thePedToCheck))then
		if(getElementType(thePedToCheck)=="player" or getElementType(thePedToCheck)=="ped")then
			if(getPedTask(thePedToCheck,"secondary",0)=="TASK_SIMPLE_USE_GUN")then
				return true;
			end
		end
	end
	return false;
end

function dxDrawBorder(x, y, w, h, size, color, postGUI)
    size = size or 2
    dxDrawRectangle(x - size, y, size, h, color or tocolor(0, 0, 0, 180), postGUI)
    dxDrawRectangle(x + w, y, size, h, color or tocolor(0, 0, 0, 180), postGUI)
    dxDrawRectangle(x - size, y - size, w + (size * 2), size, color or tocolor(0, 0, 0, 180), postGUI)
    dxDrawRectangle(x - size, y + h, w + (size * 2), size, color or tocolor(0, 0, 0, 180), postGUI)
end

function dxDrawRoundedRectangle(x, y, width, height, radius, color, postGUI, subPixelPositioning)
    dxDrawRectangle(x+radius, y+radius, width-(radius*2), height-(radius*2), color, postGUI, subPixelPositioning)
    dxDrawCircle(x+radius, y+radius, radius, 180, 270, color, color, 16, 1, postGUI)
    dxDrawCircle(x+radius, (y+height)-radius, radius, 90, 180, color, color, 16, 1, postGUI)
    dxDrawCircle((x+width)-radius, (y+height)-radius, radius, 0, 90, color, color, 16, 1, postGUI)
    dxDrawCircle((x+width)-radius, y+radius, radius, 270, 360, color, color, 16, 1, postGUI)
    dxDrawRectangle(x, y+radius, radius, height-(radius*2), color, postGUI, subPixelPositioning)
    dxDrawRectangle(x+radius, y+height-radius, width-(radius*2), radius, color, postGUI, subPixelPositioning)
    dxDrawRectangle(x+width-radius, y+radius, radius, height-(radius*2), color, postGUI, subPixelPositioning)
    dxDrawRectangle(x+radius, y, width-(radius*2), radius, color, postGUI, subPixelPositioning)
end

function isCursorOnElement( posX, posY, width, height )
	if isCursorShowing( ) then
		local mouseX, mouseY = getCursorPosition( )
		local clientW, clientH = guiGetScreenSize( )
		local mouseX, mouseY = mouseX * clientW, mouseY * clientH
		if ( mouseX > posX and mouseX < ( posX + width ) and mouseY > posY and mouseY < ( posY + height ) ) then
			return true
		end
	end
	return false
end


addEvent("Debug")
addEventHandler("Debug",root,function(msg)
	print("[HTML]: "..msg);
	outputConsole("[HTML]: "..msg)
end)











local sm = {moov = 0}

local function removeCamHandler()
    if (sm.moov == 1) then
        sm.moov = 0
		removeEventHandler("onClientPreRender",root,camRender);
    end
end

local start, animTime
local tempPos, tempPos2 = {{},{}}, {{},{}}

function camRender()
    local now = getTickCount()
    if (sm.moov == 1) then
        local x1, y1, z1 = interpolateBetween(tempPos[1][1], tempPos[1][2], tempPos[1][3], tempPos2[1][1], tempPos2[1][2], tempPos2[1][3], (now-start) / animTime, "InOutQuad")
        local x2, y2, z2 = interpolateBetween(tempPos[2][1], tempPos[2][2], tempPos[2][3], tempPos2[2][1], tempPos2[2][2], tempPos2[2][3], (now-start) / animTime, "InOutQuad")
        setCameraMatrix(x1, y1, z1, x2, y2, z2)
    else
        removeEventHandler("onClientRender", root, camRender)
        fadeCamera(true)
    end
end

function smoothMoveCamera(x1, y1, z1, x1t, y1t, z1t, x2, y2, z2, x2t, y2t, z2t, time)
    if(sm.moov == 1) then
        if(isTimer(timer1))then
			killTimer(timer1);
		end
		if(isTimer(timer2))then
			killTimer(timer2);
		end
        removeEventHandler("onClientRender", root, camRender)
        fadeCamera(true)
    end
    fadeCamera(true)
    sm.moov = 1
    timer1 = setTimer(removeCamHandler, time, 1)
    timer2 = setTimer(fadeCamera, time - 1000, 1, false)
    start = getTickCount()
    animTime = time
    tempPos[1], tempPos[2] = {x1, y1, z1}, {x1t, y1t, z1t}
    tempPos2[1], tempPos2[2] = {x2, y2, z2}, {x2t, y2t, z2t}
    removeEventHandler("onClientRender", root, camRender)
    addEventHandler("onClientRender", root, camRender)
    return true
end

function stopSmoothMoveCamera()
	if(sm.moov==1)then
		if(isTimer(timer1))then killTimer(timer1);end
		if(isTimer(timer2))then killTimer(timer2);end

		removeCamHandler();
		fadeCamera(true);
		setCameraTarget(localPlayer,localPlayer);
		sm.moov=0;
	end
end