addEvent("downloadClientsidedFiles",true)
addEvent("onClientResourceStart_Custom",false)


local DOWNLOADER_PATHS={};
local DOWNLOADER_COUNT=0;
local DOWNLOADER_AMOUNT=0;
local DOWNLOADER_CURRENTFILE=nil;
local DOWNLOADER_CURRENTFILE_SIZE=nil;
local DOWNLOADER_TICK_START=0;

local DOWNLOADER_BACKGROUND_IMG=math.random(1,2);

local DOWNLOADER_MUSIC=nil;
local DOWNLOADER_MUSIC_TOGGLE=nil;

local DOWNLOADER_DISCORD_CLICKED=nil;
local DOWNLOADER_YOUTUBE_CLICKED=nil;

local CHARACTER_DURATION=math.random(7000,10000);
local CHARACTER_TICK=getTickCount();
local CHARACTER_TIMER=nil;
local CHARACTER_IMAGE=1;


local function toggleDownloaderMusic()
	DOWNLOADER_MUSIC_TOGGLE=not DOWNLOADER_MUSIC_TOGGLE;

	if(DOWNLOADER_MUSIC_TOGGLE)then
		setSoundVolume(DOWNLOADER_MUSIC,0);
	else
		setSoundVolume(DOWNLOADER_MUSIC,0.6);
	end
end

local function drawDownloadScreen()
	showChat(false);
	dxDrawImage(0,0,GLOBALscreenX,GLOBALscreenY,":"..RESOURCE_NAME.."/Files/Images/Downloader/"..DOWNLOADER_BACKGROUND_IMG..".png",0.0,0.0,0.0,tocolor(255,255,255,255),false);--bg
	dxDrawRectangle(0,0,GLOBALscreenX,GLOBALscreenY,tocolor(0,0,0,120),false);--bg
	if(DOWNLOADER_COUNT<DOWNLOADER_AMOUNT)then
		dxDrawImage(200*Gsx-10*((CHARACTER_TICK-getTickCount()-CHARACTER_DURATION)/1500),180*Gsy,700*Gsx,900*Gsy,":"..RESOURCE_NAME.."/Files/Images/Downloader/Characters/"..CHARACTER_IMAGE..".png",0,0,0,tocolor(255,255,255,255))
	end
	dxDrawImage(1630*Gsx,0*Gsy,300*Gsx,130*Gsy,":"..RESOURCE_NAME.."/Files/Images/Logo.png",0,0,0,tocolor(255,255,255,255));
	
	--Download progress
	dxDrawRectangle(25*Gsx,1005*Gsy,350*Gsx,15*Gsy,tocolor(150,150,150,100),false);--bg progress
	if(DOWNLOADER_COUNT>0)then
		dxDrawRectangle(25*Gsx,1005*Gsy,DOWNLOADER_COUNT*350/DOWNLOADER_AMOUNT*Gsx,15*Gsy,tocolor(0,240,255,100),false);
		dxDrawText(""..DOWNLOADER_COUNT.."/"..DOWNLOADER_AMOUNT.."",200*Gsx,1006*Gsy,200*Gsx,20*Gsy,tocolor(255,255,255,255),0.95*Gsx,"default-bold","center",_,_,_,false,_,_);
		if(DOWNLOADER_CURRENTFILE)then
			dxDrawText(DOWNLOADER_CURRENTFILE.." ("..sizeFormat(DOWNLOADER_CURRENTFILE_SIZE)..")",60*Gsx,1043*Gsy,200*Gsx,20*Gsy,tocolor(255,255,255,255),0.95*Gsx,"default-bold","left",_,_,_,false,_,_);
		end
	end
	--spinning
	dxDrawImage(15*Gsx,1035*Gsy,30*Gsx,30*Gsy,":"..RESOURCE_NAME.."/Files/Images/Downloader/Loading.png",0-100*((DOWNLOADER_TICK_START-getTickCount()-3000)/1000),0,0,tocolor(255,255,255,255));

	--Discord
	dxDrawImage(60*Gsx,10*Gsy,60*Gsx,60*Gsy,":"..RESOURCE_NAME.."/Files/Images/Discord.png",0,0,0,tocolor(255,255,255,255));
	if(isTimer(DOWNLOADER_DISCORD_CLICKED))then
		dxDrawRectangle(10*Gsx,90*Gsy,160*Gsx,30*Gsy,tocolor(0,0,0,140));
		dxDrawText("Discord link copied",80*Gsx,110*Gsy,100*Gsx,100*Gsy,tocolor(255,255,255,255),1.10*Gsy,"sans","center","center",true,false,false,true,true);
	end
	--Youtube
	dxDrawImage(250*Gsx,10*Gsy,60*Gsx,60*Gsy,":"..RESOURCE_NAME.."/Files/Images/Youtube.png",0,0,0,tocolor(255,255,255,255));
	if(isTimer(DOWNLOADER_YOUTUBE_CLICKED))then
		dxDrawRectangle(200*Gsx,90*Gsy,160*Gsx,30*Gsy,tocolor(0,0,0,140));
		dxDrawText("Youtube link copied",460*Gsx,110*Gsy,100*Gsx,100*Gsy,tocolor(255,255,255,255),1.10*Gsy,"sans","center","center",true,false,false,true,true);
	end
