addRemoteEvents{"Bosses:Load:Bots:S"};--addEvents


BOSSES_DATAS={};


function loadBossPeds(area)
    if(Bosses.Peds[tostring(area)])then
        for _,pedData in pairs(BOSSES_DATAS)do--delete old peds if already existing
            if(pedData[1]==tostring(area))then
                if(pedData[2]and isElement(pedData[2]))then
                    destroyElement(pedData[2]);
                end
            end
        end

        for _,v in pairs(Bosses.Peds[tostring(area)])do
            Ped=createPed(v.Ped[1],v.Pos[1],v.Pos[2],v.Pos[3],v.Pos[4],true);
            setElementData(Ped,"Bot:Data:Bosses",true);
            setElementData(Ped,"Bot:Data:Type",v.Type);
            setElementData(Ped,"Ped:Data:Nametag:Title",v.Ped[2]);
            setElementData(Ped,"Ped:Data:Nametag:Range",v.Range);

            setElementFrozen(Ped,true);
            giveWeapon(Ped,v.Weapon,99999,true);


            setElementData(Ped,"Ped:Data:Health",v.Ped[3]);
            setElementData(Ped,"Ped:Data:MaxHealth",v.Ped[3]);

            table.insert(BOSSES_DATAS,{tostring(area),Ped,v.Range});
        end



        for _,player in pairs(getElementsByType("player"))do
            if(player and isElement(player)and isLoggedin(player))then
                triggerClientEvent(player,"Bosses:Load:Bots:C",player,true,BOSSES_DATAS);
            end
        end
    end
end
loadBossPeds("Area51");
loadBossPeds("BigSmoke");
loadBossPeds("SFPD");

addEventHandler("Bosses:Load:Bots:S",root,function()
    if(client and isElement(client)and getElementType(client)=="player")then
        triggerClientEvent(client,"Bosses:Load:Bots:C",client,true,BOSSES_DATAS);
    end
end)