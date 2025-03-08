local function calcRGBByHP(player)
	local hp=getElementHealth(player);
	local armor=getPedArmor(player);
	if(hp<=0)then
		return 0,0,0;
	else
		if(armor>0)then
			armor=math.abs(armor-0.01);
			return 0+(2.55*armor),(255),0+(2.55*armor);
		else
			hp=math.abs(hp-0.01);
			return(100-hp)*2.55/2,(hp*2.55),0;
		end
	end
end


addEventHandler("onClientRender",root,function()
	if(isChatBoxInputActive()or isConsoleActive())then
		setElementData(localPlayer,"isChatBoxInputActive",true);
	else
		setElementData(localPlayer,"isChatBoxInputActive",false);
	end
end)
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
	if(HUD_TOGGLE)then
		return;
	end
	

	local r,g,b=0,0,0;

	local TargetAFK={};
	local TargetBounty={};
	local TargetTyping={};
	for _,player in pairs(getElementsByType("player"))do
		setPlayerNametagShowing(player,false);

		if(getElementDimension(localPlayer)==getElementDimension(player)and getElementInterior(localPlayer)==getElementInterior(player)and isLoggedin(player))then
			if(getElementAlpha(player)>=100)then
				local px,py,pz=getPedBonePosition(player,8);
				local x,y,z=getElementPosition(localPlayer);
				if(getDistanceBetweenPoints3D(px,py,pz,x,y,z)<=Server.Settings.NametagRange)then
					local r,g,b=calcRGBByHP(player);
					--datas
					local Bounty=getPlayerJsonValue(player,"Stats","Bounty")or 0;
					local AFK=getElementData(player,"Player:Data:isAFK")or false;


					local sx,sy=getScreenFromWorldPosition(px,py,pz+0.5,1000,true);
					if(sx and sy)then
						--name related
						if(AFK)then
							TargetAFK[player]="#000000[AFK] ";
						else
							TargetAFK[player]="";
						end
						if(Bounty>0)then
							TargetBounty[player]=" #FF3C3C["..Bounty.."]";
						else
							TargetBounty[player]="";
						end
						dxDrawText(TargetAFK[player].."#ffffff"..getPlayerName(player)..TargetBounty[player],sx,sy+40,sx,sy,tocolor(r1,g1,b1,255),1.3,"default-bold","center","center",false,false,false,true);

						--health & armor
						local currentBarCount=100/100*getElementHealth(player);
						dxDrawRectangle(sx-50,sy+35,100,10,tocolor(0,0,0,150),false);
						dxDrawRectangle(sx-50,sy+35,currentBarCount,10,tocolor(r,g,b,150),false);
						dxDrawText(math.floor(getElementHealth(player)+getPedArmor(player)).."%",sx,sy+80,sx,sy,tocolor(255,255,255,255),1,"default-bold","center","center",false,false,true,true);

						dxSetRenderTarget();

						--typing status
						if(getElementData(player,"isChatBoxInputActive")==true)then 
							TargetTyping[player]="typing...";
						else
							TargetTyping[player]="";
						end
						dxDrawText("#ffffff"..TargetTyping[player],sx,sy+110,sx,sy,tocolor(255,255,255,255),1.1,"default-bold","center","center",false,false,false,true);
					end
				end
			end
		end
	end
end)