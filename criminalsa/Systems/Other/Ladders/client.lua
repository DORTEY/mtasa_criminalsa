speedtimer=500;
direction="none";
olddirection="none";
climbing=0;
climbingeffort=0;

function wallclimbDoubleJump(key,state)
	if(climbing==0)then
		local task=getPedSimplestTask(localPlayer)
		if(not(task=="TASK_SIMPLE_SWIM"))then
			radRot=math.rad(getPedRotation(localPlayer)-180);
			local radius=1;
			local px,py,pz=getElementPosition(localPlayer);
			local tx=px+radius*math.sin(radRot);
			local ty=py+ -(radius)*math.cos(radRot);
			local tz=pz;
			local hit,hitX,hitY,hitZ,hitlineElement,normalX,normalY,normalZ,mat,lighting,piece,worldID=processLineOfSight(px,py,pz,tx,ty,tz,true,true,false,true,false,false,false,true,localPlayer,true)
			if(hit)then
				if(hitlineElement)then
					local objType=getElementType(hitlineElement);
					if(objType=="object")then
						worldID=getElementModel(hitlineElement);
					end
				end
				
				if(worldID==3879)then
					climbingeffort=1;
					--add different amounts of climbing effort for various surfaces/object types
				end
				
				if(climbingeffort>0)then 
					local climbobject=getElementData(localPlayer,"climb_object");
					if(isElement(climbobject))then
						destroyElement(climbobject);
						climbobject=nil;
					end
					
					local wallangle=findRotation(hitX+(normalX*10),hitY+(normalY*10),hitX,hitY);
					setPedRotation(localPlayer,wallangle);
					attachPlayer(hitX,hitY,hitZ,wallangle);
				end
			end
		end
	else
		dropPlayer();
	end
end  
bindKey("E","down",wallclimbDoubleJump)

function attachPlayer(hitX,hitY,hitZ,wallangle)
	climbing=1;
	direction="none";
	local climbobject=createObject(1254,hitX,hitY,hitZ,0,0,wallangle);
	setElementCollisionsEnabled(climbobject,false);
	attachElements(localPlayer,climbobject,0,-.38,0);
	setElementData(localPlayer,"climb_object",climbobject,false);
	setElementAlpha(climbobject,0);
	triggerServerEvent("onPlayerStartClimb",localPlayer,hitX,hitY,hitZ,wallangle);
	setPedRotation(localPlayer,wallangle);
end

function dropPlayer()
	if(climbing>0)then
		climbing=0;
		climbingeffort=0;
		
		triggerServerEvent("onPlayerStopClimb",localPlayer);
		setPedAnimation(localPlayer);
		setPedControlState(localPlayer,"jump",true);
		setTimer(function(pl)
			setElementFrozen(pl,true);
		end,200,1,localPlayer)
		setTimer(function(pl)
			setElementFrozen(pl,false);
		end,400,1,localPlayer)
		
		detachElements(localPlayer);
		local climbobject=getElementData(localPlayer,"climb_object");
		if(isElement(climbobject))then
			destroyElement(climbobject);
		end
	end
end
addEventHandler("onClientPlayerWasted",localPlayer,dropPlayer)
addEventHandler("onClientPlayerDamage",localPlayer,dropPlayer)

function climbup()
	if(climbing==1)then
		if(isTimer(controlLoop))then
			resetTimer(controlLoop);
		else
			controlLoop=setTimer(checkControls,speedtimer,1);
		end
		local climbobject=getElementData(localPlayer,"climb_object");
		if(isElement(climbobject))then
			local px,py,pz=getElementPosition(localPlayer);
			local prx,pry,prot=getElementRotation(climbobject);
			local clear=isLineOfSightClear(px,py,pz,px,py,pz+1.6,true,false,false,true,true,false,false,climbobject);
			if(clear==true)then
				local ufx,ufy=getPointFromDistanceRotation(px,py, .8,(prot)*-1)
				local clear2=isLineOfSightClear(px,py,pz+1,ufx,ufy,pz+1,true,false,false,true,true,false,false,climbobject);
				if(clear2==true)then
					local fx,fy=getPointFromDistanceRotation(px,py, .9,(prot)*-1)
					local clear3=isLineOfSightClear(ufx,ufy,pz+1,fx,fy,pz,true,false,false,true,true,false,false,climbobject);
					if(clear3==true)then
					else
						fx2, fy2 = getPointFromDistanceRotation(px, py, .4, (prot)*-1)
						climbontoroof( fx2, fy2, prot)
					end
				else
					climbMove(px,py,pz+1,ufx,ufy,pz+1,"up")
				end
			end
		end
	end
end

function startup()
	if(direction~="up")then
		climbup();
	end
end
bindKey("FORWARDS","down",startup)

