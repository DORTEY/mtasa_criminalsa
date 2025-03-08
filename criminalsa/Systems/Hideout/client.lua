addRemoteEvents{"Hideout:UI","Hideout:Load","Hideout:Load:Upgrades","Hideout:Load:Laundry","Hideout:Load:PedSkins","Hideout:Load:Armory","Hideout:Wardrobe:WearSkin:C","Hideout:Wardrobe:DeleteSkin:C","Hideout:Wardrobe:GrabQueueSkin:C","Hideout:Load:WeaponSkins","Hideout:Load:RequirementsBenefits",
"Hideout:Upgrade:C","Hideout:Take:C","Hideout:TakeLaundry:C","Hideout:TakeWeapon:C","Hideout:TakeWeaponSkin:C","Hideout:PutInLaundry:C","Hideout:CurrentSide","Hideout:Update"};--addEvents


local CEFTimer,BrowserUI,Browser=nil,nil,nil;

local CurrentSite=nil;

local Blip=nil;
local Gate=nil;
local MarkerOut=nil;
local MarkerIn=nil;
local MarkerWorkbench=nil;
local MarkerGarageOut=nil;
local Dimension=nil;
local Garage=nil;

local SoundGenerator=nil;
local SoundGraphiccard=nil;
local SoundWashingmachine=nil;

local HideoutObj=nil;
local Workbench=nil;
local Generator=nil;
local GeneratorEffect=nil;
local Armorys={};
local BitcoinRacks={};
local Moneywashs={};


