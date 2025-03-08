addRemoteEvents{"Rob:Start:ATM","Rob:ATM:Sync:Rotation","Rob:ATM:Sync:Effects:S"};--addEvents


local Object={};
local ObjectCol={};
local GotRobbed={};
local AtmTimer={};

local RobPlayerMarker={};
local RobPlayerMarker2={};
local RobPickups={};
local RobPickupID={};
local RobEffects={};


addEventHandler("onResourceStart",resourceRoot,function()
    for atmID,v in pairs(Robs["ATM"].ATMs)do
        ObjectCol[atmID]=createColSphere(v.Pos[1],v.Pos[2],v.Pos[3],v.Col[1]);
        setElementData(ObjectCol[atmID],"Col:Data:Type","ATM");
        GotRobbed[ObjectCol[atmID]]=nil;

        Object[ObjectCol[atmID]]=createObject(v.Object[1],v.Pos[1],v.Pos[2],v.Pos[3]-0.4,0,0,v.Pos[4]);
        setObjectBreakable(Object[ObjectCol[atmID]],false);
        setElementFrozen(Object[ObjectCol[atmID]],true);
        setElementDoubleSided(Object[ObjectCol[atmID]],true);
        
        local NewColPos=GetOffsetFromEntityInWorldCoords(Object[ObjectCol[atmID]],0,-0.5,v.Col[2]);
        if(v.Object[1]==1900)then
            setElementPosition(ObjectCol[atmID],NewColPos.x,NewColPos.y,NewColPos.z-0.5);
        else
            setElementPosition(ObjectCol[atmID],NewColPos.x,NewColPos.y,NewColPos.z);
        end

        addEventHandler("onColShapeHit",ObjectCol[atmID],function(hitElem,dim)
            if(hitElem and isElement(hitElem)and getElementType(hitElem)=="player" and isLoggedin(hitElem)and dim)then
                if(not(isPedInVehicle(hitElem)))then
                    RobPlayerMarker[hitElem]=source;
                    RobPlayerMarker2[hitElem]=atmID;

                    if(isTimer(AtmTimer[source]))then
                        triggerClientEvent(hitElem,"Notify:UI",hitElem,loc(hitElem,"S:Rob:ATM:AlreadyRobbed"),"warning",4000);
                        return;
                    end
                    if(GotRobbed[source])then
                        triggerClientEvent(hitElem,"Notify:UI",hitElem,loc(hitElem,"S:Rob:ATM:AlreadyRobbed"),"warning",4000);
                        return;
                    end

                    setElementData(hitElem,"Player:Data:MarkerRobAllowed",true);
                    setElementData(hitElem,"Player:Data:isRobbing","ATM");
                end
            end
        end)
        addEventHandler("onColShapeLeave",ObjectCol[atmID],function(hitElem,dim)
            if(hitElem and isElement(hitElem)and getElementType(hitElem)=="player" and isLoggedin(hitElem)and dim)then
                removeElementData(hitElem,"Player:Data:MarkerRobAllowed");
                removeElementData(hitElem,"Player:Data:isRobbing");
                RobPlayerMarker[hitElem]=nil;
            end
        end)
    end
end)


