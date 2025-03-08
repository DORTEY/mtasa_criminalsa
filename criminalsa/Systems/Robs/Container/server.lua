addRemoteEvents{"Rob:Start:Container","Rob:Container:Sync:Rotation","Rob:Load:Bots:Container"};--addEvents


local AreaCol={};
local AreaColType={};
local AreaBlip={};
local AreaTimer={};
local AreaPickups={};
local AreaBots={};

local ContainerObject={};
local ContainerCol={};
local ContainerStatus={};

local RobPlayerMarker={};
local RobPlayerArea={};


local function resetRob(area)
    for _,v in pairs(getElementsByType("object"))do
        if(v and isElement(v))then
            if(getElementData(v,"Obj:Data:Area")==tostring(area))then
                if(getElementModel(v)==3193)then
                    setElementModel(v,3106);
                end
            end
        end
    end

    for _,col in pairs(getElementsByType("colshape"))do
        if(col and isElement(col))then
            if(getElementData(col,"Col:Data:Area")==tostring(area))then
                if(ContainerStatus[col])then
                    ContainerStatus[col]=nil;
                end

                if(AreaBlip[col])then
                    setBlipColor(AreaBlip[col],0,240,255,255);
                end

                for _,player in pairs(getElementsByType("player"))do
                    if(player and isElement(player)and isLoggedin(player))then
                        if(isElementWithinColShape(player,col))then
                            setElementPosition(player,Robs["Container"].Zones[tostring(area)].OutPos[1],Robs["Container"].Zones[tostring(area)].OutPos[2],Robs["Container"].Zones[tostring(area)].OutPos[3]);
                            if(RobPlayerArea[player])then
                                RobPlayerArea[player]=nil;
                            end
                        end
                    end
                end
                

                for pickupKey,pickup in pairs(AreaPickups)do--delete money pickups if still exist
                    if(pickup[1]==col)then
                        if(pickup[2]and isElement(pickup[2]))then
                            destroyElement(pickup[2]);
                            table.removevalue(AreaPickups,pickupKey);
                        end
                    end
                end
            end
        end
    end

    loadContainerBots(tostring(area));
end


addEventHandler("onResourceStart",resourceRoot,function()
    for area,v in pairs(Robs["Container"].Zones)do
        AreaCol[area]=createColRectangle(v.Zone[1],v.Zone[2],v.Zone[3],v.Zone[4]);
        AreaColType[AreaCol[area]]=tostring(area);
        setElementData(AreaCol[area],"Col:Data:Area",tostring(area));
        
        AreaBlip[AreaCol[area]]=createBlip(v.Blip[1],v.Blip[2],v.Blip[3],v.Blip[4],22,v.Blip[5],v.Blip[6],v.Blip[7],255,100);
        setElementData(AreaBlip[AreaCol[area]],"Blip:Data:Tooltip",v.Blip[8]);




        addEventHandler("onColShapeHit",AreaCol[area],function(hitElem,dim)
            if(hitElem and isElement(hitElem)and getElementType(hitElem)=="player" and isLoggedin(hitElem)and dim)then
                RobPlayerArea[hitElem]=source;
                if(not(isTimer(AreaTimer[AreaColType[source]])))then--reset timer
                    local playerStartX,playerStartY,playerStartZ=getElementPosition(hitElem);
                    for _,v in pairs(getElementsByType("player"))do
                        if(v and isElement(v)and isLoggedin(v))then
                            triggerClientEvent(v,"Notify:UI",v,loc(v,"S:Rob:Container:Started"):format(getPlayerName(hitElem),getZoneName(playerStartX,playerStartY,playerStartZ,false).." ("..getZoneName(playerStartX,playerStartY,playerStartZ,true)..")"),"warning",10000);
                            outputChatBox(loc(v,"S:Rob:Container:Started"):format(getPlayerName(hitElem),getZoneName(playerStartX,playerStartY,playerStartZ,false).." ("..getZoneName(playerStartX,playerStartY,playerStartZ,true)..")"),v,255,255,60,false);
                        end
                    end

                    setBlipColor(AreaBlip[source],255,255,60,255);

                    AreaTimer[AreaColType[source]]=setTimer(function(area)
                        resetRob(area);
                    end,Robs["Container"].Timers.Reset,1,AreaColType[source])
                else
                    local remaining,_,_=getTimerDetails(AreaTimer[AreaColType[source]]);
                    triggerClientEvent(hitElem,"Notify:UI",hitElem,loc(hitElem,"S:Rob:TimeLeft"):format(formatMilliseconds(remaining)),"warning",5000);
                end
            end
        end)

        addEventHandler("onColShapeLeave",AreaCol[area],function(hitElem,dim)
            if(hitElem and isElement(hitElem)and getElementType(hitElem)=="player" and isLoggedin(hitElem)and dim)then
                RobPlayerArea[hitElem]=nil;
            end
        end)
    end

    for area,_ in pairs(Robs["Container"].Containers)do

        for id,v in pairs(Robs["Container"].Containers[tostring(area)])do
            ContainerCol[id]=createColSphere(v.Pos[1],v.Pos[2],v.Pos[3],v.Col[1]);
            setElementData(ContainerCol[id],"Col:Data:Area",tostring(area));
            setElementData(ContainerCol[id],"Col:Data:Type","Container");
            
            ContainerObject[ContainerCol[id]]=createObject(3106,v.Pos[1],v.Pos[2],v.Pos[3],0,0,v.Pos[4]);
            setObjectBreakable(ContainerObject[ContainerCol[id]],false);
            setElementFrozen(ContainerObject[ContainerCol[id]],true);
            setElementDoubleSided(ContainerObject[ContainerCol[id]],true);
            setElementData(ContainerObject[ContainerCol[id]],"Obj:Data:Area",tostring(area));

            local NewColPos=GetOffsetFromEntityInWorldCoords(ContainerObject[ContainerCol[id]],-5.5,0,0.5);
            setElementPosition(ContainerCol[id],NewColPos.x,NewColPos.y,NewColPos.z);


            addEventHandler("onColShapeHit",ContainerCol[id],function(hitElem,dim)
                if(hitElem and isElement(hitElem)and getElementType(hitElem)=="player" and isLoggedin(hitElem)and dim)then
                    if(not(isPedInVehicle(hitElem)))then
                        RobPlayerMarker[hitElem]=source;
    
                        if(ContainerStatus[source])then
                            triggerClientEvent(hitElem,"Notify:UI",hitElem,loc(hitElem,"S:Rob:Container:AlreadyRobbed"),"warning",4000);
                            return;
                        end
    
                        setElementData(hitElem,"Player:Data:MarkerRobAllowed",true);
                        setElementData(hitElem,"Player:Data:isRobbing","Container");
                    end
                end
            end)

            addEventHandler("onColShapeLeave",ContainerCol[id],function(hitElem,dim)
                if(hitElem and isElement(hitElem)and getElementType(hitElem)=="player" and isLoggedin(hitElem)and dim)then
                    removeElementData(hitElem,"Player:Data:MarkerRobAllowed");
                    removeElementData(hitElem,"Player:Data:isRobbing");
                    RobPlayerMarker[hitElem]=nil;
                end
            end)
        end

    end
end)