end
function drawCEFloading()
	dxDrawImage(0,0,GLOBALscreenX,GLOBALscreenY,":"..RESOURCE_NAME.."/Files/Images/Downloader/"..DOWNLOADER_BACKGROUND_IMG..".png",0.0,0.0,0.0,tocolor(255,255,255,255),false);--bg
	dxDrawRectangle(0,0,GLOBALscreenX,GLOBALscreenY,tocolor(0,0,0,120),false);--bg
	
	dxDrawImage(1630*Gsx,0*Gsy,300*Gsx,130*Gsy,":"..RESOURCE_NAME.."/Files/Images/Logo.png",0,0,0,tocolor(255,255,255,255));

	dxDrawRectangle(25*Gsx,1005*Gsy,350*Gsx,15*Gsy,tocolor(0,0,0,100),false);--bg progress
	dxDrawText("Loading CEF",60*Gsx,1043*Gsy,200*Gsx,20*Gsy,tocolor(255,255,255,255),0.95*Gsx,"default-bold","left",_,_,_,false,_,_);
	if(LOADED_CEF>0)then
		dxDrawRectangle(25*Gsx,1005*Gsy,LOADED_CEF*350/Max_CEF*Gsx,15*Gsy,tocolor(0,240,255,100),false);
	end
	--spinning
	dxDrawImage(15*Gsx,1035*Gsy,30*Gsx,30*Gsy,":"..RESOURCE_NAME.."/Files/Images/Downloader/Loading.png",0-100*((DOWNLOADER_TICK_START-getTickCount()-3000)/1000),0,0,tocolor(255,255,255,255));

	--Discord
	dxDrawImage(60*Gsx,10*Gsy,60*Gsx,60*Gsy,":"..RESOURCE_NAME.."/Files/Images/Discord.png",0,0,0,tocolor(255,255,255,255));
	if(isTimer(DOWNLOADER_DISCORD_CLICKED))then
		dxDrawRectangle(10*Gsx,90*Gsy,160*Gsx,30*Gsy,tocolor(0,0,0,140));
		dxDrawText("Discord link copied",80*Gsx,110*Gsy,100*Gsx,100*Gsy,tocolor(255,255,255,255),1.10*Gsy,"sans","center","center",true,false,false,true,true);
	end
	--Youtube
	dxDrawImage(250*Gsx,10*Gsy,60*Gsx,60*Gsy,":"..RESOURCE_NAME.."/Files/Images/Youtube.png",0,0,0,tocolor(255,255,255,255));
	if(isTimer(DOWNLOADER_YOUTUBE_CLICKED))then
		dxDrawRectangle(200*Gsx,90*Gsy,160*Gsx,30*Gsy,tocolor(0,0,0,140));
		dxDrawText("Youtube link copied",460*Gsx,110*Gsy,100*Gsx,100*Gsy,tocolor(255,255,255,255),1.10*Gsy,"sans","center","center",true,false,false,true,true);
	end
end


local function antiCStackOverflow(filename)
	if(not(downloadFile(DOWNLOADER_PATHS[DOWNLOADER_COUNT])))then
		outputDebugString(DOWNLOADER_PATHS[DOWNLOADER_COUNT]);
		loadNextClientsidedFile(DOWNLOADER_PATHS[DOWNLOADER_COUNT]);
	end
end

function updateFileSize(size)
	DOWNLOADER_CURRENTFILE_SIZE=size;
end

