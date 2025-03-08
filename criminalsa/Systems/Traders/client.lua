addRemoteEvents{"Trader:UI","Trader:Load","Trader:BuySell:C"};--addEvents


local CurrentTrader=nil;
local PreviewElement,PreviewElementBG,PreviewShader,PreviewTexture,PreviewLight=nil,nil,nil,nil,nil;
local PreviewID,PreviewID2,PreviewID3,PreviewID4=nil,nil,nil,nil;

local CEFTimer,BrowserUI,Browser=nil,nil,nil;


addEventHandler("Trader:UI",root,function(type,trader,timestamp)
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

        local PlayerCurrentLVL=tonumber(getPlayerJsonValue(localPlayer,"Levels","Trader"..trader.."LVL"));
        local PlayerCurrentEXP=tonumber(getPlayerJsonValue(localPlayer,"Levels","Trader"..trader.."EXP"));
        if(TraderSettings.Progress.LevelExp[tostring(trader)][tonumber(PlayerCurrentLVL)]==9999999999)then
            TextPlayerCurrentProgress=PlayerCurrentEXP.." / ~";
        else
            TextPlayerCurrentProgress=PlayerCurrentEXP.." / "..TraderSettings.Progress.LevelExp[tostring(trader)][tonumber(PlayerCurrentLVL)];
        end

        setUIdatas("set","cursor");
        if(not(isTimer(CEFTimer)))then
            BrowserUI=guiCreateBrowser(0,0,GLOBALscreenX,GLOBALscreenY,true,true,false,nil);
            Browser=guiGetBrowser(BrowserUI);

            addEventHandler("onClientBrowserCreated",Browser,function()
                loadBrowserURL(Browser,"http://mta/local/Files/UI/Trader/main.html");
                focusBrowser(Browser);

                addEventHandler("onClientBrowserDocumentReady",BrowserUI,function(url)
                    executeBrowserJavascript(Browser,"setLanguageTrader('"..Server.Name.."','"..loc(localPlayer,"UI:Trader:Title").."','"..loc(localPlayer,"UI:Trader:SearchBar").."','"..loc(localPlayer,"UI:Trader:AmountBar").."',           '"..loc(localPlayer,"UI:Trader:LeaveUI").."','"..loc(localPlayer,"UI:Trader:Buy").."','"..loc(localPlayer,"UI:Trader:Sell").."');");
                    setTimer(function()
                        for _,v in pairs(Traders[tostring(trader)].Items)do
                            if(v.Limited)then
                                if(timestamp<=v.Limited)then
                                    if(PlayerCurrentLVL>=v.Level)then
                                        executeBrowserJavascript(Browser,"loadItemsInTraderList('"..v.Item.."','"..loc(localPlayer,"Item:"..tostring(v.Item)).."','"..timestamp.."','"..tostring(v.OnlyInCrates).."','"..toJSON({TextPlayerCurrentProgress,PlayerCurrentEXP,TraderSettings.Progress.LevelExp[tostring(trader)][tonumber(PlayerCurrentLVL)]}).."');");
                                    end
                                end
                            else
                                if(PlayerCurrentLVL>=v.Level)then
                                    executeBrowserJavascript(Browser,"loadItemsInTraderList('"..v.Item.."','"..loc(localPlayer,"Item:"..tostring(v.Item)).."','0','"..tostring(v.OnlyInCrates).."','"..toJSON({TextPlayerCurrentProgress,PlayerCurrentEXP,TraderSettings.Progress.LevelExp[tostring(trader)][tonumber(PlayerCurrentLVL)]}).."');");
                                end
                            end
                        end
                    end,200,1);
                end)
            end)
        else
            if(isTimer(CEFTimer))then
                killTimer(CEFTimer);
                CEFTimer=nil;
            end
            guiSetVisible(BrowserUI,true);

            executeBrowserJavascript(Browser,"setLanguageTrader('"..Server.Name.."','"..loc(localPlayer,"UI:Trader:Title").."','"..loc(localPlayer,"UI:Trader:SearchBar").."','"..loc(localPlayer,"UI:Trader:AmountBar").."',           '"..loc(localPlayer,"UI:Trader:LeaveUI").."','"..loc(localPlayer,"UI:Trader:Buy").."','"..loc(localPlayer,"UI:Trader:Sell").."');");
            setTimer(function()
                for _,v in pairs(Traders[tostring(trader)].Items)do
                    if(v.Limited)then
                        if(timestamp<=v.Limited)then
                            if(PlayerCurrentLVL>=v.Level)then
                                executeBrowserJavascript(Browser,"loadItemsInTraderList('"..v.Item.."','"..loc(localPlayer,"Item:"..tostring(v.Item)).."','"..timestamp.."','"..tostring(v.OnlyInCrates).."','"..toJSON({TextPlayerCurrentProgress,PlayerCurrentEXP,TraderSettings.Progress.LevelExp[tostring(trader)][tonumber(PlayerCurrentLVL)]}).."');");
                            end
                        end
                    else
                        if(PlayerCurrentLVL>=v.Level)then
                            executeBrowserJavascript(Browser,"loadItemsInTraderList('"..v.Item.."','"..loc(localPlayer,"Item:"..tostring(v.Item)).."','0','"..tostring(v.OnlyInCrates).."','"..toJSON({TextPlayerCurrentProgress,PlayerCurrentEXP,TraderSettings.Progress.LevelExp[tostring(trader)][tonumber(PlayerCurrentLVL)]}).."');");
                        end
                    end
                end
            end,200,1);
        end

        CurrentTrader=trader;
	else
		setUIdatas("rem","cursor");
        if(isTimer(CEFTimer))then
            killTimer(CEFTimer);
            CEFTimer=nil;
        end
        CEFTimer=setTimer(function()
            if(isElement(BrowserUI))then
                destroyElement(BrowserUI);
                BrowserUI=nil;
            end
        end,30*1000,1)
		setUIdatas("rem","cursor");
        if(isElement(BrowserUI)and guiGetVisible(BrowserUI))then
            guiSetVisible(BrowserUI,false);
        end

        executeBrowserJavascript(Browser,"$('.NavbarItem').empty();");
        executeBrowserJavascript(Browser,"$('.ThirdUI').css('display','none');");
        executeBrowserJavascript(Browser,"document.getElementById('Icon').src='../../Images/Transparent.png';");


        CurrentTrader=nil;

        if(isElement(PreviewElement))then
            destroyElement(PreviewElement);
            PreviewElement=nil;
        end
        if(isElement(PreviewElementBG))then
            destroyElement(PreviewElementBG);
            PreviewElementBG=nil;
        end
        if(isElement(PreviewLight))then
            destroyElement(PreviewLight);
            PreviewLight=nil;
        end
        if(isElement(PreviewShader))then
            destroyElement(PreviewShader);
            PreviewShader=nil;
        end
        setCameraTarget(localPlayer);
	end
end)

