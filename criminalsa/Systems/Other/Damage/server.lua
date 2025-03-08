addRemoteEvents{"Damage:Trigger:FromPlayerToPlayer","Damage:Trigger:FromPlayerToPed","Damage:Trigger:Ped",
"Hospital:Respawn","Hospital:UpdateTime"};--addEvent


local PlayerRandom={};


addEventHandler("onPlayerWasted",root,function(ammo,attacker,weapon,bodypart)
	if(source and isElement(source)and getElementType(source)=="player" and isLoggedin(source))then
		local pname=getPlayerName(source);
		local x,y,z=getElementPosition(source);
		local int=getElementInterior(source);
		local dim=getElementDimension(source);
		
		if(isElement(PLAYER_DEATH_PICKUP[pname]))then
			destroyElement(PLAYER_DEATH_PICKUP[pname]);
			PLAYER_DEATH_PICKUP[pname]=nil;
		end
		if(isElement(PLAYER_DEATH_DUFFLEBAG_PICKUP[source]))then
			destroyElement(PLAYER_DEATH_DUFFLEBAG_PICKUP[source]);
			PLAYER_DEATH_DUFFLEBAG_PICKUP[source]=nil;
		end

		setElementDimension(source,dim);
		setElementInterior(source,int);
		toggleGhostMode(source,false,0);

		PLAYER_DEATH_PICKUP[pname]=createPickup(x,y,z,3,1254,1000);
		setElementDimension(PLAYER_DEATH_PICKUP[pname],dim);
		setElementInterior(PLAYER_DEATH_PICKUP[pname],int);



		--Killfeed
		if(not(attacker))then
			triggerClientEvent(root,"Killfeed:UI",root,getPlayerName(source).." commited suicide");

			if(getElementData(source,"Player:Data:RobbedAmount"))then--set if element data doesnt exist
				removeElementData(source,"Player:Data:RobbedAmount");
				triggerClientEvent(source,"Rob:DeliverMarker",source);
			end
		else
			if(attacker and getElementType(attacker)=="player")then
				if(attacker~=source)then--by player
					local Distance=#(Vector3(getElementPosition(attacker))-Vector3(getElementPosition(source)));
					local Bounty=getPlayerJsonValue(source,"Stats","Bounty")or 0;
					if(Bounty and Bounty>0)then
						triggerClientEvent(root,"Killfeed:UI",root,getPlayerName(source).." got killed by "..getPlayerName(attacker).." $"..Bounty.." ("..math.floor(Distance).."m)");
					else
						triggerClientEvent(root,"Killfeed:UI",root,getPlayerName(source).." got killed by "..getPlayerName(attacker).." ("..math.floor(Distance).."m)");
					end

					

					--drop robbed money
					if(getElementData(source,"Player:Data:RobbedAmount")and getElementData(source,"Player:Data:RobbedAmount")>0)then
						PLAYER_DEATH_DUFFLEBAG_PICKUP[source]=createPickup(x,y,z,3,3915,1000);
						setElementDimension(PLAYER_DEATH_DUFFLEBAG_PICKUP[source],dim);
						setElementInterior(PLAYER_DEATH_DUFFLEBAG_PICKUP[source],int);

						setElementData(PLAYER_DEATH_DUFFLEBAG_PICKUP[source],"Pickup:Data:Money",tonumber(getElementData(source,"Player:Data:RobbedAmount")));
						if(getElementData(source,"Player:Data:RobbedAmount"))then--set if element data doesnt exist
							removeElementData(source,"Player:Data:RobbedAmount");
							triggerClientEvent(source,"Rob:DeliverMarker",source);
						end

						PLAYER_DEATH_DUFFLEBAG_PICKUP_TIMER[PLAYER_DEATH_DUFFLEBAG_PICKUP[source]]=setTimer(function(element)
							if(element and isElement(element))then
								destroyElement(PLAYER_DEATH_DUFFLEBAG_PICKUP[element]);
								PLAYER_DEATH_DUFFLEBAG_PICKUP[element]=nil;
							end
						end,Weapon.DufflebagDespawn,1,source)

						addEventHandler("onPickupHit",PLAYER_DEATH_DUFFLEBAG_PICKUP[source],function(player)
							if(player and isElement(player)and getElementType(player)=="player" and isLoggedin(player))then
								if(not(isPedDead(player)))then
									local MaxMoney=Hideout.Dufflebag.Benefits[tonumber(getPlayerJsonValue(player,"HideUpgrades","Dufflebag"))]and Hideout.Dufflebag.Benefits[tonumber(getPlayerJsonValue(player,"HideUpgrades","Dufflebag"))].max;
									
									if(not(getElementData(player,"Player:Data:RobbedAmount")))then--set if element data doesnt exist
										setElementData(player,"Player:Data:RobbedAmount",0);
									end
									
									if(tonumber(getElementData(player,"Player:Data:RobbedAmount"))<MaxMoney)then
										if(tonumber(getElementData(player,"Player:Data:RobbedAmount"))+tonumber(getElementData(source,"Pickup:Data:Money"))>=MaxMoney)then
											setElementData(player,"Player:Data:RobbedAmount",MaxMoney);
										else
											setElementData(player,"Player:Data:RobbedAmount",getElementData(player,"Player:Data:RobbedAmount")+tonumber(getElementData(source,"Pickup:Data:Money")));
										end

										createRobObjectsForPlayer(player);

										triggerClientEvent(player,"Rob:DeliverMarker",player,true);

										if(isTimer(PLAYER_DEATH_DUFFLEBAG_PICKUP_TIMER[source]))then
											killTimer(PLAYER_DEATH_DUFFLEBAG_PICKUP_TIMER[source]);
											PLAYER_DEATH_DUFFLEBAG_PICKUP_TIMER[source]=nil;
										end

										destroyElement(source);
										source=nil;
									end
								end
							end
						end)
					end

				elseif(attacker==source)then--by bot
					triggerClientEvent(root,"Killfeed:UI",root,getPlayerName(source).." got killed by BOT");
				end
			elseif(getElementType(attacker)=="vehicle")then
				triggerClientEvent(root,"Killfeed:UI",root,getPlayerName(source).." got killed by a Vehicle [VDM]");
			end
		end

		--death screen
		if(getPlayerJsonValue(source,"Stats","Hospitaltime")<=0)then
			setPlayerJsonValue(source,"Stats","Hospitaltime",Weapon.Other.Respawn);
			if(attacker and attacker~=source and getElementType(attacker)=="player")then
				triggerClientEvent(source,"Hospital:UI",source,true,Weapon.Other.Respawn,"Killed by "..getPlayerName(attacker));
			else
				triggerClientEvent(source,"Hospital:UI",source,true,Weapon.Other.Respawn,"");
			end
		end

		--kill
		if(attacker and attacker~=source and getElementType(attacker)=="player")then
			addPlayerJsonValue(attacker,"Stats","Kills",1);
			addPlayerJsonValue(source,"Stats","Deaths",1);

			if(getPlayerJsonValue(source,"Stats","Bounty")>0)then
				outputChatBox(loc(attacker,"S:Kill:GotBounty"):format(getPlayerName(source),getPlayerJsonValue(source,"Stats","Bounty")),attacker,Server.Color.RGB[1],Server.Color.RGB[2],Server.Color.RGB[3]);
				addPlayerJsonValue(attacker,"Money","Black",tonumber(getPlayerJsonValue(source,"Stats","Bounty")));
				setPlayerJsonValue(source,"Stats","Bounty",0);
			end
			
			--achievements
			addAchievement(attacker,"firstplayerkill");
			addAchievement(source,"firstdeath");
		end


		--save weapons & ammo
		if(not(PLAYER_EQUIPPED_WEAPONS[source]))then
			PLAYER_EQUIPPED_WEAPONS[source]={};
		end
		for i=0,12 do
			local weapon=getPedWeapon(source,i);
			if(weapon>0)then
				local ammo=getPedTotalAmmo(source,i);
				if(ammo>0)then
					PLAYER_EQUIPPED_WEAPONS[source][weapon]=ammo;
				end
			end
		end

	end
end)

