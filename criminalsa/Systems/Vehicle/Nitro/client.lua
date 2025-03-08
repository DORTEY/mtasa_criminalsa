addRemoteEvents{"Nitro:Amount:C"};--addEvents


local Nitro=0;
local Used=0;
local Timer=nil;


addEventHandler("Nitro:Amount:C",root,function(amount)
    Nitro=amount;
end)


addEventHandler("onClientKey",root,function(button,press) 
    if(button=="mouse1" and press)then
        if(isClickedState(localPlayer)==true)then
            return;
        end

        if(not(isTimer(Timer)))then
            local veh=getPedOccupiedVehicle(localPlayer);
            if(veh and isElement(veh))then
                if(getPedOccupiedVehicleSeat(localPlayer)==0)then
                    local VehID=getElementData(veh,"Vehicle:Data:VehID")or getElementModel(veh);
                    if(Vehicle.Types["Cars"][VehID])then
                        if(not(isPedDoingGangDriveby(localPlayer)))then
                            Timer=setTimer(usageNitro,300,0)
                            usageNitro();

                            triggerServerEvent("Nitro:Sync",localPlayer,true);
                        end
                    end
                end
            end
        end
    elseif(button=="mouse1" and(not press))then
        if(isPedInVehicle(localPlayer))then
            if(isTimer(Timer))then
                killTimer(Timer);
                Timer=nil;
            end
            triggerServerEvent("Nitro:Amount:S",localPlayer,"remove",tonumber(Used));
            triggerServerEvent("Nitro:Sync",localPlayer,false);

            Used=0;
        end
    end
end)

function usageNitro()
    if(Nitro and Nitro>0 and Used<Nitro)then
        Used=Used+1;
    else
        if(isTimer(Timer))then
            killTimer(Timer);
            Timer=nil;
        end
        Used=0;

        triggerServerEvent("Nitro:Amount:S",localPlayer,"get");
        triggerServerEvent("Nitro:Sync",localPlayer,false);
    end

    if(Used>=Nitro)then
        triggerServerEvent("Nitro:Amount:S",localPlayer,"remove",tonumber(Used));
    end
end

addEventHandler("onClientPlayerVehicleEnter",localPlayer,function(veh,seat)
    if(seat==0)then
        triggerServerEvent("Nitro:Amount:S",localPlayer,"get");
        triggerServerEvent("Nitro:Sync",localPlayer);
    end
end)
addEventHandler("onClientPlayerVehicleExit",localPlayer,function(veh,seat)
    if(seat==0)then
        if(Used>0)then
            triggerServerEvent("Nitro:Amount:S",localPlayer,"remove",tonumber(Used));
        end

        if(isTimer(Timer))then
            killTimer(Timer);
            Timer=nil;
        end
        Used=0;

        triggerServerEvent("Nitro:Sync",localPlayer,_,veh);
    end
end)