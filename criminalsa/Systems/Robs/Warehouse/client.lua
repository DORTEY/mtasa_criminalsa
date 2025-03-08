addRemoteEvents{};--addEvents


local Animation=false;
local Count=0;


addEventHandler("onClientPreRender",root,function()
    if(not(isLoggedin()))then
        return;
    end
    if(isPedDead(localPlayer))then
        return;
    end

    if(getKeyState("E")and getElementData(localPlayer,"Player:Data:isRobbing")and getElementData(localPlayer,"Player:Data:MarkerRobAllowed"))then
        if(getElementData(localPlayer,"Player:Data:isRobbing")=="Warehouse")then
            Count=Count+1;
            if(not(Animation))then
                Animation=true;
                triggerServerEvent("Rob:Warehouse:Sync:Rotation",localPlayer,true);
            end
            if(Count>=Robs["Warehouse"].Timers.TillOpen)then
                Count=0;
                triggerServerEvent("Rob:Warehouse:GiveReward",localPlayer);
                if(Animation)then
                    Animation=nil;
                    triggerServerEvent("Rob:Warehouse:Sync:Rotation",localPlayer);
                end
            end
        end
    else
        Count=0;
        if(Animation)then
            Animation=nil;
            triggerServerEvent("Rob:Warehouse:Sync:Rotation",localPlayer);
        end
    end
end)


--Render
addEventHandler("onClientRender",root,function()
	if(not(isLoggedin()))then
		return;
	end
	if(isPedDead(localPlayer))then
		return;
	end

    if(getElementData(localPlayer,"Player:Data:MarkerRobAllowed"))then
        local x,y,z=getElementPosition(localPlayer);
        for _,v in ipairs(getElementsByType("marker"))do
            if(v and isElement(v))then
                if(isElementWithinMarker(localPlayer,v))then
                    if(getElementData(v,"Marker:Data:Rob")=="Warehouse")then
                        local vx,vy,vz=getElementPosition(v);
                        if(getDistanceBetweenPoints3D(x,y,z,vx,vy,vz)<=10)then
                            local x,y=getScreenFromWorldPosition(vx,vy,vz+1.1);
                            if(x and y)then
                                local currentBarCount=146/Robs["Warehouse"].Timers.TillOpen*Count;

                                dxDrawRectangle(x-150/2,y,150,35,tocolor(0,0,0,150),false);
                                dxDrawRectangle(x-150/2+2,y+2,currentBarCount,31,tocolor(Server.Color.RGB[1],Server.Color.RGB[2],Server.Color.RGB[3],255),false);
                                dxDrawText(loc(localPlayer,"HoldE"),x-120/2,y,120+x-120/2,35+y,tocolor(255,255,255,255),1.35,"default-bold","center","center",false,false,true,true);
                            end
                        end
                    end
                end
            end
        end
    end
end)