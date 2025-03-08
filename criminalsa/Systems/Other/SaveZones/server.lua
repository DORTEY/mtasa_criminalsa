local Zones={--Pos[x,y,width,height] Showzone
    {Pos={2383.6,-1447.4,70,75},Showzone=true,CancelDamage=true,Rectangle=true,},--Hideout #1
    {Pos={808.1,-1309.3,122.5,149},Showzone=true,CancelDamage=true,Rectangle=true,},--Hideout #2
    {Pos={2606.4,-1099.5,31,31},CancelDamage=true,Rectangle=true,},--Trader #1
    {Pos={-1468.3,-1589.5,60,90},CancelDamage=true,Rectangle=true,},--Trader #2
    {Pos={1577.7,663.1,179.5,120},Showzone=true,CancelDamage=true,Rectangle=true,},--Logistic (Job)
    {Pos={1525.6,-1293.1,75,75},CancelDamage=true,Rectangle=true,},--Vehicleshop LS
    {Pos={944.1,-2227.1,50,50},CancelDamage=true,Rectangle=true,},--Vehicleshop LS (Airport)

    {Pos={-905.5,-2119.2,150,300},CancelDamage=false,Rectangle=true,},--Mining #1
    {Pos={-2046.4,-1409.1,20.0,70},CancelDamage=false,Rectangle=false,},--Mining #2 (1)
    {Pos={-2215.3,-1227.5,10.0,80},CancelDamage=false,Rectangle=false,},--Mining #2 (2)
    {Pos={-1482.4,-2382.2,240,220},CancelDamage=false,Rectangle=true,},--Orange collector
    {Pos={-1868.6,-2327.6,220,220},CancelDamage=false,Rectangle=true,},--Apple collector
    {Pos={-625.1,-1557.9,280,180},CancelDamage=false,Rectangle=true,},--Pear collector
    {Pos={-184.3,-2767.9,125,190},CancelDamage=false,Rectangle=true,},--Coconut collector
}
local Zone={};
local ZoneID={};

addEventHandler("onResourceStart",resourceRoot,function()
    for id,v in pairs(Zones)do
        if(v.Rectangle)then
            Zone[id]=createColRectangle(v.Pos[1],v.Pos[2],v.Pos[3],v.Pos[4]);
        else
            Zone[id]=createColSphere(v.Pos[1],v.Pos[2],v.Pos[3],v.Pos[4]);
        end
        ZoneID[Zone[id]]=tonumber(id);

        if(v.CancelDamage)then
            setElementData(Zone[id],"Col:Data:Savezone",true);
        else
            setElementData(Zone[id],"Col:Data:Savezone2",true);
        end

        if(v.Showzone)then
            createRadarArea(v.Pos[1],v.Pos[2],v.Pos[3],v.Pos[4],0,255,0,100,root);
        end

        addEventHandler("onColShapeHit",Zone[id],function(hitElem)
            if(hitElem and isElement(hitElem)and getElementType(hitElem)=="player" and isLoggedin(hitElem))then
                if(getElementDimension(hitElem)==getElementDimension(source)and getElementInterior(hitElem)==getElementInterior(source))then
                    if(Zones[ZoneID[source]].CancelDamage)then
                        triggerClientEvent(hitElem,"Savezone:UI",hitElem,true);
                    end
                    setElementData(hitElem,"Player:Data:Savezone",true);
                end
            end
            if(hitElem and isElement(hitElem)and getElementType(hitElem)=="vehicle")then
                if(getElementHealth(hitElem)>255)then
                    setVehicleDamageProof(hitElem,true);
                    setElementData(hitElem,"Vehicle:Data:Savezone",true);
                end
            end
        end)
        
        addEventHandler("onColShapeLeave",Zone[id],function(hitElem)
            if(hitElem and isElement(hitElem)and getElementType(hitElem)=="player")then
                if(getElementDimension(hitElem)==getElementDimension(source))then
                    triggerClientEvent(hitElem,"Savezone:UI",hitElem);
                    removeElementData(hitElem,"Player:Data:Savezone");
                end
            end
            if(hitElem and isElement(hitElem)and getElementType(hitElem)=="vehicle")then
                setVehicleDamageProof(hitElem,false);
                removeElementData(hitElem,"Vehicle:Data:Savezone");
            end
        end)
    end
end)