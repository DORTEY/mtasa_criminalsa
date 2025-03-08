addRemoteEvents{"Sell:Vehicle"};--addEvents


addEventHandler("onPlayerVehicleEnter",root,function(veh,seat)
	if(veh)then
		local id=getElementModel(veh)or nil;
		if(seat==0)then
			if(veh and isElement(veh))then
				setVehicleEngineState(veh,true);
			end
			if(getElementType(source)=="player")then
				bindKey(source,"H","DOWN",playCustomHorn,"Custom Horn On");
				bindKey(source,"H","UP",playCustomHorn,"Custom Horn Off");
			end
        end
    end
end)

addEventHandler("onPlayerVehicleExit",root,function(veh,seat)
	if(seat==0)then
		if(getElementType(source)=="player")then
			if(veh and isElement(veh))then
				setVehicleEngineState(veh,false);
			end
			if(getElementType(source)=="player")then
				unbindKey(source,"H","DOWN",playCustomHorn);
				unbindKey(source,"H","UP",playCustomHorn);
			end
		end
		triggerClientEvent(root,"Vehicle:Horn:Stop",root,veh);
	end
end)


function playCustomHorn(player,btn,state)
	if(player and isElement(player)and isLoggedin(player))then
		if(isPedInVehicle(player)and getPedOccupiedVehicleSeat(player)==0)then
			if(btn and state)then
				local veh=getPedOccupiedVehicle(player);
				if(veh and isElement(veh)and getElementType(veh)=="vehicle")then
					local HORN=getVehicleJsonValue(veh,"Tunings","Horn")or 0;
					if(HORN and HORN>0 and HORN~=9999999)then
						toggleControl(player,"horn",false);
						if(state=="down")then
							triggerClientEvent(root,"Vehicle:Horn:Start",root,player);
						elseif(state=="up")then
							triggerClientEvent(root,"Vehicle:Horn:Stop",root,veh);
						end
					else
						toggleControl(player,"horn",true);
					end
				end
			end
		end
	end
end

function toggleVehicleLights(player)--toggle vehicle lights
	if(player and isElement(player)and isLoggedin(player))then
		if(isPedInVehicle(player)and getPedOccupiedVehicleSeat(player)==0)then
			local veh=getPedOccupiedVehicle(player);
			if(veh and isElement(veh)and getElementType(veh)=="vehicle")then
				if(getVehicleOverrideLights(veh)~=2)then
					setVehicleOverrideLights(veh,2);
				else
					setVehicleOverrideLights(veh,1);
				end
			end
		end
	end
end






addEventHandler("onVehicleDamage",root,function(loss)
	if(source and isElement(source)and loss)then
		if(getVehicleOccupant(source,0))then
			setElementHealth(source,getElementHealth(source)-loss);
		else
			local VehArmory=getVehicleJsonValue(source,"Tunings","Armory")or 0;
			if(VehArmory and VehArmory>0 and VehArmory~=9999999)then
				if(getElementHealth(source,loss)>Vehicle.Tuning.Armory[tonumber(VehArmory)])then
					setElementHealth(source,Vehicle.Tuning.Armory[tonumber(VehArmory)]);
				else
					setElementHealth(source,getElementHealth(source)+loss);
				end
			else
				if(getElementHealth(source,loss)>1000)then
					setElementHealth(source,1000);
				else
					setElementHealth(source,getElementHealth(source)+loss);
				end
			end
		end
	end
end)

