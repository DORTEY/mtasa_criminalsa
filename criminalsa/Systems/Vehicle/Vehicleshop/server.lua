addRemoteEvents{"Vehicleshop:BuyTest:S"};--addEvents


local CurrentCarhouse={};
local AbleToBuy={};
local AbleToBuy2={};
local AbleToBuy3={};

local ShopPrice={};
local UsedCoupon={};


local function interact(elem)
	if(elem and isElement(elem)and getElementType(elem)=="player" and isLoggedin(elem))then
		triggerClientEvent(elem,"Vehicleshop:UI",elem,true,CurrentCarhouse[elem],os.time());
        triggerClientEvent(elem,"HelpNotify:UI",elem,nil);
	end
end

addEventHandler("onResourceStart",resourceRoot,function()
	for i,v in ipairs(Vehicle.Carhouse.Marker)do
		local Marker=createMarker(v[1],v[2],v[3],v[4],v[5],v[6],v[7],v[8],v[9]);

        local Blip=createBlip(v[1],v[2],v[3],v[11],22,v[12],v[13],v[14],255,100);
        setElementData(Blip,"Blip:Data:Tooltip",v[15]);

        addEventHandler("onMarkerHit",Marker,function(hitElem,dim)
			if(hitElem and isElement(hitElem)and getElementType(hitElem)=="player" and isLoggedin(hitElem))then
                if(not(isPedInVehicle(hitElem)))then
                    if(getElementInterior(hitElem)==getElementInterior(source)and getElementDimension(hitElem)==getElementDimension(source))then
                        if(not isKeyBound(hitElem,Server.MainInteractionKey,"down",interact))then
                            bindKey(hitElem,Server.MainInteractionKey,"down",interact);
                        end
                        toggleGhostMode(hitElem,true,9000000);
                        triggerClientEvent(hitElem,"HelpNotify:UI",hitElem,true,Server.MainInteractionKey,loc(hitElem,"UI:HelpNotify:PressToOpen:General"));
                        CurrentCarhouse[hitElem]=v[10];
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





addEventHandler("Vehicleshop:BuyTest:S",root,function(type,id,coupon,color)
    if(client and isElement(client)and getElementType(client)=="player" and isLoggedin(client))then
        if(not(type))then
            return;
        end
        if(not(id))then
            return;
        end
        if(isPedDead(client))then
            return;
        end
        if(PLAYER_VEHICLE_TESTDRIVE[client])then
            return;
        end

        local Owner=getPlayerName(client);

        if(type=="buy")then
            AbleToBuy[client]=false;
            AbleToBuy2[client]=true;
            AbleToBuy3[client]=true;
            UsedCoupon[client]=false;
            
            local result=dbPoll(dbQuery(Database.Connection,"SELECT * FROM ?? WHERE ??=?","Vehicles","Username",Owner),-1);
            if(#result>=#Hideout.Garage.GaragePositions[tonumber(getPlayerJsonValue(client,"HideUpgrades","Garage"))])then
                triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Vehicle:SlotsReached"),"error",4000);
                return;
            end



            if(coupon~="none")then
                if(getPlayerJsonValue(client,"Items",tostring(coupon))>0)then
                    AbleToBuy3[client]=true;
                    UsedCoupon[client]=true;
                    ShopPrice[client]=Vehicle.Prices[tonumber(id)]-Vehicle.Prices[tonumber(id)]/100*tonumber(Items[tostring(coupon)].Percentage);
                else
                    AbleToBuy3[client]=false;
                    UsedCoupon[client]=false;
                    ShopPrice[client]=Vehicle.Prices[tonumber(id)];
                end
            else
                AbleToBuy3[client]=true;
                UsedCoupon[client]=false;
                ShopPrice[client]=Vehicle.Prices[tonumber(id)];
            end

            if(getPlayerJsonValue(client,"Money","Cash")<ShopPrice[client])then
                triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Vehicle:NotEnoughMoney"):format(getPlayerJsonValue(client,"Money","Cash"),ShopPrice[client]),"error",4000);
                return;
            end

            if(Vehicle.Carhouse.LimitedVehicles[tonumber(id)])then
                for i,time in pairs(Vehicle.Carhouse.LimitedVehicles)do
                    if(i==tonumber(id))then
                        if(os.time()<=tonumber(time))then
                            AbleToBuy[client]=true;
                        end
                    end
                end
            else
                AbleToBuy[client]=true;
            end

            if(Vehicle.Carhouse.Requirement[tonumber(id)])then
                for requirementStation,requiredLevel in pairs(Vehicle.Carhouse.Requirement[tonumber(id)])do
                    local stationLevel=tonumber(getPlayerJsonValue(client,"HideUpgrades",tostring(requirementStation)));
            
                    if(stationLevel>=requiredLevel)then else AbleToBuy2[client]=false;end
                end
            else
                AbleToBuy2[client]=true;
            end




            if(AbleToBuy[client])then
                if(AbleToBuy2[client])then
                    if(AbleToBuy3[client])then
                        local IDcounter=dbPoll(dbQuery(Database.Connection,"SELECT ?? FROM ?? WHERE Vehicles=Vehicles","Vehicles","Counter"),-1)[1]["Vehicles"];
                        dbExec(Database.Connection,"UPDATE ?? SET ??=?","Counter","Vehicles",IDcounter+1);

                        ResultPlate=generateVehiclePlate();

                        local isCustom,mod,elementType=exports[RESOURCE_NEWMODELS]:isCustomModID(tonumber(id));
                        if(isCustom)then
                            DriveType=getOriginalHandling(tonumber(mod.base_id))["driveType"];
                        else
                            DriveType=getOriginalHandling(tonumber(id))["driveType"];
                        end

                        dbExec(Database.Connection,"INSERT INTO ?? (ID,Username,VehID,Plate,Color,LightColor,Tunings) VALUES (?,?,?,?,?,?,?)","Vehicles",IDcounter,Owner,tonumber(id),ResultPlate,toJSON(color),toJSON({255,255,255,255,255,255}),'[ { "Paintjob": 9999999, "DriveType": "'..DriveType..'" } ]');

                        triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Vehicle:Bought"):format(returnVehicleName(id)),"success",7000);
                        triggerClientEvent(client,"Vehicleshop:UI",client,false);
                        removePlayerJsonValue(client,"Money","Cash",tonumber(ShopPrice[client]));
                        addAchievement(client,"buyfirstvehicle");
                        if(UsedCoupon[client])then
                            removePlayerJsonValue(client,"Items",tostring(coupon),1);
                        end

                        --logs
                        if(UsedCoupon[client])then
                            sendDiscordMessage({
                                ID=6, Title="Vehicle purchase", Desc=getPlayerName(client).." has bought a '"..returnVehicleName(id).."' for "..ShopPrice[client].." with a coupon ("..coupon..").",
                                PlayerData={Name=getPlayerName(client),Serial=getPlayerSerial(client),},
                            })
                        else
                            sendDiscordMessage({
                                ID=6, Title="Vehicle purchase", Desc=getPlayerName(client).." has bought a '"..returnVehicleName(id).."' for "..ShopPrice[client]..".",
                                PlayerData={Name=getPlayerName(client),Serial=getPlayerSerial(client),},
                            })
                        end
                    end
                else
                    triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Vehicle:CantBuy"),"warning",10000);
                end
            else
                triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Vehicle:LimitedVehicleExpired"),"warning",5000);
            end
        else
            local rdmDim=math.random(3000,4000);
            


            local isCustom,mod,elementType=exports[RESOURCE_NEWMODELS]:isCustomModID(tonumber(id));
            if(isCustom)then
                PLAYER_VEHICLE_TESTDRIVE[client]=createVehicle(mod.base_id,Vehicle.Carhouse.SpawnPositions[CurrentCarhouse[client]][1],Vehicle.Carhouse.SpawnPositions[CurrentCarhouse[client]][2],Vehicle.Carhouse.SpawnPositions[CurrentCarhouse[client]][3],0,0,Vehicle.Carhouse.SpawnPositions[CurrentCarhouse[client]][4],"TESTDRIVE");
                local dataName=exports[RESOURCE_NEWMODELS]:getDataNameFromType(elementType);
                setElementData(PLAYER_VEHICLE_TESTDRIVE[client],dataName,mod.id);
            else
                PLAYER_VEHICLE_TESTDRIVE[client]=createVehicle(tonumber(id),Vehicle.Carhouse.SpawnPositions[CurrentCarhouse[client]][1],Vehicle.Carhouse.SpawnPositions[CurrentCarhouse[client]][2],Vehicle.Carhouse.SpawnPositions[CurrentCarhouse[client]][3],0,0,Vehicle.Carhouse.SpawnPositions[CurrentCarhouse[client]][4],"TESTDRIVE");
            end

            setElementDimension(client,rdmDim);
			setElementDimension(PLAYER_VEHICLE_TESTDRIVE[client],rdmDim);
            setVehicleColor(PLAYER_VEHICLE_TESTDRIVE[client],255,255,255,255,255,255);
            setVehicleDamageProof(PLAYER_VEHICLE_TESTDRIVE[client],true);
            setVehicleColor(PLAYER_VEHICLE_TESTDRIVE[client],toJSON(color)[1],toJSON(color)[2],toJSON(color)[3],toJSON(color)[4],toJSON(color)[5],toJSON(color)[6]);

            setElementData(PLAYER_VEHICLE_TESTDRIVE[client],"Vehicle:Data:ID",0);
            setElementData(PLAYER_VEHICLE_TESTDRIVE[client],"Vehicle:Data:VehID",tonumber(id));
            setElementData(PLAYER_VEHICLE_TESTDRIVE[client],"Vehicle:Data:Owner",Owner);
            setElementData(PLAYER_VEHICLE_TESTDRIVE[client],"Vehicle:Data:Type","Testrive");
            setElementData(PLAYER_VEHICLE_TESTDRIVE[client],"Tunings","{}");

            warpPedIntoVehicle(client,PLAYER_VEHICLE_TESTDRIVE[client],0);
            triggerClientEvent(client,"Vehicleshop:UI",client,false);
            

            PLAYER_VEHICLE_TESTDRIVE_TIMER[client]=setTimer(function(client)
                destroyElement(PLAYER_VEHICLE_TESTDRIVE[client]);
                PLAYER_VEHICLE_TESTDRIVE[client]=nil;

                if(isElement(client)and isLoggedin(client))then
                    setElementPosition(client,Vehicle.Carhouse.SpawnPositions[CurrentCarhouse[client]][5],Vehicle.Carhouse.SpawnPositions[CurrentCarhouse[client]][6],Vehicle.Carhouse.SpawnPositions[CurrentCarhouse[client]][7]);

                    setElementDimension(client,0);
                    triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Vehicle:TestdriveStopped"),"info",3000);
                    CurrentCarhouse[client]=nil;
                end
            end,5*60*1000,1,client)

            addEventHandler("onVehicleExit",PLAYER_VEHICLE_TESTDRIVE[client],function(player)
                destroyElement(source);
                setElementPosition(player,Vehicle.Carhouse.SpawnPositions[CurrentCarhouse[player]][5],Vehicle.Carhouse.SpawnPositions[CurrentCarhouse[player]][6],Vehicle.Carhouse.SpawnPositions[CurrentCarhouse[player]][7]);
                PLAYER_VEHICLE_TESTDRIVE[player]=nil;

                setElementDimension(player,0);
                triggerClientEvent(player,"Notify:UI",player,loc(player,"S:Vehicle:TestdriveStopped"),"info",3000);
                if(isTimer(PLAYER_VEHICLE_TESTDRIVE_TIMER[player]))then
                    killTimer(PLAYER_VEHICLE_TESTDRIVE_TIMER[player]);
                    PLAYER_VEHICLE_TESTDRIVE_TIMER[player]=nil;
                end

                CurrentCarhouse[player]=nil;
            end)
        end
    end
end)


local function destroyElementsAfterQuitDead(player)
	if(isElement(PLAYER_VEHICLE_TESTDRIVE[player]))then
		destroyElement(PLAYER_VEHICLE_TESTDRIVE[player]);
		PLAYER_VEHICLE_TESTDRIVE[player]=nil;
	end
	if(isTimer(PLAYER_VEHICLE_TESTDRIVE_TIMER[player]))then
		killTimer(PLAYER_VEHICLE_TESTDRIVE_TIMER[player]);
		PLAYER_VEHICLE_TESTDRIVE_TIMER[player]=nil;
	end
end

addEventHandler("onPlayerQuit",root,function()
	destroyElementsAfterQuitDead(source);
end)
addEventHandler("onPlayerWasted",root,function()
	destroyElementsAfterQuitDead(source);
end)

