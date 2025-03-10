--[[
	/////// //////////////////
	/////// PROJECT: MTA iLife - German Fun Reallife Gamemode
	/////// VERSION: 1.7.2 
	/////// DEVELOPERS: See DEVELOPERS.md in the top folder
	/////// LICENSE: See LICENSE.md in the top folder 
	/////// /////////////////
]]

--
-- Created by IntelliJ IDEA.
-- User: Noneatme, Jusonex, MasterM
-- Date: 29.01.2015
-- Time: 18:21
-- To change this template use File | Settings | File Templates.
--

local train     = {}

ServerTrains = {}
ServerTrains.Settings =
{
    Debug = false,
    Interval = 1000,
    SyncSpeedDiff = 0.7, -- Geschwindigkeit des Zuges verringern, da sich das Sync-Element porten muss (und das ca. 1ms länger braucht)
    StationTime = 30000, -- Zeit in ms, die ein Zug an einer Station hält
    RenderDistance = 200, -- 200m reichen vollkommen aus
    TrackFiles = {"Files/Traintracks.dat"}
}

function ServerTrains:new(...) local o = setmetatable({}, {__index = ServerTrains}) o:constructor(...) return o end
function ServerTrains:constructor()
    self.m_Tracks = {}

	self.trainStations = { -- Passagier- und Frachtstationen müssen IMMER im Verhältnis 1:1 erstellt werden
		--{x,y,z,bDirection, bPassenger},
		{1693.32349, -1955.97876, 13.54688, true, true}, -- Unity Station
		{783.04657, -1340.71008, -1.56082, true, true}, -- Market Station
		{-1944.00208, 185.31293, 25.71094, true, true}, -- Cranberry Station
		{1475.89893, 2634.43311, 10.82031, true, true}, -- Yellow Bell Station
		{2866.40552, 1243.73059, 10.82031, true, true}, -- Linden Station
		{783.04657, -1340.71008, -1.56082, true, false}, -- Market Station
		{-1944.00208, 185.31293, 25.71094, true, false}, -- Cranberry Station Freight
		{625.56427, 1301.28748, 11.78906, true, false}, -- Octane Springs
		{2783.15405, 1722.55298, 10.82031, true, false}, -- Sobell Rail Yards
		{2352.03784, -288.90140, 23.81623, true, false}, -- North Rock Zwangspause

	}

    -- Sehr Langsam(Haltestellen)
    self.m_verySlowPositions    =
    {
        ["cranberry station"]   = true,
        ["unity station"]       = true,
        ["linden station"]      = true,
        ["sobell rail yards"]   = true,
        ["yellow bell station"] = true,
        ["market station"]      = true,
    }

    -- Langsam
    self.m_slowPositions    =
    {
        ["el corona"]       = true,
        ["jefferson"]       = true,
        ["east los santos"] = true,
        ["las colinas"]     = true,
        ["idlewood"]        = true,
        ["willowfield"]     = true,

        -- New --
        ["doherty"]         = true,
        ["prickle pine"]    = true,
        ["linden side"]     = true,
		["creek"]		    = true,

        ["marina"]          = true,
        ["vinewood"]        = true,
        ["north rock"]      = true,
		["octane springs"] 	= true,

    }
    -- Normal
		-- Alles Andere

    -- Very Fast
    self.m_veryFastPositions    =
    {
        ["whetstone"]               = true,
		["flint county"]               = true,
        ["easter basin"]            = true,
        ["san fierro"]              = true,
        ["las venturas"]            = true,
        ["kincaid bridge"]          = true,
        ["tierra robada"]           = true,
        ["lil' probe inn"]          = true,
        ["frederick bridge"]        = true,

    }
    -- Load tracks
    for k, v in ipairs(self.Settings.TrackFiles) do
        local file = fileOpen(v, true)
        local content = fileRead(file, fileGetSize(file))
        local lines = split(content, "\r\n")

        self.m_Tracks[k] = {}
        for i, j in ipairs(lines) do
            if i ~= 1 then -- Ignore first line (contains number of track nodes)
            local x, y, z = unpack(split(j, " "))
            table.insert(self.m_Tracks[k], {index = i-1, x = x, y = y, z = z})
            end
        end
        
        fileClose(file);
    end

    -- Calculate distances
    for trackId, trackData in ipairs(self.m_Tracks) do
        local lastDistance = 0
        for k, node in ipairs(trackData) do
            local previousPosition = trackData[k-1] or {x = 0, y = 0, z = 0}
            lastDistance = lastDistance + getDistanceBetweenPoints3D(node.x, node.y, node.z, previousPosition.x, previousPosition.y, previousPosition.z)
            node.distance = lastDistance
        end
    end

    -- Initialize train list
    self.m_Trains = {}


    -- Start position updating timer
    setTimer(function() self:updateTrains() end, self.Settings.Interval, 0)


	-- load train stations
	self.tblStations = {}
	for i,v in pairs(self.trainStations) do
		local marker = createColSphere(v[1], v[2], v[3], 6)
		self.tblStations[i] = marker
		addEventHandler("onColShapeHit", marker, function(hit, dim)
			if self.m_Trains[hit] then
				if self.m_Trains[hit].bDirection == v[4] then
					if self.m_Trains[hit].bPassengerTrain == v[5] then
						if self.Settings.Debug then
							outputChatBox("train is in station "..getZoneName(v[1], v[2], v[3]))
						end
						self.m_Trains[hit].bInStation = getTickCount()
					end
				end
			end
		end)
	end
