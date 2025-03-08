addRemoteEvents{"Textures:Load","Weapon:Skin:Load","Dufflebag:Skin:Load","Vehicle:Preview:Paintjob","Vehicle:Preview:Lightjob","Vehicle:Preview:WindowTint","Vehicle:Preview:NitroColor",
"Effect:Snow:Load",
};--addEvents


local Textures={};


addEventHandler("Textures:Load",root,function(type)
	if(type=="OneTime")then
		
	end

	if(type=="Crosshair")then
		local CrosshairNormal=getPlayerJsonValue(localPlayer,"Settings","CrosshairNormal");
		if(CrosshairNormal and CrosshairNormal>0)then
			Textures["CrosshairShader"]=dxCreateShader(":"..RESOURCE_NAME.."/Files/Textures/Crosshair.fx");
			Textures["CrosshairImage"]=dxCreateTexture(":"..RESOURCE_NAME.."/Files/Textures/Crosshairs/siteM16("..CrosshairNormal..").png");
			dxSetShaderValue(Textures["CrosshairShader"],"WeaponCrosshair",Textures["CrosshairImage"]);
			engineRemoveShaderFromWorldTexture(Textures["CrosshairShader"],"siteM16");
			engineApplyShaderToWorldTexture(Textures["CrosshairShader"],"siteM16");
		else
			if(Textures["CrosshairShader"])then
				engineRemoveShaderFromWorldTexture(Textures["CrosshairShader"],"siteM16");
			end
		end

		local CrosshairSniper=getPlayerJsonValue(localPlayer,"Settings","CrosshairSniper");
		if(CrosshairSniper and CrosshairSniper>0)then
			Textures["CrosshairShaderSniper"]=dxCreateShader(":"..RESOURCE_NAME.."/Files/Textures/Crosshair.fx");
			Textures["CrosshairImageSniper"]=dxCreateTexture(":"..RESOURCE_NAME.."/Files/Textures/Crosshairs/SNIPERcrosshair("..CrosshairSniper..").png");
			dxSetShaderValue(Textures["CrosshairShaderSniper"],"WeaponCrosshair",Textures["CrosshairImageSniper"]);
			engineRemoveShaderFromWorldTexture(Textures["CrosshairShaderSniper"],"SNIPERcrosshair");
			engineApplyShaderToWorldTexture(Textures["CrosshairShaderSniper"],"SNIPERcrosshair");
		else
			if(Textures["CrosshairShaderSniper"])then
				engineRemoveShaderFromWorldTexture(Textures["CrosshairShaderSniper"],"SNIPERcrosshair");
			end
		end
	end
end)


local TexTbl={
	["Hideout"]={
		fxFile=":"..RESOURCE_NAME.."/Files/Textures/Main.fx",
		textureFile=":"..RESOURCE_NAME.."/Files/Textures/Hideout.png",
		textureName="scrapmet1_lae",
	},
	["Hideout2"]={
		fxFile=":"..RESOURCE_NAME.."/Files/Textures/Main.fx",
		textureFile=":"..RESOURCE_NAME.."/Files/Textures/Hideout2.png",
		textureName="astagesign",
	},
}
addEventHandler("onClientResourceStart_Custom",resourceRoot,function()
	for name,_ in pairs(TexTbl)do
		if(fileExists(TexTbl[name].fxFile)and fileExists(TexTbl[name].textureFile))then
			Textures[name..":Shader"]=dxCreateShader(TexTbl[name].fxFile);
			Textures[name..":Texture"]=dxCreateTexture(TexTbl[name].textureFile);
			dxSetShaderValue(Textures[name..":Shader"],"Tex",Textures[name..":Texture"]);
			engineApplyShaderToWorldTexture(Textures[name..":Shader"],TexTbl[name].textureName);
		else
			triggerServerEvent("ModFailKick:S",localPlayer,"fx");
		end
	end
end)



--Custom Paintjobs
local customPaintjobs={};
local customPaintjobShaderToWorld=nil;

