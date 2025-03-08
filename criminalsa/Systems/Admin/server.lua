addRemoteEvents{"ModFailKick:S"};--addEvents



local PlayerVanish={};
local PlayerSpectating={Status={},OldPos={},};


addCommandHandler("giveitem",function(player,cmd,target,item,amount)
	if(player and isElement(player)and getElementType(player)=="player" and isLoggedin(player)and(not client or client==player))then
        if(Admin[tonumber(getElementData(player,"AdminLevel"))].Permissions.DevFunctions)then
            if(target)then
                if(target=="me")then
                    target=player;
                else
                    target=getPlayerFromName(target)or nil;
                end

                if(target and isElement(target)and getElementType(target)=="player" and isLoggedin(target))then
                    if(item and amount)then
                        if(item~="" and tonumber(amount)>0 and Items[tostring(item)])then
                            addPlayerJsonValue(target,"Items",tostring(item),tonumber(amount));
                            outputChatBox("#ffffff+"..amount.." "..loc(target,"Item:"..item).."",target,255,255,255,true);
                        end
                    end
                else
                    triggerClientEvent(player,"Notify:UI",player,"Player doesnt exist/is offline.","error",3000,true);
                end
            end
        end
    end
end)
addCommandHandler("clearinventory",function(player,cmd,target)
	if(player and isElement(player)and getElementType(player)=="player" and isLoggedin(player)and(not client or client==player))then
        if(Admin[tonumber(getElementData(player,"AdminLevel"))].Permissions.DevFunctions)then
            if(target)then
                if(target=="me")then
                    target=player;
                else
                    target=getPlayerFromName(target)or nil;
                end

                if(target and isElement(target)and getElementType(target)=="player" and isLoggedin(target))then
                    for item,v in pairs(Items)do
                        if(getPlayerJsonValue(target,"Items",tostring(item))>0)then
                            if(Items[tostring(item)].Display)then
                                outputChatBox("#ffffff-"..loc(target,"Item:"..item).."",target,255,255,255,true);
                                setPlayerJsonValue(target,"Items",tostring(item),0);
                            end
                        end
                    end
                else
                    triggerClientEvent(player,"Notify:UI",player,"Player doesnt exist/is offline.","error",3000,true);
                end
            end
        end
    end
end)

addCommandHandler("givemoney",function(player,cmd,target,item,amount)
	if(player and isElement(player)and getElementType(player)=="player" and isLoggedin(player)and(not client or client==player))then
        if(Admin[tonumber(getElementData(player,"AdminLevel"))].Permissions.DevFunctions)then
            if(target)then
                if(target=="me")then
                    target=player;
                else
                    target=getPlayerFromName(target)or nil;
                end

                if(target and isElement(target)and getElementType(target)=="player" and isLoggedin(target))then
                    if(item and amount)then
                        if(item~="" and tonumber(amount)>0)then
                            if(item=="Cash" or item=="Black" or item=="CrimeCoin")then
                                addPlayerJsonValue(target,"Money",tostring(item),tonumber(amount));
                                outputChatBox("#ffffff+"..amount.." "..item,target,255,255,255,true);
                            end
                        end
                    end
                else
                    triggerClientEvent(player,"Notify:UI",player,"Player doesnt exist/is offline.","error",3000,true);
                end
            end
        end
    end
end)

addCommandHandler("giveeventpoints",function(player,cmd,target,amount)
    if(player and isElement(player)and getElementType(player)=="player" and isLoggedin(player)and(not client or client==player))then
        if(Admin[tonumber(getElementData(player,"AdminLevel"))].Permissions.DevFunctions)then
            if(target)then
                if(target=="me")then
                    target=player;
                else
                    target=getPlayerFromName(target)or nil;
                end

                if(target and isElement(target)and getElementType(target)=="player" and isLoggedin(target))then
                    if(amount)then
                        if(tonumber(amount)>0 and Server.Settings.Event.Current[1]~="none")then
                            addPlayerJsonValue(target,"Points",Server.Settings.Event.Datas[Server.Settings.Event.Current[1]],tonumber(amount));
                        end
                    end
                else
                    triggerClientEvent(player,"Notify:UI",player,"Player doesnt exist/is offline.","error",3000,true);
                end
            end
        end
    end
end)

