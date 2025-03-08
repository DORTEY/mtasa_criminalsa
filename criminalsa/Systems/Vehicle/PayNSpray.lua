addEventHandler("onResourceStart",resourceRoot,function()
	local TableCols={};
	local TableBlips={};
	for id,v in pairs(Vehicle.PayNSpray.Locations)do
		TableCols[id]=createMarker(v[2],v[3],v[4],v[5],v[6],70,140,185,100);
		TableBlips[id]=createBlip(v[2],v[3],v[4],21,20,70,140,185,255,100);
		if(TableCols[id]and v[1])then
			setGarageOpen(v[1],true);--open the garages when they've
		end
		setElementData(TableBlips[id],"Blip:Data:Tooltip","Pay 'n' Spray #"..id);
		
		addEventHandler("onMarkerHit",TableCols[id],enterPayNspray);
	end
end)

function enterPayNspray(elem)
	if(elem and isElement(elem)and getElementType(elem)=="vehicle")then
		local player=getVehicleOccupant(elem,0);--get vehicle driver seat player
		if(player and isElement(player)and isLoggedin(player))then
			if(getElementDimension(source)==getElementDimension(player))then
				if(getElementHealth(getPedOccupiedVehicle(player))<1000)then
					local price=1000-getElementHealth(getPedOccupiedVehicle(player));
					if(getPlayerJsonValue(player,"Money","Cash")>=tonumber(price*Vehicle.PayNSpray.Percentage))then
						toggleAllControls(player,false);
						setElementFrozen(player,true);
						setElementFrozen(elem,true);
						
						PLAYER_VEHICLE_PAYNSPRAY_TIMER[player]=setTimer(function(player,elem)
							playSoundFrontEnd(player,46);
							toggleAllControls(player,true);
							setElementFrozen(player,false);
							setElementFrozen(elem,false);
							fixVehicle(elem);

							local VehArmory=getVehicleJsonValue(elem,"Tunings","Armory")or 0;
							if(VehArmory and VehArmory>0 and VehArmory~=9999999)then
								setElementHealth(elem,Vehicle.Tuning.Armory[VehArmory]);
							end
							
							removePlayerJsonValue(player,"Money","Cash",tonumber(math.floor(price*Vehicle.PayNSpray.Percentage)));
							triggerClientEvent(player,"Notify:UI",player,loc(player,"S:Vehicle:RepairSuccess"):format(math.floor(price*Vehicle.PayNSpray.Percentage)),"success",5000);
							
							PLAYER_VEHICLE_PAYNSPRAY_TIMER[player]=nil;
						end,Vehicle.PayNSpray.Timer,1,player,elem)
					else
						triggerClientEvent(player,"Notify:UI",player,loc(player,"S:Vehicle:NotEnoughMoney"):format(getPlayerJsonValue(player,"Money","Cash"),math.floor(price*Vehicle.PayNSpray.Percentage)),"error",5000);
					end
				end
			end
		end
	end
end


local function destroyElementsAfterQuitDead(player)
	if(isTimer(PLAYER_VEHICLE_PAYNSPRAY_TIMER[source]))then
		killTimer(PLAYER_VEHICLE_PAYNSPRAY_TIMER[source]);
		PLAYER_VEHICLE_PAYNSPRAY_TIMER[source]=nil;
	end
end
addEventHandler("onPlayerQuit",root,function()
	destroyElementsAfterQuitDead(source);
end)
addEventHandler("onPlayerWasted",root,function()
	destroyElementsAfterQuitDead(source);
end)