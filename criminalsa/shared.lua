RESOURCE_NAME=getResourceName(getThisResource());--get this resourcename
RESOURCE_NEWMODELS="newmodels";

Server={
	Name="Criminal SA",
	Version="0.9.1",
	Color={HEX="#00f0ff",RGB={0,240,255}},
	
	Youtube="https://www.youtube.com/@DORTEY",
	Discord={
		Invite="https://discord.gg/AqCrraUKf2",
	
		Bot={
			ID="1248757649827168430",
	
			Description="Hideout, Robberys and more...",
			Text="Players Online",
	
			MaxPlayers=SERVER_SLOTS,
	
			Logo={
				Text="Criminal SA - Hideout, Robberys and more...",
				Image="https://i.imgur.com/sBjaUzd.png",
			},
			LogoSmall={
				Text="Join today and enter a new world in GTA:SA",
				Image="https://i.imgur.com/sBjaUzd.png",
			},
			Buttons={
				[1]={
					Status=true,
					Text="Discord",
					URL="https://discord.gg/AqCrraUKf2",
				},
				[2]={
					Status=false,
					Text="Join us now!",
					URL="mtasa://89.163.152.134:22003",
				},
			}
		}
	},

	Settings={
		Whitelist=false,
		ServerLogs=true,
		
		ChatSpamTimer=5,--Minutes
		BOTs=true,--damage?
		NametagRange=20,--player nametage/chat range

		Event={
			Current={"Christmas",1737370800},--[Easter,Halloween,Christmas, none] [timestamp end]
			Datas={
				["Christmas"]="Christmas",
				["Halloween"]="Pumpkin",
				["Easter"]="Easter",
			},
			Weathers={
				["none"]=0,
				["Christmas"]=0,
				["Halloween"]=21,
				["Easter"]=0,
			},
		}
	},

	ResetElementDatas={
		"Player:Data:MarkerRobAllowed","Player:Data:isRobbing","Player:Data:RobbedAmount","Player:Data:isTeleporting",
		"Player:Data:isMining","Player:Data:isAFK",
	},

	DefaultRegisterDataCheck={--[check data]
		["Levels"]="Admin";
		["Stats"]="Playtime";
		["Money"]="Cash";
		["Booster"]="MoneyBoosterPercentage";
		["WeaponSkins"]="24";
		["Points"]="Bonus";

		["HideUpgrades"]="Generator";
		["HideItems"]="Bitcoin";
		["HideTimers"]="Bitcoin";
	},
	DefaultRegisterDataValues={--[check data], data set
		["Levels"]={
			["Admin"]=0,["Premium"]=0,
		},
		["Stats"]={
			["Playtime"]=0,
			["Hospitaltime"]=0,
			["Mutetime"]=0,
			["Kills"]=0,
			["Deaths"]=0,
			["BossKills"]=0,
			["BotKills"]=0,
			["Bounty"]=0,
			["Tutorial"]=0,
		},
		["Money"]={
			["Cash"]=300000,["Black"]=0,["CrimeCoin"]=0,
		},
		["Booster"]={
			["MoneyBoosterPercentage"]=0,
			["MoneyBoosterTime"]=0,
			["MoneyBoosterTier"]=0,
			["ItemBoosterPercentage"]=0,
			["ItemBoosterTime"]=0,
			["ItemBoosterTier"]=0,
		},
		["WeaponSkins"]={
			["22"]=0,["23"]=0,["24"]=0,["25"]=0,["27"]=0,["28"]=0,["29"]=0,["30"]=0,["31"]=0,["33"]=0,["34"]=0,["35"]=0,
		},
		["Points"]={
			["Bonus"]=0,["Horseshoe"]=0,["Shell"]=0,["Easter"]=0,["Pumpkin"]=0,["Christmas"]=0,
		},

		["HideUpgrades"]={
			["Garage"]=0,
			["Workbench"]=1,
			["Generator"]=1,
			["Bitcoin"]=0,
			["Armory"]=1,
			["Moneywash"]=1,
			["Dufflebag"]=0,
			["Hideout"]=0,
			["Wardrobe"]=1,
			["Hideout"]=0,
		},
		["HideItems"]={
			["Bitcoin"]=0,["Cash"]=1,["Black"]=1,
		},
		["HideTimers"]={
			["Bitcoin"]=0,
		},
	},

	
	MainInteractionKey="E",
}



