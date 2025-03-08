local AreaCol={};
local AreaColType={};
local AreaBlip={};
local AreaRadar={};
local AreaTimer={};

local RobPlayerArea={};


local function resetBoss(area)
    for _,col in pairs(getElementsByType("colshape"))do
        if(col and isElement(col))then
            if(getElementData(col,"Col:Data:Area")==tostring(area))then
                for _,player in pairs(getElementsByType("player"))do
                    if(player and isElement(player)and isLoggedin(player))then
                        if(isElementWithinColShape(player,col))then
                            if(isPedInVehicle(player))then
                                local veh=getPedOccupiedVehicle(player);
                                if(veh and isElement(veh))then
                                    setElementPosition(veh,Bosses.Zones[tostring(area)].OutPos[1],Bosses.Zones[tostring(area)].OutPos[2],Bosses.Zones[tostring(area)].OutPos[3]);
                                    toggleGhostMode(veh,true,10000);
                                else
                                    setElementPosition(player,Bosses.Zones[tostring(area)].OutPos[1],Bosses.Zones[tostring(area)].OutPos[2],Bosses.Zones[tostring(area)].OutPos[3]);
                                    toggleGhostMode(player,true,10000);
                                end
                            else
                                setElementPosition(player,Bosses.Zones[tostring(area)].OutPos[1],Bosses.Zones[tostring(area)].OutPos[2],Bosses.Zones[tostring(area)].OutPos[3]);
                                toggleGhostMode(player,true,10000);
                            end
                            if(RobPlayerArea[player])then
                                RobPlayerArea[player]=nil;
                            end
                        end

                        triggerClientEvent(player,"Notify:UI",player,loc(player,"S:Boss:GotReset"):format(Bosses.Names[tostring(area)]),"warning",10000);
                        outputChatBox(loc(player,"S:Boss:GotReset"):format(Bosses.Names[tostring(area)]),player,255,255,60,false);
                    end
                end
                
                setRadarAreaFlashing(AreaRadar[col],false);
                setBlipColor(AreaBlip[col],60,255,60,255);
            end
        end
    end

    loadBossPeds(tostring(area));
end


addEventHandler("onResourceStart",resourceRoot,function()
    for area,v in pairs(Bosses.Zones)do
        AreaCol[area]=createColRectangle(v.Pos[1],v.Pos[2],v.Pos[3],v.Pos[4]);
        AreaColType[AreaCol[area]]=tostring(area);
        setElementData(AreaCol[area],"Col:Data:Area",tostring(area));
        AreaRadar[AreaCol[area]]=createRadarArea(v.Pos[1],v.Pos[2],v.Pos[3],v.Pos[4],200,0,0,100,root);

        AreaBlip[AreaCol[area]]=createBlip(v.Blip.Pos[1],v.Blip.Pos[2],v.Blip.Pos[3],10,22,60,255,60,255,100);
        setElementData(AreaBlip[AreaCol[area]],"Blip:Data:Tooltip",Bosses.Names[tostring(area)]);




        addEventHandler("onColShapeHit",AreaCol[area],function(hitElem,dim)
            if(hitElem and isElement(hitElem)and getElementType(hitElem)=="player" and isLoggedin(hitElem)and dim)then
                RobPlayerArea[hitElem]=source;
                if(not(isTimer(AreaTimer[AreaColType[source]])))then--reset timer
                    for _,v in pairs(getElementsByType("player"))do
                        if(v and isElement(v)and isLoggedin(v))then
                            triggerClientEvent(v,"Notify:UI",v,loc(v,"S:Boss:Started"):format(getPlayerName(hitElem),Bosses.Names[tostring(getElementData(source,"Col:Data:Area"))]),"warning",10000);
                            outputChatBox(loc(v,"S:Boss:Started"):format(getPlayerName(hitElem),Bosses.Names[tostring(getElementData(source,"Col:Data:Area"))]),v,255,255,60,false);
                        end
                    end

                    setRadarAreaFlashing(AreaRadar[source],true);
                    setBlipColor(AreaBlip[source],255,60,60,255);

                    AreaTimer[AreaColType[source]]=setTimer(function(area)
                        resetBoss(area);
                    end,v.ResetTimer,1,AreaColType[source])
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
end)
