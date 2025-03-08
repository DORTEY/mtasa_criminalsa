addRemoteEvents{"SkinShop:UI","SkinShop:LoadDatas","SkinShop:Buy:C",
"SkinShop:Show:Rotate",
"SkinShop:SelectCoupon"};--addEvents


local CurrentShop=nil;
local PreviewElement,PreviewLight=nil,nil;
local SelectedCoupon=nil;
local SkinPrice=0;

local CEFTimer,BrowserUI,Browser=nil,nil,nil;


addEventHandler("SkinShop:UI",root,function(type,shop,timestamp)
    if(not(isLoggedin()))then
		return;
	end
	if(isPedDead(localPlayer))then
		return;
	end

    if(type)then
		if(not(CEFready))then
            return;
        end

        if(isClickedState(localPlayer)==true)then
            return;
        end
        
        setUIdatas("set","cursor");
        if(not(isTimer(CEFTimer)))then
            BrowserUI=guiCreateBrowser(0,0,GLOBALscreenX,GLOBALscreenY,true,true,false,nil);
            Browser=guiGetBrowser(BrowserUI);

            addEventHandler("onClientBrowserCreated",Browser,function()
                loadBrowserURL(Browser,"http://mta/local/Files/UI/ShopSkin/main.html");
                focusBrowser(Browser);

                addEventHandler("onClientBrowserDocumentReady",BrowserUI,function(url)
                    executeBrowserJavascript(Browser,"setLanguageShopSkin('"..Server.Name.."','"..loc(localPlayer,"UI:ShopSkin:Title").."','"..loc(localPlayer,"UI:ShopSkin:SearchBar").."','"..loc(localPlayer,"UI:ShopSkin:SelectCoupon").."',           '"..loc(localPlayer,"UI:ShopSkin:LeaveUI").."','"..loc(localPlayer,"UI:ShopSkin:Buy").."');");
                    setTimer(function()
                        for _,v in pairs(SkinShops[tostring(shop)].Skins)do
                            if(v.Limited)then
                                if(timestamp<=v.Limited)then
                                    executeBrowserJavascript(Browser,"loadSkinsInShopList('"..v.ID.."','"..v.Name.."','"..v.Icon.."','"..timestamp.."','"..tostring(v.OnlyInCrates).."');");
                                end
                            else
                                executeBrowserJavascript(Browser,"loadSkinsInShopList('"..v.ID.."','"..v.Name.."','"..v.Icon.."','0','"..tostring(v.OnlyInCrates).."');");
                            end
                        end
                    end,200,1);
                end)
            end)
        else
            if(isTimer(CEFTimer))then
                killTimer(CEFTimer);
                CEFTimer=nil;
            end
            guiSetVisible(BrowserUI,true);

            executeBrowserJavascript(Browser,"setLanguageShopSkin('"..Server.Name.."','"..loc(localPlayer,"UI:ShopSkin:Title").."','"..loc(localPlayer,"UI:ShopSkin:SearchBar").."','"..loc(localPlayer,"UI:ShopSkin:SelectCoupon").."',           '"..loc(localPlayer,"UI:ShopSkin:LeaveUI").."','"..loc(localPlayer,"UI:ShopSkin:Buy").."');");
            setTimer(function()
                for _,v in pairs(SkinShops[tostring(shop)].Skins)do
                    if(v.Limited)then
                        if(timestamp<=v.Limited)then
                            executeBrowserJavascript(Browser,"loadSkinsInShopList('"..v.ID.."','"..v.Name.."','"..v.Icon.."','"..timestamp.."','"..tostring(v.OnlyInCrates).."');");
                        end
                    else
                        executeBrowserJavascript(Browser,"loadSkinsInShopList('"..v.ID.."','"..v.Name.."','"..v.Icon.."','0','"..tostring(v.OnlyInCrates).."');");
                    end
                end
            end,200,1);
        end

        CurrentShop=shop;
        SelectedCoupon=nil;
	else
		setUIdatas("rem","cursor");
        if(isTimer(CEFTimer))then
            killTimer(CEFTimer);
            CEFTimer=nil;
        end
        CEFTimer=setTimer(function()
            if(isElement(BrowserUI))then
                destroyElement(BrowserUI);
                BrowserUI=nil;
            end
        end,30*1000,1)
		setUIdatas("rem","cursor");
        if(isElement(BrowserUI)and guiGetVisible(BrowserUI))then
            guiSetVisible(BrowserUI,false);
        end

        executeBrowserJavascript(Browser,"$('.NavbarItem').empty();");
        executeBrowserJavascript(Browser,"$('.ThirdUI').css('display','none');");
        executeBrowserJavascript(Browser,"$('.dropdown-item-list').empty();");

        CurrentShop=nil;
        SelectedCoupon=nil;

        if(isElement(PreviewElement))then
            destroyElement(PreviewElement);
            PreviewElement=nil;
        end
        if(isElement(PreviewLight))then
            destroyElement(PreviewLight);
            PreviewLight=nil;
        end
        setCameraTarget(localPlayer);
	end
end)