function loadVehicleUpgrades(veh)
	if(veh and isElement(veh))then
		local VehWheels=getVehicleJsonValue(veh,"Tunings","Wheels")or 0;

		for i=0,16 do
			local upgrade=getVehicleUpgradeOnSlot(veh,i);
			if(upgrade)then
				if(VehWheels and VehWheels~=0)then
					if(Vehicle.Tuning.ModdedWheels[tonumber(VehWheels)]and i==12)then else
						removeVehicleUpgrade(veh,upgrade);
					end
				end
			end
		end

		local VehOwner=getElementData(veh,"Vehicle:Data:Owner")or nil;
		local VehID=getElementData(veh,"Vehicle:Data:ID")or nil;

		if(isElement(PLAYER_VEHICLE[VehOwner..VehID])or isElement(PLAYER_VEHICLE_GARAGE[VehOwner..VehID]))then
			local VehNitro=getVehicleJsonValue(veh,"Tunings","Nitro")or 0;
			local VehSpoiler=getVehicleJsonValue(veh,"Tunings","Spoiler")or 0;
			local VehExhaust=getVehicleJsonValue(veh,"Tunings","Exhaust")or 0;
			local VehFrontBumper=getVehicleJsonValue(veh,"Tunings","FrontBumper")or 0;
			local VehRearBumper=getVehicleJsonValue(veh,"Tunings","RearBumper")or 0;
			local VehRoof=getVehicleJsonValue(veh,"Tunings","Roof")or 0;
			local VehLamps=getVehicleJsonValue(veh,"Tunings","Lamps")or 0;
			local VehSideskirt=getVehicleJsonValue(veh,"Tunings","Sideskirt")or 0;
			local VehHydraulics=getVehicleJsonValue(veh,"Tunings","Hydraulics")or 0;
			local VehPaintjob=getVehicleJsonValue(veh,"Tunings","Paintjob")or 9999999;
			local VehLightjob=getVehicleJsonValue(veh,"Tunings","Lightjob")or 9999999;
			local VehWindowTint=getVehicleJsonValue(veh,"Tunings","WindowTint")or 9999999;
			local VehDriveType=getVehicleJsonValue(veh,"Tunings","DriveType");
			local VehChipStage=getVehicleJsonValue(veh,"Tunings","ChipStage")or 0;
			local VehVariant=getVehicleJsonValue(veh,"Tunings","Variant")or 0;
			local VehWingDoors=getVehicleJsonValue(veh,"Tunings","WingDoors")or 0;
			local VehWheelPositionFront=getVehicleJsonValue(veh,"Tunings","WheelPositionFront")or 0;
			local VehWheelPositionRear=getVehicleJsonValue(veh,"Tunings","WheelPositionRear")or 0;
			local VehArmory=getVehicleJsonValue(veh,"Tunings","Armory")or 0;

			if(VehWheels and VehWheels>0)then
				if(Vehicle.Tuning.ModdedWheels[tonumber(VehWheels)])then else
					addVehicleUpgrade(veh,tonumber(VehWheels));
				end
			end
			if(VehNitro and VehNitro>0 and VehNitro~=9999999)then
				addVehicleUpgrade(veh,tonumber(VehNitro));
			end
			if(VehSpoiler and VehSpoiler>0 and VehSpoiler~=9999999)then
				addVehicleUpgrade(veh,tonumber(VehSpoiler));
			end
			if(VehExhaust and VehExhaust>0 and VehExhaust~=9999999)then
				addVehicleUpgrade(veh,tonumber(VehExhaust));
			end
			if(VehFrontBumper and VehFrontBumper>0 and VehFrontBumper~=9999999)then
				addVehicleUpgrade(veh,tonumber(VehFrontBumper));
			end
			if(VehRearBumper and VehRearBumper>0 and VehRearBumper~=9999999)then
				addVehicleUpgrade(veh,tonumber(VehRearBumper));
			end
			if(VehRoof and VehRoof>0 and VehRoof~=9999999)then
				addVehicleUpgrade(veh,tonumber(VehRoof));
			end
			if(VehLamps and VehLamps>0 and VehLamps~=9999999)then
				addVehicleUpgrade(veh,tonumber(VehLamps));
			end
			if(VehSideskirt and VehSideskirt>0 and VehSideskirt~=9999999)then
				addVehicleUpgrade(veh,tonumber(VehSideskirt));
			end
			if(VehHydraulics and VehHydraulics>0 and VehHydraulics~=9999999)then
				addVehicleUpgrade(veh,tonumber(VehHydraulics));
			end

			if(VehWingDoors and VehWingDoors>0 and VehWingDoors~=9999999)then
				setElementData(veh,"Veh:Data:WingDoors",true);
			else
				removeElementData(veh,"Veh:Data:WingDoors");
			end

			if(VehArmory and VehArmory>0 and VehArmory~=9999999)then
				setElementHealth(veh,Vehicle.Tuning.Armory[VehArmory]);
			end

			if(VehWheelPositionFront and VehWheelPositionFront>0 and VehWheelPositionFront~=9999999)then
				triggerClientEvent(root,"Vehicle:Preview:WheelPosition",root,veh,"front",tonumber(VehWheelPositionFront));
			else
				triggerClientEvent(root,"Vehicle:Preview:WheelPosition",root,veh,"front",tonumber(0));
			end
			if(VehWheelPositionRear and VehWheelPositionRear>0 and VehWheelPositionRear~=9999999)then
				triggerClientEvent(root,"Vehicle:Preview:WheelPosition",root,veh,"rear",tonumber(VehWheelPositionRear));
			else
				triggerClientEvent(root,"Vehicle:Preview:WheelPosition",root,veh,"rear",tonumber(0));
			end
			
			if(VehDriveType)then
				setVehicleHandling(veh,"driveType",VehDriveType);
			end

			if(VehChipStage and VehChipStage>0)then
				local thisveh=getVehicleHandling(veh);
				
				if(Vehicle.Tuning.ChipPerformance[VehChipStage])then
					setVehicleHandling(veh,"maxVelocity",(thisveh["maxVelocity"]*(1+Vehicle.Tuning.ChipPerformance[VehChipStage][1])));
					setVehicleHandling(veh,"engineAcceleration",(thisveh["engineAcceleration"]*(1+Vehicle.Tuning.ChipPerformance[VehChipStage][1])));
					setVehicleHandling(veh,"engineInertia",(thisveh["engineInertia"]*(1+Vehicle.Tuning.ChipPerformance[VehChipStage][1])));
					setVehicleHandling(veh,"brakeDeceleration",(thisveh["brakeDeceleration"]*(1+Vehicle.Tuning.ChipPerformance[VehChipStage][1])));
					setVehicleHandling(veh,"tractionMultiplier",(thisveh["tractionMultiplier"]*(1+Vehicle.Tuning.ChipPerformance[VehChipStage][2])));
				end
			end




			if(VehPaintjob==9999999)then
				setVehiclePaintjob(veh,tonumber(3));
			else
				if(tonumber(VehPaintjob)>=4)then
					setVehiclePaintjob(veh,tonumber(3));
					triggerClientEvent(root,"Vehicle:Preview:Paintjob",root,veh,tonumber(VehPaintjob));
				else
					setVehiclePaintjob(veh,tonumber(VehPaintjob));
					triggerClientEvent(root,"Vehicle:Preview:Paintjob",root,veh);
				end
			end
			if(VehLightjob and VehLightjob>0 and VehLightjob~=9999999)then
				triggerClientEvent(root,"Vehicle:Preview:Lightjob",root,veh,tonumber(VehLightjob));
			else
				triggerClientEvent(root,"Vehicle:Preview:Lightjob",root,veh);
			end
			if(VehWindowTint and VehWindowTint>0 and VehWindowTint~=9999999)then
				triggerClientEvent(root,"Vehicle:Preview:WindowTint",root,veh,tonumber(VehWindowTint));
			else
				triggerClientEvent(root,"Vehicle:Preview:WindowTint",root,veh);
			end


			local VehicleColor=getMySQLData2("Vehicles","Username",VehOwner,"ID",tonumber(VehID),"Color")or nil;
			if(veh)then
				setVehicleColor(veh,fromJSON(VehicleColor)[1],fromJSON(VehicleColor)[2],fromJSON(VehicleColor)[3],fromJSON(VehicleColor)[1],fromJSON(VehicleColor)[2],fromJSON(VehicleColor)[3]);
			end
			local VehicleLightColor=getMySQLData2("Vehicles","Username",VehOwner,"ID",tonumber(VehID),"LightColor")or nil;
			if(veh)then
				setVehicleHeadLightColor(veh,fromJSON(VehicleLightColor)[1],fromJSON(VehicleLightColor)[2],fromJSON(VehicleLightColor)[3]);
			end

			if(VehVariant and VehVariant>0)then
				setVehicleVariant(veh,VehVariant,255);
			else
				if(Vehicle.Tuning.DefaultVariants[tonumber(getElementData(veh,"Vehicle:Data:VehID"))])then
					setVehicleVariant(veh,Vehicle.Tuning.DefaultVariants[tonumber(getElementData(veh,"Vehicle:Data:VehID"))],255);
				else
					setVehicleVariant(veh,0,255);
				end
			end

			if(Vehicle.RemoveSirens[tonumber(getElementData(veh,"Vehicle:Data:VehID"))])then
				removeVehicleSirens(veh);
			end
		else
			print("Unknown error #9588115")
		end
	end