addEventHandler("Hideout:Load",root,function(ID)
    Dimension=tonumber(ID);

    if(isElement(MarkerWorkbench))then
        destroyElement(MarkerWorkbench);MarkerWorkbench=nil;
    end
    if(isElement(Gate))then
        destroyElement(Gate);Gate=nil;
    end
    if(isElement(Blip))then
        destroyElement(Blip);Blip=nil;
    end
    if(isElement(MarkerOut))then
        destroyElement(MarkerOut);MarkerOut=nil;
    end
    if(isElement(MarkerIn))then
        destroyElement(MarkerIn);MarkerIn=nil;
    end
    if(isElement(MarkerGarageOut))then
        destroyElement(MarkerGarageOut);MarkerGarageOut=nil;
    end
    if(not(isElement(MarkerWorkbench)))then
        local HideoutTier=tonumber(getPlayerJsonValue(localPlayer,"HideUpgrades","Hideout"))or 0;
        local Table=Hideout_DefaultStuffCoords;

        if(Table[HideoutTier].Gate)then
            Gate=createObject(3037,Table[HideoutTier].Gate[1],Table[HideoutTier].Gate[2],Table[HideoutTier].Gate[3],0,0,0);
            setObjectScale(Gate,1.4);
        end

        Blip=createBlip(Table[HideoutTier].Blip[1],Table[HideoutTier].Blip[2],Table[HideoutTier].Blip[3],2,22,60,255,60,255,100);
        setElementData(Blip,"Blip:Data:Tooltip",loc(localPlayer,"UI:Hideout:Title"));


        MarkerOut=createMarker(Table[HideoutTier].MarkerOut[1],Table[HideoutTier].MarkerOut[2],Table[HideoutTier].MarkerOut[3],"cylinder",1.4,2,160,168,120);
        MarkerIn=createMarker(Table[HideoutTier].MarkerIn[1],Table[HideoutTier].MarkerIn[2],Table[HideoutTier].MarkerIn[3],"cylinder",1.4,2,160,168,120);
        MarkerGarageOut=createMarker(Table[HideoutTier].MarkerGarageOut[1],Table[HideoutTier].MarkerGarageOut[2],Table[HideoutTier].MarkerGarageOut[3],"cylinder",1.4,2,160,168,120);


        if(Gate)then
            setElementDimension(Gate,-1);
        end
        setElementDimension(MarkerOut,tonumber(Dimension));
        setElementDimension(MarkerIn,tonumber(0));
        setElementDimension(MarkerGarageOut,tonumber(Dimension));



        addEventHandler("onClientMarkerHit",MarkerOut,function(hitElem,dim)
            if(hitElem==localPlayer and dim and source)then
                if(getElementInterior(localPlayer)==getElementInterior(source)and getElementDimension(localPlayer)==getElementDimension(source))then
                    local x,y,z=getElementPosition(localPlayer);
                    local x1,y1,z1=getElementPosition(source);
                    
                    if(getDistanceBetweenPoints3D(x,y,z,x1,y1,z1)<=2)then
                        triggerEvent("Teleporter:UI",localPlayer,true,"HideoutOut");
                    end
                end
            end
        end)
        addEventHandler("onClientMarkerLeave",MarkerOut,function(hitElem,dim)
            if(hitElem==localPlayer and dim and source)then
                if(getElementInterior(localPlayer)==getElementInterior(source)and getElementDimension(localPlayer)==getElementDimension(source))then
                    triggerEvent("Teleporter:UI",localPlayer,false);
                end
            end
        end)
        addEventHandler("onClientMarkerHit",MarkerIn,function(hitElem,dim)
            if(hitElem==localPlayer and dim and source)then
                if(getElementInterior(localPlayer)==getElementInterior(source)and getElementDimension(localPlayer)==getElementDimension(source))then
                    local x,y,z=getElementPosition(localPlayer);
                    local x1,y1,z1=getElementPosition(source);
                    
                    if(getDistanceBetweenPoints3D(x,y,z,x1,y1,z1)<=2)then
                        triggerEvent("Teleporter:UI",localPlayer,true,"HideoutIn");
                    end
                end
            end
        end)
        addEventHandler("onClientMarkerLeave",MarkerIn,function(hitElem,dim)
            if(hitElem==localPlayer and dim and source)then
                if(getElementInterior(localPlayer)==getElementInterior(source)and getElementDimension(localPlayer)==getElementDimension(source))then
                    triggerEvent("Teleporter:UI",localPlayer,false);
                end
            end
        end)

        addEventHandler("onClientMarkerHit",MarkerGarageOut,function(hitElem,dim)
            if(hitElem==localPlayer and dim and source)then
                if(getElementInterior(localPlayer)==getElementInterior(source)and getElementDimension(localPlayer)==getElementDimension(source))then
                    local x,y,z=getElementPosition(localPlayer);
                    local x1,y1,z1=getElementPosition(source);
                    
                    if(getDistanceBetweenPoints3D(x,y,z,x1,y1,z1)<=2)then
                        triggerEvent("Teleporter:UI",localPlayer,true,"GarageOut");
                    end
                end
            end
        end)
        addEventHandler("onClientMarkerLeave",MarkerGarageOut,function(hitElem,dim)
            if(hitElem==localPlayer and dim and source)then
                if(getElementInterior(localPlayer)==getElementInterior(source)and getElementDimension(localPlayer)==getElementDimension(source))then
                    triggerEvent("Teleporter:UI",localPlayer,false);
                end
            end
        end)
    end

    loadUpgrades();
end)

