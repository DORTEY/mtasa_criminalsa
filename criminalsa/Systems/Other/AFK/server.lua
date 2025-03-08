addRemoteEvents{"AFK:S"};--addEvent


addEventHandler("AFK:S",root,function(status)
    if(client and isElement(client)and getElementType(client)=="player" and isLoggedin(client))then
        if(status)then
            if(not AFK.ByPass[getPlayerSerial(client)])then
                setElementData(client,"Player:Data:isAFK",true);
            end
        else
            removeElementData(client,"Player:Data:isAFK");
        end
    end
end)