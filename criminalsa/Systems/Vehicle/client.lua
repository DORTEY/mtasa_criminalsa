addRemoteEvents{"Vehicle:Horn:Start","Vehicle:Horn:Stop","Vehicle:Preview:WheelPosition"};--addEvent


addEventHandler("Vehicle:Horn:Start",root,function(player)
	if(player and isElement(player)and not isPedDead(player))then
		if(isPedInVehicle(player))then
			local veh=getPedOccupiedVehicle(player,0);
			if(veh and isElement(veh))then
				local VehicleHorn=getVehicleJsonValue(veh,"Tunings","Horn")or 0;
				if(VehicleHorn and VehicleHorn>0 and VehicleHorn~=9999999)then
					if(not(isElement(VEHICLE_HORNS[veh])))then
						local x,y,z=getElementPosition(veh);
						VEHICLE_HORNS[veh]=playSound3D(":"..RESOURCE_NAME.."/Files/Audio/Horns/"..tostring(VehicleHorn)..".mp3",x,y,z,true);
						setSoundMinDistance(VEHICLE_HORNS[veh],0);
						setSoundMaxDistance(VEHICLE_HORNS[veh],35);
						attachElements(VEHICLE_HORNS[veh],veh);

						setElementDimension(VEHICLE_HORNS[veh],getElementDimension(veh));
					end
				end
			end
		end
	end
end)
addEventHandler("Vehicle:Horn:Stop",root,function(veh)
	if(veh)then
		if(isElement(VEHICLE_HORNS[veh]))then
			destroyElement(VEHICLE_HORNS[veh]);
			VEHICLE_HORNS[veh]=nil;
		end
	end
end)

addEventHandler("onClientPlayerWasted",root,function()
	if(source==localPlayer)then
		if(isPedInVehicle(localPlayer))then
			local veh=getPedOccupiedVehicle(localPlayer,0);
			if(veh and isElement(veh))then
				if(isElement(VEHICLE_HORNS[veh]))then
					destroyElement(VEHICLE_HORNS[veh]);
					VEHICLE_HORNS[veh]=nil;
				end
			end
		end
	end
end)








addEventHandler("onClientVehicleStartEnter",root,function(player,seat)
	if(player==localPlayer)then
        if(seat==0)then
            if(getElementData(source,"Vehicle:Data:Type"))then
                if(getElementData(source,"Vehicle:Data:Owner")~=getPlayerName(localPlayer))then
                    triggerEvent("Notify:UI",localPlayer,loc(localPlayer,"S:Vehicle:NotYours"),"error",3000);
                    cancelEvent();
                end
            end
        end
	end
end)






--[[ function getMyVehicleVariants()
	if(Server.Settings.Whitelist)then
		local myVeh = getPedOccupiedVehicle(localPlayer)

		if myVeh then
			local variant1, variant2 = getVehicleVariant (myVeh)

			outputChatBox ("This vehicle's variants are: "..tostring (variant1).." "..tostring (variant2))
		end
    end
end
addCommandHandler ("getvehvar", getMyVehicleVariants) ]]







addEventHandler("onClientRender",root,function()
	if(not(isLoggedin()))then
		return;
	end
	if(isPedDead(localPlayer))then
		return;
	end
	if(isClickedState(localPlayer))then
		return;
	end
    if(isPlayerMapVisible(localPlayer))then
        return;
    end

	local x,y,z=getElementPosition(localPlayer);
	for _,v in ipairs(getElementsByType("vehicle"))do
		if(v and isElement(v))then
            if(getElementData(v,"Vehicle:Data:Type")=="Preview")then
                if(getElementDimension(v)==getElementDimension(localPlayer))then
                    if(v~=getPedOccupiedVehicle(localPlayer))then
                        local vx,vy,vz=getElementPosition(v);
                        if(getDistanceBetweenPoints3D(x,y,z,vx,vy,vz)<=10 and isLineOfSightClear(x,y,z,vx,vy,vz,true,false,true,true,true))then
                            local x,y=getScreenFromWorldPosition(vx,vy,vz+1.3);
                            if(x and y)then
                                local Name=returnVehicleName(getElementData(v,"Vehicle:Data:VehID"));
                                dxDrawRoundedRectangle(x-250/2,y,250,100,10,tocolor(0,0,0,150),false);

                                dxDrawText(Name,x-120/2,y,120+x-120/2,40+y,tocolor(255,255,255,255),1.35,"default-bold","center","center",false,false,true,true);
                                dxDrawText(getVehiclePlateText(v),x-120/2,y,120+x-120/2,110+y,tocolor(255,255,255,255),1.35,"default-bold","center","center",false,false,true,true);
                            end
                        end
                    end
                end
            end
		end
	end
end)