function loadUpgrades()
    --Hideout
    local HideoutTier=tonumber(getPlayerJsonValue(localPlayer,"HideUpgrades","Hideout"))or 0;

    if(isElement(HideoutObj))then
        destroyElement(HideoutObj);
        HideoutObj=nil;
    end

    if(HideoutTier>0)then
        HideoutObj=createObject(Hideout.Hideout.Positions[HideoutTier][1],Hideout.Hideout.Positions[HideoutTier][2],Hideout.Hideout.Positions[HideoutTier][3],Hideout.Hideout.Positions[HideoutTier][4],0,0,0);
        setElementDimension(HideoutObj,tonumber(Dimension));
    end

    --Workbench
    local WorkbenchTier=tonumber(getPlayerJsonValue(localPlayer,"HideUpgrades","Workbench"))or 0;

    if(isElement(Workbench))then
        destroyElement(Workbench);
        Workbench=nil;
    end

    if(WorkbenchTier>0)then
        Workbench=createObject(Hideout.Workbench.Positions[HideoutTier][WorkbenchTier][1],Hideout.Workbench.Positions[HideoutTier][WorkbenchTier][2],Hideout.Workbench.Positions[HideoutTier][WorkbenchTier][3],Hideout.Workbench.Positions[HideoutTier][WorkbenchTier][4],0,0,Hideout.Workbench.Positions[HideoutTier][WorkbenchTier][5]);
        setElementDimension(Workbench,tonumber(Dimension));

        if(isElement(MarkerWorkbench))then
            destroyElement(MarkerWorkbench);
            MarkerWorkbench=nil;
        end

        local x1,y1,z1=getPositionInFrontOfElement(Workbench,tonumber(Hideout.Workbench.Positions[HideoutTier][WorkbenchTier][6]));
        MarkerWorkbench=createMarker(x1,y1,z1-0.3,"cylinder",1.4,2,160,168,120);
        setElementDimension(MarkerWorkbench,tonumber(Dimension));


        addEventHandler("onClientMarkerHit",MarkerWorkbench,function(hitElem,dim)
            if(hitElem==localPlayer and dim and source)then
                if(getElementInterior(localPlayer)==getElementInterior(source)and getElementDimension(localPlayer)==getElementDimension(source))then
                    local x,y,z=getElementPosition(localPlayer);
                    local x1,y1,z1=getElementPosition(source);
                    
                    if(getDistanceBetweenPoints3D(x,y,z,x1,y1,z1)<=2)then
                        triggerEvent("Hideout:UI",localPlayer,true);
                        --triggerEvent("Hideout:Load:Laundry",localPlayer);
                        triggerServerEvent("Tutorial:NextStep",localPlayer,localPlayer,"OpenHideoutOverview");
                    end
                end
            end
        end)
        addEventHandler("onClientMarkerLeave",MarkerWorkbench,function(hitElem,dim)
            if(hitElem==localPlayer and dim and source)then
                if(getElementInterior(localPlayer)==getElementInterior(source)and getElementDimension(localPlayer)==getElementDimension(source))then
                    triggerEvent("Hideout:UI",localPlayer,false);
                end
            end
        end)
    end


    --Generator
    local GeneratorTier=tonumber(getPlayerJsonValue(localPlayer,"HideUpgrades","Generator"))or 0;

    if(isElement(Generator))then
        destroyElement(Generator);
        Generator=nil;
    end
    if(isElement(SoundGenerator))then
        destroyElement(SoundGenerator);
        SoundGenerator=nil;
    end
    if(isElement(GeneratorEffect))then
        destroyElement(GeneratorEffect);
        GeneratorEffect=nil;
    end

    if(GeneratorTier>0)then
        if(Hideout.Generator.Positions[HideoutTier])then
            Generator=createObject(Hideout.Generator.Positions[HideoutTier][GeneratorTier][1],Hideout.Generator.Positions[HideoutTier][GeneratorTier][2],Hideout.Generator.Positions[HideoutTier][GeneratorTier][3],Hideout.Generator.Positions[HideoutTier][GeneratorTier][4],0,0,Hideout.Generator.Positions[HideoutTier][GeneratorTier][5]);
            setElementDimension(Generator,tonumber(Dimension));

            GeneratorEffect=createEffect("overheat_car",Hideout.Generator.Positions[HideoutTier][GeneratorTier][2],Hideout.Generator.Positions[HideoutTier][GeneratorTier][3],Hideout.Generator.Positions[HideoutTier][GeneratorTier][4]+0.5,100,100,10,100,true);
            
            if(fileExists(":"..RESOURCE_NAME.."/Files/Audio/Generator.mp3"))then
                SoundGenerator=playSound3D(":"..RESOURCE_NAME.."/Files/Audio/Generator.mp3",Hideout.Generator.Positions[HideoutTier][GeneratorTier][2],Hideout.Generator.Positions[HideoutTier][GeneratorTier][3],Hideout.Generator.Positions[HideoutTier][GeneratorTier][4],true);
                setSoundMaxDistance(SoundGenerator,Hideout.Generator.Positions[HideoutTier][GeneratorTier][6]);
                setSoundVolume(SoundGenerator,0.5);
                setElementDimension(SoundGenerator,tonumber(Dimension));
            end
        end
    end


    --Bitcoin
    local BitcoinTier=tonumber(getPlayerJsonValue(localPlayer,"HideUpgrades","Bitcoin"))or 0;
    for i,v in ipairs(BitcoinRacks)do
		table.removevalue(BitcoinRacks,i);
		if(isElement(v))then
			destroyElement(v);
		end
	end

    if(isElement(SoundGraphiccard))then
        destroyElement(SoundGraphiccard);
        SoundGraphiccard=nil;
    end

    if(BitcoinTier>0)then
        for i=1,BitcoinTier do
            if(Hideout.Bitcoin.Positions[HideoutTier])then
                BitcoinRack=createObject(3386,Hideout.Bitcoin.Positions[HideoutTier][i][1],Hideout.Bitcoin.Positions[HideoutTier][i][2],Hideout.Bitcoin.Positions[HideoutTier][i][3],0,0,270);

                setElementDimension(BitcoinRack,tonumber(Dimension));
                
                table.insert(BitcoinRacks,BitcoinRack);
            end
        end

        if(fileExists(":"..RESOURCE_NAME.."/Files/Audio/Graphiccard.mp3"))then
            SoundGraphiccard=playSound3D(":"..RESOURCE_NAME.."/Files/Audio/Graphiccard.mp3",Hideout.Bitcoin.Positions[HideoutTier][4][1],Hideout.Bitcoin.Positions[HideoutTier][4][2],Hideout.Bitcoin.Positions[HideoutTier][4][3],true);
            setSoundMaxDistance(SoundGraphiccard,Hideout.Bitcoin.Positions[HideoutTier][BitcoinTier][4]);
            setSoundVolume(SoundGraphiccard,0.8);
            setElementDimension(SoundGraphiccard,tonumber(Dimension));
        end
    end


    --Moneywash
    local MoneywashTier=tonumber(getPlayerJsonValue(localPlayer,"HideUpgrades","Moneywash"))or 0;
    for i,v in ipairs(Moneywashs)do
		table.removevalue(Moneywashs,i);
		if(isElement(v))then
			destroyElement(v);
		end
	end

    if(isElement(SoundWashingmachine))then
        destroyElement(SoundWashingmachine);
        SoundWashingmachine=nil;
    end

    if(MoneywashTier>0)then
        for i=1,MoneywashTier do
            if(Hideout.Moneywash.Positions[HideoutTier])then
                Moneywash=createObject(1208,Hideout.Moneywash.Positions[HideoutTier][i][1],Hideout.Moneywash.Positions[HideoutTier][i][2],Hideout.Moneywash.Positions[HideoutTier][i][3],0,0,90);

                setElementDimension(Moneywash,tonumber(Dimension));
                
                table.insert(Moneywashs,Moneywash);
            end
        end

        if(fileExists(":"..RESOURCE_NAME.."/Files/Audio/Washingmachine.mp3"))then
            SoundWashingmachine=playSound3D(":"..RESOURCE_NAME.."/Files/Audio/Washingmachine.mp3",Hideout.Moneywash.Positions[HideoutTier][2][1],Hideout.Moneywash.Positions[HideoutTier][2][2],Hideout.Moneywash.Positions[HideoutTier][2][3],true);
            setSoundMaxDistance(SoundWashingmachine,Hideout.Moneywash.Positions[HideoutTier][MoneywashTier][4]);
            setSoundVolume(SoundWashingmachine,0.5);
            setElementDimension(SoundWashingmachine,tonumber(Dimension));
        end
    end


    --Armory
    local ArmoryTier=tonumber(getPlayerJsonValue(localPlayer,"HideUpgrades","Armory"))or 0;
    for i,v in ipairs(Armorys)do
		table.removevalue(Armorys,i);
		if(isElement(v))then
			destroyElement(v);
		end
	end


    --Garage
    local GarageTier=tonumber(getPlayerJsonValue(localPlayer,"HideUpgrades","Garage"))or 0;

    if(isElement(Garage))then
        destroyElement(Garage);
        Garage=nil;
    end

    if(GarageTier>0)then
        Garage=createObject(Hideout.Garage.Positions[GarageTier][1],Hideout.Garage.Positions[GarageTier][2],Hideout.Garage.Positions[GarageTier][3],Hideout.Garage.Positions[GarageTier][4],Hideout.Garage.Positions[GarageTier][5],Hideout.Garage.Positions[GarageTier][6],Hideout.Garage.Positions[GarageTier][7]);
        setElementDimension(Garage,tonumber(Dimension));

        triggerServerEvent("Load:Garage:Vehicles:S",localPlayer);
    end


    --Wardrobe
    local WardrobeTier=tonumber(getPlayerJsonValue(localPlayer,"HideUpgrades","Wardrobe"))or 0;

    if(isElement(Wardrobe))then
        destroyElement(Wardrobe);
        Wardrobe=nil;
    end

    if(WardrobeTier>0)then
        Wardrobe=createObject(Hideout.Wardrobe.Positions[HideoutTier][WardrobeTier][1],Hideout.Wardrobe.Positions[HideoutTier][WardrobeTier][2],Hideout.Wardrobe.Positions[HideoutTier][WardrobeTier][3],Hideout.Wardrobe.Positions[HideoutTier][WardrobeTier][4],0,0,Hideout.Wardrobe.Positions[HideoutTier][WardrobeTier][5]);
        setElementDimension(Wardrobe,tonumber(Dimension));
    end