NotAllowedNames={
	"none","nil","null","sieg","nazi","admin",
};
NotAllowedCharacters={
	" ツ","!","_","§","$","%","&","/","@","(",")",".","'","=","?","´","`","#","*","#","°","^","<",">","{","}",";",":","|","[","]",
};

Promo={
	Money=30000,
}



function isClickedState(player)
	if(not player)then
		player=localPlayer;
	end
	if(isElement(player))then
		return getElementData(player,"ClickedState");
	end
end
function setClickedState(player,state)
	if(not player)then
		player=localPlayer;
	end
	if(isElement(player))then
		setElementData(player,"ClickedState",state);
	end
end
function isLoggedin(player)
	if(not player)then
		player=localPlayer;
	end
	if(isElement(player)and getElementType(player)=="player")then
		return getElementData(player,"Loggedin")==1;
	end
end


function getPlayerJsonValue(player,json,item)
	if(not player)then
		player=localPlayer;
	end
	if(player and isElement(player)and getElementType(player)=="player" and isLoggedin(player))then
		local jsonElement=fromJSON(getElementData(player,tostring(json)))or {};
		if(jsonElement and jsonElement[tostring(item)])then
			return jsonElement[tostring(item)];
		else
			return 0;
		end
	else
		return 0;
	end
end
function getPlayerJsonTable(player,json)
	if(not player)then
		player=localPlayer;
	end
	if(player and isElement(player)and getElementType(player)=="player")then
		local jsonElement=fromJSON(getElementData(player,tostring(json)))or {};
		if(jsonElement)then
			return jsonElement;
		else
			return 0;
		end
	else
		return 0;
	end
end

function getPlayerNotExistingJsonValue(player,json,item)
	if(not player)then
		player=localPlayer;
	end
	if(player and isElement(player)and getElementType(player)=="player" and isLoggedin(player))then
		local jsonElement=fromJSON(getElementData(player,tostring(json)))or {};
		if(jsonElement and jsonElement[tostring(item)])then
			return jsonElement[tostring(item)];
		else
			return nil;
		end
	else
		return nil;
	end
end

function getVehicleJsonValue(vehicle,json,item)
	if(vehicle and isElement(vehicle)and getElementType(vehicle)=="vehicle")then
		local jsonElement=fromJSON(getElementData(vehicle,tostring(json)))or {};
		if(jsonElement and jsonElement[tostring(item)])then
			return jsonElement[tostring(item)];
		else
			return 0;
		end
	else
		return 0;
	end
end






function addRemoteEvents(eventList)
	for _,v in ipairs(eventList)do
		addEvent(v,true);
	end
end

function table.find(tab,value)
	for k,v in pairs(tab)do
		if(v==value)then
			return k;
		end
	end
	return nil;
end

function table.removevalue(tab,value)
	local idx=table.find(tab,value);
	if(idx)then
		table.remove(tab,idx);
		return true;
	end
end

function math.percent(type,percent,maxvalue)
	if(type==1)then
		if tonumber(percent)and tonumber(maxvalue) then
			return(percent/maxvalue)*100;
		end
		return false;
	end
	if(type==2)then
		if tonumber(percent)and tonumber(maxvalue) then
			return(maxvalue*percent)/100;
		end
		return false;
	end
end

function stringTextWithAllParameters(...)
	local tbl={...};
	return table.concat(tbl," ");
end


function findRotation(x1,y1,x2,y2)
	local t=-math.deg(math.atan2(x2-x1,y2-y1));
	if(t<0)then
		t=t+360;
	end
	return t;
end

function destroyAndCheckElement(element)
    if(element and isElement(element))then
        destroyElement(element);
		element=nil;
        return true;
    else
        return false;
    end
end

function isPlayerStationary(player)
    local vx,vy,vz=getElementVelocity(player);
    return vx<=0 and vy<=0 and vz<=0;
end

function getPositionInFrontOfElement(theElement, distance)
    assert((type(theElement) == "element" or type(theElement == "userdata")), "Bad argument @ 'getPositionInFrontOfElement' [Expected element at argument 1, got "..(type(theElement)).."]")

    local x, y, z = getElementPosition(theElement)
    local rz = ({getElementRotation(theElement)})[3]

    local rotationRad = math.rad(rz)

    local objX = x - distance * math.sin(rotationRad)
    local objY = y + distance * math.cos(rotationRad)
    local objZ = z

    return objX, objY, objZ
end