local function toggleCustomPaintjobs(veh,id)
	if(id)then
		local VehicleID=tonumber(getElementData(veh,"Vehicle:Data:VehID"));
		if(tonumber(id)>=4 and tonumber(id)~=9999999)then
			if(getPlayerJsonValue(localPlayer,"Settings","ShadersPaintjobs")==1)then
				return;
			end

			if(customPaintjobs[veh]and isElement(customPaintjobs[veh]["shader"]))then
				destroyElement(customPaintjobs[veh]["shader"]);
			end
			customPaintjobs[veh]={};

			local Shader=dxCreateShader(":"..RESOURCE_NAME.."/Files/Textures/Paintjob.fx",0,50,true,"vehicle");
			if(Shader and isElement(Shader))then
				if(Vehicle.Tuning["ShaderTexNames"][VehicleID])then
					customPaintjobShaderToWorld=Vehicle.Tuning["ShaderTexNames"][VehicleID];
				else
					customPaintjobShaderToWorld="vehiclegrunge256";
				end
				engineApplyShaderToWorldTexture(Shader,customPaintjobShaderToWorld,veh);
				engineApplyShaderToWorldTexture(Shader,"?emap*",veh);

				if(not(customPaintjobs[veh]["texture"]))then
					customPaintjobs[veh]["texture"]=dxCreateTexture(":"..RESOURCE_NAME.."/Files/Textures/Paintjobs/"..tostring(id)..".png");
				end
				if(customPaintjobs[veh]["texture"]and isElement(customPaintjobs[veh]["texture"]))then
					dxSetShaderValue(Shader,"CustomPaint",customPaintjobs[veh]["texture"]);
				end

				customPaintjobs[veh]["shader"]=Shader;
			end
		else--delete
			if(customPaintjobs[veh]and isElement(customPaintjobs[veh]["shader"]))then
				destroyElement(customPaintjobs[veh]["shader"]);
			end
			customPaintjobs[veh]={};
		end
	else--delete
		if(customPaintjobs[veh]and isElement(customPaintjobs[veh]["shader"]))then
			destroyElement(customPaintjobs[veh]["shader"]);
		end
		customPaintjobs[veh]={};
	end
end
addEventHandler("Vehicle:Preview:Paintjob",root,toggleCustomPaintjobs)

addEventHandler("onClientElementStreamIn",root,function()
	if(getElementType(source)=="vehicle" and getElementData(source,"Vehicle:Data:Type"))then
		local Paintjob=tonumber(getVehicleJsonValue(source,"Tunings","Paintjob"))or nil;
		if(Paintjob and Paintjob>=4)then
			toggleCustomPaintjobs(source,Paintjob);
		end
	end
end)
addEventHandler("onClientElementStreamOut",root,function()
	if(getElementType(source)=="vehicle")then
		toggleCustomPaintjobs(source);
	end
end)



--Custom Lightjob
local customLightjobs={};

local function toggleCustomLightjobs(veh,id)
	if(id)then
		if(tonumber(id)>=0 and tonumber(id)~=9999999)then
			if(getPlayerJsonValue(localPlayer,"Settings","ShadersLightjobs")==1)then
				return;
			end

			if(customLightjobs[veh]and isElement(customLightjobs[veh]["shader"]))then
				destroyElement(customLightjobs[veh]["shader"]);
			end
			customLightjobs[veh]={};

			local Shader=dxCreateShader(":"..RESOURCE_NAME.."/Files/Textures/Lights.fx",0,50,true,"vehicle");
			if(Shader and isElement(Shader))then
				engineRemoveShaderFromWorldTexture(Shader,"vehiclelights128",veh);
				engineRemoveShaderFromWorldTexture(Shader,"vehiclelightson128",veh);
				engineApplyShaderToWorldTexture(Shader,"vehiclelights128",veh);
				engineApplyShaderToWorldTexture(Shader,"vehiclelightson128",veh);

				if(not(customLightjobs[veh]["texture"]))then
					customLightjobs[veh]["texture"]=dxCreateTexture(":"..RESOURCE_NAME.."/Files/Textures/Lights/"..tostring(id)..".png");
				end
				if(customLightjobs[veh]["texture"]and isElement(customLightjobs[veh]["texture"]))then
					dxSetShaderValue(Shader,"CustomLights",customLightjobs[veh]["texture"]);
				end

				customLightjobs[veh]["shader"]=Shader;
			end
		else--delete
			if(customLightjobs[veh]and isElement(customLightjobs[veh]["shader"]))then
				engineRemoveShaderFromWorldTexture(customLightjobs[veh]["shader"],"vehiclelights128",veh);
				engineRemoveShaderFromWorldTexture(customLightjobs[veh]["shader"],"vehiclelightson128",veh);
				destroyElement(customLightjobs[veh]["shader"]);
			end
			customLightjobs[veh]={};
		end
	else--delete
		if(customLightjobs[veh]and isElement(customLightjobs[veh]["shader"]))then
			engineRemoveShaderFromWorldTexture(customLightjobs[veh]["shader"],"vehiclelights128",veh);
			engineRemoveShaderFromWorldTexture(customLightjobs[veh]["shader"],"vehiclelightson128",veh);
			destroyElement(customLightjobs[veh]["shader"]);
		end
		customLightjobs[veh]={};
	end