addEventHandler("Hospital:Respawn",root,function()
	if(client and isElement(client)and getElementType(client)=="player" and isLoggedin(client))then
		setCameraTarget(client,client);
		local x,y,z=getElementPosition(client);
		local pname=getPlayerName(client);

		if(Server.Settings.Whitelist)then
			if(not(fromJSON(getElementData(client,"SpawnPos"))))then
				spawnX,spawnY,spawnZ,spawnROT,spawnINT,spawnDIM=Hideout.SpawnPoints[getPlayerJsonValue(client,"HideUpgrades","Hideout")][1],Hideout.SpawnPoints[getPlayerJsonValue(client,"HideUpgrades","Hideout")][2],Hideout.SpawnPoints[getPlayerJsonValue(client,"HideUpgrades","Hideout")][3],Hideout.SpawnPoints[getPlayerJsonValue(client,"HideUpgrades","Hideout")][4],0,getElementData(client,"Player:Data:TempID");--get spawn pos
			else
				spawnX,spawnY,spawnZ,spawnROT,spawnINT,spawnDIM=unpack(fromJSON(getElementData(client,"SpawnPos")));
			end
		else
			spawnX,spawnY,spawnZ,spawnROT,spawnINT,spawnDIM=Hideout.SpawnPoints[getPlayerJsonValue(client,"HideUpgrades","Hideout")][1],Hideout.SpawnPoints[getPlayerJsonValue(client,"HideUpgrades","Hideout")][2],Hideout.SpawnPoints[getPlayerJsonValue(client,"HideUpgrades","Hideout")][3],Hideout.SpawnPoints[getPlayerJsonValue(client,"HideUpgrades","Hideout")][4],0,getElementData(client,"Player:Data:TempID");--get spawn pos
		end
		
		local isCustomOld,_,elementTypeOld=exports[RESOURCE_NEWMODELS]:isCustomModID(getElementData(client,"Skin"));
		if(isCustomOld)then
			local dataName2=exports[RESOURCE_NEWMODELS]:getDataNameFromType(elementTypeOld);
			removeElementData(client,dataName2);
		end

		local isCustom,mod,elementType=exports[RESOURCE_NEWMODELS]:isCustomModID(tonumber(getElementData(client,"Skin")));
		if(isCustom)then--check custom skin
			local dataName=exports[RESOURCE_NEWMODELS]:getDataNameFromType(elementType);
			setElementModel(client,mod.base_id);
			
			spawnPlayer(client,spawnX,spawnY,spawnZ,spawnROT,mod.base_id,spawnINT,spawnDIM);
			setElementData(client,dataName,mod.id);
		else
			spawnPlayer(client,spawnX,spawnY,spawnZ,spawnROT,tonumber(getElementData(client,"Skin")),spawnINT,spawnDIM);
		end

		setPedHeadless(client,false);
		toggleAllControls(client,true);
		setElementFrozen(client,false);
		setPedAnimation(client);
		
		setElementHealth(client,100);
		if(PLAYER_EQUIPPED_ARMOR[client])then--give saved armor
			setPedArmor(client,tonumber(PLAYER_EQUIPPED_ARMOR[client]));
		end

		if(PLAYER_EQUIPPED_WEAPONS[source])then--give saved weapons
			for weapon,ammo in pairs(PLAYER_EQUIPPED_WEAPONS[source])do
				giveWeapon(source,tonumber(weapon),tonumber(ammo));
			end
			PLAYER_EQUIPPED_WEAPONS[source]=nil;
		end


		if(isElement(PLAYER_DEATH_PICKUP[pname]))then
			destroyElement(PLAYER_DEATH_PICKUP[pname]);
			PLAYER_DEATH_PICKUP[pname]=nil;
		end
		PLAYER_GOTLASTHIT[source]=0;

		setPlayerJsonValue(client,"Stats","Hospitaltime",0);
		triggerClientEvent(client,"Hospital:UI",client);
	end
end)