end




function giveVehicleCustomHandling(veh,vehid)
	if(veh and isElement(veh)and vehid and vehid>300)then
		if(Vehicle.CustomVehicleHandlings[tonumber(vehid)])then
			for handling,v in pairs(Vehicle.CustomVehicleHandlings[tonumber(vehid)])do
				setVehicleHandling(veh,tostring(handling),v);
			end
		end
	end
end


--[[ addCommandHandler("getVehicleHandling",function(player,cmd,part)
	if(not(isLoggedin(player)))then
		return;
	end
	if(getPlayerJsonValue(player,"Levels","Admin")<4)then
		return;
	end

	local veh=getPedOccupiedVehicle(player);
	if(veh and isElement(veh))then
		local VehID=getElementModel(veh)or getElementData(veh,"Vehicle:Data:VehID");
		
		print(getOriginalHandling(VehID)[tostring(part)]);
	end
end)]]

function scriptOnPlayerEnterVehicle ( invehicle, seat, jacked )
	if(Server.Settings.Whitelist)then
		local upgrades = getVehicleCompatibleUpgrades ( invehicle )
		for upgradeKey, upgradeValue in ipairs ( upgrades ) do
			outputChatBox ( getVehicleUpgradeSlotName ( upgradeValue ) .. ": " .. upgradeValue )
		end
	end
end
addEventHandler("onPlayerVehicleEnter",root,scriptOnPlayerEnterVehicle)


