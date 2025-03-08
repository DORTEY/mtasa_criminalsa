addRemoteEvents{"Pickups:Give"};--addEvent


addEventHandler("Pickups:Give",root,function(type,id)
	if(client and isElement(client)and getElementType(client)=="player" and isLoggedin(client))then
		if(type=="Bonus" or type=="Horseshoe" or type=="Shell")then
			if(not(getPlayerNotExistingJsonValue(client,"Pickups",type.."-"..tonumber(id))))then
				setPlayerJsonValue(client,"Pickups",type.."-"..tonumber(id),1);

				addPlayerJsonValue(client,"Money","Cash",tonumber(Achievements.Pickups[type].Reward.Money));
				addPlayerJsonValue(client,"Points",tostring(type),tonumber(Achievements.Pickups[type].Reward.Points));

				triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Pickups:Got"..type):format(Achievements.Pickups[type].Reward.Money,Achievements.Pickups[type].Reward.Points),"info",5000);
			end
		elseif(type=="Easter" or type=="Pumpkin" or type=="Christmas")then
			if(not(getPlayerNotExistingJsonValue(client,"EventPickups",type.."-"..tonumber(id))))then
				setPlayerJsonValue(client,"EventPickups",type.."-"..tonumber(id),1);
	
				addPlayerJsonValue(client,"Money","Cash",tonumber(Achievements.Pickups[type].Reward.Money));
				addPlayerJsonValue(client,"Points",tostring(type),tonumber(Achievements.Pickups[type].Reward.Points));

				triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Pickups:Got"..type):format(Achievements.Pickups[type].Reward.Money,Achievements.Pickups[type].Reward.Points),"info",5000);
			end
		end
	end
end)

function addAchievement(player,achievement)
	if(player and isElement(player)and getElementType(player)=="player" and isLoggedin(player))then
		if(not(getPlayerNotExistingJsonValue(player,"Achievements",tostring(achievement))))then
			for _,v in pairs(Achievements.Achievements)do
				if(v.ID==tostring(achievement))then
					if(v.Reward[getPlayerJsonValue(player,"Achievements",tostring(achievement))]and v.Reward[getPlayerJsonValue(player,"Achievements",tostring(achievement))].Money)then
						addPlayerJsonValue(player,"Money","Cash",v.Reward[getPlayerJsonValue(player,"Achievements",tostring(achievement))].Money);
					end
					if(v.Reward[getPlayerJsonValue(player,"Achievements",tostring(achievement))]and v.Reward[getPlayerJsonValue(player,"Achievements",tostring(achievement))].Item)then
						if(v.Reward[getPlayerJsonValue(player,"Achievements",tostring(achievement))].Item[1]=="CrimeCoin")then
							addPlayerJsonValue(player,"Money","CrimeCoin",v.Reward[getPlayerJsonValue(player,"Achievements",tostring(achievement))].Item[2]);
						else
							addPlayerJsonValue(player,"Items",v.Reward[getPlayerJsonValue(player,"Achievements",tostring(achievement))].Item[1],v.Reward[getPlayerJsonValue(player,"Achievements",tostring(achievement))].Item[2]);
						end
					end

					setPlayerJsonValue(player,"Achievements",tostring(achievement),1);

					triggerClientEvent(player,"Notify:UI",player,loc(player,"S:Userpanel:AchievementReached"):format(loc(player,"UI:Userpanel:Achievement:Display:"..tostring(achievement))),"achievement",15000);
				end
			end
		else
			for _,v in pairs(Achievements.Achievements)do
				if(v.ID==tostring(achievement))then
					if(v.Requirement[getPlayerJsonValue(player,"Achievements",tostring(achievement))])then
						if(v.Reward[getPlayerJsonValue(player,"Achievements",tostring(achievement))]and v.Reward[getPlayerJsonValue(player,"Achievements",tostring(achievement))].Money)then
							addPlayerJsonValue(player,"Money","Cash",v.Reward[getPlayerJsonValue(player,"Achievements",tostring(achievement))].Money);
						end
						if(v.Reward[getPlayerJsonValue(player,"Achievements",tostring(achievement))]and v.Reward[getPlayerJsonValue(player,"Achievements",tostring(achievement))].Item)then
							if(v.Reward[getPlayerJsonValue(player,"Achievements",tostring(achievement))].Item[1]=="CrimeCoin")then
								addPlayerJsonValue(player,"Money","CrimeCoin",v.Reward[getPlayerJsonValue(player,"Achievements",tostring(achievement))].Item[2]);
							else
								addPlayerJsonValue(player,"Items",v.Reward[getPlayerJsonValue(player,"Achievements",tostring(achievement))].Item[1],v.Reward[getPlayerJsonValue(player,"Achievements",tostring(achievement))].Item[2]);
							end
						end

						addPlayerJsonValue(player,"Achievements",tostring(achievement),1);

						triggerClientEvent(player,"Notify:UI",player,loc(player,"S:Userpanel:AchievementReached"):format(loc(player,"UI:Userpanel:Achievement:Display:"..tostring(achievement))),"achievement",15000);
					end
				end
			end
		end
	end
end

--[[ addCommandHandler("koks",function(player,cmd)
	addPlayerJsonValue(player,"Stats","ATMsRobbed",1);
end)
addCommandHandler("koks3",function(player,cmd)
	addPlayerJsonValue(player,"Stats","BotKills",1);
end)
addCommandHandler("koks2",function(player,cmd)
	addAchievement(player,"robatms");
end) ]]