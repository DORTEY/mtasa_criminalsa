function SendOfflineMessage(Username,text)
	if(Username and text)then
		local DATE=os.time();
		
		dbExec(Database.Connection,"INSERT INTO ?? (Username,Time,Text) VALUES (?,?,?)","OfflineMessages",Username,DATE,text);
	end
end

function checkOfflineMessage(player)
	local result=dbPoll(dbQuery(Database.Connection,"SELECT * FROM ??","OfflineMessages"),-1);
	for _,v in pairs(result)do
		if(v["Username"]==getPlayerName(player))then
            local MessageTime=os.date("%d/%m/%Y %H:%M",v["Time"]);
			outputChatBox("[Offline] ["..MessageTime.."]: "..v["Text"],player,150,150,150);

			dbExec(Database.Connection,"DELETE FROM ?? WHERE ??=?","OfflineMessages","ID",v["ID"]);
		end
	end
end