--Custom wheel position
local WheelPositionDistance=0.03;
function updateWheelPos(veh,typ,id)
	if(veh and isElement(veh))then
		if(typ and id and type(id)=="number")then--preview
			if(typ=="front")then
				resetVehicleComponentPosition(veh,"wheel_lf_dummy");
				resetVehicleComponentPosition(veh,"wheel_rf_dummy");

				if(id and tonumber(id)~=nil and tonumber(id)>0 and tonumber(id)~=9999999)then
					local lx,ly,lz=getVehicleComponentPosition(veh,"wheel_lf_dummy");
					if (lx < 0) then lx = lx - (WheelPositionDistance*id) else lx = lx + (WheelPositionDistance*id) end
					setVehicleComponentPosition(veh,"wheel_lf_dummy", lx, ly, lz);
					
					local rx,ry,rz=getVehicleComponentPosition(veh,"wheel_rf_dummy");
					if (rx < 0) then rx = rx - (WheelPositionDistance*id) else rx = rx + (WheelPositionDistance*id) end
					setVehicleComponentPosition(veh,"wheel_rf_dummy", rx, ry, rz);
				end
			end
			if(typ=="rear")then
				resetVehicleComponentPosition(veh,"wheel_lb_dummy");
				resetVehicleComponentPosition(veh,"wheel_rb_dummy");

				if(id and tonumber(id)~=nil and tonumber(id)>0 and tonumber(id)~=9999999)then
					local lx,ly,lz=getVehicleComponentPosition(veh,"wheel_lb_dummy");
					if (lx < 0) then lx = lx - (WheelPositionDistance*id) else lx = lx + (WheelPositionDistance*id) end
					setVehicleComponentPosition(veh,"wheel_lb_dummy", lx, ly, lz);
					
					local rx,ry,rz=getVehicleComponentPosition(veh,"wheel_rb_dummy");
					if (rx < 0) then rx = rx - (WheelPositionDistance*id) else rx = rx + (WheelPositionDistance*id) end
					setVehicleComponentPosition(veh,"wheel_rb_dummy", rx, ry, rz);
				end
			end
		elseif(not typ and not id)then
			local front=getVehicleJsonValue(veh,"Tunings","WheelPositionFront")or 0;
			local rear=getVehicleJsonValue(veh,"Tunings","WheelPositionRear")or 0;
			
			resetVehicleComponentPosition(veh,"wheel_lf_dummy");
			resetVehicleComponentPosition(veh,"wheel_rf_dummy");
			resetVehicleComponentPosition(veh,"wheel_lb_dummy");
			resetVehicleComponentPosition(veh,"wheel_rb_dummy");
			
			if(front and tonumber(front)~=nil and tonumber(front)>0 and tonumber(front)~=9999999)then
				local lx,ly,lz=getVehicleComponentPosition(veh,"wheel_lf_dummy");
				if (lx < 0) then lx = lx - (WheelPositionDistance*front) else lx = lx + (WheelPositionDistance*front) end
				setVehicleComponentPosition(veh,"wheel_lf_dummy", lx, ly, lz);
				
				local rx,ry,rz=getVehicleComponentPosition(veh,"wheel_rf_dummy");
				if (rx < 0) then rx = rx - (WheelPositionDistance*front) else rx = rx + (WheelPositionDistance*front) end
				setVehicleComponentPosition(veh,"wheel_rf_dummy", rx, ry, rz);
			end
			if(rear and tonumber(rear)~=nil and tonumber(rear)>0 and tonumber(rear)~=9999999)then
				local lx,ly,lz=getVehicleComponentPosition(veh,"wheel_lb_dummy");
				if (lx < 0) then lx = lx - (WheelPositionDistance*rear) else lx = lx + (WheelPositionDistance*rear) end
				setVehicleComponentPosition(veh,"wheel_lb_dummy", lx, ly, lz);
				
				local rx,ry,rz=getVehicleComponentPosition(veh,"wheel_rb_dummy");
				if (rx < 0) then rx = rx - (WheelPositionDistance*rear) else rx = rx + (WheelPositionDistance*rear) end
				setVehicleComponentPosition(veh,"wheel_rb_dummy", rx, ry, rz);
			end
		end
	end
end
addEventHandler("Vehicle:Preview:WheelPosition",root,updateWheelPos)

addEventHandler("onClientElementStreamIn",root,function()
	if(getElementType(source)=="vehicle" and getElementData(source,"Vehicle:Data:Type"))then
		updateWheelPos(source,nil,nil);
	end
end)

--Wing doors
local oldDoorRatios = {}
local doorStatus = {}
local doorTimers = {}
local vehiclesWithScissorDoor = {}
local doorAnimTime = 250

addEventHandler("onClientResourceStart", resourceRoot, function()
	for _, vehicle in pairs(getElementsByType("vehicle")) do
		if isElementStreamedIn(vehicle) then
			if getElementData(vehicle, "flugelDoors") then
				vehiclesWithScissorDoor[vehicle] = true
			end
		end
	end
end)

addEventHandler("onClientElementDestroy", root, function()
	removeVehicleFromWingdoorsTable(source)
end)
addEventHandler("onClientElementStreamOut", root, function()
	removeVehicleFromWingdoorsTable(source)
end)
addEventHandler("onClientVehicleExplode", root, function()
	removeVehicleFromWingdoorsTable(source)
end)

