addRemoteEvents{"Notify:UI"};--addEvents


local Sound=nil;
local function triggerNotify(text,type,time,sound)
    if(isMTAWindowFocused())then
        executeBrowserJavascript(BrowserNotify,[[
            showNotify(']]..text..[[',']]..type..[[',']]..time..[[');
        ]]);

        if(not(sound))then
            if(isElement(Sound))then
                destroyElement(Sound);
                Sound=nil;
            end
            if(fileExists(":"..RESOURCE_NAME.."/Files/Audio/Infobox/"..type..".mp3"))then
                Sound=playSound(":"..RESOURCE_NAME.."/Files/Audio/Infobox/"..type..".mp3");
                setSoundVolume(Sound,0.5);
            end
        end
    else
        if(getPlayerNotExistingJsonValue(localPlayer,"Settings","WindowsNotifications"))then
            local WindowsNotification=getPlayerJsonValue(localPlayer,"Settings","WindowsNotifications");
            if(WindowsNotification==1)then
                if(type=="success")then
                    createTrayNotification(text,"default",true);
                else
                    createTrayNotification(text,type,true);
                end
            end
        end
    end
end
addEventHandler("Notify:UI",root,function(text,type,time,sound)
    triggerNotify(text,type,time,sound);
end)

--Create Notify UI when download is completed (needs to be loaded before other ui's)
addEventHandler("onClientResourceStart_Custom",resourceRoot,function()
	if(not(BrowserNotify))then
        BrowserNotify=createBrowser(GLOBALscreenX,GLOBALscreenY,true,true);

        addEventHandler("onClientBrowserCreated",BrowserNotify,function()
            loadBrowserURL(BrowserNotify,"http://mta/local/Files/UI/Notify/main.html");

            addEventHandler("onClientBrowserDocumentReady",BrowserNotify,function()
                executeBrowserJavascript(BrowserNotify,[[
                    showNotify('','','0','0');
                ]]);
            end)
        end)

        addEventHandler("onClientRender",root,function()
            dxDrawImage(0,0,GLOBALscreenX,GLOBALscreenY,BrowserNotify,0,0,0,tocolor(255,255,255,255),true);
        end)
    end
end)