addEventHandler("Rob:Start:Container",root,function()
    if(client and isElement(client)and getElementType(client)=="player" and isLoggedin(client))then
        if(isPedDead(client))then
            return;
        end
        if(not(RobPlayerMarker[client]))then
            return;
        end
        if(not(RobPlayerArea[client]))then
            return;
        end
        if(ContainerStatus[RobPlayerMarker[client]])then
            triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Rob:Container:AlreadyRobbed"),"warning",4000);
            return;
        end
        if(getPlayerJsonValue(client,"Items","Crowbar")<1)then
            triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Rob:Container:NeedItem"):format(loc(client,"Item:Crowbar")),"warning",4000);
            return;
        end

        removePlayerJsonValue(client,"Items","Crowbar",1);

        setElementModel(ContainerObject[RobPlayerMarker[client]],3193);

        ContainerStatus[RobPlayerMarker[client]]=true;

        if(not(getPlayerNotExistingJsonValue(client,"Stats","ContainersRobbed")))then
            setPlayerJsonValue(client,"Stats","ContainersRobbed",1);
        elseif(getPlayerNotExistingJsonValue(client,"Stats","ContainersRobbed"))then
            addPlayerJsonValue(client,"Stats","ContainersRobbed",1);
        end

        --create money pickups
        local Random=math.random(Robs["Container"].PickupAmount[1],Robs["Container"].PickupAmount[2]);
        for i=1,Random,1 do
            local dropPos=GetOffsetFromEntityInWorldCoords(ContainerObject[RobPlayerMarker[client]],math.random(1,i),0,0);
            local Pickup=createPickup(dropPos.x,dropPos.y,dropPos.z-0.3,3,1212,50);

            addEventHandler("onPickupHit",Pickup,function(hitElem)
                if(hitElem and isElement(hitElem)and getElementType(hitElem)=="player" and isLoggedin(hitElem))then
                    if(not(isPedInVehicle(hitElem)))then
                        if(source and isElement(source))then
                            local Reward=math.random(Robs["Container"].RewardAmount[1],Robs["Container"].RewardAmount[2]);
                            local MaxMoney=Hideout.Dufflebag.Benefits[tonumber(getPlayerJsonValue(hitElem,"HideUpgrades","Dufflebag"))]and Hideout.Dufflebag.Benefits[tonumber(getPlayerJsonValue(hitElem,"HideUpgrades","Dufflebag"))].max;

                            if(not(getElementData(hitElem,"Player:Data:RobbedAmount")))then--set if element data doesnt exist
                                setElementData(hitElem,"Player:Data:RobbedAmount",0);
                            end

                            if(tonumber(getElementData(hitElem,"Player:Data:RobbedAmount"))<MaxMoney)then
                                if(tonumber(getElementData(hitElem,"Player:Data:RobbedAmount"))+Reward>=MaxMoney)then
                                    setElementData(hitElem,"Player:Data:RobbedAmount",tonumber(MaxMoney));
                                    triggerClientEvent(hitElem,"Notify:UI",hitElem,loc(hitElem,"S:Rob:Container:RobbedAmount"):format(comma_value(Reward)),"info",10000);
                                else
                                    setElementData(hitElem,"Player:Data:RobbedAmount",getElementData(hitElem,"Player:Data:RobbedAmount")+tonumber(Reward));
                                    triggerClientEvent(hitElem,"Notify:UI",hitElem,loc(hitElem,"S:Rob:Container:RobbedAmount"):format(comma_value(Reward)),"info",10000);
                        
                                    addPlayerJsonValue(hitElem,"Stats","Bounty",math.floor(getElementData(hitElem,"Player:Data:RobbedAmount")/100*Robs["Container"].BountyPercentage));--give bounty
                                end
                    
                                triggerClientEvent(hitElem,"Rob:DeliverMarker",hitElem,true);
                                createRobObjectsForPlayer(hitElem);

                                destroyElement(source);
                                source=nil;

                                removeElementData(hitElem,"Player:Data:MarkerRobAllowed");
                            end
                        end
                    end
                end
            end)

            table.insert(AreaPickups,{RobPlayerArea[client],Pickup});
        end
    end
end)

