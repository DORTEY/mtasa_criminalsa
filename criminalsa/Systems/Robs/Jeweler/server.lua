addRemoteEvents{"Rob:Start:Jewelery","Rob:Jewelery:Sync:Rotation","Rob:Jewelery:GiveReward","Rob:Load:Bots:Jewelery"};--addEvents


local AreaCol={};
local AreaColType={};
local AreaBlip={};
local AreaTimer={};
local AreaMarkers={};
local AreaPed={};
local AreaBots={};

local RobPlayerArea={};
local RobPlayerMarker={};


local function resetRob(area)
    for _,col in pairs(getElementsByType("colshape"))do
        if(col and isElement(col))then
            if(getElementData(col,"Col:Data:Area")==tostring(area))then
                if(AreaBlip[col])then
                    setBlipColor(AreaBlip[col],0,240,255,255);
                end

                for _,player in pairs(getElementsByType("player"))do
                    if(player and isElement(player)and isLoggedin(player))then
                        if(isElementWithinColShape(player,col))then
                            setElementPosition(player,Robs["Jewelery"].Zones[tostring(area)].OutPos[1],Robs["Jewelery"].Zones[tostring(area)].OutPos[2],Robs["Jewelery"].Zones[tostring(area)].OutPos[3]);
                            if(RobPlayerArea[player])then
                                RobPlayerArea[player]=nil;
                            end
                            if(RobPlayerMarker[player])then
                                RobPlayerMarker[player]=nil;
                            end
                        end
                    end
                end
            end
        end
    end

    for i=1,999,1 do
        if(isElement(AreaMarkers[i]))then
            if(getElementData(AreaMarkers[i],"Marker:Data:Rob")=="Jewelery" and getElementData(AreaMarkers[i],"Marker:Data:Rob:Area")==area)then
                destroyElement(AreaMarkers[i]);
            end
        end
    end

    loadJeweleryBots(tostring(area));
end


