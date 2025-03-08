addRemoteEvents{"Userpanel:UI","Userpanel:LoadItems","Userpanel:LoadItems2","Userpanel:RedeemCode:C",
"Userpanel:ChangeSetting:C",
"Userpanel:Crate:Opening:C",
};--addEvents


local PreviewSound=nil;
local AchievementTier=nil;
local Texts,DataTexts={},{};

local CEFTimer,BrowserUI,Browser=nil,nil,nil;


local function clearUI()
    executeBrowserJavascript(Browser,[[
		$('.NavbarItem').empty();
        $('.ThirdUI').css('display','none');
        $('.ThirdUI-Navbar').css('display','none');
	]]);
end

local function pickupCount(base,pattern)
    return select(2,string.gsub(base,pattern,""));
end

bindKey("F1","DOWN",function()
    if(not(isLoggedin()))then
		return;
	end
	if(isPedDead(localPlayer))then
		return;
	end
    if(not(CEFready))then
        return;
    end

    local CrimeCoin=tonumber(getPlayerJsonValue(localPlayer,"Money","CrimeCoin"))or 0;

    if(isClickedState(localPlayer)==false)then
        setUIdatas("set","cursor");
        if(not(isTimer(CEFTimer)))then
            BrowserUI=guiCreateBrowser(0,0,GLOBALscreenX,GLOBALscreenY,true,true,false,nil);
            Browser=guiGetBrowser(BrowserUI);

            addEventHandler("onClientBrowserCreated",Browser,function()
                loadBrowserURL(Browser,"http://mta/local/Files/UI/Userpanel/main.html");
                focusBrowser(Browser);

                addEventHandler("onClientBrowserDocumentReady",BrowserUI,function(url)
                    executeBrowserJavascript(Browser,[[
                        setCrimeCoinValue(']]..CrimeCoin..[[');

                        setLanguageUserpanel(
                            ']]..Server.Name..[[',']]..loc(localPlayer,"UI:Userpanel:Title")..[[',

                            ']]..loc(localPlayer,"UI:Userpanel:LeaveUI")..[['
                        );
                    ]]);
                    setTimer(function()
                        for _,v in pairs(Userpanel.Categories)do
                            executeBrowserJavascript(Browser,[[
                                loadCategoriesInUserpanel(']]..v.icon..[[',']]..loc(localPlayer,"UI:Userpanel:Category:"..tostring(v.id))..[[',']]..v.id..[[');
                            ]]);
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
            
            executeBrowserJavascript(Browser,[[
                setCrimeCoinValue(']]..CrimeCoin..[[');

                setLanguageUserpanel(
                    ']]..Server.Name..[[',']]..loc(localPlayer,"UI:Userpanel:Title")..[[',
                    
                    ']]..loc(localPlayer,"UI:Userpanel:LeaveUI")..[['
                );
            ]]);
            setTimer(function()
                for _,v in pairs(Userpanel.Categories)do
                    executeBrowserJavascript(Browser,[[
                        loadCategoriesInUserpanel(']]..v.icon..[[',']]..loc(localPlayer,"UI:Userpanel:Category:"..tostring(v.id))..[[',']]..v.id..[[');
                    ]]);
                end
            end,200,1);
        end

        --[[ setDevelopmentMode(true,true);
        toggleBrowserDevTools(Browser,true); ]]
    end
end)

addEventHandler("Userpanel:UI",root,function(type)
    if(type)then
        executeBrowserJavascript(Browser,[[
            setLanguageUserpanel(
                ']]..Server.Name..[[',']]..loc(localPlayer,"UI:Userpanel:Title")..[[',
                
                ']]..loc(localPlayer,"UI:Userpanel:LeaveUI")..[['
            );
        ]]);

        clearUI();

        setTimer(function()
            for _,v in pairs(Userpanel.Categories)do
                executeBrowserJavascript(Browser,[[
                    loadCategoriesInUserpanel(']]..v.icon..[[',']]..loc(localPlayer,"UI:Userpanel:Category:"..tostring(v.id))..[[',']]..v.id..[[');
                ]]);
            end
        end,250,1);
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

        clearUI();
    end
end)

addEventHandler("Userpanel:LoadItems",root,function(id)
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
    if(not(id))then
        return;
    end

    local CrimeCoin=tonumber(getPlayerJsonValue(localPlayer,"Money","CrimeCoin"))or 0;

    if(id=="Character")then
        --Playtime stuff
        local Playtime=getPlayerJsonValue(localPlayer,"Stats","Playtime");
        local PlaytimeMinutes=Playtime-math.floor(Playtime/60)*60;

        playtimehours=math.floor(Playtime/60);
		playtimeminutes=Playtime-playtimehours*60;
		if(playtimeminutes<10)then
			playtimeminutes="0"..playtimeminutes;
		end
		if(playtimehours<10)then
			playtimehours="0"..playtimehours;
		end
        Texts["Payday"]=loc(localPlayer,"UI:Userpanel:Category:Character:TimeTillPayday");
        Texts["Playtime"]=loc(localPlayer,"UI:Userpanel:Category:Character:Playtime");
        DataTexts["PaydayIn"]=math.floor(60-PlaytimeMinutes).." Min.";
		DataTexts["Playtime"]=playtimehours..":"..playtimeminutes;
        
        --Money stuff
        Texts["Cash"]=loc(localPlayer,"UI:Userpanel:Category:Character:MoneyCash");
        Texts["Blackmoney"]=loc(localPlayer,"UI:Userpanel:Category:Character:MoneyBlack");
        DataTexts["Cash"]=getPlayerJsonValue(localPlayer,"Money","Cash")or 0;
        DataTexts["Blackmoney"]=getPlayerJsonValue(localPlayer,"Money","Black")or 0;
        
        --Register date
        Texts["Register"]=loc(localPlayer,"UI:Userpanel:Category:Character:DateRegister");
        DataTexts["Register"]=os.date('%m/%d/%Y %H:%M',getPlayerJsonValue(localPlayer,"Date","Register"))or 0;
        
        --K/D
        Texts["Kills"]=loc(localPlayer,"UI:Userpanel:Category:Character:Kills");
        Texts["Deaths"]=loc(localPlayer,"UI:Userpanel:Category:Character:Deaths");
        Texts["KillsBoss"]=loc(localPlayer,"UI:Userpanel:Category:Character:BossKills");
        Texts["KillsBots"]=loc(localPlayer,"UI:Userpanel:Category:Character:BotKills");
        DataTexts["Kills"]=getPlayerJsonValue(localPlayer,"Stats","Kills")or 0;
        DataTexts["Deaths"]=getPlayerJsonValue(localPlayer,"Stats","Deaths")or 0;
        DataTexts["KillsBoss"]=getPlayerJsonValue(localPlayer,"Stats","BossKills")or 0;
        DataTexts["KillsBots"]=getPlayerJsonValue(localPlayer,"Stats","BotKills")or 0;
        
        executeBrowserJavascript(Browser,[[
            $('.ThirdUIList-Item').empty();
            $('.ThirdUIList2-Item').empty();
            $('.ThirdUIList2-Crate').empty();

            setCrimeCoinValue(']]..CrimeCoin..[[');

            $('.ThirdUIList-Item').append(`<div class='ThirdUIList-ItemBox'> <div class='ThirdUIList-ItemTitle MaskAqua'>]]..Texts["Payday"]..[[</div> <div class='ThirdUIList-ItemText' style='color:rgba(200,200,200,1)'>]]..DataTexts["PaydayIn"]..[[</div> <div class='ThirdUIList-ItemText2' style='color:rgba(200,200,200,1)'><span class='MaskAqua'>]]..Texts["Playtime"]..[[</span> ]]..DataTexts["Playtime"]..[[</div> </div>`);
            $('.ThirdUIList-Item').append(`<div class='ThirdUIList-ItemBox'> <div class='ThirdUIList-ItemTitle MaskAqua'>]]..Texts["Cash"]..[[</div> <div class='ThirdUIList-ItemText' style='color:rgba(200,200,200,1)'>]]..DataTexts["Cash"]..[[</div> <div class='ThirdUIList-ItemText2' style='color:rgba(200,200,200,1)'><span class='MaskAqua'>]]..Texts["Blackmoney"]..[[</span> ]]..DataTexts["Blackmoney"]..[[</div> </div>`);
            $('.ThirdUIList-Item').append(`<div class='ThirdUIList-ItemBox'> <div class='ThirdUIList-ItemTitle MaskAqua'>]]..Texts["Register"]..[[</div> <div class='ThirdUIList-ItemText' style='color:rgba(200,200,200,1)'>]]..DataTexts["Register"]..[[</div> </div>`);
            $('.ThirdUIList-Item').append(`<div class='ThirdUIList-ItemBox'> <div class='ThirdUIList-ItemTitle MaskAqua'>]]..Texts["Kills"]..[[</div> <div class='ThirdUIList-ItemText' style='color:rgba(200,200,200,1)'>]]..DataTexts["Kills"]..[[</div> <div class='ThirdUIList-ItemText2' style='color:rgba(200,200,200,1)'><span class='MaskAqua'>]]..Texts["Deaths"]..[[</span> ]]..DataTexts["Deaths"]..[[</div> </div>`);
            $('.ThirdUIList-Item').append(`<div class='ThirdUIList-ItemBox'> <div class='ThirdUIList-ItemTitle MaskAqua'>]]..Texts["KillsBoss"]..[[</div> <div class='ThirdUIList-ItemText' style='color:rgba(200,200,200,1)'>]]..DataTexts["KillsBoss"]..[[</div> <div class='ThirdUIList-ItemText2' style='color:rgba(200,200,200,1)'><span class='MaskAqua'>]]..Texts["KillsBots"]..[[</span> ]]..DataTexts["KillsBots"]..[[</div> </div>`);
        ]]);



        --Pickups
        local Pickups=getPlayerJsonTable(localPlayer,"Pickups");

        local TextPickupsBonus=loc(localPlayer,"UI:Userpanel:Category:Character:PickupsBonus");
        local TextPickupsBonus2=loc(localPlayer,"UI:Userpanel:Category:Character:PickupsBonus2");
        local CountPickupsBonus=(pickupCount(toJSON(Pickups),"Bonus")or 0);
        local DataBonusPoints=getPlayerJsonValue(localPlayer,"Points","Bonus")or 0;

        local TextPickupsHorseshoe=loc(localPlayer,"UI:Userpanel:Category:Character:PickupsHorseshoe");
        local TextPickupsHorseshoe2=loc(localPlayer,"UI:Userpanel:Category:Character:PickupsHorseshoe2");
        local CountPickupsHorseshoe=(pickupCount(toJSON(Pickups),"Horseshoe")or 0);
        local DataHorseshoePoints=getPlayerJsonValue(localPlayer,"Points","Horseshoe")or 0;

        local TextPickupsShell=loc(localPlayer,"UI:Userpanel:Category:Character:PickupsShell");
        local TextPickupsShell2=loc(localPlayer,"UI:Userpanel:Category:Character:PickupsShell2");
        local CountPickupsShell=(pickupCount(toJSON(Pickups),"Shell")or 0);
        local DataShellPoints=getPlayerJsonValue(localPlayer,"Points","Shell")or 0;

        if(SERVER_TIME<=Server.Settings.Event.Current[2]and Server.Settings.Event.Current[1]~="none")then
            local EventPickups=getPlayerJsonTable(localPlayer,"EventPickups");

            local TextPickupsEvent=loc(localPlayer,"UI:Userpanel:Category:Character:PickupsEvent");
            local TextPickupsEvent2=loc(localPlayer,"UI:Userpanel:Category:Character:PickupsEvent2");
            local CountPickupsEvent=(pickupCount(toJSON(EventPickups),Server.Settings.Event.Datas[Server.Settings.Event.Current[1]])or 0);
            local DataEventPoints=getPlayerJsonValue(localPlayer,"Points",Server.Settings.Event.Datas[Server.Settings.Event.Current[1]])or 0;

            executeBrowserJavascript(Browser,"$('.ThirdUIList-Item').append(`<div class='ThirdUIList-ItemBox'> <div class='ThirdUIList-ItemTitle MaskAqua'>"..TextPickupsEvent.."</div> <div class='ThirdUIList-ItemText' style='color:rgba(200,200,200,1)'>"..CountPickupsEvent.."/"..#Achievements.Pickups[Server.Settings.Event.Datas[Server.Settings.Event.Current[1]]].Coords.." ("..math.floor(math.percent(1,CountPickupsEvent,#Achievements.Pickups[Server.Settings.Event.Datas[Server.Settings.Event.Current[1]]].Coords)).."%)</div> <div class='ThirdUIList-ItemText2' style='color:rgba(200,200,200,1)'><span class='MaskAqua'>"..TextPickupsEvent2.."</span> "..DataEventPoints.."</div> </div>`);");
        end

        executeBrowserJavascript(Browser,[[
            $('.ThirdUIList-Item').append(`<div class='ThirdUIList-ItemBox'> <div class='ThirdUIList-ItemTitle MaskAqua'>]]..TextPickupsBonus..[[</div> <div class='ThirdUIList-ItemText' style='color:rgba(200,200,200,1)'>]]..CountPickupsBonus.."/"..#Achievements.Pickups.Bonus.Coords..[[ (]]..math.floor(math.percent(1,CountPickupsBonus,#Achievements.Pickups.Bonus.Coords))..[[%)</div> <div class='ThirdUIList-ItemText2' style='color:rgba(200,200,200,1)'><span class='MaskAqua'>]]..TextPickupsBonus2..[[</span> ]]..DataBonusPoints..[[</div> </div>`);
            $('.ThirdUIList-Item').append(`<div class='ThirdUIList-ItemBox'> <div class='ThirdUIList-ItemTitle MaskAqua'>]]..TextPickupsHorseshoe..[[</div> <div class='ThirdUIList-ItemText' style='color:rgba(200,200,200,1)'>]]..CountPickupsHorseshoe.."/"..#Achievements.Pickups.Horseshoe.Coords..[[ (]]..math.floor(math.percent(1,CountPickupsHorseshoe,#Achievements.Pickups.Horseshoe.Coords))..[[%)</div> <div class='ThirdUIList-ItemText2' style='color:rgba(200,200,200,1)'><span class='MaskAqua'>]]..TextPickupsHorseshoe2..[[</span> ]]..DataHorseshoePoints..[[</div> </div>`);
            $('.ThirdUIList-Item').append(`<div class='ThirdUIList-ItemBox'> <div class='ThirdUIList-ItemTitle MaskAqua'>]]..TextPickupsShell..[[</div> <div class='ThirdUIList-ItemText' style='color:rgba(200,200,200,1)'>]]..CountPickupsShell.."/"..#Achievements.Pickups.Shell.Coords..[[ (]]..math.floor(math.percent(1,CountPickupsShell,#Achievements.Pickups.Shell.Coords))..[[%)</div> <div class='ThirdUIList-ItemText2' style='color:rgba(200,200,200,1)'><span class='MaskAqua'>]]..TextPickupsShell2..[[</span> ]]..DataShellPoints..[[</div> </div>`);
        ]]);
    end

    if(id=="Levels")then
        executeBrowserJavascript(Browser,[[
            $('.ThirdUIList-Item').empty();
            $('.ThirdUIList2-Item').empty();
            $('.ThirdUIList2-Crate').empty();

            setCrimeCoinValue(']]..CrimeCoin..[[');
        ]]);

        for job,_ in pairs(Jobs)do
            if(job~="Settings")then--blacklist other field they're not jobs
                Texts[job.."LVL"]=loc(localPlayer,"UI:Userpanel:Category:Levels:CurrentLevel"..job);
                Texts[job.."EXP"]=loc(localPlayer,"UI:Userpanel:Category:Levels:CurrentExp"..job);

                if(not(getPlayerNotExistingJsonValue(localPlayer,"Levels","Job"..job.."LVL")))then DataTexts[job.."LVL"]=1; else
                    DataTexts[job.."LVL"]=getPlayerJsonValue(localPlayer,"Levels","Job"..job.."LVL");
                end

                if(Jobs[job].Progress.LevelExp[tonumber(DataTexts[job.."LVL"])]==9999999999)then DataTexts[job.."EXP"]="~"; else
                    DataTexts[job.."EXP"]=(getPlayerJsonValue(localPlayer,"Levels","Job"..job.."EXP")or 0).." / "..Jobs[job].Progress.LevelExp[tonumber(DataTexts[job.."LVL"])].." ("..math.floor(math.percent(1,(getPlayerJsonValue(localPlayer,"Levels","Job"..job.."EXP")or 0),Jobs[job].Progress.LevelExp[tonumber(DataTexts[job.."LVL"])])).."%)";
                end
            end
        end
        
        executeBrowserJavascript(Browser,[[
            $('.ThirdUIList-Item').append(`<div class='ThirdUIList-ItemBox'> <div class='ThirdUIList-ItemTitle MaskAqua'>]]..Texts["MinerLVL"]..[[</div> <div class='ThirdUIList-ItemText' style='color:rgba(200,200,200,1)'>]]..DataTexts["MinerLVL"]..[[</div> <div class='ThirdUIList-ItemText2' style='color:rgba(200,200,200,1)'><span class='MaskAqua'>]]..Texts["MinerEXP"]..[[</span> ]]..DataTexts["MinerEXP"]..[[</div> </div>`);
            $('.ThirdUIList-Item').append(`<div class='ThirdUIList-ItemBox'> <div class='ThirdUIList-ItemTitle MaskAqua'>]]..Texts["DrugDealerLVL"]..[[</div> <div class='ThirdUIList-ItemText' style='color:rgba(200,200,200,1)'>]]..DataTexts["DrugDealerLVL"]..[[</div> <div class='ThirdUIList-ItemText2' style='color:rgba(200,200,200,1)'><span class='MaskAqua'>]]..Texts["DrugDealerEXP"]..[[</span> ]]..DataTexts["DrugDealerEXP"]..[[</div> </div>`);
            $('.ThirdUIList-Item').append(`<div class='ThirdUIList-ItemBox'> <div class='ThirdUIList-ItemTitle MaskAqua'>]]..Texts["LogisticLVL"]..[[</div> <div class='ThirdUIList-ItemText' style='color:rgba(200,200,200,1)'>]]..DataTexts["LogisticLVL"]..[[</div> <div class='ThirdUIList-ItemText2' style='color:rgba(200,200,200,1)'><span class='MaskAqua'>]]..Texts["LogisticEXP"]..[[</span> ]]..DataTexts["LogisticEXP"]..[[</div> </div>`);
            $('.ThirdUIList-Item').append(`<div class='ThirdUIList-ItemBox'> <div class='ThirdUIList-ItemTitle MaskAqua'>]]..Texts["OrangeCollectorLVL"]..[[</div> <div class='ThirdUIList-ItemText' style='color:rgba(200,200,200,1)'>]]..DataTexts["OrangeCollectorLVL"]..[[</div> <div class='ThirdUIList-ItemText2' style='color:rgba(200,200,200,1)'><span class='MaskAqua'>]]..Texts["OrangeCollectorEXP"]..[[</span> ]]..DataTexts["OrangeCollectorEXP"]..[[</div> </div>`);
            $('.ThirdUIList-Item').append(`<div class='ThirdUIList-ItemBox'> <div class='ThirdUIList-ItemTitle MaskAqua'>]]..Texts["AppleCollectorLVL"]..[[</div> <div class='ThirdUIList-ItemText' style='color:rgba(200,200,200,1)'>]]..DataTexts["AppleCollectorLVL"]..[[</div> <div class='ThirdUIList-ItemText2' style='color:rgba(200,200,200,1)'><span class='MaskAqua'>]]..Texts["AppleCollectorEXP"]..[[</span> ]]..DataTexts["AppleCollectorEXP"]..[[</div> </div>`);
            $('.ThirdUIList-Item').append(`<div class='ThirdUIList-ItemBox'> <div class='ThirdUIList-ItemTitle MaskAqua'>]]..Texts["PearCollectorLVL"]..[[</div> <div class='ThirdUIList-ItemText' style='color:rgba(200,200,200,1)'>]]..DataTexts["PearCollectorLVL"]..[[</div> <div class='ThirdUIList-ItemText2' style='color:rgba(200,200,200,1)'><span class='MaskAqua'>]]..Texts["PearCollectorEXP"]..[[</span> ]]..DataTexts["PearCollectorEXP"]..[[</div> </div>`);
            $('.ThirdUIList-Item').append(`<div class='ThirdUIList-ItemBox'> <div class='ThirdUIList-ItemTitle MaskAqua'>]]..Texts["CoconutCollectorLVL"]..[[</div> <div class='ThirdUIList-ItemText' style='color:rgba(200,200,200,1)'>]]..DataTexts["CoconutCollectorLVL"]..[[</div> <div class='ThirdUIList-ItemText2' style='color:rgba(200,200,200,1)'><span class='MaskAqua'>]]..Texts["CoconutCollectorEXP"]..[[</span> ]]..DataTexts["CoconutCollectorEXP"]..[[</div> </div>`);
        ]]);
    end

    if(id=="Achievements")then
        executeBrowserJavascript(Browser,[[
            $('.ThirdUIList-Item').empty();
            $('.ThirdUIList2-Item').empty();
            $('.ThirdUIList2-Crate').empty();
            $('.ThirdUI-NavbarItem').empty();

            setCrimeCoinValue(']]..CrimeCoin..[[');
        ]]);

        for _,v in pairs(Achievements.Achievements)do
            executeBrowserJavascript(Browser,[[
                loadSubCategoriesInUserpanel('',']]..loc(localPlayer,"UI:Userpanel:Achievement:Display:"..v.ID)..[[',']]..v.ID..[[');
            ]]);
        end
    end

    if(id=="Settings")then
        executeBrowserJavascript(Browser,[[
            $('.ThirdUIList-Item').empty();
            $('.ThirdUIList2-Item').empty();
            $('.ThirdUIList2-Crate').empty();
            $('.ThirdUI-NavbarItem').empty();

            setCrimeCoinValue(']]..CrimeCoin..[[');
        ]]);

        for _,v in pairs(Userpanel.SubCategories[id])do
            executeBrowserJavascript(Browser,[[
                loadSubCategoriesInUserpanel(']]..v.icon..[[',']]..loc(localPlayer,"UI:Userpanel:SubCategory:"..tostring(v.id))..[[',']]..v.id..[[');
            ]]);
        end
    end

    if(id=="Premium")then
        executeBrowserJavascript(Browser,[[
            $('.ThirdUIList-Item').empty();
            $('.ThirdUIList2-Item').empty();
            $('.ThirdUIList2-Crate').empty();
            $('.ThirdUI-NavbarItem').empty();

            setCrimeCoinValue(']]..CrimeCoin..[[');
        ]]);

        for _,v in pairs(Userpanel.SubCategories[id])do
            executeBrowserJavascript(Browser,[[
                loadSubCategoriesInUserpanel(']]..v.icon..[[',']]..loc(localPlayer,"UI:Userpanel:SubCategory:"..tostring(v.id))..[[',']]..v.id..[[');
            ]]);
        end
    end
end)

addEventHandler("Userpanel:LoadItems2",root,function(id)
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
    if(not(id))then
        return;
    end

    if(id=="Language" or id=="Hitbell" or id=="Hitmarker" or id=="CrosshairNormal" or id=="CrosshairSniper" or id=="WindowsNotifications" or id=="Premium" or id=="Effects" or id=="Shaders")then
        executeBrowserJavascript(Browser,[[
            $('.ThirdUIList2-Item').empty();
            $('.ThirdUIList2-Crate').empty();
        ]]);

        for _,v in pairs(Userpanel.Settings[id])do
            local Title="";
            local Type=(v.type or "nil");
            if(v.type)then
                if(loc(localPlayer,"UI:Userpanel:SettingTitle:"..v.type)=="N/A")then
                    Title=v.type;
                else
                    Title=loc(localPlayer,"UI:Userpanel:SettingTitle:"..v.type);
                end
            end

            local Text="";
            if(loc(localPlayer,"UI:Userpanel:"..v.name)=="N/A")then
                Text=v.name;
            else
                Text=loc(localPlayer,"UI:Userpanel:"..v.name);
            end

            if(v.icon)then
                executeBrowserJavascript(Browser,[[
                    loadSubCategoryItemsInUserpanel(']]..id..[[',']]..v.icon..[[',']]..Title..[[',']]..Text..[[',']]..v.value..[[',']]..Type..[[');
                ]]);
            elseif(v.image)then
                executeBrowserJavascript(Browser,[[
                    loadSubCategoryItemsInUserpanel(']]..id..[[',']]..v.image..[[',']]..Title..[[',']]..Text..[[',']]..v.value..[[',']]..Type..[[');
                ]]);
            end
        end
    elseif(id=="Crates")then
        executeBrowserJavascript(Browser,[[
            $('.ThirdUIList2-Item').empty();
            $('.ThirdUIList2-Crate').empty();
        ]]);

        for _,v in pairs(Userpanel.Premium[id])do
            local Text="";
            if(loc(localPlayer,"UI:Userpanel:Crate_"..v.value)=="N/A")then
                Text=v.name;
            else
                Text=loc(localPlayer,"UI:Userpanel:Crate_"..v.value);
            end

            executeBrowserJavascript(Browser,[[
                setUserpanelCratePrices(']]..v.value..[[',']]..v.price..[[');
                loadSubCategoryCratesInUserpanel(
                    ']]..id..[[',']]..v.image..[[',']]..Text..[[',']]..v.value..[[',']]..loc(localPlayer,"UI:Userpanel:CrateButtonOpen"):format(v.price)..[['
                );
            ]]);
        end
        
    else--Achievements
        if(not(getPlayerNotExistingJsonValue(localPlayer,"Achievements",tostring(id))))then
            AchievementTier=0;
        else
            AchievementTier=getPlayerJsonValue(localPlayer,"Achievements",tostring(id));
        end

        for _,v in pairs(Achievements.Achievements)do
            if(v.ID==tostring(id))then
                if(v.Identifier)then
                    executeBrowserJavascript(Browser,[[
                        loadAchievementItemsInUserpanel(
                            ']]..loc(localPlayer,"UI:Userpanel:Achievement:Display:"..id)..[[',']]..loc(localPlayer,"UI:Userpanel:Achievement:Desc:"..id)..[[',']]..loc(localPlayer,"UI:Userpanel:Achievement:Reached")..[[',']]..(getPlayerJsonValue(localPlayer,v.Identifier[1],v.Identifier[2])or 0)..[[',']]..AchievementTier..[[',']]..toJSON(v)..[['
                        );
                    ]]);
                end
                if(not(v.Identifier))then
                    executeBrowserJavascript(Browser,[[
                        loadAchievementItemsInUserpanel(
                            ']]..loc(localPlayer,"UI:Userpanel:Achievement:Display:"..id)..[[',']]..loc(localPlayer,"UI:Userpanel:Achievement:Desc:"..id)..[[',']]..loc(localPlayer,"UI:Userpanel:Achievement:Reached")..[[','nil',']]..AchievementTier..[[',']]..toJSON(v)..[['
                        );
                    ]]);
                end
            end
        end
    end
end)

addEventHandler("Userpanel:RedeemCode:C",root,function(code)
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
    if(not(code)or code=="")then
        return;
    end

    triggerServerEvent("Userpanel:RedeemCode:S",localPlayer,tostring(code));
end)

addEventHandler("Userpanel:Crate:Opening:C",root,function(type,crate,item,amount,name)
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
    if(not(crate))then
        return;
    end
    
    local CrimeCoin=tonumber(getPlayerJsonValue(localPlayer,"Money","CrimeCoin"))or 0;
    executeBrowserJavascript(Browser,"setCrimeCoinValue('"..CrimeCoin.."');");
    
    triggerServerEvent("Userpanel:Crate:Opening:S",localPlayer,tostring(type),tonumber(crate),item,tonumber(amount),tostring(name));
end)

addEventHandler("Userpanel:ChangeSetting:C",root,function(category,type,id)
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
    if(not(category))then
        return;
    end
    if(not(id))then
        return;
    end

    if(type)then
        triggerServerEvent("Userpanel:ChangeSetting:S",localPlayer,tostring(category),type,tonumber(id));
    else
        triggerServerEvent("Userpanel:ChangeSetting:S",localPlayer,tostring(category),nil,tonumber(id));
    end

    if(category=="Hitbell")then
        if(isElement(PreviewSound))then
            destroyElement(PreviewSound);
            PreviewSound=nil;
        end

        if(tonumber(id)~=0)then
            PreviewSound=playSound(":"..RESOURCE_NAME.."/Files/Audio/Hitbell/"..id..".mp3");
            setSoundVolume(PreviewSound,0.6);
        end
    elseif(category=="Language")then
        if(fileExists(":"..RESOURCE_NAME.."/ClientFiles/language.txt"))then
            fileDelete(":"..RESOURCE_NAME.."/ClientFiles/language.txt");
        end
        local DataFileLanguage=fileCreate(":"..RESOURCE_NAME.."/ClientFiles/language.txt");
        fileWrite(DataFileLanguage,tostring(id));
        fileClose(DataFileLanguage);
    end
end)






addEventHandler("onClientPlayerWasted",root,function()
	if(source==localPlayer)then
		if(isElement(BrowserUI))then
			destroyElement(BrowserUI);
			BrowserUI=nil;
			setUIdatas("rem","cursor");
		end
	end
end)