end
addEventHandler("Vehicle:Preview:Lightjob",root,toggleCustomLightjobs)

addEventHandler("onClientElementStreamIn",root,function()
	if(getElementType(source)=="vehicle" and getElementData(source,"Vehicle:Data:Type"))then
		local Lightjob=tonumber(getVehicleJsonValue(source,"Tunings","Lightjob"))or nil;
		if(Lightjob and Lightjob>0 and Lightjob~=9999999)then
			toggleCustomLightjobs(source,Lightjob);
		end
	end
end)
addEventHandler("onClientElementStreamOut",root,function()
	if(getElementType(source)=="vehicle")then
		toggleCustomLightjobs(source);
	end
end)

--Custom Windowtint
local VehicleWindowTintFX=[[
	struct VS_OUTPUT
	{
		float2 texCoord : TEXCOORD0;
		float4 vertexColor : COLOR0;
	};

	sampler2D glassTexture;
	float4 WindowTintColor;
	float alphaThreshold;
	float darknessFactor;

	float4 PS_Main(VS_OUTPUT input) : COLOR
	{
		float4 originalColor = tex2D(glassTexture, input.texCoord);

		float vertexAlpha = input.vertexColor.a;

		float4 darkenedTintColor = WindowTintColor * darknessFactor;

		if (vertexAlpha < alphaThreshold && originalColor.a > alphaThreshold)
		{
			return lerp(originalColor * input.vertexColor, darkenedTintColor, 0.5);
		}
		else
		{
			return originalColor * input.vertexColor;
		}
	}

	technique TintedGlass
	{
		pass P0
		{
			PixelShader = compile ps_2_0 PS_Main();
		}
	}
]]
local customWindowTints={};

local customWindowTintsGlassShader,_=dxCreateShader(":"..RESOURCE_NAME.."/Files/Textures/VehicleWindowTintFix.fx");
local customWindowTintsGlassTexture=dxCreateTexture(":"..RESOURCE_NAME.."/Files/Textures/VehicleWindowGlassFix.png");
dxSetShaderValue(customWindowTintsGlassShader,"VehicleWindowTexture",customWindowTintsGlassTexture);

local function toggleCustomWindowtints(veh,id)
	if(id)then
		if(tonumber(id)>0 and tonumber(id)~=9999999)then
			if(getPlayerJsonValue(localPlayer,"Settings","ShadersWindowtints")==1)then
				return;
			end

			if(customWindowTints[veh]and isElement(customWindowTints[veh]["shader"]))then
				destroyElement(customWindowTints[veh]["shader"]);
			end
			customWindowTints[veh]={};

			if(Vehicle.Tuning.WindowTintColors[tonumber(id)])then
				local Shader=dxCreateShader(VehicleWindowTintFX,0,45,true,"vehicle");
				if(Shader and isElement(Shader))then
					engineRemoveShaderFromWorldTexture(Shader,"vehiclegeneric256",veh);
					engineApplyShaderToWorldTexture(Shader,"vehiclegeneric256",veh);
					engineApplyShaderToWorldTexture(customWindowTintsGlassShader,"vehicleshatter128",veh);--window fix
					
					if(customWindowTintsGlassShader and isElement(customWindowTintsGlassShader))then
						dxSetShaderValue(Shader,"WindowTintColor",Vehicle.Tuning.WindowTintColors[tonumber(id)][1]/255,Vehicle.Tuning.WindowTintColors[tonumber(id)][2]/255,Vehicle.Tuning.WindowTintColors[tonumber(id)][3]/255,Vehicle.Tuning.WindowTintColors[tonumber(id)][4]/255);
						dxSetShaderValue(Shader,"alphaThreshold",0.6);
						dxSetShaderValue(Shader,"darknessFactor",Vehicle.Tuning.WindowTintColors[tonumber(id)][5]);
					end

					customWindowTints[veh]["shader"]=Shader;
				end
			end
		else--delete
			if(customWindowTints[veh]and isElement(customWindowTints[veh]["shader"]))then
				engineRemoveShaderFromWorldTexture(customWindowTints[veh]["shader"],"vehiclegeneric256",veh);
				destroyElement(customWindowTints[veh]["shader"]);
			end
			customWindowTints[veh]={};
		end
	else--delete
		if(customWindowTints[veh]and isElement(customWindowTints[veh]["shader"]))then
			engineRemoveShaderFromWorldTexture(customWindowTints[veh]["shader"],"vehiclegeneric256",veh);
			destroyElement(customWindowTints[veh]["shader"]);
		end
		customWindowTints[veh]={};
	end