function climbdown()
	if(climbing==1)then
		if(isTimer(controlLoop))then
			resetTimer(controlLoop);
		else
			controlLoop=setTimer(checkControls,speedtimer,1);
		end
		local climbobject=getElementData(localPlayer,"climb_object");
		local px,py,pz=getElementPosition(localPlayer);
		local prx,pry,prot=getElementRotation(climbobject);
		local clear=isLineOfSightClear(px,py,pz,px,py,pz-2,true,false,false,true,true,false,false,climbobject);
		if(clear==true)then
			fx,fy=getPointFromDistanceRotation(px,py,1,(prot)*-1);
			local clear2=isLineOfSightClear(px,py,pz-1,fx,fy,pz-1,true,false,false,true,true,false,false,climbobject);
			if(clear2==true)then
				local fx,fy=getPointFromDistanceRotation(px,py,1,(prot)*-1);
				local clear3=isLineOfSightClear(fx,fy,pz-1,fx,fy,pz,true,false,false,true,true,false,false,climbobject);
				if(clear3==true)then
				else
				end
			else
				climbMove(px,py,pz-1,fx,fy,pz-1,"down");
			end			
		else
			dropPlayer();
		end
	end
end

function startdown()
	if(direction~="down")then
		climbdown();
	end
end
bindKey("BACKWARDS","down",startdown)

function climbMove(x,y,z,x1,y1,z1,thedir)
	local climbobject=getElementData(localPlayer,"climb_object");
	local hit,hitX,hitY,hitZ,hitlineElement,normalX,normalY,normalZ=processLineOfSight(x,y,z,x1,y1,z1,true,false,false,true,false,true,false,true,climbobject,false);
	local wallangle=findWallRotation(hitX+(normalX*10),hitY+(normalY*10),hitX,hitY);
	local oldrx,oldry,oldrz=getElementRotation(climbobject);
	local anglediff=(oldrz-wallangle)*-1;
	if(anglediff>179)then
		anglediff=anglediff-360;
	end
	if(anglediff<-179)then
		anglediff=anglediff+360;
	end
	if(thedir~=direction)then
		triggerServerEvent("onPlayerMoveClimb",localPlayer,thedir);
	end
	direction=thedir;
	moveObject(climbobject,speedtimer,hitX,hitY,hitZ,0,0,anglediff);
	if(anglediff~=0)then
		if(isTimer(stopaligning))then
			resetTimer(stopaligning);
		else
			stopaligning=setTimer(stopalign,speedtimer,1);
			addEventHandler("onClientRender",root,alignplayer);
		end		
	end
end

function checkControls()
	if(climbing==1)then
		if(isTimer(controlLoop))then
			controlLoop=nil;
		end
		if(getPedControlState(localPlayer,"forwards")==true)then
			climbup();
		elseif(getPedControlState(localPlayer,"backwards")==true)then
			climbdown();
		else
			direction="none";
			triggerServerEvent("onPlayerStayClimb",localPlayer);
		end
	end
end

function getPointFromDistanceRotation(x,y,dist,angle)
	local a=math.rad(90-angle);
	local dx=math.cos(a)*dist;
	local dy=math.sin(a)*dist;
	
	return x+dx,y+dy;
end

function climbontoroof(fx2,fy2,prot)
	local climbobject=getElementData(localPlayer,"climb_object");
	local px,py,pz=getElementPosition(localPlayer);
	climbing=0;
	local hit,hitX,hitY,hitZ,hitlineElement,normalX,normalY,normalZ=processLineOfSight(fx2,fy2,pz+2,fx2,fy2,pz-.4,true,false,false,true,false,true,false,true,climbobject,false);
	triggerServerEvent("onPlayerRoofClimb",localPlayer);
	setElementPosition(climbobject,px,py,hitZ);
	setTimer(roofland,900,1,localPlayer,hitX,hitY,hitZ,prot);
end

function roofland(player,x,y,z,angle)
	detachElements(localPlayer)
	local climbobject=getElementData(player,"climb_object");
	if(isElement(climbobject))then
		destroyElement(climbobject);
		climbobject=nil;
	end
	setElementPosition(localPlayer,x,y,z+.7,false);
	setPedControlState(localPlayer,"jump",true);
	setPedRotation(player,angle);
	climbing=0;
	climbingeffort=0;
end

function alignplayer()
	local theclimbobject=getElementData(localPlayer,"climb_object");
	if(isElement(theclimbobject))then
		local rx,ry,rz=getElementRotation(theclimbobject);
		setPedRotation(localPlayer,rz);
	end
end

function stopalign()
	removeEventHandler("onClientRender",root,alignplayer);
	stopaligning=nil;
	local theclimbobject=getElementData(localPlayer,"climb_object");
	if isElement(theclimbobject) then
		local rx,ry,rz=getElementRotation(theclimbobject);
		triggerServerEvent("onPlayerRotateClimb",localPlayer,rz);
	end
end

function findWallRotation(x1,y1,x2,y2)
	local t=-math.deg(math.atan2(x2-x1,y2-y1));
	if(t<0)then
		t=t+360;
	end
	
	return t;
end