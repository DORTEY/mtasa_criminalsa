addRemoteEvents{"Inventory:Refresh:S","Inventory:UseItem:S","Inventory:ThrowItem:S"};--addEvents


--Main Inventory Functions
local PlayerItem={};
local PlayerItemTimer={};
local PlayerRandom={};


local PlayerInventoryStatus={};
function openInventory(player)
	if(player and isElement(player)and isLoggedin(player))then
		if(isClickedState(player)==false)then
			if(not(PlayerInventoryStatus[player]))then
				PlayerInventoryStatus[player]=true;
				triggerClientEvent(player,"Inventory:UI",player,true);
				triggerClientEvent(player,"Inventory:Refresh",player,getPlayerJsonTable(player,"Items"));
			else
				PlayerInventoryStatus[player]=nil;
				triggerClientEvent(player,"Inventory:UI",player);
			end
		else
			if(PlayerInventoryStatus[player])then
				PlayerInventoryStatus[player]=nil;
				triggerClientEvent(player,"Inventory:UI",player);
			end
		end
	end
end

addEventHandler("Inventory:Refresh:S",root,function()
	if(client and isElement(client)and getElementType(client)=="player" and isLoggedin(client))then
		if(PlayerInventoryStatus[client])then
			triggerClientEvent(client,"Inventory:Refresh",client,getPlayerJsonTable(client,"Items"));
		end
	end
end)


