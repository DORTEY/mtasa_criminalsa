addRemoteEvents{"Item:AddRemove"};--addEvent


local Table={};


addEventHandler("Item:AddRemove",root,function(typ,item,amount)
	local Tick=getTickCount();
    local Text="N/A";

	if(typ=="add")then
		Text="+";
	elseif(typ=="rem")then
		Text="-";
	end

    table.insert(Table,{Text..amount.." "..loc(localPlayer,"Item:"..item),Tick+6*1000,0});
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

	local Tick=getTickCount();
	
	if(#Table>10)then--max 10 boxes
		table.remove(Table,1);--remove the lowest infobox when limit is reached
	end
	
	for i,v in pairs(Table)do
		dxDrawText(v[1],3300*Gsx,1060*Gsy+5*Gsy-(i*40),180*Gsx,20*Gsy,tocolor(255,255,255,255),2*Gsx,"default-bold","center",_,_,_,false,_,_);--text
		
		if(Tick>=v[2])then
			v[3]=math.max(v[3]-10,0);
			v[3]=math.max(v[3]-10,0);
		else
			v[3]=math.min(v[3]+10,286);
			v[3]=math.min(v[3]+10,255);
		end
		if(v[3]<=0)then
			table.remove(Table,i);
		end
	end
end)