addEventHandler("Hospital:UpdateTime",root,function()
	if(client and isElement(client)and getElementType(client)=="player" and isLoggedin(client))then
		if(getPlayerJsonValue(client,"Stats","Hospitaltime")>0)then
			removePlayerJsonValue(client,"Stats","Hospitaltime",1);
		end
	end
end)


addEventHandler("Damage:Trigger:FromPlayerToPlayer",root,function(target,weapon,bodypart,loss)
	if(client and isElement(client)and getElementType(client)=="player" and isLoggedin(client))then
		if(target and isElement(target)and getElementType(target)=="player" and not isPedDead(target))then
			if(weapon and bodypart and loss)then
				--client=attacker

				if(getElementData(target,"Player:Data:Savezone")and not getElementData(target,"Player:Data:RobbedAmount"))then
					return false;
				end
				if(getElementData(client,"Player:Data:Savezone")and not getElementData(client,"Player:Data:RobbedAmount"))then
					return false;
				end

				if(getPlayerJsonValue(target,"Stats","Bounty")<1 and not getElementData(target,"Player:Data:RobbedAmount"))then
					return false;
				end
				if(getPlayerJsonValue(client,"Stats","Bounty")<1 and not getElementData(client,"Player:Data:RobbedAmount"))then
					return false;
				end

				triggerClientEvent(target,"Damage:Bloodscreen:C",target);--trigger bloodscreen


				local x1,y1,z1=getElementPosition(client);
				local x2,y2,z2=getElementPosition(target);
				local dist=getDistanceBetweenPoints3D(x1,y1,z1,x2,y2,z2);

				PLAYER_GOTLASTHIT[target]=getTickCount();
				PLAYER_GOTLASTHIT[client]=getTickCount();
				
				if(weapon==24 and dist<=1)then--boxing with deagle
					multiply=0.2;
				else
					if(bodypart==9)then--general headshot damage bonus
						multiply=1.3;
					else--regular damage
						multiply=1;
					end
				end
				
				if(weapon==34 and bodypart==9)then--headshot (sniper)
					setPedHeadless(target,true);
					killPed(target,client,weapon,bodypart);
					outputChatBox(loc(target,"S:Death:BySniper"),target,255,60,60);
				else
					local damage=(Weapon.DamagesOnPlayer[weapon]and Weapon.DamagesOnPlayer[weapon][bodypart]or 1)*multiply;
					if(damage)then
						damagePlayer(target,damage*multiply,client,weapon);
					else
						damagePlayer(target,loss,client,weapon);
					end
				end
			end
		end
	end
end)