addCommandHandler("givejobexp",function(player,cmd,target,job,amount)
    if(player and isElement(player)and getElementType(player)=="player" and isLoggedin(player)and(not client or client==player))then
        if(Admin[tonumber(getElementData(player,"AdminLevel"))].Permissions.DevFunctions)then
            if(target)then
                if(target=="me")then
                    target=player;
                else
                    target=getPlayerFromName(target)or nil;
                end

                if(target and isElement(target)and getElementType(target)=="player" and isLoggedin(target))then
                    if(job and amount)then
                        if(job~="" and tonumber(amount)>0)then
                            if(Jobs[tostring(job)])then
                                if(not(getPlayerNotExistingJsonValue(target,"Levels","Job"..tostring(job).."LVL")))then--set if element data doesnt exist
                                    setPlayerJsonValue(target,"Levels","Job"..tostring(job).."LVL",1);
                                    setPlayerJsonValue(target,"Levels","Job"..tostring(job).."EXP",tonumber(amount));

                                    updateJobLevelstuff(target,tostring(job));
                                else
                                    addPlayerJsonValue(target,"Levels","Job"..tostring(job).."EXP",tonumber(amount));
                                    updateJobLevelstuff(target,tostring(job));
                                end

                                outputChatBox("#ffffff+"..amount.." "..job,target,255,255,255,true);
                            else
                                triggerClientEvent(player,"Notify:UI",player,"The entered job doesnt exist.","error",3000,true);
                            end
                        end
                    end
                else
                    triggerClientEvent(player,"Notify:UI",player,"Player doesnt exist/is offline.","error",3000,true);
                end
            end
        end
    end
end)


addCommandHandler("xyz",function(player,cmd,x,y,z,int,dim)
	if(player and isElement(player)and getElementType(player)=="player" and isLoggedin(player)and(not client or client==player))then
		if(Admin[tonumber(getElementData(player,"AdminLevel"))].Permissions.DevFunctions)then
			if(isPedInVehicle(player))then
				local veh=getPedOccupiedVehicle(player);
				if(veh)then
					setElementPosition(veh,x,y,z);
					setElementInterior(veh,int)
					setElementDimension(veh,dim);
				end
			else
				if(int and dim)then
					setElementPosition(player,x,y,z);
					setElementInterior(player,int)
					setElementDimension(player,dim);
				else
					setElementPosition(player,x,y,z);
				end
			end
		end
	end
end)


addCommandHandler("givecar",function(player,cmd,target,vehID)
	if(player and isElement(player)and getElementType(player)=="player" and isLoggedin(player)and(not client or client==player))then
		if(Admin[tonumber(getElementData(player,"AdminLevel"))].Permissions.GiveCar)then
            if(target)then
                if(target=="me")then
                    target=player;
                else
                    target=getPlayerFromName(target)or nil;
                end

                if(target and isElement(target)and getElementType(target)=="player" and isLoggedin(target))then
                    if(vehID)then
                        giveVehicleToPlayer(target,tonumber(vehID));
                    end
                else
                    triggerClientEvent(player,"Notify:UI",player,"Player doesnt exist/is offline.","error",3000,true);
                end
            end
        end
	end
end)


addCommandHandler("vanish",function(player,cmd)
	if(player and isElement(player)and getElementType(player)=="player" and isLoggedin(player)and(not client or client==player))then
		if(Admin[tonumber(getElementData(player,"AdminLevel"))].Permissions.Vanish)then

            if(not(PlayerVanish[player]))then
                setElementAlpha(player,0);
                PlayerVanish[player]=true;
            else
                setElementAlpha(player,255);
                PlayerVanish[player]=nil;
            end
        end
	end
end)


