addRemoteEvents{"Logs:Screenshots",};--addEvents


addEventHandler("onPlayerResourceStart",root,function(theResource)
    if(theResource==resource)then
        triggerClientEvent(source,"addPlayerRichPresence",source,Server.Discord);
    end
end)


--[[ addEventHandler("Logs:Screenshots",root,function()
    print("alo")
    takePlayerScreenShot(client,1920,1080,"logs",50,10000,400);
end)

addEventHandler("onPlayerScreenShot",root,function(resource,status,pixels,timestamp,tag)
    if(status=="ok")then
        print("koks")
        sendDiscordMessage(10,getPlayerName(source).." took a screenshot!",{pixels});
    end
end) ]]