addRemoteEvents{"Hud:UI","HUD:Update:Boosters"};--addEvents


local HUD=nil;
local HUDboosterTimer=nil;


addEventHandler("Hud:UI",root,function()
    if(not(HUD))then

        HUD=createBrowser(GLOBALscreenX,GLOBALscreenY,true,true);

		addEventHandler("onClientBrowserCreated",HUD,function()
			loadBrowserURL(HUD,"http://mta/local/Files/UI/Hud/main.html");

			addEventHandler("onClientBrowserDocumentReady",HUD,function()
				refreshHUD();
			end)
		end)

        addEventHandler("onClientRender",root,function()
			if(HUD)then
				if(not(isLoggedin()))then
					return;
				end
				if(isMainMenuActive())then
					return;
				end
				if(isPedDead(localPlayer))then
					return;
				end
				if(isClickedState(localPlayer)==true)then
					return;
				end
				if(not(CEFready))then
					return;
				end
				if(HUD_TOGGLE)then
					return;
				end


				
				dxDrawImage(0,0,GLOBALscreenX,GLOBALscreenY,HUD,0,0,0,tocolor(255,255,255,255),true);
			end
        end)

 
		addEventHandler("onClientPreRender",root,function()
			if(HUD)then
				if(not(isLoggedin()))then
					return;
				end
				if(isMainMenuActive())then
					return;
				end
				if(isPedDead(localPlayer))then
					return;
				end
				if(isClickedState(localPlayer)==true)then
					return;
				end
				if(HUD_TOGGLE)then
					return;
				end

				refreshHUD();
			end
		end)
    end
end)


function refreshHUD()
	if(HUD)then
		if(HUD_TOGGLE)then
			return;
		end
		--Date/Time
		local time=getRealTime();
		local month=time.month+1;
		local day=time.monthday;
		local hour=time.hour;
		local minute=time.minute;
		local year=time.year+1900;
		if(string.len(tostring(hour))==1)then
			hour="0"..hour;
		end
		if(string.len(tostring(minute))==1)then
			minute="0"..minute;
		end
		if(string.len(tostring(day))==1)then
			day="0"..day;
		end
		if(string.len(tostring(month))==1)then
			month="0"..month;
		end
		
		--Money
		local TextMoney=comma_value(getPlayerJsonValue(localPlayer,"Money","Cash"))or 0;
        local TextMoneyBlack=comma_value(getPlayerJsonValue(localPlayer,"Money","Black"))or 0;
		--Weapon
		local Weapon=getPedWeapon(localPlayer)or 0;
		local TextAmmo=getPedAmmoInClip(localPlayer).." | "..getPedTotalAmmo(localPlayer)-getPedAmmoInClip(localPlayer);

		executeBrowserJavascript(HUD,[[
            showHUD(']]..hour..":"..minute..[[',']]..day.."/"..month.."/"..year..[[',']]..TextMoney..[[',']]..TextMoneyBlack..[[',']]..Weapon..[[',']]..TextAmmo..[[');
        ]]);
	end
end

addEventHandler("HUD:Update:Boosters",root,function()
	if(not(isTimer(HUDboosterTimer)))then
		HUDboosterTimer=setTimer(function()
			local BoosterMoneyType=getPlayerJsonValue(localPlayer,"Booster","MoneyBoosterTier")or 0;
			local BoosterMoneyDuration=getPlayerJsonValue(localPlayer,"Booster","MoneyBoosterTime")or 0;

			local BoosterItemsType=getPlayerJsonValue(localPlayer,"Booster","ItemBoosterTier")or 0;
			local BoosterItemsDuration=getPlayerJsonValue(localPlayer,"Booster","ItemBoosterTime")or 0;

			executeBrowserJavascript(HUD,[[
				loadHUDboosters(']]..BoosterMoneyType..[[',']]..tonumber(BoosterMoneyDuration)-SERVER_TIME..[[', ']]..BoosterItemsType..[[',']]..tonumber(BoosterItemsDuration)-SERVER_TIME..[[');
			]]);
		end,1000,0)
	end
end)


local Toggle=false;
bindKey("NUM_5","DOWN",function()
	HUD_TOGGLE=not HUD_TOGGLE;
end)
bindKey("NUM_6","DOWN",function()
	Toggle=not Toggle;

	fadeCamera(Toggle);
end)

addEventHandler("onClientRender",root,function()
	if(HUD_TOGGLE)then
		showChat(false);
	end
end)







local Settings={
	DisabledHudComponents={
		"ammo",
		"armour",
		"clock",
		"health",
		"money",
		"weapon",
		"wanted",
		"area_name",
		"vehicle_name",
		"breath",
		"radar",
		"radio",
	},
};
addEventHandler("onClientRender",root,function()
	--disable default GTASA huds etc
	setRadioChannel(0);
	toggleControl("radar",false);
	for i=1,#Settings.DisabledHudComponents do
		setPlayerHudComponentVisible(Settings.DisabledHudComponents[i],false);
	end
end)