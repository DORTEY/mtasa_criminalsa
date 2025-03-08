addRemoteEvents{"Vehicleshop:UI","Vehicleshop:LoadDatas","Vehicleshop:BuyTest:C",
"Vehicleshop:Show:PreviewColor","Vehicleshop:Show:Rotate",
"Vehicleshop:SelectCoupon"};--addEvents


local CurrentCarhouse=nil;
local PreviewElement=nil;
local ColorR,ColorG,ColorB=0,0,0;
local DriveType=nil;
local SelectedCoupon=nil;
local VehiclePrice=0;

local CEFTimer,BrowserUI,Browser=nil,nil,nil;


addEventHandler("Vehicleshop:UI",root,function(type,carhouse,timestamp)
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
                loadBrowserURL(Browser,"http://mta/local/Files/UI/Vehicleshop/main.html");
                focusBrowser(Browser);

                addEventHandler("onClientBrowserDocumentReady",BrowserUI,function(url)
                    executeBrowserJavascript(Browser,"setLanguageVehicleshop('"..Server.Name.."','"..loc(localPlayer,"UI:VehicleShop:Title").."','"..loc(localPlayer,"UI:VehicleShop:SearchBar").."','"..loc(localPlayer,"UI:VehicleShop:SelectCoupon").."',           '"..loc(localPlayer,"UI:VehicleShop:LeaveUI").."','"..loc(localPlayer,"UI:VehicleShop:Buy").."','"..loc(localPlayer,"UI:VehicleShop:Test").."');");
                    setTimer(function()
                        if(Vehicle.Carhouse.Vehicles[tostring(carhouse)])then
                            for _,v in ipairs(Vehicle.Carhouse.Vehicles[tostring(carhouse)])do
                                if(Vehicle.Carhouse.LimitedVehicles[tonumber(v[1])])then
                                    if(timestamp<=Vehicle.Carhouse.LimitedVehicles[tonumber(v[1])])then
                                        executeBrowserJavascript(Browser,"loadVehiclesInCarhouseList('"..v[1].."','"..returnVehicleName(v[1]).."','"..timestamp.."');");
                                    end
                                else
                                    executeBrowserJavascript(Browser,"loadVehiclesInCarhouseList('"..v[1].."','"..returnVehicleName(v[1]).."','0');");
                                end
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

            executeBrowserJavascript(Browser,"setLanguageVehicleshop('"..Server.Name.."','"..loc(localPlayer,"UI:VehicleShop:Title").."','"..loc(localPlayer,"UI:VehicleShop:SearchBar").."','"..loc(localPlayer,"UI:VehicleShop:SelectCoupon").."',           '"..loc(localPlayer,"UI:VehicleShop:LeaveUI").."','"..loc(localPlayer,"UI:VehicleShop:Buy").."','"..loc(localPlayer,"UI:VehicleShop:Test").."');");
            setTimer(function()
                if(Vehicle.Carhouse.Vehicles[tostring(carhouse)])then
                    for _,v in ipairs(Vehicle.Carhouse.Vehicles[tostring(carhouse)])do
                        if(Vehicle.Carhouse.LimitedVehicles[tonumber(v[1])])then
                            if(timestamp<=Vehicle.Carhouse.LimitedVehicles[tonumber(v[1])])then
                                executeBrowserJavascript(Browser,"loadVehiclesInCarhouseList('"..v[1].."','"..returnVehicleName(v[1]).."','"..timestamp.."');");
                            end
                        else
                            executeBrowserJavascript(Browser,"loadVehiclesInCarhouseList('"..v[1].."','"..returnVehicleName(v[1]).."','0');");
                        end
                    end
                end
            end,200,1);
        end

        CurrentCarhouse=carhouse;
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

        CurrentCarhouse=nil;
        SelectedCoupon=nil;

        if(isElement(PreviewElement))then
            destroyElement(PreviewElement);
            PreviewElement=nil;
        end
        setCameraTarget(localPlayer);
	end
end)

addEventHandler("Vehicleshop:LoadDatas",root,function(id)
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

    setCameraMatrix(Vehicle.Carhouse.Cam[CurrentCarhouse][1],Vehicle.Carhouse.Cam[CurrentCarhouse][2],Vehicle.Carhouse.Cam[CurrentCarhouse][3], Vehicle.Carhouse.Cam[CurrentCarhouse][4],Vehicle.Carhouse.Cam[CurrentCarhouse][5],Vehicle.Carhouse.Cam[CurrentCarhouse][6]);


    if(isElement(PreviewElement))then
		destroyElement(PreviewElement);
		PreviewElement=nil;
	end

    local isCustom,mod,elementType=exports[RESOURCE_NEWMODELS]:isCustomModID(tonumber(id));
	if(isCustom)then
		PreviewElement=createVehicle(mod.base_id,Vehicle.Carhouse.Cam[CurrentCarhouse][4],Vehicle.Carhouse.Cam[CurrentCarhouse][5],Vehicle.Carhouse.Cam[CurrentCarhouse][6]);
		local dataName=exports[RESOURCE_NEWMODELS]:getDataNameFromType(elementType);
		setElementData(PreviewElement,dataName,mod.id);
        DriveType=getOriginalHandling(tonumber(mod.base_id))["driveType"];
    else
        PreviewElement=createVehicle(tonumber(id),Vehicle.Carhouse.Cam[CurrentCarhouse][4],Vehicle.Carhouse.Cam[CurrentCarhouse][5],Vehicle.Carhouse.Cam[CurrentCarhouse][6],0,0,Vehicle.Carhouse.Cam[CurrentCarhouse][7]);
        DriveType=getOriginalHandling(tonumber(id))["driveType"];
    end
    setElementFrozen(PreviewElement,true);
    setElementCollisionsEnabled(PreviewElement,false);

	if(ColorR and ColorG and ColorB)then
		setVehicleColor(PreviewElement,ColorR,ColorG,ColorB, ColorR,ColorG,ColorB);
	else
		setVehicleColor(PreviewElement,0,0,0, 0,0,0);
	end

    --datas
    local LimitedTime=Vehicle.Carhouse.LimitedVehicles[tonumber(id)]and Vehicle.Carhouse.LimitedVehicles[tonumber(id)]-SERVER_TIME or 0;
    if(SelectedCoupon)then
        VehiclePrice=Vehicle.Prices[tonumber(id)]-Vehicle.Prices[tonumber(id)]/100*tonumber(Items[tostring(SelectedCoupon)].Percentage);
    else
        VehiclePrice=Vehicle.Prices[tonumber(id)];
    end
    executeBrowserJavascript(Browser,"showCarhouseVehicleDetails('"..tonumber(id).."','"..returnVehicleName(tonumber(id)).."','"..comma_value(VehiclePrice).."','"..getVehicleMaxPassengers(PreviewElement)+1 .."','"..DriveType.."','"..Vehicle.Speeds[tonumber(id)].."','"..LimitedTime.."');");

    --coupons
    executeBrowserJavascript(Browser,"$('.dropdown-item-list').empty();");
    for item,amount in pairs(getPlayerJsonTable(localPlayer,"Items"))do
        if(amount and tonumber(amount)>0 and item:find("VehicleCoupon"))then
            executeBrowserJavascript(Browser,"loadVehicleshopCoupons('"..item.."','"..loc(localPlayer,"Item:"..item).." (x"..amount..")');");
        end
    end
end)

addEventHandler("Vehicleshop:BuyTest:C",root,function(type,id,coupon)
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

    triggerServerEvent("Vehicleshop:BuyTest:S",localPlayer,tostring(type),tonumber(id),tostring(coupon),{tonumber(ColorR),tonumber(ColorG),tonumber(ColorB), tonumber(ColorR),tonumber(ColorG),tonumber(ColorB)});
    triggerServerEvent("Load:Garage:Vehicles:S",localPlayer);
end)


addEventHandler("Vehicleshop:Show:PreviewColor",root,function(r,g,b)
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
		ColorR,ColorG,ColorB=tonumber(r),tonumber(g),tonumber(b);
		setVehicleColor(PreviewElement,tonumber(r),tonumber(g),tonumber(b),tonumber(r),tonumber(g),tonumber(b));
	end
end)


addEventHandler("Vehicleshop:Show:Rotate",root,function(direction,speed)
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


addEventHandler("Vehicleshop:SelectCoupon",root,function(id)
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