local function destroyElementsAfterQuitDead(player)
    if(RobPlayerMarker[player])then
        RobPlayerMarker[player]=nil;
    end
    if(RobPlayerArea[player])then
        RobPlayerArea[player]=nil;
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


addEventHandler("Rob:Container:Sync:Rotation",root,function(type)
    if(client and isElement(client)and getElementType(client)=="player" and isLoggedin(client))then
        if(type)then
            if(not(RobPlayerAnim[client]))then
                if(RobPlayerMarker[client])then
                    RobPlayerAnim[client]=true;
                    setElementFrozen(client,true);
                    setPedAnimation(client,"SHOP","SHP_Serve_Loop",-1,true,false,false);

                    local x,y,_=getElementPosition(client);
                    local x1,y1,_=getElementPosition(ContainerObject[RobPlayerMarker[client]]);
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


function loadContainerBots(area)
    if(Robs["Container"].NPCs[tostring(area)])then
        for _,pedData in pairs(AreaBots)do--delete old peds if already existing
            if(pedData[1]==tostring(area))then
                if(pedData[2] and isElement(pedData[2]))then
                    destroyElement(pedData[2]);
                end
            end
        end

        for _,v in pairs(Robs["Container"].NPCs[tostring(area)])do
            Ped=createPed(v.Ped[1],v.Pos[1],v.Pos[2],v.Pos[3],v.Pos[4],true);
            setElementData(Ped,"Bot:Data:Rob",true);
            setElementData(Ped,"Bot:Data:Type",v.Type);
            setElementData(Ped,"Ped:Data:Nametag:Title",v.Ped[2]);
            setElementData(Ped,"Ped:Data:Nametag:Range",v.Range);

            setElementFrozen(Ped,true);
            giveWeapon(Ped,v.Weapon,99999,true);

            if(v.Type=="Security:Elite")then
                setElementData(Ped,"Ped:Data:Health",250);
                setElementData(Ped,"Ped:Data:MaxHealth",250);
            else
                setElementData(Ped,"Ped:Data:Health",100);
                setElementData(Ped,"Ped:Data:MaxHealth",100);
            end

            table.insert(AreaBots,{tostring(area),Ped,v.Range});
        end



        for _,player in pairs(getElementsByType("player"))do
            if(player and isElement(player)and isLoggedin(player))then
                triggerClientEvent(player,"Rob:Load:Bots:C",player,true,AreaBots);
            end
        end
    end
end
loadContainerBots("Container_LS");
loadContainerBots("Container_SF");

addEventHandler("Rob:Load:Bots:Container",root,function()
    if(client and isElement(client)and getElementType(client)=="player")then
        triggerClientEvent(client,"Rob:Load:Bots:C",client,true,AreaBots);
    end
end)