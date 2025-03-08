addRemoteEvents{"Job:Logistic:C","Job:Logistic:Cooldown:C"};--addEvents


local Markers={};
local Timer={};
local Col,ColRoute=nil,nil;
local CurrentLocation=nil;
local Marker,MarkerRoute=nil,nil;


addEventHandler("Job:Logistic:C",root,function(type,type2)
    if(not(isLoggedin()))then
		return;
	end
	if(isPedDead(localPlayer))then
		return;
	end

    CurrentLocation=type2;

    local PlayerJobLevel=tonumber(getPlayerJsonValue(localPlayer,"Levels","JobLogisticLVL"))or 1;

    if(type=="start")then
        if(PlayerJobLevel==1)then
            if(not(Col))then
                Col=createColSphere(1677.1,692.1,12,120);

                addEventHandler("onClientColShapeLeave",Col,function(elem,dim)
                    if(elem==localPlayer and dim and source)then
                        triggerServerEvent("Job:Logistic:S",localPlayer,"stop");
                    end
                end);

                for i=1,#Jobs["Logistic"].Positions[CurrentLocation][PlayerJobLevel],1 do
                    Markers[i]=createMarker(Jobs["Logistic"].Positions[CurrentLocation][PlayerJobLevel][i][1],Jobs["Logistic"].Positions[CurrentLocation][PlayerJobLevel][i][2],Jobs["Logistic"].Positions[CurrentLocation][PlayerJobLevel][i][3]-1,"cylinder",1.2,200,200,0,70);
                    setElementDimension(Markers[i],0);
                    setElementInterior(Markers[i],0);
                    setElementData(Markers[i],"Marker:Data:Rot",Jobs["Logistic"].Positions[CurrentLocation][PlayerJobLevel][i][4]);

                    addEventHandler("onClientMarkerHit",Markers[i],function(elem,dim)
                        if(elem==localPlayer and dim and source)then
                            if(not isPedInVehicle(localPlayer))then
                                if(not(isTimer(Timer[source])))then
                                    triggerServerEvent("Job:Logistic:Bindkey",localPlayer,true,"pickup");
                                    setElementData(localPlayer,"Player:Data:Marker",getElementData(source,"Marker:Data:Rot"));
                                    Marker=source;
                                else
                                    triggerEvent("Notify:UI",localPlayer,loc(localPlayer,"Job:MarkerNotReady"),"warning",4000);
                                end
                            end
                        end
                    end)
                    addEventHandler("onClientMarkerLeave",Markers[i],function(elem,dim)
                        if(elem==localPlayer and dim and source)then
                            triggerServerEvent("Job:Logistic:Bindkey",localPlayer,false,"pickup");
                            Marker=nil;
                        end
                    end)
                end
            end
        end
        if(PlayerJobLevel==2)then
            if(not(Col))then
                Col=createColSphere(1677.1,692.1,12,120);

                addEventHandler("onClientColShapeLeave",Col,function(elem,dim)
                    if(elem==localPlayer and dim and source)then
                        triggerServerEvent("Job:Logistic:S",localPlayer,"stop");
                    end
                end)
            end
            loadForkliftBoxes();
        end
    end

    if(type=="route")then
        if(PlayerJobLevel==1)then--Packages
            if(isElement(MarkerRoute))then
                destroyElement(MarkerRoute);
                MarkerRoute=nil;
            end

            local Random=math.random(1,#Jobs["Logistic"].DeliverPositions[CurrentLocation][PlayerJobLevel]);
            MarkerPOS=Jobs["Logistic"].DeliverPositions[CurrentLocation][PlayerJobLevel][Random];

            MarkerRoute=createMarker(MarkerPOS[1],MarkerPOS[2],MarkerPOS[3],"cylinder",2,220,220,0,120);
            setElementDimension(MarkerRoute,0);
            setElementInterior(MarkerRoute,0);
            setElementData(MarkerRoute,"Marker:Data:Rot",MarkerPOS[4]);

            addEventHandler("onClientMarkerHit",MarkerRoute,function(elem,dim)
                if(elem==localPlayer and dim and source)then
                    if(not isPedInVehicle(localPlayer))then
                        triggerServerEvent("Job:Logistic:Bindkey",localPlayer,true,"deliver");
                        setElementData(localPlayer,"Player:Data:Marker",getElementData(source,"Marker:Data:Rot"));
                    end
                end
            end)
            addEventHandler("onClientMarkerLeave",MarkerRoute,function(elem,dim)
                if(elem==localPlayer and dim and source)then
                    if(not isPedInVehicle(localPlayer))then
                        triggerServerEvent("Job:Logistic:Bindkey",localPlayer,false,"deliver");
                    end
                end
            end)
        end
        if(PlayerJobLevel==2)then--Forklift
            local Random=math.random(1,#Jobs["Logistic"].DeliverPositions[CurrentLocation][PlayerJobLevel]);
            MarkerPOS=Jobs["Logistic"].DeliverPositions[CurrentLocation][PlayerJobLevel][Random];

            MarkerRoute=createMarker(MarkerPOS[1],MarkerPOS[2],MarkerPOS[3],"cylinder",2.5,220,220,0,120);
            ColRoute=createColSphere(MarkerPOS[1],MarkerPOS[2],MarkerPOS[3]+1,2);

            addEventHandler("onClientColShapeHit",ColRoute,function(elem,dim)
                if(elem==localPlayer and dim and source)then
                    if(isPedInVehicle(localPlayer))then
                        local veh=getPedOccupiedVehicle(localPlayer);
					    if(veh)then
                            if(getElementData(veh,"Vehicle:Data:VehID")==Jobs["Logistic"].Vehicle[PlayerJobLevel][1])then
                                Object=nil;
                                for _,v in pairs(getElementsWithinColShape(source,"object"))do
                                    if(getElementData(v,"Object:Data:Owner")==getPlayerName(localPlayer))then
                                        Object=v;
                                    end
                                end

                                if(Object)then
                                    if(getElementParent(Object))then
                                        destroyElement(getElementParent(Object));
                                    end
                                    triggerServerEvent("Job:Logistic:S",localPlayer,"reward");
                                end
                            end
                        end
                    end
                end
            end)
        end
    end

    if(type=="stop")then
        if(isElement(Col))then
            destroyElement(Col);
            Col=nil;
        end
        destroyForkliftBoxes();
    end
end)

addEventHandler("Job:Logistic:Cooldown:C",root,function()
    if(Marker)then
        if(not(isTimer(Timer[Marker])))then
            setMarkerColor(Marker,220,0,0,120);
            Timer[Marker]=setTimer(function(Marker)
                if(Marker)then
                    setMarkerColor(Marker,220,220,0,120);
                end
            end,2*60*1000,1,Marker);
        end
    end
end)



local BoxesTable={};
local BoxArrow={};
local Boxes={--objID, x,y,z,rot
    --
    {1558, 1702.1,675.6,10.54,0},
    {1558, 1702.1,677.4,10.54,0},
    {1558, 1702.1,679.2,10.54,0},
    {1558, 1702.1,681.0,10.54,0},
    {1558, 1702.1,682.8,10.54,0},
    {1558, 1702.1,684.6,10.54,0},

    {1558, 1702.1,675.6,11.84,0},
    {1558, 1702.1,677.4,11.84,0},
    {1558, 1702.1,679.2,11.84,0},
    {1558, 1702.1,681.0,11.84,0},
    {1558, 1702.1,682.8,11.84,0},
    {1558, 1702.1,684.6,11.84,0},
    --
    {1558, 1703.7,675.6,10.54,0},
    {1558, 1703.7,677.4,10.54,0},
    {1558, 1703.7,679.2,10.54,0},
    {1558, 1703.7,681.0,10.54,0},
    {1558, 1703.7,682.8,10.54,0},
    {1558, 1703.7,684.6,10.54,0},

    {1558, 1703.7,675.6,11.84,0},
    {1558, 1703.7,677.4,11.84,0},
    {1558, 1703.7,679.2,11.84,0},
    {1558, 1703.7,681.0,11.84,0},
    {1558, 1703.7,682.8,11.84,0},
    {1558, 1703.7,684.6,11.84,0},


    --
    {1558, 1711.3,675.6,10.54,0},
    {1558, 1711.3,677.4,10.54,0},
    {1558, 1711.3,679.2,10.54,0},
    {1558, 1711.3,681.0,10.54,0},
    {1558, 1711.3,682.8,10.54,0},
    {1558, 1711.3,684.6,10.54,0},

    {1558, 1711.3,675.6,11.84,0},
    {1558, 1711.3,677.4,11.84,0},
    {1558, 1711.3,679.2,11.84,0},
    {1558, 1711.3,681.0,11.84,0},
    {1558, 1711.3,682.8,11.84,0},
    {1558, 1711.3,684.6,11.84,0},
    --
    {1558, 1712.9,675.6,10.54,0},
    {1558, 1712.9,677.4,10.54,0},
    {1558, 1712.9,679.2,10.54,0},
    {1558, 1712.9,681.0,10.54,0},
    {1558, 1712.9,682.8,10.54,0},
    {1558, 1712.9,684.6,10.54,0},

    {1558, 1712.9,675.6,11.84,0},
    {1558, 1712.9,677.4,11.84,0},
    {1558, 1712.9,679.2,11.84,0},
    {1558, 1712.9,681.0,11.84,0},
    {1558, 1712.9,682.8,11.84,0},
    {1558, 1712.9,684.6,11.84,0},
}
function loadForkliftBoxes()
    for i,v in pairs(Boxes)do
        Boxes[i]=createObject(v[1],v[2],v[3],v[4],0,0,v[5]);
        BoxArrow[i]=createMarker(0,0,0,"arrow",0.5,220,220,0,100);

        setObjectBreakable(Boxes[i],false);
        attachElements(BoxArrow[i],Boxes[i],0,0,1.1);
        setElementParent(Boxes[i],BoxArrow[i]);

        setElementData(Boxes[i],"Object:Data:Owner",getPlayerName(localPlayer));

        table.insert(BoxesTable,{Boxes[i],BoxArrow[i]});
    end
end

function destroyForkliftBoxes()
    for i,v in pairs(BoxesTable)do
        if(v and isElement(v[1]))then--Boxes
            destroyElement(v[1]);
            Boxes[i]=nil;
        end
        if(v and isElement(v[2]))then--Arrows
            destroyElement(v[2]);
            BoxArrow[i]=nil;
        end
    end
end