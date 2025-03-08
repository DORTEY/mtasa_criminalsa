local CHAT_SPAM_LIMIT=6;
local CHAT_SPAM_LAST=3;
local CHAT_MESSAGES={};
local CHAT_SPAM_TIMER={};


addEventHandler("onPlayerPrivateMessage",root,function()
    cancelEvent();--cancel default private chat
end)


addEventHandler("onPlayerChat",root,function(msg,typ)
	cancelEvent();--cancel default chat
	if(typ==0)then
		if(not(isLoggedin(source)))then
			return;
		end
		if(isPedDead(source))then
			return;
		end
		if(#msg<2)then
			return; --todo at least 2 characters
		end

		if(getPlayerJsonValue(source,"Stats","Mutetime")>0)then
			triggerClientEvent(source,"Notify:UI",source,loc(source,"S:Chat:StillMuted"):format(getPlayerJsonValue(source,"Stats","Mutetime")),"warning",5000);
			cancelEvent();
		else
			local pX,pY,pZ=getElementPosition(source);--player pos
			local pInt=getElementInterior(source);--player int
			local pDim=getElementDimension(source);--player dim
			local pName=getPlayerName(source);--player name
			
			sendDiscordMessage({
				ID=1, Title="Local Chat", Desc=getPlayerName(source)..": "..msg.."",
				PlayerData={Name=getPlayerName(source),Serial=getPlayerSerial(source),},
			})
			checkSpam(source,msg);
			
			
			for _,v in ipairs(getElementsByType("player"))do
				if(isElement(v)and isLoggedin(v))then
					local tX,tY,tZ=getElementPosition(v);--target pos
					local tInt=getElementInterior(v);--target int
					local tDim=getElementDimension(v);--target dim
					
					if(pInt==tInt and pDim==tDim)then--check same dim and int
						if(getDistanceBetweenPoints3D(pX,pY,pZ,tX,tY,tZ)<=Server.Settings.NametagRange)then--get players in same range
							outputChatBox("#ffffff(Local) "..pName..": "..msg,v,0,0,0,true);
							triggerClientEvent(v,"Chat:Bubble",source,msg);
						end
					end
				end
			end
		end
	end
end)

function checkSpam(player,message)
    local playerName=getPlayerName(player);
    if(not CHAT_MESSAGES[playerName])then
        CHAT_MESSAGES[playerName]={};
    end

    local currentTime=getTickCount();
    if(not CHAT_SPAM_TIMER[playerName]or CHAT_SPAM_TIMER[playerName]<currentTime)then
        CHAT_SPAM_TIMER[playerName]=currentTime+CHAT_SPAM_LAST*1000;
        CHAT_MESSAGES[playerName]={};
    end

    table.insert(CHAT_MESSAGES[playerName],currentTime);

    if(#CHAT_MESSAGES[playerName]>CHAT_SPAM_LIMIT)then
        local oldestMessageTime=CHAT_MESSAGES[playerName][1];
        if(currentTime-oldestMessageTime<CHAT_SPAM_LAST*1000)then
			setPlayerJsonValue(player,"Stats","Mutetime",Server.Settings.ChatSpamTimer);
			triggerClientEvent(player,"Notify:UI",player,loc(player,"S:Chat:GotMuted"):format(Server.Settings.ChatSpamTimer),"warning",5000);
			outputChatBox(loc(player,"S:Chat:GotMuted"):format(Server.Settings.ChatSpamTimer),player,255,255,60);
            return;
        else
            table.remove(CHAT_MESSAGES[playerName],1);
        end
    end
end


addCommandHandler("global",function(player,cmd,...)
	if(player and isElement(player)and isLoggedin(player)and(not client or client==player))then
		if(isPedDead(player))then
			return;
		end
		local msg=stringTextWithAllParameters(...);
		if(#msg<2)then
			return; --todo at least 2 characters
		end
		local pName=getPlayerName(player);--player name
		
		if(getPlayerJsonValue(player,"Stats","Mutetime")>0)then
			triggerClientEvent(player,"Notify:UI",player,loc(player,"S:Chat:StillMuted"):format(getPlayerJsonValue(player,"Stats","Mutetime")),"warning",5000);
		else
			sendDiscordMessage({
				ID=1, Title="Global Chat", Desc=getPlayerName(player)..": "..msg.."",
				PlayerData={Name=getPlayerName(player),Serial=getPlayerSerial(player),},
			})
			
			outputChatBox(Server.Color.HEX.."(GLOBAL) "..pName.."#ffffff: "..msg,root,0,0,0,true);

			checkSpam(player,msg);
		end
	end
end)