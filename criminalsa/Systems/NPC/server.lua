addRemoteEvents{"Bountyclear:S",};--addEvents


local CurrentDealer={};


local function interactBountyclear(elem)
	if(elem and isElement(elem)and getElementType(elem)=="player" and isLoggedin(elem))then
        if(getPlayerJsonValue(elem,"Stats","Bounty")<=0)then
            triggerClientEvent(elem,"Notify:UI",elem,loc(elem,"S:BountyClear:NoBounty"),"error",5000);
            return;
        end
        if(getElementData(elem,"Player:Data:RobbedAmount"))then
            return;
        end
        triggerClientEvent(elem,"Popup:UI",elem,true,"ClearBounty",loc(elem,"UI:BountyClear:Text"):format(getElementData(root,"BountyClear:Price:"..CurrentDealer[elem])));
        triggerClientEvent(elem,"HelpNotify:UI",elem,nil);
	end
end

addEventHandler("onResourceStart",resourceRoot,function()
    --bounty clear
    for bot,v in pairs(Bots_Bountyclear.Peds)do
        local isCustom,mod,elementType=exports[RESOURCE_NEWMODELS]:isCustomModID(tonumber(Bots_Bountyclear.Peds[bot].Ped[1]));
		if(isCustom)then--check custom skin
			Ped=createPed(mod.base_id,Bots_Bountyclear.Peds[bot].Ped[2],Bots_Bountyclear.Peds[bot].Ped[3],Bots_Bountyclear.Peds[bot].Ped[4],Bots_Bountyclear.Peds[bot].Ped[5]);

			local dataName=exports[RESOURCE_NEWMODELS]:getDataNameFromType(elementType);
			setElementData(Ped,dataName,mod.id);
		else
			Ped=createPed(Bots_Bountyclear.Peds[bot].Ped[1],Bots_Bountyclear.Peds[bot].Ped[2],Bots_Bountyclear.Peds[bot].Ped[3],Bots_Bountyclear.Peds[bot].Ped[4],Bots_Bountyclear.Peds[bot].Ped[5]);

			setElementModel(Ped,tonumber(Bots_Bountyclear.Peds[bot].Ped[1]));
		end
        setElementFrozen(Ped,true);
        setElementData(Ped,"Ped:Data:Godmode",true);

        local x1,y1,z1=getPositionInFrontOfElement(Ped,tonumber(Bots_Bountyclear.Peds[bot].Ped[6]));
        local Marker=createMarker(x1,y1,z1-1,"cylinder",1.3,220,220,0,80);

        local Blip=createBlip(Bots_Bountyclear.Peds[bot].Ped[2],Bots_Bountyclear.Peds[bot].Ped[3],Bots_Bountyclear.Peds[bot].Ped[4],Bots_Bountyclear.Peds[bot].Ped[7],20,80,80,80,255,100);
        setElementData(Blip,"Blip:Data:Tooltip","Bounty clear");

        addEventHandler("onMarkerHit",Marker,function(hitElem,dim)
			if(hitElem and isElement(hitElem)and getElementType(hitElem)=="player" and isLoggedin(hitElem))then
                if(not(isPedInVehicle(hitElem)))then
                    if(getElementInterior(hitElem)==getElementInterior(source)and getElementDimension(hitElem)==getElementDimension(source))then
                        if(not isKeyBound(hitElem,Server.MainInteractionKey,"down",interactBountyclear))then
                            bindKey(hitElem,Server.MainInteractionKey,"down",interactBountyclear);
                        end
                        toggleGhostMode(hitElem,true,9000000);
                        triggerClientEvent(hitElem,"HelpNotify:UI",hitElem,true,Server.MainInteractionKey,loc(hitElem,"UI:HelpNotify:PressToOpen:General"));
                        CurrentDealer[hitElem]=bot;
                    end
                end
            end
        end)
        addEventHandler("onMarkerLeave",Marker,function(hitElem,dim)
			if(hitElem and isElement(hitElem)and getElementType(hitElem)=="player")then
                if(isKeyBound(hitElem,Server.MainInteractionKey,"down",interactBountyclear))then
                    unbindKey(hitElem,Server.MainInteractionKey,"down",interactBountyclear);
                end
                toggleGhostMode(hitElem,false,0);
                triggerClientEvent(hitElem,"HelpNotify:UI",hitElem,nil);
            end
        end)
    end

    for dealer,price in pairs(Bots_Bountyclear.Prices)do
        Price=math.random(price[1],price[2]);
        setElementData(root,"BountyClear:Price:"..dealer,Price);
    end
end)

addEventHandler("Bountyclear:S",root,function(type)
	if(client and isElement(client)and getElementType(client)=="player" and isLoggedin(client))then
        if(type)then
            if(getPlayerJsonValue(client,"Stats","Bounty")<=0)then
                triggerClientEvent(client,"Notify:UI",client,loc(client,"S:BountyClear:NoBounty"),"error",5000);
                triggerClientEvent(client,"Popup:UI",client,false);
                return;
            end

            if(getPlayerJsonValue(client,"Money","Cash")>=tonumber(getElementData(root,"BountyClear:Price:"..CurrentDealer[client])))then
                removePlayerJsonValue(client,"Money","Cash",tonumber(getElementData(root,"BountyClear:Price:"..CurrentDealer[client])));
                setPlayerJsonValue(client,"Stats","Bounty",0);
                triggerClientEvent(client,"Popup:UI",client,false);
            else
                triggerClientEvent(client,"Notify:UI",client,loc(client,"S:BountyClear:NotEnoughCash"):format(getPlayerJsonValue(client,"Money","Cash"),tonumber(getElementData(root,"BountyClear:Price:"..CurrentDealer[client]))),"error",5000);
                triggerClientEvent(client,"Popup:UI",client,false);
            end
        end
	end
end)