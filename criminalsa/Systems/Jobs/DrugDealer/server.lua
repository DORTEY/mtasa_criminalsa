addRemoteEvents{"Job:DrugDealer:S"};--addEvent


local JobTimer={};

local CurrentDealer={};


local function interact(elem)
	if(elem and isElement(elem)and getElementType(elem)=="player" and isLoggedin(elem))then
        triggerClientEvent(elem,"Popup:UI",elem,true,"StartJobDrugDealer",loc(elem,"UI:JobDrugDealer:Text"));
        triggerClientEvent(elem,"HelpNotify:UI",elem,nil);
	end
end

addEventHandler("onResourceStart",resourceRoot,function()
    for dealer,v in pairs(Jobs["DrugDealer"].StartPositions)do
        local isCustom,mod,elementType=exports[RESOURCE_NEWMODELS]:isCustomModID(tonumber(Jobs["DrugDealer"].StartPositions[dealer][1]));
		if(isCustom)then--check custom skin
			Ped=createPed(mod.base_id,Jobs["DrugDealer"].StartPositions[dealer][2],Jobs["DrugDealer"].StartPositions[dealer][3],Jobs["DrugDealer"].StartPositions[dealer][4],Jobs["DrugDealer"].StartPositions[dealer][5]);

			local dataName=exports[RESOURCE_NEWMODELS]:getDataNameFromType(elementType);
			setElementData(Ped,dataName,mod.id);
		else
			Ped=createPed(Jobs["DrugDealer"].StartPositions[dealer][1],Jobs["DrugDealer"].StartPositions[dealer][2],Jobs["DrugDealer"].StartPositions[dealer][3],Jobs["DrugDealer"].StartPositions[dealer][4],Jobs["DrugDealer"].StartPositions[dealer][5]);

			setElementModel(Ped,tonumber(Jobs["DrugDealer"].StartPositions[dealer][1]));
		end
        setElementFrozen(Ped,true);
        setElementData(Ped,"Ped:Data:Godmode",true);

        local x1,y1,z1=getPositionInFrontOfElement(Ped,tonumber(Jobs["DrugDealer"].StartPositions[dealer][6]));
        local Marker=createMarker(x1,y1,z1-1,"cylinder",1.3,220,220,0,80);

        if(Jobs["DrugDealer"].Blip[dealer])then
            local Blip=createBlip(Jobs["DrugDealer"].Blip[dealer][1],Jobs["DrugDealer"].Blip[dealer][2],Jobs["DrugDealer"].Blip[dealer][3],Jobs["DrugDealer"].Blip[dealer][4],22,Jobs["DrugDealer"].Blip[dealer][5],Jobs["DrugDealer"].Blip[dealer][6],Jobs["DrugDealer"].Blip[dealer][7],255,100);
            setElementData(Blip,"Blip:Data:Tooltip",Jobs["DrugDealer"].Blip[dealer][8]);
        end

        addEventHandler("onMarkerHit",Marker,function(hitElem,dim)
			if(hitElem and isElement(hitElem)and getElementType(hitElem)=="player" and isLoggedin(hitElem))then
                if(not(isPedInVehicle(hitElem)))then
                    if(getElementInterior(hitElem)==getElementInterior(source)and getElementDimension(hitElem)==getElementDimension(source))then
                        if(not isKeyBound(hitElem,Server.MainInteractionKey,"down",interact))then
                            bindKey(hitElem,Server.MainInteractionKey,"down",interact);
                        end
                        toggleGhostMode(hitElem,true,9000000);
                        triggerClientEvent(hitElem,"HelpNotify:UI",hitElem,true,Server.MainInteractionKey,loc(hitElem,"UI:HelpNotify:PressToOpen:General"));
                        CurrentDealer[hitElem]=dealer;

                        if(not(getPlayerNotExistingJsonValue(hitElem,"Levels","JobDrugDealerLVL")))then--set if element data doesnt exist
                            setPlayerJsonValue(hitElem,"Levels","JobDrugDealerLVL",1);
                            setPlayerJsonValue(hitElem,"Levels","JobDrugDealerEXP",0);
                        end
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
end)

addEventHandler("Job:DrugDealer:S",root,function(type,done)
	if(client and isElement(client)and getElementType(client)=="player" and isLoggedin(client))then
        if(type and type=="Accept")then
            triggerClientEvent(client,"Job:DrugDealer:C",client,CurrentDealer[client]);
            triggerClientEvent(client,"Popup:UI",client,false);
        else
            setElementFrozen(client,true);
            setPedAnimation(client,"BOX","boxhipin",2500,true,false,false,nil,nil);
            toggleAllControls(client,false);

            JobTimer[client]=setTimer(function(client)
                if(isElement(client))then
                    setPedAnimation(client);
                    setElementFrozen(client,false);
                    toggleAllControls(client,true);

                    if(not done)then
                        local Level=(getPlayerJsonValue(client,"Levels","JobDrugDealerLVL")or 0);
                        local Reward=math.random(Jobs["DrugDealer"].Drops[Level][1],Jobs["DrugDealer"].Drops[Level][2]);
                        triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Job:GotItem"):format(loc(client,"Item:Cannabis"),Reward),"info",4000,true);
                
                        --give reward
                        addPlayerJsonValue(client,"Items","Cannabis",tonumber(Reward));
                
                        --level
                        updateJobLevelstuff(client,"DrugDealer");
                    end

                    if(done)then--if route is done
                        local Level=(getPlayerJsonValue(client,"Levels","JobDrugDealerLVL")or 0);
                        if(math.random(0,100)<=Jobs["DrugDealer"].BonusDrops[Level].Chance+(getPlayerJsonValue(client,"Booster","ItemBoosterPercentage")or 0))then--chance
                            local Reward=math.random(Jobs["DrugDealer"].BonusDrops[Level][1],Jobs["DrugDealer"].BonusDrops[Level][2]);
                            triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Job:GotBonusItem"):format(loc(client,"Item:Cannabis"),Reward),"info",4000,true);
                
                            --give reward
                            addPlayerJsonValue(client,"Items","Cannabis",tonumber(Reward));
                        end
                    end
                end
            end,2500,1,client)
        end
	end
end)

local function destroyElementsAfterQuitDead(player)
    if(isTimer(JobTimer[player]))then
        killTimer(JobTimer[player]);
        JobTimer[player]=nil;
    end

    if(player and isElement(player))then
        if(isKeyBound(player,Server.MainInteractionKey,"down",interact))then
            unbindKey(player,Server.MainInteractionKey,"down",interact);
            toggleControl(player,"next_weapon",true);
            toggleControl(player,"previous_weapon",true);
            triggerClientEvent(player,"HelpNotify:UI",player,nil);
        end
    end
end

addEventHandler("onPlayerQuit",root,function()
	destroyElementsAfterQuitDead(source);
end)
addEventHandler("onPlayerWasted",root,function()
	destroyElementsAfterQuitDead(source);
end)