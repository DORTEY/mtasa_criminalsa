addRemoteEvents{"Trader:BuySell:S"};--addEvents


local CurrentTrader={};
local AbleToBuy={};


local function interact(elem)
	if(elem and isElement(elem)and getElementType(elem)=="player" and isLoggedin(elem))then
		triggerClientEvent(elem,"Trader:UI",elem,true,CurrentTrader[elem],os.time());
        triggerClientEvent(elem,"HelpNotify:UI",elem,nil);
	end
end

addEventHandler("onResourceStart",resourceRoot,function()
    for trader,v in pairs(Traders)do
        local isCustom,mod,elementType=exports[RESOURCE_NEWMODELS]:isCustomModID(tonumber(Traders[trader].Ped[1]));
		if(isCustom)then--check custom skin
			Ped=createPed(mod.base_id,Traders[trader].Ped[2],Traders[trader].Ped[3],Traders[trader].Ped[4],Traders[trader].Ped[5]);

			local dataName=exports[RESOURCE_NEWMODELS]:getDataNameFromType(elementType);
			setElementData(Ped,dataName,mod.id);
		else
			Ped=createPed(Traders[trader].Ped[1],Traders[trader].Ped[2],Traders[trader].Ped[3],Traders[trader].Ped[4],Traders[trader].Ped[5]);

			setElementModel(Ped,tonumber(Traders[trader].Ped[1]));
		end
        setElementFrozen(Ped,true);
        setElementData(Ped,"Ped:Data:Godmode",true);
        setElementData(Ped,"Ped:Data:Title",Traders[trader].Ped[7]);

        local x1,y1,z1=getPositionInFrontOfElement(Ped,tonumber(Traders[trader].Ped[6]));
        local Marker=createMarker(x1,y1,z1-1,"cylinder",1.3,0,240,255,80);

        if(Traders[trader].Blip)then
            local Blip=createBlip(Traders[trader].Blip[1],Traders[trader].Blip[2],Traders[trader].Blip[3],Traders[trader].Blip[4],22,Traders[trader].Blip[5],Traders[trader].Blip[6],Traders[trader].Blip[7],255,100);
            setElementData(Blip,"Blip:Data:Tooltip",Traders[trader].Blip[8]);
        end

        addEventHandler("onMarkerHit",Marker,function(hitElem,dim)
			if(hitElem and isElement(hitElem)and getElementType(hitElem)=="player" and isLoggedin(hitElem))then
                if(not(isPedInVehicle(hitElem)))then
                    if(getElementInterior(hitElem)==getElementInterior(source)and getElementDimension(hitElem)==getElementDimension(source))then
                        if(not isKeyBound(hitElem,Server.MainInteractionKey,"down",interact))then
                            bindKey(hitElem,Server.MainInteractionKey,"down",interact);
                        end
                        toggleGhostMode(hitElem,true,9000000);
                        triggerClientEvent(hitElem,"HelpNotify:UI",hitElem,true,Server.MainInteractionKey,loc(hitElem,"UI:HelpNotify:PressToOpen:General"));
                        CurrentTrader[hitElem]=trader;

                        if(not(getPlayerNotExistingJsonValue(hitElem,"Levels","Trader"..trader.."LVL")))then--set if element data doesnt exist
                            setPlayerJsonValue(hitElem,"Levels","Trader"..trader.."LVL",1);
                            setPlayerJsonValue(hitElem,"Levels","Trader"..trader.."EXP",0);
                        end
                    end
                end
            end
        end)
        addEventHandler("onMarkerLeave",Marker,function(hitElem,dim)
			if(hitElem and isElement(hitElem)and getElementType(hitElem)=="player")then
                if(isKeyBound(hitElem,Server.MainInteractionKey,"down",interact))then
                    unbindKey(hitElem,Server.MainInteractionKey,"down",interact);
                end
                toggleGhostMode(hitElem,false,0);
                triggerClientEvent(hitElem,"HelpNotify:UI",hitElem,nil);
            end
        end)
    end
    for item,price in pairs(TraderSettings.Prices)do
        Price=math.random(price[1],price[2]);
        setElementData(root,"Trader:Price:"..item,Price);
    end
end)