--Bots
addEventHandler("Damage:Trigger:FromPlayerToPed",root,function(target,weapon,bodypart,loss,camethrough)
	if(client and isElement(client)and getElementType(client)=="player" and isLoggedin(client))then
		if(target and isElement(target)and getElementType(target)=="ped" and not isPedDead(target))then
			if(weapon and bodypart and loss)then
				--client = player
				--target = ped
				if(bodypart==9)then--general headshot damage bonus
					multiply=1.2;
				else--regular damage
					multiply=1;
				end
				
				if(camethrough)then
					local damage=(Weapon.DamagesOnPed[weapon]and Weapon.DamagesOnPed[weapon][bodypart]or 1)*multiply;
					if(damage)then
						damagePed(target,damage*multiply,client,weapon);
					else
						damagePed(target,loss,client,weapon);
					end
				else
					damagePed(target,0,client,0);
				end
			end
		end
	end
end)




addEventHandler("onPedWasted",root,function(ammo,attacker,weapon,bodypart)
	if(attacker and attacker~=source)then
		local x,y,z=getElementPosition(source);

		--Robs
		if(getElementData(source,"Bot:Data:Rob"))then
			local BotDataType=getElementData(source,"Bot:Data:Type");
			if(BotDataType=="Security:Regular" or BotDataType=="Security:Elite")then
				addPlayerJsonValue(attacker,"Stats","BotKills",1);
				addPlayerJsonValue(attacker,"Stats","Bounty",75);--give bounty
				
				--Random reward
				PlayerRandom[attacker]=math.random(0,300);
				for i,v in pairs(Weapon.RandomKillItemReward[tostring(BotDataType)])do
					local RandomAmount=math.random(v.Amount[1],v.Amount[2]);

					if(PlayerRandom[attacker]<=v.Chance)then
						addPlayerJsonValue(attacker,"Items",tostring(v.Item),tonumber(RandomAmount));
						triggerClientEvent(attacker,"Notify:UI",attacker,loc(attacker,"S:Rob:GiveExtraRewardFromPed"):format(loc(attacker,"Item:"..v.Item),RandomAmount,getElementData(source,"Ped:Data:Nametag:Title")),"info",6000);
					end
				end
			end
		end


		--Bosses
		if(getElementData(source,"Bot:Data:Bosses"))then
			local BotDataType=getElementData(source,"Bot:Data:Type");
			if(BotDataType=="Area51:Boss")then--BOSS
				createExplosion(x,y,z,6,nil);
				addPlayerJsonValue(attacker,"Stats","Bounty",7000);--give bounty

				for _,v in pairs(getElementsByType("player"))do
					if(v and isElement(v)and isLoggedin(v))then
						triggerClientEvent(v,"Notify:UI",v,loc(v,"S:Boss:GotKilledBy"):format(Bosses.Names["Area51"],getPlayerName(attacker)),"warning",10000);
						triggerClientEvent(v,"Killfeed:UI",v,loc(v,"S:Boss:GotKilledBy"):format(Bosses.Names["Area51"],getPlayerName(attacker)));
					end
				end

				addPlayerJsonValue(attacker,"Stats","BossKills",1);
				addAchievement(attacker,"firstbosskill");
			end
			if(BotDataType=="BigSmoke:Boss")then--BOSS
				addPlayerJsonValue(attacker,"Stats","Bounty",7000);--give bounty

				for _,v in pairs(getElementsByType("player"))do
					if(v and isElement(v)and isLoggedin(v))then
						triggerClientEvent(v,"Notify:UI",v,loc(v,"S:Boss:GotKilledBy"):format(Bosses.Names["BigSmoke"],getPlayerName(attacker)),"warning",10000);
						triggerClientEvent(v,"Killfeed:UI",v,loc(v,"S:Boss:GotKilledBy"):format(Bosses.Names["BigSmoke"],getPlayerName(attacker)));
					end
				end

				addPlayerJsonValue(attacker,"Stats","BossKills",1);
				addAchievement(attacker,"firstbosskill");
			end
			if(BotDataType=="SFPD:Chief")then--BOSS
				addPlayerJsonValue(attacker,"Stats","Bounty",7000);--give bounty

				for _,v in pairs(getElementsByType("player"))do
					if(v and isElement(v)and isLoggedin(v))then
						triggerClientEvent(v,"Notify:UI",v,loc(v,"S:Boss:GotKilledBy"):format(Bosses.Names["SFPD"],getPlayerName(attacker)),"warning",10000);
						triggerClientEvent(v,"Killfeed:UI",v,loc(v,"S:Boss:GotKilledBy"):format(Bosses.Names["SFPD"],getPlayerName(attacker)));
					end
				end

				addPlayerJsonValue(attacker,"Stats","BossKills",1);
				addAchievement(attacker,"firstbosskill");
			end

			if(BotDataType:find("Area51:")or BotDataType:find("BigSmoke:")or BotDataType:find("SFPD:"))then
				addPlayerJsonValue(attacker,"Stats","BotKills",1);

				--Random reward
				PlayerRandom[attacker]=math.random(0,300);
				for i,v in pairs(Weapon.RandomKillItemReward[tostring(BotDataType)])do
					local RandomAmount=math.random(v.Amount[1],v.Amount[2]);

					if(PlayerRandom[attacker]<=v.Chance)then
						addPlayerJsonValue(attacker,"Items",tostring(v.Item),tonumber(RandomAmount));
						triggerClientEvent(attacker,"Notify:UI",attacker,loc(attacker,"S:Rob:GiveExtraRewardFromPed"):format(loc(attacker,"Item:"..v.Item),RandomAmount,getElementData(source,"Ped:Data:Nametag:Title")),"info",6000);
					end
				end
			end

			addPlayerJsonValue(attacker,"Stats","Bounty",150);--give bounty
		end
	end
end)

