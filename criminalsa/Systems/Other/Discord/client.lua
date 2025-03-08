local application={};

function setDiscordRichPresence()
    if(not(isDiscordRichPresenceConnected()))then
        return;
    end
    resetDiscordRichPresenceData();

    local DiscordStatusConnected=setDiscordApplicationID(application.Bot.ID);
    if(DiscordStatusConnected)then
        if(application.Bot.Logo.Text and application.Bot.Logo.Text:len()>0)then
            setDiscordRichPresenceAsset(application.Bot.Logo.Image,application.Bot.Logo.Text);
        end
        if(application.Bot.Logo.Text and application.Bot.LogoSmall.Text:len()>0)then
            setDiscordRichPresenceSmallAsset(application.Bot.LogoSmall.Image,application.Bot.LogoSmall.Text);
        end

        --buttons
        if(application.Bot.Buttons[1]and application.Bot.Buttons[1].Status)then
            setDiscordRichPresenceButton(1,application.Bot.Buttons[1].Text,application.Bot.Buttons[1].URL);
        end
        if(application.Bot.Buttons[2]and application.Bot.Buttons[2].Status)then
            setDiscordRichPresenceButton(2,application.Bot.Buttons[2].Text,application.Bot.Buttons[2].URL);
        end

        --description aka player count
        setDiscordRichPresencePartySize(#getElementsByType("player"),application.Bot.MaxPlayers);
        if(application.Bot.Text and application.Bot.Text:len()>0)then
            setDiscordRichPresenceState(application.Bot.Text);
        end

        if(application.Bot.Description and application.Bot.Description:len()>0)then
            setDiscordRichPresenceDetails(application.Bot.Description);
        end


        setDiscordRichPresenceStartTime(1);
    end
end

addEvent("addPlayerRichPresence",true);
addEventHandler("addPlayerRichPresence",localPlayer,function(data)
    application=data;
    setDiscordRichPresence();
end,false)

addEventHandler("onClientPlayerJoin",root,function()
    if(not isDiscordRichPresenceConnected())then
        return;
    end

     setDiscordRichPresencePartySize(#getElementsByType("player"),application.Bot.MaxPlayers);
end)
addEventHandler("onClientPlayerQuit",root,function()
    if(not isDiscordRichPresenceConnected())then
        return;
    end
        
    setDiscordRichPresencePartySize(#getElementsByType("player"),application.Bot.MaxPlayers);
end)




--[[ local Count=0;
addEventHandler("onClientPreRender",root,function()
    if(not(isLoggedin()))then
        return;
    end
    if(isPedDead(localPlayer))then
        return;
    end

    if(getKeyState("F12"))then
        Count=Count+1;
        if(Count==1)then
            triggerServerEvent("Logs:Screenshots",localPlayer);
        end
    else
        Count=0;
    end
end) ]]