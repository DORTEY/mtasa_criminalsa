function updateJobLevelstuff(player,type)
    if(player and isElement(player)and getElementType(player)=="player" and isLoggedin(player)and(not client or client==player))then
        if(Jobs[tostring(type)])then
            addPlayerJsonValue(player,"Levels","Job"..type.."EXP",tonumber(Jobs[tostring(type)].Progress.GiveExp[getPlayerJsonValue(player,"Levels","Job"..type.."LVL")]));

            if(not(getPlayerNotExistingJsonValue(player,"Levels","Job"..type.."LVL")))then
                PlayerJobLevel=1;
            else
                PlayerJobLevel=getPlayerJsonValue(player,"Levels","Job"..type.."LVL");
            end

            if(not(getPlayerNotExistingJsonValue(player,"Levels","Job"..type.."EXP")))then
                PlayerJobExp=0;
            else
                PlayerJobExp=getPlayerJsonValue(player,"Levels","Job"..type.."EXP");
            end

            if(Jobs[tostring(type)].Progress.LevelExp[tonumber(PlayerJobLevel)]and PlayerJobExp>=Jobs[tostring(type)].Progress.LevelExp[tonumber(PlayerJobLevel)])then
                addPlayerJsonValue(player,"Levels","Job"..type.."LVL",1);
                setPlayerJsonValue(player,"Levels","Job"..type.."EXP",0);

                outputChatBox("#ffffff"..loc(player,"S:Job:LevelUp"):format(getPlayerJsonValue(player,"Levels","Job"..type.."LVL")),player,255,255,255,true);
                triggerClientEvent(player,"Notify:UI",player,loc(player,"S:Job:LevelUp"):format(getPlayerJsonValue(player,"Levels","Job"..type.."LVL")),"info",10000);
            end
        end
    end
end

local function destroyElementsAfterQuitDead(player)
    if(isElement(PLAYER_VEHICLE_JOB[getPlayerName(player)]))then
        destroyElement(PLAYER_VEHICLE_JOB[getPlayerName(player)]);
        PLAYER_VEHICLE_JOB[getPlayerName(player)]=nil;
    end
end

addEventHandler("onPlayerQuit",root,function()
	destroyElementsAfterQuitDead(source);
end)
addEventHandler("onPlayerWasted",root,function()
	destroyElementsAfterQuitDead(source);
end)