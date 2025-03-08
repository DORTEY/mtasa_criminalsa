addRemoteEvents{"Tuning:UI","Tuning:Show:Color","Tuning:Tuningpart:C","Tuning:Load:Parts",

"Load:Garage:Vehicles:C"};--addEvent


local ID=nil;
local KeyUnpark="W";
local KeyTuning="X";
local KeySellVehicle="J";
local ColorR,ColorG,ColorB=0,0,0;


local function tuneVehicle()
    triggerEvent("Tuning:UI",localPlayer,true);
end
local function sellVehicle()
    if(not(isPedInVehicle(localPlayer)))then
        return;
    end

    local veh=getPedOccupiedVehicle(localPlayer);
	if(veh and isElement(veh)and getElementData(veh,"Vehicle:Data:Owner"))then
        if(getElementData(veh,"Vehicle:Data:Owner")==getPlayerName(localPlayer))then
            local Model=getElementData(veh,"Vehicle:Data:VehID");
            if(Vehicle.Prices[tonumber(Model)])then
                triggerEvent("Popup:UI",localPlayer,true,"SellVehicle",loc(localPlayer,"UI:VehicleSell:Text"):format(returnVehicleName(Model),comma_value(Vehicle.Prices[tonumber(Model)]/100*Vehicle.SellPercentage)));
                
                unbindKey(KeyUnpark,"DOWN",parkoutVehicle);
                unbindKey(KeyTuning,"DOWN",tuneVehicle);
                unbindKey(KeySellVehicle,"DOWN",sellVehicle);
            else
                print("cant be sold")
            end
        end
    end
end

local function parkoutVehicle()
    if(isClickedState(localPlayer)==true)then
        return;
    end
    if(guiGetVisible(BrowserTuning))then
        return;
    end

    unbindKey(KeyUnpark,"DOWN",parkoutVehicle);
    unbindKey(KeyTuning,"DOWN",tuneVehicle);
    unbindKey(KeySellVehicle,"DOWN",sellVehicle);

    if(ID and ID>0)then
        triggerServerEvent("Garage:ParkOut",localPlayer,ID);
        triggerServerEvent("Tutorial:NextStep",localPlayer,localPlayer,"ParkoutVehicle");
    end
end


addEventHandler("onClientVehicleEnter",root,function(player,seat)
	if(player==localPlayer)then
        if(getElementData(source,"Vehicle:Data:Type")and getElementData(source,"Vehicle:Data:Type")=="Preview")then
            bindKey(KeyUnpark,"DOWN",parkoutVehicle);
            bindKey(KeyTuning,"DOWN",tuneVehicle);
            bindKey(KeySellVehicle,"DOWN",sellVehicle);

            triggerEvent("Notify:UI",localPlayer,loc(localPlayer,"S:Vehicle:UnparkWith"):format(KeyUnpark),"info",6000);
            triggerEvent("Notify:UI",localPlayer,loc(localPlayer,"S:Vehicle:OpenTuningWith"):format(KeyTuning),"info",6000);
            triggerEvent("Notify:UI",localPlayer,loc(localPlayer,"S:Vehicle:SellVehicleWith"):format(KeySellVehicle),"info",6000);

            outputChatBox(loc(localPlayer,"S:Vehicle:UnparkWith"):format(KeyUnpark),Server.Color.RGB[1],Server.Color.RGB[2],Server.Color.RGB[3],false);
            outputChatBox(loc(localPlayer,"S:Vehicle:OpenTuningWith"):format(KeyTuning),Server.Color.RGB[1],Server.Color.RGB[2],Server.Color.RGB[3],false);
            outputChatBox(loc(localPlayer,"S:Vehicle:SellVehicleWith"):format(KeySellVehicle),Server.Color.RGB[1],Server.Color.RGB[2],Server.Color.RGB[3],false);

            ID=getElementData(source,"Vehicle:Data:ID")or nil;
        end
	end
end)

addEventHandler("onClientVehicleStartExit",root,function(player,veh,seat)
	if(player==localPlayer)then
        unbindKey(KeyUnpark,"DOWN",parkoutVehicle);
        unbindKey(KeyTuning,"DOWN",tuneVehicle);
        unbindKey(KeySellVehicle,"DOWN",sellVehicle);

        ID=nil;
	end
end)