end
addEventHandler("Hideout:Load:Upgrades",root,loadUpgrades)


local function updateUI()
    setTimer(function()
        local LevelGenerator=tonumber(getPlayerJsonValue(localPlayer,"HideUpgrades","Generator"))or 0;
        local LevelBitcoin=tonumber(getPlayerJsonValue(localPlayer,"HideUpgrades","Bitcoin"))or 0;
        local LevelWorkbench=tonumber(getPlayerJsonValue(localPlayer,"HideUpgrades","Workbench"))or 0;
        local LevelArmory=tonumber(getPlayerJsonValue(localPlayer,"HideUpgrades","Armory"))or 0;
        local LevelGarage=tonumber(getPlayerJsonValue(localPlayer,"HideUpgrades","Garage"))or 0;
        local LevelMoneywash=tonumber(getPlayerJsonValue(localPlayer,"HideUpgrades","Moneywash"))or 0;
        local LevelDufflebag=tonumber(getPlayerJsonValue(localPlayer,"HideUpgrades","Dufflebag"))or 0;
        local LevelHideout=tonumber(getPlayerJsonValue(localPlayer,"HideUpgrades","Hideout"))or 0;
        local LevelWardrobe=tonumber(getPlayerJsonValue(localPlayer,"HideUpgrades","Wardrobe"))or 0;

        local ButtonGenerator=Hideout.Generator.Upgrades[LevelGenerator]and Hideout.Generator.Upgrades[LevelGenerator].costs or loc(localPlayer,"UI:Hideout:Maxed");
        local ButtonBitcoin=Hideout.Bitcoin.Upgrades[LevelBitcoin]and Hideout.Bitcoin.Upgrades[LevelBitcoin].costs or loc(localPlayer,"UI:Hideout:Maxed");
        local ButtonWorkbench=Hideout.Workbench.Upgrades[LevelWorkbench]and Hideout.Workbench.Upgrades[LevelWorkbench].costs or loc(localPlayer,"UI:Hideout:Maxed");
        local ButtonArmory=Hideout.Armory.Upgrades[LevelArmory]and Hideout.Armory.Upgrades[LevelArmory].costs or loc(localPlayer,"UI:Hideout:Maxed");
        local ButtonGarage=Hideout.Garage.Upgrades[LevelGarage]and Hideout.Garage.Upgrades[LevelGarage].costs or loc(localPlayer,"UI:Hideout:Maxed");
        local ButtonMoneywash=Hideout.Moneywash.Upgrades[LevelMoneywash]and Hideout.Moneywash.Upgrades[LevelMoneywash].costs or loc(localPlayer,"UI:Hideout:Maxed");
        local ButtonDufflebag=Hideout.Dufflebag.Upgrades[LevelDufflebag]and Hideout.Dufflebag.Upgrades[LevelDufflebag].costs or loc(localPlayer,"UI:Hideout:Maxed");
        local ButtonHideout=Hideout.Hideout.Upgrades[LevelHideout]and Hideout.Hideout.Upgrades[LevelHideout].costs or loc(localPlayer,"UI:Hideout:Maxed");
        local ButtonWardrobe=Hideout.Wardrobe.Upgrades[LevelWardrobe]and Hideout.Wardrobe.Upgrades[LevelWardrobe].costs or loc(localPlayer,"UI:Hideout:Maxed");

        executeBrowserJavascript(Browser,[[
			setLanguageHideout(
                ']]..Server.Name..[[',']]..loc(localPlayer,"UI:Hideout:Title")..[[',

                ']]..loc(localPlayer,"UI:Hideout:Requirements")..[[',']]..loc(localPlayer,"UI:Hideout:Benefits")..[[',

                ']]..loc(localPlayer,"UI:Hideout:CategoryGenerator")..[[',']]..loc(localPlayer,"UI:Hideout:CategoryBitcoin")..[[',']]..loc(localPlayer,"UI:Hideout:CategoryWorkbench")..[[',']]..loc(localPlayer,"UI:Hideout:CategoryArmory")..[[',']]..loc(localPlayer,"UI:Hideout:CategoryGarage")..[[',']]..loc(localPlayer,"UI:Hideout:CategoryMoneywash")..[[',']]..loc(localPlayer,"UI:Hideout:CategoryDufflebag")..[[',']]..loc(localPlayer,"UI:Hideout:CategoryHideout")..[[',']]..loc(localPlayer,"UI:Hideout:CategoryWardrobe")..[[',
                ']]..LevelGenerator.." | "..#Hideout.Generator.Upgrades+1 ..[[',']]..LevelBitcoin.." | "..#Hideout.Bitcoin.Upgrades+1 ..[[',']]..LevelWorkbench.." | "..#Hideout.Workbench.Upgrades+1 ..[[',']]..LevelArmory.." | "..#Hideout.Armory.Upgrades+1 ..[[',']]..LevelGarage.." | "..#Hideout.Garage.Upgrades+1 ..[[',']]..LevelMoneywash.." | "..#Hideout.Moneywash.Upgrades+1 ..[[',']]..LevelDufflebag.." | "..#Hideout.Dufflebag.Upgrades+1 ..[[',']]..LevelHideout.." | "..#Hideout.Hideout.Upgrades+1 ..[[',']]..LevelWardrobe.." | "..#Hideout.Wardrobe.Upgrades+1 ..[[',
                
                ']]..loc(localPlayer,"UI:Hideout:ButtonTake")..[[',']]..loc(localPlayer,"UI:Hideout:ButtonPutin")..[['
            );

            setHideoutStuff(
                ']]..ButtonGenerator..[[',']]..ButtonBitcoin..[[',']]..ButtonWorkbench..[[',']]..ButtonArmory..[[',']]..ButtonGarage..[[',']]..ButtonMoneywash..[[',']]..ButtonDufflebag..[[',']]..ButtonHideout..[[',']]..ButtonWardrobe..[['
            );
		]]);
        
        refreshHideout(CurrentSite);
    end,300,1)
