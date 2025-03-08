addRemoteEvents{"Savezone:UI"};--addEvents


local alpha=0;
local unrender=false;

function openSavezone()
	if(alpha<1 and unrender==false)then
		alpha=alpha+0.01;
	elseif(alpha>0 and unrender==true)then
		alpha=alpha-0.01;
	elseif(alpha==0 and unrender==true)then
		removeEventHandler("onClientRender",root,openSavezone)
		unrender=false;
	end
	if(isPlayerMapVisible(localPlayer)==true)then
		return;
	end
	if(isPedDead(localPlayer))then
		return;
	end
    if(isClickedState(localPlayer)==true)then
        return;
    end
    if(HUD_TOGGLE)then
		return;
	end

	dxDrawRectangle(0*Gsx,380*Gsy,300*Gsx,90*Gsy,tocolor(180,40,40,100*alpha),false);
	dxDrawText(loc(localPlayer,"Savezone:Title"),260*Gsx,390*Gsy,30*Gsx,30*Gsy,tocolor(255,255,255,255*alpha),1.70*Gsx,"default-bold","center",_,_,_,false,_,_);
	dxDrawText(loc(localPlayer,"Savezone:Text"),260*Gsx,430*Gsy,30*Gsx,30*Gsy,tocolor(255,255,255,255*alpha),1.15*Gsx,"default-bold","center");
end

addEventHandler("Savezone:UI",root,function(type)
	if(type)then--appear
		if(unrender==true and alpha~=0)then
			unrender=false;
		else
			unrender=false;
			removeEventHandler("onClientRender",root,openSavezone);
			addEventHandler("onClientRender",root,openSavezone);
		end
	else--disappear
		unrender=true;
	end
end)


















local function handleColShapeHit(colshape,element,matchingDimension)
    if(matchingDimension and getElementData(colshape,"Col:Data:Savezone")or matchingDimension and getElementData(colshape,"Col:Data:Savezone2"))then
        if(not isElement(element))then
            return;
        end
        if(element==localPlayer)then
            setCameraClip(true,false);
        end

        if(element.type=="player" or element.type=="vehicle")then
            for i,e in ipairs(colshape:getElementsWithin("player"))do
                if(e and isElement(e))then
                    element:setCollidableWith(e,false);
                end
            end
            for i,e in ipairs(colshape:getElementsWithin("vehicle"))do
                if(e and isElement(e))then
                    element:setCollidableWith(e,false);
                end
            end
        end
    end
end

local function handleColShapeOut(colshape,element,matchingDimension)
    if(matchingDimension and getElementData(colshape,"Col:Data:Savezone")or matchingDimension and getElementData(colshape,"Col:Data:Savezone2"))then
        if(element==localPlayer)then
            setCameraClip(true,true);
        end
        if(not isElement(element))then
            return;
        end

        local elementType=getElementType(element);
        if(elementType and elementType=="player" or elementType=="vehicle")then
            for i,e in ipairs(colshape:getElementsWithin("player"))do
                element:setCollidableWith(e,true);
            end
            for i,e in ipairs(colshape:getElementsWithin("vehicle"))do
                element:setCollidableWith(e,true);
            end
        end
    end
end

addEventHandler("onClientColShapeLeave",resourceRoot,function(element,matchingDimension)
    handleColShapeOut(source,element,matchingDimension)
end)

addEventHandler("onClientColShapeHit",resourceRoot,function(element,matchingDimension)
    handleColShapeHit(source,element,matchingDimension)
end)

function leaveSafeZones()
    for _, v in ipairs(getElementsByType("colshape"))do
        for _,vv in ipairs(getElementsWithinColShape(v))do
            handleColShapeOut(v,vv,true);
        end
    end
end

for _,v in ipairs(getElementsByType("colshape"))do
    for _,vv in ipairs(getElementsWithinColShape(v))do
        handleColShapeHit(v,vv,vv.dimension==v.dimension);
    end
end