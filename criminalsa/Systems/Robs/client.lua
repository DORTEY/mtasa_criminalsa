addRemoteEvents{"Rob:DeliverMarker","Rob:Load:Bots:C"};--addEvents


local DeliverMarker,DeliverBlip,DeliverStage=nil,nil,math.random(1,#Robs.DeliverPositions);


function playerTargetCheck()
    for _,v in pairs(getElementsByType("ped"))do
        local x,y,z=getElementPosition(localPlayer);
        local pedX,pedY,pedZ=getElementPosition(v);
        if(getDistanceBetweenPoints3D(x,y,z,pedX,pedY,pedZ)<=8)then
            if(getPedTask(localPlayer,"secondary",0)=="TASK_SIMPLE_USE_GUN" and getPedTarget(localPlayer)==v)then
                if(getElementData(v,"Ped:Data:Rob")=="Jewelery")then
                    triggerServerEvent("Rob:Start:Jewelery",localPlayer);
                end
                if(getElementData(v,"Ped:Data:Rob")=="Shop")then
                    triggerServerEvent("Rob:Start:Shop",localPlayer);
                end
            end
        end
    end
end
setTimer(playerTargetCheck,1000,0)


function drawDuffleMoney()
    if(not(isLoggedin()))then
		return;
	end
	if(isMainMenuActive())then
		return;
	end
	if(isPedDead(localPlayer))then
		return;
	end
	if(isClickedState(localPlayer)==true)then
		return;
	end
	if(getPedWeapon(localPlayer)==34 and isPedAiming(localPlayer))then
		return;
	end
	if(RADAR_TOGGLE)then
		return;
	end
    if(not(getElementData(localPlayer,"Player:Data:RobbedAmount")))then
        return;
    end

    local MaxMoney=Hideout.Dufflebag.Benefits[tonumber(getPlayerJsonValue(localPlayer,"HideUpgrades","Dufflebag"))]and Hideout.Dufflebag.Benefits[tonumber(getPlayerJsonValue(localPlayer,"HideUpgrades","Dufflebag"))].max;
    local currentBarCount=290/MaxMoney*getElementData(localPlayer,"Player:Data:RobbedAmount");

    dxDrawRectangle(810*Gsx,950*Gsy,300*Gsx,50*Gsy,tocolor(0,0,0,140),false);
    dxDrawRectangle(815*Gsx,955*Gsy,currentBarCount*Gsx,40*Gsy,tocolor(0,240,255,200),false);
    if(Hideout.Hideout.Benefits[tonumber(getPlayerJsonValue(localPlayer,"HideUpgrades","Hideout"))].Cash>0)then
        local PercentageReward=getElementData(localPlayer,"Player:Data:RobbedAmount")+getElementData(localPlayer,"Player:Data:RobbedAmount")*Hideout.Hideout.Benefits[tonumber(getPlayerJsonValue(localPlayer,"HideUpgrades","Hideout"))].Cash/100;
        dxDrawText(comma_value(getElementData(localPlayer,"Player:Data:RobbedAmount")).." / "..comma_value(MaxMoney).." +"..Hideout.Hideout.Benefits[tonumber(getPlayerJsonValue(localPlayer,"HideUpgrades","Hideout"))].Cash.."% ["..math.floor(PercentageReward).."]",1890*Gsx,965*Gsy,30*Gsx,30*Gsy,tocolor(255,255,255,255),1.3*Gsx,"default-bold","center");
    else
        dxDrawText(comma_value(getElementData(localPlayer,"Player:Data:RobbedAmount")).." / "..comma_value(MaxMoney),1890*Gsx,965*Gsy,30*Gsx,30*Gsy,tocolor(255,255,255,255),1.3*Gsx,"default-bold","center");
    end


    --3D Text
	local Distance=#(Vector3(Robs.DeliverPositions[DeliverStage][1],Robs.DeliverPositions[DeliverStage][2],Robs.DeliverPositions[DeliverStage][3])-Vector3(getElementPosition(localPlayer)));
	if(Distance>1 and Distance<=9999)then
		local sx,sy=getScreenFromWorldPosition(Robs.DeliverPositions[DeliverStage][1],Robs.DeliverPositions[DeliverStage][2],Robs.DeliverPositions[DeliverStage][3]+0.95,0.06);
		if(not sx)then return; end
		dxDrawText(loc(localPlayer,"Rob:Deliver:3DText").." ("..Server.Color.HEX..math.floor(Distance).."m#ffffff)",sx,sy-30,sx,sy-30,tocolor(255,255,255,255), math.min((Distance)*1,1.2),"default-bold","center","bottom",false,false,false,true);
        dxDrawImage(sx-30*Gsx,sy*Gsy,math.min((Distance)*40,50)*Gsx,math.min((Distance)*40,50)*Gsy,":"..RESOURCE_NAME.."/Files/Images/Deliver.png",0,0,0,tocolor(255,255,255,255));
    end
end
addEventHandler("onClientRender",root,drawDuffleMoney);


addEventHandler("Rob:DeliverMarker",root,function(type)
    if(type)then--appear
        if(isElement(DeliverMarker))then
            destroyElement(DeliverMarker);
            DeliverMarker=nil;
        end
        if(isElement(DeliverBlip))then
            destroyElement(DeliverBlip);
            DeliverBlip=nil;
        end
        
        DeliverMarker=createMarker(Robs.DeliverPositions[DeliverStage][1],Robs.DeliverPositions[DeliverStage][2],Robs.DeliverPositions[DeliverStage][3],"cylinder",4.0,200,0,0,120);
        DeliverBlip=createBlip(Robs.DeliverPositions[DeliverStage][1],Robs.DeliverPositions[DeliverStage][2],Robs.DeliverPositions[DeliverStage][3],0,22,200,0,0);
		setElementData(DeliverBlip,"Blip:Data:Tooltip",loc(localPlayer,"Rob:Deliver:3DText"));

        addEventHandler("onClientMarkerHit",DeliverMarker,function(hitElem,dim)
            if(hitElem==localPlayer and dim and source)then
                if(getElementInterior(localPlayer)==getElementInterior(source)and getElementDimension(localPlayer)==getElementDimension(source))then
                    local Distance=#(Vector3(Robs.DeliverPositions[DeliverStage][1],Robs.DeliverPositions[DeliverStage][2],Robs.DeliverPositions[DeliverStage][3])-Vector3(getElementPosition(localPlayer)));
                    if(Distance<=5)then
                        if(not(isPedInVehicle(localPlayer)))then
                            triggerServerEvent("Rob:GiveReward",localPlayer);
                        end
                    end
                end
            end
        end)
    else--disappear
        if(isElement(DeliverMarker))then
            destroyElement(DeliverMarker);
            DeliverMarker=nil;
        end
        if(isElement(DeliverBlip))then
            destroyElement(DeliverBlip);
            DeliverBlip=nil;
        end

        DeliverStage=math.random(1,#Robs.DeliverPositions);
    end
end)






--NPC
local BotDoesntshootChance=35;
local PEDS={};
addEventHandler("Rob:Load:Bots:C",root,function(type,tbl)
    if(type)then
        for i,v in pairs(tbl)do
            table.insert(PEDS,{v[2],v[3]});
        end
    else
        PEDS={};
    end
end)

addEventHandler("onClientRender",root,function()
    if(not(isLoggedin()))then
        return;
    end

    local x,y,z=getPedBonePosition(localPlayer,8);

    for _,v in pairs(PEDS)do
        if(v[1] and isElement(v[1]))then
            local x1,y1,z1=getPedBonePosition(v[1],8);

            if(Server.Settings.BOTs)then
                if(getDistanceBetweenPoints3D(x,y,z,x1,y1,z1)<=v[2])then
                    if(isLineOfSightClear(x,y,z,x1,y1,z1,true,true,false,true,true,false,false))then
                        if(isPedDead(localPlayer)or isPedDead(v[1]))then
                            setPedControlState(v[1],"fire",false);
                            setPedControlState(v[1],"aim_weapon",false);
                        else
                            if(isPedDucked(localPlayer))then
                                setPedAimTarget(v[1],x,y,z-.5);
                            else
                                setPedAimTarget(v[1],x,y,z+0.6);
                            end
                            if(math.random(1,100)<=BotDoesntshootChance)then
                                setPedControlState(v[1],"fire",false);
                                setPedControlState(v[1],"aim_weapon",false);
                            else
                                setPedControlState(v[1],"fire",true);
                                setPedControlState(v[1],"aim_weapon",true);
                            end

                            local rotZ=findRotation(x1,y1, x,y);
                            setElementRotation(v[1],0,0,rotZ);
                        end
                    else
                        setPedControlState(v[1],"fire",false);
                        setPedControlState(v[1],"aim_weapon",false);
                    end
                else
                    setPedControlState(v[1],"fire",false);
                    setPedControlState(v[1],"aim_weapon",false);
                end
            end
        end
    end
end)