addEventHandler("onResourceStart",resourceRoot,function()
    for area,v in pairs(Robs["Jewelery"].Zones)do
        AreaCol[area]=createColRectangle(v.Zone[1],v.Zone[2],v.Zone[3],v.Zone[4]);
        AreaColType[AreaCol[area]]=tostring(area);
        setElementData(AreaCol[area],"Col:Data:Area",tostring(area));
        
        AreaBlip[AreaCol[area]]=createBlip(v.Blip[1],v.Blip[2],v.Blip[3],v.Blip[4],22,v.Blip[5],v.Blip[6],v.Blip[7],255,100);
        setElementData(AreaBlip[AreaCol[area]],"Blip:Data:Tooltip",v.Blip[8]);

        AreaPed[AreaCol[area]]=createPed(v.Ped[5],v.Ped[1],v.Ped[2],v.Ped[3],v.Ped[4]);
        setElementData(AreaPed[AreaCol[area]],"Ped:Data:Rob","Jewelery");
        setElementData(AreaPed[AreaCol[area]],"Ped:Data:Godmode",true);
        setElementData(AreaPed[AreaCol[area]],"Ped:Data:Nametag:Name",v.Ped[6]);
        setElementData(AreaPed[AreaCol[area]],"Ped:Data:Nametag:Title",v.Blip[8]);
        setElementData(AreaPed[AreaCol[area]],"Ped:Data:Nametag:Range",8);
        setElementFrozen(AreaPed[AreaCol[area]],true);




        addEventHandler("onColShapeHit",AreaCol[area],function(hitElem,dim)
            if(hitElem and isElement(hitElem)and getElementType(hitElem)=="player" and isLoggedin(hitElem)and dim)then
                RobPlayerArea[hitElem]=source;

                if(isTimer(AreaTimer[AreaColType[source]]))then--reset timer
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
end)

addEventHandler("Rob:Start:Jewelery",root,function()
    if(client and isElement(client)and getElementType(client)=="player" and isLoggedin(client))then
        if(isPedDead(client))then
            return;
        end
        if(not(RobPlayerArea[client]))then
            return;
        end
        if(isTimer(AreaTimer[AreaColType[RobPlayerArea[client]]]))then
            local remaining,_,_=getTimerDetails(AreaTimer[AreaColType[RobPlayerArea[client]]]);
            triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Rob:TimeLeft"):format(formatMilliseconds(remaining)),"warning",5000);
            return;
        end
        if(tonumber(#getElementsByType("player"))<Robs.PlayerRequired)then
            triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Rob:NotEnoughPlayers"):format(Robs.PlayerRequired),"warning",4000);
            return;
        end


        AreaTimer[AreaColType[RobPlayerArea[client]]]=setTimer(function(area)--reset timer
            resetRob(area);
        end,Robs["Jewelery"].Timers.Reset,1,AreaColType[RobPlayerArea[client]])

        setPedAnimation(AreaPed[RobPlayerArea[client]],"shop","SHP_HandsUp_Scr",-1,false,true,true,nil,nil);
        setBlipColor(AreaBlip[RobPlayerArea[client]],255,255,60,255);

        local playerStartX,playerStartY,playerStartZ=getElementPosition(client);
        for _,v in pairs(getElementsByType("player"))do
            if(v and isElement(v)and isLoggedin(v))then
                triggerClientEvent(v,"Notify:UI",v,loc(v,"S:Rob:Jeweler:Started"):format(getPlayerName(client),getZoneName(playerStartX,playerStartY,playerStartZ,false).." ("..getZoneName(playerStartX,playerStartY,playerStartZ,true)..")"),"warning",10000);
                outputChatBox(loc(v,"S:Rob:Jeweler:Started"):format(getPlayerName(client),getZoneName(playerStartX,playerStartY,playerStartZ,false).." ("..getZoneName(playerStartX,playerStartY,playerStartZ,true)..")"),v,255,255,60,false);
            end
        end

        if(not(getPlayerNotExistingJsonValue(client,"Stats","JewelerysRobbed")))then
            setPlayerJsonValue(client,"Stats","JewelerysRobbed",1);
        elseif(getPlayerNotExistingJsonValue(client,"Stats","JewelerysRobbed"))then
            addPlayerJsonValue(client,"Stats","JewelerysRobbed",1);
        end

        --Markers
        local AreaMarker=Robs["Jewelery"].Cases[AreaColType[RobPlayerArea[client]]];
        for i=1,#AreaMarker,1 do
            AreaMarkers[i]=createMarker(AreaMarker[i].Pos[1],AreaMarker[i].Pos[2],AreaMarker[i].Pos[3],"cylinder",AreaMarker[i].Marker[1],0,255,0,70);
            setElementData(AreaMarkers[i],"Marker:Data:Rob","Jewelery");
            setElementData(AreaMarkers[i],"Marker:Data:Rob:Area",AreaColType[RobPlayerArea[client]]);
            setElementData(AreaMarkers[i],"Marker:Data:Rotation",AreaMarker[i].Pos[4]);
            
            addEventHandler("onMarkerHit",AreaMarkers[i],function(hitElem)
                if(hitElem and isElement(hitElem)and getElementType(hitElem)=="player" and isLoggedin(hitElem))then
                    if(getElementDimension(hitElem)==getElementDimension(source))then
                        if(not(isPedInVehicle(hitElem)))then
                            if(isTimer(AreaTimer[AreaColType[RobPlayerArea[hitElem]]])and isElementWithinMarker(hitElem,source))then
                                RobPlayerMarker[hitElem]=source;
                                setElementData(hitElem,"Player:Data:MarkerRobAllowed",true);
                                setElementData(hitElem,"Player:Data:isRobbing","Jewelery");
                            end
                        end
                    end
                end
            end)
            addEventHandler("onMarkerLeave",AreaMarkers[i],function(hitElem)
                if(hitElem and isElement(hitElem)and getElementType(hitElem)=="player" and isLoggedin(hitElem))then
                    if(getElementDimension(hitElem)==getElementDimension(source))then
                        removeElementData(hitElem,"Player:Data:MarkerRobAllowed");
                    end
                end
            end)
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


addEventHandler("Rob:Jewelery:Sync:Rotation",root,function(type)
    if(client and isElement(client)and getElementType(client)=="player" and isLoggedin(client))then
        if(type)then
            if(not(RobPlayerAnim[client]))then
                if(RobPlayerMarker[client])then
                    RobPlayerAnim[client]=true;
                    setElementFrozen(client,true);
                    setPedAnimation(client,"SHOP","SHP_Serve_Loop",-1,true,false,false);

                    if(RobPlayerMarker[client]and getElementData(RobPlayerMarker[client],"Marker:Data:Rotation"))then
                        setElementRotation(client,0,0,getElementData(RobPlayerMarker[client],"Marker:Data:Rotation"));
                    end
                end
            end
        else
            RobPlayerAnim[client]=nil;
            setElementFrozen(client,false);
            setPedAnimation(client);
        end
    end
end)

addEventHandler("Rob:Jewelery:GiveReward",root,function()
    if(client and isElement(client)and getElementType(client)=="player" and isLoggedin(client))then


        local Reward=math.random(Robs["Jewelery"].RewardAmount[1],Robs["Jewelery"].RewardAmount[2]);
        local MaxMoney=Hideout.Dufflebag.Benefits[tonumber(getPlayerJsonValue(client,"HideUpgrades","Dufflebag"))]and Hideout.Dufflebag.Benefits[tonumber(getPlayerJsonValue(client,"HideUpgrades","Dufflebag"))].max;

        if(not(getElementData(client,"Player:Data:RobbedAmount")))then--set if element data doesnt exist
            setElementData(client,"Player:Data:RobbedAmount",0);
        end

        if(tonumber(getElementData(client,"Player:Data:RobbedAmount"))<MaxMoney)then
            if(tonumber(getElementData(client,"Player:Data:RobbedAmount"))+Reward>=MaxMoney)then
                setElementData(client,"Player:Data:RobbedAmount",tonumber(MaxMoney));
                triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Rob:Jeweler:RobbedAmount"):format(comma_value(Reward)),"info",10000);
            else
                setElementData(client,"Player:Data:RobbedAmount",getElementData(client,"Player:Data:RobbedAmount")+tonumber(Reward));
                triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Rob:Jeweler:RobbedAmount"):format(comma_value(Reward)),"info",10000);
        
                addPlayerJsonValue(client,"Stats","Bounty",math.floor(getElementData(client,"Player:Data:RobbedAmount")/100*Robs["Jewelery"].BountyPercentage));--give bounty
            end
        
            triggerClientEvent(client,"Rob:DeliverMarker",client,true);
            createRobObjectsForPlayer(client);

            if(isElement(RobPlayerMarker[client]))then
                destroyElement(RobPlayerMarker[client]);
                RobPlayerMarker[client]=nil;
            end

            removeElementData(client,"Player:Data:MarkerRobAllowed");
        end
    end
end)


function loadJeweleryBots(area)
    if(Robs["Jewelery"].NPCs[tostring(area)])then
        for _,pedData in pairs(AreaBots)do--delete old peds if already existing
            if(pedData[1]==tostring(area))then
                if(pedData[2] and isElement(pedData[2]))then
                    destroyElement(pedData[2]);
                end
            end
        end

        for _,v in pairs(Robs["Jewelery"].NPCs[tostring(area)])do
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
loadJeweleryBots("Jewelery_LS");

addEventHandler("Rob:Load:Bots:Jewelery",root,function()
    if(client and isElement(client)and getElementType(client)=="player")then
        triggerClientEvent(client,"Rob:Load:Bots:C",client,true,AreaBots);
    end
end)