addEventHandler("Inventory:UseItem:S",root,function(item)
	if(client and isElement(client)and getElementType(client)=="player" and isLoggedin(client))then
		if(getPlayerJsonValue(client,"Items",tostring(item))>=1)then
			if(Items[tostring(item)]and Items[tostring(item)].Useable)then
				if(not(isTimer(PlayerItemTimer[client])))then


					if(item=="Repairkit")then
						local nearestVeh=GetNearestVehicle(client,2);
						if(nearestVeh)then
							if(not PLAYER_GOTLASTHIT[client]or PLAYER_GOTLASTHIT[client]+Weapon.AllowRepairAfterLastHitTimer<=getTickCount())then
								setElementFrozen(client,true);
								setPedAnimation(client,"graffiti","spraycan_fire");
								PlayerItemTimer[client]=setTimer(function(client)
									setElementFrozen(client,false);
									setPedAnimation(client);

									fixVehicle(nearestVeh);
									removePlayerJsonValue(client,"Items",tostring(item),1);
								end,Items[tostring(item)].Duration,1,client)
							else
								triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Vehicle:CantRepair"):format((Weapon.AllowRepairAfterLastHitTimer/1000)),"warning",5000);
							end
						end
					end
					if(item=="Medikit")then
						if(not isPedInVehicle(client))then
							if(not PLAYER_GOTLASTHIT[client]or PLAYER_GOTLASTHIT[client]+Weapon.AllowMedikitAfterLastHitTimer<=getTickCount())then
								if(getElementHealth(client)==100)then
									return;
								end

								removePlayerJsonValue(client,"Items",tostring(item),1);

								setElementFrozen(client,true);
								setPedAnimation(client,"BOMBER","BOM_Plant_Crouch_In");
								PlayerItemTimer[client]=setTimer(function(client)
									setElementFrozen(client,false);
									setPedAnimation(client);

									setElementHealth(client,getElementHealth(client)+50);
								end,Items[tostring(item)].Duration,1,client)
							else
								triggerClientEvent(client,"Notify:UI",client,loc(client,"S:CantUseMedikit"):format((Weapon.AllowMedikitAfterLastHitTimer/1000)),"warning",5000);
							end
						end
					end
					if(item:find("MoneyBooster"))then
						if(not(getPlayerNotExistingJsonValue(client,"Booster","MoneyBoosterPercentage")))then
							setPlayerJsonValue(client,"Booster","MoneyBoosterPercentage",0);
							setPlayerJsonValue(client,"Booster","MoneyBoosterTime",0);
						end

						if(getPlayerJsonValue(client,"Booster","MoneyBoosterTime")==0)then
							local BoosterTier=item:gsub("MoneyBooster","");

							setPlayerJsonValue(client,"Booster","MoneyBoosterPercentage",Items[tostring(item)].Percentage);
							setPlayerJsonValue(client,"Booster","MoneyBoosterTime",os.time()+Items[tostring(item)].Duration);
							setPlayerJsonValue(client,"Booster","MoneyBoosterTier",tonumber(BoosterTier));

							triggerClientEvent(client,"Notify:UI",client,loc(client,"S:UsedBooster"):format(loc(client,"Item:"..tostring(item))),"success",5000);

							triggerClientEvent(client,"HUD:Update:Boosters",client);
							removePlayerJsonValue(client,"Items",tostring(item),1);
						else
							triggerClientEvent(client,"Notify:UI",client,loc(client,"S:CantUseBooster"),"error",5000);
						end
					end
					if(item:find("ItemBooster"))then
						if(not(getPlayerNotExistingJsonValue(client,"Booster","ItemBoosterPercentage")))then
							setPlayerJsonValue(client,"Booster","ItemBoosterPercentage",0);
							setPlayerJsonValue(client,"Booster","ItemBoosterTime",0);
						end
						
						if(getPlayerJsonValue(client,"Booster","ItemBoosterTime")==0)then
							local BoosterTier=item:gsub("ItemBooster","");

							setPlayerJsonValue(client,"Booster","ItemBoosterPercentage",Items[tostring(item)].Percentage);
							setPlayerJsonValue(client,"Booster","ItemBoosterTime",os.time()+Items[tostring(item)].Duration);
							setPlayerJsonValue(client,"Booster","ItemBoosterTier",tonumber(BoosterTier));

							triggerClientEvent(client,"Notify:UI",client,loc(client,"S:UsedBooster"):format(loc(client,"Item:"..tostring(item))),"success",5000);

							triggerClientEvent(client,"HUD:Update:Boosters",client);
							removePlayerJsonValue(client,"Items",tostring(item),1);
						else
							triggerClientEvent(client,"Notify:UI",client,loc(client,"S:CantUseBooster"),"error",5000);
						end
					end

					if(item:find("Present"))then
						removePlayerJsonValue(client,"Items",tostring(item),1);

						--Random reward
						PlayerRandom[client]=math.random(0,300);
						for i,v in pairs(ItemDrops[tostring(item)])do
							local RandomAmount=math.random(v.Amount[1],v.Amount[2]);

							if(PlayerRandom[client]<=v.Chance)then
								if(v.Item:find("Vehicle_"))then
									local VehicleID=v.Item:gsub("Vehicle_","");
									
									giveVehicleToPlayer(client,tonumber(VehicleID));

									triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Job:GotItem"):format(loc(client,"Item:"..v.Item),1),"info",5000);
								else
									addPlayerJsonValue(client,"Items",tostring(v.Item),tonumber(RandomAmount));
									triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Job:GotItem"):format(loc(client,"Item:"..v.Item),RandomAmount),"info",5000);
								end
							end
						end
					end




					if(item:find("Wheel_"))then
						if(isPedInVehicle(client))then
							local veh=getPedOccupiedVehicle(client);
							if(veh and isElement(veh)and getElementData(veh,"Vehicle:Data:Owner"))then
								local VehOwner=tostring(getElementData(veh,"Vehicle:Data:Owner"))or nil;
								local VehID=tonumber(getElementData(veh,"Vehicle:Data:ID"))or nil;
								local VehModelID=tonumber(getElementData(veh,"Vehicle:Data:VehID"))or nil;
	
								if(Vehicle.Types["Cars"][VehModelID])then
									if(getPedOccupiedVehicleSeat(client)==0)then
										if(VehOwner==getPlayerName(client))then
											local id=item:gsub("Wheel_","");
											
											if(Vehicle.Tuning.ModdedWheels[tonumber(id)])then
												triggerClientEvent(root,"Vehicle:Preview:Wheels",root,veh,tonumber(id));
											else
												triggerClientEvent(root,"Vehicle:Preview:Wheels",root,veh);
												addVehicleUpgrade(veh,tonumber(id));
											end
	
											setVehicleJsonValue(veh,"Tunings","Wheels",tonumber(id));
											dbExec(Database.Connection,"UPDATE ?? SET ??=? WHERE ??=? AND ??=?","Vehicles","Tunings",getElementData(veh,"Tunings"),"Username",VehOwner,"ID",VehID);
	
											removePlayerJsonValue(client,"Items",tostring(item),1);
										end
									end
								end
							end
						else
							triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Vehicle:NotInAnyVehicle"),"error",5000);
						end
					end
				end
				triggerClientEvent(client,"Inventory:Refresh",client,getPlayerJsonTable(client,"Items"));
			end
		else
			triggerClientEvent(client,"Inventory:Refresh",client,getPlayerJsonTable(client,"Items"));
		end
	end
end)

local function destroyElementsAfterQuitDead(player)
    if(player and isElement(player))then
        if(isTimer(PlayerItemTimer[player]))then
			killTimer(PlayerItemTimer[player]);
			PlayerItemTimer[player]=nil;
		end
    end
end

addEventHandler("onPlayerQuit",root,function()
	destroyElementsAfterQuitDead(source);
end)
addEventHandler("onPlayerWasted",root,function()
	destroyElementsAfterQuitDead(source);
end)