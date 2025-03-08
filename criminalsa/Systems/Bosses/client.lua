addRemoteEvents{"Bosses:Load:Bots:C"};--addEvents


local BotDoesntshootChance=35;
local PEDS={};
addEventHandler("Bosses:Load:Bots:C",root,function(type,tbl)
    if(type)then
        for i,v in pairs(tbl)do
            table.insert(PEDS,{v[2],v[3], v[1]});
        end
    else
        PEDS={};
    end
end)

addEventHandler("onClientRender",root,function()
    if(not(isLoggedin()))then
        return;
    end

    local x,y,z=getPedBonePosition(localPlayer,8);

    for _,v in pairs(PEDS)do
        if(v[1] and isElement(v[1]))then
            local x1,y1,z1=getPedBonePosition(v[1],8);

            if(Server.Settings.BOTs)then
                if(getDistanceBetweenPoints3D(x,y,z,x1,y1,z1)<=v[2])then
                    if(isLineOfSightClear(x,y,z,x1,y1,z1,true,false,false,true,false,true,false))then
                        if(isPedDead(localPlayer)or isPedDead(v[1]))then
                            setPedControlState(v[1],"fire",false);
                            setPedControlState(v[1],"aim_weapon",false);
                        else
                            if(isPedDucked(localPlayer))then
                                setPedAimTarget(v[1],x,y,z-.5);
                            else
                                setPedAimTarget(v[1],x,y,z+0.6);
                            end
                            if(math.random(1,100)<=BotDoesntshootChance)then
                                setPedControlState(v[1],"fire",false);
                                setPedControlState(v[1],"aim_weapon",false);
                            else
                                setPedControlState(v[1],"fire",true);
                                setPedControlState(v[1],"aim_weapon",true);
                            end

                            local rotZ=findRotation(x1,y1, x,y);
                            setElementRotation(v[1],0,0,rotZ);
                        end
                    else
                        setPedControlState(v[1],"fire",false);
                        setPedControlState(v[1],"aim_weapon",false);
                    end
                else
                    setPedControlState(v[1],"fire",false);
                    setPedControlState(v[1],"aim_weapon",false);
                end
            end
        end
    end
end)