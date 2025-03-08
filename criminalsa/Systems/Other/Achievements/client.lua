addRemoteEvents{"Pickups:Load","EventPickups:Load"};--addEvent


local Object=nil;
local Objects={};


local function pickupBonus(elem,dim)
	if(elem==localPlayer and dim and source)then
		if(getElementInterior(localPlayer)==getElementInterior(source)and getElementDimension(localPlayer)==getElementDimension(source))then
			if(not(isPedInVehicle(localPlayer)))then
				local x,y,z=getElementPosition(localPlayer);
				local x1,y1,z1=getElementPosition(source);
				
				if(getDistanceBetweenPoints3D(x,y,z,x1,y1,z1)<=2)then
					for _,pickupData in pairs(Objects)do
						if(pickupData[2]==source)then
							--destroyElement(source);
							setElementDimension(source,60000);

							triggerServerEvent("Pickups:Give",elem,pickupData[3],pickupData[1]);
							break;
						end
					end
				end
			end
		end
	end
end

addEventHandler("Pickups:Load",root,function(types)
	for _,achievement in pairs(types)do
		for i,v in pairs(Achievements.Pickups[achievement].Coords)do
			if(Achievements.Pickups[achievement].Status)then
				Object=createPickup(v[1],v[2],v[3],3,Achievements.Pickups[achievement].ObjectID,0);
				
				local ID=getPlayerJsonValue(client,"Pickups",tostring(achievement).."-"..tonumber(i));
				if(ID and ID==1)then
					--destroyElement(Object);
					setElementDimension(Object,60000);
				else
					addEventHandler("onClientPickupHit",Object,pickupBonus)
					table.insert(Objects,{i,Object,achievement});
				end
			end
		end
	end
end)
addEventHandler("EventPickups:Load",root,function()
	local CurrentEvent=Server.Settings.Event.Current[1];
	if(CurrentEvent~="none" and SERVER_TIME<=Server.Settings.Event.Current[2])then
		for i,v in pairs(Achievements.Pickups[Server.Settings.Event.Datas[CurrentEvent]].Coords)do
			Object=createPickup(v[1],v[2],v[3],3,Achievements.Pickups[Server.Settings.Event.Datas[CurrentEvent]].ObjectID,0);
			
			local ID=getPlayerJsonValue(client,"EventPickups",tostring(Server.Settings.Event.Datas[CurrentEvent]).."-"..tonumber(i));
			if(ID and ID==1)then
				--destroyElement(Object);
				setElementDimension(Object,60000);
			else
				addEventHandler("onClientPickupHit",Object,pickupBonus)
				table.insert(Objects,{i,Object,Server.Settings.Event.Datas[CurrentEvent]});
			end
		end
	end
end)