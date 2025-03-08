addRemoteEvents{"Rob:Start:Shop"};--addEvents


local RobPed={};
local ObjectCol={};
local ObjectBlip={};
local GotRobbed={};
local ShopTimer={};

local RobPlayerMarker={};
local RobPlayerTimer={};


addEventHandler("onResourceStart",resourceRoot,function()
    for i,v in pairs(Robs["Shops"].Shop)do
        --[[ ObjectCol[i]=createColSphere(v.Pos[1],v.Pos[2],v.Pos[3],v.Col[1]); ]]
        ObjectCol[i]=createColRectangle(v.Zone[1],v.Zone[2],v.Zone[3],v.Zone[4]);
        GotRobbed[ObjectCol[i]]=nil;

        RobPed[ObjectCol[i]]=createPed(v.Ped[1],v.Ped[3],v.Ped[4],v.Ped[5],v.Ped[6]);
        setElementData(RobPed[ObjectCol[i]],"Ped:Data:Rob","Shop");
        setElementData(RobPed[ObjectCol[i]],"Ped:Data:Godmode",true);
        setElementData(RobPed[ObjectCol[i]],"Ped:Data:Nametag:Name",v.Ped[2]);
        setElementData(RobPed[ObjectCol[i]],"Ped:Data:Nametag:Title",v.Blip[2]);
        setElementData(RobPed[ObjectCol[i]],"Ped:Data:Nametag:Range",v.Range);
        setElementFrozen(RobPed[ObjectCol[i]],true);
        
        ObjectBlip[ObjectCol[i]]=createBlip(v.Ped[3],v.Ped[4],v.Ped[5],v.Blip[1],22,0,240,255,255,100);
        setElementData(ObjectBlip[ObjectCol[i]],"Blip:Data:Tooltip",v.Blip[2]);

        addEventHandler("onColShapeHit",ObjectCol[i],function(hitElem,dim)
            if(hitElem and isElement(hitElem)and getElementType(hitElem)=="player" and isLoggedin(hitElem)and dim)then
                if(not(isPedInVehicle(hitElem)))then
                    RobPlayerMarker[hitElem]=source;

                    if(isTimer(ShopTimer[source]))then
                        triggerClientEvent(hitElem,"Notify:UI",hitElem,loc(hitElem,"S:Rob:Shops:AlreadyRobbed"),"warning",4000);
                        return;
                    end
                    if(GotRobbed[source])then
                        triggerClientEvent(hitElem,"Notify:UI",hitElem,loc(hitElem,"S:Rob:Shops:AlreadyRobbed"),"warning",4000);
                        return;
                    end

                    setElementData(hitElem,"Player:Data:isRobbing","Shop");
                end
            end
        end)
        addEventHandler("onColShapeLeave",ObjectCol[i],function(hitElem,dim)
            if(hitElem and isElement(hitElem)and getElementType(hitElem)=="player" and isLoggedin(hitElem)and dim)then
                removeElementData(hitElem,"Player:Data:isRobbing");
                RobPlayerMarker[hitElem]=nil;

                if(isTimer(RobPlayerTimer[hitElem]))then
                    killTimer(RobPlayerTimer[hitElem]);
                    RobPlayerTimer[hitElem]=nil;
                end
            end
        end)
    end
end)


