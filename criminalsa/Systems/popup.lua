addRemoteEvents{"Popup:UI","Popup:Function"};--addEvent


local BrowserUI=nil;
local Browser=nil;
local FuncEvents={
    ["SellVehicle"]="Sell:Vehicle",
    ["ClearBounty"]="Bountyclear:S",
    ["StartJobDrugDealer"]="Job:DrugDealer:S",
    ["StartJobLogistic"]="Job:Logistic:S",
};


addEventHandler("Popup:UI",root,function(type,type2,text)
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
        setUIdatas("set","cursor");
        guiSetInputMode("no_binds");
		guiSetInputMode("no_binds_when_editing");

		BrowserUI=guiCreateBrowser(0,0,GLOBALscreenX,GLOBALscreenY,true,true,false,nil);
		Browser=guiGetBrowser(BrowserUI);

		addEventHandler("onClientBrowserCreated",Browser,function()
			loadBrowserURL(Browser,"http://mta/local/Files/UI/Popup/main.html");
			focusBrowser(Browser);

			addEventHandler("onClientBrowserDocumentReady",BrowserUI,function(url)
				executeBrowserJavascript(Browser,"$('.Title-Title').html('<span>"..Server.Name.."</span>');");
				executeBrowserJavascript(Browser,"popupUI('"..type2.."','"..loc(localPlayer,"UI:Popup:Accept").."','"..loc(localPlayer,"UI:Popup:Decline").."','"..text.."');");
			end)
		end)

	else
		if(isElement(BrowserUI))then
			destroyElement(BrowserUI);
			BrowserUI=nil;
			setUIdatas("rem","cursor");
		end
	end
end)

addEventHandler("Popup:Function",root,function(func,option)
    if(not(isLoggedin()))then
		return;
	end
	if(isPedDead(localPlayer))then
		return;
	end
	if(isClickedState(localPlayer)==false)then
        return;
	end

    if(func and option and FuncEvents[tostring(func)])then
		if(option=="Accept")then
			triggerServerEvent(tostring(FuncEvents[tostring(func)]),localPlayer,tostring(option));

			if(func=="SellVehicle")then
				triggerServerEvent("Load:Garage:Vehicles:S",localPlayer);
			end
		end
    end

	if(option=="Decline")then
		if(isElement(BrowserUI))then
			destroyElement(BrowserUI);
			BrowserUI=nil;
			setUIdatas("rem","cursor");
		end
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