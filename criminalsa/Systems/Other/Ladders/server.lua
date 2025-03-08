function animLock(ped)
	if(isElement(ped))then
        setPedAnimationProgress(ped,"BMX_pedal",1.0);
        animLockTimer=setTimer(animLock,300,1,ped);
	end
end


speedtimer=500;

function startclimb(x,y,z,wallangle)
	local climbobject=createObject(1254,x,y,z,0,0,wallangle)
	setElementDimension(climbobject,getElementDimension(source));
	setElementInterior(climbobject,getElementInterior(source));
	setElementCollisionsEnabled(climbobject,false);
	attachElements(climbobject,source,0,.38,0)
	
	setElementData(source,"climb_object",climbobject,false);
	setElementAlpha(climbobject,0);
	setPedAnimation(source);
	setTimer(function(ped)
		setPedAnimation(ped,"bmx","BMX_pedal",-1,true,false,false,false,200);
	end,200,1,source)

	setPedAnimationProgress(source,"BMX_pedal",0.8);
	animLock(source);
	setPedRotation(source,wallangle);
end
addEvent("onPlayerStartClimb",true)
addEventHandler("onPlayerStartClimb",root,startclimb)

function stopclimb()
	setPedAnimation(source);
	local climbobject=getElementData(source,"climb_object");
	if(isElement(climbobject))then
		destroyElement(climbobject);
	end
end
addEvent("onPlayerStopClimb",true)
addEventHandler("onPlayerStopClimb",root,stopclimb)

function moveclimb(direction)
	if(direction=="up")then
		setPedAnimation(source,"bmx","BMX_pedal",-1,true,true,false,false);
	elseif(direction=="down")then
		setPedAnimation(source,"biked","BIKEd_pushes",-1,true,true,false,false);
	end
end
addEvent("onPlayerMoveClimb",true)
addEventHandler("onPlayerMoveClimb",root,moveclimb)

function resetwallanim()
	local climbobject=getElementData(source,"climb_object");
	if(isElement(climbobject))then
		setPedAnimation(source,"bmx","BMX_pedal",100,false,false,true,true,100);
	end
end
addEvent("onPlayerStayClimb",true)
addEventHandler("onPlayerStayClimb",root,resetwallanim)

function roofclimb()
	local climbobject=getElementData(source,"climb_object");
	if(isElement(climbobject))then
		setPedAnimation(source,"ped","CLIMB_Stand",-1,false,true,false,false);
		setTimer(roofland,900,1,source);
	end
end
addEvent("onPlayerRoofClimb",true)
addEventHandler("onPlayerRoofClimb",root,roofclimb)

function roofland(player)
	local climbobject=getElementData(player,"climb_object");
	if(isElement(climbobject))then
		destroyElement(climbobject);
	end
	setPedAnimation(player);
end

function rotateclimb(angle)
	local climbobject=getElementData(source,"climb_object")
	if(isElement(climbobject))then
		setElementRotation(source,0,0,angle);
	end
end
addEvent("onPlayerRotateClimb",true)
addEventHandler("onPlayerRotateClimb",root,rotateclimb)


function toggleSit(thePlayer)
	if not getElementData(thePlayer, "sitting") then
		setPedAnimation(thePlayer, "ped", "seat_down", -1, false, false, false, true)
		setElementData(thePlayer, "sitting", true)
	else
		setPedAnimation(thePlayer)
		removeElementData(thePlayer, "sitting")
	end
end
addCommandHandler("sit",toggleSit)