addEventHandler("Rob:Start:Shop",root,function()
    if(client and isElement(client)and getElementType(client)=="player" and isLoggedin(client))then
        if(isPedDead(client))then
            return;
        end
        if(not(RobPlayerMarker[client]))then
            return;
        end
        if(isTimer(ShopTimer[RobPlayerMarker[client]]))then
            triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Rob:Shops:AlreadyRobbed"),"warning",4000);
            return;
        end
        if(GotRobbed[RobPlayerMarker[client]])then
            triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Rob:Shops:AlreadyRobbed"),"warning",4000);
            return;
        end
        if(isTimer(RobPlayerTimer[client]))then
            return;
        end
        if(tonumber(#getElementsByType("player"))<Robs.PlayerRequired)then
            triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Rob:NotEnoughPlayers"):format(Robs.PlayerRequired),"warning",4000);
            return;
        end

        local playerStartX,playerStartY,playerStartZ=getElementPosition(client);
        for _,v in pairs(getElementsByType("player"))do
            if(v and isElement(v)and isLoggedin(v))then
                triggerClientEvent(v,"Notify:UI",v,loc(v,"S:Rob:Shops:Started"):format(getPlayerName(client),getZoneName(playerStartX,playerStartY,playerStartZ,false).." ("..getZoneName(playerStartX,playerStartY,playerStartZ,true)..")"),"warning",10000);
                outputChatBox(loc(v,"S:Rob:Shops:Started"):format(getPlayerName(client),getZoneName(playerStartX,playerStartY,playerStartZ,false).." ("..getZoneName(playerStartX,playerStartY,playerStartZ,true)..")"),v,255,255,60,false);
            end
        end

        if(not(getPlayerNotExistingJsonValue(client,"Stats","ShopsRobbed")))then
            setPlayerJsonValue(client,"Stats","ShopsRobbed",1);
        elseif(getPlayerNotExistingJsonValue(client,"Stats","ShopsRobbed"))then
            addPlayerJsonValue(client,"Stats","ShopsRobbed",1);
        end

        setPedAnimation(RobPed[RobPlayerMarker[client]],"shop","SHP_HandsUp_Scr",-1,false,true,true,nil,nil);

        setBlipColor(ObjectBlip[RobPlayerMarker[client]],255,60,60,255);

        GotRobbed[RobPlayerMarker[client]]=true;
        ShopTimer[RobPlayerMarker[client]]=setTimer(function(source)--reset timer
            setPedAnimation(RobPed[source]);
            setBlipColor(ObjectBlip[source],0,240,255,255);
            GotRobbed[source]=nil;
        end,Robs["Shops"].Timers.Reset,1,RobPlayerMarker[client])

        RobPlayerTimer[client]=setTimer(function(client)--rob timer
            local Reward=math.random(Robs["Shops"].RewardAmount[1],Robs["Shops"].RewardAmount[2]);
            local MaxMoney=Hideout.Dufflebag.Benefits[tonumber(getPlayerJsonValue(client,"HideUpgrades","Dufflebag"))]and Hideout.Dufflebag.Benefits[tonumber(getPlayerJsonValue(client,"HideUpgrades","Dufflebag"))].max;

            if(not(getElementData(client,"Player:Data:RobbedAmount")))then--set if element data doesnt exist
                setElementData(client,"Player:Data:RobbedAmount",0);
            end

            if(tonumber(getElementData(client,"Player:Data:RobbedAmount"))<MaxMoney)then
                if(tonumber(getElementData(client,"Player:Data:RobbedAmount"))+Reward>=MaxMoney)then
                    setElementData(client,"Player:Data:RobbedAmount",tonumber(MaxMoney));
                    triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Rob:Shops:RobbedAmount"):format(comma_value(Reward)),"info",10000,true);
                    
                    if(isTimer(RobPlayerTimer[client]))then
                        killTimer(RobPlayerTimer[client]);
                        RobPlayerTimer[client]=nil;
                    end
                else
                    setElementData(client,"Player:Data:RobbedAmount",getElementData(client,"Player:Data:RobbedAmount")+tonumber(Reward));
                    triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Rob:Shops:RobbedAmount"):format(comma_value(Reward)),"info",10000,true);
        
                    addPlayerJsonValue(client,"Stats","Bounty",math.floor(getElementData(client,"Player:Data:RobbedAmount")/100*Robs["Shops"].BountyPercentage));--give bounty
                end
    
                triggerClientEvent(client,"Rob:DeliverMarker",client,true);
                createRobObjectsForPlayer(client);
            end
        end,3*1000,math.random(Robs["Shops"].MaxRewards[1],Robs["Shops"].MaxRewards[2]),client)
    end
end)

local function destroyElementsAfterQuitDead(player)
    if(RobPlayerMarker[player])then
        RobPlayerMarker[player]=nil;
    end

    if(isTimer(RobPlayerTimer[player]))then
        killTimer(RobPlayerTimer[player]);
        RobPlayerTimer[player]=nil;
    end

    if(player and isElement(player))then
        removeElementData(player,"Player:Data:isRobbing");

        triggerClientEvent(player,"Rob:DeliverMarker",player);
    end
end

addEventHandler("onPlayerQuit",root,function()
	destroyElementsAfterQuitDead(source);
end)
addEventHandler("onPlayerWasted",root,function()
	destroyElementsAfterQuitDead(source);
end)