end

local Count=0;
function ServerTrains:addTrain(x, y, z, tblTrain, speed, bDirection, bPassengerTrain)
	local train2 = createVehicle(411,x, y, z)
	Count=Count+1;




	Blip=createBlip(2415,-1426,25.2,4,22,60,60,60,255,100);
	attachElements(Blip,train2)
	setElementData(Blip,"Blip:Data:Tooltip","Train #"..Count);

		setElementFrozen(train2, true)
		if not self.Settings.Debug then
			setElementAlpha(train2,0)
		end
		setVehicleDamageProof(train2, true)
    self.m_Trains[train2] = {speed = speed, node = false, track = false, trackDistance = 0}
	self.m_Trains[train2].tblTrain = tblTrain
	self.m_Trains[train2].bDirection = bDirection
	self.m_Trains[train2].bPassengerTrain = bPassengerTrain
	self.m_Trains[train2].uRenderCol = createColSphere(x, y, z, self.Settings.RenderDistance)
	attachElements(self.m_Trains[train2].uRenderCol, train2)
    setElementData(train2, "IsServerTrain", true)
	if self.Settings.Debug then
		createBlipAttachedTo(train2)
	end
end

function ServerTrains:updateTrains()
    for train, info in pairs(self.m_Trains) do
        if not info.node then
            info.node, info.track = self:getClosestNodeToPoint(getElementPosition(train))
         --   outputDebugString(("Found new track + node. Node: %d Track: %d"):format(info.node.index, info.track))
            info.trackDistance = info.node.distance
        end

        local nextNode = self.m_Tracks[info.track][info.node.index + 1] or self.m_Tracks[info.track][1]
        local deltaTrackDistance = info.speed * (50 + self.Settings.SyncSpeedDiff ) * self.Settings.Interval / 1000

        info.trackDistance = info.trackDistance + deltaTrackDistance
        while info.trackDistance > nextNode.distance do
            info.node = nextNode
            nextNode = self.m_Tracks[info.track][nextNode.index+1]

            if not nextNode then
                nextNode = self.m_Tracks[info.track][2]
                info.node = self.m_Tracks[info.track][1]
                info.trackDistance = info.node.distance
                break
            end
        end

        local deltaNodes = getDistanceBetweenPoints3D(info.node.x, info.node.y, info.node.z, nextNode.x, nextNode.y, nextNode.z)
        local progress = (info.trackDistance - info.node.distance) / deltaNodes

        -- Interpolate and set the position
		local x, y, z = interpolateBetween(info.node.x, info.node.y, info.node.z, nextNode.x, nextNode.y, nextNode.z, progress, "Linear")
		local x2, y2, z2    = getElementPosition(train)
		local zone          = getZoneName(info.node.x, info.node.y, info.node.z, false)
		--station check
		if self.m_Trains[train].bInStation and getTickCount()-self.m_Trains[train].bInStation <= self.Settings.StationTime then
			self.m_Trains[train].speed = 0
		else
			self.m_Trains[train].bInStation = false -- update
			if(self.m_slowPositions[string.lower(zone)]) then
				self.m_Trains[train].speed = 0.4
			elseif(self.m_verySlowPositions[string.lower(zone)]) then
				self.m_Trains[train].speed = 0.15
			elseif(self.m_veryFastPositions[string.lower(zone)]) then
				self.m_Trains[train].speed = 1
			else
				self.m_Trains[train].speed = 0.7
			end
		end

		-- sync check
		if self.Settings.Debug then
			outputDebugString(("Position: X=%.2f Y=%.2f Z=%.2f Node=%d Distance=%.4f Syncer=%s Speed=%s Zone=%s" ):format(x, y, z, info.node.index, info.trackDistance, getElementSyncer(train) and getPlayerName(getElementSyncer(train)) or "false", info.speed, zone))
		end
		if #getElementsWithinColShape(self.m_Trains[train].uRenderCol, "player") > 0 then
			if not self.m_Trains[train].tblVisibleTrain then
				if self.Settings.Debug then
					outputChatBox("creating new train")
				end
				self:changeTrainState(train, x,y,z)
			else
				setTrainSpeed(self.m_Trains[train].tblVisibleTrain[1], info.speed)
				-- Warnung bei desync
				local tx, ty, tz = getElementPosition(self.m_Trains[train].tblVisibleTrain[1])
				local dist = getDistanceBetweenPoints3D(x, y, z, tx, ty, tz)
				if dist > self.Settings.RenderDistance then
					for i,v in pairs(getElementsWithinColShape(self.m_Trains[train].uRenderCol, "player")) do
						--outputConsole("Sorry, but this train might be desynced by "..dist.."m!", v)
					end
				end
			end
			setElementPosition(train, x, y, z-1)
		elseif not getElementSyncer(train) then
			if self.m_Trains[train].tblVisibleTrain then
				self:changeTrainState(train)
				if self.Settings.Debug then
					outputChatBox("destroying train")
				end
			end
			setElementPosition(train, x, y, z-1)
		end
    end
