addRemoteEvents{"Job:Miner:UI"};--addEvent


local Count=0;


addEventHandler("Job:Miner:UI",root,function(count)
    if(not(isLoggedin()))then
		return;
	end
	if(isPedDead(localPlayer))then
		return;
	end

    Count=count;
end)


addEventHandler("onClientRender",root,function()
	if(not(isLoggedin()))then
		return;
	end
	if(isPedDead(localPlayer))then
		return;
	end

    if(getElementData(localPlayer,"Player:Data:isMining"))then
        for _,v in pairs(getElementsByType("colshape"))do
            if(v and isElement(v))then
                if(getElementData(v,"Col:Data:Type")=="Miner")then
                    local vx,vy,vz=getElementPosition(v);
                    local x,y=getScreenFromWorldPosition(vx,vy,vz+0.7);
                    if(x and y)then
                        local Distance=#(Vector3(getElementPosition(localPlayer))-Vector3(getElementPosition(v)));
                        if(Distance<10)then
                            --display rock amount progress
                            if(getElementData(v,"Col:Data:Amount")>0)then
                                local currentBarCount=146/getElementData(v,"Col:Data:MaxAmount")*getElementData(v,"Col:Data:Amount");

                                dxDrawRectangle(x-150/2,y,150,35,tocolor(0,0,0,150),false);
                                dxDrawRectangle(x-150/2+2,y+2,currentBarCount,31,tocolor(Server.Color.RGB[1],Server.Color.RGB[2],Server.Color.RGB[3],255),false);
                            else
                                dxDrawRectangle(x-150/2,y,150,35,tocolor(200,60,60,150),false);
                                dxDrawText(loc(localPlayer,"Empty"),x-120/2,y,120+x-120/2,35+y,tocolor(255,255,255,255),1.35,"default-bold","center","center",false,false,false,true);
                            end

                            --display current mining progress
                            if(getElementData(v,"Col:Data:Amount")>0 and Count)then
                                local currentBarCount=146/Jobs["Miner"].MaxCount*Count;

                                dxDrawRectangle(x-150/2,y+40,150,15,tocolor(0,0,0,150),false);
                                dxDrawRectangle(x-150/2+2,y+42,currentBarCount,11,tocolor(Server.Color.RGB[1],Server.Color.RGB[2],Server.Color.RGB[3],255),false);
                            end
                        end
                    end
                end
            end
        end
    end
end)