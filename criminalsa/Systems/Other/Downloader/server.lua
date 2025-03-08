addRemoteEvents{"Open:CEF:Cache:S"};--addEvents


addEventHandler("Open:CEF:Cache:S",root,function()
	triggerClientEvent(client,"Open:CEF:Cache",client);
end)

addEvent("clientResourceLoaded_Custom",true)


local DOWNLOADER_PATHS={};
local DOWNLOADER_PATHS_SIZE=0;
local DOWNLOADER_STATUS={};


addEventHandler("onResourceStart",resourceRoot,function()
	local meta=xmlLoadFile("meta.xml");
	local nodes=xmlNodeGetChildren(meta);
	if(nodes and nodes[1])then
		local count=0;
		for i=1,#nodes do
			if(xmlNodeGetName(nodes[i])=="file")then
				if(xmlNodeGetAttribute(nodes[i],"download")=="false")then
					count=count+1;
					DOWNLOADER_PATHS[count]=xmlNodeGetAttribute(nodes[i],"src");

					local openedFile=fileOpen(DOWNLOADER_PATHS[count]);
					
					DOWNLOADER_PATHS_SIZE=DOWNLOADER_PATHS_SIZE+fileGetSize(openedFile);
					fileClose(openedFile);
				end
			end
		end
	end
	xmlUnloadFile(meta);
end)


addEventHandler("clientResourceLoaded_Custom",root,function()
	if(DOWNLOADER_PATHS[1]and not DOWNLOADER_STATUS[client])then
		DOWNLOADER_STATUS[client]=true;

		triggerLatentClientEvent(client,"downloadClientsidedFiles",50000,false,client,DOWNLOADER_PATHS,sizeFormat(DOWNLOADER_PATHS_SIZE));
	end
end)


addEventHandler("onPlayerQuit",root,function()
	DOWNLOADER_STATUS[source]=nil;
end)


--[[ addEvent("Custom:Texture:Download:S",true)
addEventHandler("Custom:Texture:Download:S",root,function(id)
	fetchRemote(
	"http://2.58.113.87/paintjobs/"..id..".png",
	sendFiletoClient,
	"",
	false,
	client
	);
end)

addCommandHandler("kkk",function(player,cmd)
	fetchRemote ("http://2.58.113.87/paintjobs/4.png", sendFiletoClient, "", false, player)
end)

function sendFiletoClient(responseData, errorCode, player)
	print(responseData)
	print(errorCode)
	if (errorCode == 0) then
		triggerClientEvent(player, "printImageInfo", resourceRoot, responseData)
	end
end ]]