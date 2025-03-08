addRemoteEvents{"Nitro:Amount:S","Nitro:Sync"};--addEvents


addEventHandler("Nitro:Amount:S",root,function(type,amount)
    if(client and isElement(client)and getElementType(client)=="player" and isLoggedin(client))then
        if(type=="get")then
            local NitroAmount=getPlayerJsonValue(client,"Items","Nitro")or 0;

            triggerClientEvent(client,"Nitro:Amount:C",client,NitroAmount);
        elseif(type=="remove")then
            local NitroAmount=getPlayerJsonValue(client,"Items","Nitro")or 0;
            if(NitroAmount>=amount)then
                if(amount>0)then
                    removePlayerJsonValue(client,"Items","Nitro",amount);
                end

                triggerClientEvent(client,"Nitro:Amount:C",client,getPlayerJsonValue(client,"Items","Nitro"));
            end
        end
    end
end)


addEventHandler("Nitro:Sync",root,function(type,veh)
    if(client and isElement(client)and getElementType(client)=="player" and isLoggedin(client))then
        if(type and(not veh))then
            local veh=getPedOccupiedVehicle(client);
            if(veh and isElement(veh))then
                removeVehicleUpgrade(veh,1010);
                if(getPlayerJsonValue(client,"Items","Nitro")>0)then
                    addVehicleUpgrade(veh,1010);
                end
            end
        elseif(not type and(not veh))then
            local veh=getPedOccupiedVehicle(client);
            if(veh and isElement(veh))then
                local nitroBottle=getVehicleUpgradeOnSlot(veh,8);
                removeVehicleUpgrade(veh,nitroBottle);
            end
        elseif(veh)then
            if(veh and isElement(veh))then
                local nitroBottle=getVehicleUpgradeOnSlot(veh,8);
                removeVehicleUpgrade(veh,nitroBottle);
            end
        end
    end
end)