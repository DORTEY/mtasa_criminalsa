addRemoteEvents{"Speedo:UI"};--addEvents


local Speedo=nil;



addEventHandler("Speedo:UI",root,function()
	if(not(Speedo))then
		Speedo=createBrowser(GLOBALscreenX,GLOBALscreenY,true,true);

		addEventHandler("onClientBrowserCreated",Speedo,function()
			loadBrowserURL(Speedo,"http://mta/local/Files/UI/Speedometer/main.html");

			addEventHandler("onClientBrowserDocumentReady",Speedo,function()
				refreshSpeedo(Speedo);
			end)
		end)

		addEventHandler("onClientRender",root,function()
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
			if(not(isPedInVehicle(localPlayer)))then
				return;
			end
			if(not(CEFready))then
				return;
			end

			dxDrawImage(0,0,GLOBALscreenX,GLOBALscreenY,Speedo,0,0,0,tocolor(255,255,255,255),true);
		end)

		addEventHandler("onClientPreRender",root,function()
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
			if(not(isPedInVehicle(localPlayer)))then
				return;
			end

			if(Speedo)then
				refreshSpeedo(Speedo);
			end
		end)
	end
end)

function refreshSpeedo(Speedo)
	if(Speedo)then
		if(isPedInVehicle(localPlayer))then
			local veh=getPedOccupiedVehicle(localPlayer);
			if(veh and isElement(veh))then
				local VehSpeed=getElementSpeed(veh,"km/h")or 0;

				executeBrowserJavascript(Speedo,"showSpeedo('"..math.floor(VehSpeed).."');");
			end
		end
	end
end