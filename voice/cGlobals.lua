SETTINGS_REFRESH = 2000 -- Interval in which team channels are refreshed, in MS.
bShowChatIcons = true

voicePlayers = {}
globalMuted = {}

---
--addEventHandler ( "onClientPlayerVoiceStart", root,
--	function()
--		if isPlayerVoiceMuted ( source ) then
--			cancelEvent()
--			return
--		end
--		voicePlayers[source] = true
--	end
--)



local range=25;
  
addEventHandler("onClientPlayerVoiceStart",root,function() 
	--if(isPlayerVoiceMuted(source))then
	--	cancelEvent();
	--	return;
	--end
	if(source and isElement(source)and getElementType(source)=="player")then
		if(exports["criminalsa"]:isLoggedin(source))then
			--[[ if(getElementData(source,"Mutetime")>=1)then
				cancelEvent();
				return;
			end ]]
			if(isPedDead(source))then
				cancelEvent();
				return;
			end
			if(getElementDimension(localPlayer)==getElementDimension(source))then
				local sX,sY,sZ=getElementPosition(localPlayer);
				local rX,rY,rZ=getElementPosition(source);
				local distance=getDistanceBetweenPoints3D(sX,sY,sZ,rX,rY,rZ);
				if(distance<=range)then
					voicePlayers[source]=true;
				else 
					cancelEvent();
				end
			end
		end
	end
end)

addEventHandler("onClientPlayerVoiceStop",root,function()
	voicePlayers[source]=nil;
end)

addEventHandler("onClientPlayerQuit",root,function()
	voicePlayers[source]=nil;
end)
---

function checkValidPlayer ( player )
	if not isElement(player) or getElementType(player) ~= "player" then
		outputDebugString ( "is/setPlayerVoiceMuted: Bad 'player' argument", 2 )
		return false
	end
	return true
end

---

setTimer (
	function()
		bShowChatIcons = getElementData ( resourceRoot, "show_chat_icon", show_chat_icon )
	end,
SETTINGS_REFRESH, 0 )


























addEventHandler("onClientPreRender", root,function ()
	local players = getElementsByType("player", root, true)
	
	for _,v in ipairs(players) do
		local vecSoundPos = v.position;
		local vecCamPos = Camera.position;
		local fDistance = (vecSoundPos - vecCamPos).length;
		local fMaxVol = 100;
		local fMinDistance = 2;
		local fMaxDistance = 25;
		
		local fPanSharpness = 1.0
		if (fMinDistance ~= fMinDistance * 2) then
			fPanSharpness = math.max(0, math.min(1, (fDistance - fMinDistance) / ((fMinDistance * 2) - fMinDistance)))
		end
		
		local fPanLimit = (0.65 * fPanSharpness + 0.35)
		
		local vecLook = Camera.matrix.forward.normalized
		local vecSound = (vecSoundPos - vecCamPos).normalized
		local cross = vecLook:cross(vecSound)
		local fPan = math.max(-fPanLimit, math.min(-cross.z, fPanLimit))
		
		local fDistDiff = fMaxDistance - fMinDistance;
		
		
		local fVolume
		if (fDistance <= fMinDistance) then
			fVolume = fMaxVol
		elseif (fDistance >= fMaxDistance) then
			fVolume = 0.0
		else
			fVolume = math.exp(-(fDistance - fMinDistance) * (5.0 / fDistDiff)) * fMaxVol
		end
		setSoundPan(v, fPan)
		
		if isLineOfSightClear(localPlayer.position, vecSoundPos, true, true, false, true, false, true, true, localPlayer) then
			setSoundVolume(v, fVolume)
			setSoundEffectEnabled(v, "compressor", false)
		else
			local fVolume = fVolume * 0.5 -- reduce volume by half
			local fVolume = fVolume < 0.01 and 0 or fVolume -- treshold of 0.01 (anything below is forced to 0)
			setSoundVolume(v, fVolume)
			setSoundEffectEnabled(v, "compressor", true)
		end
	end
end,false)

addEventHandler("onClientElementStreamIn", root,function ()
	if source:getType() == "player" then
		triggerServerEvent("proximity-voice::broadcastUpdate", localPlayer, getElementsByType("player", root, true))
	end
end)

addEventHandler("onClientElementStreamOut", root,function ()
	if source:getType() == "player" then
		triggerServerEvent("proximity-voice::broadcastUpdate", localPlayer, getElementsByType("player", root, true))
		setSoundPan(source, 0)
		setSoundVolume(source, 0)
	end
end)

addEventHandler("onClientResourceStart", resourceRoot,
    function ()
        triggerServerEvent("proximity-voice::broadcastUpdate", localPlayer, getElementsByType("player", root, true)) -- request server to start broadcasting voice data once the resource is loaded (to prevent receiving voice data while this script is still downloading)
    end
, false)