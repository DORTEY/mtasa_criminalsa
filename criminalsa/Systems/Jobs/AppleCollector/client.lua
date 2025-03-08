addRemoteEvents{"Job:AppleCollector:UI"};--addEvent


local Count,JobItem=0,"Apple";

local CEFTimer,BrowserUI,Browser=nil,nil,nil;


addEventHandler("Job:AppleCollector:UI",root,function(type,amountGot)
    if(not(isLoggedin()))then
		return;
	end
	if(isPedDead(localPlayer))then
		return;
	end

    local PlayerJobLevel=tonumber(getPlayerJsonValue(localPlayer,"Levels","JobAppleCollectorLVL"))or 1;

    if(type and type~="nil")then--appear
        if(isClickedState(localPlayer)==true)then
            return;
        end

        setUIdatas("set","cursor");
        if(not(isTimer(CEFTimer)))then
            BrowserUI=guiCreateBrowser(0,0,GLOBALscreenX,GLOBALscreenY,true,true,false,nil);
            Browser=guiGetBrowser(BrowserUI);

            addEventHandler("onClientBrowserCreated",Browser,function()
                loadBrowserURL(Browser,"http://mta/local/Files/UI/Collector/main.html");
                focusBrowser(Browser);

                addEventHandler("onClientBrowserDocumentReady",BrowserUI,function(url)
                    if(Count==0)then
                        Count=math.random(Jobs["AppleCollector"].Drops[PlayerJobLevel][1],Jobs["AppleCollector"].Drops[PlayerJobLevel][2]);
                    end

                    executeBrowserJavascript(Browser,[[
                        fillJobCollectorItems(']]..JobItem..[[',']]..Count..[[');
                    ]]);
                end)
            end)
        else
            if(isTimer(CEFTimer))then
                killTimer(CEFTimer);
                CEFTimer=nil;
            end
            guiSetVisible(BrowserUI,true);

            if(Count==0)then
                Count=math.random(Jobs["AppleCollector"].Drops[PlayerJobLevel][1],Jobs["AppleCollector"].Drops[PlayerJobLevel][2]);
            end
    
            executeBrowserJavascript(Browser,[[
                fillJobCollectorItems(']]..JobItem..[[',']]..Count..[[');
            ]]);
        end
    else--disappear
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

        Count=0;
        
        triggerServerEvent("Job:AppleCollector:S",localPlayer,tonumber(amountGot));
    end
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