addEventHandler("Damage:Trigger:Ped",root,function(weapon)
	if(client and isElement(client)and getElementType(client)=="player" and isLoggedin(client))then
		local damage=Weapon.DamagesPeds[weapon];
		if(damage)then
			damagePlayer(client,damage,client,weapon);

			PLAYER_GOTLASTHIT[client]=getTickCount();
		end
	end
end)





















function damagePlayer(element,amount,damager,weapon)
	if(element and isElement(element)and isLoggedin(element))then
		local amount=amount;
		local armor=getPedArmor(element);
		local health=getElementHealth(element);

		if(armor>0)then
			if(armor>=amount)then
				setPedArmor(element,armor-amount);
			else
				if(armor>0)then
					setPedArmor(element,0);
				end

				local newamount=amount-armor;
				if(health-newamount<=0)then
					killPed(element,damager,weapon);
					amount=armor+health;
				else
					setElementHealth(element,health-newamount);
				end
			end
		else
			if(health-amount<=0)then
				amount=health;
				killPed(element,damager,weapon);
			else
				setElementHealth(element,health-amount);
			end
		end
	end
end

function damagePed(element,amount,damager,weapon)
	if(element and isElement(element)and not isPedDead(element)and element~=damager)then
		local amountPed=amount;
		local armorPed=tonumber(getElementData(element,"Ped:Data:Armor"))or 0;
		local healthPed=tonumber(getElementData(element,"Ped:Data:Health"))or 0;

		if(armorPed>0)then
			if(armorPed>=amountPed)then
				setElementData(element,"Ped:Data:Armor",armorPed-amountPed);
			else
				if(armorPed>0)then
					setElementData(element,"Ped:Data:Armor",0);
				end

				local newamount=amountPed-armorPed;
				if(healthPed-newamount<=0)then
					killPed(element,damager,weapon);
					amountPed=armorPed+healthPed;
					setElementData(element,"Ped:Data:Health",0);
					print("ped got killed")
				else
					setElementData(element,"Ped:Data:Health",healthPed-newamount);
				end
			end
		else
			if(healthPed-amountPed<=0)then
				amountPed=healthPed;
				killPed(element,damager,weapon);
				setElementData(element,"Ped:Data:Health",0);
				print("ped got killed")
			else
				setElementHealth(element,healthPed-amountPed);
				setElementData(element,"Ped:Data:Health",healthPed-amountPed);
			end
		end
	end
end