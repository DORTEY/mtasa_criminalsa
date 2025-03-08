addRemoteEvents{"Open:CEF:Cache"};--addEvents


local CEF={};
CEF_LOADING_STATUS=nil;
LOADED_CEF=0;
Max_CEF=4;


addEventHandler("Open:CEF:Cache",root,function()
	--Inventory
    BrowserInventory=guiCreateBrowser(0,0,GLOBALscreenX,GLOBALscreenY,true,true,false,nil);
    getBrowserInventory=guiGetBrowser(BrowserInventory);
    guiSetVisible(BrowserInventory,false);
	table.insert(CEF,BrowserInventory);

    addEventHandler("onClientBrowserCreated",getBrowserInventory,function()
        loadBrowserURL(getBrowserInventory,"http://mta/local/Files/UI/Inventory/main.html");
        focusBrowser(getBrowserInventory);

        addEventHandler("onClientBrowserDocumentReady",BrowserInventory,function(url)
			LOADED_CEF=LOADED_CEF+1;

			executeBrowserJavascript(getBrowserInventory,[[
				$('.Title-Title').html('<span>]]..Server.Name..[[</span> - Inventar');
				$('.Loading').css('display','block');
			]]);
        end)
    end)


	--Tuning
	BrowserTuning=guiCreateBrowser(0,0,GLOBALscreenX,GLOBALscreenY,true,true,false,nil);
	getBrowserTuning=guiGetBrowser(BrowserTuning);
	guiSetVisible(BrowserTuning,false);
	table.insert(CEF,BrowserTuning);

	addEventHandler("onClientBrowserCreated",getBrowserTuning,function()
		loadBrowserURL(getBrowserTuning,"http://mta/local/Files/UI/Tuning/main.html");
		focusBrowser(getBrowserTuning);

		addEventHandler("onClientBrowserDocumentReady",BrowserTuning,function(url)
            LOADED_CEF=LOADED_CEF+1;
        end)
	end)


	--Teleport
	BrowserTeleporter=guiCreateBrowser(0,0,GLOBALscreenX,GLOBALscreenY,true,true,false,nil);
	getBrowserTeleporter=guiGetBrowser(BrowserTeleporter);
	guiSetVisible(BrowserTeleporter,false);
	table.insert(CEF,BrowserTeleporter);

	addEventHandler("onClientBrowserCreated",getBrowserTeleporter,function()
		loadBrowserURL(getBrowserTeleporter,"http://mta/local/Files/UI/Teleporter/main.html");
		focusBrowser(getBrowserTeleporter);

		addEventHandler("onClientBrowserDocumentReady",BrowserTeleporter,function(url)
			executeBrowserJavascript(getBrowserTeleporter,[[
				$('.Title-Title').html('<span>]]..Server.Name..[[</span>');
			]]);

            LOADED_CEF=LOADED_CEF+1;
        end)
	end)


	if(SERVER_TIME<=Server.Settings.Event.Current[2]and Server.Settings.Event.Current[1]~="none")then
		--Event
		BrowserEvent=guiCreateBrowser(0,0,GLOBALscreenX,GLOBALscreenY,true,true,false,nil);
		getBrowserEvent=guiGetBrowser(BrowserEvent);
		guiSetVisible(BrowserEvent,false);
		table.insert(CEF,BrowserEvent);

		addEventHandler("onClientBrowserCreated",getBrowserEvent,function()
			loadBrowserURL(getBrowserEvent,"http://mta/local/Files/UI/Event/main.html");
			focusBrowser(getBrowserEvent);

			addEventHandler("onClientBrowserDocumentReady",BrowserEvent,function(url)
				LOADED_CEF=LOADED_CEF+1;
			end)
		end)

		table.insert(CEF,BrowserEvent);
	end


	setTimer(function()
		CEFready=true;
	end,3000,1)
end)

addEventHandler("onClientResourceStart_Custom",resourceRoot,function()
	triggerServerEvent("Open:CEF:Cache:S",localPlayer);
end)


addEventHandler("onClientPreRender",root,function()
	if(isLoggedin())then
		return;
	end

	if(CEF_LOADING_STATUS)then
		removeEventHandler("onClientRender",root,drawCEFloading);
		addEventHandler("onClientRender",root,drawCEFloading);
	end
	if(LOADED_CEF>0)then
		if(LOADED_CEF>=Max_CEF)then
			LOADED_CEF=0;
			CEF_LOADING_STATUS=nil;
			removeEventHandler("onClientRender",root,drawCEFloading);
		end
	end
end)