addRemoteEvents{"Teleporter:UI","Teleport:Teleport:C","Teleporter:Loadingscreen"};--addEvents


addEventHandler("Teleporter:UI",root,function(type,type2)
    if(not(isLoggedin()))then
		return;
	end
	if(isPedDead(localPlayer))then
		return;
	end

    if(type)then
		if(not(CEFready))then
            return;
        end
        
        if(isClickedState(localPlayer)==true)then
            return;
        end
        if(getElementData(localPlayer,"Player:Data:isTeleporting"))then
            return;
        end

        setUIdatas("set","cursor");
        guiSetVisible(BrowserTeleporter,true);

        local HideoutTier=tonumber(getPlayerJsonValue(localPlayer,"HideUpgrades","Hideout"))or 0;

        executeBrowserJavascript(getBrowserTeleporter,"clearTeleporter();");
        for name,v in pairs(Teleporter[HideoutTier][tostring(type2)])do
            executeBrowserJavascript(getBrowserTeleporter,"insertTeleporterStuff('"..type2.."','"..name.."','"..loc(localPlayer,"UI:Teleporter:"..name).."','"..v[5].."');");
        end
	else
        setUIdatas("rem","cursor");
        guiSetVisible(BrowserTeleporter,false);
	end
end)

addEventHandler("Teleport:Teleport:C",root,function(type,name)
    if(not(isLoggedin()))then
		return;
	end
	if(isPedDead(localPlayer))then
		return;
	end
	if(isClickedState(localPlayer)==false)then
        return;
	end
    if(not guiGetVisible(BrowserTeleporter))then
        return;
    end

    if(type and name)then
        triggerServerEvent("Teleport:Teleport:S",localPlayer,type,name);
    end
end)

addEventHandler("onClientPlayerWasted",root,function()
	if(source==localPlayer)then
		if(isElement(BrowserTeleporter))then
			guiSetVisible(BrowserTeleporter,false);
			setUIdatas("rem","cursor");
		end
	end
end)