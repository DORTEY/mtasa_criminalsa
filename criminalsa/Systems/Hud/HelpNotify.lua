addRemoteEvents{"HelpNotify:UI"};--addEvents


local CEFTimer,BrowserUI,Browser=nil,nil,nil;


addEventHandler("HelpNotify:UI",root,function(type,key,text)
	if(not(isLoggedin()))then
		return;
	end
	if(isPedDead(localPlayer))then
		return;
	end
    if(not(CEFready))then
        return;
    end

    if(type)then--appear
        if(not(isTimer(CEFTimer)))then
            BrowserUI=guiCreateBrowser(0,0,GLOBALscreenX,GLOBALscreenY,true,true,false,nil);
            Browser=guiGetBrowser(BrowserUI);

            addEventHandler("onClientBrowserCreated",Browser,function()
                loadBrowserURL(Browser,"http://mta/local/Files/UI/HelpNotify/main.html");
                focusBrowser(Browser);

                addEventHandler("onClientBrowserDocumentReady",BrowserUI,function(url)
                    executeBrowserJavascript(Browser,[[
                        openHelpNotify('true',']]..key..[[',']]..text..[[');
                    ]]);
                end)
            end)
        else
            if(isTimer(CEFTimer))then
                killTimer(CEFTimer);
                CEFTimer=nil;
            end
            if(isElement(BrowserUI))then
                guiSetVisible(BrowserUI,true);

                executeBrowserJavascript(Browser,[[
                    openHelpNotify('true',']]..key..[[',']]..text..[[');
                ]]);
            end
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
        end,15*1000,1)
        if(isElement(BrowserUI)and guiGetVisible(BrowserUI))then
            guiSetVisible(BrowserUI,false);
        end
    end
end)
addEventHandler("onClientPlayerWasted",root,function()
	if(source==localPlayer)then
        if(isTimer(CEFTimer))then
            killTimer(CEFTimer);
            CEFTimer=nil;
        end
        if(isElement(BrowserUI)and guiGetVisible(BrowserUI))then
            guiSetVisible(BrowserUI,false);

            if(isElement(BrowserUI))then
                destroyElement(BrowserUI);
                BrowserUI=nil;
            end
        end
	end
end)