addEventHandler("Trader:BuySell:S",root,function(type,item,amount)
    if(client and isElement(client)and getElementType(client)=="player" and isLoggedin(client))then
        if(not(type))then
            return;
        end
        if(not(item))then
            return;
        end
        if(not(amount))then
            return;
        end
        if(tonumber(amount)<1)then
            return;
        end
        if(not(CurrentTrader[client]))then
            return;
        end

        if(type=="buy")then
            if(getPlayerJsonValue(client,"Money","Cash")>=tonumber(amount)*getElementData(root,"Trader:Price:"..item))then
                AbleToBuy[client]=false;

                for i,v in pairs(Traders[CurrentTrader[client]].Items)do
                    if(v.Item==tostring(item))then
                        if(v.Limited and os.time()>=tonumber(v.Limited))then
                            AbleToBuy[client]=false;
                        else
                            AbleToBuy[client]=true;
                        end
                        break;
                    else
                        AbleToBuy[client]=false;
                    end
                end

                if(AbleToBuy[client])then
                    if(item=="Crowbar")then
                        triggerEvent("Tutorial:NextStep",client,client,"MarketCrowbar");
                    end
                    if(item=="Pickaxe")then
                        triggerEvent("Tutorial:NextStep",client,client,"MarketPickaxe");
                    end
                    if(item:find("Weapon_"))then
                        if(getPlayerJsonValue(client,"Items",tostring(item))<1)then
                            addPlayerJsonValue(client,"Items",tostring(item),tonumber(1));
                            removePlayerJsonValue(client,"Money","Cash",getElementData(root,"Trader:Price:"..item));
                            triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Trader:BoughtItem"):format(loc(client,"Item:"..item),getElementData(root,"Trader:Price:"..item)),"success",5000);
                            
                            --level
                            updateTraderLevelstuff(client,CurrentTrader[client],tonumber(1));

                            --logs
                            sendDiscordMessage({
                                ID=5, Title="Weapon skin", Desc=getPlayerName(client).." has bought a weapon skin ("..item..")",
                                PlayerData={Name=getPlayerName(client),Serial=getPlayerSerial(client),},
                            })
                        else
                            triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Trader:AlreadyOwnSkin"):format(loc(client,"Item:"..item)),"error",5000);
                        end
                    else
                        if(Items[tostring(item)].MaxAmount and getPlayerJsonValue(client,"Items",tostring(item))+tonumber(amount)>Items[tostring(item)].MaxAmount)then
                            triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Trader:MaxAmount"):format(loc(client,"Item:"..item),Items[tostring(item)].MaxAmount),"error",5000);
                            return;
                        end
                        addPlayerJsonValue(client,"Items",tostring(item),tonumber(amount));
                        removePlayerJsonValue(client,"Money","Cash",tonumber(amount)*getElementData(root,"Trader:Price:"..item));
                        triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Trader:BoughtItem"):format(loc(client,"Item:"..item),tonumber(amount)*getElementData(root,"Trader:Price:"..item)),"success",5000);
                    
                        --level
                        updateTraderLevelstuff(client,CurrentTrader[client],tonumber(amount));

                        --logs
                        sendDiscordMessage({
                            ID=5, Title="Item", Desc=getPlayerName(client).." has bought a "..item.." (x"..amount..")",
                            PlayerData={Name=getPlayerName(client),Serial=getPlayerSerial(client),},
                        })
                    end
                else
                    triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Trader:LimitedItemExpired"),"warning",5000);
                end
            else
                triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Trader:NotEnoughCash"):format(getPlayerJsonValue(client,"Money","Cash"),tonumber(amount)*getElementData(root,"Trader:Price:"..item)),"error",5000);
            end
        elseif(type=="sell")then
            if(getPlayerJsonValue(client,"Items",tostring(item))>=amount)then
                removePlayerJsonValue(client,"Items",tostring(item),amount);
                addPlayerJsonValue(client,"Money","Cash",tonumber(amount)*getElementData(root,"Trader:Price:"..item));

                triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Trader:SoldItem"):format(loc(client,"Item:"..item),tonumber(amount)*getElementData(root,"Trader:Price:"..item)),"success",5000);
            
                --level
                updateTraderLevelstuff(client,CurrentTrader[client],tonumber(amount));

                --logs
                sendDiscordMessage({
                    ID=5, Title="Item sell", Desc=getPlayerName(client).." has sold a "..item.." (x"..amount..") for "..tonumber(amount)*getElementData(root,"Trader:Price:"..item).."",
                    PlayerData={Name=getPlayerName(client),Serial=getPlayerSerial(client),},
                })
            else
                triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Trader:NotEnoughAmount"):format(loc(client,"Item:"..item)),"error",5000);
            end
        end
    end
end)


function updateTraderLevelstuff(player,trader,amount)
    if(player and isElement(player)and getElementType(player)=="player" and isLoggedin(player)and(not client or client==player))then
        if(trader and amount)then
            addPlayerJsonValue(player,"Levels","Trader"..trader.."EXP",tonumber(TraderSettings.Progress.GiveExp[tostring(trader)][getPlayerJsonValue(player,"Levels","Trader"..trader.."LVL")])*tonumber(amount));

            local PlayerLevel=getPlayerJsonValue(player,"Levels","Trader"..trader.."LVL")or 1;
            local PlayerExp=getPlayerJsonValue(player,"Levels","Trader"..trader.."EXP")or 0;

            if(TraderSettings.Progress.LevelExp[tostring(trader)][tonumber(PlayerLevel)]and PlayerExp>=TraderSettings.Progress.LevelExp[tostring(trader)][tonumber(PlayerLevel)])then
                addPlayerJsonValue(player,"Levels","Trader"..trader.."LVL",1);
                setPlayerJsonValue(player,"Levels","Trader"..trader.."EXP",0);

                outputChatBox("#ffffff"..loc(player,"S:Trader:LevelUp"):format(getPlayerJsonValue(player,"Levels","Trader"..trader.."LVL")),player,255,255,255,true);
                triggerClientEvent(player,"Notify:UI",player,loc(player,"S:Trader:LevelUp"):format(getPlayerJsonValue(player,"Levels","Trader"..trader.."LVL")),"info",10000);
            end
        end
    end
end