end

addEventHandler("Hideout:UI",root,function(type)
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
                loadBrowserURL(Browser,"http://mta/local/Files/UI/Hideout/main.html");
                focusBrowser(Browser);

                addEventHandler("onClientBrowserDocumentReady",BrowserUI,function(url)
                    updateUI();
                end)
            end)
        else
            if(isTimer(CEFTimer))then
                killTimer(CEFTimer);
                CEFTimer=nil;
            end
            guiSetVisible(BrowserUI,true);
            updateUI();
        end
	else
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
	end
end)


addEventHandler("Hideout:Upgrade:C",root,function(type)
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
    
    if(type)then
        triggerServerEvent("Hideout:Upgrade:S",localPlayer,tostring(type));
        updateUI();
    end
end)

addEventHandler("Hideout:Take:C",root,function(item)
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

    if(item)then
        triggerServerEvent("Hideout:Take:S",localPlayer,tostring(item));
    end
end)

addEventHandler("Hideout:TakeLaundry:C",root,function(id)
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

    if(id)then
        triggerServerEvent("Hideout:TakeLaundry:S",localPlayer,tonumber(id));
    end
end)

addEventHandler("Hideout:TakeWeapon:C",root,function(id)
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

    if(id)then
        triggerServerEvent("Hideout:TakeWeapon:S",localPlayer,tonumber(id));
    end
end)

