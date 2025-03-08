addRemoteEvents{"Userpanel:ChangeSetting:S","Userpanel:Crate:Opening:S","Userpanel:RedeemCode:S",};--addEvents


local TempTable={};


addEventHandler("Userpanel:ChangeSetting:S",root,function(category,type,value)
    if(client and isElement(client)and getElementType(client)=="player" and isLoggedin(client))then
        if(type and type~="nil")then
            if(not(getPlayerNotExistingJsonValue(client,"Settings",tostring(category..type))))then
                setPlayerJsonValue(client,"Settings",tostring(category..type),tonumber(value));
            else
                setPlayerJsonValue(client,"Settings",tostring(category..type),tonumber(value));
            end

            if(type=="Snow" and value==1)then
                triggerClientEvent(client,"Effect:Snow:Load",client,true);
            elseif(type=="Snow" and value==0)then
                triggerClientEvent(client,"Effect:Snow:Load",client,nil);
            end

            if(type=="Bloodscreen" and value>0)then
                triggerClientEvent(client,"Damage:Bloodscreen:C",client);
            end

            triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Userpanel:ChangeSetting:"..tostring(category)):format(value),"info",5000,true);
        else
            if(category=="Language")then
                setElementData(client,"Language",tonumber(value));

                triggerClientEvent(client,"Userpanel:UI",client,true);
            else
                if(not(getPlayerNotExistingJsonValue(client,"Settings",tostring(category))))then
                    setPlayerJsonValue(client,"Settings",tostring(category),tonumber(value));
                else
                    setPlayerJsonValue(client,"Settings",tostring(category),tonumber(value));
                end
            end

            triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Userpanel:ChangeSetting:"..tostring(category)):format(value),"info",5000,true);

            if(category:find("Crosshair"))then
                triggerClientEvent(client,"Textures:Load",client,"Crosshair");
            end
        end
    end
end)