addEventHandler("Rob:Start:ATM",root,function()
    if(client and isElement(client)and getElementType(client)=="player" and isLoggedin(client))then
        if(isPedDead(client))then
            return;
        end
        if(not(RobPlayerMarker[client]))then
            return;
        end
        if(not(RobPlayerMarker2[client]))then
            return;
        end
        if(isTimer(AtmTimer[RobPlayerMarker[client]]))then
            triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Rob:ATM:AlreadyRobbed"),"warning",4000);
            return;
        end
        if(GotRobbed[RobPlayerMarker[client]])then
            triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Rob:ATM:AlreadyRobbed"),"warning",4000);
            return;
        end
        if(getPlayerJsonValue(client,"Items",Robs["ATM"].ATMs[RobPlayerMarker2[client]].RequiredItem[1])<Robs["ATM"].ATMs[RobPlayerMarker2[client]].RequiredItem[2])then
            triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Rob:ATM:NeedItem"):format(loc(client,"Item:"..Robs["ATM"].ATMs[RobPlayerMarker2[client]].RequiredItem[1])),"warning",4000);
            return;
        end
        if(tonumber(#getElementsByType("player"))<Robs.PlayerRequired)then
            triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Rob:NotEnoughPlayers"):format(Robs.PlayerRequired),"warning",4000);
            return;
        end

        if(not(getPlayerNotExistingJsonValue(client,"Stats","ATMsRobbed")))then
            setPlayerJsonValue(client,"Stats","ATMsRobbed",1);
        elseif(getPlayerNotExistingJsonValue(client,"Stats","ATMsRobbed"))then
            addPlayerJsonValue(client,"Stats","ATMsRobbed",1);
        end

        removePlayerJsonValue(client,"Items",Robs["ATM"].ATMs[RobPlayerMarker2[client]].RequiredItem[1],Robs["ATM"].ATMs[RobPlayerMarker2[client]].RequiredItem[2]);

        setElementModel(Object[RobPlayerMarker[client]],Robs["ATM"].ATMs[RobPlayerMarker2[client]].Object[2]);
        triggerClientEvent(root,"Rob:ATM:Sync:Effects:C",root,true,Object[RobPlayerMarker[client]]);

        table.insert(RobEffects,Object[RobPlayerMarker[client]]);--insert object for client side effect sync

        GotRobbed[RobPlayerMarker[client]]=true;
        AtmTimer[RobPlayerMarker[client]]=setTimer(function(source,oldID)--reset timer
            setElementModel(Object[source],oldID);
            GotRobbed[source]=nil;
            
            triggerClientEvent(root,"Rob:ATM:Sync:Effects:C",root,false,Object[source]);--remove client side effects
            for i,v in ipairs(RobEffects)do
                if(v==Object[source])then
                    table.remove(RobEffects,i);
                end
            end
            
            for i,v in pairs(RobPickups)do--delete money pickups if still exist
                if(v[1]==source)then
                    if(v[2]and isElement(v[2]))then
                        destroyElement(v[2]);
                        v[2]=nil;
                    end
                end
            end
        end,Robs["ATM"].Timers.Reset,1,RobPlayerMarker[client],Robs["ATM"].ATMs[RobPlayerMarker2[client]].Object[1])

        --create money pickups
        local x1,y1,z1=getPositionInFrontOfElement(Object[RobPlayerMarker[client]],tonumber(-2.0));
        local Random=math.random(Robs["ATM"].PickupAmount[1],Robs["ATM"].PickupAmount[2]);
        for i=1,Random,1 do
            if(Robs["ATM"].ATMs[RobPlayerMarker2[client]].Object[1]==1900)then
                Pickup=createPickup(x1+math.random(1,10)*.1,y1+math.random(1,10)*.1,z1-0.5,3,1212,50);
            else
                Pickup=createPickup(x1+math.random(1,10)*.1,y1+math.random(1,10)*.1,z1-0.1,3,1212,50);
            end
            RobPickupID[Pickup]=RobPlayerMarker2[client];

            addEventHandler("onPickupHit",Pickup,function(hitElem)
                if(hitElem and isElement(hitElem)and getElementType(hitElem)=="player" and isLoggedin(hitElem))then
                    if(not(isPedInVehicle(hitElem)))then
                        if(source and isElement(source))then
                            local Reward=math.random(Robs["ATM"].ATMs[RobPickupID[source]].RewardAmount[1],Robs["ATM"].ATMs[RobPickupID[source]].RewardAmount[2]);
                            local MaxMoney=Hideout.Dufflebag.Benefits[tonumber(getPlayerJsonValue(hitElem,"HideUpgrades","Dufflebag"))]and Hideout.Dufflebag.Benefits[tonumber(getPlayerJsonValue(hitElem,"HideUpgrades","Dufflebag"))].max;
                            
                            if(not(getElementData(hitElem,"Player:Data:RobbedAmount")))then--set if element data doesnt exist
                                setElementData(hitElem,"Player:Data:RobbedAmount",0);
                            end

                            if(tonumber(getElementData(hitElem,"Player:Data:RobbedAmount"))<MaxMoney)then
                                if(tonumber(getElementData(hitElem,"Player:Data:RobbedAmount"))+Reward>=MaxMoney)then
                                    setElementData(hitElem,"Player:Data:RobbedAmount",tonumber(MaxMoney));
                                    triggerClientEvent(hitElem,"Notify:UI",hitElem,loc(hitElem,"S:Rob:ATM:RobbedAmount"):format(comma_value(Reward)),"info",10000);
                                else
                                    setElementData(hitElem,"Player:Data:RobbedAmount",getElementData(hitElem,"Player:Data:RobbedAmount")+tonumber(Reward));
                                    triggerClientEvent(hitElem,"Notify:UI",hitElem,loc(hitElem,"S:Rob:ATM:RobbedAmount"):format(comma_value(Reward)),"info",10000);
                        
                                    addPlayerJsonValue(hitElem,"Stats","Bounty",math.floor(getElementData(hitElem,"Player:Data:RobbedAmount")/100*Robs["ATM"].BountyPercentage));--give bounty
                                end
                    
                                triggerClientEvent(hitElem,"Rob:DeliverMarker",hitElem,true);
                                createRobObjectsForPlayer(hitElem);

                                RobPickupID[source]=nil;
                                destroyElement(source);
                                source=nil;

                                triggerEvent("Tutorial:NextStep",hitElem,hitElem,"RobATM");
                            end
                        end
                    end
                end
            end)

            table.insert(RobPickups,{RobPlayerMarker[client],Pickup});
        end

        -- setElementModel(Object[RobPlayerMarker[client]],2943);
        -- triggerClientEvent(root,"Rob:ATM:Sync:Effects:C",root,true,Object[RobPlayerMarker[client]]);

        -- table.insert(RobEffects,Object[RobPlayerMarker[client]]);--insert object for client side effect sync

        -- GotRobbed[RobPlayerMarker[client]]=true;
        -- AtmTimer[RobPlayerMarker[client]]=setTimer(function(source)--reset timer
        --     setElementModel(Object[source],2942);
        --     GotRobbed[source]=nil;
            
        --     triggerClientEvent(root,"Rob:ATM:Sync:Effects:C",root,false,Object[source]);--remove client side effects
        --     for i,v in ipairs(RobEffects)do
        --         if(v==Object[source])then
        --             table.remove(RobEffects,i);
        --         end
        --     end
            
        --     for i,v in pairs(RobPickups)do--delete money pickups if still exist
        --         if(v[1]==source)then
        --             if(v[2]and isElement(v[2]))then
        --                 destroyElement(v[2]);
        --                 v[2]=nil;
        --             end
        --         end
        --     end
        -- end,Robs["ATM"].Timers.Reset,1,RobPlayerMarker[client])

        -- --create money pickups
        -- local x1,y1,z1=getPositionInFrontOfElement(Object[RobPlayerMarker[client]],tonumber(-2.4));
        -- local Random=math.random(Robs["ATM"].PickupAmount[1],Robs["ATM"].PickupAmount[2]);
        -- for i=1,Random,1 do
        --     local Pickup=createPickup(x1+math.random(1,30)*.1,y1+math.random(1,30)*.1,z1-0.1,3,1212,50);

        --     addEventHandler("onPickupHit",Pickup,function(hitElem)
        --         if(hitElem and isElement(hitElem)and getElementType(hitElem)=="player" and isLoggedin(hitElem))then
        --             if(not(isPedInVehicle(hitElem)))then
        --                 if(source and isElement(source))then
        --                     local Reward=math.random(Robs["ATM"].RewardAmount[1],Robs["ATM"].RewardAmount[2]);
        --                     local MaxMoney=Hideout.Dufflebag.Benefits[tonumber(getPlayerJsonValue(hitElem,"HideUpgrades","Dufflebag"))]and Hideout.Dufflebag.Benefits[tonumber(getPlayerJsonValue(hitElem,"HideUpgrades","Dufflebag"))].max;
                            
        --                     if(not(getElementData(hitElem,"Player:Data:RobbedAmount")))then--set if element data doesnt exist
        --                         setElementData(hitElem,"Player:Data:RobbedAmount",0);
        --                     end

        --                     if(tonumber(getElementData(hitElem,"Player:Data:RobbedAmount"))<MaxMoney)then
        --                         if(tonumber(getElementData(hitElem,"Player:Data:RobbedAmount"))+Reward>=MaxMoney)then
        --                             setElementData(hitElem,"Player:Data:RobbedAmount",tonumber(MaxMoney));
        --                             triggerClientEvent(hitElem,"Notify:UI",hitElem,loc(hitElem,"S:Rob:ATM:RobbedAmount"):format(comma_value(Reward)),"info",10000);
        --                         else
        --                             setElementData(hitElem,"Player:Data:RobbedAmount",getElementData(hitElem,"Player:Data:RobbedAmount")+tonumber(Reward));
        --                             triggerClientEvent(hitElem,"Notify:UI",hitElem,loc(hitElem,"S:Rob:ATM:RobbedAmount"):format(comma_value(Reward)),"info",10000);
                        
        --                             addPlayerJsonValue(hitElem,"Stats","Bounty",math.floor(getElementData(hitElem,"Player:Data:RobbedAmount")/100*Robs["ATM"].BountyPercentage));--give bounty
        --                         end
                    
        --                         triggerClientEvent(hitElem,"Rob:DeliverMarker",hitElem,true);
        --                         createRobObjectsForPlayer(hitElem);

        --                         destroyElement(source);
        --                         source=nil;

        --                         triggerEvent("Tutorial:NextStep",hitElem,hitElem,"RobATM");
        --                     end
        --                 end
        --             end
        --         end
        --     end)

        --     table.insert(RobPickups,{RobPlayerMarker[client],Pickup});
        -- end
    end
end)

local function destroyElementsAfterQuitDead(player)
    if(RobPlayerMarker[player])then
        RobPlayerMarker[player]=nil;
    end

    if(player and isElement(player))then
        removeElementData(player,"Player:Data:isRobbing");
        removeElementData(player,"Player:Data:MarkerRobAllowed");

        triggerClientEvent(player,"Rob:DeliverMarker",player);
    end
end

addEventHandler("onPlayerQuit",root,function()
	destroyElementsAfterQuitDead(source);
end)
addEventHandler("onPlayerWasted",root,function()
	destroyElementsAfterQuitDead(source);
end)


addEventHandler("Rob:ATM:Sync:Rotation",root,function(type)
    if(client and isElement(client)and getElementType(client)=="player" and isLoggedin(client))then
        if(type)then
            if(not(RobPlayerAnim[client]))then
                if(RobPlayerMarker[client])then
                    RobPlayerAnim[client]=true;
                    setElementFrozen(client,true);
                    setPedAnimation(client,"SHOP","SHP_Serve_Loop",-1,true,false,false);

                    local x,y,_=getElementPosition(client);
                    local x1,y1,_=getElementPosition(Object[RobPlayerMarker[client]]);
                    local rotZ=findRotation(x,y, x1,y1);

                    setElementRotation(client,0,0,rotZ);
                end
            end
        else
            RobPlayerAnim[client]=nil;
            setElementFrozen(client,false);
            setPedAnimation(client);
        end
    end
end)


addEventHandler("Rob:ATM:Sync:Effects:S",root,function()
    if(client and isElement(client)and getElementType(client)=="player")then
        for _,v in ipairs(RobEffects)do
            if(v and isElement(v))then
                triggerClientEvent(client,"Rob:ATM:Sync:Effects:C",client,true,v);
            end
        end
    end
end)