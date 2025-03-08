addRemoteEvents{"Event:Buy:S"};--addEvents


local CurrentEventTrader={};


local function interact(elem)
	if(elem and isElement(elem)and getElementType(elem)=="player" and isLoggedin(elem))then
        if(os.time()>=Server.Settings.Event.Current[2])then
            return;
        end
		triggerClientEvent(elem,"Event:UI",elem,true,CurrentEventTrader[elem]);
        triggerClientEvent(elem,"HelpNotify:UI",elem,nil);
	end
end

addEventHandler("onResourceStart",resourceRoot,function()
    for i,v in pairs(EventStands)do
        if(i==Server.Settings.Event.Current[1]and os.time()<=Server.Settings.Event.Current[2])then
            local isCustom,mod,elementType=exports[RESOURCE_NEWMODELS]:isCustomModID(tonumber(EventStands[i].Ped[1]));
			if(isCustom)then--check custom skin
				Ped=createPed(mod.base_id,EventStands[i].Ped[2],EventStands[i].Ped[3],EventStands[i].Ped[4],EventStands[i].Ped[5]);

				local dataName=exports[RESOURCE_NEWMODELS]:getDataNameFromType(elementType);
				setElementData(Ped,dataName,mod.id);

                if(EventStands[i].Ped2)then
                    Ped2=createPed(mod.base_id,EventStands[i].Ped2[2],EventStands[i].Ped2[3],EventStands[i].Ped2[4],EventStands[i].Ped2[5]);

                    local dataName=exports[RESOURCE_NEWMODELS]:getDataNameFromType(elementType);
                    setElementData(Ped2,dataName,mod.id);
                end
			else
				Ped=createPed(EventStands[i].Ped[1],EventStands[i].Ped[2],EventStands[i].Ped[3],EventStands[i].Ped[4],EventStands[i].Ped[5]);

				setElementModel(Ped,tonumber(EventStands[i].Ped[1]));

                if(EventStands[i].Ped2)then
                    Ped2=createPed(EventStands[i].Ped2[1],EventStands[i].Ped2[2],EventStands[i].Ped2[3],EventStands[i].Ped2[4],EventStands[i].Ped2[5]);

				    setElementModel(Ped2,tonumber(EventStands[i].Ped2[1]));
                end
			end
            setElementFrozen(Ped,true);
            setElementData(Ped,"Ped:Data:Godmode",true);
            setElementData(Ped,"Ped:Data:Title",EventStands[i].Ped[6]);
            if(Ped2)then
                setElementFrozen(Ped2,true);
                setElementData(Ped2,"Ped:Data:Godmode",true);
                setElementData(Ped2,"Ped:Data:Title",EventStands[i].Ped[6]);
            end

            if(Ped2)then
                local x1,y1,z1=getPositionInFrontOfElement(Ped2,tonumber(1.5));
                local Marker=createMarker(x1,y1,z1-1,"cylinder",1.3,0,240,255,80);

                addEventHandler("onMarkerHit",Marker,function(hitElem,dim)
                    if(hitElem and isElement(hitElem)and getElementType(hitElem)=="player" and isLoggedin(hitElem))then
                        if(not(isPedInVehicle(hitElem)))then
                            if(getElementInterior(hitElem)==getElementInterior(source)and getElementDimension(hitElem)==getElementDimension(source))then
                                if(os.time()>=Server.Settings.Event.Current[2])then
                                    return;
                                end
                                if(not isKeyBound(hitElem,Server.MainInteractionKey,"down",interact))then
                                    bindKey(hitElem,Server.MainInteractionKey,"down",interact);
                                end
                                toggleGhostMode(hitElem,true,9000000);
                                triggerClientEvent(hitElem,"HelpNotify:UI",hitElem,true,Server.MainInteractionKey,loc(hitElem,"UI:HelpNotify:PressToOpen:General"));
                                CurrentEventTrader[hitElem]=i;
                            end
                        end
                    end
                end)
                addEventHandler("onMarkerLeave",Marker,function(hitElem,dim)
                    if(hitElem and isElement(hitElem)and getElementType(hitElem)=="player")then
                        if(isKeyBound(hitElem,Server.MainInteractionKey,"down",interact))then
                            unbindKey(hitElem,Server.MainInteractionKey,"down",interact);
                        end
                        toggleGhostMode(hitElem,false,0);
                        triggerClientEvent(hitElem,"HelpNotify:UI",hitElem,nil);
                    end
                end)
            end

            if(EventStands[i].Blip)then
                local Blip=createBlip(EventStands[i].Blip[1],EventStands[i].Blip[2],EventStands[i].Blip[3],EventStands[i].Blip[4],22,EventStands[i].Blip[5],EventStands[i].Blip[6],EventStands[i].Blip[7],255,100);
                setElementData(Blip,"Blip:Data:Tooltip",EventStands[i].Blip[8]);
            end

            local x1,y1,z1=getPositionInFrontOfElement(Ped,tonumber(1.5));
            local Marker=createMarker(x1,y1,z1-1,"cylinder",1.3,0,240,255,80);
            addEventHandler("onMarkerHit",Marker,function(hitElem,dim)
                if(hitElem and isElement(hitElem)and getElementType(hitElem)=="player" and isLoggedin(hitElem))then
                    if(not(isPedInVehicle(hitElem)))then
                        if(getElementInterior(hitElem)==getElementInterior(source)and getElementDimension(hitElem)==getElementDimension(source))then
                            if(os.time()>=Server.Settings.Event.Current[2])then
                                return;
                            end
                            if(not isKeyBound(hitElem,Server.MainInteractionKey,"down",interact))then
                                bindKey(hitElem,Server.MainInteractionKey,"down",interact);
                            end
                            toggleGhostMode(hitElem,true,9000000);
                            triggerClientEvent(hitElem,"HelpNotify:UI",hitElem,true,Server.MainInteractionKey,loc(hitElem,"UI:HelpNotify:PressToOpen:General"));
                            CurrentEventTrader[hitElem]=i;
                        end
                    end
                end
            end)
            addEventHandler("onMarkerLeave",Marker,function(hitElem,dim)
                if(hitElem and isElement(hitElem)and getElementType(hitElem)=="player")then
                    if(isKeyBound(hitElem,Server.MainInteractionKey,"down",interact))then
                        unbindKey(hitElem,Server.MainInteractionKey,"down",interact);
                    end
                    toggleGhostMode(hitElem,false,0);
                    triggerClientEvent(hitElem,"HelpNotify:UI",hitElem,nil);
                end
            end)
        end
        for item,price in pairs(EventSettings.Prices)do
            Price=math.random(price[1],price[2]);
            setElementData(root,"EventTrader:Price:"..item,Price);
        end
    end
end)