addEventHandler("onClientElementStreamIn", root, function()
	if source and isElement(source) and getElementType(source) == "vehicle" then
		if(getElementData(source,"Veh:Data:WingDoors"))then
			vehiclesWithScissorDoor[source] = true
		end
	end
end)

addEventHandler("onClientElementDataChange", root, function(data)
	if source and isElement(source) and getElementType(source) == "vehicle" then
		if data == "Veh:Data:WingDoors" then
			if isElementStreamedIn(source) then
				vehiclesWithScissorDoor[source] = getElementData(source,"Veh:Data:WingDoors");
				
				if not vehiclesWithScissorDoor[source] then
					removeVehicleFromWingdoorsTable(source)
				end
			end
		end
	end
end)

addEventHandler("onClientPreRender", root, function()
	for vehicle in pairs(vehiclesWithScissorDoor) do
		if isElement(vehicle) then
			if not doorTimers[vehicle] then
				doorTimers[vehicle] = {}
			end
			
			local doorRatios = {}
			
			for i = 1, 4 do
				local i = i + 1
				local doorRatio = getVehicleDoorOpenRatio(vehicle, i)
 
				if doorRatio and oldDoorRatios[vehicle] and oldDoorRatios[vehicle][i] then
					local oldDoorRatio = oldDoorRatios[vehicle][i]
 
					if not doorStatus[vehicle] then
						doorStatus[vehicle] = {}
					end
					
					local doorPreviousState = doorStatus[vehicle][i]
					
					if not doorPreviousState then
						doorPreviousState = "closed"
					end
					
					if doorPreviousState == "closed" and doorRatio > oldDoorRatio then
						doorStatus[vehicle][i] = "opening"
						doorTimers[vehicle][i] = setTimer(function(vehicle,i)
							doorStatus[vehicle][i] = "open"
							doorTimers[vehicle][i] = nil
						end, doorAnimTime, 1, vehicle, i)
					elseif doorPreviousState == "open" and doorRatio < oldDoorRatio then
						doorStatus[vehicle][i] = "closing"
						doorTimers[vehicle][i] = setTimer(function(vehicle, i)
							doorStatus[vehicle][i] = "closed"
							doorTimers[vehicle][i] = nil
						end, doorAnimTime, 1, vehicle, i)
					end
				elseif not oldDoorRatios[vehicle] then
					oldDoorRatios[vehicle] = {}
				end
				
				if doorRatio then
					oldDoorRatios[vehicle][i] = doorRatio
				end
			end
		else
			vehiclesWithScissorDoor[vehicle] = nil
			oldDoorRatios[vehicle] = nil
			doorStatus[vehicle] = nil
			doorTimers[vehicle] = nil
		end
	end
	
	for vehicle, doors in pairs(doorStatus) do
		if vehiclesWithScissorDoor[vehicle] then
			local doorX, doorY, doorZ = -72, -25, 0
			
			for door, status in pairs(doors) do
				local ratio = 0
				
				if status == "open" then
					ratio = 1
				end
				
				local doorTimer = doorTimers[vehicle][door]
				
				if doorTimer and isTimer(doorTimer) then
					local timeLeft = getTimerDetails(doorTimer)
					
					ratio = timeLeft / doorAnimTime
					
					if status == "opening" then
						ratio = 1 - ratio
					end
				end
				
				local dummyName = (door == 2 and "door_lf_dummy") or (door == 3 and "door_rf_dummy")
				
				if dummyName then
					local doorX, doorY, doorZ = doorX * ratio, doorY * ratio, doorZ * ratio
					
					if string.find(dummyName, "rf") then
						doorY, doorZ = doorY * -1, doorZ * -1
					end
					
					setVehicleComponentRotation(vehicle, dummyName, doorX, doorY, doorZ)
				end
			end
		end
	end
end)
addEventHandler("onClientVehicleDamage", root, function()
	local leftDoor = getVehicleDoorState(source, 2)
	local rightDoor = getVehicleDoorState(source, 3)
	
	if leftDoor == 1 then
		setVehicleDoorOpenRatio(source, 2, 0, 500)
	end
	
	if rightDoor == 1 then
		setVehicleDoorOpenRatio(source, 3, 0, 500)
	end
end)
function removeVehicleFromWingdoorsTable(vehicle)
	if vehicle and isElement(vehicle) and getElementType(vehicle) == "vehicle" then
		oldDoorRatios[vehicle] = nil
		doorStatus[vehicle] = nil
		doorTimers[vehicle] = nil
		vehiclesWithScissorDoor[vehicle] = nil
	end
end









function isTuningpartAvailable(model,id)
	local state=false;
	local TABLE=Vehicle.Tuning["TuningAvailable"][model]or nil;
	if(TABLE)then
		for _,v in pairs(TABLE)do
			if(v==id)then
				state=true;
				break;
			end
		end
	end
	return state;
end