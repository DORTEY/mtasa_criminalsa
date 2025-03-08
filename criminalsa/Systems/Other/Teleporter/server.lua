addRemoteEvents{"Teleport:Teleport:S"};--addEvents


addEventHandler("Teleport:Teleport:S",root,function(type,name)
    if(client and isElement(client)and getElementType(client)=="player" and isLoggedin(client))then
        if(not(isPedInVehicle(client)))then
            if(type and name)then
                if(not(isTimer(PLAYER_TELEPORTER[client])))then
                    local HideoutTier=tonumber(getPlayerJsonValue(client,"HideUpgrades","Hideout"))or 0;

                    if(getElementData(client,"Player:Data:RobbedAmount"))then
                        return;
                    end
                    if(type=="HideoutOut" and name=="Garage" or type=="HideoutIn" and name=="Garage" or type=="HideoutIn" and name=="Hideout" or type=="GarageOut" and name=="Hideout")then
                        dim=getElementData(client,"Player:Data:TempID");
                    else
                        dim=0;
                    end

                    if(type=="HideoutOut" and name=="Exit")then
                        triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Hideout:Leaved"),"info",3000,true);
                    elseif(type=="HideoutIn" and name=="Hideout")then
                        triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Hideout:Entered"),"info",3000,true);
                    end
                    
                    fadeElementPosition(client,Teleporter[HideoutTier][tostring(type)][tostring(name)][1],Teleporter[HideoutTier][tostring(type)][tostring(name)][2],Teleporter[HideoutTier][tostring(type)][tostring(name)][3],Teleporter[HideoutTier][tostring(type)][tostring(name)][4],0,dim);
                    triggerClientEvent(client,"Teleporter:UI",client);
                end
            end
        end
    end
end)









function fadeElementPosition(player,x,y,z,rot,int,dim)
	if(isElement(player)and isLoggedin(player)and getElementType(player)=="player")then
		if(x and y and z and rot)then
            if(not(isTimer(PLAYER_TELEPORTER[player])))then
                fadeCamera(player,false,0.1,0,0,0);
                setElementFrozen(player,true);
                setElementData(player,"Player:Data:isTeleporting",true);

                PLAYER_TELEPORTER[player]=setTimer(function(player,x,y,z,rot,int,dim)
                    if(player and isElement(player)and isLoggedin(player))then
                        fadeCamera(player,true,0.2,0,0,0);
                        setElementFrozen(player,false);

                        setElementPosition(player,x,y,z);
                        setElementRotation(player,0,0,rot);

                        if(int)then
                            setElementInterior(player,int);
                        end
                        if(dim)then
                            setElementDimension(player,dim);
                        end

                        removeElementData(player,"Player:Data:isTeleporting");
                    end
                end,800,1,player,x,y,z,rot,int,dim)
            end
		end
	end
end