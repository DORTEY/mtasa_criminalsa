local Object={};
local ObjectCol={};
local ObjectColOffset={};
local ColTimer={};
local ColBlip={};
local ColBlipMinimap={};

local PlayerJobData={};--[1]=object [2]=col 
local PlayerTimer={};
local PlayerFarmCount={};
local PlayerRandom={};
local PlayerPickaxe={};


local function resetRock(col)
    if(col and isElement(col))then
        setElementData(col,"Col:Data:Amount",tonumber(getElementData(col,"Col:Data:MaxAmount")));
        setElementAlpha(Object[col],255);
        setElementCollisionsEnabled(Object[col],true);
        setBlipColor(ColBlipMinimap[col],60,255,60,255);

        for _,player in pairs(getElementsByType("player"))do
            if(player and isElement(player)and isLoggedin(player))then
                if(isElementWithinColShape(player,col))then
                    local NewColPos=GetOffsetFromEntityInWorldCoords(PlayerJobData[player][1],ObjectColOffset[col][1],ObjectColOffset[col][2],ObjectColOffset[col][3]);

                    --createMarker(NewColPos.x,NewColPos.y,NewColPos.z,"cylinder",4,255,255,255,100)
                    if(isPedInVehicle(player))then
                        local veh=getPedOccupiedVehicle(player);
                        if(veh and isElement(veh))then
                            setElementPosition(veh,NewColPos.x,NewColPos.y,NewColPos.z);
                            toggleGhostMode(veh,true,10000);
                        else
                            setElementPosition(player,NewColPos.x,NewColPos.y,NewColPos.z);
                            setElementRotation(player,0,0,math.random(0,270));
                            toggleGhostMode(player,true,10000);
                        end
                    else
                        setElementPosition(player,NewColPos.x,NewColPos.y,NewColPos.z);
                        setElementRotation(player,0,0,math.random(0,270));
                        toggleGhostMode(player,true,10000);
                    end
                end
            end
        end
    end
end

addEventHandler("onResourceStart",resourceRoot,function()
    for i,v in pairs(Jobs["Miner"].Areas)do
        ObjectCol[i]=createColSphere(v.Pos[1],v.Pos[2],v.Pos[3],Jobs.Settings.Ranges[v.ID]);
        setElementData(ObjectCol[i],"Col:Data:Type","Miner");
        local MarkerAmount=math.random(v.Count[1],v.Count[2]);
        setElementData(ObjectCol[i],"Col:Data:Amount",tonumber(MarkerAmount));
        setElementData(ObjectCol[i],"Col:Data:MaxAmount",tonumber(MarkerAmount));
        ObjectColOffset[ObjectCol[i]]={v.OutOffset[1],v.OutOffset[2],v.OutOffset[3]};

        if(v.Blip)then
            ColBlip[ObjectCol[i]]=createBlip(v.Pos[1],v.Pos[2],v.Pos[3],v.Blip[1],20,90,65,50,255,100);
            setElementData(ColBlip[ObjectCol[i]],"Blip:Data:Tooltip",v.Blip[2]);
            setElementData(ColBlip[ObjectCol[i]],"Blip:Data:OnlyF11Map",true);
        end

        Object[ObjectCol[i]]=createObject(v.ID,v.Pos[1],v.Pos[2],v.Pos[3]-1.5,v.Pos[4],v.Pos[5],v.Pos[6]);
        setObjectBreakable(Object[ObjectCol[i]],false);
        setElementFrozen(Object[ObjectCol[i]],true);
        setElementDoubleSided(Object[ObjectCol[i]],true);

        ColBlipMinimap[ObjectCol[i]]=createBlip(v.Pos[1],v.Pos[2],v.Pos[3],1,20,60,255,60,255,100);
        setElementData(ColBlipMinimap[ObjectCol[i]],"Blip:Data:OnlyMinimap",true);

        addEventHandler("onColShapeHit",ObjectCol[i],function(hitElem,dim)
            if(hitElem and isElement(hitElem)and getElementType(hitElem)=="player" and isLoggedin(hitElem)and dim)then
                if(not(isPedInVehicle(hitElem))and not(isPedDead(hitElem)))then
                    PlayerJobData[hitElem]={Object[source],source};
                    PlayerFarmCount[hitElem]=0;

                    bindKey(hitElem,"MOUSE1","DOWN",startMining);
                    toggleControl(hitElem,"fire",false);
                    setElementData(hitElem,"Player:Data:isMining",true);

                    if(getPlayerJsonValue(hitElem,"Items","Pickaxe")>0)then
                        PlayerPickaxe[hitElem]=createObject(2107,708.87,836.69,-29.74);
                        attachElementToBone(PlayerPickaxe[hitElem],hitElem,12,0,0,0,90,-90,0);
                    else
                        triggerClientEvent(hitElem,"Notify:UI",hitElem,loc(hitElem,"S:Job:NeedItem"):format(loc(hitElem,"Item:Pickaxe")),"warning",4000);
                    end

                    if(not(getPlayerNotExistingJsonValue(hitElem,"Levels","JobMinerLVL")))then--set if element data doesnt exist
                        setPlayerJsonValue(hitElem,"Levels","JobMinerLVL",1);
                        setPlayerJsonValue(hitElem,"Levels","JobMinerEXP",0);
                    end
                end
            end
        end)
        addEventHandler("onColShapeLeave",ObjectCol[i],function(hitElem,dim)
            if(hitElem and isElement(hitElem)and getElementType(hitElem)=="player" and isLoggedin(hitElem)and dim)then
                PlayerJobData[hitElem]=nil;
                PlayerFarmCount[hitElem]=nil;

                unbindKey(hitElem,"MOUSE1","DOWN",startMining);
                toggleControl(hitElem,"fire",true);
                removeElementData(hitElem,"Player:Data:isMining");

                if(isElement(PlayerPickaxe[hitElem]))then
                    destroyElement(PlayerPickaxe[hitElem]);
                    PlayerPickaxe[hitElem]=nil;
                end
            end
        end)
    end
end)

