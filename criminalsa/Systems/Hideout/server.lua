addRemoteEvents{"Hideout:Upgrade:S","Hideout:Take:S","Hideout:TakeLaundry:S","Hideout:TakeWeapon:S","Hideout:TakeWeaponSkin:S","Hideout:PutInLaundry:S",
"Hideout:Wardrobe:WearSkin:S","Hideout:Wardrobe:DeleteSkin:S","Hideout:Wardrobe:GrabQueueSkin:S"};--addEvents


local UpgradeReady={};
local CanEquip={};
local Timer={};
local WardrobeFilterCount={};


addEventHandler("Hideout:Upgrade:S",root,function(type)
    if(client and isElement(client)and getElementType(client)=="player" and isLoggedin(client))then
        if(type=="Workbench")then
            if(tonumber(getPlayerJsonValue(client,"HideUpgrades","Workbench"))<#Hideout.Workbench.Upgrades+1)then
                UpgradeReady[client]=true;
                for requirementStation,requiredLevel in pairs(Hideout.Workbench.Upgrades[tonumber(getPlayerJsonValue(client,"HideUpgrades","Workbench"))].requirements)do
                    local stationLevel=tonumber(getPlayerJsonValue(client,"HideUpgrades",tostring(requirementStation)));
            
                    if(stationLevel>=requiredLevel)then else UpgradeReady[client]=false;end
                end

                if(UpgradeReady[client])then
                    if(tonumber(getPlayerJsonValue(client,"Money","Cash"))>=Hideout.Workbench.Upgrades[tonumber(getPlayerJsonValue(client,"HideUpgrades","Workbench"))].costs)then
                        removePlayerJsonValue(client,"Money","Cash",Hideout.Workbench.Upgrades[tonumber(getPlayerJsonValue(client,"HideUpgrades","Workbench"))].costs);
                        triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Hideout:UpgradeSuccess"),"success",4000);
                        addPlayerJsonValue(client,"HideUpgrades","Workbench",1);
                        triggerClientEvent(client,"Hideout:Load:Upgrades",client);
                        addAchievement(client,"firsthideoutupgrade");

                        sendDiscordMessage({
                            ID=7, Title="Hideout upgrade", Desc=getPlayerName(client).." has bought a workbench upgrade. ("..getPlayerJsonValue(client,"HideUpgrades","Workbench").."/"..#Hideout.Workbench.Upgrades+1 ..")",
                            PlayerData={Name=getPlayerName(client),Serial=getPlayerSerial(client),},
                        })
                    else
                        triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Hideout:NotEnoughMoney"):format(Hideout.Workbench.Upgrades[tonumber(getPlayerJsonValue(client,"HideUpgrades","Workbench"))].costs),"error",4000);
                    end
                else
                    triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Hideout:CantUpgrade"),"error",4000);
                end
            else
                triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Hideout:Maxed"),"error",4000);
            end
        elseif(type=="Bitcoin")then
            if(tonumber(getPlayerJsonValue(client,"HideUpgrades","Bitcoin"))<#Hideout.Bitcoin.Upgrades+1)then
                UpgradeReady[client]=true;
                for requirementStation,requiredLevel in pairs(Hideout.Bitcoin.Upgrades[tonumber(getPlayerJsonValue(client,"HideUpgrades","Bitcoin"))].requirements)do
                    local stationLevel=tonumber(getPlayerJsonValue(client,"HideUpgrades",tostring(requirementStation)));
            
                    if(stationLevel>=requiredLevel)then else UpgradeReady[client]=false;end
                end

                if(UpgradeReady[client])then
                    if(tonumber(getPlayerJsonValue(client,"Money","Cash"))>=Hideout.Bitcoin.Upgrades[tonumber(getPlayerJsonValue(client,"HideUpgrades","Bitcoin"))].costs)then
                        removePlayerJsonValue(client,"Money","Cash",Hideout.Bitcoin.Upgrades[tonumber(getPlayerJsonValue(client,"HideUpgrades","Bitcoin"))].costs);
                        triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Hideout:UpgradeSuccess"),"success",4000);
                        addPlayerJsonValue(client,"HideUpgrades","Bitcoin",1);
                        triggerClientEvent(client,"Hideout:Load:Upgrades",client);
                        addAchievement(client,"firsthideoutupgrade");

                        sendDiscordMessage({
                            ID=7, Title="Hideout upgrade", Desc=getPlayerName(client).." has bought a bitcoin upgrade. ("..getPlayerJsonValue(client,"HideUpgrades","Bitcoin").."/"..#Hideout.Bitcoin.Upgrades+1 ..")",
                            PlayerData={Name=getPlayerName(client),Serial=getPlayerSerial(client),},
                        })

                        setPlayerJsonValue(client,"HideTimers","Bitcoin",os.time()+Hideout.Bitcoin.MiningSettings[tonumber(getPlayerJsonValue(client,"HideUpgrades","Bitcoin"))].timer);

                        HideoutStartMining(client);
                    else
                        triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Hideout:NotEnoughMoney"):format(Hideout.Bitcoin.Upgrades[tonumber(getPlayerJsonValue(client,"HideUpgrades","Bitcoin"))].costs),"error",4000);
                    end
                else
                    triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Hideout:CantUpgrade"),"error",4000);
                end
            else
                triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Hideout:Maxed"),"error",4000);
            end
        elseif(type=="Generator")then
            if(tonumber(getPlayerJsonValue(client,"HideUpgrades","Generator"))<#Hideout.Generator.Upgrades+1)then
                UpgradeReady[client]=true;
                for requirementStation,requiredLevel in pairs(Hideout.Generator.Upgrades[tonumber(getPlayerJsonValue(client,"HideUpgrades","Generator"))].requirements)do
                    local stationLevel=tonumber(getPlayerJsonValue(client,"HideUpgrades",tostring(requirementStation)));
            
                    if(stationLevel>=requiredLevel)then else UpgradeReady[client]=false;end
                end

                if(UpgradeReady[client])then
                    if(tonumber(getPlayerJsonValue(client,"Money","Cash"))>=Hideout.Generator.Upgrades[tonumber(getPlayerJsonValue(client,"HideUpgrades","Generator"))].costs)then
                        removePlayerJsonValue(client,"Money","Cash",Hideout.Generator.Upgrades[tonumber(getPlayerJsonValue(client,"HideUpgrades","Generator"))].costs);
                        triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Hideout:UpgradeSuccess"),"success",4000);
                        addPlayerJsonValue(client,"HideUpgrades","Generator",1);
                        triggerClientEvent(client,"Hideout:Load:Upgrades",client);
                        addAchievement(client,"firsthideoutupgrade");

                        sendDiscordMessage({
                            ID=7, Title="Hideout upgrade", Desc=getPlayerName(client).." has bought a generator upgrade. ("..getPlayerJsonValue(client,"HideUpgrades","Generator").."/"..#Hideout.Generator.Upgrades+1 ..")",
                            PlayerData={Name=getPlayerName(client),Serial=getPlayerSerial(client),},
                        })
                    else
                        triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Hideout:NotEnoughMoney"):format(Hideout.Generator.Upgrades[tonumber(getPlayerJsonValue(client,"HideUpgrades","Generator"))].costs),"error",4000);
                    end
                else
                    triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Hideout:CantUpgrade"),"error",4000);
                end
            else
                triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Hideout:Maxed"),"error",4000);
            end
        elseif(type=="Armory")then
            if(tonumber(getPlayerJsonValue(client,"HideUpgrades","Armory"))<#Hideout.Armory.Upgrades+1)then
                UpgradeReady[client]=true;
                for requirementStation,requiredLevel in pairs(Hideout.Armory.Upgrades[tonumber(getPlayerJsonValue(client,"HideUpgrades","Armory"))].requirements)do
                    local stationLevel=tonumber(getPlayerJsonValue(client,"HideUpgrades",tostring(requirementStation)));
            
                    if(stationLevel>=requiredLevel)then else UpgradeReady[client]=false;end
                end

                if(UpgradeReady[client])then
                    if(tonumber(getPlayerJsonValue(client,"Money","Cash"))>=Hideout.Armory.Upgrades[tonumber(getPlayerJsonValue(client,"HideUpgrades","Armory"))].costs)then
                        removePlayerJsonValue(client,"Money","Cash",Hideout.Armory.Upgrades[tonumber(getPlayerJsonValue(client,"HideUpgrades","Armory"))].costs);
                        triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Hideout:UpgradeSuccess"),"success",4000);
                        addPlayerJsonValue(client,"HideUpgrades","Armory",1);
                        triggerClientEvent(client,"Hideout:Load:Upgrades",client);
                        addAchievement(client,"firsthideoutupgrade");

                        sendDiscordMessage({
                            ID=7, Title="Hideout upgrade", Desc=getPlayerName(client).." has bought a armory upgrade. ("..getPlayerJsonValue(client,"HideUpgrades","Armory").."/"..#Hideout.Armory.Upgrades+1 ..")",
                            PlayerData={Name=getPlayerName(client),Serial=getPlayerSerial(client),},
                        })
                    else
                        triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Hideout:NotEnoughMoney"):format(Hideout.Armory.Upgrades[tonumber(getPlayerJsonValue(client,"HideUpgrades","Armory"))].costs),"error",4000);
                    end
                else
                    triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Hideout:CantUpgrade"),"error",4000);
                end
            else
                triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Hideout:Maxed"),"error",4000);
            end
        elseif(type=="Garage")then
            if(tonumber(getPlayerJsonValue(client,"HideUpgrades","Garage"))<#Hideout.Garage.Upgrades+1)then
                UpgradeReady[client]=true;
                for requirementStation,requiredLevel in pairs(Hideout.Garage.Upgrades[tonumber(getPlayerJsonValue(client,"HideUpgrades","Garage"))].requirements)do
                    local stationLevel=tonumber(getPlayerJsonValue(client,"HideUpgrades",tostring(requirementStation)));
            
                    if(stationLevel>=requiredLevel)then else UpgradeReady[client]=false;end
                end

                if(UpgradeReady[client])then
                    if(tonumber(getPlayerJsonValue(client,"Money","Cash"))>=Hideout.Garage.Upgrades[tonumber(getPlayerJsonValue(client,"HideUpgrades","Garage"))].costs)then
                        removePlayerJsonValue(client,"Money","Cash",Hideout.Garage.Upgrades[tonumber(getPlayerJsonValue(client,"HideUpgrades","Garage"))].costs);
                        triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Hideout:UpgradeSuccess"),"success",4000);
                        addPlayerJsonValue(client,"HideUpgrades","Garage",1);
                        triggerClientEvent(client,"Hideout:Load:Upgrades",client);
                        addAchievement(client,"firsthideoutupgrade");

                        sendDiscordMessage({
                            ID=7, Title="Hideout upgrade", Desc=getPlayerName(client).." has bought a garage upgrade. ("..getPlayerJsonValue(client,"HideUpgrades","Garage").."/"..#Hideout.Garage.Upgrades+1 ..")",
                            PlayerData={Name=getPlayerName(client),Serial=getPlayerSerial(client),},
                        })
                    else
                        triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Hideout:NotEnoughMoney"):format(Hideout.Garage.Upgrades[tonumber(getPlayerJsonValue(client,"HideUpgrades","Garage"))].costs),"error",4000);
                    end
                else
                    triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Hideout:CantUpgrade"),"error",4000);
                end
            else
                triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Hideout:Maxed"),"error",4000);
            end
        elseif(type=="Moneywash")then
            if(tonumber(getPlayerJsonValue(client,"HideUpgrades","Moneywash"))<#Hideout.Moneywash.Upgrades+1)then
                UpgradeReady[client]=true;
                for requirementStation,requiredLevel in pairs(Hideout.Moneywash.Upgrades[tonumber(getPlayerJsonValue(client,"HideUpgrades","Moneywash"))].requirements)do
                    local stationLevel=tonumber(getPlayerJsonValue(client,"HideUpgrades",tostring(requirementStation)));
            
                    if(stationLevel>=requiredLevel)then else UpgradeReady[client]=false;end
                end

                if(UpgradeReady[client])then
                    if(tonumber(getPlayerJsonValue(client,"Money","Cash"))>=Hideout.Moneywash.Upgrades[tonumber(getPlayerJsonValue(client,"HideUpgrades","Moneywash"))].costs)then
                        removePlayerJsonValue(client,"Money","Cash",Hideout.Moneywash.Upgrades[tonumber(getPlayerJsonValue(client,"HideUpgrades","Moneywash"))].costs);
                        triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Hideout:UpgradeSuccess"),"success",4000);
                        addPlayerJsonValue(client,"HideUpgrades","Moneywash",1);
                        triggerClientEvent(client,"Hideout:Load:Upgrades",client);
                        addAchievement(client,"firsthideoutupgrade");

                        sendDiscordMessage({
                            ID=7, Title="Hideout upgrade", Desc=getPlayerName(client).." has bought a moneywash upgrade. ("..getPlayerJsonValue(client,"HideUpgrades","Moneywash").."/"..#Hideout.Moneywash.Upgrades+1 ..")",
                            PlayerData={Name=getPlayerName(client),Serial=getPlayerSerial(client),},
                        })
                    else
                        triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Hideout:NotEnoughMoney"):format(Hideout.Moneywash.Upgrades[tonumber(getPlayerJsonValue(client,"HideUpgrades","Moneywash"))].costs),"error",4000);
                    end
                else
                    triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Hideout:CantUpgrade"),"error",4000);
                end
            else
                triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Hideout:Maxed"),"error",4000);
            end
        elseif(type=="Dufflebag")then
            if(tonumber(getPlayerJsonValue(client,"HideUpgrades","Dufflebag"))<#Hideout.Dufflebag.Upgrades+1)then
                UpgradeReady[client]=true;
                for requirementStation,requiredLevel in pairs(Hideout.Dufflebag.Upgrades[tonumber(getPlayerJsonValue(client,"HideUpgrades","Dufflebag"))].requirements)do
                    local stationLevel=tonumber(getPlayerJsonValue(client,"HideUpgrades",tostring(requirementStation)));
            
                    if(stationLevel>=requiredLevel)then else UpgradeReady[client]=false;end
                end

                if(UpgradeReady[client])then
                    if(tonumber(getPlayerJsonValue(client,"Money","Cash"))>=Hideout.Dufflebag.Upgrades[tonumber(getPlayerJsonValue(client,"HideUpgrades","Dufflebag"))].costs)then
                        removePlayerJsonValue(client,"Money","Cash",Hideout.Dufflebag.Upgrades[tonumber(getPlayerJsonValue(client,"HideUpgrades","Dufflebag"))].costs);
                        triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Hideout:UpgradeSuccess"),"success",4000);
                        addPlayerJsonValue(client,"HideUpgrades","Dufflebag",1);
                        addAchievement(client,"firsthideoutupgrade");

                        sendDiscordMessage({
                            ID=7, Title="Hideout upgrade", Desc=getPlayerName(client).." has bought a dufflebag upgrade. ("..getPlayerJsonValue(client,"HideUpgrades","Dufflebag").."/"..#Hideout.Dufflebag.Upgrades+1 ..")",
                            PlayerData={Name=getPlayerName(client),Serial=getPlayerSerial(client),},
                        })
                    else
                        triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Hideout:NotEnoughMoney"):format(Hideout.Dufflebag.Upgrades[tonumber(getPlayerJsonValue(client,"HideUpgrades","Dufflebag"))].costs),"error",4000);
                    end
                else
                    triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Hideout:CantUpgrade"),"error",4000);
                end
            else
                triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Hideout:Maxed"),"error",4000);
            end
        elseif(type=="Hideout")then
            if(tonumber(getPlayerJsonValue(client,"HideUpgrades","Hideout"))<#Hideout.Hideout.Upgrades+1)then
                UpgradeReady[client]=true;
                for requirementStation,requiredLevel in pairs(Hideout.Hideout.Upgrades[tonumber(getPlayerJsonValue(client,"HideUpgrades","Hideout"))].requirements)do
                    local stationLevel=tonumber(getPlayerJsonValue(client,"HideUpgrades",tostring(requirementStation)));
            
                    if(stationLevel>=requiredLevel)then else UpgradeReady[client]=false;end
                end

                if(UpgradeReady[client])then
                    if(tonumber(getPlayerJsonValue(client,"Money","Cash"))>=Hideout.Hideout.Upgrades[tonumber(getPlayerJsonValue(client,"HideUpgrades","Hideout"))].costs)then
                        removePlayerJsonValue(client,"Money","Cash",Hideout.Hideout.Upgrades[tonumber(getPlayerJsonValue(client,"HideUpgrades","Hideout"))].costs);
                        triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Hideout:UpgradeSuccess"),"success",4000);
                        addPlayerJsonValue(client,"HideUpgrades","Hideout",1);
                        triggerClientEvent(client,"Hideout:Load",client,getElementData(client,"Player:Data:TempID"));
                        for data,value in pairs(Hideout.ResetDatas)do
                            setPlayerJsonValue(client,"HideUpgrades",tostring(data),value);
                        end
                        addAchievement(client,"firsthideoutupgrade");

                        local Table=Hideout_DefaultStuffCoords;
                        local HideoutTier=tonumber(getPlayerJsonValue(client,"HideUpgrades","Hideout"));
                        setElementPosition(client,Table[HideoutTier].MarkerOut[1],Table[HideoutTier].MarkerOut[2],Table[HideoutTier].MarkerOut[3]);

                        sendDiscordMessage({
                            ID=7, Title="Hideout upgrade", Desc=getPlayerName(client).." has bought a hideout upgrade. ("..getPlayerJsonValue(client,"HideUpgrades","Hideout").."/"..#Hideout.Hideout.Upgrades+1 ..")",
                            PlayerData={Name=getPlayerName(client),Serial=getPlayerSerial(client),},
                        })
                    else
                        triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Hideout:NotEnoughMoney"):format(Hideout.Hideout.Upgrades[tonumber(getPlayerJsonValue(client,"HideUpgrades","Hideout"))].costs),"error",4000);
                    end
                else
                    triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Hideout:CantUpgrade"),"error",4000);
                end
            else
                triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Hideout:Maxed"),"error",4000);
            end
        elseif(type=="Wardrobe")then
            if(tonumber(getPlayerJsonValue(client,"HideUpgrades","Wardrobe"))<#Hideout.Wardrobe.Upgrades+1)then
                UpgradeReady[client]=true;
                for requirementStation,requiredLevel in pairs(Hideout.Wardrobe.Upgrades[tonumber(getPlayerJsonValue(client,"HideUpgrades","Wardrobe"))].requirements)do
                    local stationLevel=tonumber(getPlayerJsonValue(client,"HideUpgrades",tostring(requirementStation)));
            
                    if(stationLevel>=requiredLevel)then else UpgradeReady[client]=false;end
                end

                if(UpgradeReady[client])then
                    if(tonumber(getPlayerJsonValue(client,"Money","Cash"))>=Hideout.Wardrobe.Upgrades[tonumber(getPlayerJsonValue(client,"HideUpgrades","Wardrobe"))].costs)then
                        removePlayerJsonValue(client,"Money","Cash",Hideout.Wardrobe.Upgrades[tonumber(getPlayerJsonValue(client,"HideUpgrades","Wardrobe"))].costs);
                        triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Hideout:UpgradeSuccess"),"success",4000);
                        addPlayerJsonValue(client,"HideUpgrades","Wardrobe",1);
                        triggerClientEvent(client,"Hideout:Load:Upgrades",client);
                        addAchievement(client,"firsthideoutupgrade");

                        sendDiscordMessage({
                            ID=7, Title="Hideout upgrade", Desc=getPlayerName(client).." has bought a wardrobe upgrade. ("..getPlayerJsonValue(client,"HideUpgrades","Wardrobe").."/"..#Hideout.Wardrobe.Upgrades+1 ..")",
                            PlayerData={Name=getPlayerName(client),Serial=getPlayerSerial(client),},
                        })
                    else
                        triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Hideout:NotEnoughMoney"):format(Hideout.Wardrobe.Upgrades[tonumber(getPlayerJsonValue(client,"HideUpgrades","Wardrobe"))].costs),"error",4000);
                    end
                else
                    triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Hideout:CantUpgrade"),"error",4000);
                end
            else
                triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Hideout:Maxed"),"error",4000);
            end
        end


        local hideoutUpgrades={"Hideout","Workbench","Generator","Bitcoin","Armory","Garage","Moneywash","Dufflebag","Wardrobe"};
        local count=0;
        for data2,_ in pairs(Hideout)do
            if(data2~="Out" and data2~="ResetDatas" and data2~="SpawnPoints")then
                if(tonumber(getPlayerJsonValue(client,"HideUpgrades",tostring(data2)))==#Hideout[data2].Upgrades+1)then
                    count=count+1;

                    if(count==#hideoutUpgrades)then
                        addAchievement(client,"maxedouthideout");
                    end
                end
            end
        end
    end
end)

addEventHandler("Hideout:Take:S",root,function(item)
    if(client and isElement(client)and getElementType(client)=="player" and isLoggedin(client))then
        if(item=="Bitcoin")then
            if(tonumber(getPlayerJsonValue(client,"HideUpgrades",item))>0)then
                if(getPlayerJsonValue(client,"HideItems",tostring(item))>0)then
                    addPlayerJsonValue(client,"Items",tostring(item),getPlayerJsonValue(client,"HideItems",tostring(item)));
                    setPlayerJsonValue(client,"HideItems",tostring(item),tonumber(0));
                end
            else
                triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Hideout:CantUseThisFuction"),"error",4000);
            end
        end
    end
end)



addEventHandler("Hideout:TakeWeapon:S",root,function(id)
    if(client and isElement(client)and getElementType(client)=="player" and isLoggedin(client))then
        if(tonumber(getPlayerJsonValue(client,"HideUpgrades","Armory"))>0)then
            CanEquip[client]=true;

            if(id==50 or id==100)then
                if(PLAYER_EQUIPPED_ARMOR[client]and PLAYER_EQUIPPED_ARMOR[client]==id)then
                    triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Hideout:AlreadyEquipped"),"error",4000);
                else
                    setPedArmor(client,id);
                    triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Hideout:ArmorEquipped"):format(id.."%"),"success",4000);

                    PLAYER_EQUIPPED_ARMOR[client]=id;
                end
            else
                --[[ for i,v in ipairs(getPedWeapons(client)) do
                    if(v==id)then
                        CanEquip[client]=false;
                    end
                end ]]

                --if(CanEquip[client])then
                    giveWeapon(client,tonumber(id),Hideout.Armory.MaxAmmo[tonumber(getPlayerJsonValue(client,"HideUpgrades","Armory"))]);
                    triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Hideout:WeaponEquipped"):format(getWeaponNameFromID(tonumber(id))),"success",4000);

                    triggerClientEvent(client,"Weapon:Skin:Load",client,client,tonumber(id),getPlayerJsonValue(client,"WeaponSkins",tostring(id)));
                --else
                --    triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Hideout:AlreadyEquipped"),"error",4000);
                --end
            end
        else
            triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Hideout:CantUseThisFuction"),"error",4000);    
        end
    end
end)

addEventHandler("Hideout:TakeWeaponSkin:S",root,function(item)
    if(client and isElement(client)and getElementType(client)=="player" and isLoggedin(client))then
        if(tonumber(getPlayerJsonValue(client,"HideUpgrades","Armory"))>0)then
            if(item:find("Weapon_24_"))then--Deagle
                local id=item:gsub("Weapon_24_","");

                setPlayerJsonValue(client,"WeaponSkins","24",id);
                --[[ triggerClientEvent(client,"Weapon:Skin:Load",client,client,tonumber(30),tostring(id)); ]]
                for _,weapon in ipairs(getPedWeapons(client))do
                    if(weapon>22)then
                        local SkinID=getPlayerJsonValue(client,"WeaponSkins",tostring(weapon));
                        if(SkinID>0)then
                            triggerClientEvent(client,"Weapon:Skin:Load",client,client,tonumber(weapon),tostring(SkinID));
                        end
                    end
                end

                triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Hideout:EquippedWeaponskin"),"success",4000);  
            end
            if(item:find("Weapon_25_"))then--Shotgun
                local id=item:gsub("Weapon_25_","");

                setPlayerJsonValue(client,"WeaponSkins","25",id);
                --[[ triggerClientEvent(client,"Weapon:Skin:Load",client,client,tonumber(30),tostring(id)); ]]
                for _,weapon in ipairs(getPedWeapons(client))do
                    if(weapon>22)then
                        local SkinID=getPlayerJsonValue(client,"WeaponSkins",tostring(weapon));
                        if(SkinID>0)then
                            triggerClientEvent(client,"Weapon:Skin:Load",client,client,tonumber(weapon),tostring(SkinID));
                        end
                    end
                end

                triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Hideout:EquippedWeaponskin"),"success",4000);  
            end
            if(item:find("Weapon_29_"))then--MP5
                local id=item:gsub("Weapon_29_","");

                setPlayerJsonValue(client,"WeaponSkins","29",id);
                --[[ triggerClientEvent(client,"Weapon:Skin:Load",client,client,tonumber(30),tostring(id)); ]]
                for _,weapon in ipairs(getPedWeapons(client))do
                    if(weapon>22)then
                        local SkinID=getPlayerJsonValue(client,"WeaponSkins",tostring(weapon));
                        if(SkinID>0)then
                            triggerClientEvent(client,"Weapon:Skin:Load",client,client,tonumber(weapon),tostring(SkinID));
                        end
                    end
                end

                triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Hideout:EquippedWeaponskin"),"success",4000);  
            end
            if(item:find("Weapon_30_"))then--AK-47
                local id=item:gsub("Weapon_30_","");

                setPlayerJsonValue(client,"WeaponSkins","30",id);
                --[[ triggerClientEvent(client,"Weapon:Skin:Load",client,client,tonumber(30),tostring(id)); ]]
                for _,weapon in ipairs(getPedWeapons(client))do
                    if(weapon>22)then
                        local SkinID=getPlayerJsonValue(client,"WeaponSkins",tostring(weapon));
                        if(SkinID>0)then
                            triggerClientEvent(client,"Weapon:Skin:Load",client,client,tonumber(weapon),tostring(SkinID));
                        end
                    end
                end

                triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Hideout:EquippedWeaponskin"),"success",4000);  
            end
            if(item:find("Weapon_31_"))then--M4
                local id=item:gsub("Weapon_31_","");

                setPlayerJsonValue(client,"WeaponSkins","31",id);
                --[[ triggerClientEvent(client,"Weapon:Skin:Load",client,client,tonumber(31),tostring(id)); ]]
                for _,weapon in ipairs(getPedWeapons(client))do
                    if(weapon>22)then
                        local SkinID=getPlayerJsonValue(client,"WeaponSkins",tostring(weapon));
                        if(SkinID>0)then
                            triggerClientEvent(client,"Weapon:Skin:Load",client,client,tonumber(weapon),tostring(SkinID));
                        end
                    end
                end

                triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Hideout:EquippedWeaponskin"),"success",4000);  
            end
            if(item:find("Weapon_34_"))then--Sniper
                local id=item:gsub("Weapon_34_","");

                setPlayerJsonValue(client,"WeaponSkins","34",id);
                --[[ triggerClientEvent(client,"Weapon:Skin:Load",client,client,tonumber(34),tostring(id)); ]]
                for _,weapon in ipairs(getPedWeapons(client))do
                    if(weapon>22)then
                        local SkinID=getPlayerJsonValue(client,"WeaponSkins",tostring(weapon));
                        if(SkinID>0)then
                            triggerClientEvent(client,"Weapon:Skin:Load",client,client,tonumber(weapon),tostring(SkinID));
                        end
                    end
                end

                triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Hideout:EquippedWeaponskin"),"success",4000);  
            end
        else
            triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Hideout:CantUseThisFuction"),"error",4000);    
        end
    end
end)


addEventHandler("Hideout:Wardrobe:WearSkin:S",root,function(id)
    if(client and isElement(client)and getElementType(client)=="player" and isLoggedin(client))then
        local typOld=getElementData(client,"Skin");

        local isCustomOld,_,elementTypeOld=exports[RESOURCE_NEWMODELS]:isCustomModID(typOld);
        if(isCustomOld)then
            local dataName2=exports[RESOURCE_NEWMODELS]:getDataNameFromType(elementTypeOld);
            removeElementData(client,dataName2);
        end
        local isCustom,mod,elementType=exports[RESOURCE_NEWMODELS]:isCustomModID(tonumber(id));
        if(isCustom)then
            local dataName=exports[RESOURCE_NEWMODELS]:getDataNameFromType(elementType);
            removeElementData(client,dataName);
            setElementData(client,dataName,mod.id);
        else
            setElementModel(client,tonumber(id));
        end
        
        setElementData(client,"Skin",tonumber(id));
    end
end)
addEventHandler("Hideout:Wardrobe:DeleteSkin:S",root,function(id)
    if(client and isElement(client)and getElementType(client)=="player" and isLoggedin(client))then
        
        local jsonWardrobeSkins=getPlayerJsonTable(client,"PedSkins");
        if(jsonWardrobeSkins and type(jsonWardrobeSkins)=="table")then
            for tblID,data in pairs(jsonWardrobeSkins)do
                if(id==tblID)then
                    table.remove(jsonWardrobeSkins,id);
                    setElementData(client,"PedSkins",toJSON(jsonWardrobeSkins));

                    triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Hideout:DeletedPedSkin"),"success",4000);
                    triggerClientEvent(client,"Hideout:Load:PedSkins",client);
                    break;
                end
            end
        end
    end
end)
addEventHandler("Hideout:Wardrobe:GrabQueueSkin:S",root,function(id)
    if(client and isElement(client)and getElementType(client)=="player" and isLoggedin(client))then
        local jsonWardrobeSkins=getPlayerJsonTable(client,"PedSkins");
        if(jsonWardrobeSkins and type(jsonWardrobeSkins)=="table")then
            --new count(filter)
            WardrobeFilterCount[client]=0;
            for tblID,_ in ipairs(jsonWardrobeSkins)do
                if(not jsonWardrobeSkins[tblID][3])then
                    WardrobeFilterCount[client]=WardrobeFilterCount[client]+1;
                end
            end
            if(WardrobeFilterCount[client]>=Hideout.Wardrobe.Benefits[tonumber(getPlayerJsonValue(client,"HideUpgrades","Wardrobe"))].max)then
                triggerClientEvent(client,"Notify:UI",client,loc(client,"S:ShopSkin:LimitReached"):format(Hideout.Wardrobe.Benefits[tonumber(getPlayerJsonValue(client,"HideUpgrades","Wardrobe"))].max),"error",5000);
                return;
            end

            for tblID,data in ipairs(jsonWardrobeSkins)do
                if(id==tblID and jsonWardrobeSkins[tblID][3])then
                    if(tonumber(jsonWardrobeSkins[tblID][3])>=tonumber(os.time()))then
                        if(#data>=3)then
                            table.remove(data,3);

                            setElementData(client,"PedSkins",toJSON(jsonWardrobeSkins));

                            triggerClientEvent(client,"Hideout:Load:PedSkins",client);
                            break;
                        end
                    else
                        print("expired")
                    end
                end
            end
        end
    end
end)


addEventHandler("Hideout:TakeLaundry:S",root,function(id)
    if(client and isElement(client)and getElementType(client)=="player" and isLoggedin(client))then

        local jsonLaundry=getPlayerJsonTable(client,"HideLaundry");
        if(jsonLaundry and type(jsonLaundry)=="table")then
            for tblID,data in pairs(jsonLaundry)do
                if(id==tblID)then
                    if(tonumber(os.time())>=data[2])then
                        table.remove(jsonLaundry,id);
                        setElementData(client,"HideLaundry",toJSON(jsonLaundry));

                        addPlayerJsonValue(client,"Money","Cash",tonumber(data[1]));
                        triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Hideout:TakeLaundryMoney"):format(data[1]),"success",4000);
                        triggerClientEvent(client,"Hideout:Load:Laundry",client);

                        triggerEvent("Tutorial:NextStep",client,client,"TakeWashedMoney");
                    else
                        triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Hideout:CantTakeLaundryYet"),"error",4000);
                    end
                    break;
                end
            end
        end
    end
end)

addEventHandler("Hideout:PutInLaundry:S",root,function(item)
    if(client and isElement(client)and getElementType(client)=="player" and isLoggedin(client))then
        if(item=="Moneywash")then
            local MaxStacks=Hideout.Moneywash.WashSettings[tonumber(getPlayerJsonValue(client,"HideUpgrades","Moneywash"))]and Hideout.Moneywash.WashSettings[tonumber(getPlayerJsonValue(client,"HideUpgrades","Moneywash"))].stacks or 0;
            local MaxMoney=Hideout.Moneywash.WashSettings[tonumber(getPlayerJsonValue(client,"HideUpgrades","Moneywash"))]and Hideout.Moneywash.WashSettings[tonumber(getPlayerJsonValue(client,"HideUpgrades","Moneywash"))].max or 10000;
            local CurrentBlackMoney=tonumber(getPlayerJsonValue(client,"Money","Black"));

            if(tonumber(getPlayerJsonValue(client,"HideUpgrades","Moneywash"))>0)then
                if(tonumber(getPlayerJsonValue(client,"Money","Black"))>0)then
                    if(getLaundryStacks(client)<MaxStacks)then
                        if(tonumber(getPlayerJsonValue(client,"Money","Black"))>=MaxMoney)then
                            addLaundryQueue(client,tonumber(MaxMoney));
                            removePlayerJsonValue(client,"Money","Black",tonumber(MaxMoney));
                            triggerClientEvent(client,"Hideout:Load:Laundry",client);

                            triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Hideout:LaundryMoneyPutin"):format(MaxMoney),"success",4000);
                        else
                            addLaundryQueue(client,tonumber(CurrentBlackMoney));
                            removePlayerJsonValue(client,"Money","Black",tonumber(CurrentBlackMoney));
                            triggerClientEvent(client,"Hideout:Load:Laundry",client);

                            triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Hideout:LaundryMoneyPutin"):format(CurrentBlackMoney),"success",4000);
                        end
                    else
                        triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Hideout:LaundryStacksFull"):format(MaxStacks),"error",4000);
                    end
                else
                    triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Hideout:LaundryNoBlackmoney"),"error",4000);
                end
            else
                triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Hideout:CantUseThisFuction"),"error",4000);
            end
        end
    end
end)

function addLaundryQueue(player,amount)
    if(player and isElement(player)and getElementType(player)=="player" and isLoggedin(player))then
        local WashTime=amount*Hideout.Moneywash.WashSettings[tonumber(getPlayerJsonValue(client,"HideUpgrades","Moneywash"))].multiplicator;
        local jsonLaundry=getPlayerJsonTable(player,"HideLaundry");

        if(jsonLaundry and type(jsonLaundry)=="table")then
            if(amount and tonumber(amount)>=6000)then
                triggerEvent("Tutorial:NextStep",player,player,"WashMoney");
            end

            table.insert(jsonLaundry,{amount,os.time()+WashTime});

            setElementData(player,"HideLaundry",toJSON(jsonLaundry));
        end
    end
end

function getLaundryStacks(player)
    if(player and isElement(player)and getElementType(player)=="player" and isLoggedin(player))then
        local jsonLaundry=getPlayerJsonTable(player,"HideLaundry");
        if(jsonLaundry and type(jsonLaundry)=="table")then
            return #jsonLaundry;
        end
    end
end









function HideoutStartMining(player)
    if(isTimer(PLAYER_MINING[player]))then
        killTimer(PLAYER_MINING[player]);
        PLAYER_MINING[player]=nil;
    end

    local BitcoinRacks=tonumber(getPlayerJsonValue(player,"HideUpgrades","Bitcoin"))or 0;
    
    if(BitcoinRacks>0)then
        PLAYER_MINING[player]=setTimer(function(player)
            if(player and isElement(player)and isLoggedin(player))then
                --print("1         "..os.time(),"2         "..tonumber(getPlayerJsonValue(player,"HideTimers","Bitcoin")))
                if(tonumber(os.time())>=tonumber(getPlayerJsonValue(player,"HideTimers","Bitcoin")))then
                    addPlayerJsonValue(player,"HideItems","Bitcoin",1);
                    setPlayerJsonValue(player,"HideTimers","Bitcoin",os.time()+Hideout.Bitcoin.MiningSettings[tonumber(getPlayerJsonValue(player,"HideUpgrades","Bitcoin"))].timer);
                    
                    triggerClientEvent(player,"Notify:UI",player,loc(player,"S:Hideout:BitcoinReady"),"info",4000);
                end


                triggerClientEvent(player,"Hideout:Update",player,"Bitcoin", tonumber(getPlayerJsonValue(player,"HideTimers","Bitcoin"))-os.time(),tonumber(getPlayerJsonValue(player,"HideItems","Bitcoin")));
            end
        end,1000,0,player)
    end
end