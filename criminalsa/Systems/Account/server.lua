addRemoteEvents{"RegisterLogin:TriggerUI","RegisterLogin:Login:S","RegisterLogin:Register:S",
"RegisterLogin:CheckAccount:S","RegisterLogin:Callback:S:Name","RegisterLogin:Callback:S:Promoter",

"RegisterLogin:Callback:S:ForgotAccount","RegisterLogin:ResetPassword:S",
};--addEvents

addEventHandler("RegisterLogin:TriggerUI",root,function()
	if(client and isElement(client)and getElementType(client)=="player")then
		triggerClientEvent(client,"RegisterLogin:UI",client,true);
	end
end)

addEventHandler("RegisterLogin:CheckAccount:S",root,function()--check is user already existing(opens "login" UI page)
	if(client and isElement(client)and getElementType(client)=="player")then
		local PlayerSerial=getPlayerSerial(client);
		local result=dbPoll(dbQuery(Database.Connection,"SELECT * FROM ?? WHERE ??=?","Accounts","Serial",PlayerSerial),-1);
		if(#result==1)then
			triggerClientEvent(client,"RegisterLogin:CheckAccount:C",client,"true");
		else
			triggerClientEvent(client,"RegisterLogin:CheckAccount:C",client,"false");
		end
	end
end)

addEventHandler("RegisterLogin:Callback:S:Name",root,function(name)
	if(client and isElement(client)and getElementType(client)=="player" and not(isLoggedin(client)))then
		local result=dbPoll(dbQuery(Database.Connection,"SELECT * FROM ?? WHERE ??=?","Accounts","Username",tostring(name)),-1);
		if(#result==1)then
			triggerClientEvent(client,"RegisterLogin:Callback:C:Name",client,true);
		else
			triggerClientEvent(client,"RegisterLogin:Callback:C:Name",client,false);
		end
	end
end)

addEventHandler("RegisterLogin:Callback:S:Promoter",root,function(name)
	if(client and isElement(client)and getElementType(client)=="player" and not(isLoggedin(client)))then
		local result=dbPoll(dbQuery(Database.Connection,"SELECT * FROM ?? WHERE ??=?","Accounts","Username",tostring(name)),-1);
		if(#result==1)then
			triggerClientEvent(client,"RegisterLogin:Callback:C:Promoter",client,true);
		else
			triggerClientEvent(client,"RegisterLogin:Callback:C:Promoter",client,false);
		end
	end
end)

addEventHandler("RegisterLogin:Callback:S:ForgotAccount",root,function(name)
	if(client and isElement(client)and getElementType(client)=="player" and not(isLoggedin(client)))then
		local result=dbPoll(dbQuery(Database.Connection,"SELECT * FROM ?? WHERE ??=?","Accounts","Username",tostring(name)),-1);
		if(#result==1)then
			triggerClientEvent(client,"RegisterLogin:Callback:C:ForgotAccount",client,fromJSON(result[1]["Secret"])[1]);
		else
			triggerClientEvent(client,"RegisterLogin:Callback:C:ForgotAccount",client,nil);
		end
	end
end)


addEventHandler("RegisterLogin:ResetPassword:S",root,function(name,password,answer)
	if(client and isElement(client)and getElementType(client)=="player" and not(isLoggedin(client)))then
		local result=dbPoll(dbQuery(Database.Connection,"SELECT * FROM ?? WHERE ??=?","Accounts","Username",tostring(name)),-1);
		if(#result==1)then
			local HashAnswer=md5(hash("sha512",answer));--secret answer hash

			if(fromJSON(result[1]["Secret"])[2]==HashAnswer)then
				local HashPW=md5(hash("sha512",password));--password hash

				dbExec(Database.Connection,"UPDATE ?? SET ??=? WHERE ??=?","Accounts","Password",HashPW,"Serial",getPlayerSerial(client));

				triggerClientEvent(client,"Notify:UI",client,loc(client,"S:RegisterLogin:PasswordReset:Success"),"success",5000);
			else
				triggerClientEvent(client,"Notify:UI",client,loc(client,"S:RegisterLogin:PasswordReset:WrongAnswer"),"error",4000);
			end
		end
	end
end)

local DatabaseTable={
	["Accounts"]={
		"SpawnPos","AdminLevel","Stats","Booster","Levels","WeaponSkins","PedSkins","Achievements","Pickups","EventPickups","Skin","Settings","Date",
	},
	["Hideout"]={
		"HideUpgrades","HideItems","HideTimers","HideLaundry",
	},
	["Inventory"]={
		"Money","Items","Points",
	},
};


addEventHandler("RegisterLogin:Login:S",root,function(name,password,discordID)
	if(client and isElement(client)and getElementType(client)=="player" and not(isLoggedin(client)))then
		local HashPW=md5(hash("sha512",password));--password hash
		local result=dbPoll(dbQuery(Database.Connection,"SELECT * FROM Accounts WHERE ??=?","Username",name),-1);

		if(result and result[1])then
			if(result[1]["Password"]==HashPW)then
				if(result[1]["LoggedinDB"]==0)then
					if(result[1]["Activated"]==1)then
						setPlayerName(client,name);--set name from client ui

						setElementDatasAfterRegisterLogin(client,discordID);--spawn player after register and set datas
					else
						triggerClientEvent(client,"Notify:UI",client,loc(client,"S:RegisterLogin:AccountDisabled"),"error",4000);
					end
				else
					triggerClientEvent(client,"Notify:UI",client,loc(client,"S:RegisterLogin:AlreadyLoggedin"),"error",4000);
				end
			else
				triggerClientEvent(client,"Notify:UI",client,loc(client,"S:RegisterLogin:WrongPassword"),"error",4000);
			end
		end
	end
end)

addEventHandler("RegisterLogin:Register:S",root,function(name,password,promoter,secretQ,secretA,discordID)
	if(client and isElement(client)and getElementType(client)=="player" and not(isLoggedin(client)))then
		local PlayerSerial=getPlayerSerial(client);
		local result=dbPoll(dbQuery(Database.Connection,"SELECT * FROM ?? WHERE ??=?","Accounts","Serial",PlayerSerial),-1);
		if(#result==0)then
			local resultNameCheck=dbPoll(dbQuery(Database.Connection,"SELECT * FROM ?? WHERE ??=?","Accounts","Username",string.lower(name)),-1);
			if(#resultNameCheck==0)then
				for _,v in ipairs(NotAllowedNames)do--check not allowed name
					if(string.lower(name):find(v,1,true))then
						triggerClientEvent(client,"Notify:UI",client,loc(client,"S:RegisterLogin:NotAllowedName"),"error",4000);
						return false;
					end
				end
				
				for _,v in ipairs(NotAllowedCharacters)do
					if(string.lower(name):find(v,1,true))then
						triggerClientEvent(client,"Notify:UI",client,loc(client,"S:RegisterLogin:NotAllowedCharacters"),"error",4000);
						return false;
					end
				end

				if(string.len(name)<3 or string.len(name)>15)then
					triggerClientEvent(client,"Notify:UI",client,loc(client,"S:RegisterLogin:NameLimits"),"error",4000);
					return false;
				end

				local HashPW=md5(hash("sha512",password));--password hash
				local HashAnswer=md5(hash("sha512",secretA));--secret answer hash
				local IDcounter=dbPoll(dbQuery(Database.Connection,"SELECT ?? FROM ?? WHERE User=User","User","Counter"),-1)[1]["User"];
				local IDcounter2=dbPoll(dbQuery(Database.Connection,"SELECT ?? FROM ?? WHERE Vehicles=Vehicles","Vehicles","Counter"),-1)[1]["Vehicles"];
				local ResultPlate=generateVehiclePlate();

                dbExec(Database.Connection,"UPDATE ?? SET ??=?","Counter","User",IDcounter+1);
				dbExec(Database.Connection,"UPDATE ?? SET ??=?","Counter","Vehicles",IDcounter2+1);

				dbExec(Database.Connection,"INSERT INTO ?? (ID,Username,DiscordID,Serial,Password,Secret,Promoter,Date) VALUES (?,?,?,?,?,?,?,?)","Accounts",IDcounter,name,discordID,PlayerSerial,HashPW,toJSON({secretQ,HashAnswer}),promoter,'[ { "Register": '..os.time()..', "Login": '..os.time()..' } ]');
				dbExec(Database.Connection,"INSERT INTO ?? (ID,Username,Items) VALUES (?,?,?)","Inventory",IDcounter,name,'[ { "Bitcoin": 0 } ]');
				dbExec(Database.Connection,"INSERT INTO ?? (ID,Username,HideUpgrades,HideItems) VALUES (?,?,?,?)","Hideout",IDcounter,name,'[ [ ] ]','[ { "Bitcoin": 0 } ]');
				dbExec(Database.Connection,"INSERT INTO ?? (ID,Username,VehID,Plate,Color,LightColor,Tunings) VALUES (?,?,?,?,?,?,?)","Vehicles",IDcounter2,name,"410",ResultPlate,toJSON({255,255,255,255,255,255}),toJSON({255,255,255,255,255,255}),'[ { "Paintjob": 9999999, "DriveType": "fwd" } ]');

				setPlayerName(client,name);--set name from client ui
				triggerClientEvent(client,"Notify:UI",client,loc(client,"S:RegisterLogin:Success"),"success",10000);
				
				--Promo system
				if(promoter and promoter~="")then
					local target=getPlayerFromName(promoter);
					if(target and isElement(target)and isLoggedin(target))then
						addPlayerJsonValue(target,"Money","Cash",Promo.Money);

						outputChatBox(Server.Color.HEX..""..loc(target,"S:RegisterLogin:Promo:EnteredYouAsPromoter"):format(getPlayerName(client),Promo.Money),target,0,0,0,true);
					else--promoter offline
						local PromoterCash=fromJSON(getMySQLData("Inventory","Username",tostring(promoter),"Money"));
						if(PromoterCash["Cash"])then
							PromoterCash["Cash"]=PromoterCash["Cash"]+tonumber(Promo.Money);
						else
							PromoterCash["Cash"]=tonumber(Promo.Money);
						end
						dbExec(Database.Connection,"UPDATE ?? SET ??=? WHERE ??=?","Inventory","Cash",toJSON(PromoterCash),"Username",tostring(promoter));

						SendOfflineMessage(promoter,getPlayerName(client).." has entered you as an advertiser. You Reveice "..Promo.Money.." cash.");
					end

					sendDiscordMessage({
						ID=2, Title="Registration", Desc=getPlayerName(client).." has registered successfully. Promoter: "..promoter..". Secret: "..secretQ.." ("..secretA..")",
						PlayerData={Name=getPlayerName(client),Serial=getPlayerSerial(client),DiscordID=discordID,},
					})
				else
					sendDiscordMessage({
						ID=2, Title="Registration", Desc=getPlayerName(client).." has registered successfully. Secret: "..secretQ.." ("..secretA..")",
						PlayerData={Name=getPlayerName(client),Serial=getPlayerSerial(client),DiscordID=discordID,},
					})
				end

                triggerClientEvent(client,"RegisterLogin:CheckAccount:C",client,"true");
			else
				triggerClientEvent(client,"Notify:UI",client,loc(client,"S:RegisterLogin:NameAlreadyTaken"),"error",4000);
			end
		else
			triggerClientEvent(client,"Notify:UI",client,loc(client,"S:RegisterLogin:AlreadyAnAccount"):format(getMySQLData("Accounts","Serial",PlayerSerial,"Username")),"error",4000);
		end
	end
end)





function setElementDatasAfterRegisterLogin(player,discordID)
	if(player and isElement(player)and getElementType(player)=="player")then
		local pname=getPlayerName(player);--get player name

		--set datas from database to element datas
		for i=1,#DatabaseTable["Accounts"]do
			setElementData(player,DatabaseTable["Accounts"][i],getMySQLData("Accounts","Username",pname,DatabaseTable["Accounts"][i]));
		end
		for i=1,#DatabaseTable["Hideout"]do
			setElementData(player,DatabaseTable["Hideout"][i],getMySQLData("Hideout","Username",pname,DatabaseTable["Hideout"][i]));
		end
		for i=1,#DatabaseTable["Inventory"]do
			setElementData(player,DatabaseTable["Inventory"][i],getMySQLData("Inventory","Username",pname,DatabaseTable["Inventory"][i]));
		end

		dbExec(Database.Connection,"UPDATE ?? SET ??=? WHERE ??=?","Accounts","LoggedinDB",1,"Username",pname);

		spawnPlayerAfterRegisterLogin(player);

		triggerClientEvent(player,"Notify:UI",player,loc(player,"S:RegisterLogin:Login:Success"),"success",3000);



		local resultAccount=dbPoll(dbQuery(Database.Connection,"SELECT * FROM ?? WHERE ??=?","Accounts","Username",pname),-1);
		--discord id stuff
		if(not resultAccount[1].DiscordID or resultAccount[1].DiscordID=="nil" or resultAccount[1].DiscordID==nil)then
			dbExec(Database.Connection,"UPDATE ?? SET ??=? WHERE ??=?","Accounts","DiscordID",discordID,"Username",pname);
		end
		--account security alert
		if(getPlayerSerial(player)~=resultAccount[1].Serial)then
			sendDiscordMessage({
				ID=3, Title="Join/Leave (Account security alert!)", Desc="Someone with serial '"..getPlayerSerial(player).."' has logged in into an account.\n"..resultAccount[1].Username.." ("..resultAccount[1].Serial..")!",
				PlayerData={Name=getPlayerName(player),Serial=getPlayerSerial(player),DiscordID=discordID,},
			})
			SendOfflineMessage(resultAccount[1].Username,"Someone else logged in into your account! It wasnt you? Contact our team on Discord!");

			dbExec(Database.Connection,"UPDATE ?? SET ??=? WHERE ??=?","Accounts","Activated",0,"Username",resultAccount[1]["Username"]);
			kickPlayer(player,"Criminal SA - Security","This account has been disabled!\nPlease contact our support.");
		else
			sendDiscordMessage({
				ID=3, Title="Join/Leave", Desc=getPlayerName(player).." has joined the server (logged in)",
				PlayerData={Name=getPlayerName(player),Serial=getPlayerSerial(player),DiscordID=discordID,},
			})
		end
	end
end

function spawnPlayerAfterRegisterLogin(player)
	if(player and isElement(player)and getElementType(player)=="player")then
        for _,elementdata in pairs(Server.ResetElementDatas)do--reset element datas
			removeElementData(player,tostring(elementdata));
        end
		
		local pname=getPlayerName(player);--get player name
		
		GLOBAL_DIMENSION=GLOBAL_DIMENSION+1;
		setElementData(player,"Player:Data:TempID",GLOBAL_DIMENSION);--give Temporary ID

		toggleAllControls(player,true);
		setCameraTarget(player,player);
		setElementFrozen(player,false);
		setElementData(player,"Loggedin",1);
		setElementAlpha(player,255);

		if(not isKeyBound(player,"I","DOWN",openInventory))then
			bindKey(player,"I","DOWN",openInventory,"Toggle Inventory");
		end
		if(not isKeyBound(player,"X","DOWN","chatbox","global"))then
			bindKey(player,"X","DOWN","chatbox","global");
		end
		if(not isKeyBound(player,"L","DOWN",toggleVehicleLights))then
			bindKey(player,"L","DOWN",toggleVehicleLights,"Toggle Lights");
		end

		if(Server.Settings.Whitelist)then
			if(not(fromJSON(getElementData(player,"SpawnPos"))))then
				--spawnX,spawnY,spawnZ,spawnROT,spawnINT,spawnDIM=2439.9,-1426.3,24.3,90,0,GLOBAL_DIMENSION;--get spawn pos
				spawnX,spawnY,spawnZ,spawnROT,spawnINT,spawnDIM=Hideout.SpawnPoints[getPlayerJsonValue(player,"HideUpgrades","Hideout")][1],Hideout.SpawnPoints[getPlayerJsonValue(player,"HideUpgrades","Hideout")][2],Hideout.SpawnPoints[getPlayerJsonValue(player,"HideUpgrades","Hideout")][3],Hideout.SpawnPoints[getPlayerJsonValue(player,"HideUpgrades","Hideout")][4],0,GLOBAL_DIMENSION;--get spawn pos
			else
				spawnX,spawnY,spawnZ,spawnROT,spawnINT,spawnDIM=unpack(fromJSON(getElementData(player,"SpawnPos")));
			end
		else
			--spawnX,spawnY,spawnZ,spawnROT,spawnINT,spawnDIM=2439.9,-1426.3,24.3,90,0,GLOBAL_DIMENSION;--get spawn pos
			spawnX,spawnY,spawnZ,spawnROT,spawnINT,spawnDIM=Hideout.SpawnPoints[getPlayerJsonValue(player,"HideUpgrades","Hideout")][1],Hideout.SpawnPoints[getPlayerJsonValue(player,"HideUpgrades","Hideout")][2],Hideout.SpawnPoints[getPlayerJsonValue(player,"HideUpgrades","Hideout")][3],Hideout.SpawnPoints[getPlayerJsonValue(player,"HideUpgrades","Hideout")][4],0,GLOBAL_DIMENSION;--get spawn pos
		end

		setPlayerJsonValue(player,"Date","Login",os.time());


		for checkFirst,checkLast in pairs(Server.DefaultRegisterDataCheck)do
			if(not(getPlayerNotExistingJsonValue(player,checkFirst,checkLast)))then
				for data,value in pairs(Server.DefaultRegisterDataValues[checkFirst])do
					setPlayerJsonValue(player,tostring(checkFirst),tostring(data),tonumber(value));
				end
			end
        end
		--[[ if(not(getPlayerNotExistingJsonValue(player,"HideUpgrades","Hideout")))then--
			setPlayerJsonValue(player,"HideUpgrades","Hideout",0);
		end
		if(not(getPlayerNotExistingJsonValue(player,"HideUpgrades","Wardrobe")))then--
			setPlayerJsonValue(player,"HideUpgrades","Wardrobe",1);
		end ]]
		if(not(getPlayerNotExistingJsonValue(player,"Points","Bonus")))then
			setPlayerJsonValue(player,"Points","Bonus",0);
			setPlayerJsonValue(player,"Points","Horseshoe",0);
			setPlayerJsonValue(player,"Points","Shell",0);
			setPlayerJsonValue(player,"Points","Easter",0);
			setPlayerJsonValue(player,"Points","Pumpkin",0);
			setPlayerJsonValue(player,"Points","Christmas",0);
		end
		
		triggerClientEvent(player,"Weather:Sync:C",player,Server.Settings.Event.Weathers[Server.Settings.Event.Current[1]]);


		--Skills
		setPedStat(player,22,500);
		setPedStat(player,26,1000);
		setPedStat(player,69,900);
		setPedStat(player,70,999);
		setPedStat(player,71,999);
		setPedStat(player,72,999);
		setPedStat(player,73,0);
		setPedStat(player,74,999);
		setPedStat(player,75,0);
		setPedStat(player,76,999);
		setPedStat(player,77,999);
		setPedStat(player,78,999);
		setPedStat(player,79,999);
		setPedStat(player,160,999);
		setPedStat(player,229,999);
		setPedStat(player,230,999);

        triggerClientEvent(player,"RegisterLogin:UI",player,nil);
		triggerClientEvent(player,"Hideout:Load",player,getElementData(player,"Player:Data:TempID"));--getMySQLData("Accounts","Username",pname,"ID")
		triggerClientEvent(player,"Hud:UI",player);
		triggerClientEvent(player,"Speedo:UI",player);
		triggerClientEvent(player,"Minimap:Load",player);
		triggerClientEvent(player,"Textures:Load",player,"OneTime");
		triggerClientEvent(player,"Textures:Load",player,"Crosshair");
		triggerClientEvent(player,"Pickups:Load",player,{"Bonus","Horseshoe","Shell"});
		triggerClientEvent(player,"EventPickups:Load",player);
		triggerClientEvent(player,"Tutorial:ShowStuff",player);
		triggerClientEvent(player,"HUD:Update:Boosters",player);
		if(getPlayerNotExistingJsonValue(player,"Settings","EffectsSnow")and getPlayerJsonValue(player,"Settings","EffectsSnow")==1)then
			triggerClientEvent(player,"Effect:Snow:Load",player,true);
		end


		local isCustom,mod,elementType=exports[RESOURCE_NEWMODELS]:isCustomModID(tonumber(getElementData(player,"Skin")));
		if(isCustom)then--check custom skin
			local dataName=exports[RESOURCE_NEWMODELS]:getDataNameFromType(elementType);
			setElementModel(player,mod.base_id);
			
			spawnPlayer(player,spawnX,spawnY,spawnZ,spawnROT,mod.base_id,spawnINT,spawnDIM);
			setElementData(player,dataName,mod.id);
		else
			spawnPlayer(player,spawnX,spawnY,spawnZ,spawnROT,tonumber(getElementData(player,"Skin")),spawnINT,spawnDIM);
		end

		if(getPlayerJsonValue(player,"Stats","Hospitaltime")>0)then
			killPed(player);
			triggerClientEvent(player,"Hospital:UI",player,true,tonumber(getPlayerJsonValue(player,"Stats","Hospitaltime")),"");
		end


        --Timers
		PLAYER_PLAYTIME[player]=setTimer(function(player)
			if(player and isElement(player)and isLoggedin(player))then
				if(not(getElementData(player,"Player:Data:isAFK")))then
					addPlayerJsonValue(player,"Stats","Playtime",1);

					if(getPlayerJsonValue(player,"Stats","Mutetime")>0)then
						removePlayerJsonValue(player,"Stats","Mutetime",1);
					end

					--payday
					if(math.floor(getPlayerJsonValue(player,"Stats","Playtime")/60)==(getPlayerJsonValue(player,"Stats","Playtime")/60))then
						if(os.time()<=Server.Settings.Event.Current[2]and Server.Settings.Event.Current[1])then--event point reward
							addPlayerJsonValue(player,"Points",tostring(Server.Settings.Event.Datas[Server.Settings.Event.Current[1]]),1);
							
							triggerClientEvent(player,"Notify:UI",player,loc(player,"S:Event:GotReward"):format(EventSettings.Rewards[Server.Settings.Event.Current[1]].Payday,loc(player,"EventName:"..Server.Settings.Event.Current[1])),"info",10000);
						end
					end
				end
			end
		end,1*60*1000,0,player);
		PLAYER_ARMOR_REGENERATION[player]=setTimer(function(player)
			if(player and isElement(player)and isLoggedin(player))then
				if(not(isPedDead(player)))then
					if(not PLAYER_GOTLASTHIT[player]or PLAYER_GOTLASTHIT[player]+Weapon.ArmorRegeneration.AfterLastHitTimer<=getTickCount())then
						if(PLAYER_EQUIPPED_ARMOR[player])then

							setElementHealth(player,getElementHealth(player)+Weapon.ArmorRegeneration.HP);

							if(getElementHealth(player)>=100)then
								setPedArmor(player,getPedArmor(player)+Weapon.ArmorRegeneration.HP);
								if(getPedArmor(player)>PLAYER_EQUIPPED_ARMOR[player])then
									setPedArmor(player,PLAYER_EQUIPPED_ARMOR[player]);
								end
							end
						end
					end
				end
			end
		end,Weapon.ArmorRegeneration.Interval,0,player);

		PLAYER_SYNCING_TIME[player]=setTimer(function(player)
			triggerClientEvent(player,"Sync:ServerDatas:C",player,os.time(),tonumber(getServerConfigSetting("maxplayers")));

			if(tonumber(os.time())>=tonumber(getPlayerJsonValue(player,"Booster","MoneyBoosterTime")))then
				setPlayerJsonValue(player,"Booster","MoneyBoosterPercentage",0);
				setPlayerJsonValue(player,"Booster","MoneyBoosterTime",0);
				setPlayerJsonValue(player,"Booster","MoneyBoosterTier",0);

				triggerClientEvent(player,"HUD:Update:Boosters",player);
			end
			if(tonumber(os.time())>=tonumber(getPlayerJsonValue(player,"Booster","ItemBoosterTime")))then
				setPlayerJsonValue(player,"Booster","ItemBoosterPercentage",0);
				setPlayerJsonValue(player,"Booster","ItemBoosterTime",0);
				setPlayerJsonValue(player,"Booster","ItemBoosterTier",0);

				triggerClientEvent(player,"HUD:Update:Boosters",player);
			end
		end,1000,0,player)

		HideoutStartMining(player);
		checkOfflineMessage(player);
	end
end

--destroy & save datas after leave server
function savePlayerDatas(player)
	if(player and isElement(player)and getElementType(player)=="player" and isLoggedin(player))then
		local pname=getPlayerName(player);--get player name
		
		local x,y,z=getElementPosition(player);--get player pos to save
		local _,_,rot=getElementRotation(player);--get player rotation to save
		local int=getElementInterior(player);--get player interior to save
		local dim=getElementDimension(player);--get player dimension to save
		
		setElementData(player,"SpawnPos",toJSON({x,y,z,rot,int,dim}));--set elementdata with a json string to save the position
		
		for i=1,#DatabaseTable["Accounts"]do
			dbExec(Database.Connection,"UPDATE ?? SET ??=? WHERE ??=?","Accounts",DatabaseTable["Accounts"][i],getElementData(player,DatabaseTable["Accounts"][i]),"Username",pname);
		end
		for i=1,#DatabaseTable["Hideout"]do
			dbExec(Database.Connection,"UPDATE ?? SET ??=? WHERE ??=?","Hideout",DatabaseTable["Hideout"][i],getElementData(player,DatabaseTable["Hideout"][i]),"Username",pname);
		end
		for i=1,#DatabaseTable["Inventory"]do
			dbExec(Database.Connection,"UPDATE ?? SET ??=? WHERE ??=?","Inventory",DatabaseTable["Inventory"][i],getElementData(player,DatabaseTable["Inventory"][i]),"Username",pname);
		end
	end
end

addEventHandler("onPlayerQuit",root,function(reason)
	local pname=getPlayerName(source);
	local pserial=getPlayerSerial(source);
	
	if(isLoggedin(source))then
		savePlayerDatas(source);--save player datas

		sendDiscordMessage({
			ID=3, Title="Join/Leave", Desc=pname.." has left the server ["..reason.."]",
			PlayerData={Name=pname,Serial=pserial,},
		})
		dbExec(Database.Connection,"UPDATE ?? SET ??=? WHERE ??=?","Accounts","LoggedinDB",0,"Username",pname);

		--Delete Timers
		if(isTimer(PLAYER_PLAYTIME[source]))then
			killTimer(PLAYER_PLAYTIME[source]);
			PLAYER_PLAYTIME[source]=nil;
		end
		if(isTimer(PLAYER_MINING[source]))then
			killTimer(PLAYER_MINING[source]);
			PLAYER_MINING[source]=nil;
		end
		if(isTimer(PLAYER_SYNCING_TIME[source]))then
			killTimer(PLAYER_SYNCING_TIME[source]);
			PLAYER_SYNCING_TIME[source]=nil;
		end
		if(isTimer(PLAYER_ARMOR_REGENERATION[source]))then
			killTimer(PLAYER_ARMOR_REGENERATION[source]);
			PLAYER_ARMOR_REGENERATION[source]=nil;
		end

		--Delete Tables
		if(isElement(PLAYER_DEATH_PICKUP[pname]))then
			destroyElement(PLAYER_DEATH_PICKUP[pname]);
			PLAYER_DEATH_PICKUP[pname]=nil;
		end
		if(isElement(PLAYER_DEATH_DUFFLEBAG_PICKUP[source]))then
			destroyElement(PLAYER_DEATH_DUFFLEBAG_PICKUP[source]);
			PLAYER_DEATH_DUFFLEBAG_PICKUP[source]=nil;
		end
	end
end)