end
addEventHandler("Vehicle:Preview:WindowTint",root,toggleCustomWindowtints)

addEventHandler("onClientElementStreamIn",root,function()
	if(getElementType(source)=="vehicle" and getElementData(source,"Vehicle:Data:Type"))then
		local WindowTint=tonumber(getVehicleJsonValue(source,"Tunings","WindowTint"))or nil;
		if(WindowTint and WindowTint>0 and WindowTint~=9999999)then
			toggleCustomWindowtints(source,WindowTint);
		end
	end
end)
addEventHandler("onClientElementStreamOut",root,function()
	if(getElementType(source)=="vehicle")then
		toggleCustomWindowtints(source);
	end
end)

function breakWindowFix()
	local x,y,z=getElementPosition(localPlayer);
    for _,v in pairs(getElementsWithinRange(x,y,z,40,"vehicle"))do
		if(getVehiclePanelState(v,4)>0)then
			setVehiclePanelState(v,4,0);
		end
	end
end
setTimer(breakWindowFix,2500,0)




--Weapon skins
local customWeaponSkins={["shader"]={},};
WeaponShaderNames={
	[24]="pist_deagle",
	[25]="shot_xm1014",
	[29]="mp5",
	[30]="ak47",
	[31]="rif_m4a1",
	[34]="9f257c2f",
}

local function toggleCustomWeaponSkins(player,weapon,id)
	if(id and tonumber(id)>0 and WeaponShaderNames[weapon])then
		if(customWeaponSkins[player]and customWeaponSkins[player]["shader"])then
			if(isElement(customWeaponSkins[player]["shader"][weapon]))then
				destroyElement(customWeaponSkins[player]["shader"][weapon]);
			end
			if(isElement(customWeaponSkins[player]["texture"]))then
				destroyElement(customWeaponSkins[player]["texture"]);
			end
			customWeaponSkins[player]["shader"]=nil;
		end
		customWeaponSkins[player]={["shader"]={}};

		local Shader=dxCreateShader(":"..RESOURCE_NAME.."/Files/Textures/Weapons.fx",0,45,true,"ped");
		if(Shader and isElement(Shader))then
			engineApplyShaderToWorldTexture(Shader,WeaponShaderNames[tonumber(weapon)],player);

			if(not(customWeaponSkins[player]["texture"]))then
				customWeaponSkins[player]["texture"]=dxCreateTexture(":"..RESOURCE_NAME.."/Files/Textures/Weapons/"..weapon.."/"..tostring(id)..".png");
			end
			if(customWeaponSkins[player]["texture"]and isElement(customWeaponSkins[player]["texture"]))then
				dxSetShaderValue(Shader,"WeaponSkin",customWeaponSkins[player]["texture"]);
			end

			customWeaponSkins[player]["shader"][weapon]=Shader;
		end
	else--delete
		if(customWeaponSkins[player]and customWeaponSkins[player]["shader"])then
			if(isElement(customWeaponSkins[player]["shader"][weapon]))then
				destroyElement(customWeaponSkins[player]["shader"][weapon]);
			end
			if(isElement(customWeaponSkins[player]["texture"]))then
				destroyElement(customWeaponSkins[player]["texture"]);
			end
			customWeaponSkins[player]["shader"]=nil;
		end
		customWeaponSkins[player]={["shader"]={}};
	end
end
addEventHandler("Weapon:Skin:Load",root,toggleCustomWeaponSkins)

addEventHandler("onClientElementStreamIn",root,function()
	if(getElementType(source)=="player")then
		for _,weapon in ipairs(getPedWeapons(source))do
			if(weapon>22 and WeaponShaderNames[weapon])then
				local SkinID=getPlayerJsonValue(source,"WeaponSkins",tostring(weapon));
				if(SkinID>0)then
					toggleCustomWeaponSkins(source,weapon,SkinID);
				end
			end
        end
	end
end)
addEventHandler("onClientElementStreamOut",root,function()
	if(getElementType(source)=="player")then
		toggleCustomWeaponSkins(source);
	end
end)



