local WEBHOOKS={
	[1]="https://discord.com/api/webhooks/1249685570410774574/GZ395E29EqxpWcwvKU1nmORzqrPzZlGl05oQlrHJQyMga8XV72wuIz2Q7CueP8IfSLHn",--chat (local, global & /me)
	[2]="https://discord.com/api/webhooks/1273932825241976965/53CUsgx_Irnz54cznqeHzxqB2jbgW0-ixNzCCgGcagxdpmceI3yp6POOa0fAWgrY9VP9",--registration
	[3]="https://discord.com/api/webhooks/1307547084680859658/Wl00rfBuAd9AyyaE1aQZtSuMH5xPTJXsGkS0l4_00ayqxh78E5ZMtNZJUKpCcE0a-Mwo",--join/leave
	[4]="https://discord.com/api/webhooks/1306233187881455708/PilvgmxUyRxh_lPojcelgFywMaOwqk69kgmMdfGP8eiru9mC_LywXUR6eNI58k9LTDlZ",--robbed money deliver
	[5]="https://discord.com/api/webhooks/1306237220297900083/238XC2zN-9BqSebpmdHckQnT6aPCZTDIUfNJ4zpx0my25mZFTwwMpHoNdrGhFmL4scgt",--trader
	[6]="https://discord.com/api/webhooks/1306238653420273757/224xd7ay67tPjQd_iGga2Q2po4eylkbb8JjH_5ZrJXRj8K3WhPEFVgsHH7oQXZIsfcyg",--vehicle
	[7]="https://discord.com/api/webhooks/1273935982370226207/Q2BAEIFuxWPYV4bjixvwEki9IHyntySmuJlMVnJroXBG3svEWQFqLvgLquCcylsotYKe",--hideout
	[8]="https://discord.com/api/webhooks/1307619266966716416/MFn9QyxiQZLK-1DHvtBTeZ-s4bz05CL_4btTUcLqgguozuZJ00AAWzglpqTdjmIq_fuc",--code redeems
	[9]="https://discord.com/api/webhooks/1319692659937382400/tka8rurMEKeQoCejQCULEc8YO5krDbTW57y5Ev3oWxtCcZPLOn7Zr9bJrZTwaMTuXS-p",--crates
	[10]="https://discord.com/api/webhooks/1321569214477242421/9ACoWD7i08NahCvIlu0tfnbaqR-iJ0aZf1qhV6NEK1jQtimk5YiwyiUM1GBBJkEPDo-K",--screensots
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