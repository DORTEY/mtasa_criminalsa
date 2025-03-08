addRemoteEvents{"Event:UI","Event:Buy:C"};--addEvents


local CurrentEventTrader=nil;


addEventHandler("Event:UI",root,function(type,event)
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
        guiSetVisible(BrowserEvent,true);

        executeBrowserJavascript(getBrowserEvent,"$('.SecondUIList-Item').empty();");

        CurrentEventTrader=event;

        executeBrowserJavascript(getBrowserEvent,"setLanguageEvent('"..Server.Name.."','"..loc(localPlayer,"UI:EventTrader:Title").."');");
        setTimer(function()
            for _,v in pairs(EventStands[tostring(event)].Items)do
                if(SERVER_TIME<=Server.Settings.Event.Current[2])then
                    LimitedTime=Server.Settings.Event.Current[2]and Server.Settings.Event.Current[2]-SERVER_TIME or 0;
                    executeBrowserJavascript(getBrowserEvent,"loadEventstandItems('"..v.Item.."','"..loc(localPlayer,"Item:"..tostring(v.Item)).."','"..comma_value(getElementData(root,"EventTrader:Price:"..tostring(v.Item))).."','"..loc(localPlayer,"UI:EventTrader:Buy").."','"..LimitedTime.."')");
                else
                    executeBrowserJavascript(getBrowserEvent,"loadEventstandItems('"..v.Item.."','"..loc(localPlayer,"Item:"..tostring(v.Item)).."','"..comma_value(getElementData(root,"EventTrader:Price:"..tostring(v.Item))).."','"..loc(localPlayer,"UI:EventTrader:Buy").."')");
                end
            end
        end,250,1);
	else
		setUIdatas("rem","cursor");
        guiSetVisible(BrowserEvent,false);

        executeBrowserJavascript(getBrowserEvent,"$('.SecondUIList-Item').empty();");
	end
end)

addEventHandler("Event:Buy:C",root,function(item)
    if(not(isLoggedin()))then
		return;
	end
	if(isPedDead(localPlayer))then
		return;
	end
	if(isClickedState(localPlayer)==false)then
        return;
	end
    if(not guiGetVisible(BrowserEvent))then
        return;
    end

    triggerServerEvent("Event:Buy:S",localPlayer,tostring(item));
end)