--Snow
local maxEffectDistance=250;
local nextCheckTime=0;
local snowApplyList = {
	"*",
}
local snowRemoveList = {
	"",												-- unnamed

	"vehicle*", "?emap*", "?hite*",					-- vehicles
	"*92*", "*wheel*", "*interior*",				-- vehicles
	"*handle*", "*body*", "*decal*",				-- vehicles
	"*8bit*", "*logos*", "*badge*",					-- vehicles
	"*plate*", "*sign*",							-- vehicles
	"headlight", "headlight1",						-- vehicles

	"shad*",										-- shadows
	"coronastar",									-- coronas
	"tx*",											-- grass effect
	"lod*",											-- lod models
	"cj_w_grad",									-- checkpoint texture
	"*cloud*",										-- clouds
	"*smoke*",										-- smoke
	"sphere_cj",									-- nitro heat haze mask
	"particle*",									-- particle skid and maybe others
	"*water*", "sw_sand", "coral",					-- sea
}
local treeApplyList = {--trees and shrubs
	"sm_des_bush*", "*tree*", "*ivy*", "*pine*",
	"veg_*", "*largefur*", "hazelbr*", "weeelm",
	"*branch*", "cypress*",
	"*bark*", "gen_log", "trunk5",
	"bchamae", "vegaspalm01_128",

}
local naughtyTreeApplyList = {--naughty trees and shrubs
	"planta256", "sm_josh_leaf", "kbtree4_test", "trunk3",
	"newtreeleaves128", "ashbrnch", "pinelo128", "tree19mi",
	"lod_largefurs07", "veg_largefurs05","veg_largefurs06",
	"fuzzyplant256", "foliage256", "cypress1", "cypress2",
}
addEventHandler("Effect:Snow:Load",root,function(toggle)
	if(toggle==true)then
		snowShader=dxCreateShader(":"..RESOURCE_NAME.."/Files/Textures/Snow/Ground.fx",0,maxEffectDistance);
		treeShader=dxCreateShader(":"..RESOURCE_NAME.."/Files/Textures/Snow/Trees.fx");
		naughtyTreeShader=dxCreateShader(":"..RESOURCE_NAME.."/Files/Textures/Snow/TreesNaughty.fx");
		sNoiseTexture=dxCreateTexture(":"..RESOURCE_NAME.."/Files/Textures/Snow/Snow.dds");

		if not snowShader or not treeShader or not naughtyTreeShader or not sNoiseTexture then
			--outputChatBox( "Could not create shader. Please use debugscript 3" )
			return nil;
		end

		-- Setup shaders
		dxSetShaderValue(treeShader,"sNoiseTexture",sNoiseTexture);
		dxSetShaderValue(naughtyTreeShader,"sNoiseTexture",sNoiseTexture);
		dxSetShaderValue(snowShader,"sNoiseTexture",sNoiseTexture);
		dxSetShaderValue(snowShader,"sFadeEnd",maxEffectDistance);
		dxSetShaderValue(snowShader,"sFadeStart",maxEffectDistance/2);

		-- Process snow apply list
		for _,applyMatch in ipairs(snowApplyList)do
			engineApplyShaderToWorldTexture(snowShader,applyMatch);
		end

		-- Process snow remove list
		for _,removeMatch in ipairs(snowRemoveList)do
			engineRemoveShaderFromWorldTexture(snowShader,removeMatch);
		end

		-- Process tree apply list
		for _,applyMatch in ipairs(treeApplyList)do
			engineApplyShaderToWorldTexture(treeShader,applyMatch);
		end

		-- Process naughty tree apply list
		for _,applyMatch in ipairs(naughtyTreeApplyList)do
			engineApplyShaderToWorldTexture(naughtyTreeShader,applyMatch);
		end

		-- Init vehicle checker
		doneVehTexRemove={}
		vehTimer=setTimer(checkCurrentVehicle,100,0);
		removeVehTextures();
	else
		destroyElement(sNoiseTexture);
		destroyElement(treeShader);
		destroyElement(naughtyTreeShader);
		destroyElement(snowShader);

		killTimer(vehTimer);
	end
end)

function removeVehTexturesSoon()
    nextCheckTime=getTickCount()+200;
end
function checkCurrentVehicle()
	local veh=getPedOccupiedVehicle(localPlayer);
	local id=veh and getElementModel(veh);
	if lastveh ~= veh or lastid ~= id then
		lastveh = veh
		lastid = id
		removeVehTexturesSoon();
	end
	if nextCheckTime < getTickCount() then
		nextCheckTime=getTickCount()+5000
		removeVehTextures();
	end
end
function removeVehTextures()
	local veh = getPedOccupiedVehicle(localPlayer)
	if veh then
		local id = getElementModel(veh)
		local vis = engineGetVisibleTextureNames("*",id)
		if vis then	
			for _,removeMatch in pairs(vis) do
				if not doneVehTexRemove[removeMatch] then
					doneVehTexRemove[removeMatch] = true
					engineRemoveShaderFromWorldTexture ( snowShader, removeMatch )
				end
			end
		end
	end
end