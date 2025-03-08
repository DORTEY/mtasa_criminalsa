addRemoteEvents{"Rob:Start:Warehouse","Rob:Warehouse:Sync:Rotation","Rob:Warehouse:GiveReward"};--addEvents


local AreaCol={};
local AreaCol2={};
local AreaColType={};
local AreaBlip={};
local AreaMarkers={};
local AreaTimer={};
local AreaGate={};
local AreaGateTimer={};
local AreaGateBomb={};

local RobPlayerArea={};
local RobPlayerMarker={};
local RobPlayerTimer={};


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
                            if(isPedInVehicle(player))then
                                local veh=getPedOccupiedVehicle(player);
                                if(veh and isElement(veh))then
                                    setElementPosition(veh,Robs["Warehouse"].Zones[tostring(area)].OutPos[1],Robs["Warehouse"].Zones[tostring(area)].OutPos[2],Robs["Warehouse"].Zones[tostring(area)].OutPos[3]);
                                    toggleGhostMode(veh,true,10000);
                                else
                                    setElementPosition(player,Robs["Warehouse"].Zones[tostring(area)].OutPos[1],Robs["Warehouse"].Zones[tostring(area)].OutPos[2],Robs["Warehouse"].Zones[tostring(area)].OutPos[3]);
                                    toggleGhostMode(player,true,10000);
                                end
                            else
                                setElementPosition(player,Robs["Warehouse"].Zones[tostring(area)].OutPos[1],Robs["Warehouse"].Zones[tostring(area)].OutPos[2],Robs["Warehouse"].Zones[tostring(area)].OutPos[3]);
                                toggleGhostMode(player,true,10000);
                            end
                            if(RobPlayerArea[player])then
                                RobPlayerArea[player]=nil;
                            end
                        end
                    end
                end
            end
        end
    end

    for i=1,999,1 do
        if(isElement(AreaMarkers[i]))then
            if(getElementData(AreaMarkers[i],"Marker:Data:Rob")=="Warehouse" and getElementData(AreaMarkers[i],"Marker:Data:Rob:Area")==area)then
                destroyElement(AreaMarkers[i]);
            end
        end
    end

    if(isElement(AreaGate[AreaColType[AreaCol[area]]]))then
        local x,y,z=getElementPosition(AreaGate[AreaColType[AreaCol[area]]]);
        setElementPosition(AreaGate[AreaColType[AreaCol[area]]],x,y,z+10);
    end
end


addEventHandler("onResourceStart",resourceRoot,function()
    for area,v in pairs(Robs["Warehouse"].Zones)do
        AreaCol[area]=createColRectangle(v.Zone[1],v.Zone[2],v.Zone[3],v.Zone[4]);
        AreaColType[AreaCol[area]]=tostring(area);
        setElementData(AreaCol[area],"Col:Data:Area",tostring(area));
        
        AreaBlip[AreaCol[area]]=createBlip(v.Blip[1],v.Blip[2],v.Blip[3],v.Blip[4],22,0,240,255,255,100);
        setElementData(AreaBlip[AreaCol[area]],"Blip:Data:Tooltip",v.Blip[8]);

        AreaCol2[area]=createColSphere(v.Gate[2],v.Gate[3],v.Gate[5],v.Gate[7]);
        AreaGate[AreaColType[AreaCol[area]]]=createObject(v.Gate[1],v.Gate[2],v.Gate[3],v.Gate[4],0,0,v.Gate[6]);

        addEventHandler("onColShapeHit",AreaCol2[area],function(hitElem,dim)
            if(hitElem and isElement(hitElem)and getElementType(hitElem)=="player" and isLoggedin(hitElem)and dim)then
                if(isElement(AreaGate[AreaColType[AreaCol[area]]]))then
                    if(not isKeyBound(hitElem,Server.MainInteractionKey,"down",startWarehouseRob))then
                        bindKey(hitElem,Server.MainInteractionKey,"down",startWarehouseRob);
                    end
                end
            end
        end)
        addEventHandler("onColShapeLeave",AreaCol2[area],function(hitElem,dim)
            if(hitElem and isElement(hitElem)and getElementType(hitElem)=="player" and isLoggedin(hitElem)and dim)then
                if(isKeyBound(hitElem,Server.MainInteractionKey,"down",startWarehouseRob))then
					unbindKey(hitElem,Server.MainInteractionKey,"down",startWarehouseRob);
				end
            end
        end)



        addEventHandler("onColShapeHit",AreaCol[area],function(hitElem,dim)
            if(hitElem and isElement(hitElem)and getElementType(hitElem)=="player" and isLoggedin(hitElem)and dim)then
                RobPlayerArea[hitElem]=source;
                if(not(isTimer(AreaTimer[AreaColType[source]])))then--reset timer
                    
                else
                    local remaining,_,_=getTimerDetails(AreaTimer[AreaColType[source]]);
                    triggerClientEvent(hitElem,"Notify:UI",hitElem,loc(hitElem,"S:Rob:TimeLeft"):format(formatMilliseconds(remaining)),"warning",5000);
                end
            end
        end)
        addEventHandler("onColShapeLeave",AreaCol[area],function(hitElem,dim)
            if(hitElem and isElement(hitElem)and getElementType(hitElem)=="player" and isLoggedin(hitElem)and dim)then
                if(isTimer(RobPlayerTimer[hitElem]))then
                    killTimer(RobPlayerTimer[hitElem]);
                    RobPlayerTimer[hitElem]=nil;
                end
            end
        end)
    end
end)