function startMining(player)
    if(player and isElement(player)and getElementType(player)=="player" and isLoggedin(player)and(not client or client==player))then
        if(not(isElement(PlayerPickaxe[player])))then
            triggerClientEvent(player,"Notify:UI",player,loc(player,"S:Job:NeedItem"):format(loc(player,"Item:Pickaxe")),"warning",4000);
            return;
        end
        if(isTimer(PlayerTimer[player]))then
            return;
        end
        if(not(PlayerJobData[player]))then
            return;
        end
        if(getElementData(player,"Player:Data:isAFK"))then
            return;
        end
        if(tonumber(getElementData(PlayerJobData[player][2],"Col:Data:Amount"))==0)then
            return;
        end
        if(getPlayerJsonValue(player,"Items","Pickaxe")==0)then
            triggerClientEvent(player,"Notify:UI",player,loc(player,"S:Job:NeedItem"):format(loc(player,"Item:Pickaxe")),"warning",4000);
            if(isElement(PlayerPickaxe[player]))then
                destroyElement(PlayerPickaxe[player]);
                PlayerPickaxe[player]=nil;
            end
            return;
        end

        local x,y,z=getElementPosition(player);
        local x1,y1,_=getElementPosition(PlayerJobData[player][1]);
        local rotZ=findRotation(x,y, x1,y1);
        setElementRotation(player,0,0,rotZ);
        setElementFrozen(player,true);
        
        setPedAnimation(player,"BASEBALL","Bat_1");
        triggerClientEvent(root,"Sound:Sync:3D",root,player,true,"Pickaxe.mp3",false,15,{x,y,z});

        PlayerTimer[player]=setTimer(function(player)--farm timer
            setElementFrozen(player,false);
            setPedAnimation(player);
            
            if(not(PlayerJobData[player]))then
                return;
            end
            if(tonumber(getElementData(PlayerJobData[player][2],"Col:Data:Amount"))==0)then
                return;
            end
            if(not(PlayerFarmCount[player]))then
                return;
            end

            PlayerFarmCount[player]=PlayerFarmCount[player]+1;
            triggerClientEvent(player,"Job:Miner:UI",player,PlayerFarmCount[player]);

            if(PlayerFarmCount[player]>=Jobs["Miner"].MaxCount)then
                PlayerFarmCount[player]=0;
                triggerClientEvent(player,"Job:Miner:UI",player,PlayerFarmCount[player]);
                setElementData(PlayerJobData[player][2],"Col:Data:Amount",tonumber(getElementData(PlayerJobData[player][2],"Col:Data:Amount"))-1);

                if(not(isTimer(ColTimer[PlayerJobData[player][2]])))then--reset timer
                    ColTimer[PlayerJobData[player][2]]=setTimer(function(col)
                        resetRock(col);
                    end,Jobs["Miner"].Timers.Reset,1,PlayerJobData[player][2])
                end
                
                if(tonumber(getElementData(PlayerJobData[player][2],"Col:Data:Amount"))<=0)then--destroy element if empty
                    if(getNearestElement(player,"object",getColShapeRadius(PlayerJobData[player][2])))then
                        setElementAlpha(PlayerJobData[player][1],0);
                        setElementCollisionsEnabled(PlayerJobData[player][1],false);
                        setBlipColor(ColBlipMinimap[PlayerJobData[player][2]],255,60,60,255);
                    end
                end

                triggerEvent("Tutorial:NextStep",player,player,"FarmItem");

                --give random reward
                PlayerRandom[player]=math.random(0,200);
                for i,v in pairs(Jobs["Miner"].Drops[tonumber(getPlayerJsonValue(player,"Levels","JobMinerLVL"))])do
                    local RandomAmount=math.random(v.Amount[1],v.Amount[2]);

                    if(PlayerRandom[player]<=v.Chance+(getPlayerJsonValue(player,"Booster","ItemBoosterPercentage")or 0))then
                        addPlayerJsonValue(player,"Items",tostring(v.Item),tonumber(RandomAmount));
                        triggerClientEvent(player,"Notify:UI",player,loc(player,"S:Job:GotItem"):format(loc(player,"Item:"..v.Item),RandomAmount),"info",4000,true);
                    end
                end

                --level
                updateJobLevelstuff(player,"Miner");

                --pickaxe chances
                if(math.random(0,100)<=Jobs["Miner"].Pickaxe[tonumber(getPlayerJsonValue(player,"Levels","JobMinerLVL"))])then
                    removePlayerJsonValue(player,"Items","Pickaxe",1);
                end
            end
        end,1000,1,player)
    end
end




local function destroyElementsAfterQuitDead(player)
    if(PlayerJobData[player])then
        PlayerJobData[player]=nil;
    end

    if(isTimer(PlayerTimer[player]))then
        killTimer(PlayerTimer[player]);
        PlayerTimer[player]=nil;
    end

    if(isElement(PlayerPickaxe[player]))then
        destroyElement(PlayerPickaxe[player]);
        PlayerPickaxe[player]=nil;
    end

    if(player and isElement(player))then
        removeElementData(player,"Player:Data:isMining");

        unbindKey(player,"MOUSE1","DOWN",startMining);
        toggleControl(player,"fire",true);

        triggerClientEvent(root,"Sound:Destroy:3D",root,player);
    end
end

addEventHandler("onPlayerQuit",root,function()
	destroyElementsAfterQuitDead(source);
end)
addEventHandler("onPlayerWasted",root,function()
	destroyElementsAfterQuitDead(source);
end)