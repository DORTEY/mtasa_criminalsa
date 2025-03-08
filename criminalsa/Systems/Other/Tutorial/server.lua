addRemoteEvents{"Tutorial:NextStep"};--addEvents


addEventHandler("Tutorial:NextStep",root,function(player,step)
    if(player and isElement(player)and getElementType(player)=="player" and isLoggedin(player)and(not client or client==player))then
        if(Tutorial[getPlayerJsonValue(player,"Stats","Tutorial")])then
            if(Tutorial[getPlayerJsonValue(player,"Stats","Tutorial")].VerifiyNextStep and Tutorial[getPlayerJsonValue(player,"Stats","Tutorial")].VerifiyNextStep==tostring(step))then
                if(Tutorial[getPlayerJsonValue(player,"Stats","Tutorial")].VerifiyNextStep=="Market")then
                    addPlayerJsonValue(player,"Money","Cash",Tutorial[getPlayerJsonValue(player,"Stats","Tutorial")].Current.RewardMoney+getElementData(root,"Trader:Price:Crowbar"));
                else
                    addPlayerJsonValue(player,"Money","Cash",Tutorial[getPlayerJsonValue(player,"Stats","Tutorial")].Current.RewardMoney);
                end

                addPlayerJsonValue(player,"Stats","Tutorial",1);
                triggerClientEvent(player,"Tutorial:ShowStuff",player);

                triggerClientEvent(player,"Notify:UI",player,loc(player,"S:Tutorial:NextStep"),"success",5000);
            end
        end
    end
end)