addEventHandler("Sell:Vehicle",root,function(option)
	if(client and isElement(client)and getElementType(client)=="player" and isLoggedin(client))then
		if(option=="Accept")then
			if(not(isPedInVehicle(client)))then
				triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Vehicle:NotInAnyVehicle"),"error",5000);
				triggerClientEvent(client,"Popup:UI",client,false);
				return;
			end
	
			local veh=getPedOccupiedVehicle(client);
			if(veh and isElement(veh)and getElementData(veh,"Vehicle:Data:Owner"))then
				if(getElementData(veh,"Vehicle:Data:Owner")==getPlayerName(client))then
					local VehOwner,VehID=getElementData(veh,"Vehicle:Data:Owner"),getElementData(veh,"Vehicle:Data:ID");
					local VehModel=getElementData(veh,"Vehicle:Data:VehID");
					local Price=Vehicle.Prices[tonumber(VehModel)]/100*Vehicle.SellPercentage;

					if(isElement(PLAYER_VEHICLE_GARAGE[VehOwner..VehID]))then
						destroyElement(PLAYER_VEHICLE_GARAGE[VehOwner..VehID]);
						PLAYER_VEHICLE_GARAGE[VehOwner..VehID]=nil;
					end
					if(isElement(PLAYER_VEHICLE[VehOwner..VehID]))then
						destroyElement(PLAYER_VEHICLE[VehOwner..VehID]);
						PLAYER_VEHICLE[VehOwner..VehID]=nil;
					end

					sendDiscordMessage({
						ID=6, Title="Vehicle sell", Desc=getPlayerName(client).." has sold a '"..returnVehicleName(VehModel).."' for "..Price..".",
						PlayerData={Name=getPlayerName(client),Serial=getPlayerSerial(client),},
					})

					addPlayerJsonValue(client,"Money","Cash",tonumber(Price));

					dbExec(Database.Connection,"DELETE FROM ?? WHERE ??=? AND ??=?","Vehicles","Username",VehOwner,"ID",VehID);

					triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Vehicle:Sold"):format(returnVehicleName(VehModel)),"success",5000);
				end
			end

			triggerClientEvent(client,"Popup:UI",client,false);
		else
			triggerClientEvent(client,"Popup:UI",client,false);
		end
	end
end)





function GetNearestVehicle(player,distancee)--nearst vehicles
	if(not(distancee))then
		distancee=7;
	end

    local x,y,z=getElementPosition(player);
    local prevDistance;
    local nearestVehicle;
    for _,v in ipairs(getElementsByType("vehicle"))do
        local distance=getDistanceBetweenPoints3D(x,y,z,getElementPosition(v));
        if(distance<=(prevDistance or distance+1))then
            prevDistance=distance;
			if(prevDistance<tonumber(distancee))then
				nearestVehicle=v;
			else
				nearestVehicle=false;
			end
        end
    end
    return nearestVehicle or false;
end








function giveVehicleToPlayer(player,vehicleID)
	if(player and vehicleID and tonumber(vehicleID)>0)then
		local result=dbPoll(dbQuery(Database.Connection,"SELECT * FROM ?? WHERE ??=?","Vehicles","Username",getPlayerName(player)),-1);
		if(#result>=#Hideout.Garage.GaragePositions[tonumber(getPlayerJsonValue(player,"HideUpgrades","Garage"))])then
			triggerClientEvent(player,"Notify:UI",player,loc(player,"S:Vehicle:SlotsReached"),"error",4000);
			return;
		end

		local IDcounter=dbPoll(dbQuery(Database.Connection,"SELECT ?? FROM ?? WHERE Vehicles=Vehicles","Vehicles","Counter"),-1)[1]["Vehicles"];
		dbExec(Database.Connection,"UPDATE ?? SET ??=?","Counter","Vehicles",IDcounter+1);

		ResultPlate=generateVehiclePlate();

		local isCustom,mod,elementType=exports[RESOURCE_NEWMODELS]:isCustomModID(tonumber(vehicleID));
		if(isCustom)then
			DriveType=getOriginalHandling(tonumber(mod.base_id))["driveType"];
		else
			DriveType=getOriginalHandling(tonumber(vehicleID))["driveType"];
		end

		dbExec(Database.Connection,"INSERT INTO ?? (ID,Username,VehID,Plate,Color,LightColor,Tunings) VALUES (?,?,?,?,?,?,?)","Vehicles",IDcounter,getPlayerName(player),tonumber(vehicleID),ResultPlate,toJSON({255,255,255,255,255,255}),toJSON({255,255,255,255,255,255}),'[ { "Paintjob": 9999999, "DriveType": "'..DriveType..'" } ]');
		
		triggerClientEvent(player,"Load:Garage:Vehicles:C",player);
	end
end