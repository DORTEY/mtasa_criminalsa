addRemoteEvents{"Load:Garage:Vehicles:S","Garage:ParkOut",
"Tuning:Tuningpart:S";"Tuning:Close"};--addEvents


local Count={};
local VehicleOwner={};
local VehicleID={};
local VehicleType={};


addEventHandler("Load:Garage:Vehicles:S",root,function()
    if(client and isElement(client)and getElementType(client)=="player" and isLoggedin(client))then
        for i,v in ipairs(getElementsByType("vehicle"))do
            VehicleID[i]=getElementData(v,"Vehicle:Data:ID")or nil;
            VehicleOwner[i]=getElementData(v,"Vehicle:Data:Owner")or nil;
    
            if(getElementData(v,"Vehicle:Data:Owner")and VehicleOwner[i]==getPlayerName(client)and VehicleID[i]and getElementData(v,"Vehicle:Data:Type")and getElementData(v,"Vehicle:Data:Type")=="Preview")then
                if(isElement(PLAYER_VEHICLE_GARAGE[VehicleOwner[i]..VehicleID[i]]))then
                    destroyElement(PLAYER_VEHICLE_GARAGE[VehicleOwner[i]..VehicleID[i]]);
                    PLAYER_VEHICLE_GARAGE[VehicleOwner[i]..VehicleID[i]]=nil;
                end
            end
        end



        Count[client]=0;
        local GarageTier=tonumber(getPlayerJsonValue(client,"HideUpgrades","Garage"))or 0;

        local result=dbPoll(dbQuery(Database.Connection,"SELECT * FROM ?? WHERE ??=?","Vehicles","Username",getPlayerName(client)),-1);
        if(#result>=1)then
            for _,v in pairs(result)do
                if(not(isElement(PLAYER_VEHICLE_GARAGE[v["Username"]..v["ID"]])))then
                    Count[client]=Count[client]+1;
                    local VehID=v["VehID"];
                    local VehColor=v["Color"];
                    local VehTunings=fromJSON(v["Tunings"]);
                    
                    if(Vehicle.Types["Helicopter"][VehID])then
                        zFix=0.2;
                    else
                        zFix=0;
                    end

                    local isCustom,mod,elementType=exports[RESOURCE_NEWMODELS]:isCustomModID(tonumber(VehID));
                    if(isCustom)then
                        PLAYER_VEHICLE_GARAGE[v["Username"]..v["ID"]]=createVehicle(mod.base_id,Hideout.Garage.GaragePositions[GarageTier][Count[client]][1],Hideout.Garage.GaragePositions[GarageTier][Count[client]][2],Hideout.Garage.GaragePositions[GarageTier][Count[client]][3]+zFix,0,0,Hideout.Garage.GaragePositions[GarageTier][Count[client]][4],v["Plate"]);
                        local dataName=exports[RESOURCE_NEWMODELS]:getDataNameFromType(elementType);
                        setElementData(PLAYER_VEHICLE_GARAGE[v["Username"]..v["ID"]],dataName,mod.id);
                    else
                        PLAYER_VEHICLE_GARAGE[v["Username"]..v["ID"]]=createVehicle(VehID,Hideout.Garage.GaragePositions[GarageTier][Count[client]][1],Hideout.Garage.GaragePositions[GarageTier][Count[client]][2],Hideout.Garage.GaragePositions[GarageTier][Count[client]][3]+zFix,0,0,Hideout.Garage.GaragePositions[GarageTier][Count[client]][4],v["Plate"]);
                    end

                    setElementData(PLAYER_VEHICLE_GARAGE[v["Username"]..v["ID"]],"Vehicle:Data:ID",v["ID"]);
                    setElementData(PLAYER_VEHICLE_GARAGE[v["Username"]..v["ID"]],"Vehicle:Data:VehID",VehID);
                    setElementData(PLAYER_VEHICLE_GARAGE[v["Username"]..v["ID"]],"Vehicle:Data:Owner",getPlayerName(client));
                    setElementData(PLAYER_VEHICLE_GARAGE[v["Username"]..v["ID"]],"Vehicle:Data:Type","Preview");
                    setElementData(PLAYER_VEHICLE_GARAGE[v["Username"]..v["ID"]],"Tunings",toJSON(VehTunings));

                    setVehicleDamageProof(PLAYER_VEHICLE_GARAGE[v["Username"]..v["ID"]],true);
                    setElementFrozen(PLAYER_VEHICLE_GARAGE[v["Username"]..v["ID"]],true);
                    setVehicleOverrideLights(PLAYER_VEHICLE_GARAGE[v["Username"]..v["ID"]],1);
                    setVehicleDoorsUndamageable(PLAYER_VEHICLE_GARAGE[v["Username"]..v["ID"]],true);

                    giveVehicleCustomHandling(PLAYER_VEHICLE_GARAGE[v["Username"]..v["ID"]],tonumber(VehID));
                    loadVehicleUpgrades(PLAYER_VEHICLE_GARAGE[v["Username"]..v["ID"]]);

                    setElementDimension(PLAYER_VEHICLE_GARAGE[v["Username"]..v["ID"]],getElementData(client,"Player:Data:TempID"));
                end
            end
        end
    end
end)

addEventHandler("Garage:ParkOut",root,function(id)
    if(client and isElement(client)and getElementType(client)=="player" and isLoggedin(client))then
        local HideoutTier=tonumber(getPlayerJsonValue(client,"HideUpgrades","Hideout"))or 0;

        if(isElement(PLAYER_VEHICLE[getPlayerName(client)..tonumber(id)]))then
            destroyElement(PLAYER_VEHICLE[getPlayerName(client)..tonumber(id)]);
            PLAYER_VEHICLE[getPlayerName(client)..tonumber(id)]=nil;
        end

        local VehID=getMySQLData2("Vehicles","Username",getPlayerName(client),"ID",tonumber(id),"VehID")or nil;
        local VehPlate=getMySQLData2("Vehicles","Username",getPlayerName(client),"ID",tonumber(id),"Plate")or nil;
        local VehColor=getMySQLData2("Vehicles","Username",getPlayerName(client),"ID",tonumber(id),"Color")or nil;
        local VehTunings=fromJSON(getMySQLData2("Vehicles","Username",getPlayerName(client),"ID",tonumber(id),"Tunings"))or nil;

        if(VehID and VehPlate and VehColor)then
            if(Vehicle.Types["Helicopter"][VehID])then
                spawnX,spawnY,spawnZ,spawnRot=Hideout.Garage.ParkOut[HideoutTier][2][1],Hideout.Garage.ParkOut[HideoutTier][2][2],Hideout.Garage.ParkOut[HideoutTier][2][3],Hideout.Garage.ParkOut[HideoutTier][2][4];
            else
                spawnX,spawnY,spawnZ,spawnRot=Hideout.Garage.ParkOut[HideoutTier][1][1],Hideout.Garage.ParkOut[HideoutTier][1][2],Hideout.Garage.ParkOut[HideoutTier][1][3],Hideout.Garage.ParkOut[HideoutTier][1][4];
            end

            local isCustom,mod,elementType=exports[RESOURCE_NEWMODELS]:isCustomModID(tonumber(VehID));
            if(isCustom)then
                PLAYER_VEHICLE[getPlayerName(client)..tonumber(id)]=createVehicle(mod.base_id,spawnX,spawnY,spawnZ,0,0,spawnRot, VehPlate);
                local dataName=exports[RESOURCE_NEWMODELS]:getDataNameFromType(elementType);
                setElementData(PLAYER_VEHICLE[getPlayerName(client)..tonumber(id)],dataName,mod.id);
            else
                PLAYER_VEHICLE[getPlayerName(client)..tonumber(id)]=createVehicle(tonumber(VehID),spawnX,spawnY,spawnZ,0,0,spawnRot, VehPlate);
            end
            setElementSpeed(PLAYER_VEHICLE[getPlayerName(client)..tonumber(id)],"km/h",0);
            
            setElementData(PLAYER_VEHICLE[getPlayerName(client)..tonumber(id)],"Vehicle:Data:ID",tonumber(id));
            setElementData(PLAYER_VEHICLE[getPlayerName(client)..tonumber(id)],"Vehicle:Data:VehID",tonumber(VehID));
            setElementData(PLAYER_VEHICLE[getPlayerName(client)..tonumber(id)],"Vehicle:Data:Owner",getPlayerName(client));
            setElementData(PLAYER_VEHICLE[getPlayerName(client)..tonumber(id)],"Vehicle:Data:Type","User");
            setElementData(PLAYER_VEHICLE[getPlayerName(client)..tonumber(id)],"Tunings",toJSON(VehTunings));

            setVehicleOverrideLights(PLAYER_VEHICLE[getPlayerName(client)..tonumber(id)],1);
            
            loadVehicleUpgrades(PLAYER_VEHICLE[getPlayerName(client)..tonumber(id)]);
            giveVehicleCustomHandling(PLAYER_VEHICLE[getPlayerName(client)..tonumber(id)],tonumber(VehID));
            
            setElementDimension(PLAYER_VEHICLE[getPlayerName(client)..tonumber(id)],0);
            setElementDimension(client,0);
            warpPedIntoVehicle(client,PLAYER_VEHICLE[getPlayerName(client)..tonumber(id)],0);
            setVehicleDoorsUndamageable(PLAYER_VEHICLE[getPlayerName(client)..tonumber(id)],true);

            triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Vehicle:ParkedOut"):format(returnVehicleName(VehID)),"info",3000,true);
        else
            print("Unknown error #9989011")
        end
    end
end)   






addEventHandler("Tuning:Tuningpart:S",root,function(type,part,color)
    if(client and isElement(client)and getElementType(client)=="player" and isLoggedin(client))then
        if(not(isPedInVehicle(client)))then
            return;
        end

        local veh=getPedOccupiedVehicle(client);
		if(veh and isElement(veh)and getElementData(veh,"Vehicle:Data:Owner"))then
            local VehOwner=tostring(getElementData(veh,"Vehicle:Data:Owner"))or nil;
			local VehID=tonumber(getElementData(veh,"Vehicle:Data:ID"))or nil;
            local VehModel=tonumber(getElementData(veh,"Vehicle:Data:VehID"))or nil;

            if(type=="Show")then
                if(string.find(part,"Paintjob_"))then
                    id=part:gsub("Paintjob_","");
                    if(tonumber(id)==9999999)then--remove
                        setVehiclePaintjob(veh,tonumber(3));
                        triggerClientEvent(client,"Vehicle:Preview:Paintjob",client,veh,tonumber(9999999));
                    else
                        if(tonumber(id)>=4)then
                            setVehiclePaintjob(veh,tonumber(3));
                            triggerClientEvent(client,"Vehicle:Preview:Paintjob",client,veh,tonumber(id));
                        else
                            setVehiclePaintjob(veh,tonumber(id));
                            triggerClientEvent(client,"Vehicle:Preview:Paintjob",client,veh);
                        end
                    end
                elseif(string.find(part,"Lightjob_"))then
                    id=part:gsub("Lightjob_","");
                    if(tonumber(id)==9999999)then--remove
                        triggerClientEvent(client,"Vehicle:Preview:Lightjob",client,veh,tonumber(9999999));
                    else
                        triggerClientEvent(client,"Vehicle:Preview:Lightjob",client,veh,tonumber(id));
                    end
                elseif(string.find(part,"WindowTint_"))then
                    id=part:gsub("WindowTint_","");
                    if(tonumber(id)==9999999)then--remove
                        triggerClientEvent(client,"Vehicle:Preview:WindowTint",client,veh,tonumber(9999999));
                    else
                        triggerClientEvent(client,"Vehicle:Preview:WindowTint",client,veh,tonumber(id));
                    end
                elseif(string.find(part,"NitroColor_"))then
                    id=part:gsub("NitroColor_","");
                    if(tonumber(id)==9999999)then--remove
                        triggerClientEvent(client,"Vehicle:Preview:NitroColor",client,veh,tonumber(9999999));
                    else
                        triggerClientEvent(client,"Vehicle:Preview:NitroColor",client,veh,tonumber(id));
                    end
                elseif(string.find(part,"WingDoors_"))then
                    id=part:gsub("WingDoors_","");
                    if(tonumber(id)==9999999)then--remove
                        removeElementData(veh,"Veh:Data:WingDoors");
                    else
                        setElementData(veh,"Veh:Data:WingDoors",id);
                    end
                elseif(string.find(part,"WheelPositionFront_"))then
                    id=part:gsub("WheelPositionFront_","");
                    if(tonumber(id)==9999999)then--remove
                        triggerClientEvent(client,"Vehicle:Preview:WheelPosition",client,veh,"front",tonumber(0));
                    else
                        triggerClientEvent(client,"Vehicle:Preview:WheelPosition",client,veh,"front",tonumber(id));
                    end
                elseif(string.find(part,"WheelPositionRear_"))then
                    id=part:gsub("WheelPositionRear_","");
                    if(tonumber(id)==9999999)then--remove
                        triggerClientEvent(client,"Vehicle:Preview:WheelPosition",client,veh,"rear",tonumber(0));
                    else
                        triggerClientEvent(client,"Vehicle:Preview:WheelPosition",client,veh,"rear",tonumber(id));
                    end
                elseif(string.find(part,"Wheels_"))then
                    id=part:gsub("Wheels_","");
                    if(Vehicle.Tuning.ModdedWheels[tonumber(id)])then
                        triggerClientEvent(client,"Vehicle:Preview:Wheels",client,veh,tonumber(id));
                    else
                        triggerClientEvent(client,"Vehicle:Preview:Wheels",client,veh);
                        addVehicleUpgrade(veh,tonumber(id));
                    end
                elseif(string.find(part,"Nitro_"))then
                    id=part:gsub("Nitro_","");
                    if(tonumber(id)==tonumber(9999999))then
                        local upgrade=getVehicleUpgradeOnSlot(veh,8);
			            if(upgrade)then
                            removeVehicleUpgrade(veh,tonumber(upgrade));
                        end
                    else
                        addVehicleUpgrade(veh,tonumber(id));
                    end
                elseif(string.find(part,"Spoiler_"))then
                    id=part:gsub("Spoiler_","");
                    if(tonumber(id)==tonumber(9999999))then
                        local upgrade=getVehicleUpgradeOnSlot(veh,2);
			            if(upgrade)then
                            removeVehicleUpgrade(veh,tonumber(upgrade));
                        end
                    else
                        addVehicleUpgrade(veh,tonumber(id));
                    end
                elseif(string.find(part,"Exhaust_"))then
                    id=part:gsub("Exhaust_","");
                    if(tonumber(id)==tonumber(9999999))then
                        local upgrade=getVehicleUpgradeOnSlot(veh,13);
			            if(upgrade)then
                            removeVehicleUpgrade(veh,tonumber(upgrade));
                        end
                    else
                        addVehicleUpgrade(veh,tonumber(id));
                    end
                elseif(string.find(part,"FrontBumper_"))then
                    id=part:gsub("FrontBumper_","");
                    if(tonumber(id)==tonumber(9999999))then
                        local upgrade=getVehicleUpgradeOnSlot(veh,14);
			            if(upgrade)then
                            removeVehicleUpgrade(veh,tonumber(upgrade));
                        end
                    else
                        addVehicleUpgrade(veh,tonumber(id));
                    end
                elseif(string.find(part,"RearBumper_"))then
                    id=part:gsub("RearBumper_","");
                    if(tonumber(id)==tonumber(9999999))then
                        local upgrade=getVehicleUpgradeOnSlot(veh,15);
			            if(upgrade)then
                            removeVehicleUpgrade(veh,tonumber(upgrade));
                        end
                    else
                        addVehicleUpgrade(veh,tonumber(id));
                    end
                elseif(string.find(part,"Roof_"))then
                    id=part:gsub("Roof_","");
                    if(tonumber(id)==tonumber(9999999))then
                        local upgrade=getVehicleUpgradeOnSlot(veh,7);
			            if(upgrade)then
                            removeVehicleUpgrade(veh,tonumber(upgrade));
                        end
                    else
                        addVehicleUpgrade(veh,tonumber(id));
                    end
                elseif(string.find(part,"Lamps_"))then
                    id=part:gsub("Lamps_","");
                    if(tonumber(id)==tonumber(9999999))then
                        local upgrade=getVehicleUpgradeOnSlot(veh,6);
			            if(upgrade)then
                            removeVehicleUpgrade(veh,tonumber(upgrade));
                        end
                    else
                        addVehicleUpgrade(veh,tonumber(id));
                    end
                elseif(string.find(part,"Sideskirt_"))then
                    id=part:gsub("Sideskirt_","");
                    if(tonumber(id)==tonumber(9999999))then
                        local upgrade=getVehicleUpgradeOnSlot(veh,3);
			            if(upgrade)then
                            removeVehicleUpgrade(veh,tonumber(upgrade));
                        end
                    else
                        addVehicleUpgrade(veh,tonumber(id));
                    end
                elseif(string.find(part,"Hydraulics_"))then
                    id=part:gsub("Hydraulics_","");
                    if(tonumber(id)==tonumber(9999999))then
                        local upgrade=getVehicleUpgradeOnSlot(veh,9);
			            if(upgrade)then
                            removeVehicleUpgrade(veh,tonumber(upgrade));
                        end
                    else
                        addVehicleUpgrade(veh,tonumber(id));
                    end
                elseif(string.find(part,"Variant_"))then
                    id=part:gsub("Variant_","");
                    setVehicleVariant(veh,tonumber(id),255);
                end
            elseif(type=="Buy")then
                if(part=="Bodycolor")then
                    if(tonumber(getPlayerJsonValue(client,"Money","Cash"))>=Vehicle.Tuning["TuningPrices"][tostring(part)])then--check money
                        setVehicleColor(veh,color[1],color[2],color[3],color[1],color[2],color[3]);

                        dbExec(Database.Connection,"UPDATE ?? SET ??=? WHERE ??=? AND ??=?","Vehicles","Color",toJSON(color),"Username",VehOwner,"ID",VehID);

                        removePlayerJsonValue(client,"Money","Cash",Vehicle.Tuning["TuningPrices"][tostring(part)]);
                        
                        triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Tuning:BoughtPart"):format(Vehicle.Tuning["TuningPrices"][tostring(part)]),"success",5000);

                        --logs
                        sendDiscordMessage({
                            ID=6, Title="Tuning purchase (Body color)", Desc=getPlayerName(client).." has bought a tuning.\n\nVehicle: '"..returnVehicleName(VehModel).." ("..VehModel..")'\nPrice: "..Vehicle.Tuning["TuningPrices"][tostring(part)].."",
                            PlayerData={Name=getPlayerName(client),Serial=getPlayerSerial(client),},
                        })
                    else
                        triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Tuning:NotEnoughMoney"):format(getPlayerJsonValue(client,"Money","Cash"),Vehicle.Tuning["TuningPrices"][tostring(part)]),"error",5000);
                    end
                elseif(part=="Lightcolor")then
                    if(tonumber(getPlayerJsonValue(client,"Money","Cash"))>=Vehicle.Tuning["TuningPrices"][tostring(part)])then--check money
                        setVehicleHeadLightColor(veh,color[1],color[2],color[3]);

                        dbExec(Database.Connection,"UPDATE ?? SET ??=? WHERE ??=? AND ??=?","Vehicles","LightColor",toJSON(color),"Username",VehOwner,"ID",VehID);

                        removePlayerJsonValue(client,"Money","Cash",Vehicle.Tuning["TuningPrices"][tostring(part)]);
                        
                        triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Tuning:BoughtPart"):format(Vehicle.Tuning["TuningPrices"][tostring(part)]),"success",5000);

                        --logs
                        sendDiscordMessage({
                            ID=6, Title="Tuning purchase (Light color)", Desc=getPlayerName(client).." has bought a tuning.\n\nVehicle: '"..returnVehicleName(VehModel).." ("..VehModel..")'\nPrice: "..Vehicle.Tuning["TuningPrices"][tostring(part)].."",
                            PlayerData={Name=getPlayerName(client),Serial=getPlayerSerial(client),},
                        })
                    else
                        triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Tuning:NotEnoughMoney"):format(getPlayerJsonValue(client,"Money","Cash"),Vehicle.Tuning["TuningPrices"][tostring(part)]),"error",5000);
                    end
                elseif(string.find(part,"Paintjob_"))then
                    id=part:gsub("Paintjob_","");
                    if(tonumber(getPlayerJsonValue(client,"Money","Cash"))>=(Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)])then--check money
                        if(tonumber(id)==9999999)then--remove
                            setVehiclePaintjob(veh,tonumber(3));
                            triggerClientEvent(client,"Vehicle:Preview:Paintjob",client,veh,tonumber(9999999));
                        else
                            if(tonumber(id)>=4)then
                                setVehiclePaintjob(veh,tonumber(3));
                                triggerClientEvent(client,"Vehicle:Preview:Paintjob",client,veh,tonumber(id));
                            else
                                setVehiclePaintjob(veh,tonumber(id));
                                triggerClientEvent(client,"Vehicle:Preview:Paintjob",client,veh);
                            end
                            removePlayerJsonValue(client,"Money","Cash",(Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)]);

                            triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Tuning:BoughtPart"):format((Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)]),"success",5000);
                            
                            --logs
                            sendDiscordMessage({
                                ID=6, Title="Tuning purchase (Paintjob)", Desc=getPlayerName(client).." has bought a tuning.\n\nVehicle: '"..returnVehicleName(VehModel).." ("..VehModel..")'\nPrice: "..Vehicle.Tuning["TuningPrices"][tostring(part)].."\nID/Part: "..tostring(part).."",
                                PlayerData={Name=getPlayerName(client),Serial=getPlayerSerial(client),},
                            })
                        end

                        addAchievement(client,"firstvehicletuning");
                        setVehicleJsonValue(veh,"Tunings","Paintjob",tonumber(id));
                        dbExec(Database.Connection,"UPDATE ?? SET ??=? WHERE ??=? AND ??=?","Vehicles","Tunings",getElementData(veh,"Tunings"),"Username",VehOwner,"ID",VehID);
                        loadVehicleUpgrades(veh);
                    else
                        triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Tuning:NotEnoughMoney"):format(getPlayerJsonValue(client,"Money","Cash"),(Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)]),"error",5000);
                    end
                elseif(string.find(part,"Lightjob_"))then
                    id=part:gsub("Lightjob_","");
                    if(tonumber(getPlayerJsonValue(client,"Money","Cash"))>=(Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)])then--check money
                        if(tonumber(id)==9999999)then--remove
                            triggerClientEvent(client,"Vehicle:Preview:Lightjob",client,veh,tonumber(9999999));
                        else
                            triggerClientEvent(client,"Vehicle:Preview:Lightjob",client,veh,tonumber(id));
                            removePlayerJsonValue(client,"Money","Cash",(Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)]);

                            triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Tuning:BoughtPart"):format((Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)]),"success",5000);
                            
                            --logs
                            sendDiscordMessage({
                                ID=6, Title="Tuning purchase (Lightjob)", Desc=getPlayerName(client).." has bought a tuning.\n\nVehicle: '"..returnVehicleName(VehModel).." ("..VehModel..")'\nPrice: "..Vehicle.Tuning["TuningPrices"][tostring(part)].."\nID/Part: "..tostring(part).."",
                                PlayerData={Name=getPlayerName(client),Serial=getPlayerSerial(client),},
                            })
                        end

                        addAchievement(client,"firstvehicletuning");
                        setVehicleJsonValue(veh,"Tunings","Lightjob",tonumber(id));
                        dbExec(Database.Connection,"UPDATE ?? SET ??=? WHERE ??=? AND ??=?","Vehicles","Tunings",getElementData(veh,"Tunings"),"Username",VehOwner,"ID",VehID);
                        loadVehicleUpgrades(veh);
                    else
                        triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Tuning:NotEnoughMoney"):format(getPlayerJsonValue(client,"Money","Cash"),(Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)]),"error",5000);
                    end
                elseif(string.find(part,"WindowTint_"))then
                    id=part:gsub("WindowTint_","");
                    if(tonumber(getPlayerJsonValue(client,"Money","Cash"))>=(Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)])then--check money
                        if(tonumber(id)==9999999)then--remove
                            triggerClientEvent(client,"Vehicle:Preview:WindowTint",client,veh,tonumber(9999999));
                        else
                            triggerClientEvent(client,"Vehicle:Preview:WindowTint",client,veh,tonumber(id));
                            removePlayerJsonValue(client,"Money","Cash",(Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)]);

                            triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Tuning:BoughtPart"):format((Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)]),"success",5000);
                            
                            --logs
                            sendDiscordMessage({
                                ID=6, Title="Tuning purchase (Window tint)", Desc=getPlayerName(client).." has bought a tuning.\n\nVehicle: '"..returnVehicleName(VehModel).." ("..VehModel..")'\nPrice: "..Vehicle.Tuning["TuningPrices"][tostring(part)].."\nID/Part: "..tostring(part).."",
                                PlayerData={Name=getPlayerName(client),Serial=getPlayerSerial(client),},
                            })
                        end

                        addAchievement(client,"firstvehicletuning");
                        setVehicleJsonValue(veh,"Tunings","WindowTint",tonumber(id));
                        dbExec(Database.Connection,"UPDATE ?? SET ??=? WHERE ??=? AND ??=?","Vehicles","Tunings",getElementData(veh,"Tunings"),"Username",VehOwner,"ID",VehID);
                        loadVehicleUpgrades(veh);
                    else
                        triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Tuning:NotEnoughMoney"):format(getPlayerJsonValue(client,"Money","Cash"),(Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)]),"error",5000);
                    end
                elseif(string.find(part,"WingDoors_"))then
                    id=part:gsub("WingDoors_","");
                    if(tonumber(getPlayerJsonValue(client,"Money","Cash"))>=(Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)])then--check money
                        if(tonumber(id)==9999999)then--remove
                            removeElementData(veh,"Veh:Data:WingDoors");
                        else
                            setElementData(veh,"Veh:Data:WingDoors",tonumber(id));
                            removePlayerJsonValue(client,"Money","Cash",(Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)]);

                            triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Tuning:BoughtPart"):format((Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)]),"success",5000);
                            
                            --logs
                            sendDiscordMessage({
                                ID=6, Title="Tuning purchase (Wing doors)", Desc=getPlayerName(client).." has bought a tuning.\n\nVehicle: '"..returnVehicleName(VehModel).." ("..VehModel..")'\nPrice: "..Vehicle.Tuning["TuningPrices"][tostring(part)].."\nID/Part: "..tostring(part).."",
                                PlayerData={Name=getPlayerName(client),Serial=getPlayerSerial(client),},
                            })
                        end

                        addAchievement(client,"firstvehicletuning");
                        setVehicleJsonValue(veh,"Tunings","WingDoors",tonumber(id));
                        dbExec(Database.Connection,"UPDATE ?? SET ??=? WHERE ??=? AND ??=?","Vehicles","Tunings",getElementData(veh,"Tunings"),"Username",VehOwner,"ID",VehID);
                        loadVehicleUpgrades(veh);
                    else
                        triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Tuning:NotEnoughMoney"):format(getPlayerJsonValue(client,"Money","Cash"),(Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)]),"error",5000);
                    end
                elseif(string.find(part,"WheelPositionFront_"))then
                    id=part:gsub("WheelPositionFront_","");
                    if(tonumber(getPlayerJsonValue(client,"Money","Cash"))>=(Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)])then--check money
                        if(tonumber(id)==9999999)then--remove
                            triggerClientEvent(client,"Vehicle:Preview:WheelPosition",client,veh,"front",0);
                        else
                            removePlayerJsonValue(client,"Money","Cash",(Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)]);

                            triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Tuning:BoughtPart"):format((Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)]),"success",5000);
                            
                            --logs
                            sendDiscordMessage({
                                ID=6, Title="Tuning purchase (F wheel position)", Desc=getPlayerName(client).." has bought a tuning.\n\nVehicle: '"..returnVehicleName(VehModel).." ("..VehModel..")'\nPrice: "..Vehicle.Tuning["TuningPrices"][tostring(part)].."\nID/Part: "..tostring(part).."",
                                PlayerData={Name=getPlayerName(client),Serial=getPlayerSerial(client),},
                            })
                        end

                        addAchievement(client,"firstvehicletuning");
                        setVehicleJsonValue(veh,"Tunings","WheelPositionFront",tonumber(id));
                        triggerClientEvent(client,"Vehicle:Preview:WheelPosition",client,veh,"front",tonumber(id));
                        dbExec(Database.Connection,"UPDATE ?? SET ??=? WHERE ??=? AND ??=?","Vehicles","Tunings",getElementData(veh,"Tunings"),"Username",VehOwner,"ID",VehID);
                        loadVehicleUpgrades(veh);
                    else
                        triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Tuning:NotEnoughMoney"):format(getPlayerJsonValue(client,"Money","Cash"),(Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)]),"error",5000);
                    end
                elseif(string.find(part,"WheelPositionRear_"))then
                    id=part:gsub("WheelPositionRear_","");
                    if(tonumber(getPlayerJsonValue(client,"Money","Cash"))>=(Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)])then--check money
                        if(tonumber(id)==9999999)then--remove
                            triggerClientEvent(client,"Vehicle:Preview:WheelPosition",client,veh,"rear",0);
                        else
                            removePlayerJsonValue(client,"Money","Cash",(Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)]);

                            triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Tuning:BoughtPart"):format((Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)]),"success",5000);
                            
                            --logs
                            sendDiscordMessage({
                                ID=6, Title="Tuning purchase (R wheel position)", Desc=getPlayerName(client).." has bought a tuning.\n\nVehicle: '"..returnVehicleName(VehModel).." ("..VehModel..")'\nPrice: "..Vehicle.Tuning["TuningPrices"][tostring(part)].."\nID/Part: "..tostring(part).."",
                                PlayerData={Name=getPlayerName(client),Serial=getPlayerSerial(client),},
                            })
                        end

                        addAchievement(client,"firstvehicletuning");
                        setVehicleJsonValue(veh,"Tunings","WheelPositionRear",tonumber(id));
                        triggerClientEvent(client,"Vehicle:Preview:WheelPosition",client,veh,"rear",tonumber(id));
                        dbExec(Database.Connection,"UPDATE ?? SET ??=? WHERE ??=? AND ??=?","Vehicles","Tunings",getElementData(veh,"Tunings"),"Username",VehOwner,"ID",VehID);
                        loadVehicleUpgrades(veh);
                    else
                        triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Tuning:NotEnoughMoney"):format(getPlayerJsonValue(client,"Money","Cash"),(Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)]),"error",5000);
                    end

                elseif(string.find(part,"Wheels_"))then
                    id=part:gsub("Wheels_","");
                    if(tonumber(getPlayerJsonValue(client,"Money","Cash"))>=(Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)])then--check money
                        if(Vehicle.Tuning.ModdedWheels[tonumber(id)])then
                            triggerClientEvent(client,"Vehicle:Preview:Wheels",client,veh,tonumber(id));
                        else
                            triggerClientEvent(client,"Vehicle:Preview:Wheels",client,veh);
                            addVehicleUpgrade(veh,tonumber(id));
                        end
                        setVehicleJsonValue(veh,"Tunings","Wheels",tonumber(id));
                        dbExec(Database.Connection,"UPDATE ?? SET ??=? WHERE ??=? AND ??=?","Vehicles","Tunings",getElementData(veh,"Tunings"),"Username",VehOwner,"ID",VehID);

                        addAchievement(client,"firstvehicletuning");
                        removePlayerJsonValue(client,"Money","Cash",(Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)]);

                        triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Tuning:BoughtPart"):format((Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)]),"success",5000);
                        
                        --logs
                        sendDiscordMessage({
                            ID=6, Title="Tuning purchase (Wheels)", Desc=getPlayerName(client).." has bought a tuning.\n\nVehicle: '"..returnVehicleName(VehModel).." ("..VehModel..")'\nPrice: "..Vehicle.Tuning["TuningPrices"][tostring(part)].."\nID/Part: "..tostring(part).."",
                            PlayerData={Name=getPlayerName(client),Serial=getPlayerSerial(client),},
                        })
                    else
                        triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Tuning:NotEnoughMoney"):format(getPlayerJsonValue(client,"Money","Cash"),(Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)]),"error",5000);
                    end
                elseif(string.find(part,"Spoiler_"))then
                    id=part:gsub("Spoiler_","");
                    if(tonumber(getPlayerJsonValue(client,"Money","Cash"))>=(Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)])then--check money
                        setVehicleJsonValue(veh,"Tunings","Spoiler",tonumber(id));
                        dbExec(Database.Connection,"UPDATE ?? SET ??=? WHERE ??=? AND ??=?","Vehicles","Tunings",getElementData(veh,"Tunings"),"Username",VehOwner,"ID",VehID);
                        loadVehicleUpgrades(veh);

                        addAchievement(client,"firstvehicletuning");
                        removePlayerJsonValue(client,"Money","Cash",(Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)]);

                        triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Tuning:BoughtPart"):format((Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)]),"success",5000);
                        
                        --logs
                        sendDiscordMessage({
                            ID=6, Title="Tuning purchase (Spoiler)", Desc=getPlayerName(client).." has bought a tuning.\n\nVehicle: '"..returnVehicleName(VehModel).." ("..VehModel..")'\nPrice: "..Vehicle.Tuning["TuningPrices"][tostring(part)].."\nID/Part: "..tostring(part).."",
                            PlayerData={Name=getPlayerName(client),Serial=getPlayerSerial(client),},
                        })
                    else
                        triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Tuning:NotEnoughMoney"):format(getPlayerJsonValue(client,"Money","Cash"),(Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)]),"error",5000);
                    end
                elseif(string.find(part,"Exhaust_"))then
                    id=part:gsub("Exhaust_","");
                    if(tonumber(getPlayerJsonValue(client,"Money","Cash"))>=(Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)])then--check money
                        setVehicleJsonValue(veh,"Tunings","Exhaust",tonumber(id));
                        dbExec(Database.Connection,"UPDATE ?? SET ??=? WHERE ??=? AND ??=?","Vehicles","Tunings",getElementData(veh,"Tunings"),"Username",VehOwner,"ID",VehID);
                        loadVehicleUpgrades(veh);

                        addAchievement(client,"firstvehicletuning");
                        removePlayerJsonValue(client,"Money","Cash",(Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)]);

                        triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Tuning:BoughtPart"):format((Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)]),"success",5000);
                        
                        --logs
                        sendDiscordMessage({
                            ID=6, Title="Tuning purchase (Exhaust)", Desc=getPlayerName(client).." has bought a tuning.\n\nVehicle: '"..returnVehicleName(VehModel).." ("..VehModel..")'\nPrice: "..Vehicle.Tuning["TuningPrices"][tostring(part)].."\nID/Part: "..tostring(part).."",
                            PlayerData={Name=getPlayerName(client),Serial=getPlayerSerial(client),},
                        })
                    else
                        triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Tuning:NotEnoughMoney"):format(getPlayerJsonValue(client,"Money","Cash"),(Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)]),"error",5000);
                    end
                elseif(string.find(part,"FrontBumper_"))then
                    id=part:gsub("FrontBumper_","");
                    if(tonumber(getPlayerJsonValue(client,"Money","Cash"))>=(Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)])then--check money
                        setVehicleJsonValue(veh,"Tunings","FrontBumper",tonumber(id));
                        dbExec(Database.Connection,"UPDATE ?? SET ??=? WHERE ??=? AND ??=?","Vehicles","Tunings",getElementData(veh,"Tunings"),"Username",VehOwner,"ID",VehID);
                        loadVehicleUpgrades(veh);

                        addAchievement(client,"firstvehicletuning");
                        removePlayerJsonValue(client,"Money","Cash",(Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)]);

                        triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Tuning:BoughtPart"):format((Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)]),"success",5000);
                        
                        --logs
                        sendDiscordMessage({
                            ID=6, Title="Tuning purchase (F bumper)", Desc=getPlayerName(client).." has bought a tuning.\n\nVehicle: '"..returnVehicleName(VehModel).." ("..VehModel..")'\nPrice: "..Vehicle.Tuning["TuningPrices"][tostring(part)].."\nID/Part: "..tostring(part).."",
                            PlayerData={Name=getPlayerName(client),Serial=getPlayerSerial(client),},
                        })
                    else
                        triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Tuning:NotEnoughMoney"):format(getPlayerJsonValue(client,"Money","Cash"),(Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)]),"error",5000);
                    end
                elseif(string.find(part,"RearBumper_"))then
                    id=part:gsub("RearBumper_","");
                    if(tonumber(getPlayerJsonValue(client,"Money","Cash"))>=(Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)])then--check money
                        setVehicleJsonValue(veh,"Tunings","RearBumper",tonumber(id));
                        dbExec(Database.Connection,"UPDATE ?? SET ??=? WHERE ??=? AND ??=?","Vehicles","Tunings",getElementData(veh,"Tunings"),"Username",VehOwner,"ID",VehID);
                        loadVehicleUpgrades(veh);

                        addAchievement(client,"firstvehicletuning");
                        removePlayerJsonValue(client,"Money","Cash",(Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)]);

                        triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Tuning:BoughtPart"):format((Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)]),"success",5000);
                        
                        --logs
                        sendDiscordMessage({
                            ID=6, Title="Tuning purchase (R bumper)", Desc=getPlayerName(client).." has bought a tuning.\n\nVehicle: '"..returnVehicleName(VehModel).." ("..VehModel..")'\nPrice: "..Vehicle.Tuning["TuningPrices"][tostring(part)].."\nID/Part: "..tostring(part).."",
                            PlayerData={Name=getPlayerName(client),Serial=getPlayerSerial(client),},
                        })
                    else
                        triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Tuning:NotEnoughMoney"):format(getPlayerJsonValue(client,"Money","Cash"),(Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)]),"error",5000);
                    end
                elseif(string.find(part,"Roof_"))then
                    id=part:gsub("Roof_","");
                    if(tonumber(getPlayerJsonValue(client,"Money","Cash"))>=(Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)])then--check money
                        setVehicleJsonValue(veh,"Tunings","Roof",tonumber(id));
                        dbExec(Database.Connection,"UPDATE ?? SET ??=? WHERE ??=? AND ??=?","Vehicles","Tunings",getElementData(veh,"Tunings"),"Username",VehOwner,"ID",VehID);
                        loadVehicleUpgrades(veh);

                        addAchievement(client,"firstvehicletuning");
                        removePlayerJsonValue(client,"Money","Cash",(Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)]);

                        triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Tuning:BoughtPart"):format((Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)]),"success",5000);
                        
                        --logs
                        sendDiscordMessage({
                            ID=6, Title="Tuning purchase (Roof)", Desc=getPlayerName(client).." has bought a tuning.\n\nVehicle: '"..returnVehicleName(VehModel).." ("..VehModel..")'\nPrice: "..Vehicle.Tuning["TuningPrices"][tostring(part)].."\nID/Part: "..tostring(part).."",
                            PlayerData={Name=getPlayerName(client),Serial=getPlayerSerial(client),},
                        })
                    else
                        triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Tuning:NotEnoughMoney"):format(getPlayerJsonValue(client,"Money","Cash"),(Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)]),"error",5000);
                    end
                elseif(string.find(part,"Lamps_"))then
                    id=part:gsub("Lamps_","");
                    if(tonumber(getPlayerJsonValue(client,"Money","Cash"))>=(Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)])then--check money
                        setVehicleJsonValue(veh,"Tunings","Lamps",tonumber(id));
                        dbExec(Database.Connection,"UPDATE ?? SET ??=? WHERE ??=? AND ??=?","Vehicles","Tunings",getElementData(veh,"Tunings"),"Username",VehOwner,"ID",VehID);
                        loadVehicleUpgrades(veh);

                        addAchievement(client,"firstvehicletuning");
                        removePlayerJsonValue(client,"Money","Cash",(Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)]);

                        triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Tuning:BoughtPart"):format((Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)]),"success",5000);
                    
                        --logs
                        sendDiscordMessage({
                            ID=6, Title="Tuning purchase (Lamps)", Desc=getPlayerName(client).." has bought a tuning.\n\nVehicle: '"..returnVehicleName(VehModel).." ("..VehModel..")'\nPrice: "..Vehicle.Tuning["TuningPrices"][tostring(part)].."\nID/Part: "..tostring(part).."",
                            PlayerData={Name=getPlayerName(client),Serial=getPlayerSerial(client),},
                        })
                    else
                        triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Tuning:NotEnoughMoney"):format(getPlayerJsonValue(client,"Money","Cash"),(Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)]),"error",5000);
                    end
                elseif(string.find(part,"Sideskirt_"))then
                    id=part:gsub("Sideskirt_","");
                    if(tonumber(getPlayerJsonValue(client,"Money","Cash"))>=(Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)])then--check money
                        setVehicleJsonValue(veh,"Tunings","Sideskirt",tonumber(id));
                        dbExec(Database.Connection,"UPDATE ?? SET ??=? WHERE ??=? AND ??=?","Vehicles","Tunings",getElementData(veh,"Tunings"),"Username",VehOwner,"ID",VehID);
                        loadVehicleUpgrades(veh);

                        addAchievement(client,"firstvehicletuning");
                        removePlayerJsonValue(client,"Money","Cash",(Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)]);

                        triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Tuning:BoughtPart"):format((Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)]),"success",5000);
                        
                        --logs
                        sendDiscordMessage({
                            ID=6, Title="Tuning purchase (Sideskirt)", Desc=getPlayerName(client).." has bought a tuning.\n\nVehicle: '"..returnVehicleName(VehModel).." ("..VehModel..")'\nPrice: "..Vehicle.Tuning["TuningPrices"][tostring(part)].."\nID/Part: "..tostring(part).."",
                            PlayerData={Name=getPlayerName(client),Serial=getPlayerSerial(client),},
                        })
                    else
                        triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Tuning:NotEnoughMoney"):format(getPlayerJsonValue(client,"Money","Cash"),(Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)]),"error",5000);
                    end
                elseif(string.find(part,"Hydraulics_"))then
                    id=part:gsub("Hydraulics_","");
                    if(tonumber(getPlayerJsonValue(client,"Money","Cash"))>=(Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)])then--check money
                        setVehicleJsonValue(veh,"Tunings","Hydraulics",tonumber(id));
                        dbExec(Database.Connection,"UPDATE ?? SET ??=? WHERE ??=? AND ??=?","Vehicles","Tunings",getElementData(veh,"Tunings"),"Username",VehOwner,"ID",VehID);
                        loadVehicleUpgrades(veh);

                        addAchievement(client,"firstvehicletuning");
                        removePlayerJsonValue(client,"Money","Cash",(Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)]);

                        triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Tuning:BoughtPart"):format((Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)]),"success",5000);
                        
                        --logs
                        sendDiscordMessage({
                            ID=6, Title="Tuning purchase (Hydraulics)", Desc=getPlayerName(client).." has bought a tuning.\n\nVehicle: '"..returnVehicleName(VehModel).." ("..VehModel..")'\nPrice: "..Vehicle.Tuning["TuningPrices"][tostring(part)].."\nID/Part: "..tostring(part).."",
                            PlayerData={Name=getPlayerName(client),Serial=getPlayerSerial(client),},
                        })
                    else
                        triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Tuning:NotEnoughMoney"):format(getPlayerJsonValue(client,"Money","Cash"),(Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)]),"error",5000);
                    end

                elseif(string.find(part,"DriveType_"))then
                    id=part:gsub("DriveType_","");
                    if(tonumber(getPlayerJsonValue(client,"Money","Cash"))>=(Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)])then--check money
                        setVehicleJsonValue(veh,"Tunings","DriveType",tostring(id));
                        dbExec(Database.Connection,"UPDATE ?? SET ??=? WHERE ??=? AND ??=?","Vehicles","Tunings",getElementData(veh,"Tunings"),"Username",VehOwner,"ID",VehID);
                        loadVehicleUpgrades(veh);

                        addAchievement(client,"firstvehicletuning");
                        removePlayerJsonValue(client,"Money","Cash",(Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)]);

                        triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Tuning:BoughtPart"):format((Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)]),"success",5000);
                    
                        --logs
                        sendDiscordMessage({
                            ID=6, Title="Tuning purchase (Drivetype)", Desc=getPlayerName(client).." has bought a tuning.\n\nVehicle: '"..returnVehicleName(VehModel).." ("..VehModel..")'\nPrice: "..Vehicle.Tuning["TuningPrices"][tostring(part)].."\nID/Part: "..tostring(part).."",
                            PlayerData={Name=getPlayerName(client),Serial=getPlayerSerial(client),},
                        })
                    else
                        triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Tuning:NotEnoughMoney"):format(getPlayerJsonValue(client,"Money","Cash"),(Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)]),"error",5000);
                    end
                elseif(string.find(part,"Horn_"))then
                    id=part:gsub("Horn_","");
                    if(tonumber(getPlayerJsonValue(client,"Money","Cash"))>=(Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)])then--check money
                        setVehicleJsonValue(veh,"Tunings","Horn",tonumber(id));
                        dbExec(Database.Connection,"UPDATE ?? SET ??=? WHERE ??=? AND ??=?","Vehicles","Tunings",getElementData(veh,"Tunings"),"Username",VehOwner,"ID",VehID);
                        loadVehicleUpgrades(veh);

                        addAchievement(client,"firstvehicletuning");
                        removePlayerJsonValue(client,"Money","Cash",(Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)]);

                        triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Tuning:BoughtPart"):format((Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)]),"success",5000);
                    
                        --logs
                        sendDiscordMessage({
                            ID=6, Title="Tuning purchase (Horn)", Desc=getPlayerName(client).." has bought a tuning.\n\nVehicle: '"..returnVehicleName(VehModel).." ("..VehModel..")'\nPrice: "..Vehicle.Tuning["TuningPrices"][tostring(part)].."\nID/Part: "..tostring(part).."",
                            PlayerData={Name=getPlayerName(client),Serial=getPlayerSerial(client),},
                        })
                    else
                        triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Tuning:NotEnoughMoney"):format(getPlayerJsonValue(client,"Money","Cash"),(Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)]),"error",5000);
                    end

                elseif(string.find(part,"Chip_"))then
                    id=part:gsub("Chip_","");
                    if(tonumber(getPlayerJsonValue(client,"Money","Cash"))>=(Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)])then--check money
                        setVehicleJsonValue(veh,"Tunings","ChipStage",tonumber(id));
                        dbExec(Database.Connection,"UPDATE ?? SET ??=? WHERE ??=? AND ??=?","Vehicles","Tunings",getElementData(veh,"Tunings"),"Username",VehOwner,"ID",VehID);
                        loadVehicleUpgrades(veh);

                        addAchievement(client,"firstvehicletuning");
                        removePlayerJsonValue(client,"Money","Cash",(Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)]);

                        triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Tuning:BoughtPart"):format((Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)]),"success",5000);
                    
                        --logs
                        sendDiscordMessage({
                            ID=6, Title="Tuning purchase (Chip)", Desc=getPlayerName(client).." has bought a tuning.\n\nVehicle: '"..returnVehicleName(VehModel).." ("..VehModel..")'\nPrice: "..Vehicle.Tuning["TuningPrices"][tostring(part)].."\nID/Part: "..tostring(part).."",
                            PlayerData={Name=getPlayerName(client),Serial=getPlayerSerial(client),},
                        })
                    else
                        triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Tuning:NotEnoughMoney"):format(getPlayerJsonValue(client,"Money","Cash"),(Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)]),"error",5000);
                    end
                elseif(string.find(part,"Variant_"))then
                    id=part:gsub("Variant_","");
                    if(tonumber(getPlayerJsonValue(client,"Money","Cash"))>=(Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)])then--check money
                        setVehicleJsonValue(veh,"Tunings","Variant",tonumber(id));
                        dbExec(Database.Connection,"UPDATE ?? SET ??=? WHERE ??=? AND ??=?","Vehicles","Tunings",getElementData(veh,"Tunings"),"Username",VehOwner,"ID",VehID);
                        loadVehicleUpgrades(veh);

                        addAchievement(client,"firstvehicletuning");
                        removePlayerJsonValue(client,"Money","Cash",(Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)]);

                        triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Tuning:BoughtPart"):format((Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)]),"success",5000);
                    
                        --logs
                        sendDiscordMessage({
                            ID=6, Title="Tuning purchase (Variant)", Desc=getPlayerName(client).." has bought a tuning.\n\nVehicle: '"..returnVehicleName(VehModel).." ("..VehModel..")'\nPrice: "..Vehicle.Tuning["TuningPrices"][tostring(part)].."\nID/Part: "..tostring(part).."",
                            PlayerData={Name=getPlayerName(client),Serial=getPlayerSerial(client),},
                        })
                    else
                        triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Tuning:NotEnoughMoney"):format(getPlayerJsonValue(client,"Money","Cash"),(Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)]),"error",5000);
                    end
                elseif(string.find(part,"Armory_"))then
                    id=part:gsub("Armory_","");
                    if(tonumber(getPlayerJsonValue(client,"Money","Cash"))>=(Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)])then--check money
                        setVehicleJsonValue(veh,"Tunings","Armory",tonumber(id));
                        dbExec(Database.Connection,"UPDATE ?? SET ??=? WHERE ??=? AND ??=?","Vehicles","Tunings",getElementData(veh,"Tunings"),"Username",VehOwner,"ID",VehID);
                        loadVehicleUpgrades(veh);

                        addAchievement(client,"firstvehicletuning");
                        removePlayerJsonValue(client,"Money","Cash",(Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)]);

                        triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Tuning:BoughtPart"):format((Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)]),"success",5000);
                    
                        --logs
                        sendDiscordMessage({
                            ID=6, Title="Tuning purchase (Armory)", Desc=getPlayerName(client).." has bought a tuning.\n\nVehicle: '"..returnVehicleName(VehModel).." ("..VehModel..")'\nPrice: "..Vehicle.Tuning["TuningPrices"][tostring(part)].."\nID/Part: "..tostring(part).."",
                            PlayerData={Name=getPlayerName(client),Serial=getPlayerSerial(client),},
                        })
                    else
                        triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Tuning:NotEnoughMoney"):format(getPlayerJsonValue(client,"Money","Cash"),(Vehicle.Prices[VehModel]or 300000)/100*Vehicle.Tuning["TuningPrices"][tostring(part)]),"error",5000);
                    end

                end
            end

        end
    end