addEventHandler("Hideout:TakeWeaponSkin:C",root,function(item)
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

    if(item)then
        triggerServerEvent("Hideout:TakeWeaponSkin:S",localPlayer,tostring(item));
    end
end)

addEventHandler("Hideout:PutInLaundry:C",root,function(item)
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

    if(item)then
        triggerServerEvent("Hideout:PutInLaundry:S",localPlayer,tostring(item));
    end
end)

addEventHandler("Hideout:Load:RequirementsBenefits",root,function(type)
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
    
    if(type)then
        refreshHideout(type);
    end
end)

addEventHandler("Hideout:Load:Laundry",root,function()
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

    executeBrowserJavascript(Browser,[[
		$('.ItemListItem').empty();
	]]);

    local jsonLaundry=getPlayerJsonTable(localPlayer,"HideLaundry");
    if(jsonLaundry and type(jsonLaundry)=="table")then
        local sortedData={};
        for i,_ in pairs(jsonLaundry)do
            table.insert(sortedData,i);
        end
        
        for count,v in ipairs(sortedData)do
            executeBrowserJavascript(Browser,[[
                laundryQueue(']]..count..[[',']]..comma_value(jsonLaundry[v][1])..[[',']].. jsonLaundry[v][2]-SERVER_TIME..[[');
            ]]);
        end
	end
end)

