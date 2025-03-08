local AreaCol={};
local AreaColType={};
local AreaBlip={};
local AreaTimer={};

local OilMarker={};

local RobPlayerMarker={};
local RobPlayerArea={};
local RobPlayerTimer={};


local function resetRob(area)
    for _,v in pairs(Robs["Oilrig"].Rigs[tostring(area)])do
        for _,marker in pairs(getElementsByType("marker"))do
            if(marker and isElement(marker))then
                if(getElementData(marker,"Marker:Data:Area")==tostring(area))then
                    local MarkerAmount=math.random(v.Amount[1],v.Amount[2]);
                    setElementData(marker,"Marker:Data:Amount",MarkerAmount);
                    setElementData(marker,"Marker:Data:MaxAmount",MarkerAmount);
                end
            end
        end
    end

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
                                    setElementPosition(veh,Robs["Oilrig"].Zones[tostring(area)].OutPos[1],Robs["Oilrig"].Zones[tostring(area)].OutPos[2],Robs["Oilrig"].Zones[tostring(area)].OutPos[3]);
                                    toggleGhostMode(veh,true,10000);
                                else
                                    setElementPosition(player,Robs["Oilrig"].Zones[tostring(area)].OutPos[1],Robs["Oilrig"].Zones[tostring(area)].OutPos[2],Robs["Oilrig"].Zones[tostring(area)].OutPos[3]);
                                    toggleGhostMode(player,true,10000);
                                end
                            else
                                setElementPosition(player,Robs["Oilrig"].Zones[tostring(area)].OutPos[1],Robs["Oilrig"].Zones[tostring(area)].OutPos[2],Robs["Oilrig"].Zones[tostring(area)].OutPos[3]);
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
end


