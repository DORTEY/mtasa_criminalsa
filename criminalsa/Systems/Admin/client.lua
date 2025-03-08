addRemoteEvents{"Admin:Givecar"};--addEvents


local EventPickups=nil;
local EventPickupBlips={};
local ObjectCoords=nil;
local Achievementss=nil;
local AchievementBlips={};
local Atms=nil;
local AtmsBlips={};
local AdminUI=nil;


addCommandHandler("dev",function(cmd,web)
	if(not(isLoggedin()))then
		return;
	end
	if(Admin[tonumber(getElementData(localPlayer,"AdminLevel"))].Permissions.DevFunctions)then
		local boolean=not getDevelopmentMode();
		if(web)then
			setDevelopmentMode(boolean,true);
		else
			setDevelopmentMode(boolean,false);
		end
		print(boolean)
	end
end)

addCommandHandler("dev2",function()
	if(not(isLoggedin()))then
		return;
	end
	if(Admin[tonumber(getElementData(localPlayer,"AdminLevel"))].Permissions.DevFunctions)then
		AdminUI=not AdminUI;
	end
end)
addEventHandler("onClientRender",root,function()
	if(not(isLoggedin()))then
		return;
	end
	if(isPedDead(localPlayer))then
		return;
	end

	if(AdminUI)then
		dxDrawRectangle(1620*Gsx,620*Gsy,200*Gsx,250*Gsy,tocolor(0,0,0,140),false);

		dxDrawRectangle(1620*Gsx,620*Gsy,200*Gsx,30*Gsy,tocolor(255,255,255,140),false);
		dxDrawText("#ffffffCopy coords",3420*Gsx,625*Gsy,30*Gsx,30*Gsy,tocolor(0,0,0,255),1.20*Gsx,"default-bold","center",_,_,_,false,true,_);
		
		dxDrawRectangle(1620*Gsx,660*Gsy,200*Gsx,30*Gsy,tocolor(255,255,255,140),false);
		dxDrawText("#ffffffShow all achievements",3420*Gsx,665*Gsy,30*Gsx,30*Gsy,tocolor(0,0,0,255),1.20*Gsx,"default-bold","center",_,_,_,false,true,_);
		if(Achievementss)then
			local x,y,z=getElementPosition(localPlayer);
			for _,v in ipairs(getElementsByType("pickup"))do
				if(v and isElement(v))then
					if(getElementModel(v)==1276 or getElementModel(v)==954 or getElementModel(v)==953)then
						local x1,y1,z1=getElementPosition(v);
						if(getDistanceBetweenPoints3D(x,y,z,x1,y1,z1)<=500)then
							local x,y=getScreenFromWorldPosition(x1,y1,z1+1.1);
							if(x and y)then
								dxDrawText("ID: "..getElementModel(v),x-120/2,y-15,120+x-120/2,40+y,tocolor(255,255,255,255),0.8,"default-bold","center","center",false,false,true,true);
								dxDrawText("X: "..math.floor(x1).." Y: "..math.floor(y1).." Z: "..math.floor(z1),x-120/2,y+15,120+x-120/2,40+y,tocolor(255,255,255,255),0.8,"default-bold","center","center",false,false,true,true);
							end
						end
					end
				end
			end
		end

		dxDrawRectangle(1620*Gsx,700*Gsy,200*Gsx,30*Gsy,tocolor(255,255,255,140),false);
		dxDrawText("#ffffffShow nearby objects",3420*Gsx,705*Gsy,30*Gsx,30*Gsy,tocolor(0,0,0,255),1.20*Gsx,"default-bold","center",_,_,_,false,true,_);
		if(ObjectCoords)then
			local x,y,z=getElementPosition(localPlayer);
			for _,v in ipairs(getElementsByType("object"))do
				if(v and isElement(v))then
					local x1,y1,z1=getElementPosition(v);
					if(getDistanceBetweenPoints3D(x,y,z,x1,y1,z1)<=200)then
						local x,y=getScreenFromWorldPosition(x1,y1,z1+1.1);
						if(x and y)then
							dxDrawText("ID: "..getElementModel(v),x-120/2,y-15,120+x-120/2,40+y,tocolor(255,255,255,255),0.8,"default-bold","center","center",false,false,true,true);
							dxDrawText("X: "..math.floor(x1).." Y: "..math.floor(y1).." Z: "..math.floor(z1),x-120/2,y+15,120+x-120/2,40+y,tocolor(255,255,255,255),0.8,"default-bold","center","center",false,false,true,true);
							dxDrawText("Frozen: "..tostring(isElementFrozen(v)).." Breakable: "..tostring(isObjectBreakable(v)),x-120/2,y+45,120+x-120/2,40+y,tocolor(255,255,255,255),0.8,"default-bold","center","center",false,false,true,true);
						end
					end
				end
			end
		end

		dxDrawRectangle(1620*Gsx,740*Gsy,200*Gsx,30*Gsy,tocolor(255,255,255,140),false);
		dxDrawText("#ffffffShow all event pickups",3420*Gsx,745*Gsy,30*Gsx,30*Gsy,tocolor(0,0,0,255),1.20*Gsx,"default-bold","center",_,_,_,false,true,_);
		if(EventPickups)then
			local x,y,z=getElementPosition(localPlayer);
			for _,v in ipairs(getElementsByType("pickup"))do
				if(v and isElement(v))then
					if(getElementModel(v)==3101)then
						local x1,y1,z1=getElementPosition(v);
						if(getDistanceBetweenPoints3D(x,y,z,x1,y1,z1)<=500)then
							local x,y=getScreenFromWorldPosition(x1,y1,z1+1.1);
							if(x and y)then
								dxDrawText("ID: "..getElementModel(v),x-120/2,y-15,120+x-120/2,40+y,tocolor(255,255,255,255),0.8,"default-bold","center","center",false,false,true,true);
								dxDrawText("X: "..math.floor(x1).." Y: "..math.floor(y1).." Z: "..math.floor(z1),x-120/2,y+15,120+x-120/2,40+y,tocolor(255,255,255,255),0.8,"default-bold","center","center",false,false,true,true);
							end
						end
					end
				end
			end
		end

		dxDrawRectangle(1620*Gsx,780*Gsy,200*Gsx,30*Gsy,tocolor(255,255,255,140),false);
		dxDrawText("#ffffffShow all atms",3420*Gsx,785*Gsy,30*Gsx,30*Gsy,tocolor(0,0,0,255),1.20*Gsx,"default-bold","center",_,_,_,false,true,_);
		if(Atms)then
			local x,y,z=getElementPosition(localPlayer);
			for _,v in ipairs(getElementsByType("object"))do
				if(v and isElement(v))then
					if(getElementModel(v)==2942 or getElementModel(v)==2943 or getElementModel(v)==1900)then
						local x1,y1,z1=getElementPosition(v);
						if(getDistanceBetweenPoints3D(x,y,z,x1,y1,z1)<=500)then
							local x,y=getScreenFromWorldPosition(x1,y1,z1+1.1);
							if(x and y)then
								dxDrawText("ID: "..getElementModel(v),x-120/2,y-15,120+x-120/2,40+y,tocolor(255,255,255,255),0.8,"default-bold","center","center",false,false,true,true);
								dxDrawText("X: "..math.floor(x1).." Y: "..math.floor(y1).." Z: "..math.floor(z1),x-120/2,y+15,120+x-120/2,40+y,tocolor(255,255,255,255),0.8,"default-bold","center","center",false,false,true,true);
							end
						end
					end
				end
			end
		end

	end
end)
addEventHandler("onClientClick",root,function(button,state)
	if(AdminUI)then
		if(button=="left" and state=="down")then
			if(isCursorOnElement(1620*Gsx,620*Gsy,200*Gsx,30*Gsy))then--Copy coords
				local x,y,z=getElementPosition(localPlayer);
				local xr,yr,zr=getElementRotation(localPlayer);
				setClipboard(x..","..y..","..z);

				outputChatBox("Your Position: "..x..", " ..y..", " ..z,239,100,0,true);
				outputChatBox("Your Rotation: "..xr..", " ..yr..", " ..zr,239,100,0,true);
			end

			if(isCursorOnElement(1620*Gsx,660*Gsy,200*Gsx,30*Gsy))then--Show achievements
				Achievementss=not Achievementss;

				if(Achievementss)then
					for _,v in ipairs(getElementsByType("pickup"))do
						if(v and isElement(v))then
							if(getElementModel(v)==1276 or getElementModel(v)==954 or getElementModel(v)==953)then
								local x1,y1,z1=getElementPosition(v);
								local Blip=createBlip(x1,y1,z1,0,22,0,0,0);

								table.insert(AchievementBlips,{Blip});
							end
						end
					end
				else
					for i,v in ipairs(AchievementBlips)do
						if(isElement(v[1]))then
							destroyElement(v[1]);
						end
					end
				end
			end

			if(isCursorOnElement(1620*Gsx,700*Gsy,200*Gsx,30*Gsy))then--Show objects
				ObjectCoords=not ObjectCoords;
			end

			if(isCursorOnElement(1620*Gsx,740*Gsy,200*Gsx,30*Gsy))then--Show event pickups
				local CurrentEvent=Server.Settings.Event.Current[1];
				if(CurrentEvent~="none")then
					EventPickups=not EventPickups;

					if(EventPickups)then
						for _,v in ipairs(getElementsByType("pickup"))do
							if(v and isElement(v))then
								if(getElementModel(v)==tonumber(Achievements.Pickups[Server.Settings.Event.Datas[CurrentEvent]].ObjectID))then
									local x1,y1,z1=getElementPosition(v);
									local Blip=createBlip(x1,y1,z1,0,22,0,0,0);

									table.insert(EventPickupBlips,{Blip});
								end
							end
						end
					else
						for i,v in ipairs(EventPickupBlips)do
							if(isElement(v[1]))then
								destroyElement(v[1]);
							end
						end
					end
				end
			end

			if(isCursorOnElement(1620*Gsx,780*Gsy,200*Gsx,30*Gsy))then--Show Atms
				Atms=not Atms;

				if(Atms)then
					for _,v in ipairs(getElementsByType("object"))do
						if(v and isElement(v))then
							if(getElementModel(v)==2942 or getElementModel(v)==2943 or getElementModel(v)==1900)then
								local x1,y1,z1=getElementPosition(v);
								local Blip=createBlip(x1,y1,z1,0,22,220,220,220);

								table.insert(AtmsBlips,{Blip});
							end
						end
					end
				else
					for i,v in ipairs(AtmsBlips)do
						if(isElement(v[1]))then
							destroyElement(v[1]);
						end
					end
				end
			end

		end
	end
end)






local Object=nil;
local Shader=nil;
addCommandHandler("object",function(cmd,id,distance)
	if(not(isLoggedin()))then
		return;
	end
	if(Admin[tonumber(getElementData(localPlayer,"AdminLevel"))].Permissions.DevFunctions)then
		if(id)then
			if(isElement(Object))then
				destroyElement(Object);
			end

			local x,y,z=getElementPosition(localPlayer);
			Distance=4;
			if(distance)then
				Distance=distance;
			end
			local x1,y1,z1=getPositionInFrontOfElement(localPlayer,tonumber(Distance));
			local Height=555;
			Object=createObject(tonumber(id),x1,y1,z1+Height,0,0,0)
			setElementRotation(Object,0,0,0);

			setCameraMatrix(x,y,z+Height, x1,y1,z1+Height)
		else
			if(isElement(Object))then
				destroyElement(Object);
			end
			setCameraTarget(localPlayer,localPlayer);
		end
	end
end)
addCommandHandler("rotate",function(cmd,rot)
	if(isElement(Object))then
		setElementRotation(Object,0,0,tonumber(rot));
	end
end)