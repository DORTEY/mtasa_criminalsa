local Count=0;
local Status=nil;


local function setAFK()
    if(Count>=AFK.MaxCount)then
        Count=0;
        Status=true;
        triggerServerEvent("AFK:S",localPlayer,Status);
    end
end


addEventHandler("onClientPreRender",root,function()
    if(not(isLoggedin()))then
        return;
    end
    if(isPedDead(localPlayer))then
        return;
    end
    if(AFK.ByPass[getPlayerSerial(localPlayer)])then
        return;
    end

    if(getKeyState("W")or getKeyState("A")or getKeyState("S")or getKeyState("D")or getKeyState("SPACE"))then
        if(isPedInVehicle(localPlayer))then
            local veh=getPedOccupiedVehicle(localPlayer,0);
			if(veh and isElement(veh))then
                if(getElementSpeed(veh,"km/h")>30)then
                    Count=0;
                    if(Status)then
                        Status=nil;
                        triggerServerEvent("AFK:S",localPlayer,Status);
                    end
                else
                    if(not(Status))then
                        Count=Count+1;
                        setAFK();
                    end
                end
            end
        else
            if(getElementSpeed(localPlayer,"km/h")>17)then
                Count=0;
                if(Status)then
                    Status=nil;
                    triggerServerEvent("AFK:S",localPlayer,Status);
                end
            else
                if(not(Status))then
                    Count=Count+1;
                    setAFK();
                end
            end
        end
    else
        if(not(Status))then
            Count=Count+1;
            setAFK();
        end
    end
end)