function getEntityMatrix(element)
    local rotX,rotY,rotZ = getElementRotation(element) -- ZXY
    local rx, ry, rz = rotX,rotY,rotZ
    rx, ry, rz = math.rad(rx), math.rad(ry), math.rad(rz)
    local matrix = {}
    matrix[1] = {}
    matrix[1][1] = math.cos(rz)*math.cos(ry) - math.sin(rz)*math.sin(rx)*math.sin(ry)
    matrix[1][2] = math.cos(ry)*math.sin(rz) + math.cos(rz)*math.sin(rx)*math.sin(ry)
    matrix[1][3] = -math.cos(rx)*math.sin(ry)
    matrix[1][4] = 1
    
    matrix[2] = {}
    matrix[2][1] = -math.cos(rx)*math.sin(rz)
    matrix[2][2] = math.cos(rz)*math.cos(rx)
    matrix[2][3] = math.sin(rx)
    matrix[2][4] = 1
    
    matrix[3] = {}
    matrix[3][1] = math.cos(rz)*math.sin(ry) + math.cos(ry)*math.sin(rz)*math.sin(rx)
    matrix[3][2] = math.sin(rz)*math.sin(ry) - math.cos(rz)*math.cos(ry)*math.sin(rx)
    matrix[3][3] = math.cos(rx)*math.cos(ry)
    matrix[3][4] = 1
    
    matrix[4] = {}
    local posX,posY,posZ = getElementPosition(element)
    matrix[4][1], matrix[4][2], matrix[4][3] = posX,posY,posZ - 1.0
    matrix[4][4] = 1
    
    return matrix
end

function GetOffsetFromEntityInWorldCoords(entity, offX, offY, offZ)
    local m = getEntityMatrix(entity)
    local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1]
    local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2]
    local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3]
    return Vector3(x, y, z)
end

function getNearestElement(player, type, distance)
    local result = false
    local dist = nil
    if player and isElement(player) then
        local elements = getElementsWithinRange(Vector3(getElementPosition(player)), distance, type, getElementInterior(player), getElementDimension(player))
        for i = 1, #elements do
            local element = elements[i]
            if not dist then
                result = element
                dist = getDistanceBetweenPoints3D(Vector3(getElementPosition(player)), Vector3(getElementPosition(element)))
            else
                local newDist = getDistanceBetweenPoints3D(Vector3(getElementPosition(player)), Vector3(getElementPosition(element)))
                if newDist <= dist then
                    result = element
                    dist = newDist
                end
            end
        end
    end
    return result
end



function comma_value(amount)
	local formatted=amount;
	while true do  
	  	formatted,k=string.gsub(formatted,"^(-?%d+)(%d%d%d)",'%1,%2');
	  	if (k==0) then
			break;
	  	end
	end
	return formatted;
end




function getPedWeapons(ped)
	local playerWeapons={};

	if(ped and isElement(ped)and getElementType(ped)=="ped" or getElementType(ped)=="player")then
		for i=2,9 do
			local wep=getPedWeapon(ped,i);
			if(wep and wep~=0)then
				table.insert(playerWeapons,wep);
			end
		end
	else
		return false;
	end

	return playerWeapons;
end




function formatMilliseconds(ms)
    local total_seconds=math.floor(ms/1000);
    local hours=math.floor(total_seconds/3600);
    local minutes=math.floor((total_seconds%3600)/60);
    local seconds=total_seconds%60;

	if(hours<1)then
		hours="";
	elseif(hours<10)then
		hours="0"..hours..":";
	else
		hours=hours..":";
	end
	if(minutes<1)then
		minutes="";
	elseif(minutes<10)then
		minutes="0"..minutes..":";
	else
		minutes=minutes..":";
	end
	if(seconds<10)then
		seconds="0"..seconds;
	end
    return hours..minutes..seconds;
end








function sizeFormat(size)
	local size = tostring(size)
	if size:len() >= 4 then		
		if size:len() >= 7 then
			if size:len() >= 9 then
				local returning = size:sub(1, size:len()-9)
				if returning:len() <= 1 then
					returning = returning.."."..size:sub(2, size:len()-7)
				end
				return returning.." GB";
			else				
				local returning = size:sub(1, size:len()-6)
				if returning:len() <= 1 then
					returning = returning.."."..size:sub(2, size:len()-4)
				end
				return returning.." MB";
			end
		else		
			local returning = size:sub(1, size:len()-3)
			if returning:len() <= 1 then
				returning = returning.."."..size:sub(2, size:len()-1)
			end
			return returning.." KB";
		end
	else
		return size.." B";
	end
end