addEventHandler("SkinShop:LoadDatas",root,function(skin)
    if(not(isLoggedin()))then
		return;
	end
	if(isPedDead(localPlayer))then
		return;
	end
	if(isClickedState(localPlayer)==false)then
        return;
	end
    if(not guiGetVisible(BrowserUI))then
        return;
    end

    if(isElement(PreviewElement))then
        destroyElement(PreviewElement);
        PreviewElement=nil;
    end
    if(isElement(PreviewLight))then
        destroyElement(PreviewLight);
        PreviewLight=nil;
    end

    --datas
    for _,v in pairs(SkinShops[CurrentShop].Skins)do
        if(tonumber(v.ID)==tonumber(skin))then
            LimitedTime=v.Limited and v.Limited-SERVER_TIME or 0;

            if(SelectedCoupon)then
                SkinPrice=SkinShopsSettings.Prices[tonumber(skin)]-SkinShopsSettings.Prices[tonumber(skin)]/100*tonumber(Items[tostring(SelectedCoupon)].Percentage);
            else
                SkinPrice=SkinShopsSettings.Prices[tonumber(skin)];
            end
            executeBrowserJavascript(Browser,"showShopSkinDetails('"..skin.."','"..v.Name.."','"..comma_value(SkinPrice).."','"..LimitedTime.."','"..tostring(v.OnlyInCrates).."');");
            break;
        end
    end

    --coupons
    executeBrowserJavascript(Browser,"$('.dropdown-item-list').empty();");
    for item,amount in pairs(getPlayerJsonTable(localPlayer,"Items"))do
        if(amount and tonumber(amount)>0 and item:find("SkinCoupon"))then
            executeBrowserJavascript(Browser,"loadSkinshopCoupons('"..item.."','"..loc(localPlayer,"Item:"..item).." (x"..amount..")');");
        end
    end
    


    local CamX,CamY,CamZ,CamEndX,CamEndY,CamEndZ,pedROT=SkinShops[CurrentShop].Cam[1],SkinShops[CurrentShop].Cam[2],SkinShops[CurrentShop].Cam[3],SkinShops[CurrentShop].Cam[4],SkinShops[CurrentShop].Cam[5],SkinShops[CurrentShop].Cam[6],SkinShops[CurrentShop].Cam[7];
    
    local isCustom,mod,elementType=exports[RESOURCE_NEWMODELS]:isCustomModID(tonumber(skin));
	if(isCustom)then
		PreviewElement=createPed(mod.base_id,CamEndX,CamEndY,CamEndZ,pedROT);
		local dataName=exports[RESOURCE_NEWMODELS]:getDataNameFromType(elementType);
		setElementData(PreviewElement,dataName,mod.id);
	else
		PreviewElement=createPed(tonumber(skin),CamEndX,CamEndY,CamEndZ,pedROT);
	end
    local NewPosLightning=GetOffsetFromEntityInWorldCoords(PreviewElement,0,2,0);

    setCameraMatrix(CamX,CamY,CamZ,CamEndX,CamEndY,CamEndZ);
    PreviewLight=createLight(0,NewPosLightning.x,NewPosLightning.y,NewPosLightning.z,20, 200,200,200);
end)

addEventHandler("SkinShop:Buy:C",root,function(skin,coupon)
    if(not(isLoggedin()))then
		return;
	end
	if(isPedDead(localPlayer))then
		return;
	end
	if(isClickedState(localPlayer)==false)then
        return;
	end
    if(not guiGetVisible(BrowserUI))then
        return;
    end

    triggerServerEvent("SkinShop:Buy:S",localPlayer,tonumber(skin),tostring(coupon));
end)


addEventHandler("SkinShop:Show:Rotate",root,function(direction,speed)
    if(not(isLoggedin()))then
		return;
	end
	if(isPedDead(localPlayer))then
		return;
	end
	if(isClickedState(localPlayer)==false)then
		return;
	end
    if(not guiGetVisible(BrowserUI))then
        return;
    end
    
    if(isElement(PreviewElement))then
        local _,_,CurrentRotation=getElementRotation(PreviewElement);
        if(tostring(direction)and tonumber(speed)and tonumber(speed)>0)then
            if(direction=="left")then
                setElementRotation(PreviewElement,0,0,CurrentRotation-0.10*tonumber(speed));
            elseif(direction=="right")then
                setElementRotation(PreviewElement,0,0,CurrentRotation+0.10*tonumber(speed));
            end
        end
    end
end)


addEventHandler("SkinShop:SelectCoupon",root,function(id)
    if(not(isLoggedin()))then
		return;
	end
	if(isPedDead(localPlayer))then
		return;
	end
	if(isClickedState(localPlayer)==false)then
		return;
	end
    if(not guiGetVisible(BrowserUI))then
        return;
    end

    SelectedCoupon=tostring(id);
end)