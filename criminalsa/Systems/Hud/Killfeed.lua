addRemoteEvents{"Killfeed:UI"};--addEvents


local Sound=nil;
local function triggerKillfeed(text)
    executeBrowserJavascript(BrowserNotify,"showKillfeed('"..text.."');");
end
addEventHandler("Killfeed:UI",root,function(text)
    triggerKillfeed(text);
end)