end)


addEventHandler("Tuning:Close",root,function()
    if(client and isElement(client)and getElementType(client)=="player" and isLoggedin(client))then
        if(not(isPedInVehicle(client)))then
            return;
        end

        local veh=getPedOccupiedVehicle(client);
		if(veh and isElement(veh)and getElementData(veh,"Vehicle:Data:Owner"))then
            loadVehicleUpgrades(veh);
        end
    end
end)













addEventHandler("onPlayerQuit",root,function()
    for i,v in ipairs(getElementsByType("vehicle"))do
        if(v and isElement(v))then
            VehicleID[i]=getElementData(v,"Vehicle:Data:ID")or nil;
            VehicleOwner[i]=getElementData(v,"Vehicle:Data:Owner")or nil;
            VehicleType[i]=getElementData(v,"Vehicle:Data:Type")or nil;

            if(VehicleOwner[i]and VehicleOwner[i]==getPlayerName(source)and VehicleID[i]and VehicleType[i]and VehicleType[i]=="Preview")then
                if(isElement(PLAYER_VEHICLE_GARAGE[VehicleOwner[i]..VehicleID[i]]))then
                    destroyElement(PLAYER_VEHICLE_GARAGE[VehicleOwner[i]..VehicleID[i]]);
                    PLAYER_VEHICLE_GARAGE[VehicleOwner[i]..VehicleID[i]]=nil;
                end
            end

            if(VehicleOwner[i]and VehicleOwner[i]==getPlayerName(source)and VehicleID[i]and VehicleType[i]and VehicleType[i]=="User")then
                if(isElement(PLAYER_VEHICLE[VehicleOwner[i]..VehicleID[i]]))then
                    destroyElement(PLAYER_VEHICLE[VehicleOwner[i]..VehicleID[i]]);
                    PLAYER_VEHICLE[VehicleOwner[i]..VehicleID[i]]=nil;
                end
            end
        end
    end
end)