function startWarehouseRob(player)
    if(isPedDead(player))then
        return;
    end
    if(not(RobPlayerArea[player]))then
        return;
    end
    if(not(AreaColType[RobPlayerArea[player]]))then
        return;
    end
    if(isTimer(AreaTimer[AreaColType[RobPlayerArea[player]]]))then--reset timer
        triggerClientEvent(player,"Notify:UI",player,loc(player,"S:Rob:Warehouse:AlreadyRobbed"),"warning",4000);
        return;
    end
    if(getPlayerJsonValue(player,"Items","Dynamite")<Robs["Warehouse"].Zones[AreaColType[RobPlayerArea[player]]].RequiredItemAmount)then
        triggerClientEvent(player,"Notify:UI",player,loc(player,"S:Rob:Warehouse:NeedItem"):format(loc(player,"Item:Dynamite"),Robs["Warehouse"].Zones[AreaColType[RobPlayerArea[player]]].RequiredItemAmount),"warning",4000);
        return;
    end

    removePlayerJsonValue(player,"Items","Dynamite",Robs["Warehouse"].Zones[AreaColType[RobPlayerArea[player]]].RequiredItemAmount);

    setBlipColor(AreaBlip[RobPlayerArea[player]],255,60,60,255);

    setElementFrozen(player,true);
    setPedAnimation(player,"BOMBER","BOM_Plant_Loop",-1,true,false,false,true,nil);
    toggleAllControls(player,false);
    
    RobPlayerTimer[player]=setTimer(function(player)
        if(isElement(player))then
            local playerStartX,playerStartY,playerStartZ=getElementPosition(player);
            local playerRotX,playerRotY,playerRotZ=getElementRotation(player);
            for _,v in pairs(getElementsByType("player"))do
                if(v and isElement(v)and isLoggedin(v))then
                    --triggerClientEvent(v,"Notify:UI",v,loc(v,"S:Rob:Warehouse:Started"):format(getPlayerName(player),getZoneName(playerStartX,playerStartY,playerStartZ,false).." ("..getZoneName(playerStartX,playerStartY,playerStartZ,true)..")"),"warning",10000);
                    outputChatBox(loc(v,"S:Rob:Warehouse:Started"):format(getPlayerName(player),getZoneName(playerStartX,playerStartY,playerStartZ,false).." ("..getZoneName(playerStartX,playerStartY,playerStartZ,true)..")"),v,255,255,60,false);
                end
            end

            setPedAnimation(player);
            setElementFrozen(player,false);
            toggleAllControls(player,true);
        
            AreaGateBomb[AreaColType[RobPlayerArea[player]]]=createObject(1252,playerStartX,playerStartY,playerStartZ-0.9,90,0,playerRotZ);
            setElementCollisionsEnabled(AreaGateBomb[AreaColType[RobPlayerArea[player]]],false);
            setElementFrozen(AreaGateBomb[AreaColType[RobPlayerArea[player]]],true);
        
            
            AreaGateTimer[AreaColType[RobPlayerArea[player]]]=setTimer(function(area)
                if(isElement(player)and AreaColType[RobPlayerArea[player]])then
                    AreaTimer[AreaColType[RobPlayerArea[player]]]=setTimer(function(area)
                        resetRob(area);
                    end,Robs["Warehouse"].Timers.Reset,1,AreaColType[RobPlayerArea[player]])

                    local x,y,z=getElementPosition(AreaGate[AreaColType[RobPlayerArea[player]]]);
                    setElementPosition(AreaGate[AreaColType[RobPlayerArea[player]]],x,y,z-10);

                    --Explosion and bomb
                    createExplosion(x,y,z,6,nil);
                    if(isElement(AreaGateBomb[AreaColType[AreaCol[area]]]))then
                        destroyElement(AreaGateBomb[AreaColType[AreaCol[area]]]);
                    end
                    
                    --Markers
                    local AreaMarker=Robs["Warehouse"].Boxes[AreaColType[RobPlayerArea[player]]];
                    for i=1,#AreaMarker,1 do
                        AreaMarkers[i]=createMarker(AreaMarker[i].Pos[1],AreaMarker[i].Pos[2],AreaMarker[i].Pos[3],"cylinder",AreaMarker[i].Marker[1],0,255,0,70);
                        setElementData(AreaMarkers[i],"Marker:Data:Rob","Warehouse");
                        setElementData(AreaMarkers[i],"Marker:Data:Rob:Area",AreaColType[RobPlayerArea[player]]);
                        setElementData(AreaMarkers[i],"Marker:Data:Rotation",AreaMarker[i].Pos[4]);
            
                        addEventHandler("onMarkerHit",AreaMarkers[i],function(hitElem)
                            if(hitElem and isElement(hitElem)and getElementType(hitElem)=="player" and isLoggedin(hitElem))then
                                if(getElementDimension(hitElem)==getElementDimension(source))then
                                    if(not(isPedInVehicle(hitElem)))then
                                        if(isTimer(AreaTimer[AreaColType[RobPlayerArea[hitElem]]])and isElementWithinMarker(hitElem,source))then
                                            RobPlayerMarker[hitElem]=source;
                                            setElementData(hitElem,"Player:Data:MarkerRobAllowed",true);
                                            setElementData(hitElem,"Player:Data:isRobbing","Warehouse");
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
            end,Robs["Warehouse"].Timers.TillOpen2,1,AreaColType[RobPlayerArea[player]])
        end
    end,Robs["Warehouse"].Timers.TillOpen3,1,player)
end

local function destroyElementsAfterQuitDead(player)
    if(RobPlayerArea[player])then
        RobPlayerArea[player]=nil;
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


addEventHandler("Rob:Warehouse:Sync:Rotation",root,function(type)
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

addEventHandler("Rob:Warehouse:GiveReward",root,function()
    if(client and isElement(client)and getElementType(client)=="player" and isLoggedin(client))then

        if(isElement(RobPlayerMarker[client]))then
            destroyElement(RobPlayerMarker[client]);
            RobPlayerMarker[client]=nil;
        end

        --Random reward
        local RandomItem=math.random(1,#Robs["Warehouse"].Loot);
        local RandomAmount=math.random(Robs["Warehouse"].Loot[RandomItem].Amount[1],Robs["Warehouse"].Loot[RandomItem].Amount[2]);
        if(Robs["Warehouse"].Loot[RandomItem].Chance<=math.random(1,250))then
            if(Robs["Warehouse"].Loot[RandomItem].Item=="Cash")then
                addPlayerJsonValue(client,"Money","Cash",tonumber(RandomAmount));
                triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Rob:Warehouse:GotCash"):format(RandomAmount),"info",6000);
            else
                addPlayerJsonValue(client,"Items",tostring(Robs["Warehouse"].Loot[RandomItem].Item),tonumber(RandomAmount));
                triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Rob:Warehouse:GotItem"):format(loc(client,"Item:"..Robs["Warehouse"].Loot[RandomItem].Item),RandomAmount),"info",6000);
            end
        else
            triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Rob:GotNothing"),"error",4000);
        end

        removeElementData(client,"Player:Data:MarkerRobAllowed");
    end
end)