addEventHandler("onClientRender",root,function()
	if(not(isLoggedin()))then
		return;
	end
	if(isPedDead(localPlayer))then
		return;
	end
	if(isClickedState(localPlayer)==true)then
		return;
	end
	if(isPlayerMapVisible(localPlayer)==true)then
		return;
	end
	
	for _,v in pairs(getElementsByType("ped"))do
		if(getElementDimension(localPlayer)==getElementDimension(v)and getElementInterior(localPlayer)==getElementInterior(v))then
			local px,py,pz=getPedBonePosition(v,8);
			local x,y,z=getPedBonePosition(localPlayer,8);
			
			if(getDistanceBetweenPoints3D(px,py,pz,x,y,z)<=(tonumber(getElementData(v,"Ped:Data:Nametag:Range"))or 10)and isLineOfSightClear(px,py,pz,x,y,z,true,false,false,true,false,true))then
				local sx,sy=getScreenFromWorldPosition(px,py,pz+0.5,1000,true);
				if(sx and sy)then
                    if(getElementData(v,"Ped:Data:Nametag:Name"))then
                        local PedName=getElementData(v,"Ped:Data:Nametag:Name"):gsub("_"," ")or "";
                        dxDrawText(Server.Color.HEX..""..PedName,sx,sy,sx,sy,tocolor(0,0,0,255),1.6,"default-bold","center","center",false,false,false,true);
                    end
                    if(getElementData(v,"Ped:Data:Nametag:Title"))then
                        local PedTitle=getElementData(v,"Ped:Data:Nametag:Title")or " ";
                        dxDrawText("#ffffff"..PedTitle,sx,sy-40,sx,sy,tocolor(0,0,0,255),1.1,"default-bold","center","center",false,false,false,true);
                    end

					if(getElementData(v,"Ped:Data:Health"))then
						local PedHealthArmor=math.floor(getElementData(v,"Ped:Data:Health"));
						local currentBarCount=100/getElementData(v,"Ped:Data:MaxHealth")*getElementData(v,"Ped:Data:Health");

						dxDrawRectangle(sx-50,sy+12,100,10,tocolor(0,0,0,150),false);
						dxDrawRectangle(sx-50,sy+12,currentBarCount,10,tocolor(255,60,60,150),false);
						dxDrawText(PedHealthArmor.."%",sx,sy+35,sx,sy,tocolor(255,255,255,255),1,"default-bold","center","center",false,false,true,true);
					end
				end
			end
		end
	end
end)