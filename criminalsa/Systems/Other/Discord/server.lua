addRemoteEvents{"Logs:Screenshots",};--addEvents


addEventHandler("onPlayerResourceStart",root,function(theResource)
    if(theResource==resource)then
        triggerClientEvent(source,"addPlayerRichPresence",source,Server.Discord);
    end
end)