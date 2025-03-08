addRemoteEvents{"SkinShop:Buy:S"};--addEvents


local CurrentShop={};
local AbleToBuy={};
local AbleToBuy2={};

local ShopPrice={};
local UsedCoupon={};


local function interact(elem)
	if(elem and isElement(elem)and getElementType(elem)=="player" and isLoggedin(elem))then
		triggerClientEvent(elem,"SkinShop:UI",elem,true,CurrentShop[elem],os.time());
        triggerClientEvent(elem,"HelpNotify:UI",elem,nil);
	end
end

addEventHandler("onResourceStart",resourceRoot,function()
    for i,v in pairs(SkinShops)do
        local Marker=createMarker(SkinShops[i].Marker[1],SkinShops[i].Marker[2],SkinShops[i].Marker[3],SkinShops[i].Marker[4],SkinShops[i].Marker[5],SkinShops[i].Marker[6],SkinShops[i].Marker[7],SkinShops[i].Marker[8],SkinShops[i].Marker[9]);

        if(SkinShops[i].Blip)then
            local Blip=createBlip(SkinShops[i].Blip[1],SkinShops[i].Blip[2],SkinShops[i].Blip[3],SkinShops[i].Blip[4],22,SkinShops[i].Blip[5],SkinShops[i].Blip[6],SkinShops[i].Blip[7],255,100);
            setElementData(Blip,"Blip:Data:Tooltip",SkinShops[i].Blip[8]);
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
                        CurrentShop[hitElem]=i;
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
end)

addEventHandler("SkinShop:Buy:S",root,function(skin,coupon)
    if(client and isElement(client)and getElementType(client)=="player" and isLoggedin(client))then
        if(not(skin))then
            return;
        end
        if(not(CurrentShop[client]))then
            return;
        end

        AbleToBuy[client]=false;
        AbleToBuy2[client]=true;
        UsedCoupon[client]=false;
        
        if(coupon~="none")then
            if(getPlayerJsonValue(client,"Items",tostring(coupon))>0)then
                AbleToBuy2[client]=true;
                UsedCoupon[client]=true;
                ShopPrice[client]=SkinShopsSettings.Prices[tonumber(skin)]-SkinShopsSettings.Prices[tonumber(skin)]/100*tonumber(Items[tostring(coupon)].Percentage);
            else
                AbleToBuy2[client]=false;
                UsedCoupon[client]=false;
                ShopPrice[client]=SkinShopsSettings.Prices[tonumber(skin)];
            end
        else
            AbleToBuy2[client]=true;
            UsedCoupon[client]=false;
            ShopPrice[client]=SkinShopsSettings.Prices[tonumber(skin)];
        end

        local jsonWardrobeSkins=getPlayerJsonTable(client,"PedSkins");
        if(#jsonWardrobeSkins>=Hideout.Wardrobe.Benefits[tonumber(getPlayerJsonValue(client,"HideUpgrades","Wardrobe"))].max)then
            triggerClientEvent(client,"Notify:UI",client,loc(client,"S:ShopSkin:LimitReached"):format(Hideout.Wardrobe.Benefits[tonumber(getPlayerJsonValue(client,"HideUpgrades","Wardrobe"))].max),"error",5000);
            return;
        end

        if(getPlayerJsonValue(client,"Money","Cash")<ShopPrice[client])then
            triggerClientEvent(client,"Notify:UI",client,loc(client,"S:ShopSkin:NotEnoughCash"):format(getPlayerJsonValue(client,"Money","Cash"),ShopPrice[client]),"error",5000);
            return;
        end

        for i,v in pairs(SkinShops[CurrentShop[client]].Skins)do
            if(tonumber(v.ID)==tonumber(skin))then
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
            if(AbleToBuy2[client])then
                local typOld=getElementData(client,"Skin");

                local isCustomOld,_,elementTypeOld=exports[RESOURCE_NEWMODELS]:isCustomModID(typOld);
                if(isCustomOld)then
                    local dataName2=exports[RESOURCE_NEWMODELS]:getDataNameFromType(elementTypeOld);
                    removeElementData(client,dataName2);
                end
                local isCustom,mod,elementType=exports[RESOURCE_NEWMODELS]:isCustomModID(tonumber(skin));
                if(isCustom)then
                    local dataName=exports[RESOURCE_NEWMODELS]:getDataNameFromType(elementType);
                    removeElementData(client,dataName);
                    setElementData(client,dataName,mod.id);
                else
                    setElementModel(client,tonumber(skin));
                end
                
                setElementData(client,"Skin",tonumber(skin));


                --add wardrobe skins
                if(jsonWardrobeSkins and type(jsonWardrobeSkins)=="table")then
                    for shop,_ in pairs(SkinShops)do
                        for _,data in pairs(SkinShops[shop].Skins)do
                            if(tonumber(data.ID)==tonumber(skin))then
                                table.insert(jsonWardrobeSkins,{skin,data.Name});
                                break;
                            end
                        end
                    end

                    setElementData(client,"PedSkins",toJSON(jsonWardrobeSkins));
                end

                triggerClientEvent(client,"Notify:UI",client,loc(client,"S:ShopSkin:BoughtSkin"):format(skin,ShopPrice[client]),"success",5000);
                removePlayerJsonValue(client,"Money","Cash",ShopPrice[client]);
                if(UsedCoupon[client])then
                    removePlayerJsonValue(client,"Items",tostring(coupon),1);
                end
            end
        else
            triggerClientEvent(client,"Notify:UI",client,loc(client,"S:ShopSkin:LimitedItemExpired"),"warning",5000);
        end
    end
end)