addEventHandler("Hideout:Load:PedSkins",root,function()
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

    executeBrowserJavascript(Browser,[[
		$('.ItemListItem').empty();
		$('.ItemListItem2').empty();
	]]);

    local jsonWardrobeSkins=getPlayerJsonTable(localPlayer,"PedSkins");
    if(jsonWardrobeSkins and type(jsonWardrobeSkins)=="table")then
        local sortedData={};
        for i,_ in pairs(jsonWardrobeSkins)do
            table.insert(sortedData,i);
        end
        
        for count,v in ipairs(sortedData)do
            if(not jsonWardrobeSkins[v][3])then
                executeBrowserJavascript(Browser,[[
                hideoutPedSkinList(']]..count..[[',']]..jsonWardrobeSkins[v][1]..[[',']]..jsonWardrobeSkins[v][2]..[[');
            ]]);
            end
            if(jsonWardrobeSkins[v][3]and SERVER_TIME<jsonWardrobeSkins[v][3])then
                executeBrowserJavascript(Browser,[[
                    hideoutPedSkinList(']]..count..[[',']]..jsonWardrobeSkins[v][1]..[[',']]..jsonWardrobeSkins[v][2]..[[',']]..jsonWardrobeSkins[v][3]-SERVER_TIME..[[');
                ]]);
            end
        end
	end
end)

addEventHandler("Hideout:Wardrobe:WearSkin:C",root,function(id)
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

    if(id)then
        triggerServerEvent("Hideout:Wardrobe:WearSkin:S",localPlayer,tonumber(id));
    end
end)
addEventHandler("Hideout:Wardrobe:DeleteSkin:C",root,function(id)
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

    if(id)then
        triggerServerEvent("Hideout:Wardrobe:DeleteSkin:S",localPlayer,tonumber(id));
    end
end)
addEventHandler("Hideout:Wardrobe:GrabQueueSkin:C",root,function(id)
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

    if(id)then
        triggerServerEvent("Hideout:Wardrobe:GrabQueueSkin:S",localPlayer,tonumber(id));
    end
end)

