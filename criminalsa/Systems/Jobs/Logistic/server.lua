addRemoteEvents{"Job:Logistic:S","Job:Logistic:Bindkey"};--addEvent


local Object={};

local CurrentJob={};


local function interact(elem)
	if(elem and isElement(elem)and getElementType(elem)=="player" and isLoggedin(elem))then
        triggerClientEvent(elem,"Popup:UI",elem,true,"StartJobLogistic",loc(elem,"UI:JobLogistic:Text"));
        triggerClientEvent(elem,"HelpNotify:UI",elem,nil);
	end
end

addEventHandler("onResourceStart",resourceRoot,function()
    for job,v in pairs(Jobs["Logistic"].StartPositions)do
        local isCustom,mod,elementType=exports[RESOURCE_NEWMODELS]:isCustomModID(tonumber(Jobs["Logistic"].StartPositions[job][1]));
		if(isCustom)then--check custom skin
			Ped=createPed(mod.base_id,Jobs["Logistic"].StartPositions[job][2],Jobs["Logistic"].StartPositions[job][3],Jobs["Logistic"].StartPositions[job][4],Jobs["Logistic"].StartPositions[job][5]);

			local dataName=exports[RESOURCE_NEWMODELS]:getDataNameFromType(elementType);
			setElementData(Ped,dataName,mod.id);
		else
			Ped=createPed(Jobs["Logistic"].StartPositions[job][1],Jobs["Logistic"].StartPositions[job][2],Jobs["Logistic"].StartPositions[job][3],Jobs["Logistic"].StartPositions[job][4],Jobs["Logistic"].StartPositions[job][5]);

			setElementModel(Ped,tonumber(Jobs["Logistic"].StartPositions[job][1]));
		end
        setElementFrozen(Ped,true);
        setElementData(Ped,"Ped:Data:Godmode",true);

        local x1,y1,z1=getPositionInFrontOfElement(Ped,tonumber(Jobs["Logistic"].StartPositions[job][6]));
        local Marker=createMarker(x1,y1,z1-1,"cylinder",1.3,220,220,0,80);

        if(Jobs["Logistic"].Blip[job])then
            local Blip=createBlip(Jobs["Logistic"].Blip[job][1],Jobs["Logistic"].Blip[job][2],Jobs["Logistic"].Blip[job][3],Jobs["Logistic"].Blip[job][4],22,Jobs["Logistic"].Blip[job][5],Jobs["Logistic"].Blip[job][6],Jobs["Logistic"].Blip[job][7],255,100);
            setElementData(Blip,"Blip:Data:Tooltip",Jobs["Logistic"].Blip[job][8]);
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
                        CurrentJob[hitElem]=job;

                        if(not(getPlayerNotExistingJsonValue(hitElem,"Levels","JobLogisticLVL")))then--set if element data doesnt exist
                            setPlayerJsonValue(hitElem,"Levels","JobLogisticLVL",1);
                            setPlayerJsonValue(hitElem,"Levels","JobLogisticEXP",0);
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

addEventHandler("Job:Logistic:S",root,function(type)
	if(client and isElement(client)and getElementType(client)=="player" and isLoggedin(client))then
        if(type and type=="Accept")then
            if(not(CurrentJob[client]))then
                return;
            end
            local PlayerJobLevel=(getPlayerJsonValue(client,"Levels","JobLogisticLVL")or 0);

            triggerClientEvent(client,"Popup:UI",client,false);
            if(PlayerJobLevel==1)then
                triggerClientEvent(client,"Job:Logistic:C",client,"start",CurrentJob[client]);
            elseif(PlayerJobLevel==2)then
                triggerClientEvent(client,"Job:Logistic:C",client,"start",CurrentJob[client]);
                triggerClientEvent(client,"Job:Logistic:C",client,"route",CurrentJob[client]);
            end

            if(Jobs["Logistic"].Vehicle[PlayerJobLevel])then
                local isCustom,mod,elementType=exports[RESOURCE_NEWMODELS]:isCustomModID(tonumber(Jobs["Logistic"].Vehicle[PlayerJobLevel][1]));
                if(isCustom)then
                    PLAYER_VEHICLE_JOB[getPlayerName(client)]=createVehicle(mod.base_id,Jobs["Logistic"].Vehicle[PlayerJobLevel][2],Jobs["Logistic"].Vehicle[PlayerJobLevel][3],Jobs["Logistic"].Vehicle[PlayerJobLevel][4],0,0,Jobs["Logistic"].Vehicle[PlayerJobLevel][5], "Logis");
                    local dataName=exports[RESOURCE_NEWMODELS]:getDataNameFromType(elementType);
                    setElementData(PLAYER_VEHICLE_JOB[getPlayerName(client)],dataName,mod.id);
                else
                    PLAYER_VEHICLE_JOB[getPlayerName(client)]=createVehicle(tonumber(Jobs["Logistic"].Vehicle[PlayerJobLevel][1]),Jobs["Logistic"].Vehicle[PlayerJobLevel][2],Jobs["Logistic"].Vehicle[PlayerJobLevel][3],Jobs["Logistic"].Vehicle[PlayerJobLevel][4],0,0,Jobs["Logistic"].Vehicle[PlayerJobLevel][5], "Logis");
                end

                setElementData(PLAYER_VEHICLE_JOB[getPlayerName(client)],"Vehicle:Data:VehID",tonumber(Jobs["Logistic"].Vehicle[PlayerJobLevel][1]));

                warpPedIntoVehicle(client,PLAYER_VEHICLE_JOB[getPlayerName(client)],0);
            end
        elseif(type and type=="reward")then
            logisticGiveReward(client);
        elseif(type and type=="stop")then
            triggerClientEvent(client,"Job:Logistic:C",client,"stop");

            if(isElement(PLAYER_VEHICLE_JOB[getPlayerName(client)]))then
                destroyElement(PLAYER_VEHICLE_JOB[getPlayerName(client)]);
                PLAYER_VEHICLE_JOB[getPlayerName(client)]=nil;
            end
        end
    end
end)

addEventHandler("Job:Logistic:Bindkey",root,function(type,type2)
	if(client and isElement(client)and getElementType(client)=="player" and isLoggedin(client))then
		if(type2=="pickup")then
			if(type)then
				if(not(Object[client]))then
					bindKey(client,Server.MainInteractionKey,"down",logisticPickupBox);
					triggerClientEvent(client,"HelpNotify:UI",client,true,Server.MainInteractionKey,loc(client,"UI:HelpNotify:PressToOpen:General"));
				else
					triggerClientEvent(client,"HelpNotify:UI",client,false,_,_);
				end
			else
				if(isKeyBound(client,Server.MainInteractionKey,"down",logisticPickupBox))then
					unbindKey(client,Server.MainInteractionKey,"down",logisticPickupBox);
				end
				triggerClientEvent(client,"HelpNotify:UI",client,false,_,_);
			end
		elseif(type2=="deliver")then
			if(type)then
				bindKey(client,Server.MainInteractionKey,"down",logisticDeliverBox);
				triggerClientEvent(client,"HelpNotify:UI",client,true,Server.MainInteractionKey,loc(client,"UI:HelpNotify:PressToOpen:General"));
			else
				if(isKeyBound(client,Server.MainInteractionKey,"down",logisticDeliverBox))then
					unbindKey(client,Server.MainInteractionKey,"down",logisticDeliverBox);
				end
				triggerClientEvent(client,"HelpNotify:UI",client,false,_,_);
			end
		end
	end
end)

function logisticPickupBox(player)
	if(player and isElement(player)and getElementType(player)=="player" and isLoggedin(player)and(not client or client==player))then
		if(not(Object[player]))then
			setElementRotation(player,0,0,getElementData(player,"Player:Data:Marker"));
			Object[player]=createObject(2969,0,0,0);
			setElementInterior(Object[player],getElementInterior(player));
			setElementDimension(Object[player],getElementDimension(player));

			setPedAnimation(player,"BOX","boxshup",2500,true,false,false,nil,nil);

			logisticToggle(player,false);

			setTimer(function(player)
				if(player and isElement(player)and isLoggedin(player))then
					setObjectScale(Object[player],0.7);
					attachElements(Object[player],player,0,0.4,0.4);
					setElementCollisionsEnabled(Object[player],false);
					setPedAnimation(player,"CARRY","crry_prtial",50);
					triggerClientEvent(player,"HelpNotify:UI",player,false,_,_);
				end
			end,2500,1,player)
			triggerClientEvent(player,"Job:Logistic:Cooldown:C",player);
			triggerClientEvent(player,"Job:Logistic:C",player,"route",CurrentJob[player]);
		end
	end
end

function logisticDeliverBox(player)
	if(player and isElement(player)and getElementType(player)=="player" and isLoggedin(player)and(not client or client==player))then
		if(Object[player])then
			setElementRotation(player,0,0,getElementData(player,"Player:Data:Marker"));

			destroyElement(Object[player]);
			Object[player]=nil;
			setPedAnimation(player,"BOMBER","BOM_Plant",-1,true,false,false,false);

			setTimer(function(player)
				if(player and isElement(player)and isLoggedin(player))then
					setPedAnimation(player,false);
					triggerClientEvent(player,"HelpNotify:UI",player,false,_,_);
					logisticToggle(player,true);

					logisticGiveReward(player);
				end
			end,1000,1,player)
		end
	end
end

function logisticToggle(player,bool)
	toggleControl(player,"sprint",bool);
	toggleControl(player,"jump",bool);
	toggleControl(player,"aim_weapon",bool);
    toggleControl(player,"next_weapon",bool);
    toggleControl(player,"previous_weapon",bool);
	toggleControl(player,"enter_exit",bool);
	toggleControl(player,"fire",bool);
end

function logisticGiveReward(player)
    if(player and isElement(player)and getElementType(player)=="player" and isLoggedin(player)and(not client or client==player))then
        local PlayerJobLevel=(getPlayerJsonValue(player,"Levels","JobLogisticLVL")or 0);
        local Reward=math.random(Jobs["Logistic"].Reward[PlayerJobLevel][1],Jobs["Logistic"].Reward[PlayerJobLevel][2]);
        triggerClientEvent(player,"Notify:UI",player,loc(player,"S:Job:GotMoney"):format(Reward),"info",4000,true);
        
        --give reward
        addPlayerJsonValue(player,"Money","Cash",tonumber(Reward));
        
        --level
        updateJobLevelstuff(player,"Logistic");
    end
end



local Vehicles={--vehID,x,y,z,rot
	{455, 1734.2,726.1,11.3,0},
	{455, 1720.6,726.1,11.3,0},
	{455, 1706.6,726.1,11.3,0},

	{578, 1585.6,755.1,11.4,90},
	{578, 1585.6,763.1,11.4,90},
}
addEventHandler("onResourceStart",resourceRoot,function()
	for i,v in pairs(Vehicles)do
		Vehicles[i]=createVehicle(v[1],v[2],v[3],v[4],0,0,v[5],"Logis");
		setElementData(Vehicles[i],"IsServerTrain",true);
		setElementData(Vehicles[i],"Vehicle:Data:VehID",v[1]);

		setVehicleColor(Vehicles[i],255,255,255,255,255,255);
        setVehicleLocked(Vehicles[i],true);
        setVehicleDamageProof(Vehicles[i],true);
        setElementFrozen(Vehicles[i],true);
		setVehicleVariant(Vehicles[i],3,255);
	end
end)

local function destroyElementsAfterQuitDead(player)
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