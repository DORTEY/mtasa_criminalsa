local WEBHOOKS={
	[1]="",--chat (local, global & /me)
	[2]="",--registration
	[3]="",--join/leave
	[4]="",--robbed money deliver
	[5]="",--trader
	[6]="",--vehicle
	[7]="",--hideout
	[8]="",--code redeems
	[9]="",--crates
	[10]="",--screensots
};

function sendDiscordMessage(data)
	local srvTime=getRealTime();
	local hour=srvTime.hour;
	if(string.len(tostring(hour))==1)then
		hour="0"..hour;
	end
	local minute=srvTime.minute;
	if(string.len(tostring(minute))==1)then
		minute="0"..minute;
	end
	
	if(Server.Settings.ServerLogs)then
		if(tonumber(data.ID)and WEBHOOKS[tonumber(data.ID)])then
			local dataa;
			dataa={
				embeds={
					{
						["title"]=data.Title,
						["description"]="```"..data.Desc.."```",
						["fields"]={
							{name="Username",value="`"..(data.PlayerData.Name or "N/A").."`",inline=false},
							{name="Serial",value="`"..(data.PlayerData.Serial or "N/A").."`",inline=false},
							{name="Discord Identifier",value="`"..(data.PlayerData.DiscordID or "N/A").."`",inline=false},
						},
						["footer"]={
							text=Server.Name.." - "..Server.Version.."   ("..hour..":"..minute..")",
						},
					}
				}
			};

			local jsonData=toJSON(dataa)jsonData=string.sub(jsonData,3,#jsonData-2);
			local sendOptions={headers={["Content-Type"]="application/json"},postData=jsonData};

			fetchRemote(WEBHOOKS[tonumber(data.ID)],sendOptions,callback);
		end
	end
end
function callback(msg)
end