addEventHandler("onResourceStart",resourceRoot,function()
    for area,v in pairs(Robs["Oilrig"].Zones)do
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
                            triggerClientEvent(v,"Notify:UI",v,loc(v,"S:Rob:Oilrig:Started"):format(getPlayerName(hitElem),getZoneName(playerStartX,playerStartY,playerStartZ,false).." ("..getZoneName(playerStartX,playerStartY,playerStartZ,true)..")"),"warning",10000);
                            outputChatBox(loc(v,"S:Rob:Oilrig:Started"):format(getPlayerName(hitElem),getZoneName(playerStartX,playerStartY,playerStartZ,false).." ("..getZoneName(playerStartX,playerStartY,playerStartZ,true)..")"),v,255,255,60,false);
                        end
                    end

                    setBlipColor(AreaBlip[source],255,255,60,255);

                    AreaTimer[AreaColType[source]]=setTimer(function(area)
                        resetRob(area);
                    end,Robs["Oilrig"].Timers.Reset,1,AreaColType[source])
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

    for area,_ in pairs(Robs["Oilrig"].Rigs)do

        for id,v in pairs(Robs["Oilrig"].Rigs[tostring(area)])do
            OilMarker[id]=createMarker(v.Pos[1],v.Pos[2],v.Pos[3],"cylinder",v.Marker[1],0,0,0,100);
            setElementData(OilMarker[id],"Marker:Data:Area",tostring(area));
            local MarkerAmount=math.random(v.Amount[1],v.Amount[2]);
            setElementData(OilMarker[id],"Marker:Data:Amount",MarkerAmount);
            setElementData(OilMarker[id],"Marker:Data:MaxAmount",MarkerAmount);


            addEventHandler("onMarkerHit",OilMarker[id],function(hitElem,dim)
                if(hitElem and isElement(hitElem)and getElementType(hitElem)=="player" and isLoggedin(hitElem)and dim)then
                    if(not(isPedInVehicle(hitElem)))then
                        if(not(RobPlayerArea[hitElem]))then
                            return;
                        end

                        RobPlayerMarker[hitElem]=source;
                                                    
                        if(not(getElementData(hitElem,"Player:Data:RobbedAmount")))then--set if element data doesnt exist
                            setElementData(hitElem,"Player:Data:RobbedAmount",0);
                        end
    
                        local Reward=Robs["Oilrig"].RewardAmount;
                        local MaxMoney=Hideout.Dufflebag.Benefits[tonumber(getPlayerJsonValue(hitElem,"HideUpgrades","Dufflebag"))]and Hideout.Dufflebag.Benefits[tonumber(getPlayerJsonValue(hitElem,"HideUpgrades","Dufflebag"))].max;

                        if(tonumber(getElementData(hitElem,"Player:Data:RobbedAmount"))<MaxMoney)then
                            setElementData(hitElem,"Player:Data:MarkerRobAllowed",true);
                            setElementData(hitElem,"Player:Data:isRobbing","Oilrig");

                            RobPlayerTimer[hitElem]=setTimer(function(hitElem,source)
                                if(getElementData(source,"Marker:Data:Amount")>=1)then
                                    if(getElementData(source,"Marker:Data:Amount")>=Reward)then
                                        if(tonumber(getElementData(hitElem,"Player:Data:RobbedAmount"))+Reward>=MaxMoney)then
                                            setElementData(hitElem,"Player:Data:RobbedAmount",tonumber(MaxMoney));
                                            triggerClientEvent(hitElem,"Notify:UI",hitElem,loc(hitElem,"S:Rob:Oilrig:RobbedAmount"):format(getElementData(hitElem,"Player:Data:RobbedAmount")+Reward-MaxMoney),"info",4000,true);
                                            
                                            if(isTimer(RobPlayerTimer[hitElem]))then
                                                killTimer(RobPlayerTimer[hitElem]);
                                                RobPlayerTimer[hitElem]=nil;
                                            end
                                        else
                                            setElementData(hitElem,"Player:Data:RobbedAmount",getElementData(hitElem,"Player:Data:RobbedAmount")+tonumber(Reward));
                                            triggerClientEvent(hitElem,"Notify:UI",hitElem,loc(hitElem,"S:Rob:Oilrig:RobbedAmount"):format(comma_value(Reward)),"info",4000,true);
                                
                                            addPlayerJsonValue(hitElem,"Stats","Bounty",math.floor(getElementData(hitElem,"Player:Data:RobbedAmount")/100*Robs["Oilrig"].BountyPercentage));--give bounty
                                            setElementData(source,"Marker:Data:Amount",tonumber(getElementData(source,"Marker:Data:Amount"))-Reward);
                                        end
                                    elseif(getElementData(source,"Marker:Data:Amount")<=Reward)then
                                        setElementData(hitElem,"Player:Data:RobbedAmount",getElementData(hitElem,"Player:Data:RobbedAmount")+tonumber(getElementData(source,"Marker:Data:Amount")));
                                        triggerClientEvent(hitElem,"Notify:UI",hitElem,loc(hitElem,"S:Rob:Oilrig:RobbedAmount"):format(comma_value(getElementData(source,"Marker:Data:Amount"))),"info",4000,true);
                                        
                                        setElementData(source,"Marker:Data:Amount",tonumber(getElementData(source,"Marker:Data:Amount"))-tonumber(getElementData(source,"Marker:Data:Amount")));

                                        if(isTimer(RobPlayerTimer[hitElem]))then
                                            killTimer(RobPlayerTimer[hitElem]);
                                            RobPlayerTimer[hitElem]=nil;
                                        end
                                    end
                                else
                                    if(isTimer(RobPlayerTimer[hitElem]))then
                                        killTimer(RobPlayerTimer[hitElem]);
                                        RobPlayerTimer[hitElem]=nil;
                                    end
                                end
                            end,2*1000,0,hitElem,source)

                            triggerClientEvent(hitElem,"Rob:DeliverMarker",hitElem,true);
                            createRobObjectsForPlayer(hitElem);
                        end
                    end
                end
            end)

            addEventHandler("onMarkerLeave",OilMarker[id],function(hitElem,dim)
                if(hitElem and isElement(hitElem)and getElementType(hitElem)=="player" and isLoggedin(hitElem)and dim)then
                    setElementData(hitElem,"Player:Data:MarkerRobAllowed",false);
                    removeElementData(hitElem,"Player:Data:isRobbing");
                    RobPlayerMarker[hitElem]=nil;

                    if(isTimer(RobPlayerTimer[hitElem]))then
                        killTimer(RobPlayerTimer[hitElem]);
                        RobPlayerTimer[hitElem]=nil;
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
    if(isTimer(RobPlayerTimer[player]))then
        killTimer(RobPlayerTimer[player]);
        RobPlayerTimer[player]=nil;
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