end


function ServerTrains:changeTrainState(train, x, y, z)
	if x then
		self.m_Trains[train].tblVisibleTrain = {}
		tblVisibleTrain = self.m_Trains[train].tblVisibleTrain
		for index, id in ipairs(self.m_Trains[train].tblTrain) do
			curAdd = 50
            setTimer(function()
                tblVisibleTrain[index] = createVehicle(id, x, y, z)
				if self.m_Trains[train].bPassengerTrain then
					setVehicleColor(tblVisibleTrain[index], 0, 240, 255, 255, 255, 255)
				end
                setTrainDerailable(tblVisibleTrain[index], false)
                setTrainDirection(tblVisibleTrain[index], true)
                setElementID(tblVisibleTrain[index], "visibleTrain")

                if(tblVisibleTrain[index-1]) and (isElement(tblVisibleTrain[index-1])) then
                    attachTrailerToVehicle(tblVisibleTrain[index-1], tblVisibleTrain[index])
                else
                    local ped = createPed(294, x, y, z)
                    warpPedIntoVehicle(ped, tblVisibleTrain[index])
					self.m_Trains[train].ped = ped -- ist zwar doof, aber den Typ löscht es nicht
					setVehicleLocked(tblVisibleTrain[index], true)
					setTrainSpeed(tblVisibleTrain[index], self.m_Trains[train].speed)
                end
            end, curAdd*index, 1)
        end
	else
		for i,v in pairs(tblVisibleTrain) do
			if(isElement(v))then
				destroyElement(v)
			end
		end
		destroyElement(self.m_Trains[train].ped)
		self.m_Trains[train].tblVisibleTrain = nil
	end
end


function ServerTrains:getClosestNodeToPoint(x, y, z)
    local minDistance = math.huge
    local closestNode, closestTrack

    -- Iterate over train tracks
    for i, trackNodes in ipairs(self.m_Tracks) do

        -- Iterate over track nodes
        for k, node in ipairs(trackNodes) do
            local distance = getDistanceBetweenPoints3D(x, y, z, node.x, node.y, node.z)
            if distance < minDistance then
                minDistance = distance
                closestNode = node
                closestTrack = i
            end
        end
    end

    return closestNode, closestTrack
end

-- am besten nicht mehr als 6 Wagen anhängen
addEventHandler("onResourceStart", resourceRoot,function()
	local x,y,z = 2286.17578, -1161.74585, 26.53530 -- East LS
	local tblTrain = {538,570,570,}
	ServerTrains:new():addTrain(x,y,z, tblTrain, 0.7, true, true)


	x,y,z = -1944.37500, 101.84702, 25.9902 -- Cranberry Station SF
	tblTrain = {538,570,570,570,570,}
	ServerTrains:new():addTrain(x,y,z, tblTrain, 0.7, true, true)

	x,y,z = 1475.89893, 2634.43311, 10.82031 -- Yellow Bell Station
	tblTrain = {537,569,590,590,590,569,569,}
	ServerTrains:new():addTrain(x,y,z, tblTrain, 1, true, false)
end)