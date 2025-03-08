addRemoteEvents{"Rob:Sync:Animation","Rob:GiveReward"};--addEvents


RobDufflebag={};
RobberBlip={};
RobPlayerAnim={};

RobRewardBooster={};
RobRewardHideoutPerk={};



function createRobObjectsForPlayer(elem)
    if(elem and isElement(elem))then
        if(not(isElement(RobDufflebag[elem])))then
            RobDufflebag[elem]=createObject(3915,0,0,0);
            attachElementToBone(RobDufflebag[elem],elem,3,0.050,-0.1325,0.1,0,0,0);
            setElementCollisionsEnabled(RobDufflebag[elem],false);
        end
        if(not(isElement(RobberBlip[elem])))then
            RobberBlip[elem]=createBlipAttachedTo(elem,1,20,255,0,0,255,0,9999);
            setElementData(RobberBlip[elem],"Blip:Data:OnlyMinimap",true);
            setElementVisibleTo(RobberBlip[elem],root,true);
        end
    end
end

local function destroyElementsAfterQuitDead(player)
	if(isElement(RobDufflebag[player]))then
		destroyElement(RobDufflebag[player]);
		RobDufflebag[player]=nil;
    end
    if(isElement(RobberBlip[player]))then
        destroyElement(RobberBlip[player]);
        RobberBlip[player]=nil;
    end
end

addEventHandler("onPlayerQuit",root,function()
	destroyElementsAfterQuitDead(source);
end)
addEventHandler("onPlayerWasted",root,function()
	destroyElementsAfterQuitDead(source);
end)


addEventHandler("Rob:Sync:Animation",root,function(type)
    if(client and isElement(client)and getElementType(client)=="player" and isLoggedin(client))then
        if(type)then
            if(not(RobPlayerAnim[client]))then
                RobPlayerAnim[client]=true;
                setElementFrozen(client,true);
                setPedAnimation(client,"SHOP","SHP_Serve_Loop",-1,true,false,false);
            end
        else
            RobPlayerAnim[client]=nil;
            setElementFrozen(client,false);
            setPedAnimation(client);
        end
    end
end)


addEventHandler("Rob:GiveReward",root,function()
    if(client and isElement(client)and getElementType(client)=="player" and isLoggedin(client))then
        if(isPedDead(client))then
            return;
        end
        
        if(isElement(RobDufflebag[client]))then
            destroyElement(RobDufflebag[client]);
            RobDufflebag[client]=nil;
        end
        if(isElement(RobberBlip[client]))then
            destroyElement(RobberBlip[client]);
            RobberBlip[client]=nil;
        end

        --calculate monnies
        local BaseRobbedAmount=getElementData(client,"Player:Data:RobbedAmount");
        if(getPlayerJsonValue(client,"Booster","MoneyBoosterTime")>0)then--add booster percentage
            RobRewardBooster[client]=BaseRobbedAmount*getPlayerJsonValue(client,"Booster","MoneyBoosterPercentage")/100;
        end
        if(Hideout.Hideout.Benefits[tonumber(getPlayerJsonValue(client,"HideUpgrades","Hideout"))].Cash>0)then--add hideout perk percentage
            RobRewardHideoutPerk[client]=BaseRobbedAmount*Hideout.Hideout.Benefits[tonumber(getPlayerJsonValue(client,"HideUpgrades","Hideout"))].Cash/100;
        end

        --give reward
        addPlayerJsonValue(client,"Money","Black",math.floor(BaseRobbedAmount)+ math.floor(RobRewardBooster[client]or 0)+ math.floor(RobRewardHideoutPerk[client]));--give money
        removeElementData(client,"Player:Data:RobbedAmount");--reset robbed money
        triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Rob:GiveReward"):format(comma_value(math.floor(BaseRobbedAmount)+ math.floor(RobRewardBooster[client]or 0)+ math.floor(RobRewardHideoutPerk[client]))),"info",6000);

        --logs
        sendDiscordMessage({
            ID=4, Title="Money deliver", Desc=getPlayerName(client).." has delivered "..math.floor(BaseRobbedAmount)+ math.floor(RobRewardBooster[client]or 0)+ math.floor(RobRewardHideoutPerk[client])..".\n\nBase money: "..math.floor(BaseRobbedAmount).."\nBooster money: "..math.floor((RobRewardBooster[client]or 0)).."\nHideout perk money: "..math.floor((RobRewardHideoutPerk[client]or 0)).."",
            PlayerData={Name=getPlayerName(client),Serial=getPlayerSerial(client),},
        })


        --empty tables
        RobRewardBooster[client]=nil;
        RobRewardHideoutPerk[client]=nil;

        triggerClientEvent(client,"Rob:DeliverMarker",client);

        --[[ if(getPlayerJsonValue(client,"Booster","MoneyBoosterTime")>0)then
            Reward[client]=getElementData(client,"Player:Data:RobbedAmount")+getElementData(client,"Player:Data:RobbedAmount")*getPlayerJsonValue(client,"Booster","MoneyBoosterPercentage")/100;
        else
            Reward[client]=getElementData(client,"Player:Data:RobbedAmount");
        end
        RewardHideoutTierBoost[client]=getElementData(client,"Player:Data:RobbedAmount")*Hideout.Hideout.Benefits[tonumber(getPlayerJsonValue(client,"HideUpgrades","Hideout"))].Cash/100;
        

        if(Reward[client]and Reward[client]>0)then
            addPlayerJsonValue(client,"Money","Black",math.floor(Reward[client])+math.floor(RewardHideoutTierBoost[client]));
            removeElementData(client,"Player:Data:RobbedAmount");

            triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Rob:GiveReward"):format(comma_value(math.floor(Reward[client]+RewardHideoutTierBoost[client]))),"info",6000);

            local MaxMoney=Hideout.Dufflebag.Benefits[tonumber(getPlayerJsonValue(client,"HideUpgrades","Dufflebag"))].max or 8000;
            if(Hideout.Hideout.Benefits[tonumber(getPlayerJsonValue(client,"HideUpgrades","Hideout"))].Cash>0)then
            else
                sendDiscordMessage({
                    ID=4, Title="Money deliver", Desc=getPlayerName(client).." has delivered "..math.floor(Reward[client])+math.floor(RewardHideoutTierBoost[client]).."/"..MaxMoney.." money.",
                    PlayerData={Name=getPlayerName(client),Serial=getPlayerSerial(client),},
                })
            end

            Reward[client]=nil;
            RewardHideoutTierBoost[client]=nil;
        end
        triggerClientEvent(client,"Rob:DeliverMarker",client); ]]
    end
end)


addCommandHandler("giverobmoney",function(player,cmd,target,amount)
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
                        if(tonumber(amount)>0)then
                            setElementData(target,"Player:Data:RobbedAmount",tonumber(amount));
                            triggerClientEvent(target,"Rob:DeliverMarker",target,true);
                            createRobObjectsForPlayer(target);
                        end
                    end
                else
                    triggerClientEvent(player,"Notify:UI",player,"Player doesnt exist/is offline.","error",3000,true);
                end
            end
        end
    end
end)