addEventHandler("Trader:Load",root,function(item)
    if(not(isLoggedin()))then
		return;
	end
	if(isPedDead(localPlayer))then
		return;
	end
	if(isClickedState(localPlayer)==false)then
        return;
	end
    if(not guiGetVisible(BrowserUI))then
        return;
    end

    if(isElement(PreviewElement))then
        destroyElement(PreviewElement);
        PreviewElement=nil;
    end
    if(isElement(PreviewLight))then
        destroyElement(PreviewLight);
        PreviewLight=nil;
    end
    if(isElement(PreviewShader))then
        destroyElement(PreviewShader);
        PreviewShader=nil;
    end

    for i,v in pairs(Traders[CurrentTrader].Items)do
        if(v.Item==item)then
            Limited=v.Limited and v.Limited-SERVER_TIME or 0;

            executeBrowserJavascript(Browser,"showTraderItemDetails('"..item.."','"..loc(localPlayer,"Item:"..tostring(item)).."','"..comma_value(getElementData(root,"Trader:Price:"..tostring(item))).."','"..tostring(v.Buyable).."','"..tostring(v.Sellable).."','"..Limited.."','"..tostring(v.OnlyInCrates).."','"..getPlayerJsonValue(localPlayer,"Items",tostring(item)).."');");
            if(v.PreviewObject)then
                PreviewID=v.PreviewObject[1]or nil;
                PreviewID2=v.PreviewObject[2]or nil;
                PreviewID3=v.PreviewObject[3]or nil;
                PreviewID4=v.PreviewObject[4]or nil;
            else
                PreviewID=nil;
                PreviewID2=nil;
                PreviewID3=nil;
                PreviewID4=nil;
            end
            break;
        end
    end

    if(PreviewID)then
        local x,y,z=getElementPosition(localPlayer);
        local zFix=50;

        PreviewElement=createObject(tonumber(PreviewID),x,y,z,0,0,0);
        if(not isElement(PreviewElementBG))then
            PreviewElementBG=createObject(tonumber(8661),x,y,z,0,0,0);
        end
        local NewPos=GetOffsetFromEntityInWorldCoords(localPlayer,-2,0,-zFix);
        local NewPosLightning=GetOffsetFromEntityInWorldCoords(localPlayer,-1,0,-zFix);
        local NewPos2=GetOffsetFromEntityInWorldCoords(localPlayer,-5,0,-zFix);
        Rot=findRotation(x,y,NewPos.x,NewPos.y);

        setElementPosition(PreviewElement,NewPos.x,NewPos.y,NewPos.z);
        setElementPosition(PreviewElementBG,NewPos2.x,NewPos2.y,NewPos2.z);
        if(PreviewID4)then
            setElementRotation(PreviewElement,0,0,Rot-90);
        else
            setElementRotation(PreviewElement,0,0,Rot);
        end
        setElementRotation(PreviewElementBG,0,90,Rot-90);
        setElementDoubleSided(PreviewElementBG,true);

        setCameraMatrix(x,y,z-zFix-1, NewPos.x,NewPos.y,NewPos.z);
        PreviewLight=createLight(0,NewPosLightning.x,NewPosLightning.y,NewPosLightning.z,20, 200,200,200);


        if(PreviewID2 and PreviewID3)then
            PreviewShader=dxCreateShader(":"..RESOURCE_NAME.."/Files/Textures/Weapons.fx",0,0,true,"object");
            engineApplyShaderToWorldTexture(PreviewShader,WeaponShaderNames[tonumber(PreviewID2)],PreviewElement);

            PreviewTexture=dxCreateTexture(":"..RESOURCE_NAME.."/Files/Textures/Weapons/"..PreviewID2.."/"..tostring(PreviewID3)..".png");
            dxSetShaderValue(PreviewShader,"WeaponSkin",PreviewTexture);
        end
    else
        if(isElement(PreviewElement))then
            destroyElement(PreviewElement);
            PreviewElement=nil;
        end
        if(isElement(PreviewElementBG))then
            destroyElement(PreviewElementBG);
            PreviewElementBG=nil;
        end
        if(isElement(PreviewLight))then
            destroyElement(PreviewLight);
            PreviewLight=nil;
        end
        if(isElement(PreviewShader))then
            destroyElement(PreviewShader);
            PreviewShader=nil;
        end
        setCameraTarget(localPlayer);
    end
end)

addEventHandler("Trader:BuySell:C",root,function(type,item,amount)
    if(not(isLoggedin()))then
		return;
	end
	if(isPedDead(localPlayer))then
		return;
	end
	if(isClickedState(localPlayer)==false)then
        return;
	end
    if(not guiGetVisible(BrowserUI))then
        return;
    end

    triggerServerEvent("Trader:BuySell:S",localPlayer,tostring(type),tostring(item),tonumber(amount));
end)

addEventHandler("onClientPlayerWasted",root,function()
	if(source==localPlayer)then
		if(isElement(BrowserUI))then
			destroyElement(BrowserUI);
			BrowserUI=nil;
			setUIdatas("rem","cursor");
		end
	end
end)