addEventHandler("Hideout:Load:Armory",root,function()
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
    
    for i,v in pairs(Hideout.Armory.Weapons)do
        if(i<=tonumber(getPlayerJsonValue(localPlayer,"HideUpgrades","Armory")))then
            executeBrowserJavascript(Browser,[[
                armoryList(']]..v.name..[[',']]..v.id..[[');
            ]]);
        end
    end
end)

addEventHandler("Hideout:Load:WeaponSkins",root,function(id)
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

    executeBrowserJavascript(Browser,[[
        $('.SkinList').empty();
    ]]);
    for item,v in pairs(getPlayerJsonTable(localPlayer,"Items"))do
        if(item:find("Weapon_"..id.."_"))then
            executeBrowserJavascript(Browser,[[
                weaponSkinList(']]..item..[[',']]..loc(localPlayer,"Item:"..item)..[[');
            ]]);
        end
    end
end)










function refreshHideout(type)
    if(not(isLoggedin()))then
		return;
	end
	if(isPedDead(localPlayer))then
		return;
	end
	if(isClickedState(localPlayer)==false)then
        return;
	end
    if(not isElement(BrowserUI))then
        return;
    end

    if(type and type~=true)then
        --Requirements
        if(Hideout[type].Upgrades[tonumber(getPlayerJsonValue(client,"HideUpgrades",tostring(type)))])then
            executeBrowserJavascript(Browser,[[
                $('.RequirementItem').empty();
            ]]);
            for requirementStation,requiredLevel in pairs(Hideout[type].Upgrades[tonumber(getPlayerJsonValue(client,"HideUpgrades",tostring(type)))].requirements)do
                local stationLevel=tonumber(getPlayerJsonValue(client,"HideUpgrades",tostring(requirementStation)));

                if(stationLevel>=requiredLevel)then
                    executeBrowserJavascript(Browser,"$('.RequirementItem').append(`<div class='Requirements-Items'> <div class='Requirements-Item-Text'><i class='MaskGreen fas fa-circle-check'></i> "..loc(localPlayer,tostring(requirementStation)).." </div>`);");
                else
                    executeBrowserJavascript(Browser,"$('.RequirementItem').append(`<div class='Requirements-Items'> <div class='Requirements-Item-Text'><i class='MaskRed fas fa-circle-xmark'></i> "..loc(localPlayer,tostring(requirementStation)).." ("..requiredLevel..") </div>`);");
                end
            end
        end

        --Benefits
        if(Hideout[type].Upgrades[tonumber(getPlayerJsonValue(client,"HideUpgrades",tostring(type)))])then
            executeBrowserJavascript(Browser,"$('.BenefitItem').empty();");
            for i,v in pairs(Hideout[type].Upgrades[tonumber(getPlayerJsonValue(client,"HideUpgrades",tostring(type)))].benefits)do
                executeBrowserJavascript(Browser,"$('.BenefitItem').append(`<div class='Benefits-Items'> <div class='Benefits-Item-Text'> "..loc(localPlayer,"UI:Hideout:Benefit:"..i)..": "..v.." </div>`);");
            end
        end
    end
end


addEventHandler("Hideout:Update",root,function(type,time,amount)
    if(not(isLoggedin()))then
		return;
	end
	if(isPedDead(localPlayer))then
		return;
	end
	if(isClickedState(localPlayer)==false)then
        return;
	end
    if(not isElement(BrowserUI))then
        return;
    end

    if(type and time and amount)then
        executeBrowserJavascript(Browser,[[
            updateHideoutTimers(']]..type..[[',']]..time..[[',']]..amount..[[');
        ]]);
    end
end)

addEventHandler("Hideout:CurrentSide",root,function(site)
    if(not(isLoggedin()))then
		return;
	end
	if(isPedDead(localPlayer))then
		return;
	end
	if(isClickedState(localPlayer)==false)then
        return;
	end
    if(not isElement(BrowserUI))then
        return;
    end
    
    CurrentSite=site;

    executeBrowserJavascript(Browser,[[
        updateHideoutButtons(']]..CurrentSite..[[');
    ]]);
end)