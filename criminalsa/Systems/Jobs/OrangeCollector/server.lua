addRemoteEvents{"Job:OrangeCollector:S"};--addEvent


local Object={};
local ObjectCol={};
local ColTimer={};
local ColBlip={};
local ColBlipMinimap={};

local PlayerJobData={};--[1]=col


local function resetTree(col)
    if(col and isElement(col))then
        setBlipColor(ColBlipMinimap[col],255,180,60,255);
    end
end

addEventHandler("onResourceStart",resourceRoot,function()
    for i,v in pairs(Jobs["OrangeCollector"].Areas)do
        ObjectCol[i]=createColSphere(v.Pos[1],v.Pos[2],v.Pos[3],Jobs.Settings.Ranges[v.ID]);
        setElementData(ObjectCol[i],"Col:Data:Type","OrangeCollector");

        if(v.Blip)then
            ColBlip[ObjectCol[i]]=createBlip(v.Pos[1],v.Pos[2],v.Pos[3],v.Blip[1],20,255,180,60,255,100);
            setElementData(ColBlip[ObjectCol[i]],"Blip:Data:Tooltip",v.Blip[2]);
            setElementData(ColBlip[ObjectCol[i]],"Blip:Data:OnlyF11Map",true);
        end

        Object[ObjectCol[i]]=createObject(v.ID,v.Pos[1],v.Pos[2],v.Pos[3]-2.0,0,0,math.random(0,350));
        setObjectBreakable(Object[ObjectCol[i]],false);
        setElementFrozen(Object[ObjectCol[i]],true);
        setElementDoubleSided(Object[ObjectCol[i]],true);

        ColBlipMinimap[ObjectCol[i]]=createBlip(v.Pos[1],v.Pos[2],v.Pos[3],1,20,255,180,60,255,100);
        setElementData(ColBlipMinimap[ObjectCol[i]],"Blip:Data:OnlyMinimap",true);

        addEventHandler("onColShapeHit",ObjectCol[i],function(hitElem,dim)
            if(hitElem and isElement(hitElem)and getElementType(hitElem)=="player" and isLoggedin(hitElem)and dim)then
                if(not(isPedInVehicle(hitElem))and not(isPedDead(hitElem)))then
                    PlayerJobData[hitElem]={source};

                    if(not isKeyBound(hitElem,Server.MainInteractionKey,"down",startCollectingOranges))then
                        bindKey(hitElem,Server.MainInteractionKey,"down",startCollectingOranges);
                        toggleControl(hitElem,"next_weapon",false);
                        toggleControl(hitElem,"previous_weapon",false);
                    end

                    triggerClientEvent(hitElem,"HelpNotify:UI",hitElem,true,Server.MainInteractionKey,loc(hitElem,"UI:HelpNotify:PressToOpen:General"));

                    if(not(getPlayerNotExistingJsonValue(hitElem,"Levels","JobOrangeCollectorLVL")))then--set if element data doesnt exist
                        setPlayerJsonValue(hitElem,"Levels","JobOrangeCollectorLVL",1);
                        setPlayerJsonValue(hitElem,"Levels","JobOrangeCollectorEXP",0);
                    end
                end
            end
        end)
        addEventHandler("onColShapeLeave",ObjectCol[i],function(hitElem,dim)
            if(hitElem and isElement(hitElem)and getElementType(hitElem)=="player" and isLoggedin(hitElem)and dim)then
                PlayerJobData[hitElem]=nil;

                if(isKeyBound(hitElem,Server.MainInteractionKey,"down",startCollectingOranges))then
                    unbindKey(hitElem,Server.MainInteractionKey,"down",startCollectingOranges);
                    toggleControl(hitElem,"next_weapon",true);
                    toggleControl(hitElem,"previous_weapon",true);
                    triggerClientEvent(hitElem,"HelpNotify:UI",hitElem,nil);
                end
            end
        end)
    end
end)

function startCollectingOranges(player)
    if(player and isElement(player)and getElementType(player)=="player" and isLoggedin(player)and(not client or client==player))then
        if(not(PlayerJobData[player]))then
            return;
        end
        if(getElementData(player,"Player:Data:isAFK"))then
            return;
        end

        if(not(isTimer(ColTimer[PlayerJobData[player][1]])))then--reset timer
            triggerClientEvent(player,"Job:OrangeCollector:UI",player,true,nil);
            triggerClientEvent(player,"HelpNotify:UI",player,nil);
        else
            triggerClientEvent(player,"Notify:UI",player,loc(player,"Job:CollectorNotReady"),"warning",4000);
        end
    end
end

addEventHandler("Job:OrangeCollector:S",root,function(amount)
    if(client and isElement(client)and getElementType(client)=="player" and isLoggedin(client))then
        if(not(PlayerJobData[client]))then
            return;
        end

        if(not(isTimer(ColTimer[PlayerJobData[client][1]])))then--reset timer
            setBlipColor(ColBlipMinimap[PlayerJobData[client][1]],60,60,60,255);
            ColTimer[PlayerJobData[client][1]]=setTimer(function(col)
                resetTree(col);
            end,Jobs["OrangeCollector"].Timers.Reset,1,PlayerJobData[client][1])

            --give reward
            addPlayerJsonValue(client,"Items","Orange",tonumber(amount));

            --level
            updateJobLevelstuff(client,"OrangeCollector");
        else
            triggerClientEvent(client,"Notify:UI",client,loc(client,"Job:CollectorNotReady"),"warning",4000);
        end
    end
end)




local function destroyElementsAfterQuitDead(player)
    if(PlayerJobData[player])then
        PlayerJobData[player]=nil;
    end

    if(player and isElement(player))then
        if(isKeyBound(player,Server.MainInteractionKey,"down",startCollectingOranges))then
            unbindKey(player,Server.MainInteractionKey,"down",startCollectingOranges);
            toggleControl(player,"next_weapon",true);
            toggleControl(player,"previous_weapon",true);
            triggerClientEvent(player,"HelpNotify:UI",player,nil);
        end
    end
end

addEventHandler("onPlayerQuit",root,function()
	destroyElementsAfterQuitDead(source);
end)
addEventHandler("onPlayerWasted",root,function()
	destroyElementsAfterQuitDead(source);
end)