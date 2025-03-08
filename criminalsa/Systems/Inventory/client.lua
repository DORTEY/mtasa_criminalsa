addRemoteEvents{"Inventory:UI","Inventory:Refresh","Inventory:UseItem:C"};--addEvents


local Delay=nil;


addEventHandler("Inventory:UI",root,function(type)
    if(not(isLoggedin()))then
		return;
	end
	if(isPedDead(localPlayer))then
		return;
	end
    if(not(CEFready))then
        return;
    end

	if(type)then
		if(isClickedState(localPlayer)==true)then
			return;
		end
        setUIdatas("set","cursor");
        guiSetVisible(BrowserInventory,true);
    else
        if(guiGetVisible(BrowserInventory))then
            setUIdatas("rem","cursor");
			guiSetVisible(BrowserInventory,false);
            
            executeBrowserJavascript(getBrowserInventory,[[
				$('.ListItems-Item').empty();
                $('.Loading').css('display','block');
			]]);
		end
    end
end)
addEventHandler("onClientPlayerWasted",root,function()
	if(source==localPlayer)then
		if(BrowserInventory and guiGetVisible(BrowserInventory))then
			guiSetVisible(BrowserInventory,false);
			setUIdatas("rem","cursor");

            if(isTimer(Delay))then
                killTimer(Delay);
                Delay=nil;
            end
		end
	end
end)


addEventHandler("Inventory:Refresh",root,function(tbl)
	if(not(isLoggedin()))then
		return;
	end
	if(isPedDead(localPlayer))then
		return;
	end
	if(isClickedState(localPlayer)==false)then
		return;
	end
    
    if(isTimer(Delay))then
        killTimer(Delay);
        Delay=nil;
    end

    if(guiGetVisible(BrowserInventory))then
        executeBrowserJavascript(getBrowserInventory,[[
			$('.ListItems-Item').empty();
            $('.Loading').css('display','block');
		]]);

        Delay=setTimer(function()
            if(guiGetVisible(BrowserInventory))then
                executeBrowserJavascript(getBrowserInventory,[[
                    $('.ListItems-Item').empty();
                ]]);
                for item,amount in pairs(tbl)do
                    if(amount and tonumber(amount)>0)then
                        if(Items[tostring(item)].Display)then
                            executeBrowserJavascript(getBrowserInventory,[[
                                loadIventoryItems(']]..item..[[',']]..loc(localPlayer,"Item:"..tostring(item))..[[',']]..amount..[[');
                            ]]);
                        end
                    end
                end
                executeBrowserJavascript(getBrowserInventory,[[
                    $('.Loading').css('display','none');
                ]]);
        
                --Item Amount
                --executeBrowserJavascript(getBrowserInventory,"updateItemAmount('"..curcount.."','"..maxcount.."'); $('.ItemAmountBar').fadeIn('slow');");
            else
                if(isTimer(Delay))then
                    killTimer(Delay);
                    Delay=nil;
                end
            end
        end,500,1);
    end
end)

addEventHandler("Inventory:UseItem:C",root,function(item)
    if(not(isLoggedin()))then
		return;
	end
	if(isPedDead(localPlayer))then
		return;
	end
	if(isClickedState(localPlayer)==false)then
		return;
	end

    triggerServerEvent("Inventory:UseItem:S",localPlayer,tostring(item));
end)