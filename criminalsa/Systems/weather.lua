addRemoteEvents{"Weather:Sync:C"};--addEvent


addEventHandler("Weather:Sync:C",root,function(id)
    setWeather(tonumber(id));
end)