addCommandHandler("spec",function(player,cmd,target)
	if(player and isElement(player)and getElementType(player)=="player" and isLoggedin(player)and(not client or client==player))then
		if(Admin[tonumber(getElementData(player,"AdminLevel"))].Permissions.Spectate)then
            if(target)then
                if(target=="me")then
                    target=player;
                else
                    target=getPlayerFromName(target)or nil;
                end
                
                if(target and isElement(target)and getElementType(target)=="player" and isLoggedin(target))then
                    if(PlayerSpectating.Status[player]==nil)then
                        PlayerSpectating.Status[player]=true;
                        PlayerSpectating.OldPos[player]={getElementDimension(player),getElementInterior(player)};

                        fadeCamera(player,true);
                        setElementFrozen(player,true);
                        setCameraTarget(player,target);

                        
                        setElementDimension(player,getElementDimension(target));
                        setElementInterior(player,getElementInterior(target));

                        triggerClientEvent(player,"Notify:UI",player,"You are spectating "..getPlayerName(target).." now.","info",3000,true);
                    else
                        PlayerSpectating.Status[player]=nil;
                        if(PlayerSpectating.OldPos[player])then
                            setElementInterior(player,PlayerSpectating.OldPos[player][2]);
                            setElementDimension(player,PlayerSpectating.OldPos[player][1]);
                            PlayerSpectating.OldPos[player]=nil;
                        end

                        fadeCamera(player,true);
                        setElementFrozen(player,false);
                        setCameraTarget(player,player);

                        triggerClientEvent(player,"Notify:UI",player,"You stopped spectating.","info",3000,true);
                    end
                else
                    triggerClientEvent(player,"Notify:UI",player,"Player doesnt exist/is offline.","error",3000,true);
                end
            else
                if(PlayerSpectating.Status[player])then
                    PlayerSpectating.Status[player]=nil;
                    if(PlayerSpectating.OldPos[player])then
                        setElementInterior(player,PlayerSpectating.OldPos[player][2]);
                        setElementDimension(player,PlayerSpectating.OldPos[player][1]);
                        PlayerSpectating.OldPos[player]=nil;
                    end

                    fadeCamera(player,true);
                    setElementFrozen(player,false);
                    setCameraTarget(player,player);

                    triggerClientEvent(player,"Notify:UI",player,"You stopped spectating.","info",3000,true);
                end
            end
        end
	end
end)


addCommandHandler("generatecode",function(player,cmd,type,item,amount)
	if(player and isElement(player)and getElementType(player)=="player" and isLoggedin(player)and(not client or client==player))then
		if(Admin[tonumber(getElementData(player,"AdminLevel"))].Permissions.DevFunctions)then
            if(type and item)then
                if(type=="Item" and Items[item]or type=="Money" and Moneys[item]or type=="Vehicle" and Vehicle.Names[tonumber(item)])then
                    if(not(amount))then
                        amount=1;
                    end
                    ResultRandomCode=generateRedeemCode();

                    dbExec(Database.Connection,"INSERT INTO ?? (Code,Type,Item,Amount) VALUES (?,?,?,?)","Codes",ResultRandomCode,tostring(type),tostring(item),tonumber(amount));
                    outputChatBox(Server.Color.HEX..ResultRandomCode.." ("..type.." "..item.." "..amount..")",player,0,0,0,true);
                end
            else
                print("Type(Item,Money,Vehicle), ItemName/VehicleID, Amount")
            end
        end
	end
end)

addCommandHandler("toggleaccount",function(player,cmd,target)
	if(player and isElement(player)and getElementType(player)=="player" and isLoggedin(player)and(not client or client==player))then
		if(Admin[tonumber(getElementData(player,"AdminLevel"))].Permissions.DevFunctions)then
            if(target)then
                local result=dbPoll(dbQuery(Database.Connection,"SELECT * FROM Accounts WHERE ??=?","Username",target),-1);
                if(result and result[1])then
                    if(result[1]["Activated"]==1)then
                        dbExec(Database.Connection,"UPDATE ?? SET ??=? WHERE ??=?","Accounts","Activated",0,"Username",target);
                        print("acc "..result[1]["Username"].." disabled")

                        if(isElement(getPlayerFromName(target)))then
                            kickPlayer(getPlayerFromName(target),"Criminal SA","Your account has been disabled!\nPlease contact our support.");
                        end
                    else
                        dbExec(Database.Connection,"UPDATE ?? SET ??=? WHERE ??=?","Accounts","Activated",1,"Username",target);
                        print("acc "..result[1]["Username"].." enabled")
                    end
                else
                    print("acc doesnt exist")
                end
            else
                print("Name")
            end
        end
	end
end)


































addEventHandler("ModFailKick:S",root,function(reason)
    if(client and isElement(client)and getElementType(client)=="player")then
        if(reason)then
            kickPlayer(client,"Criminal SA","Failed to load some mods...\nPlease reconnect!");
        end
    end
end)