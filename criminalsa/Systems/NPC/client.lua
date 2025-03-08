-- addRemoteEvents{"Drugdealer:C",};--addEvents


-- local Markers={};
-- local Blips={};
-- local Object=nil;
-- local MarkerCount=0;
-- local Stage=0;
-- local StageType;


-- addEventHandler("Drugdealer:C",root,function(type)
--     if(MarkerCount==0)then--check if player doesnt have any deliver markers to start
--         local Random=math.random(1,#Bots_Drugdealer[type].Positions);
       
--         Stage=Random;
--         StageType=type;

--         MarkerCount=0;

--         for i=1,#Bots_Drugdealer[type].Positions[Random],1 do
--             Markers[i]=createMarker(Bots_Drugdealer[type].Positions[Random][i][1],Bots_Drugdealer[type].Positions[Random][i][2],Bots_Drugdealer[type].Positions[Random][i][3]-1,"cylinder",1.2,200,200,0,70);
--             setElementDimension(Markers[i],0);
--             setElementInterior(Markers[i],0);

--             Blips[Markers[i]]=createBlip(Bots_Drugdealer[type].Positions[Random][i][1],Bots_Drugdealer[type].Positions[Random][i][2],Bots_Drugdealer[type].Positions[Random][i][3],0,22,220,220,0,255,0);
--             setElementData(Blips[Markers[i]],"Blip:Data:Tooltip",loc(localPlayer,"Rob:Deliver:3DText"));

--             MarkerCount=i;

--             addEventHandler("onClientMarkerHit",Markers[i],function(hitElem,dim)
--                 if(hitElem==localPlayer and dim and source)then
--                     if(getElementInterior(localPlayer)==getElementInterior(source)and getElementDimension(localPlayer)==getElementDimension(source))then
--                         if(not(isPedInVehicle(localPlayer)))then
--                             local x,y,z=getElementPosition(localPlayer);
--                             local x1,y1,z1=getElementPosition(source);
                            
--                             if(getDistanceBetweenPoints3D(x,y,z,x1,y1,z1)<=1.8)then
--                                 if(isPedOnGround(localPlayer))then
--                                     destroyElement(source);
--                                     destroyElement(Blips[source]);
                                    
--                                     MarkerCount=MarkerCount-1;

--                                     if(isElement(Object))then
--                                         destroyElement(Object);
--                                         Object=nil;
--                                     end
                                    
--                                     Object=createObject(1279,0,0,0);
--                                     setElementInterior(Object,getElementInterior(localPlayer));
--                                     setElementDimension(Object,getElementDimension(localPlayer));

--                                     setElementCollisionsEnabled(Object,false);
--                                     attachElementToBone(Object,localPlayer,12,-0.05,0.02,0.02,20,-50,-10);

--                                     if(MarkerCount==0)then
--                                         triggerServerEvent("Drugdealer:S",localPlayer,StageType,Stage);

--                                         setTimer(function()
--                                             if(isElement(Object))then
--                                                 destroyElement(Object);
--                                                 Object=nil;
--                                             end

--                                             Object=createObject(1279,x1,y1,z1,getElementRotation(localPlayer));
--                                             setElementCollisionsEnabled(Object,false);
--                                         end,2500,1)
--                                     else
--                                         triggerServerEvent("Drugdealer:S",localPlayer);

--                                         setTimer(function()
--                                             if(isElement(Object))then
--                                                 destroyElement(Object);
--                                                 Object=nil;
--                                             end

--                                             Object=createObject(1279,x1,y1,z1,getElementRotation(localPlayer));
--                                             setElementCollisionsEnabled(Object,false);
--                                         end,2500,1)
--                                     end

--                                 end
--                             end
--                         end
--                     end
--                 end
--             end)
--         end
--     end
-- end)