function loadNextClientsidedFile(fileName,success)
	if(fileName==DOWNLOADER_PATHS[DOWNLOADER_COUNT])then
		if(DOWNLOADER_PATHS[DOWNLOADER_COUNT+1])then
			DOWNLOADER_CURRENTFILE=DOWNLOADER_PATHS[DOWNLOADER_COUNT+1];
			TargetFile=fileOpen(DOWNLOADER_PATHS[DOWNLOADER_COUNT]);
			if(TargetFile)then
				local TargetFileSize=fileGetSize(TargetFile);
				fileClose(TargetFile);
				updateFileSize(TargetFileSize);
			end

			DOWNLOADER_COUNT=DOWNLOADER_COUNT+1;
			CEF_LOADING_STATUS=nil;

			if(DOWNLOADER_COUNT%150==0)then
				setTimer(antiCStackOverflow,50,1);
			else
				if(not(downloadFile(DOWNLOADER_PATHS[DOWNLOADER_COUNT])))then
					outputDebugString(DOWNLOADER_PATHS[DOWNLOADER_COUNT]);
					loadNextClientsidedFile(DOWNLOADER_PATHS[DOWNLOADER_COUNT]);
				end
			end
		else
			removeEventHandler("onClientFileDownloadComplete",root,loadNextClientsidedFile);
			removeEventHandler("onClientRender",root,drawDownloadScreen);
			triggerEvent("onClientResourceStart_Custom",resourceRoot,getResourceName(resource));

			local CopyrightContent=string.format([[
			Gamemode: Made by DALE(huarycane) (Selfmade)

			Server logo Images: by _thresh_
			UI design inspirations: by rentner.r6
			Gamemode inspirations: by rentner.r6 / Crinimal Tycoon in Roblox



			Last Update: 06/16/2024]]);
			local Copyright=fileCreate("copyrights.txt");
			if(Copyright)then
				fileWrite(Copyright,tostring(CopyrightContent));
				fileClose(Copyright);
			end

			
			DOWNLOADER_COUNT=0;
			CEF_LOADING_STATUS=true;

			if(isTimer(DOWNLOADER_DISCORD_CLICKED))then
				killTimer(DOWNLOADER_DISCORD_CLICKED);
				DOWNLOADER_DISCORD_CLICKED=nil;
			end
			if(isTimer(DOWNLOADER_YOUTUBE_CLICKED))then
				killTimer(DOWNLOADER_YOUTUBE_CLICKED);
				DOWNLOADER_YOUTUBE_CLICKED=nil;
			end
			if(isElement(DOWNLOADER_MUSIC))then
				destroyElement(DOWNLOADER_MUSIC);
				DOWNLOADER_MUSIC=nil;
			end
			if(isTimer(CHARACTER_TIMER))then
				killTimer(CHARACTER_TIMER);
				CHARACTER_TIMER=nil;
			end
			unbindKey("M","DOWN",toggleDownloaderMusic);
		end
	end
end

addEventHandler("downloadClientsidedFiles",root,function(filepathsarray)
	DOWNLOADER_AMOUNT=#filepathsarray;
	for i=1,DOWNLOADER_AMOUNT do
		DOWNLOADER_PATHS[i]=filepathsarray[i];
	end
	addEventHandler("onClientFileDownloadComplete",root,loadNextClientsidedFile);
	DOWNLOADER_COUNT=DOWNLOADER_COUNT+1;
	DOWNLOADER_TICK_START=getTickCount();
	
	if(not(downloadFile(DOWNLOADER_PATHS[DOWNLOADER_COUNT])))then
		outputDebugString(DOWNLOADER_PATHS[DOWNLOADER_COUNT]);
		loadNextClientsidedFile(DOWNLOADER_PATHS[DOWNLOADER_COUNT]);
	end
end)


addEventHandler("onClientResourceStart",resourceRoot,function()
	addEventHandler("onClientRender",root,drawDownloadScreen);
	triggerServerEvent("clientResourceLoaded_Custom",localPlayer);

	showCursor(true);

	DOWNLOADER_MUSIC=playSound(":"..getResourceName(getThisResource()).."/Files/Audio/Downloader/Music.mp3",true);
	setSoundVolume(DOWNLOADER_MUSIC,0.5);

	CHARACTER_IMAGE=math.random(1,9);
	CHARACTER_DURATION=math.random(7000,10000);

	CHARACTER_TIMER=setTimer(function()
		CHARACTER_IMAGE=math.random(1,9);
		CHARACTER_TICK=getTickCount();
	end,CHARACTER_DURATION,0)

	bindKey("M","DOWN",toggleDownloaderMusic);
end)

addEventHandler("onClientClick",root,function(button,state)
	if(DOWNLOADER_COUNT>0)then
		if(button=="left" and state=="down")then
			if(isCursorOnElement(60*Gsx,10*Gsy,60*Gsx,60*Gsy)or isCursorOnElement(760*Gsx,110*Gsy,160*Gsx,30*Gsy))then
				if(not(isTimer(DOWNLOADER_DISCORD_CLICKED)))then
					setClipboard(Server.Discord.Invite);
					DOWNLOADER_DISCORD_CLICKED=setTimer(function()end,1000,1)
				end
			end

			if(isCursorOnElement(250*Gsx,10*Gsy,60*Gsx,60*Gsy)or isCursorOnElement(760*Gsx,110*Gsy,160*Gsx,30*Gsy))then
				if(not(isTimer(DOWNLOADER_YOUTUBE_CLICKED)))then
					setClipboard(Server.Youtube);
					DOWNLOADER_YOUTUBE_CLICKED=setTimer(function()end,1000,1)
				end
			end
		end
	end
end)









--[[ addEvent("Custom:Texture:Download:C",true)
addEventHandler("Custom:Texture:Download:C",root,function(id)
	triggerServerEvent("Custom:Texture:Download:S",root,id);
end) ]]




--[[ addEvent("printImageInfo", true)
addEventHandler( "printImageInfo", resourceRoot,function(pixels)
    local image = fileCreate ("image.png")
    fileWrite(image, pixels)
    local fileSize = fileGetSize(image)
    outputDebugString(fileSize)
    fileClose(image)
end) ]]