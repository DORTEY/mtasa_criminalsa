addEventHandler("onClientRender",root,function()
	if(not(isLoggedin()))then
		return;
	end
	if(isPedDead(localPlayer))then
		return;
	end

    if(getElementData(localPlayer,"Player:Data:isRobbing")and getElementData(localPlayer,"Player:Data:MarkerRobAllowed"))then
        if(getElementData(localPlayer,"Player:Data:isRobbing")=="Oilrig")then
            for i,v in pairs(getElementsByType("object",_,true))do
                if(v and isElement(v))then
                    local Distance=#(Vector3(getElementPosition(localPlayer))-Vector3(getElementPosition(v)));
                    if(Distance<7)then
                        if(getElementModel(v)==3255)then
                            local x,y,z=getElementPosition(localPlayer);
                            local x1,y1,z1=getElementPosition(v);

                            dxDrawLine3D(x,y,z-0.1,x1,y1,z1+3,tocolor(0,0,0,200),5);
                        end
                    end
                end
            end


            local MaxMoney=Hideout.Dufflebag.Benefits[tonumber(getPlayerJsonValue(localPlayer,"HideUpgrades","Dufflebag"))]and Hideout.Dufflebag.Benefits[tonumber(getPlayerJsonValue(localPlayer,"HideUpgrades","Dufflebag"))].max;
            local RobbedAmount=tonumber(getElementData(localPlayer,"Player:Data:RobbedAmount"))or 0;
            --Display Oil amount
            for _,v in ipairs(getElementsByType("marker"))do
                if(v and isElement(v))then
                    local vx,vy,vz=getElementPosition(v);
                    local Distance=#(Vector3(getElementPosition(localPlayer))-Vector3(getElementPosition(v)));
                    if(Distance<7)then
                        local x,y=getScreenFromWorldPosition(vx,vy,vz+1.1);
                        if(x and y)then
                            if(RobbedAmount<MaxMoney)then
                                local currentBarCount=146/getElementData(v,"Marker:Data:MaxAmount")*getElementData(v,"Marker:Data:Amount");

                                dxDrawRectangle(x-150/2,y,150,35,tocolor(0,0,0,150),false);
                                dxDrawRectangle(x-150/2+2,y+2,currentBarCount,31,tocolor(Server.Color.RGB[1],Server.Color.RGB[2],Server.Color.RGB[3],255),false);
                                dxDrawText(getElementData(v,"Marker:Data:Amount").." / "..getElementData(v,"Marker:Data:MaxAmount"),x-120/2,y,120+x-120/2,35+y,tocolor(255,255,255,255),1.35,"default-bold","center","center",false,false,true,true);
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
end)