addEventHandler("Tuning:UI",root,function(type)
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
        guiSetVisible(BrowserTuning,true);

        executeBrowserJavascript(getBrowserTuning,"setLanguageTuning('"..Server.Name.."','"..loc(localPlayer,"UI:Tuning:Title").."','"..loc(localPlayer,"UI:Tuning:SearchBar").."');");
        setTimer(function()
            local model=getElementData(getPedOccupiedVehicle(localPlayer),"Vehicle:Data:VehID");
            if(Vehicle.Tuning["Categorys"][model])then
                for i,v in ipairs(Vehicle.Tuning["Categorys"][model])do
                    if(Vehicle.Tuning["TuningPrices"][v])then
                        executeBrowserJavascript(getBrowserTuning,"loadCategoriesInTuningList('"..v.."','"..Vehicle.Tuning["CategoryIcons"][v].."','"..loc(localPlayer,"UI:Tuning:Category"..v).."','"..Vehicle.Tuning["TuningPrices"][v].."');");
                    else
                        executeBrowserJavascript(getBrowserTuning,"loadCategoriesInTuningList('"..v.."','"..Vehicle.Tuning["CategoryIcons"][v].."','"..loc(localPlayer,"UI:Tuning:Category"..v).."','0');");
                    end
                end
            end
        end,250,1);
	else
		setUIdatas("rem","cursor");
        guiSetVisible(BrowserTuning,false);

        executeBrowserJavascript(getBrowserTuning,"$('.NavbarItem').empty();");
        executeBrowserJavascript(getBrowserTuning,"$('.TuningListItem').empty();");
        executeBrowserJavascript(getBrowserTuning,"$('.ThirdUI').css('display','none');");

        triggerServerEvent("Tuning:Close",localPlayer);
	end
end)

addEventHandler("Tuning:Load:Parts",root,function(type)
    if(not(isLoggedin()))then
		return;
	end
	if(isPedDead(localPlayer))then
		return;
	end
	if(isClickedState(localPlayer)==false)then
        return;
	end
    if(not guiGetVisible(BrowserTuning))then
        return;
    end

    executeBrowserJavascript(getBrowserTuning,"$('.TuningListItem').empty();");
    setTimer(function()
        local VehModel=getElementData(getPedOccupiedVehicle(localPlayer),"Vehicle:Data:VehID");
        for _,part in ipairs(Vehicle.Tuning["Parts"][tostring(type)])do
            if(isTuningpartAvailable(VehModel,part))then
                executeBrowserJavascript(getBrowserTuning,"loadTuningParts('"..part.."','"..Vehicle.Tuning["TuningNames"][part].."','"..(Vehicle.Prices[VehModel]or 700000)/100*Vehicle.Tuning["TuningPrices"][part].."');");
            end
        end
    end,250,1);
end)

addEventHandler("Tuning:Show:Color",root,function(type,r,g,b)
    if(not(isLoggedin()))then
		return;
	end
	if(isPedDead(localPlayer))then
		return;
	end
	if(isClickedState(localPlayer)==false)then
        return;
	end
    if(not guiGetVisible(BrowserTuning))then
        return;
    end

    if(isPedInVehicle(localPlayer))then
        local Vehicle=getPedOccupiedVehicle(localPlayer);
        if(type=="Bodycolor")then
            setVehicleColor(Vehicle,r,g,b, r,g,b);
            ColorR,ColorG,ColorB=tonumber(r),tonumber(g),tonumber(b);
        elseif(type=="Lightcolor")then
            setVehicleHeadLightColor(Vehicle,r,g,b);
            ColorR,ColorG,ColorB=tonumber(r),tonumber(g),tonumber(b);
        end
    end
end)

addEventHandler("Tuning:Tuningpart:C",root,function(type,id)
    if(not(isLoggedin()))then
		return;
	end
	if(isPedDead(localPlayer))then
		return;
	end
	if(isClickedState(localPlayer)==false)then
        return;
	end
    if(not guiGetVisible(BrowserTuning))then
        return;
    end

    if(type and isPedInVehicle(localPlayer))then
        if(id:find("Horn_"))then
            HORN=id:gsub("Horn_","");
            if(isElement(SOUND))then
                destroyElement(SOUND);
                SOUND=nil;
            end
            if(HORN and tonumber(HORN)>0 and tonumber(HORN)~=9999999)then
                SOUND=playSound(":"..RESOURCE_NAME.."/Files/Audio/Horns/"..tostring(HORN)..".mp3",false);
            end
        end
        triggerServerEvent("Tuning:Tuningpart:S",localPlayer,tostring(type),id,{ColorR,ColorG,ColorB, ColorR,ColorG,ColorB});
    end
end)









addEventHandler("Load:Garage:Vehicles:C",root,function()
    triggerServerEvent("Load:Garage:Vehicles:S",localPlayer);
end)