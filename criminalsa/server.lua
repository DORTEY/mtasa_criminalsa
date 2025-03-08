Database={
	IP="127.0.0.1",
	Port="3306",
	Name="",
	Password="",
	Username="",
	Connection=nil,
};

addEventHandler("onResourceStart",resourceRoot,function()
	Database.Connection=dbConnect("mysql","dbname="..Database.Name..";host="..Database.IP..";charset=utf8;port="..Database.Port,Database.Username,Database.Password,"autoreconnect=1");
	print("[MYSQL] Opening connection to MySQL database..");
	if(Database.Connection)then
		print("[MYSQL] Connection to the MySQL database was successfully established!");
		return true;
	else
		print("[MYSQL] Connection failed!");
		stopResource(resource);
		return false;
	end
end)



function getMySQLData(from,where,name,data)
	local sql=dbQuery(Database.Connection,"SELECT * FROM ?? WHERE ??=?",from,where,name);
	local row=dbPoll(sql,-1);
	if(#row>=1)then
		return row[1][data];
	end
end
function getMySQLData2(from,where,name,andd,name2,data)
	local sql=dbQuery(Database.Connection,"SELECT * FROM ?? WHERE ??=? AND ??=?",from,where,name,andd,name2);
	local row=dbPoll(sql,-1);
	if(#row>=1)then
		return row[1][data];
	end
end



PLAYER_PLAYTIME={};
PLAYER_ARMOR_REGENERATION={};
PLAYER_SYNCING_TIME={};
PLAYER_MINING={};
PLAYER_VEHICLE={};
PLAYER_VEHICLE_JOB={};
PLAYER_VEHICLE_GARAGE={};
PLAYER_VEHICLE_TESTDRIVE={};
PLAYER_VEHICLE_TESTDRIVE_TIMER={};
PLAYER_VEHICLE_PAYNSPRAY={};
PLAYER_VEHICLE_PAYNSPRAY_TIMER={};
PLAYER_EQUIPPED_ARMOR={};
PLAYER_EQUIPPED_WEAPONS={};
PLAYER_GOTLASTHIT={};
PLAYER_TELEPORTER={};

PLAYER_DEATH_PICKUP={};
PLAYER_DEATH_DUFFLEBAG_PICKUP={};
PLAYER_DEATH_DUFFLEBAG_PICKUP_TIMER={};


GLOBAL_DIMENSION=5000;
SERVER_SLOTS=tonumber(getServerConfigSetting("maxplayers"));



addEventHandler("onPlayerJoin",root,function()
	setElementData(source,"Loggedin",0);
	setElementData(source,"Language",0);

	setElementFrozen(source,true);
end)

addEventHandler("onPlayerChangeNick",root,function()
	cancelEvent();
end)

--set stuff after script re/start
local function setStartStuff()
	setGameType(Server.Name.." v"..Server.Version);
	setMapName(Server.Name.." v"..Server.Version);

	setFPSLimit(60);
	if(Server.Settings.Whitelist)then
		setServerPassword("ghgh1");
	else
		setServerPassword("");
	end
	
	for _,v in pairs(getElementsByType("player"))do
		if(isLoggedin(v))then
			setClickedState(v,false);
			setElementData(v,"Loggedin",0);
		end
	end
	
	local time=getRealTime();
	local hour=time.hour;
	local minute=time.minute;
	
	setTime(hour,minute);
	setMinuteDuration(60*1000);

	if(Database.Connection)then
		if(os.time()>=Server.Settings.Event.Current[2])then
			dbExec(Database.Connection,"UPDATE ?? SET ??=?","Accounts","EventPickups","[ [ ] ]");
		end

		dbExec(Database.Connection,"UPDATE ?? SET ??=? WHERE ??=?","Accounts","LoggedinDB",0,"LoggedinDB",1);
	end



	for i,v in pairs(getElementsByType("vehicle"))do
		if(isElement(v))then
			if(getElementModel(v)~=538 and getElementModel(v)~=570 and getElementModel(v)~=590 and getElementModel(v)~=569 and getElementModel(v)~=537 and not getElementData(v,"IsServerTrain"))then
				destroyElement(v);
			end
		end
	end
end
addEventHandler("onResourceStart",resourceRoot,setStartStuff)
setTimer(setStartStuff,2*1000,1)

addEventHandler("onResourceStop",resourceRoot,function()
	for _,v in pairs(getElementsByType("player"))do
		if(isLoggedin(v))then
			savePlayerDatas(v);
			setClickedState(v,false);
			setElementData(v,"Loggedin",0);
		end
	end
	
	if(Database.Connection)then
		destroyElement(Database.Connection);
		Database.Connection=nil;
	end
end)


local WhitelistedJson={
	["Items"]=true,
}
function addPlayerJsonValue(player,json,item,amount)
	if(player and isElement(player)and getElementType(player)=="player" and isLoggedin(player)and(not client or client==player))then
		local jsonElement=fromJSON(getElementData(player,tostring(json)))or {};

		if(jsonElement and jsonElement[tostring(item)])then
			jsonElement[tostring(item)]=tonumber(jsonElement[tostring(item)])+tonumber(amount);

			setElementData(player,tostring(json),toJSON(jsonElement));

			if(Items[tostring(item)])then
				if(WhitelistedJson[tostring(json)])then
					triggerClientEvent(player,"Item:AddRemove",player,"add",item,amount);
				end
			end

			for _,v in pairs(Achievements.Achievements)do
				if(v.Identifier and tostring(item)==v.Identifier[2])then
					if(v.Requirement[(getPlayerJsonValue(player,"Achievements",tostring(v.ID))or 1)])then
						if(jsonElement[tostring(item)]>=v.Requirement[(getPlayerJsonValue(player,"Achievements",tostring(v.ID))or 1)])then
							addAchievement(player,tostring(v.ID));
						end
					end
				end
			end
		else
			jsonElement[tostring(item)]=tonumber(amount);

			setElementData(player,tostring(json),toJSON(jsonElement));

			if(WhitelistedJson[tostring(json)])then
				triggerClientEvent(player,"Item:AddRemove",player,"add",item,amount);
			end
		end
	end
end

function removePlayerJsonValue(player,json,item,amount)
	if(player and isElement(player)and getElementType(player)=="player" and isLoggedin(player)and(not client or client==player))then
		local jsonElement=fromJSON(getElementData(player,tostring(json)))or {};
		if(jsonElement and jsonElement[tostring(item)])then
			jsonElement[tostring(item)]=tonumber(jsonElement[tostring(item)])-tonumber(amount);

			if(not(jsonElement[tostring(item)]))then--set json object if not existing
				jsonElement[tostring(item)]=tonumber(0);
			end

			if(tonumber(jsonElement[tostring(item)])<0)then--set number to 0 if its under 0
				jsonElement[tostring(item)]=tonumber(0);
			end

			setElementData(player,tostring(json),toJSON(jsonElement));

			if(Items[tostring(item)])then
				if(WhitelistedJson[tostring(json)])then
					triggerClientEvent(player,"Item:AddRemove",player,"rem",item,amount);
				end
			end
		end
	end
end

function setPlayerJsonValue(player,json,item,amount)
	if(player and isElement(player)and getElementType(player)=="player" and isLoggedin(player)and(not client or client==player))then
		local jsonElement=fromJSON(getElementData(player,tostring(json)))or {};
		
		if(jsonElement and jsonElement[tostring(item)])then
			jsonElement[tostring(item)]=tonumber(amount);

			setElementData(player,tostring(json),toJSON(jsonElement));
		else
			jsonElement[tostring(item)]=tonumber(amount);

			setElementData(player,tostring(json),toJSON(jsonElement));
		end
	end
end




function setVehicleJsonValue(vehicle,json,item,amount)
	if(vehicle and isElement(vehicle)and getElementType(vehicle)=="vehicle")then
		local jsonElement=fromJSON(getElementData(vehicle,tostring(json)))or {};
		
		if(jsonElement and jsonElement[tostring(item)])then
			jsonElement[tostring(item)]=amount;

			setElementData(vehicle,tostring(json),toJSON(jsonElement));
		else
			jsonElement[tostring(item)]=amount;

			setElementData(vehicle,tostring(json),toJSON(jsonElement));
		end
	end
end


--[[ addEvent("koks",true)
addEventHandler("koks",root,function(weapon,id)
	setPlayerJsonValue(client,"WeaponSkins",weapon,id)

	triggerClientEvent(root,"Weapon:Skin:Load",root,client,weapon,id)
end) ]]

--[[ function getMyData ( thePlayer, command )
    local data = getAllElementData ( thePlayer )
    for k, v in pairs ( data ) do
        outputConsole ( k .. ": " .. tostring ( v ) )
    end
end
addCommandHandler ( "elemdata", getMyData ) ]]




--Whitelist
addEventHandler("onPlayerConnect",root,function(nickname,ip,username,serial,versionNumber,versionString)
	if(Server.Settings.Whitelist)then
		local result=dbPoll(dbQuery(Database.Connection,"SELECT * FROM ?? WHERE ??=?","Whitelist","Serial",serial),-1)
		if(result and result[1])then
			if(result[1]["Access"]~="Yes")then
				cancelEvent(true,"You're on our whitelist, but without permissions to join!\n"..Server.Discord.Invite.."")
			end
		else
			cancelEvent(true,"You're not whitelisted yet!\n"..Server.Discord.Invite.."")
		end
	end


	local result=dbPoll(dbQuery(Database.Connection,"SELECT * FROM ?? WHERE ??=?","Bans","Serial",serial),-1);
	if(result and result[1])then
		for i=1,#result do
			if(result[i]["Time"]~=0 and(result[i]["Time"]-getTBanSecTime(0))<=0)then
				dbExec(Database.Connection,"DELETE FROM ?? WHERE ??=?","Bans","Serial",serial);
			else
				local banid=tostring(result[i]["ID"]);
				local admin=tostring(result[i]["Admin"]);
				local reason=tostring(result[i]["Reason"]);
				local var=math.floor(((result[i]["Time"]-getTBanSecTime(0))/60)*100)/100;
				if(var>=0)then
					cancelEvent(true,"You have been banned by "..admin.."!\nReason: "..reason..", Time: "..var..", Ban ID: #"..banid);
				else
					cancelEvent(true,"You have been permanently banned by "..admin.."!\nReason: "..reason..", Ban ID: #"..banid);
				end
				return;
			end
		end
	end
end)