addEventHandler("Userpanel:Crate:Opening:S",root,function(typ,crate,item,amount,name)
    if(client and isElement(client)and getElementType(client)=="player" and isLoggedin(client))then
        if(typ=="Coin" and not item and not amount)then
            for _,v in pairs(Userpanel.Premium["Crates"])do
                if(v.value==crate)then
                    if(getPlayerJsonValue(client,"Money","CrimeCoin")>=tonumber(v.price))then
                        removePlayerJsonValue(client,"Money","CrimeCoin",tonumber(v.price));
                    end
                    return;
                end
            end
        end

        if(typ=="GiveItem" and item)then
            if(item=="CrimeCoin" or item=="Cash" and amount)then
                addPlayerJsonValue(client,"Money",tostring(item),tonumber(amount));

                sendDiscordMessage({
                    ID=9, Title="Crate "..crate.." got opened", Desc=getPlayerName(client).." has opened a crate.\n\nReward: "..item.." - Amount: "..amount.."",
                    PlayerData={Name=getPlayerName(client),Serial=getPlayerSerial(client),},
                })
            elseif(item:find("Skin_")and name)then
                local jsonWardrobeSkins=getPlayerJsonTable(client,"PedSkins");
                if(jsonWardrobeSkins and type(jsonWardrobeSkins)=="table")then
                    if(#jsonWardrobeSkins>=Hideout.Wardrobe.Benefits[tonumber(getPlayerJsonValue(client,"HideUpgrades","Wardrobe"))].max)then--limit reached
                        table.insert(jsonWardrobeSkins,{item:gsub("Skin_",""),tostring(name),os.time()+Userpanel.Premium.TimeTillPedSkinExpires});

                        local differenceInSeconds=os.difftime(os.time()+Userpanel.Premium.TimeTillPedSkinExpires,os.time());
                        triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Userpanel:SkinLimitReachedSoMovedToQueue"):format(math.floor(differenceInSeconds/(24*60*60))),"warning",15000);
                    else
                        table.insert(jsonWardrobeSkins,{item:gsub("Skin_",""),tostring(name)});
                    end
                    setElementData(client,"PedSkins",toJSON(jsonWardrobeSkins));

                    sendDiscordMessage({
                        ID=9, Title="Crate "..crate.." got opened", Desc=getPlayerName(client).." has opened a crate.\n\nReward: "..item.." ("..name..")",
                        PlayerData={Name=getPlayerName(client),Serial=getPlayerSerial(client),},
                    })
                end
            elseif(item:find("Weapon_")and name)then
                addPlayerJsonValue(client,"Items",tostring(item),tonumber(1));

                sendDiscordMessage(9,getPlayerName(client).." opened a "..crate.." crate.\n\nReward: "..item.." ("..name..")");
            else
                if(amount)then--items
                    addPlayerJsonValue(client,"Items",tostring(item),tonumber(amount));

                    sendDiscordMessage({
                        ID=9, Title="Crate "..crate.." got opened", Desc=getPlayerName(client).." has opened a crate.\n\nReward: "..item.." - Amount: "..amount.."",
                        PlayerData={Name=getPlayerName(client),Serial=getPlayerSerial(client),},
                    })
                end
            end
        end
    end
end)

addEventHandler("Userpanel:RedeemCode:S",root,function(code)
    if(client and isElement(client)and getElementType(client)=="player" and isLoggedin(client))then
        if(code and code~="")then
            local result=dbPoll(dbQuery(Database.Connection,"SELECT * FROM ?? WHERE ??=?","Codes","Code",code:upper()),-1);
            if(#result==1 and not result[1].UsedBy)then
                if(result[1].Type=="Item" and Items[tostring(result[1].Item)])then
                    addPlayerJsonValue(client,"Items",tostring(result[1].Item),tonumber(result[1].Amount));

                    triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Userpanel:CodeRedeemed"):format(loc(client,"Item:"..result[1].Item),result[1].Amount),"success",10000);

                    dbExec(Database.Connection,"UPDATE ?? SET ??=? WHERE ??=?","Codes","UsedBy",getPlayerName(client),"Code",code:upper());
                    sendDiscordMessage({
                        ID=8, Title="Code use", Desc=getPlayerName(client).." has used a code.\n\nType: "..result[1].Type.." - Item/Money/Vehicle: "..result[1].Item.." (x"..result[1].Amount..")",
                        PlayerData={Name=getPlayerName(client),Serial=getPlayerSerial(client),},
                    })
                elseif(result[1].Type=="Money" and Moneys[tostring(result[1].Item)])then
                    addPlayerJsonValue(client,"Money",tostring(result[1].Item),tonumber(result[1].Amount));

                    triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Userpanel:CodeRedeemed"):format(loc(client,"Item:"..result[1].Item),result[1].Amount),"success",10000);

                    dbExec(Database.Connection,"UPDATE ?? SET ??=? WHERE ??=?","Codes","UsedBy",getPlayerName(client),"Code",code:upper());
                    sendDiscordMessage({
                        ID=8, Title="Code use", Desc=getPlayerName(client).." has used a code.\n\nType: "..result[1].Type.." - Item/Money/Vehicle: "..result[1].Item.." (x"..result[1].Amount..")",
                        PlayerData={Name=getPlayerName(client),Serial=getPlayerSerial(client),},
                    })
                elseif(result[1].Type=="Vehicle" and Vehicle.Names[tonumber(result[1].Item)])then
                    TempTable[client]=tonumber(result[1].Item);
                    
                    local Owner=getPlayerName(client);
                    local result=dbPoll(dbQuery(Database.Connection,"SELECT * FROM ?? WHERE ??=?","Vehicles","Username",Owner),-1);
                    if(#result>=#Hideout.Garage.GaragePositions[tonumber(getPlayerJsonValue(client,"HideUpgrades","Garage"))])then
                        triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Vehicle:SlotsReached"),"error",4000);
                        return;
                    end
                    
                    local IDcounter=dbPoll(dbQuery(Database.Connection,"SELECT ?? FROM ?? WHERE Vehicles=Vehicles","Vehicles","Counter"),-1)[1]["Vehicles"];
                    dbExec(Database.Connection,"UPDATE ?? SET ??=?","Counter","Vehicles",IDcounter+1);

                    ResultPlate=generateVehiclePlate();

                    local isCustom,mod,elementType=exports[RESOURCE_NEWMODELS]:isCustomModID(TempTable[client]);
                    if(isCustom)then
                        DriveType=getOriginalHandling(tonumber(mod.base_id))["driveType"];
                    else
                        DriveType=getOriginalHandling(TempTable[client])["driveType"];
                    end

                    dbExec(Database.Connection,"INSERT INTO ?? (ID,Username,VehID,Plate,Color,LightColor,Tunings) VALUES (?,?,?,?,?,?,?)","Vehicles",IDcounter,Owner,TempTable[client],ResultPlate,toJSON({255,255,255,255,255,255}),toJSON({255,255,255,255,255,255}),'[ { "Paintjob": 9999999, "DriveType": "'..DriveType..'" } ]');

                    triggerClientEvent(client,"Load:Garage:Vehicles:C",client);

                    triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Userpanel:CodeRedeemed2"):format(Vehicle.Names[tonumber(TempTable[client])]),"success",10000);
                    
                    dbExec(Database.Connection,"UPDATE ?? SET ??=? WHERE ??=?","Codes","UsedBy",getPlayerName(client),"Code",code:upper());
                    sendDiscordMessage({
                        ID=8, Title="Code use", Desc=getPlayerName(client).." has used a code.\n\nType: "..result[1].Type.." - Item/Money/Vehicle: "..result[1].Item.." (x"..result[1].Amount..")",
                        PlayerData={Name=getPlayerName(client),Serial=getPlayerSerial(client),},
                    })
                end

                TempTable[client]=nil;
            else
                triggerClientEvent(client,"Notify:UI",client,loc(client,"S:Userpanel:CodeNotAvailable"),"error",4000);
            end
        end
    end
end)