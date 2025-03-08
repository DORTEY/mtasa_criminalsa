addRemoteEvents{"Rob:SprunkATM:Sync:Effects:C"};--addEvents


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
        if(getElementData(localPlayer,"Player:Data:isRobbing")=="SprunkATM")then
            Count=Count+1;
            if(not(Animation))then
                Animation=true;
                triggerServerEvent("Rob:SprunkATM:Sync:Rotation",localPlayer,true);
            end
            if(Count>=Robs["SprunkATM"].Timers.TillOpen)then
                Count=0;
                triggerServerEvent("Rob:Start:SprunkATM",localPlayer);
                if(Animation)then
                    Animation=nil;
                    triggerServerEvent("Rob:SprunkATM:Sync:Rotation",localPlayer);
                end
            end
        end
    else
        Count=0;
        if(Animation)then
            Animation=nil;
            triggerServerEvent("Rob:SprunkATM:Sync:Rotation",localPlayer);
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
        local MaxMoney=Hideout.Dufflebag.Benefits[tonumber(getPlayerJsonValue(localPlayer,"HideUpgrades","Dufflebag"))]and Hideout.Dufflebag.Benefits[tonumber(getPlayerJsonValue(localPlayer,"HideUpgrades","Dufflebag"))].max;
        local RobbedAmount=tonumber(getElementData(localPlayer,"Player:Data:RobbedAmount"))or 0;

        local x,y,z=getElementPosition(localPlayer);
        for _,v in ipairs(getElementsByType("colshape"))do
            if(v and isElement(v))then
                if(v~=nameSphere and getElementType(v)=="colshape")then
                    if(isElementWithinColShape(localPlayer,v))then
                        if(getElementData(v,"Col:Data:Type")=="SprunkATM")then
                            local vx,vy,vz=getElementPosition(v);
                            if(getDistanceBetweenPoints3D(x,y,z,vx,vy,vz)<=10)then
                                local x,y=getScreenFromWorldPosition(vx,vy,vz+1.1);
                                if(x and y)then
                                    if(RobbedAmount<MaxMoney)then
                                        local currentBarCount=146/Robs["SprunkATM"].Timers.TillOpen*Count;

                                        dxDrawRectangle(x-150/2,y,150,35,tocolor(0,0,0,150),false);
                                        dxDrawRectangle(x-150/2+2,y+2,currentBarCount,31,tocolor(Server.Color.RGB[1],Server.Color.RGB[2],Server.Color.RGB[3],255),false);
                                        dxDrawText(loc(localPlayer,"HoldE"),x-120/2,y,120+x-120/2,35+y,tocolor(255,255,255,255),1.35,"default-bold","center","center",false,false,true,true);
                                    else
                                        dxDrawRectangle(x-150/2,y,150,35,tocolor(200,60,60,150),false);
                                        dxDrawText(loc(localPlayer,"HoldE:Full"),x-120/2,y,120+x-120/2,35+y,tocolor(255,255,255,255),1.35,"default-bold","center","center",false,false,true,true);
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)


local tblRobEffects={};

addEventHandler("Rob:SprunkATM:Sync:Effects:C",root,function(type,elem)
    if(type and elem)then
        local x,y,z=getElementPosition(localPlayer);
        local x1,y1,z1=getElementPosition(elem);
        if(isElement(tblRobEffects[elem]))then
            destroyElement(tblRobEffects[elem]);
            tblRobEffects[elem]=nil;
        end

        local effect=createEffect("prt_spark_2",x1,y1,z1,-90,0,0);
        tblRobEffects[elem]=effect;
    else
        if(isElement(tblRobEffects[elem]))then
            destroyElement(tblRobEffects[elem]);
            tblRobEffects[elem]=nil;
        end
    end
end)