addEventHandler("Event:Buy:S",root,function(item)
    if(client and isElement(client)and getElementType(client)=="player" and isLoggedin(client))then
        if(not(item))then
            return;
        end
        if(not(CurrentEventTrader[client]))then
            return;
        end
        if(os.time()>=Server.Settings.Event.Current[2])then
            return;
        end

        if(getPlayerJsonValue(client,"Points",tostring(Server.Settings.Event.Datas[Server.Settings.Event.Current[1]]))>=getElementData(root,"EventTrader:Price:"..item))then
            if(item:find("Vehicle_"))then
                local VehicleID=item:gsub("Vehicle_","");

                giveVehicleToPlayer(client,tonumber(VehicleID));

                removePlayerJsonValue(client,"Points",tostring(Server.Settings.Event.Datas[Server.Settings.Event.Current[1]]),getElementData(root,"EventTrader:Price:"..item));
                triggerClientEvent(client,"Notify:UI",client,loc(client,"S:EventTrader:BoughtItem"):format(loc(client,"Item:"..item),getElementData(root,"EventTrader:Price:"..item)),"success",5000);
            else
                if(Items[tostring(item)].MaxAmount and getPlayerJsonValue(client,"Items",tostring(item))>Items[tostring(item)].MaxAmount)then
                    triggerClientEvent(client,"Notify:UI",client,loc(client,"S:EventTrader:MaxAmount"):format(loc(client,"Item:"..item),Items[tostring(item)].MaxAmount),"error",5000);
                    return;
                end

                addPlayerJsonValue(client,"Items",tostring(item),1);
                removePlayerJsonValue(client,"Points",tostring(Server.Settings.Event.Datas[Server.Settings.Event.Current[1]]),getElementData(root,"EventTrader:Price:"..item));
                triggerClientEvent(client,"Notify:UI",client,loc(client,"S:EventTrader:BoughtItem"):format(loc(client,"Item:"..item),getElementData(root,"EventTrader:Price:"..item)),"success",5000);
            end
        else
            triggerClientEvent(client,"Notify:UI",client,loc(client,"S:EventTrader:NotEnoughCash"):format(getPlayerJsonValue(client,"Points",tostring(Server.Settings.Event.Datas[Server.Settings.Event.Current[1]])),getElementData(root,"EventTrader:Price:"..item)),"error",5000);
        end
    end
end)