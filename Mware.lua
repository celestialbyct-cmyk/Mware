-- Maneware Hub | выбор игры: MM2 / Universal
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local env = (getgenv and getgenv()) or _G

local function getGuiParent()
	local ok, parent = pcall(function()
		if typeof(gethui) == "function" then return gethui() end
		return game:GetService("CoreGui")
	end)
	if ok and parent then return parent end
	return Players.LocalPlayer:WaitForChild("PlayerGui")
end
local guiParent = getGuiParent()
do
	local old = guiParent:FindFirstChild("ManewareLauncher")
	if old then old:Destroy() end
end

local NL_LIB = [=====[
--[[
                          Neverlose.cc UI Library
    Author: 4lpaca
	License: MIT
    Discord: https://arceney.win/discord
    Other-Projects: https://4lpaca.win
]]

do
	local Constant = 'L'..'P'..'H'..'_NO_VIRTUALIZE';
	getfenv()[Constant] = getfenv()[Constant] or function(f) return f end;
end;

cloneref = cloneref or function(i) return i end;
gethui = gethui or get_hidden_gui;
getcustomasset = getcustomasset or getsynasset;
getgenv = getgenv or getfenv;

local LOAD_ENV = LPH_NO_VIRTUALIZE(function()
	if game:GetService('RunService'):IsStudio() then
		local BaseWorkspace = game:GetService("ReplicatedFirst"):FindFirstChild('PRI_WORKSPACE') or Instance.new('Folder',game:GetService("ReplicatedFirst"));

		BaseWorkspace.Name = 'PRI\0.'..tostring(string.char(math.random(50,120)))..tostring(string.char(math.random(50,120)))..tostring(string.char(math.random(50,120)))..tostring(string.char(math.random(50,120)))..tostring(string.char(math.random(50,120)))..tostring(string.char(math.random(50,120)));

		local __get_path_c = function(path)
			return (string.find(path,'/',1,true) and string.split(path,'/')) or (string.find(path,'\\',1,true) and string.split(path,'\\')) or {path};
		end;

		local __get_path = function(path)
			local main = __get_path_c(path);

			local block = BaseWorkspace;

			for i,v in next , main do
				block = block[v];
			end;

			return block;
		end;

		getgenv().readfile = function(path)
			local path : StringValue = __get_path(path);

			return path.Value;
		end;

		getgenv().isfile = function(path)
			local success , message = pcall(function()
				return __get_path(path);
			end);

			if success and not message:IsA("Folder") then
				return true;
			end;

			return false;
		end;

		getgenv().isfolder = function(path)
			local success , message = pcall(function()
				return __get_path(path);
			end);

			if success and message:IsA("Folder") then
				return true;
			end;

			return false;
		end;

		getgenv().writefile = function(path,content)
			local main = __get_path_c(path);

			local block = BaseWorkspace;

			for i,v in next , main do
				local item = block:FindFirstChild(v);
				if not item then
					local c = Instance.new('StringValue',block);

					c.Name = tostring(v);
					c.Value = content;
				else
					if item:IsA('StringValue') and tostring(item) == v then
						item.Name = tostring(v);
						item.Value = content;
					end;

					block = item;
				end;
			end;
		end;

		getgenv().listfiles = function(path)
			local fold = __get_path(path);
			local pa = {};

			for i,v in next , fold:GetChildren() do
				if v:IsA('StringValue') then
					table.insert(pa,path..'/'..tostring(v));
				end;
			end;

			return pa;
		end;

		getgenv().makefolder = function(path)
			local main = __get_path_c(path);

			local block = BaseWorkspace;

			for i,v in next , main do
				local item = block:FindFirstChild(v);
				if not item then
					local c = Instance.new('Folder',block);

					c.Name = tostring(v);
				else
					block = item;
				end;
			end;
		end;

		getgenv().delfile = function(path)
			local main = __get_path_c(path);

			local block = BaseWorkspace;

			for i,v in next , main do
				local item = block:FindFirstChild(v);
				if item and item:IsA('StringValue') then
					item:Destroy();
				else
					block = item;
				end;
			end;
		end;
	end;
end)

LOAD_ENV();

writefile = writefile or getgenv().writefile;
makefolder = makefolder or getgenv().makefolder;
readfile = readfile or getgenv().readfile;
delfolder = delfolder or getgenv().delfolder;
delfile = delfile or getgenv().delfile;
listfiles = listfiles or getgenv().listfiles;
isfolder = isfolder or getgenv().isfolder;
isfile = isfile or getgenv().isfile;

local NeverLose = {};

NeverLose.BuiltInRegular = Font.new('rbxasset://LuaPackages/Packages/_Index/BuilderIcons/BuilderIcons/BuilderIcons.json',Enum.FontWeight.Regular,Enum.FontStyle.Normal);
NeverLose.BuiltInBold = Font.new('rbxasset://LuaPackages/Packages/_Index/BuilderIcons/BuilderIcons/BuilderIcons.json',Enum.FontWeight.Bold,Enum.FontStyle.Normal);
NeverLose.GlobalSignals = {};
NeverLose.UnloadEnabled = false;

local cloneref: cloneref = cloneref or function(f) return f end;
local TweenService: TweenService = cloneref(game:GetService('TweenService'));
local UserInputService: UserInputService = cloneref(game:GetService('UserInputService'));
local TextService: TextService = cloneref(game:GetService('TextService'));
local RunService: RunService = cloneref(game:GetService('RunService'));
local Players: Players = cloneref(game:GetService('Players'));
local HttpService: HttpService = cloneref(game:GetService('HttpService'));
local LocalPlayer: Player = Players.LocalPlayer;
local CoreGui: PlayerGui = (gethui and gethui()) or (get_hidden_gui and get_hidden_gui()) or cloneref(game:FindFirstChild('CoreGui')) or cloneref(LocalPlayer.PlayerGui);
local Mouse: Mouse = LocalPlayer:GetMouse();
local CurrentCamera: Camera = cloneref(workspace.CurrentCamera);
local ProtectGui = protect_gui or protectgui or (syn and syn.protect_gui) or function(s) return s; end;
local GlobalWindow = Instance.new('ScreenGui');
local ManualTween = TweenInfo.new(0.1);
local SlowyTween = TweenInfo.new(0.175);
local FastTween = TweenInfo.new(0.05);
local VSlowTween = TweenInfo.new(0.5,Enum.EasingStyle.Quint);
local Encryption = {};

NeverLose.UserProfile = Players:GetUserThumbnailAsync(LocalPlayer.UserId , Enum.ThumbnailType.HeadShot , Enum.ThumbnailSize.Size150x150)
NeverLose.RandomString = LPH_NO_VIRTUALIZE(function()
	return string.rep(string.char(math.random(1,7)),math.random(1,4))..string.rep(string.char(math.random(1,7)),math.random(1,4))..string.rep(string.char(math.random(1,7)),math.random(1,4))..string.rep(string.char(math.random(1,7)),math.random(1,4))..string.rep(string.char(math.random(1,7)),math.random(1,4))..string.rep(string.char(math.random(1,7)),math.random(1,4))..string.rep(string.char(math.random(1,7)),math.random(1,4))..string.rep(string.char(math.random(1,7)),math.random(1,4))..string.rep(string.char(math.random(1,7)),math.random(1,4))..string.rep(string.char(math.random(1,7)),math.random(1,4))..string.rep(string.char(math.random(1,7)),math.random(1,4));
end);

ProtectGui(GlobalWindow);

GlobalWindow.Name = NeverLose.RandomString();
GlobalWindow.IgnoreGuiInset = true;
GlobalWindow.ZIndexBehavior = Enum.ZIndexBehavior.Global;
GlobalWindow.ResetOnSpawn = false;
GlobalWindow.Parent = CoreGui;

NeverLose.Scales = {
	Small = UDim2.fromOffset(540,380),
	Mobile = UDim2.fromOffset(640,385),
	Default = UDim2.fromOffset(640 , 480),
	Large = UDim2.fromOffset(800 , 600)
};

NeverLose.IconColor = Color3.fromRGB(255, 255, 255);
NeverLose.ScreenGui = GlobalWindow;
NeverLose.Flags = {};
NeverLose.AccentColor = Color3.fromRGB(78, 127, 252);
NeverLose.MainColor = Color3.fromRGB(8, 8, 13);
NeverLose.RegisiteryColor = {};
NeverLose.NameRegisitry = {};
NeverLose.IsMosueOverOtherFrame = false;
NeverLose.GlobalLogo = "rbxassetid://120358385035996";
NeverLose.ImageColorMapping = "rbxassetid://4155801252";

if getcustomasset then
	local link = "https://github.com/4lpaca-pin/NeverLose/blob/main/assets/%s?raw=true";
	local dir = 'NLAssets';

	if not isfolder(dir) then
		makefolder(dir);
	end;

	pcall(function()
		if not isfile(dir..'/'..'logo.png') then
			local byte = game:HttpGet(string.format(link,'logo.png'));

			writefile(dir..'/'..'logo.png' , byte);
			task.wait();
		end;

		if isfile(dir..'/'..'logo.png') then
			NeverLose.GlobalLogo = getcustomasset(dir..'/'..'logo.png')
		end;
	end);

	pcall(function()
		if not isfile(dir..'/'..'saturation_value_gradient.png') then
			local byte = game:HttpGet(string.format(link,'saturation_value_gradient.png'));

			writefile(dir..'/'..'saturation_value_gradient.png' , byte);
			task.wait();
		end;

		if isfile(dir..'/'..'saturation_value_gradient.png') then
			NeverLose.ImageColorMapping = getcustomasset(dir..'/'..'saturation_value_gradient.png')
		end;
	end);
end;

function NeverLose:AddSignal(RBXSignal)
	if NeverLose.UnloadEnabled then
		table.insert(NeverLose.GlobalSignals,RBXSignal);
	end;

	return RBXSignal;
end;

function NeverLose:AddQuery(ItemRoot: Frame , Name : string)
	table.insert(NeverLose.NameRegisitry , {
		Root = ItemRoot,
		Idx = Name,
	});
end;

function Encryption.new(data: string)
	local bytes = {};
	local encrypt_seed = ((#data + 3782) % 111) + 1;

	string.gsub(data , '.', LPH_NO_VIRTUALIZE(function(dt)
		table.insert(bytes , tostring(dt:byte() + encrypt_seed));
	end));

	local concatbyte = table.concat(bytes,'?');

	table.clear(bytes);

	return "{"..tostring(encrypt_seed + 72667).."}?"..concatbyte;
end;

function Encryption.reverse(data: string)
	local main_data = string.split(data,'?');
	local seed_str = main_data[1]:gsub('{',''):gsub('}','');
	local seed = tonumber(seed_str);

	local ks = {};
	local real_seed = seed - 72667;

	for i,v in next , main_data do
		if i > 1 then
			local fake_byte = tonumber(v);
			table.insert(ks , string.char(fake_byte - real_seed))	
		end;
	end;

	local data = table.concat(ks);

	table.clear(ks);

	return data;
end;

do
	local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';

	NeverLose.Base64Encode = LPH_NO_VIRTUALIZE(function(data)
		return ((data:gsub('.', function(x) 
			local r,b='',x:byte()
			for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
			return r;
		end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
			if (#x < 6) then return '' end
			local c=0
			for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
			return b:sub(c+1,c+1)
		end)..({ '', '==', '=' })[#data%3+1])
	end);

	NeverLose.Base64Decode = LPH_NO_VIRTUALIZE(function(data)
		data = string.gsub(data, '[^'..b..'=]', '')
		return (data:gsub('.', function(x)
			if (x == '=') then return '' end
			local r,f='',(b:find(x)-1)
			for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
			return r;
		end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
			if (#x ~= 8) then return '' end
			local c=0
			for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
			return string.char(c)
		end))
	end);
end;

NeverLose.LoadIcon = LPH_NO_VIRTUALIZE(function()
	NeverLose.RobloxIcon = {
		["3d-cube-arrow-left"] = "3d-cube-arrow-left",
		["amazon"] = "amazon",
		["arm-left"] = "arm-left",
		["arm-right"] = "arm-right",
		["arrow-curl-to-left"] = "arrow-curl-to-left",
		["arrow-curl-to-right"] = "arrow-curl-to-right",
		["arrow-down-to-line"] = "arrow-down-to-line",
		["arrow-large-down"] = "arrow-large-down",
		["arrow-large-left"] = "arrow-large-left",
		["arrow-large-right"] = "arrow-large-right",
		["arrow-large-up"] = "arrow-large-up",
		["arrow-right-from-portrait-rectangle"] = "arrow-right-from-portrait-rectangle",
		["arrow-right-to-portrait-rectangle"] = "arrow-right-to-portrait-rectangle",
		["arrow-rotate-down-dashed"] = "arrow-rotate-down-dashed",
		["arrow-rotate-right"] = "arrow-rotate-right",
		["arrow-rotate-right-dashed"] = "arrow-rotate-right-dashed",
		["arrow-small-down"] = "arrow-small-down",
		["arrow-small-left"] = "arrow-small-left",
		["arrow-small-right"] = "arrow-small-right",
		["arrow-small-up"] = "arrow-small-up",
		["arrow-spin-clockwise"] = "arrow-spin-clockwise",
		["arrow-spin-clockwise-10"] = "arrow-spin-clockwise-10",
		["arrow-spin-clockwise-15"] = "arrow-spin-clockwise-15",
		["arrow-spin-clockwise-30"] = "arrow-spin-clockwise-30",
		["arrow-spin-counter-clockwise-10"] = "arrow-spin-counter-clockwise-10",
		["arrow-spin-counter-clockwise-15"] = "arrow-spin-counter-clockwise-15",
		["arrow-spin-counter-clockwise-30"] = "arrow-spin-counter-clockwise-30",
		["arrow-thick-to-left"] = "arrow-thick-to-left",
		["arrow-thick-to-right"] = "arrow-thick-to-right",
		["arrow-up-from-landscape-rectangle"] = "arrow-up-from-landscape-rectangle",
		["arrow-up-right-from-square"] = "arrow-up-right-from-square",
		["arrow-wide-short-down"] = "arrow-wide-short-down",
		["arrow-wide-short-left"] = "arrow-wide-short-left",
		["arrow-wide-short-right"] = "arrow-wide-short-right",
		["arrow-wide-short-up"] = "arrow-wide-short-up",
		["arrows-small-directional"] = "arrows-small-directional",
		["audio-wave-dotted-line"] = "audio-wave-dotted-line",
		["backpack"] = "backpack",
		["beard"] = "beard",
		["bell"] = "bell",
		["bell-clock"] = "bell-clock",
		["bell-plus"] = "bell-plus",
		["bell-slash"] = "bell-slash",
		["belt"] = "belt",
		["binoculars"] = "binoculars",
		["book-closed"] = "book-closed",
		["bookmark"] = "bookmark",
		["bow-tie"] = "bow-tie",
		["building-store"] = "building-store",
		["bullet-flying"] = "bullet-flying",
		["butterfly-wings"] = "butterfly-wings",
		["calendar"] = "calendar",
		["calendar-plus"] = "calendar-plus",
		["calendar-star"] = "calendar-star",
		["camera-small"] = "camera-small",
		["caret-small-down"] = "caret-small-down",
		["caret-small-left"] = "caret-small-left",
		["caret-small-right"] = "caret-small-right",
		["caret-small-up"] = "caret-small-up",
		["chain-link"] = "chain-link",
		["chart-four-vertical-bars"] = "chart-four-vertical-bars",
		["chart-line"] = "chart-line",
		["chart-pie"] = "chart-pie",
		["chart-scatter-plot"] = "chart-scatter-plot",
		["chart-three-vertical-bars"] = "chart-three-vertical-bars",
		["check"] = "check",
		["check-large"] = "check-large",
		["check-small"] = "check-small",
		["chevron-large-down"] = "chevron-large-down",
		["chevron-large-down-to-line"] = "chevron-large-down-to-line",
		["chevron-large-left"] = "chevron-large-left",
		["chevron-large-left-to-line"] = "chevron-large-left-to-line",
		["chevron-large-right"] = "chevron-large-right",
		["chevron-large-right-to-line"] = "chevron-large-right-to-line",
		["chevron-large-up"] = "chevron-large-up",
		["chevron-large-up-to-line"] = "chevron-large-up-to-line",
		["chevron-small-down"] = "chevron-small-down",
		["chevron-small-down-to-line"] = "chevron-small-down-to-line",
		["chevron-small-left"] = "chevron-small-left",
		["chevron-small-left-to-line"] = "chevron-small-left-to-line",
		["chevron-small-right"] = "chevron-small-right",
		["chevron-small-right-to-line"] = "chevron-small-right-to-line",
		["chevron-small-up"] = "chevron-small-up",
		["chevron-small-up-to-line"] = "chevron-small-up-to-line",
		["circle-check"] = "circle-check",
		["circle-i"] = "circle-i",
		["circle-minus"] = "circle-minus",
		["circle-person"] = "circle-person",
		["circle-person-three-horizontal-bars-wrapping-right"] = "circle-person-three-horizontal-bars-wrapping-right",
		["circle-play"] = "circle-play",
		["circle-plus"] = "circle-plus",
		["circle-question"] = "circle-question",
		["circle-slash"] = "circle-slash",
		["circle-star"] = "circle-star",
		["circle-three-dots-horizontal"] = "circle-three-dots-horizontal",
		["circle-three-dots-vertical"] = "circle-three-dots-vertical",
		["circle-x"] = "circle-x",
		["clock"] = "clock",
		["clock-dashed"] = "clock-dashed",
		["clock-spin-reverse"] = "clock-spin-reverse",
		["clock-spin-reverse-dashed"] = "clock-spin-reverse-dashed",
		["clothes-hanger"] = "clothes-hanger",
		["cloud"] = "cloud",
		["cloud-arrow-down"] = "cloud-arrow-down",
		["code"] = "code",
		["compact-makeup-brush"] = "compact-makeup-brush",
		["compass"] = "compass",
		["controller-with-cog"] = "controller-with-cog",
		["crop"] = "crop",
		["crosshairs"] = "crosshairs",
		["crosshairs-slash"] = "crosshairs-slash",
		["cube-vertexes"] = "cube-vertexes",
		["curved-rectangle-megaphone"] = "curved-rectangle-megaphone",
		["diagonal-line-pattern"] = "diagonal-line-pattern",
		["diagonal-line-pattern-sticker"] = "diagonal-line-pattern-sticker",
		["diamond-simplified"] = "diamond-simplified",
		["discord"] = "discord",
		["disguise-nose-glasses"] = "disguise-nose-glasses",
		["document-circle-slash"] = "document-circle-slash",
		["document-list-heart"] = "document-list-heart",
		["door-open-arrow-to-bottom-right"] = "door-open-arrow-to-bottom-right",
		["dress"] = "dress",
		["dual-arrows-horizontal"] = "dual-arrows-horizontal",
		["dual-arrows-to-corners"] = "dual-arrows-to-corners",
		["dual-arrows-vertical"] = "dual-arrows-vertical",
		["envelope"] = "envelope",
		["eraser"] = "eraser",
		["eye"] = "eye",
		["eye-slash"] = "eye-slash",
		["eye-with-eyeliner"] = "eye-with-eyeliner",
		["eyebrows"] = "eyebrows",
		["eyelashes"] = "eyelashes",
		["face-winking"] = "face-winking",
		["facebook"] = "facebook",
		["file-box"] = "file-box",
		["fingerprint"] = "fingerprint",
		["flag"] = "flag",
		["flame"] = "flame",
		["folder"] = "folder",
		["fountain-pen-nib"] = "fountain-pen-nib",
		["four-bars-horizontal-center-aligned"] = "four-bars-horizontal-center-aligned",
		["four-bars-horizontal-chevron-left"] = "four-bars-horizontal-chevron-left",
		["four-bars-horizontal-chevron-right"] = "four-bars-horizontal-chevron-right",
		["four-bars-horizontal-justified-aligned"] = "four-bars-horizontal-justified-aligned",
		["four-bars-horizontal-left-aligned"] = "four-bars-horizontal-left-aligned",
		["four-bars-horizontal-right-aligned"] = "four-bars-horizontal-right-aligned",
		["frame-bubble-slash"] = "frame-bubble-slash",
		["frame-bubble-soundwave"] = "frame-bubble-soundwave",
		["frame-camera"] = "frame-camera",
		["frame-camera-center"] = "frame-camera-center",
		["frame-collapsed"] = "frame-collapsed",
		["frame-corners"] = "frame-corners",
		["frame-expanded"] = "frame-expanded",
		["frame-face"] = "frame-face",
		["frame-person-torso"] = "frame-person-torso",
		["frame-record"] = "frame-record",
		["frame-single-bar-horizontal"] = "frame-single-bar-horizontal",
		["frame-soundwave"] = "frame-soundwave",
		["frame-video-camera"] = "frame-video-camera",
		["gear"] = "gear",
		["generic-dpad"] = "generic-dpad",
		["gift-box"] = "gift-box",
		["gift-card"] = "gift-card",
		["glasses"] = "glasses",
		["globe-detailed"] = "globe-detailed",
		["globe-simplified"] = "globe-simplified",
		["globe-simplipfied-speech-bubble"] = "globe-simplipfied-speech-bubble",
		["grid"] = "grid",
		["guilded"] = "guilded",
		["hack-week"] = "hack-week",
		["hammer-code"] = "hammer-code",
		["hand-curved-arrow-left"] = "hand-curved-arrow-left",
		["hand-dual-arrows"] = "hand-dual-arrows",
		["hand-ellipse"] = "hand-ellipse",
		["hand-half-ellipse"] = "hand-half-ellipse",
		["hand-two-arrows-horizontal"] = "hand-two-arrows-horizontal",
		["hashtag"] = "hashtag",
		["hat-fedora"] = "hat-fedora",
		["hat-toque"] = "hat-toque",
		["head-blank"] = "head-blank",
		["head-blush"] = "head-blush",
		["head-female"] = "head-female",
		["head-freckles"] = "head-freckles",
		["head-lips"] = "head-lips",
		["head-male"] = "head-male",
		["headphones"] = "headphones",
		["headphones-arrow-up"] = "headphones-arrow-up",
		["headphones-arrow-up-lock"] = "headphones-arrow-up-lock",
		["headphones-slash"] = "headphones-slash",
		["headphones-x"] = "headphones-x",
		["headphones-x-lock"] = "headphones-x-lock",
		["heart"] = "heart",
		["house"] = "house",
		["image"] = "image",
		["image-stacked"] = "image-stacked",
		["instagram"] = "instagram",
		["jacket"] = "jacket",
		["key"] = "key",
		["key-alt"] = "key-alt",
		["key-apostrophe"] = "key-apostrophe",
		["key-arrow-down"] = "key-arrow-down",
		["key-arrow-right"] = "key-arrow-right",
		["key-arrow-up"] = "key-arrow-up",
		["key-asterisk"] = "key-asterisk",
		["key-backspace"] = "key-backspace",
		["key-caps-lock"] = "key-caps-lock",
		["key-caret"] = "key-caret",
		["key-comma"] = "key-comma",
		["key-command"] = "key-command",
		["key-control"] = "key-control",
		["key-grave-accent"] = "key-grave-accent",
		["key-period"] = "key-period",
		["key-return"] = "key-return",
		["key-shift"] = "key-shift",
		["key-space"] = "key-space",
		["key-tab"] = "key-tab",
		["language-characters"] = "language-characters",
		["leg-left"] = "leg-left",
		["leg-right"] = "leg-right",
		["lightning-bolt"] = "lightning-bolt",
		["linkedin"] = "linkedin",
		["lips"] = "lips",
		["lipstick"] = "lipstick",
		["list-bulleted"] = "list-bulleted",
		["location-pin"] = "location-pin",
		["location-pin-map"] = "location-pin-map",
		["lock-closed"] = "lock-closed",
		["lollipop"] = "lollipop",
		["magnifying-glass"] = "magnifying-glass",
		["magnifying-glass-minus"] = "magnifying-glass-minus",
		["magnifying-glass-plus"] = "magnifying-glass-plus",
		["mascara"] = "mascara",
		["megaphone"] = "megaphone",
		["memory-card"] = "memory-card",
		["messenger"] = "messenger",
		["microphone"] = "microphone",
		["microphone-slash"] = "microphone-slash",
		["microphone-text-box"] = "microphone-text-box",
		["microphone-triangle-exclamation"] = "microphone-triangle-exclamation",
		["minus"] = "minus",
		["minus-small"] = "minus-small",
		["mirror-standing"] = "mirror-standing",
		["moments"] = "moments",
		["moon"] = "moon",
		["mouse-button-left"] = "mouse-button-left",
		["mouse-button-right"] = "mouse-button-right",
		["mouse-scrollwheel"] = "mouse-scrollwheel",
		["music-note"] = "music-note",
		["nebula"] = "nebula",
		["necklace"] = "necklace",
		["nine-dots-grid"] = "nine-dots-grid",
		["ninja"] = "ninja",
		["nose"] = "nose",
		["page"] = "page",
		["paint-brush"] = "paint-brush",
		["paint-bucket"] = "paint-bucket",
		["pants"] = "pants",
		["pants-2d-text"] = "pants-2d-text",
		["paper-airplane"] = "paper-airplane",
		["parrot"] = "parrot",
		["pause-large"] = "pause-large",
		["pause-small"] = "pause-small",
		["pencil"] = "pencil",
		["pencil-square"] = "pencil-square",
		["person"] = "person",
		["person-arrow-from-bottom-right"] = "person-arrow-from-bottom-right",
		["person-check"] = "person-check",
		["person-circle-slash"] = "person-circle-slash",
		["person-climbing"] = "person-climbing",
		["person-clock"] = "person-clock",
		["person-falling"] = "person-falling",
		["person-graduate"] = "person-graduate",
		["person-jumping"] = "person-jumping",
		["person-magnifying-glass"] = "person-magnifying-glass",
		["person-photo-camera"] = "person-photo-camera",
		["person-play"] = "person-play",
		["person-play-clock"] = "person-play-clock",
		["person-plus"] = "person-plus",
		["person-racing"] = "person-racing",
		["person-running"] = "person-running",
		["person-standing"] = "person-standing",
		["person-standing-arrow-reverse"] = "person-standing-arrow-reverse",
		["person-standing-dual-arrows-vertical"] = "person-standing-dual-arrows-vertical",
		["person-standing-gear"] = "person-standing-gear",
		["person-swimming"] = "person-swimming",
		["person-teleport"] = "person-teleport",
		["person-trash-can"] = "person-trash-can",
		["person-walking"] = "person-walking",
		["person-with-smaller-person"] = "person-with-smaller-person",
		["phone"] = "phone",
		["phone-down"] = "phone-down",
		["phone-plus"] = "phone-plus",
		["phone-volume"] = "phone-volume",
		["phone-x"] = "phone-x",
		["photo-camera"] = "photo-camera",
		["photo-camera-face"] = "photo-camera-face",
		["photo-camera-slash"] = "photo-camera-slash",
		["picture-in-picture"] = "picture-in-picture",
		["pig"] = "pig",
		["pin"] = "pin",
		["pin-slash"] = "pin-slash",
		["play-large"] = "play-large",
		["play-small"] = "play-small",
		["plus-large"] = "plus-large",
		["plus-small"] = "plus-small",
		["premium"] = "premium",
		["ps-circle"] = "ps-circle",
		["ps-dpad-down"] = "ps-dpad-down",
		["ps-dpad-left"] = "ps-dpad-left",
		["ps-dpad-right"] = "ps-dpad-right",
		["ps-dpad-up"] = "ps-dpad-up",
		["ps-l1"] = "ps-l1",
		["ps-l2"] = "ps-l2",
		["ps-l3"] = "ps-l3",
		["ps-r1"] = "ps-r1",
		["ps-r2"] = "ps-r2",
		["ps-r3"] = "ps-r3",
		["ps-square"] = "ps-square",
		["ps-stick-left"] = "ps-stick-left",
		["ps-stick-right"] = "ps-stick-right",
		["ps-triagle"] = "ps-triagle",
		["ps-x"] = "ps-x",
		["ps4-options"] = "ps4-options",
		["ps4-share"] = "ps4-share",
		["ps4-touchpad"] = "ps4-touchpad",
		["ps5-options"] = "ps5-options",
		["ps5-share"] = "ps5-share",
		["ps5-touchpad"] = "ps5-touchpad",
		["pumpkin"] = "pumpkin",
		["purse"] = "purse",
		["rectangle-list"] = "rectangle-list",
		["rectangle-numbers-counting"] = "rectangle-numbers-counting",
		["rectangle-person-with-three-horizontal-lines"] = "rectangle-person-with-three-horizontal-lines",
		["robux"] = "robux",
		["rosette-seven-point"] = "rosette-seven-point",
		["rosette-ten-point"] = "rosette-ten-point",
		["seven-point-rosette"] = "seven-point-rosette",
		["shield-check"] = "shield-check",
		["shield-lock"] = "shield-lock",
		["shirt"] = "shirt",
		["shirt-2d-text"] = "shirt-2d-text",
		["shirt-pants"] = "shirt-pants",
		["shoe-left"] = "shoe-left",
		["shoe-right"] = "shoe-right",
		["shopping-basket"] = "shopping-basket",
		["shopping-basket-check"] = "shopping-basket-check",
		["shopping-cart"] = "shopping-cart",
		["shorts"] = "shorts",
		["sidebar"] = "sidebar",
		["signal-exclamation"] = "signal-exclamation",
		["six-dots-two-column-grid"] = "six-dots-two-column-grid",
		["skip-end-large"] = "skip-end-large",
		["skip-end-small"] = "skip-end-small",
		["skip-next-large"] = "skip-next-large",
		["skip-next-small"] = "skip-next-small",
		["skip-previous-large"] = "skip-previous-large",
		["skip-previous-small"] = "skip-previous-small",
		["skip-start-large"] = "skip-start-large",
		["skip-start-small"] = "skip-start-small",
		["smartphone-portrait"] = "smartphone-portrait",
		["speaker"] = "speaker",
		["speaker-slash"] = "speaker-slash",
		["speaker-triangle-exclamation"] = "speaker-triangle-exclamation",
		["speaker-x"] = "speaker-x",
		["speech-bubble-align-center"] = "speech-bubble-align-center",
		["speech-bubble-align-left"] = "speech-bubble-align-left",
		["speech-bubble-exclamation"] = "speech-bubble-exclamation",
		["speech-bubble-round"] = "speech-bubble-round",
		["square-bone"] = "square-bone",
		["square-books"] = "square-books",
		["square-check"] = "square-check",
		["square-code"] = "square-code",
		["square-dashed-person-standing"] = "square-dashed-person-standing",
		["square-dual-arrows-horizontal"] = "square-dual-arrows-horizontal",
		["square-dual-arrows-to-corner"] = "square-dual-arrows-to-corner",
		["square-face-sound"] = "square-face-sound",
		["square-face-waving-hand"] = "square-face-waving-hand",
		["square-face-winking"] = "square-face-winking",
		["square-minus"] = "square-minus",
		["square-person"] = "square-person",
		["squares-grid-plus"] = "squares-grid-plus",
		["squares-grid-qr"] = "squares-grid-qr",
		["stacked-squares-arrow-down-left"] = "stacked-squares-arrow-down-left",
		["stacked-squares-arrow-up-right"] = "stacked-squares-arrow-up-right",
		["stacked-squares-plus"] = "stacked-squares-plus",
		["star"] = "star",
		["stop-large"] = "stop-large",
		["stop-small"] = "stop-small",
		["studio"] = "studio",
		["sun"] = "sun",
		["sweater"] = "sweater",
		["sword"] = "sword",
		["tag-sparkle"] = "tag-sparkle",
		["teletype"] = "teletype",
		["tencent-qq"] = "tencent-qq",
		["text-b-bold"] = "text-b-bold",
		["text-box-microphone"] = "text-box-microphone",
		["text-h-subscript-1"] = "text-h-subscript-1",
		["text-h-subscript-2"] = "text-h-subscript-2",
		["text-h-subscript-3"] = "text-h-subscript-3",
		["text-i-italic"] = "text-i-italic",
		["text-s-strikethrough"] = "text-s-strikethrough",
		["text-u-underline"] = "text-u-underline",
		["text-uppercase-a-lowercase-a"] = "text-uppercase-a-lowercase-a",
		["text-x-subscript-2"] = "text-x-subscript-2",
		["text-x-superscript-2"] = "text-x-superscript-2",
		["three-bars-horizontal"] = "three-bars-horizontal",
		["three-bars-horizontal-chevron-left"] = "three-bars-horizontal-chevron-left",
		["three-bars-horizontal-narrowing"] = "three-bars-horizontal-narrowing",
		["three-bars-horizontal-triangles-vertical"] = "three-bars-horizontal-triangles-vertical",
		["three-bars-vertical-triangles-horizontal"] = "three-bars-vertical-triangles-horizontal",
		["three-chevrons-enlarging-down"] = "three-chevrons-enlarging-down",
		["three-chevrons-enlarging-up"] = "three-chevrons-enlarging-up",
		["three-dots-horizontal"] = "three-dots-horizontal",
		["three-dots-vertical"] = "three-dots-vertical",
		["three-horizontal-bars-wrapping-right"] = "three-horizontal-bars-wrapping-right",
		["three-people"] = "three-people",
		["three-ring-note"] = "three-ring-note",
		["three-sliders-horizontal"] = "three-sliders-horizontal",
		["three-stacked-squares-tilted"] = "three-stacked-squares-tilted",
		["thumb-down"] = "thumb-down",
		["thumb-up"] = "thumb-up",
		["tik-tok"] = "tik-tok",
		["tilt"] = "tilt",
		["torso"] = "torso",
		["trash-can"] = "trash-can",
		["triangle-exclamation"] = "triangle-exclamation",
		["trophy"] = "trophy",
		["tshirt"] = "tshirt",
		["tshirt-2d-text"] = "tshirt-2d-text",
		["tshirt-dual-arrows"] = "tshirt-dual-arrows",
		["twitch"] = "twitch",
		["twitter"] = "twitter",
		["two-arrows-down-and-up"] = "two-arrows-down-and-up",
		["two-arrows-from-center"] = "two-arrows-from-center",
		["two-arrows-left-right"] = "two-arrows-left-right",
		["two-arrows-loop-clockwise"] = "two-arrows-loop-clockwise",
		["two-arrows-loop-clockwise-1"] = "two-arrows-loop-clockwise-1",
		["two-arrows-loop-clockwise-infinity"] = "two-arrows-loop-clockwise-infinity",
		["two-arrows-spin-clockwise"] = "two-arrows-spin-clockwise",
		["two-arrows-spin-clockwise-plus"] = "two-arrows-spin-clockwise-plus",
		["two-arrows-switch-right"] = "two-arrows-switch-right",
		["two-arrows-to-center"] = "two-arrows-to-center",
		["two-folders"] = "two-folders",
		["two-location-pins-connecting-arrow"] = "two-location-pins-connecting-arrow",
		["two-makeup-brushes"] = "two-makeup-brushes",
		["two-people"] = "two-people",
		["two-people-speech-bubble"] = "two-people-speech-bubble",
		["two-stacked-squares"] = "two-stacked-squares",
		["two-switches-horizontal"] = "two-switches-horizontal",
		["verified-backplate"] = "verified-backplate",
		["verified-check"] = "verified-check",
		["verified-mono"] = "verified-mono",
		["video-camera"] = "video-camera",
		["video-camera-arrow-to-bottom-left"] = "video-camera-arrow-to-bottom-left",
		["video-camera-arrow-to-top-right"] = "video-camera-arrow-to-top-right",
		["video-camera-slash"] = "video-camera-slash",
		["video-camera-triangle-exclamation"] = "video-camera-triangle-exclamation",
		["video-camera-x"] = "video-camera-x",
		["wallet"] = "wallet",
		["we-chat"] = "we-chat",
		["whatsapp"] = "whatsapp",
		["x"] = "x",
		["x-small"] = "x-small",
		["xbox-a"] = "xbox-a",
		["xbox-a-pressed"] = "xbox-a-pressed",
		["xbox-a-unpressed"] = "xbox-a-unpressed",
		["xbox-b"] = "xbox-b",
		["xbox-dpad"] = "xbox-dpad",
		["xbox-dpad-down"] = "xbox-dpad-down",
		["xbox-dpad-left"] = "xbox-dpad-left",
		["xbox-dpad-right"] = "xbox-dpad-right",
		["xbox-dpad-up"] = "xbox-dpad-up",
		["xbox-lb"] = "xbox-lb",
		["xbox-lt"] = "xbox-lt",
		["xbox-menu"] = "xbox-menu",
		["xbox-rb"] = "xbox-rb",
		["xbox-rt"] = "xbox-rt",
		["xbox-stick-left"] = "xbox-stick-left",
		["xbox-stick-left-directional"] = "xbox-stick-left-directional",
		["xbox-stick-left-horizontal"] = "xbox-stick-left-horizontal",
		["xbox-stick-left-vertical"] = "xbox-stick-left-vertical",
		["xbox-stick-right"] = "xbox-stick-right",
		["xbox-stick-right-directional"] = "xbox-stick-right-directional",
		["xbox-stick-right-horizontal"] = "xbox-stick-right-horizontal",
		["xbox-stick-right-vertical"] = "xbox-stick-right-vertical",
		["xbox-view"] = "xbox-view",
		["xbox-x"] = "xbox-x",
		["xbox-y"] = "xbox-y",
		["xr-headset"] = "xr-headset",
		["youtube"] = "youtube"
	};
end);

NeverLose.IsMouseOverFrame = LPH_NO_VIRTUALIZE(function(self , Frame)
	if not Frame then
		return;
	end;

	if NeverLose.Global3DRenderMode then
		if Frame.GuiState == Enum.GuiState.Hover or Frame.GuiState == Enum.GuiState.Press then
			return true;
		end;

		return false;
	end;

	local AbsPos: Vector2, AbsSize: Vector2 = Frame.AbsolutePosition, Frame.AbsoluteSize;

	if Mouse.X >= AbsPos.X and Mouse.X <= AbsPos.X + AbsSize.X and Mouse.Y >= AbsPos.Y and Mouse.Y <= AbsPos.Y + AbsSize.Y then
		return true;
	end;
end);

NeverLose.CreateSignal = LPH_NO_VIRTUALIZE(function(self , DefaultValue)
	local __cache = Instance.new('BindableEvent');
	local bind = {
		Value = DefaultValue,
		__event = __cache
	};

	function bind:GetValue()
		return bind.Value;
	end;

	function bind:SetValue(f)
		bind.Value = f;

		return __cache:Fire(f);
	end;

	function bind:Connect(f)
		local signal = __cache.Event:Connect(f);

		NeverLose:AddSignal(signal);

		return signal;
	end;

	return bind;
end);

NeverLose.SetIconMode = LPH_NO_VIRTUALIZE(function(self , Label: TextLabel , Icon: string)
	local useBold = string.lower(string.sub(Icon , -5)) == '-bold';

	if useBold then
		Label.Text = Icon:sub(1,-6);
		Label.FontFace = NeverLose.BuiltInBold;
	else
		Label.Text = Icon;
		Label.FontFace = NeverLose.BuiltInRegular;
	end;
end);

function NeverLose:GetIconFont(icon: string)
	local useBold = string.lower(string.sub(icon , -5)) == '-bold';

	if useBold then
		return NeverLose.BuiltInBold;
	end;

	return NeverLose.BuiltInRegular;
end;

function NeverLose:MoreThanHalfY(Value: number)
	return (NeverLose.ScreenGui.AbsoluteSize.Y / 2) < Value
end;

NeverLose.IsStudio = RunService:IsStudio();
NeverLose.IsMobile = UserInputService.TouchEnabled;

NeverLose.CreateInput = LPH_NO_VIRTUALIZE(function(self , Frame , Callback)
	local Button = Instance.new('ImageButton',Frame);

	Button.ZIndex = Frame.ZIndex + 10;
	Button.Size = UDim2.fromScale(1,1);
	Button.BackgroundTransparency = 1;
	Button.ImageTransparency = 1;
	Button.Image = "rbxasset://textuers/translateIcon.png";

	if Callback then
		local bth_signal = Button.MouseButton1Click:Connect(Callback);

		return Button , bth_signal;
	end;

	return Button;
end);

NeverLose.PlayAnimate = LPH_NO_VIRTUALIZE(function(Self , Info , Property)
	local Tween = TweenService:Create(Self , Info or TweenInfo.new(0.25) , Property);

	Tween:Play();

	return Tween;
end);

NeverLose.Drag = LPH_NO_VIRTUALIZE(function(InputFrame: Frame, MoveFrame: Frame, Speed : number)
	local dragToggle: boolean = false;
	local dragStart: Vector3 = nil;
	local startPos: UDim2 = nil;
	local Tween = TweenInfo.new(Speed);

	local updateInput = function(input)
		local delta = input.Position - dragStart;
		local position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
			startPos.Y.Scale, startPos.Y.Offset + delta.Y);

		if NeverLose.Global3DRenderMode then
			NeverLose.PlayAnimate(MoveFrame,Tween,{
				Position = UDim2.fromScale(0.5,0.5)
			});
		else
			NeverLose.PlayAnimate(MoveFrame,Tween,{
				Position = position
			});
		end;
	end;

	NeverLose:AddSignal(InputFrame.InputBegan:Connect(function(input)
		if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then 
			dragToggle = true;
			dragStart = input.Position;
			startPos = MoveFrame.Position;

			local input_end;
			input_end = input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragToggle = false;

					input_end:Disconnect();
				end
			end)
		end
	end));

	NeverLose:AddSignal(UserInputService.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			if dragToggle then
				updateInput(input)
			end
		end
	end));
end);

NeverLose.Rounding = LPH_NO_VIRTUALIZE(function(num, numDecimalPlaces)
	local mult = 10 ^ (numDecimalPlaces or 0);
	return math.floor(num * mult + 0.5) / mult;
end);

NeverLose.ProcessParams = LPH_NO_VIRTUALIZE(function(self , Params , Fixed)
	Params = Params or {};

	local k = Params or {};

	for i,v in next , Fixed do
		k[i] = Params[i] or v;
	end;

	table.clear(Fixed);

	return k;
end);

NeverLose.EnabledBlur = true;
NeverLose.BlurModuleParent = workspace.CurrentCamera;

NeverLose.GetCalculatePosition = LPH_NO_VIRTUALIZE(function(planePos, planeNormal, rayOrigin, rayDirection)
	local n = planeNormal;
	local d = rayDirection;
	local v = rayOrigin - planePos;

	local num = (n.x * v.x) + (n.y * v.y) + (n.z * v.z);
	local den = (n.x * d.x) + (n.y * d.y) + (n.z * d.z);
	local a = -num / den;

	return rayOrigin + (a * rayDirection);
end);

NeverLose.CreateBlurModule = LPH_NO_VIRTUALIZE(function(self , Frame , Signal)
	if not NeverLose.EnabledBlur then
		return NeverLose:AddSignal(Instance.new('BindableEvent').Event:Connect(function() return "nl"; end));	
	end;

	local Part = Instance.new('Part',NeverLose.BlurModuleParent);
	local DepthOfField = Instance.new('DepthOfFieldEffect',cloneref(game:GetService('Lighting')));
	local BlockMesh = Instance.new("BlockMesh");

	BlockMesh.Parent = Part;

	Part.Material = Enum.Material.Glass;
	Part.Transparency = 1;
	Part.Reflectance = 1;
	Part.CastShadow = false;
	Part.Anchored = true;
	Part.CanCollide = false;
	Part.CanQuery = false;
	Part.CollisionGroup = NeverLose.RandomString();
	Part.Size = Vector3.new(1, 1, 1) * 0.01;
	Part.Color = Color3.fromRGB(0,0,0);

	DepthOfField.Enabled = true;
	DepthOfField.FarIntensity = 0;
	DepthOfField.FocusDistance = 0;
	DepthOfField.InFocusRadius = 1000;
	DepthOfField.NearIntensity = 1;
	DepthOfField.Name = NeverLose.RandomString();

	Part.Name = NeverLose.RandomString();

	local disconnect;

	local UpdateFunction = function()
		local IsWindowActive = Signal:GetValue();

		if IsWindowActive and not NeverLose.Global3DRenderMode then

			NeverLose.PlayAnimate(DepthOfField,TweenInfo.new(0.1),{
				NearIntensity = 1
			})

			NeverLose.PlayAnimate(Part,TweenInfo.new(0.1),{
				Transparency = 0.97,
				Size = Vector3.new(1, 1, 1) * 0.01;
			})

			Part.Parent = NeverLose.BlurModuleParent;
		else
			NeverLose.PlayAnimate(DepthOfField,TweenInfo.new(0.1),{
				NearIntensity = 0
			})

			NeverLose.PlayAnimate(Part,TweenInfo.new(0.1),{
				Size = Vector3.zero,
				Transparency = 1.5,
			})

			Part.Parent = nil;

			return false;
		end;

		if IsWindowActive then
			local corner0 = Frame.AbsolutePosition;
			local corner1 = corner0 + Frame.AbsoluteSize;

			local ray0 = CurrentCamera.ScreenPointToRay(CurrentCamera,corner0.X, corner0.Y, 1);
			local ray1 = CurrentCamera.ScreenPointToRay(CurrentCamera,corner1.X, corner1.Y, 1);

			local planeOrigin = CurrentCamera.CFrame.Position + CurrentCamera.CFrame.LookVector * (0.05 - CurrentCamera.NearPlaneZ);

			local planeNormal = CurrentCamera.CFrame.LookVector;

			local pos0 = NeverLose.GetCalculatePosition(planeOrigin, planeNormal, ray0.Origin, ray0.Direction);
			local pos1 = NeverLose.GetCalculatePosition(planeOrigin, planeNormal, ray1.Origin, ray1.Direction);

			pos0 = CurrentCamera.CFrame:PointToObjectSpace(pos0);
			pos1 = CurrentCamera.CFrame:PointToObjectSpace(pos1);

			local size   = pos1 - pos0;
			local center = (pos0 + pos1) / 2;

			BlockMesh.Offset = center
			BlockMesh.Scale  = size / 0.0101;
			Part.CFrame = CurrentCamera.CFrame;
		end;
	end;

	local rbxsignal = NeverLose:AddSignal(CurrentCamera:GetPropertyChangedSignal('CFrame'):Connect(UpdateFunction))
	local loopThread = NeverLose:AddSignal(UserInputService.InputChanged:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
			pcall(UpdateFunction);
		end;
	end));

	local THREAD = task.spawn(function()
		while true do task.wait(0.1)
			pcall(UpdateFunction);
		end;
	end);

	disconnect = function()
		rbxsignal:Disconnect();
		loopThread:Disconnect();
		task.cancel(THREAD);
		Part:Destroy();
		DepthOfField:Destroy();
	end;

	Frame.Destroying:Connect(disconnect);

	return rbxsignal;
end);

local EmptyFunction = function() end;

function NeverLose:RollingEffect(parent)
	local UIGradient = Instance.new("UIGradient")

	UIGradient.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.4), NumberSequenceKeypoint.new(1.00, 0.00)}
	UIGradient.Parent = parent

	return UIGradient;
end;

function NeverLose:CreateShadow(parent , RollingEffect)
	local Shadow = {};

	local UIShadowSafe85 = Instance.new("UIStroke")
	local UIShadowSafe65 = Instance.new("UIStroke")
	local UIShadowSafe50 = Instance.new("UIStroke")
	local UIShadowSafe45 = Instance.new("UIStroke")

	UIShadowSafe85.Thickness = 6.000
	UIShadowSafe85.Transparency = 1
	UIShadowSafe85.Parent = parent

	UIShadowSafe65.Thickness = 5.000
	UIShadowSafe65.Transparency = 1
	UIShadowSafe65.Parent = parent

	UIShadowSafe50.Thickness = 4.000
	UIShadowSafe50.Transparency = 1
	UIShadowSafe50.Parent = parent

	UIShadowSafe45.Thickness = 3.000
	UIShadowSafe45.Transparency = 1
	UIShadowSafe45.Parent = parent

	local RollingEffectThread;
	local r1,r2,r3,r4;

	if RollingEffect then
		r1 = NeverLose:RollingEffect(UIShadowSafe85);
		r2 = NeverLose:RollingEffect(UIShadowSafe65);
		r3 = NeverLose:RollingEffect(UIShadowSafe50);
		r4 = NeverLose:RollingEffect(UIShadowSafe45);
	end;

	Shadow.Render = LPH_NO_VIRTUALIZE(function(self , value)
		if RollingEffectThread then
			task.cancel(RollingEffectThread);
			RollingEffectThread = nil;
		end;

		if value then
			NeverLose.PlayAnimate(UIShadowSafe85 , SlowyTween , {
				Transparency = 0.900
			})

			NeverLose.PlayAnimate(UIShadowSafe65 , SlowyTween , {
				Transparency = 0.900
			})

			NeverLose.PlayAnimate(UIShadowSafe50 , SlowyTween , {
				Transparency = 0.900
			})

			NeverLose.PlayAnimate(UIShadowSafe45 , SlowyTween , {
				Transparency = 0.900
			})

			if RollingEffect then
				RollingEffectThread = task.spawn(function()
					local level = 20;
					while true do task.wait(0.025)
						NeverLose.PlayAnimate(r1 , SlowyTween , {
							Rotation = r1.Rotation + level
						});

						NeverLose.PlayAnimate(r2 , SlowyTween , {
							Rotation = r2.Rotation + level
						});

						NeverLose.PlayAnimate(r3 , SlowyTween , {
							Rotation = r3.Rotation + level
						});

						NeverLose.PlayAnimate(r4 , SlowyTween , {
							Rotation = r4.Rotation + level
						});
					end;
				end);
			end;
		else
			NeverLose.PlayAnimate(UIShadowSafe85 , SlowyTween , {
				Transparency = 1
			})

			NeverLose.PlayAnimate(UIShadowSafe65 , SlowyTween , {
				Transparency = 1
			})

			NeverLose.PlayAnimate(UIShadowSafe50 , SlowyTween , {
				Transparency = 1
			})

			NeverLose.PlayAnimate(UIShadowSafe45 , SlowyTween , {
				Transparency = 1
			})
		end;
	end);

	return Shadow;
end;

function NeverLose:CreateOptionWindow(Frame: Frame , Zindex)
	Zindex = Zindex or 9;

	local Window = {
		Signal = NeverLose:CreateSignal(false),
	};

	local OptionHandler = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local UIListLayout = Instance.new("UIListLayout")
	local UIStroke = Instance.new("UIStroke")
	local shadow = NeverLose:CreateShadow(OptionHandler);

	OptionHandler.Name = NeverLose.RandomString();
	OptionHandler.Parent = NeverLose.ScreenGui
	OptionHandler.AnchorPoint = Vector2.new(0, 0)
	OptionHandler.BackgroundColor3 = Color3.fromRGB(20, 22, 27)
	OptionHandler.BackgroundTransparency = 0.035
	OptionHandler.BorderColor3 = Color3.fromRGB(0, 0, 0)
	OptionHandler.BorderSizePixel = 0
	OptionHandler.ClipsDescendants = true
	OptionHandler.Position = UDim2.new(255,255,255,255)
	OptionHandler.Size = UDim2.new(0, 220, 0, 75)
	OptionHandler.ZIndex = Zindex + 9

	UICorner.CornerRadius = UDim.new(0, 10)
	UICorner.Parent = OptionHandler

	UIListLayout.Parent = OptionHandler
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

	UIStroke.Transparency = 0.650
	UIStroke.Color = Color3.fromRGB(45, 48, 58)
	UIStroke.Parent = OptionHandler

	NeverLose:AddSignal(UIListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(LPH_NO_VIRTUALIZE(function()
		NeverLose.PlayAnimate(OptionHandler , SlowyTween , {
			Size = UDim2.new(0, 220, 0, UIListLayout.AbsoluteContentSize.Y - 1)
		})
	end)));

	NeverLose:AddSignal(OptionHandler:GetPropertyChangedSignal('BackgroundTransparency'):Connect(LPH_NO_VIRTUALIZE(function()
		if OptionHandler.BackgroundTransparency > 0.9 then
			OptionHandler.Visible = false;
			UIListLayout.Parent = nil;
			OptionHandler.Parent = nil;
		else
			OptionHandler.Visible = true;
			UIListLayout.Parent = OptionHandler

			if NeverLose.Global3DRenderMode then
				OptionHandler.Parent = NeverLose.GlobalSurfaceGui;
			else
				OptionHandler.Parent = NeverLose.ScreenGui;
			end;
		end
	end)));

	local FollowingThread;
	local SetPosition = LPH_NO_VIRTUALIZE(function()
		if NeverLose:MoreThanHalfY(Frame.AbsolutePosition.Y + 65) then
			OptionHandler.AnchorPoint = Vector2.new(0,1)
		else
			OptionHandler.AnchorPoint = Vector2.new(0,0)
		end;

		OptionHandler.Position = UDim2.fromOffset(Frame.AbsolutePosition.X + 18 , Frame.AbsolutePosition.Y + 65);
	end);

	Window.SetRender = LPH_NO_VIRTUALIZE(function(value)
		if FollowingThread then
			task.cancel(FollowingThread);
			FollowingThread = nil;
		end;

		if value then
			SetPosition();

			NeverLose.PlayAnimate(OptionHandler , SlowyTween , {
				BackgroundTransparency = 0.035
			})

			NeverLose.PlayAnimate(UIStroke , SlowyTween , {
				Transparency = 0.650
			})

			shadow:Render(true);

			if NeverLose.Global3DRenderMode then
				OptionHandler.Parent = NeverLose.GlobalSurfaceGui;
			else
				OptionHandler.Parent = NeverLose.ScreenGui;
			end;

			FollowingThread = task.spawn(function()
				while true do task.wait()
					SetPosition();
				end
			end)
		else
			NeverLose.PlayAnimate(OptionHandler , SlowyTween , {
				BackgroundTransparency = 1
			})

			NeverLose.PlayAnimate(UIStroke , SlowyTween , {
				Transparency = 1
			})

			shadow:Render(false);
		end;
	end);

	Window.SetRender(false);
	Window.Signal:Connect(Window.SetRender)

	local Payback = NeverLose:RegisiterItem(OptionHandler , Window.Signal);

	Payback.Winbdow = Window;
	Payback.Root = OptionHandler;
	Payback.Signal = Window.Signal;

	return Payback;
end;

function NeverLose:CreateColorPicker(HandleFrame: Frame)
	local ZIndex = HandleFrame.ZIndex;

	local ColorPickerLib = {};

	local ColorPickerHandler = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local UIStroke = Instance.new("UIStroke")
	local SaViMap = Instance.new("ImageLabel")
	local UICorner_2 = Instance.new("UICorner")
	local ColorZoneSelection = Instance.new("Frame")
	local UICorner_3 = Instance.new("UICorner")
	local UIStroke_2 = Instance.new("UIStroke")
	local ColorMap = Instance.new("Frame")
	local UIGradient = Instance.new("UIGradient")
	local UICorner_4 = Instance.new("UICorner")
	local ColorMapSelection = Instance.new("Frame")
	local UIStroke_3 = Instance.new("UIStroke")
	local UICorner_5 = Instance.new("UICorner")
	local RGBLabel = Instance.new("TextLabel")
	local UICorner_6 = Instance.new("UICorner")
	local Shadow = NeverLose:CreateShadow(ColorPickerHandler);

	ColorPickerHandler.Name = NeverLose.RandomString();
	ColorPickerHandler.Parent = NeverLose.ScreenGui
	ColorPickerHandler.AnchorPoint = Vector2.new(0, 0)
	ColorPickerHandler.BackgroundColor3 = Color3.fromRGB(20, 22, 27)
	ColorPickerHandler.BackgroundTransparency = 0.035
	ColorPickerHandler.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ColorPickerHandler.BorderSizePixel = 0
	ColorPickerHandler.ClipsDescendants = true
	ColorPickerHandler.Position = UDim2.new(255, 0, 255, 20)
	ColorPickerHandler.Size = UDim2.new(0, 200, 0, 240)
	ColorPickerHandler.ZIndex = ZIndex + 125

	NeverLose:AddSignal(ColorPickerHandler:GetPropertyChangedSignal('BackgroundTransparency'):Connect(LPH_NO_VIRTUALIZE(function()
		if ColorPickerHandler.BackgroundTransparency > 0.9 then
			ColorPickerHandler.Visible = false;
			ColorPickerHandler.Parent = nil
		else
			ColorPickerHandler.Visible = true;

			if NeverLose.Global3DRenderMode then
				ColorPickerHandler.Parent = NeverLose.GlobalSurfaceGui;
			else
				ColorPickerHandler.Parent = NeverLose.ScreenGui;
			end;
		end;
	end)));

	UICorner.CornerRadius = UDim.new(0, 10)
	UICorner.Parent = ColorPickerHandler

	UIStroke.Transparency = 0.650
	UIStroke.Color = Color3.fromRGB(45, 48, 58)
	UIStroke.Parent = ColorPickerHandler

	SaViMap.Name = NeverLose.RandomString();
	SaViMap.Parent = ColorPickerHandler
	SaViMap.AnchorPoint = Vector2.new(0.5, 0)
	SaViMap.BackgroundColor3 = Color3.fromRGB(255, 0, 4)
	SaViMap.BorderColor3 = Color3.fromRGB(0, 0, 0)
	SaViMap.BorderSizePixel = 0
	SaViMap.Position = UDim2.new(0.5, 0, 0, 5)
	SaViMap.Size = UDim2.new(0, 185, 0, 185)
	SaViMap.ZIndex = ZIndex + 126
	SaViMap.Image = NeverLose.ImageColorMapping -- UNSAFE IMAGE

	UICorner_2.CornerRadius = UDim.new(0, 5)
	UICorner_2.Parent = SaViMap

	ColorZoneSelection.Name = NeverLose.RandomString();
	ColorZoneSelection.Parent = SaViMap
	ColorZoneSelection.AnchorPoint = Vector2.new(0.5, 0.5)
	ColorZoneSelection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ColorZoneSelection.BackgroundTransparency = 1.000
	ColorZoneSelection.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ColorZoneSelection.BorderSizePixel = 0
	ColorZoneSelection.Position = UDim2.new(0.5, 0, 0.5, 0)
	ColorZoneSelection.Size = UDim2.new(0, 10, 0, 10)
	ColorZoneSelection.ZIndex = ZIndex + 127

	UICorner_3.CornerRadius = UDim.new(1, 0)
	UICorner_3.Parent = ColorZoneSelection

	UIStroke_2.Color = Color3.fromRGB(255, 255, 255)
	UIStroke_2.Parent = ColorZoneSelection

	ColorMap.Name = NeverLose.RandomString();
	ColorMap.Parent = ColorPickerHandler
	ColorMap.AnchorPoint = Vector2.new(0.5, 0)
	ColorMap.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ColorMap.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ColorMap.BorderSizePixel = 0
	ColorMap.Position = UDim2.new(0.5, 0, 0, 200)
	ColorMap.Size = UDim2.new(1, -15, 0, 10)
	ColorMap.ZIndex = ZIndex + 126

	UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.10, Color3.fromRGB(255, 153, 0)), ColorSequenceKeypoint.new(0.20, Color3.fromRGB(203, 255, 0)), ColorSequenceKeypoint.new(0.30, Color3.fromRGB(50, 255, 0)), ColorSequenceKeypoint.new(0.40, Color3.fromRGB(0, 255, 102)), ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 255, 255)), ColorSequenceKeypoint.new(0.60, Color3.fromRGB(0, 101, 255)), ColorSequenceKeypoint.new(0.70, Color3.fromRGB(50, 0, 255)), ColorSequenceKeypoint.new(0.80, Color3.fromRGB(204, 0, 255)), ColorSequenceKeypoint.new(0.90, Color3.fromRGB(255, 0, 153)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 0))}
	UIGradient.Parent = ColorMap

	UICorner_4.CornerRadius = UDim.new(0, 3)
	UICorner_4.Parent = ColorMap

	ColorMapSelection.Name = NeverLose.RandomString();
	ColorMapSelection.Parent = ColorMap
	ColorMapSelection.AnchorPoint = Vector2.new(0.5, 0.5)
	ColorMapSelection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ColorMapSelection.BackgroundTransparency = 1.000
	ColorMapSelection.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ColorMapSelection.BorderSizePixel = 0
	ColorMapSelection.Position = UDim2.new(0, 0, 0.5, 0)
	ColorMapSelection.Size = UDim2.new(0, 5, 1, 0)
	ColorMapSelection.ZIndex = ZIndex + 126

	UIStroke_3.Thickness = 2.000
	UIStroke_3.Color = Color3.fromRGB(255, 255, 255)
	UIStroke_3.Parent = ColorMapSelection

	UICorner_5.CornerRadius = UDim.new(0, 3)
	UICorner_5.Parent = ColorMapSelection

	RGBLabel.Name = NeverLose.RandomString();
	RGBLabel.Parent = ColorPickerHandler
	RGBLabel.BackgroundColor3 = Color3.fromRGB(26, 28, 36)
	RGBLabel.BackgroundTransparency = 0.750
	RGBLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	RGBLabel.BorderSizePixel = 0
	RGBLabel.Position = UDim2.new(0, 10, 0, 217)
	RGBLabel.Size = UDim2.new(1, -20, 0, 15)
	RGBLabel.ZIndex = ZIndex + 127
	RGBLabel.Font = Enum.Font.GothamBold
	RGBLabel.Text = "#FFFFFF"
	RGBLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	RGBLabel.TextSize = 12.000
	RGBLabel.TextTransparency = 0.400
	RGBLabel.TextXAlignment = Enum.TextXAlignment.Left

	UICorner_6.CornerRadius = UDim.new(0, 4)
	UICorner_6.Parent = RGBLabel

	ColorPickerLib.SetRender = LPH_NO_VIRTUALIZE(function(value)
		if value then
			ColorPickerHandler.Position = UDim2.new(0,HandleFrame.AbsolutePosition.X + 20 , 0 ,HandleFrame.AbsolutePosition.Y + 75);

			NeverLose.PlayAnimate(ColorPickerHandler,SlowyTween , {
				BackgroundTransparency = 0.035
			})

			NeverLose.PlayAnimate(UIStroke,SlowyTween , {
				Transparency = 0.650
			})

			NeverLose.PlayAnimate(SaViMap,SlowyTween , {
				BackgroundTransparency = 0,
				ImageTransparency = 0
			})

			NeverLose.PlayAnimate(UIStroke_2,SlowyTween , {
				Transparency = 0
			})

			NeverLose.PlayAnimate(ColorMap,SlowyTween , {
				BackgroundTransparency = 0
			})

			NeverLose.PlayAnimate(UIStroke_3,SlowyTween , {
				Transparency = 0
			})

			NeverLose.PlayAnimate(RGBLabel,SlowyTween , {
				BackgroundTransparency = 0.750,
				TextTransparency = 0.400
			})

			Shadow:Render(true)
		else
			NeverLose.PlayAnimate(ColorPickerHandler,SlowyTween , {
				BackgroundTransparency = 1
			})

			NeverLose.PlayAnimate(UIStroke,SlowyTween , {
				Transparency = 1
			})

			NeverLose.PlayAnimate(SaViMap,SlowyTween , {
				BackgroundTransparency = 1,
				ImageTransparency = 1
			})

			NeverLose.PlayAnimate(UIStroke_2,SlowyTween , {
				Transparency = 1
			})

			NeverLose.PlayAnimate(ColorMap,SlowyTween , {
				BackgroundTransparency = 1
			})

			NeverLose.PlayAnimate(UIStroke_3,SlowyTween , {
				Transparency = 1
			})

			NeverLose.PlayAnimate(RGBLabel,SlowyTween , {
				BackgroundTransparency = 1,
				TextTransparency = 1
			})

			Shadow:Render(false)
		end;
	end);

	ColorPickerLib.SetRender(false);
	ColorPickerLib.Root = ColorPickerHandler;
	ColorPickerLib.H = 1;
	ColorPickerLib.S = 1;
	ColorPickerLib.V = 1;
	ColorPickerLib.Callback = EmptyFunction;

	function ColorPickerLib:Update()
		local RealColor = Color3.fromHSV(ColorPickerLib.H , ColorPickerLib.S , ColorPickerLib.V);

		NeverLose.PlayAnimate(ColorZoneSelection,ManualTween,{
			Position = UDim2.fromScale(ColorPickerLib.S , 1 - ColorPickerLib.V)
		});

		NeverLose.PlayAnimate(SaViMap,ManualTween,{
			BackgroundColor3 = Color3.fromHSV(ColorPickerLib.H , 1 , 1)
		});

		NeverLose.PlayAnimate(ColorMapSelection,ManualTween,{
			Position = UDim2.fromScale(ColorPickerLib.H,0.5)
		});

		RGBLabel.Text = "#"..RealColor:ToHex();

		ColorPickerLib.Callback(RealColor);
	end;

	function ColorPickerLib:SetValue(Color)
		if typeof(Color) == 'string' then
			Color = Color3.fromHex(Color);
		end;

		local H , S , V = Color:ToHSV();

		ColorPickerLib.H = H;
		ColorPickerLib.S = S;
		ColorPickerLib.V = V;

		ColorPickerLib:Update();
	end;

	ColorPickerLib.IsHold = false;

	NeverLose:AddSignal(ColorPickerHandler.InputBegan:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
			ColorPickerLib.IsHold = true;
		end;
	end));

	NeverLose:AddSignal(ColorPickerHandler.InputEnded:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
			ColorPickerLib.IsHold = false;
		end;
	end));

	NeverLose:AddSignal(ColorMap.InputBegan:Connect(LPH_NO_VIRTUALIZE(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
			ColorPickerLib.IsHold = true;

			while (UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) or ColorPickerLib.IsHold) do task.wait()
				local ColorY = ColorMap.AbsolutePosition.X
				local ColorYM = ColorY + ColorMap.AbsoluteSize.X;
				local Value = math.clamp(Mouse.X, ColorY, ColorYM)
				local Code = ((Value - ColorY) / (ColorYM - ColorY));

				ColorPickerLib.H = Code;
				ColorPickerLib:Update();
			end;
		end;
	end)));

	NeverLose:AddSignal(SaViMap.InputBegan:Connect(LPH_NO_VIRTUALIZE(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
			ColorPickerLib.IsHold = true;

			while (UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) or ColorPickerLib.IsHold) do task.wait();
				local PosX = SaViMap.AbsolutePosition.X;
				local ScaleX = PosX + SaViMap.AbsoluteSize.X;
				local Value, PosY = math.clamp(Mouse.X, PosX, ScaleX), SaViMap.AbsolutePosition.Y;
				local ScaleY = PosY + SaViMap.AbsoluteSize.Y;
				local Vals = math.clamp(Mouse.Y, PosY, ScaleY);

				ColorPickerLib.S = (Value - PosX) / (ScaleX - PosX);
				ColorPickerLib.V = (1 - ((Vals - PosY) / (ScaleY - PosY)));
				ColorPickerLib:Update();
			end
		end
	end)));

	return ColorPickerLib;
end;

NeverLose.KeyEnum = {
	One = '1',
	Two = '2',
	Three = '3',
	Four = '4',
	Five = '5',
	Six = '6',
	Seven = '7',
	Eight = '8',
	Nine = '9',
	Zero = '0',
	['Minus'] = "-",
	['Plus'] = "+",
	BackSlash = "\\",
	Slash = "/",
	Period = '.',
	Semicolon = ';',
	Colon = ":",
	LeftControl = "LCtrl",
	RightControl = "RCtrl",
	LeftShift = "LShift",
	RightShift = "RShift",
	Return = "Enter",
	LeftBracket = "[",
	RightBracket = "]",
	Quote = "'",
	Comma = ",",
	Equals = "=",
	LeftSuper = "Super",
	RightSuper = "Super",
	LeftAlt = "LAlt",
	RightAlt = "RAlt",
	Escape = "Esc",
};

NeverLose.EnumReverse = {};

for i,v in next , NeverLose.KeyEnum do
	NeverLose.EnumReverse[v] = i;
end;

function NeverLose:KeyCodeToStr(K: Enum.KeyCode)
	if typeof(K) == 'string' then
		if NeverLose.KeyEnum[K] then
			return NeverLose.KeyEnum[K];
		end;

		return K;
	end;

	return (NeverLose.KeyEnum[K.Name] or K.Name);
end;

function NeverLose:StrToKeyCode(str: string)
	if NeverLose.EnumReverse[str] then
		return Enum.KeyCode[NeverLose.EnumReverse[str]];
	end;

	return Enum.KeyCode[str];
end;

function NeverLose:RegisiterHandler(Handler: Frame , Signal)
	local handle = {};
	local ZINdex = Handler.ZIndex;

	function handle:AddToggle(Config)
		Config = NeverLose:ProcessParams(Config , {
			Default = false,
			Flag = nil,
			Callback = EmptyFunction,
		});

		local Toggle = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local Circle = Instance.new("Frame")
		local UICorner_2 = Instance.new("UICorner")

		Toggle.Name = NeverLose.RandomString();
		Toggle.Parent = Handler
		Toggle.BackgroundColor3 = Color3.fromRGB(10, 13, 21)
		Toggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Toggle.BorderSizePixel = 0
		Toggle.ClipsDescendants = true
		Toggle.Size = UDim2.new(0, 30, 0, 18)
		Toggle.ZIndex = ZINdex + 13
		Toggle.LayoutOrder = -(#Handler:GetChildren() + 5);

		UICorner.CornerRadius = UDim.new(1, 0)
		UICorner.Parent = Toggle

		Circle.Name = NeverLose.RandomString();
		Circle.Parent = Toggle
		Circle.AnchorPoint = Vector2.new(0.5, 0.5)
		Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Circle.BackgroundTransparency = 0.500
		Circle.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Circle.BorderSizePixel = 0
		Circle.Position = UDim2.new(0.300000012, 0, 0.5, 0)
		Circle.Size = UDim2.new(0, 16, 0, 16)
		Circle.ZIndex = ZINdex + 14

		UICorner_2.CornerRadius = UDim.new(1, 0)
		UICorner_2.Parent = Circle

		local ToggleLib = {
			Root = Toggle	
		};

		ToggleLib.SetUI = LPH_NO_VIRTUALIZE(function(value)
			if value then
				NeverLose.PlayAnimate(Toggle,SlowyTween,{
					BackgroundTransparency = 0,
					BackgroundColor3 = NeverLose.AccentColor
				})

				NeverLose.PlayAnimate(Circle,SlowyTween,{
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 0,
					Position = UDim2.new(0.7, 0, 0.5, 0)
				})
			else
				NeverLose.PlayAnimate(Toggle,SlowyTween,{
					BackgroundTransparency = 0,
					BackgroundColor3 = Color3.fromRGB(10, 13, 21)
				})

				NeverLose.PlayAnimate(Circle,SlowyTween,{
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 0.500,
					Position = UDim2.new(0.300000012, 0, 0.5, 0)
				})
			end;
		end);

		ToggleLib.SetVisible = LPH_NO_VIRTUALIZE(function(value)
			if value then
				ToggleLib.SetUI(Config.Default);
			else
				NeverLose.PlayAnimate(Toggle,SlowyTween,{
					BackgroundTransparency = 1,
					BackgroundColor3 = Color3.fromRGB(10, 13, 21)
				})

				NeverLose.PlayAnimate(Circle,SlowyTween,{
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					Position = UDim2.new(0.300000012, 0, 0.5, 0)
				})
			end;
		end);

		ToggleLib.SetUI(Config.Default);
		ToggleLib.SetVisible(Signal:GetValue());

		NeverLose:CreateInput(Toggle , LPH_NO_VIRTUALIZE(function()
			Config.Default = not Config.Default;

			ToggleLib.SetUI(Config.Default);

			Config.Callback(Config.Default)
		end))

		ToggleLib.Signal = Signal:Connect(ToggleLib.SetVisible);

		function ToggleLib:GetValue()
			return Config.Default;
		end;

		function ToggleLib:SetValue(v)
			Config.Default = v;

			if Signal:GetValue() then
				ToggleLib.SetUI(Config.Default);
			end;

			Config.Callback(Config.Default)
		end;

		if Config.Flag then
			NeverLose.Flags[Config.Flag] = ToggleLib;
		end;

		return ToggleLib;
	end;

	function handle:AddSlider(Config)
		Config = NeverLose:ProcessParams(Config , {
			Default = 50,
			Min = 0,
			Max = 10,
			Type = "",
			Rounding = 0,
			Nums = {},
			Flag = nil,
			Size = 125,
			Callback = EmptyFunction,
		});

		local SliderLib = {};

		SliderLib.GetSize = LPH_NO_VIRTUALIZE(function()
			return (Config.Default - Config.Min) / (Config.Max - Config.Min);
		end);

		local FullNumSize = TextService:GetTextSize(string.rep("0",(Config.Rounding + #tostring(Config.Max))+1)..tostring(Config.Type),10,Enum.Font.GothamMedium,Vector2.new(math.huge,math.huge));

		SliderLib.MaximumSize = FullNumSize.X;

		if Config.Nums then
			local nszie = 0;

			for i,ns in next , Config.Nums do
				local size = TextService:GetTextSize(string.rep("m",string.len(tostring(ns))),10,Enum.Font.GothamMedium,Vector2.new(math.huge,math.huge));

				if nszie < size.X then
					nszie = size.X;
				end
			end;

			if SliderLib.MaximumSize < nszie then
				SliderLib.MaximumSize = nszie;
			end;
		end;

		local Slider = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local ValueFrame = Instance.new("Frame")
		local UICorner_2 = Instance.new("UICorner")
		local UIStroke = Instance.new("UIStroke")
		local ValueLabel = Instance.new("TextBox")
		local SlideMain = Instance.new("Frame")
		local SlideFrame = Instance.new("Frame")
		local UICorner_3 = Instance.new("UICorner")
		local SlideMoving = Instance.new("Frame")
		local UICorner_4 = Instance.new("UICorner")
		local Frame = Instance.new("Frame")
		local UICorner_5 = Instance.new("UICorner")
		local boxSize = 2;

		Slider.Name = NeverLose.RandomString();
		Slider.Parent = Handler
		Slider.BackgroundColor3 = Color3.fromRGB(26, 28, 36)
		Slider.BackgroundTransparency = 1.000
		Slider.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Slider.BorderSizePixel = 0
		Slider.ClipsDescendants = false
		Slider.Size = UDim2.new(0, Config.Size, 0, 18)
		Slider.ZIndex = ZINdex + 13
		Slider.LayoutOrder = -(#Handler:GetChildren() + 5);

		UICorner.CornerRadius = UDim.new(0, 4)
		UICorner.Parent = Slider

		ValueFrame.Name = NeverLose.RandomString();
		ValueFrame.Parent = Slider
		ValueFrame.AnchorPoint = Vector2.new(1, 0)
		ValueFrame.BackgroundColor3 = Color3.fromRGB(26, 28, 36)
		ValueFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ValueFrame.BorderSizePixel = 0
		ValueFrame.ClipsDescendants = true
		ValueFrame.Position = UDim2.new(1, 0, 0, 0)
		ValueFrame.Size = UDim2.new(0, SliderLib.MaximumSize + boxSize, 0, 18)
		ValueFrame.ZIndex = ZINdex + 13

		UICorner_2.CornerRadius = UDim.new(0, 4)
		UICorner_2.Parent = ValueFrame

		UIStroke.Transparency = 0.650
		UIStroke.Color = Color3.fromRGB(45, 48, 58)
		UIStroke.Parent = ValueFrame

		ValueLabel.Name = NeverLose.RandomString();
		ValueLabel.Parent = ValueFrame
		ValueLabel.AnchorPoint = Vector2.new(0.5, 0.5)
		ValueLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ValueLabel.BackgroundTransparency = 1.000
		ValueLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ValueLabel.BorderSizePixel = 0
		ValueLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
		ValueLabel.Size = UDim2.new(1, 0, 1, 0)
		ValueLabel.ZIndex = ZINdex + 14
		ValueLabel.Font = Enum.Font.GothamMedium
		ValueLabel.Text = tostring(Config.Default)..tostring(Config.Type);
		ValueLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		ValueLabel.TextSize = 10.000
		ValueLabel.ClearTextOnFocus = false;
		ValueLabel.TextTransparency = 0.350

		SlideMain.Name = NeverLose.RandomString();
		SlideMain.Parent = Slider
		SlideMain.AnchorPoint = Vector2.new(0, 0.5)
		SlideMain.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		SlideMain.BackgroundTransparency = 1.000
		SlideMain.BorderColor3 = Color3.fromRGB(0, 0, 0)
		SlideMain.BorderSizePixel = 0
		SlideMain.Position = UDim2.new(0, 0, 0.5, 0)
		SlideMain.Size = UDim2.new(1, -((SliderLib.MaximumSize + 11)), 0, 18)
		SlideMain.ZIndex = ZINdex + 13

		SlideFrame.Name = NeverLose.RandomString();
		SlideFrame.Parent = SlideMain
		SlideFrame.AnchorPoint = Vector2.new(0, 0.5)
		SlideFrame.BackgroundColor3 = Color3.fromRGB(30, 29, 36)
		SlideFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		SlideFrame.BorderSizePixel = 0
		SlideFrame.Position = UDim2.new(0, 0, 0.5, 0)
		SlideFrame.Size = UDim2.new(1, 0, 0, 5)
		SlideFrame.ZIndex = ZINdex + 13

		UICorner_3.CornerRadius = UDim.new(1, 0)
		UICorner_3.Parent = SlideFrame

		SlideMoving.Name = NeverLose.RandomString();
		SlideMoving.Parent = SlideFrame
		SlideMoving.BackgroundColor3 = NeverLose.AccentColor
		SlideMoving.BorderColor3 = Color3.fromRGB(0, 0, 0)
		SlideMoving.BorderSizePixel = 0
		SlideMoving.Size = UDim2.new(SliderLib.GetSize(), 0, 1, 0)
		SlideMoving.ZIndex = ZINdex + 14

		UICorner_4.CornerRadius = UDim.new(1, 0)
		UICorner_4.Parent = SlideMoving

		Frame.Parent = SlideMoving
		Frame.AnchorPoint = Vector2.new(1, 0.5)
		Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Frame.BorderSizePixel = 0
		Frame.Position = UDim2.new(1, 5, 0.5, 0)
		Frame.Size = UDim2.new(0, 10, 0, 10)
		Frame.ZIndex = ZINdex + 15

		UICorner_5.CornerRadius = UDim.new(1, 0)
		UICorner_5.Parent = Frame

		local LoadText = LPH_NO_VIRTUALIZE(function()
			if Config.Nums[Config.Default] then
				ValueLabel.Text = Config.Nums[Config.Default]

			else
				ValueLabel.Text = tostring(Config.Default)..tostring(Config.Type);

			end;
		end);

		ValueLabel.FocusLost:Connect(LPH_NO_VIRTUALIZE(function()
			local OutVal = NeverLose:ParseInput(ValueLabel.Text , true);
			if OutVal then
				local rx = math.clamp(OutVal , Config.Min , Config.Max);
				local Value = NeverLose.Rounding(rx,Config.Rounding);

				if Value then
					Config.Default = Value;

					TweenService:Create(SlideMoving , ManualTween ,{
						Size = UDim2.new(SliderLib.GetSize(), 0, 1, 0)
					}):Play();

					LoadText();

					Config.Callback(Config.Default)
				else
					LoadText();
				end;

			else
				LoadText()
			end;
		end));

		SliderLib.SetRender = LPH_NO_VIRTUALIZE(function(value)
			if value then
				NeverLose.PlayAnimate(ValueFrame,SlowyTween,{
					BackgroundTransparency = 0,
					Size = UDim2.new(0, SliderLib.MaximumSize + boxSize, 0, 18)
				});

				NeverLose.PlayAnimate(UIStroke,SlowyTween,{
					Transparency = 0.650
				});

				NeverLose.PlayAnimate(ValueLabel,SlowyTween,{
					TextTransparency = 0.350
				});

				NeverLose.PlayAnimate(SlideFrame,SlowyTween,{
					BackgroundTransparency = 0
				});

				NeverLose.PlayAnimate(SlideMoving,SlowyTween,{
					BackgroundTransparency = 0,
					Size = UDim2.new(SliderLib.GetSize(), 0, 1, 0)
				});

				NeverLose.PlayAnimate(Frame,SlowyTween,{
					BackgroundTransparency = 0
				});
			else
				NeverLose.PlayAnimate(ValueFrame,SlowyTween,{
					BackgroundTransparency = 1,
				});

				NeverLose.PlayAnimate(UIStroke,SlowyTween,{
					Transparency = 1
				});

				NeverLose.PlayAnimate(ValueLabel,SlowyTween,{
					TextTransparency = 1
				});

				NeverLose.PlayAnimate(SlideFrame,SlowyTween,{
					BackgroundTransparency = 1
				});

				NeverLose.PlayAnimate(SlideMoving,SlowyTween,{
					BackgroundTransparency = 1,
					Size = UDim2.new(0, 0, 1, 0)
				});

				NeverLose.PlayAnimate(Frame,SlowyTween,{
					BackgroundTransparency = 1
				});
			end;
		end);

		SliderLib.SetRender(Signal:GetValue());
		SliderLib.Signal = Signal:Connect(SliderLib.SetRender);

		local Update = function(Input)
			local SizeScale = math.clamp((((Input.Position.X) - SlideMain.AbsolutePosition.X) / SlideMain.AbsoluteSize.X), 0, 1);
			local Main = ((Config.Max - Config.Min) * SizeScale) + Config.Min;
			local Value = NeverLose.Rounding(Main,Config.Rounding);
			local PositionX = UDim2.fromScale(SizeScale, 1);
			local Size = ((Value - Config.Min) / (Config.Max - Config.Min)) + 0.02;

			Config.Default = Value;

			TweenService:Create(SlideMoving , ManualTween ,{
				Size = UDim2.new(SliderLib.GetSize(), 0, 1, 0)
			}):Play();

			LoadText()


			Config.Callback(Value)
		end;

		local IsHold = false;

		do
			SlideMain.InputBegan:Connect(LPH_NO_VIRTUALIZE(function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					IsHold = true
					Update(Input)
				end
			end))

			SlideMain.InputEnded:Connect(LPH_NO_VIRTUALIZE(function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					if UserInputService.TouchEnabled then
						if not NeverLose:IsMouseOverFrame(SlideMain) then
							IsHold = false
						end;
					else
						IsHold = false
					end;
				end
			end))

			UserInputService.InputChanged:Connect(LPH_NO_VIRTUALIZE(function(Input)
				if IsHold then
					if (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch)  then
						if UserInputService.TouchEnabled then
							if not NeverLose:IsMouseOverFrame(SlideMain) then
								IsHold = false
							else
								Update(Input)
							end;
						else
							Update(Input)
						end;
					end;
				end;
			end));
		end;

		function SliderLib:GetValue()
			return Config.Default;
		end;

		function SliderLib:SetValue(v)
			Config.Default = v;

			if Signal:GetValue() then
				NeverLose.PlayAnimate(SlideMoving,SlowyTween,{
					BackgroundTransparency = 0,
					Size = UDim2.new(SliderLib.GetSize(), 0, 1, 0)
				});
			end;

			LoadText()

			Config.Callback(Config.Default);
		end;

		if Config.Flag then
			NeverLose.Flags[Config.Flag] = SliderLib;
		end;

		return SliderLib;
	end;

	function handle:AddOption(GearIcon)
		local Option = Instance.new("Frame")
		local Icon = Instance.new("TextLabel")
		local UICorner = Instance.new("UICorner")

		Option.Name = NeverLose.RandomString();
		Option.Parent = Handler
		Option.BackgroundColor3 = Color3.fromRGB(39, 40, 49)
		Option.BackgroundTransparency = 1.000
		Option.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Option.BorderSizePixel = 0
		Option.ClipsDescendants = true
		Option.Size = UDim2.new(0, 20, 0, 18)
		Option.ZIndex = ZINdex + 13
		Option.LayoutOrder = -(#Handler:GetChildren() + 5);

		Icon.Name = NeverLose.RandomString();
		Icon.Parent = Option
		Icon.AnchorPoint = Vector2.new(0.5, 0.5)
		Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Icon.BackgroundTransparency = 1.000
		Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Icon.BorderSizePixel = 0
		Icon.Position = UDim2.new(0.5, 0, 0.5, 0)
		Icon.Size = UDim2.new(1, 0, 1, 0)
		Icon.ZIndex = ZINdex + 14
		Icon.FontFace = NeverLose.BuiltInBold
		Icon.Text = (GearIcon == 1 and 'gear') or (GearIcon == 2 and 'chevron-large-right') or "three-dots-horizontal";
		Icon.TextColor3 = Color3.fromRGB(223, 223, 223)
		Icon.TextSize = 16.000
		Icon.TextTransparency = 0.400
		Icon.TextWrapped = true

		UICorner.CornerRadius = UDim.new(0, 4)
		UICorner.Parent = Option

		local Window = NeverLose:CreateOptionWindow(Option , ZINdex + 13);
		local reciveSignal;

		Window.SetRender = LPH_NO_VIRTUALIZE(function(value)
			if value then
				NeverLose.PlayAnimate(Icon , SlowyTween , {
					TextTransparency = 0.400
				})
			else
				NeverLose.PlayAnimate(Icon , SlowyTween , {
					TextTransparency = 1
				})
			end;
		end);

		Window.SetRender(Signal:GetValue());
		Signal:Connect(Window.SetRender);

		local bthg = NeverLose:CreateInput(Option , LPH_NO_VIRTUALIZE(function()
			if reciveSignal then
				reciveSignal:Disconnect();
				reciveSignal = nil;	
			end;

			Window.Signal:SetValue(true);

			reciveSignal = UserInputService.InputBegan:Connect(function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					if not NeverLose:IsMouseOverFrame(Window.Root) and not NeverLose:IsMouseOverFrame(Option) then
						if reciveSignal then
							reciveSignal:Disconnect();
							reciveSignal = nil;	
						end;

						Window.Signal:SetValue(false);
					end
				end
			end)
		end));

		NeverLose:AddSignal(bthg.MouseEnter:Connect(LPH_NO_VIRTUALIZE(function()
			NeverLose.PlayAnimate(Option , SlowyTween , {
				BackgroundTransparency = 0.5
			})

			NeverLose.PlayAnimate(Icon , SlowyTween , {
				TextTransparency = 0.25
			})
		end)));

		NeverLose:AddSignal(bthg.MouseLeave:Connect(LPH_NO_VIRTUALIZE(function()
			NeverLose.PlayAnimate(Option , SlowyTween , {
				BackgroundTransparency = 1.000
			})

			NeverLose.PlayAnimate(Icon , SlowyTween , {
				TextTransparency = 0.400
			})
		end)));

		return Window;
	end;

	function handle:AddColorPicker(Config)
		Config = NeverLose:ProcessParams(Config , {
			Default = Color3.fromRGB(255, 255, 255),
			Callback  = EmptyFunction,
		});

		if typeof(Config.Default) == 'string' then
			Config.Default = Color3.fromHex(Config.Default:gsub('#',''));
		end;

		local ColorPickerLib = {};
		local ColorPicker = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local UIStroke = Instance.new("UIStroke")
		local ImageLabel = Instance.new("ImageLabel")
		local UICorner_2 = Instance.new("UICorner")

		ColorPicker.Name = NeverLose.RandomString();
		ColorPicker.Parent = Handler
		ColorPicker.BackgroundColor3 = Config.Default;
		ColorPicker.BackgroundTransparency = 0
		ColorPicker.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ColorPicker.BorderSizePixel = 0
		ColorPicker.ClipsDescendants = true
		ColorPicker.Size = UDim2.new(0, 18, 0, 18)
		ColorPicker.ZIndex = ZINdex + 13
		ColorPicker.LayoutOrder = -(#Handler:GetChildren() + 5);

		UICorner.CornerRadius = UDim.new(0, 4)
		UICorner.Parent = ColorPicker

		UIStroke.Transparency = 0.650
		UIStroke.Color = Color3.fromRGB(45, 48, 58)
		UIStroke.Parent = ColorPicker

		ImageLabel.Parent = ColorPicker
		ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ImageLabel.BorderSizePixel = 0
		ImageLabel.Size = UDim2.new(1, 0, 1, 0)
		ImageLabel.ZIndex = ZINdex + 11
		ImageLabel.Image = "rbxasset://textures/meshPartFallback.png"
		ImageLabel.ImageTransparency = 0.9
		ImageLabel.BackgroundTransparency = 1;
		ImageLabel.ScaleType = Enum.ScaleType.Crop

		UICorner_2.CornerRadius = UDim.new(0, 4)
		UICorner_2.Parent = ImageLabel

		local BackendM = NeverLose:CreateColorPicker(ColorPicker);

		BackendM:SetValue(Config.Default)
		BackendM.Callback = function(color)
			ColorPicker.BackgroundColor3 = color;
			Config.Default = color;
			Config.Callback(Config.Default);
		end;

		local signal;
		NeverLose:CreateInput(ColorPicker , LPH_NO_VIRTUALIZE(function()
			if signal then
				signal:Disconnect();
				signal = nil;
			end;

			BackendM.SetRender(true);

			signal = UserInputService.InputBegan:Connect(function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					if not NeverLose:IsMouseOverFrame(ColorPicker) and not NeverLose:IsMouseOverFrame(BackendM.Root) then
						if signal then
							signal:Disconnect();
							signal = nil;
						end;

						BackendM.SetRender(false);
					end;
				end;
			end)
		end));

		ColorPickerLib.SetRender = LPH_NO_VIRTUALIZE(function(value)
			if value then
				NeverLose.PlayAnimate(ColorPicker , SlowyTween , {
					BackgroundTransparency = 0
				})

				NeverLose.PlayAnimate(UIStroke , SlowyTween , {
					Transparency = 0.650
				})

				NeverLose.PlayAnimate(ImageLabel , SlowyTween , {
					ImageTransparency = 0.9
				})
			else
				NeverLose.PlayAnimate(ColorPicker , SlowyTween , {
					BackgroundTransparency = 1
				})

				NeverLose.PlayAnimate(UIStroke , SlowyTween , {
					Transparency = 1
				})

				NeverLose.PlayAnimate(ImageLabel , SlowyTween , {
					ImageTransparency = 1
				})
			end;
		end);

		ColorPickerLib.SetRender(Signal:GetValue());
		Signal:Connect(ColorPickerLib.SetRender);

		function ColorPickerLib:GetValue()
			return Config.Default;
		end;

		function ColorPickerLib:SetValue(v)
			Config.Default = v;
			BackendM:SetValue(Config.Default)
		end;

		if Config.Flag then
			NeverLose.Flags[Config.Flag] = ColorPickerLib;
		end;

		return ColorPickerLib;
	end;

	function handle:AddKeybind(Config)
		Config = NeverLose:ProcessParams(Config,{
			Default = nil,
			Blacklist = {},
			Callback = EmptyFunction,
			Flag = nil
		});

		local KeybindLib = {};

		local Keybind = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local UIStroke = Instance.new("UIStroke")
		local ValueLabel = Instance.new("TextLabel")

		Keybind.Name = NeverLose.RandomString();
		Keybind.Parent = Handler
		Keybind.BackgroundColor3 = Color3.fromRGB(26, 28, 36)
		Keybind.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Keybind.BorderSizePixel = 0
		Keybind.ClipsDescendants = true
		Keybind.Size = UDim2.new(0, 45, 0, 18)
		Keybind.ZIndex = ZINdex + 13
		Keybind.LayoutOrder = -(#Handler:GetChildren() + 5);

		UICorner.CornerRadius = UDim.new(0, 4)
		UICorner.Parent = Keybind

		UIStroke.Transparency = 0.650
		UIStroke.Color = Color3.fromRGB(45, 48, 58)
		UIStroke.Parent = Keybind

		ValueLabel.Name = NeverLose.RandomString();
		ValueLabel.Parent = Keybind
		ValueLabel.AnchorPoint = Vector2.new(0.5, 0.5)
		ValueLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ValueLabel.BackgroundTransparency = 1.000
		ValueLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ValueLabel.BorderSizePixel = 0
		ValueLabel.ClipsDescendants = true
		ValueLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
		ValueLabel.Size = UDim2.new(1, 0, 1, 0)
		ValueLabel.ZIndex = ZINdex + 14
		ValueLabel.Font = Enum.Font.GothamMedium
		ValueLabel.Text = NeverLose:KeyCodeToStr(Config.Default or "None")
		ValueLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		ValueLabel.TextSize = 10.000
		ValueLabel.TextTransparency = 0.500

		KeybindLib.SetRender = LPH_NO_VIRTUALIZE(function(value)
			if value then
				NeverLose.PlayAnimate(Keybind,SlowyTween, {
					BackgroundTransparency = 0
				})

				NeverLose.PlayAnimate(UIStroke,SlowyTween, {
					Transparency = 0.650
				})

				NeverLose.PlayAnimate(ValueLabel,SlowyTween, {
					TextTransparency = 0.500
				})
			else
				NeverLose.PlayAnimate(Keybind,SlowyTween, {
					BackgroundTransparency = 1
				})

				NeverLose.PlayAnimate(UIStroke,SlowyTween, {
					Transparency = 1
				})

				NeverLose.PlayAnimate(ValueLabel,SlowyTween, {
					TextTransparency = 1
				})
			end;
		end);

		function KeybindLib:Update()
			local size = TextService:GetTextSize(ValueLabel.Text,ValueLabel.TextSize,ValueLabel.Font,Vector2.new(math.huge,math.huge));

			NeverLose.PlayAnimate(Keybind , SlowyTween , {
				Size = UDim2.new(0, size.X + 7, 0, 18)
			})
		end;

		local IsBlacklist = LPH_NO_VIRTUALIZE(function(v)
			return Config.Blacklist and (Config.Blacklist[v] or table.find(Config.Blacklist,v))
		end);

		KeybindLib:Update()

		KeybindLib.SetRender(Signal:GetValue());
		Signal:Connect(KeybindLib.SetRender);

		local IsBinding = false;
		NeverLose:CreateInput(Keybind , function()
			if IsBinding then
				return;
			end;

			IsBinding = true;

			ValueLabel.Text = "...";

			KeybindLib:Update();

			local Selected = nil;

			while not Selected do
				local Key = UserInputService.InputBegan:Wait();

				if Key.KeyCode ~= Enum.KeyCode.Unknown and not IsBlacklist(Key.KeyCode) and not IsBlacklist(Key.KeyCode.Name) then
					Selected = Key.KeyCode;
				else
					if Key.UserInputType == Enum.UserInputType.MouseButton1 and not IsBlacklist(Enum.UserInputType.MouseButton1) and not IsBlacklist("M1B") then
						Selected = "M1B";
					elseif Key.UserInputType == Enum.UserInputType.MouseButton2 and not IsBlacklist(Enum.UserInputType.MouseButton2) and not IsBlacklist("M2B") then
						Selected = "M2B";
					end;
				end;
			end;

			IsBinding = false;

			local KeyName = typeof(Selected) == "string" and Selected or Selected.Name;

			Config.Default = KeyName;

			ValueLabel.Text = NeverLose:KeyCodeToStr(KeyName);

			KeybindLib:Update();

			Config.Callback(KeyName)
		end)

		function KeybindLib:GetValue()
			return Config.Default;
		end;

		function KeybindLib:SetValue(v)
			Config.Default = v;
			ValueLabel.Text = NeverLose:KeyCodeToStr(v);
			KeybindLib:Update();
			Config.Callback(Config.Default);
		end;

		if Config.Flag then
			NeverLose.Flags[Config.Flag] = KeybindLib;
		end;

		return KeybindLib;
	end;

	function handle:AddTextInput(Config)
		Config = NeverLose:ProcessParams(Config , {
			Default = "",
			Placeholder = "Placeholder",
			Callback = print,
			Flag = nil,
			Size = 100,
			Numeric = false,
		});

		local TextBoxLib = {};

		local TextInput = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local UIStroke = Instance.new("UIStroke")
		local TextBox = Instance.new("TextBox")

		TextInput.Name = NeverLose.RandomString();
		TextInput.Parent = Handler
		TextInput.BackgroundColor3 = Color3.fromRGB(26, 28, 36)
		TextInput.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TextInput.BorderSizePixel = 0
		TextInput.ClipsDescendants = true
		TextInput.Size = UDim2.new(0, Config.Size, 0, 18)
		TextInput.ZIndex = ZINdex + 13
		TextInput.LayoutOrder = -(#Handler:GetChildren() + 5);

		UICorner.CornerRadius = UDim.new(0, 4)
		UICorner.Parent = TextInput

		UIStroke.Transparency = 0.650
		UIStroke.Color = Color3.fromRGB(45, 48, 58)
		UIStroke.Parent = TextInput

		TextBox.Parent = TextInput
		TextBox.AnchorPoint = Vector2.new(0, 0.5)
		TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TextBox.BackgroundTransparency = 1.000
		TextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TextBox.BorderSizePixel = 0
		TextBox.Position = UDim2.new(0, 5, 0.5, 0)
		TextBox.Size = UDim2.new(1, -5, 0, 17)
		TextBox.ZIndex = ZINdex + 14
		TextBox.ClearTextOnFocus = false
		TextBox.Font = Enum.Font.GothamMedium
		TextBox.PlaceholderText = Config.Placeholder
		TextBox.Text = tostring(Config.Default)
		TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextBox.TextSize = 11.000
		TextBox.TextTransparency = 0.350
		TextBox.TextXAlignment = Enum.TextXAlignment.Left

		TextBoxLib.SetRender = LPH_NO_VIRTUALIZE(function(value)
			if value then
				NeverLose.PlayAnimate(TextInput , SlowyTween ,{
					BackgroundTransparency = 0
				})	

				NeverLose.PlayAnimate(UIStroke , SlowyTween ,{
					Transparency = 0.650
				})	

				NeverLose.PlayAnimate(TextBox , SlowyTween ,{
					TextTransparency = 0.350
				})	
			else
				NeverLose.PlayAnimate(TextInput , SlowyTween ,{
					BackgroundTransparency = 1
				})	

				NeverLose.PlayAnimate(UIStroke , SlowyTween ,{
					Transparency = 1
				})	

				NeverLose.PlayAnimate(TextBox , SlowyTween ,{
					TextTransparency = 1
				})
			end;
		end);

		NeverLose:AddSignal(TextBox:GetPropertyChangedSignal('Text'):Connect(LPH_NO_VIRTUALIZE(function()
			local valout = NeverLose:ParseInput(TextBox.Text , Config.Numeric);

			if Config.Numeric then
				TextBox.Text = string.gsub(TextBox.Text , '[^0-9.]','')
			end;

			if valout then
				Config.Default = valout;
				Config.Callback(valout);
			end
		end)));

		TextBoxLib.SetRender(Signal:GetValue());
		Signal:Connect(TextBoxLib.SetRender);

		TextBoxLib.Box = TextBox;

		function TextBoxLib:GetValue()
			return Config.Default;
		end;

		function TextBoxLib:SetValue(v)
			Config.Default = v;
			TextBox.Text = tostring(v);
			Config.Callback(Config.Default);
		end;

		if Config.Flag then
			NeverLose.Flags[Config.Flag] = TextBoxLib;
		end;

		return TextBoxLib;
	end;

	function handle:AddDropdown(Config)
		Config = NeverLose:ProcessParams(Config , {
			Default = nil,
			Values = {},
			Multi = false,
			Callback = EmptyFunction,
			AutoUpdate = false,
			Flag = nil,
			Size = 100
		})

		Config.Default = NeverLose.ProcessDropdown(Config.Default);

		local Dropdown = Instance.new("Frame")
		local DropdownIcon = Instance.new("TextLabel")
		local UICorner = Instance.new("UICorner")
		local UIStroke = Instance.new("UIStroke")
		local BasedLabel = Instance.new("TextLabel")

		Dropdown.Name = NeverLose.RandomString();
		Dropdown.Parent = Handler
		Dropdown.BackgroundColor3 = Color3.fromRGB(26, 28, 36)
		Dropdown.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Dropdown.BorderSizePixel = 0
		Dropdown.ClipsDescendants = true
		Dropdown.Size = UDim2.new(0, Config.Size, 0, 18)
		Dropdown.ZIndex = ZINdex + 13
		Dropdown.LayoutOrder = -(#Handler:GetChildren() + 5);

		DropdownIcon.Name = NeverLose.RandomString();
		DropdownIcon.Parent = Dropdown
		DropdownIcon.AnchorPoint = Vector2.new(1, 0.5)
		DropdownIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		DropdownIcon.BackgroundTransparency = 1.000
		DropdownIcon.BorderColor3 = Color3.fromRGB(0, 0, 0)
		DropdownIcon.BorderSizePixel = 0
		DropdownIcon.Position = UDim2.new(1, -2, 0.5, 0)
		DropdownIcon.Size = UDim2.new(0, 18, 0, 18)
		DropdownIcon.ZIndex = ZINdex + 14
		DropdownIcon.FontFace = NeverLose.BuiltInBold
		DropdownIcon.Text = "chevron-small-down"
		DropdownIcon.TextColor3 = Color3.fromRGB(223, 223, 223)
		DropdownIcon.TextSize = 16.000
		DropdownIcon.TextTransparency = 0.250
		DropdownIcon.TextWrapped = true

		UICorner.CornerRadius = UDim.new(0, 4)
		UICorner.Parent = Dropdown

		UIStroke.Transparency = 0.650
		UIStroke.Color = Color3.fromRGB(45, 48, 58)
		UIStroke.Parent = Dropdown

		BasedLabel.Name = NeverLose.RandomString();
		BasedLabel.Parent = Dropdown
		BasedLabel.AnchorPoint = Vector2.new(0, 0.5)
		BasedLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		BasedLabel.BackgroundTransparency = 1.000
		BasedLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BasedLabel.BorderSizePixel = 0
		BasedLabel.ClipsDescendants = true
		BasedLabel.Position = UDim2.new(0, 5, 0.5, 0)
		BasedLabel.Size = UDim2.new(1, -25, 0, 15)
		BasedLabel.ZIndex = ZINdex + 14
		BasedLabel.Font = Enum.Font.GothamMedium
		BasedLabel.Text = NeverLose.ParseDropdown(Config.Default);
		BasedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		BasedLabel.TextSize = 12.000
		BasedLabel.TextTransparency = 0.5
		BasedLabel.TextXAlignment = Enum.TextXAlignment.Left

		do
			local UIGradient = Instance.new("UIGradient")

			UIGradient.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.00), NumberSequenceKeypoint.new(0.85, 0.23), NumberSequenceKeypoint.new(1.00, 1.00)}
			UIGradient.Parent = BasedLabel;
		end;

		NeverLose:AddSignal(Dropdown.MouseEnter:Connect(LPH_NO_VIRTUALIZE(function()
			NeverLose.PlayAnimate(BasedLabel , SlowyTween , {
				TextTransparency = 0.200
			})
		end)));

		NeverLose:AddSignal(Dropdown.MouseLeave:Connect(LPH_NO_VIRTUALIZE(function()
			NeverLose.PlayAnimate(BasedLabel , SlowyTween , {
				TextTransparency = 0.5
			})
		end)));

		local DropdownLib = {
			OpenSignal = NeverLose:CreateSignal(false),
			Signals = {},
			Refuse = {},
		};

		DropdownLib.SetRender = LPH_NO_VIRTUALIZE(function(value)
			if value then
				NeverLose.PlayAnimate(Dropdown , SlowyTween , {
					BackgroundTransparency = 0
				});

				NeverLose.PlayAnimate(DropdownIcon , SlowyTween , {
					TextTransparency = 0.250
				});

				NeverLose.PlayAnimate(UIStroke , SlowyTween , {
					Transparency = 0.650
				});

				NeverLose.PlayAnimate(BasedLabel , SlowyTween , {
					TextTransparency = 0.5
				});
			else
				NeverLose.PlayAnimate(Dropdown , SlowyTween , {
					BackgroundTransparency = 1
				});

				NeverLose.PlayAnimate(DropdownIcon , SlowyTween , {
					TextTransparency = 1
				});

				NeverLose.PlayAnimate(UIStroke , SlowyTween , {
					Transparency = 1
				});

				NeverLose.PlayAnimate(BasedLabel , SlowyTween , {
					TextTransparency = 1
				});
			end
		end);

		DropdownLib.SetRender(Signal:GetValue())
		Signal:Connect(DropdownLib.SetRender);
		DropdownLib.ExtentSize = 0;

		do
			local DropdownHandler = Instance.new("Frame")
			local UICorner = Instance.new("UICorner")
			local UIStroke = Instance.new("UIStroke")
			local DropdownScrollFrame = Instance.new("ScrollingFrame")
			local UIListLayout = Instance.new("UIListLayout")
			local Shadow = NeverLose:CreateShadow(DropdownHandler);

			DropdownHandler.Name = NeverLose.RandomString();
			DropdownHandler.Parent = NeverLose.ScreenGui;
			DropdownHandler.AnchorPoint = Vector2.new(0.5, 0)
			DropdownHandler.BackgroundColor3 = Color3.fromRGB(20, 22, 27)
			DropdownHandler.BackgroundTransparency = 0.5
			DropdownHandler.BorderColor3 = Color3.fromRGB(0, 0, 0)
			DropdownHandler.BorderSizePixel = 0
			DropdownHandler.ClipsDescendants = true
			DropdownHandler.Position = UDim2.new(255,255,255,255)
			DropdownHandler.Size = UDim2.new(0, 125, 0, 50)
			DropdownHandler.ZIndex = ZINdex + 125
			DropdownLib.BlockRoot = DropdownHandler;

			NeverLose:AddSignal(DropdownHandler:GetPropertyChangedSignal('BackgroundTransparency'):Connect(function()
				if DropdownHandler.BackgroundTransparency > 0.9 then
					DropdownHandler.Visible = false;
					DropdownHandler.Parent = nil;
				else
					DropdownHandler.Visible = true;

					if NeverLose.Global3DRenderMode then
						DropdownHandler.Parent = NeverLose.GlobalSurfaceGui;
					else
						DropdownHandler.Parent = NeverLose.ScreenGui;
					end;
				end;
			end));

			UICorner.CornerRadius = UDim.new(0, 10)
			UICorner.Parent = DropdownHandler

			UIStroke.Transparency = 0.650
			UIStroke.Color = Color3.fromRGB(45, 48, 58)
			UIStroke.Parent = DropdownHandler

			DropdownScrollFrame.Name = NeverLose.RandomString();
			DropdownScrollFrame.Parent = DropdownHandler
			DropdownScrollFrame.Active = true
			DropdownScrollFrame.AnchorPoint = Vector2.new(0.5, 0.5)
			DropdownScrollFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			DropdownScrollFrame.BackgroundTransparency = 1.000
			DropdownScrollFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			DropdownScrollFrame.BorderSizePixel = 0
			DropdownScrollFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
			DropdownScrollFrame.Size = UDim2.new(1, -5, 1, -5)
			DropdownScrollFrame.ZIndex = ZINdex + 127
			DropdownScrollFrame.ScrollBarThickness = 0

			DropdownLib.RootItem = DropdownScrollFrame;

			UIListLayout.Parent = DropdownScrollFrame
			UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

			NeverLose:AddSignal(UIListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(LPH_NO_VIRTUALIZE(function()
				DropdownScrollFrame.CanvasSize = UDim2.fromOffset(0,UIListLayout.AbsoluteContentSize.Y)
				NeverLose.PlayAnimate(DropdownHandler , SlowyTween , {
					Size = UDim2.new(0, (Dropdown.AbsoluteSize.X + 5) + DropdownLib.ExtentSize, 0, math.min(UIListLayout.AbsoluteContentSize.Y + 5, 250));
				})
			end)));

			local SetPosition = LPH_NO_VIRTUALIZE(function()
				if NeverLose:MoreThanHalfY(Dropdown.AbsolutePosition.Y + 85) then
					DropdownHandler.AnchorPoint = Vector2.new(0.5,1)
				else
					DropdownHandler.AnchorPoint = Vector2.new(0.5,0)
				end;

				DropdownHandler.Position = UDim2.fromOffset(Dropdown.AbsolutePosition.X + (DropdownHandler.AbsoluteSize.X / 2), Dropdown.AbsolutePosition.Y + 85);

			end);

			DropdownLib.SetFrameRender = LPH_NO_VIRTUALIZE(function(value)
				DropdownLib.OpenSignal:SetValue(value);

				if value then
					Shadow:Render(true);

					DropdownHandler.Size = UDim2.new(0, (Dropdown.AbsoluteSize.X + 5) + DropdownLib.ExtentSize, 0, math.min(UIListLayout.AbsoluteContentSize.Y + 5, 250));

					SetPosition();

					NeverLose.PlayAnimate(DropdownHandler , SlowyTween , {
						BackgroundTransparency = 0.035
					})

					if Config.AutoUpdate then
						DropdownLib:Generate();
					end;
				else

					NeverLose.PlayAnimate(DropdownHandler , SlowyTween , {
						BackgroundTransparency = 1
					})

					Shadow:Render(false);
				end;
			end);

			DropdownLib.SetFrameRender(false);
		end;

		local SecureSignal;
		NeverLose:CreateInput(Dropdown , LPH_NO_VIRTUALIZE(function()
			if SecureSignal then
				SecureSignal:Disconnect();
				SecureSignal = nil;
			end;

			DropdownLib.SetFrameRender(true);
			NeverLose.IsMosueOverOtherFrame = true;

			SecureSignal = UserInputService.InputBegan:Connect(function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					if not NeverLose:IsMouseOverFrame(DropdownLib.BlockRoot) and not NeverLose:IsMouseOverFrame(Dropdown) then
						if SecureSignal then
							SecureSignal:Disconnect();
							SecureSignal = nil;
						end;

						NeverLose.IsMosueOverOtherFrame = false;
						DropdownLib.SetFrameRender(false);
					end;
				end
			end)
		end))

		DropdownLib.IsMatch = LPH_NO_VIRTUALIZE(function(v1)
			if typeof(Config.Default) =='table' then
				if Config.Default[v1] or table.find(Config.Default , v1) then
					return true;
				end
			end

			if Config.Default == v1 then
				return true;
			end;
		end);

		function DropdownLib:Generate()
			for i,v in next , DropdownLib.RootItem:GetChildren() do
				if v:IsA('Frame') then
					v:Destroy();
				end;
			end;

			for i,v in next , DropdownLib.Signals do
				v:Disconnect();
			end;

			table.clear(DropdownLib.Signals);
			table.clear(DropdownLib.Refuse);

			local Lastone;
			for i,Value in next , Config.Values do
				local ItemFrame = Instance.new("Frame")
				local ItemLabel = Instance.new("TextLabel")
				local UICorner = Instance.new("UICorner")

				ItemFrame.Name = NeverLose.RandomString();
				ItemFrame.Parent = DropdownLib.RootItem
				ItemFrame.BackgroundColor3 = Color3.fromRGB(29, 31, 38)
				ItemFrame.BackgroundTransparency = 1.000
				ItemFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ItemFrame.BorderSizePixel = 0
				ItemFrame.Size = UDim2.new(1, 0, 0, 25)
				ItemFrame.ZIndex = ZINdex + 1258

				ItemLabel.Name = NeverLose.RandomString();
				ItemLabel.Parent = ItemFrame
				ItemLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ItemLabel.BackgroundTransparency = 1.000
				ItemLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ItemLabel.BorderSizePixel = 0
				ItemLabel.Position = UDim2.new(0, 15, 0, 4)
				ItemLabel.Size = UDim2.new(0,1, 0, 15)
				ItemLabel.ZIndex = ZINdex + 1258
				ItemLabel.Font = Enum.Font.GothamMedium
				ItemLabel.Text = tostring(Value);
				ItemLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
				ItemLabel.TextSize = 13.000
				ItemLabel.TextTransparency = 0.200
				ItemLabel.TextXAlignment = Enum.TextXAlignment.Left

				UICorner.CornerRadius = UDim.new(0, 10)
				UICorner.Parent = ItemFrame
				local sizetext = TextService:GetTextSize(ItemLabel.Text , ItemLabel.TextSize,ItemLabel.Font,Vector2.new(math.huge,math.huge));

				DropdownLib.ExtentSize = math.max(DropdownLib.ExtentSize , sizetext.X);

				local MIcon , MarkItem = nil , nil;

				if Config.Multi then
					local Icon = Instance.new("TextLabel")

					Icon.Parent = ItemFrame;
					Icon.AnchorPoint = Vector2.new(0, 0.5)
					Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Icon.BackgroundTransparency = 1.000
					Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Icon.BorderSizePixel = 0
					Icon.Position = UDim2.new(0, 5, 0.5, 0)
					Icon.Size = UDim2.new(0, 20, 0, 20)
					Icon.ZIndex = ZINdex + 1259
					Icon.FontFace = NeverLose.BuiltInBold;
					Icon.Text = "check"
					Icon.TextColor3 = Color3.fromRGB(223, 223, 223)
					Icon.TextSize = 18.000
					Icon.TextTransparency = 1
					Icon.TextWrapped = true;

					local VisiblewOfMult = LPH_NO_VIRTUALIZE(function()
						if DropdownLib.IsMatch(Value) then
							NeverLose.PlayAnimate(ItemLabel , VSlowTween , {
								TextTransparency = 0.200,
								Position = UDim2.new(0, 30, 0, 4)
							})

							NeverLose.PlayAnimate(Icon , vs , {
								TextTransparency = 0.250
							})

							Lastone = ItemLabel;
						else

							NeverLose.PlayAnimate(Icon , SlowyTween , {
								TextTransparency = 1
							})

							NeverLose.PlayAnimate(ItemLabel , VSlowTween , {
								TextTransparency = 0.5,
								Position = UDim2.new(0, 15, 0, 4)
							})
						end;
					end);

					MIcon = Icon;
					MarkItem = VisiblewOfMult;
				else
					local DefaultVisible = LPH_NO_VIRTUALIZE(function()
						if DropdownLib.IsMatch(Value) then
							NeverLose.PlayAnimate(ItemLabel , SlowyTween , {
								TextTransparency = 0.200
							})

							Lastone = ItemLabel;
						else
							NeverLose.PlayAnimate(ItemLabel , SlowyTween , {
								TextTransparency = 0.5
							})
						end;
					end);

					MarkItem = DefaultVisible;
				end;

				MarkItem();

				table.insert(DropdownLib.Refuse , MarkItem)

				table.insert(DropdownLib.Signals,ItemFrame.MouseEnter:Connect(LPH_NO_VIRTUALIZE(function()
					NeverLose.PlayAnimate(ItemFrame , SlowyTween , {
						BackgroundTransparency = 0.1
					})
				end)));

				table.insert(DropdownLib.Signals,ItemFrame.MouseLeave:Connect(LPH_NO_VIRTUALIZE(function()
					NeverLose.PlayAnimate(ItemFrame , SlowyTween , {
						BackgroundTransparency = 1
					})
				end)));

				table.insert(DropdownLib.Signals , DropdownLib.OpenSignal:Connect(LPH_NO_VIRTUALIZE(function(val)
					if val then
						MarkItem();
					else
						NeverLose.PlayAnimate(ItemLabel , SlowyTween , {
							TextTransparency = 1
						})

						if MIcon then
							NeverLose.PlayAnimate(MIcon , SlowyTween , {
								TextTransparency = 1
							})
						end;
					end;
				end)));

				if Config.Multi then
					local _,bth_signal = NeverLose:CreateInput(ItemFrame , LPH_NO_VIRTUALIZE(function()
						Config.Default[Value] = not Config.Default[Value];

						MarkItem();

						BasedLabel.Text = NeverLose.ParseDropdown(Config.Default);

						Config.Callback(Config.Default);
					end));

					table.insert(DropdownLib.Signals , bth_signal);
				else
					local _,bth_signal = NeverLose:CreateInput(ItemFrame , LPH_NO_VIRTUALIZE(function()
						Config.Default = Value;

						for i,v in next , DropdownLib.Refuse do
							task.spawn(v);
						end;

						BasedLabel.Text = NeverLose.ParseDropdown(Config.Default);

						Config.Callback(Config.Default);
					end));

					table.insert(DropdownLib.Signals , bth_signal);
				end;
			end;
		end;

		DropdownLib:Generate();

		function DropdownLib:GetValue()
			return Config.Default;
		end;

		function DropdownLib:SetValue(v)
			Config.Default = v;

			BasedLabel.Text = NeverLose.ParseDropdown(Config.Default);

			for i,v in next , DropdownLib.Refuse do
				task.spawn(v);
			end;

			Config.Callback(Config.Default);
		end;

		function DropdownLib:SetValues(a)
			Config.Values = a;

			if not Config.AutoUpdate then
				DropdownLib:Generate();
			end;
		end;

		if Config.Flag then
			NeverLose.Flags[Config.Flag] = DropdownLib;
		end;

		return DropdownLib;
	end;

	return handle;
end;

NeverLose.ProcessDropdown = LPH_NO_VIRTUALIZE(function(value)
	if typeof(value) == 'table' then
		local data = {};

		for i,v in next , value do
			if typeof(v) == 'boolean' and typeof(i) ~= 'number' then
				data[i] = v;
			else
				data[v] = true;
			end;
		end;

		return data;
	else
		return value;
	end;
end);

NeverLose.ParseDropdown = LPH_NO_VIRTUALIZE(function(value)
	if not value then return 'Select'; end;

	local Out;

	if typeof(value) == 'table' then
		if #value > 0 then
			local x = {};

			for i,v in next , value do
				table.insert(x , tostring(v))
			end;

			Out = table.concat(x,' , ');

			table.clear(x);
		else
			local x = {};

			for i,v in next , value do
				if v == true then
					table.insert(x , tostring(i));
				end			
			end;

			Out = table.concat(x,' , ');

			table.clear(x)

			if not Out:byte() then
				Out = 'Select';
			end
		end;
	else
		Out = tostring(value or 'Select');
	end;

	return Out;
end);

function NeverLose:ParseInput(Value , Numeric)
	if not Value then
		return (Numeric and nil) or "";	
	end;

	if Numeric then
		local out = string.gsub(tostring(Value), '[^0-9.%-]', '')

		if tonumber(out) then
			return tonumber(out);
		end;

		return nil;
	end;

	return Value;
end;

function NeverLose:CreateToolTips(Container: Frame , Name: string , Content: string)
	local Tooltips = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local UIStroke = Instance.new("UIStroke")
	local TooltipName = Instance.new("TextLabel")
	local TooltipContent = Instance.new("TextLabel")
	local Shadow = NeverLose:CreateShadow(Tooltips);

	Tooltips.Name = NeverLose.RandomString();
	Tooltips.BackgroundColor3 = Color3.fromRGB(20, 22, 27)
	Tooltips.BackgroundTransparency = 0.075
	Tooltips.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Tooltips.BorderSizePixel = 0
	Tooltips.ClipsDescendants = true
	Tooltips.Position = UDim2.new(255,255,255,255)
	Tooltips.Size = UDim2.new(0,0,0,0)
	Tooltips.ZIndex = 130

	UICorner.CornerRadius = UDim.new(0, 10)
	UICorner.Parent = Tooltips

	UIStroke.Transparency = 0.650
	UIStroke.Color = Color3.fromRGB(45, 48, 58)
	UIStroke.Parent = Tooltips

	TooltipName.Name = NeverLose.RandomString();
	TooltipName.Parent = Tooltips
	TooltipName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TooltipName.BackgroundTransparency = 1.000
	TooltipName.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TooltipName.BorderSizePixel = 0
	TooltipName.Position = UDim2.new(0, 15, 0, 5)
	TooltipName.Size = UDim2.new(0, 1, 0, 20)
	TooltipName.ZIndex = 132
	TooltipName.Font = Enum.Font.GothamBold
	TooltipName.Text = Name
	TooltipName.TextColor3 = Color3.fromRGB(255, 255, 255)
	TooltipName.TextSize = 15.000
	TooltipName.TextXAlignment = Enum.TextXAlignment.Left

	TooltipContent.Name = NeverLose.RandomString();
	TooltipContent.Parent = Tooltips
	TooltipContent.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TooltipContent.BackgroundTransparency = 1.000
	TooltipContent.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TooltipContent.BorderSizePixel = 0
	TooltipContent.Position = UDim2.new(0, 15, 0, 30)
	TooltipContent.Size = UDim2.new(0, 1, 0, 15)
	TooltipContent.ZIndex = 132
	TooltipContent.Font = Enum.Font.GothamBold
	TooltipContent.Text = Content
	TooltipContent.TextColor3 = Color3.fromRGB(255, 255, 255)
	TooltipContent.TextSize = 12.000
	TooltipContent.TextTransparency = 0.650
	TooltipContent.TextXAlignment = Enum.TextXAlignment.Left
	TooltipContent.TextYAlignment = Enum.TextYAlignment.Top

	local ToolTip = {};

	ToolTip.Update = LPH_NO_VIRTUALIZE(function()
		local SizeName = TextService:GetTextSize(TooltipName.Text , TooltipName.TextSize , TooltipName.Font , Vector2.new(math.huge,math.huge));
		local SizeContent = TextService:GetTextSize(TooltipContent.Text , TooltipContent.TextSize , TooltipContent.Font , Vector2.new(math.huge,math.huge));

		local MaxX = math.max(SizeName.X , SizeContent.X) + 65;
		local MaxY = SizeName.Y + SizeContent.Y + 30;

		NeverLose.PlayAnimate(Tooltips,SlowyTween , {
			Size = UDim2.new(0,MaxX,0,MaxY)
		})
	end)

	NeverLose:AddSignal(Tooltips:GetPropertyChangedSignal('BackgroundTransparency'):Connect(LPH_NO_VIRTUALIZE(function()
		if Tooltips.BackgroundTransparency > 0.9 then
			Tooltips.Visible = false;
			Tooltips.Parent = nil;
		else
			Tooltips.Visible = true;

			if NeverLose.Global3DRenderMode then
				Tooltips.Parent = NeverLose.GlobalSurfaceGui;
			else
				Tooltips.Parent = NeverLose.ScreenGui;
			end;
		end
	end)));

	ToolTip.SetRender = LPH_NO_VIRTUALIZE(function(value)
		if value then
			Tooltips.Position = UDim2.fromOffset(Container.AbsolutePosition.X + Container.AbsoluteSize.X , Container.AbsolutePosition.Y + (Container.AbsoluteSize.Y + 25));

			NeverLose.PlayAnimate(Tooltips , SlowyTween , {
				BackgroundTransparency = 0.075
			})

			NeverLose.PlayAnimate(UIStroke , SlowyTween , {
				Transparency = 0.650
			})

			NeverLose.PlayAnimate(TooltipName , SlowyTween , {
				TextTransparency = 0
			})

			NeverLose.PlayAnimate(TooltipContent , SlowyTween , {
				TextTransparency = 0.650
			})

			ToolTip.Update();
			Shadow:Render(true);
		else
			NeverLose.PlayAnimate(Tooltips , SlowyTween , {
				BackgroundTransparency = 1
			})

			NeverLose.PlayAnimate(UIStroke , SlowyTween , {
				Transparency = 1
			})

			NeverLose.PlayAnimate(TooltipName , SlowyTween , {
				TextTransparency = 1
			})

			NeverLose.PlayAnimate(TooltipContent , SlowyTween , {
				TextTransparency = 1
			})

			Shadow:Render(false);
		end;
	end);

	ToolTip.SetRender(false);
	ToolTip.Update();

	local DelayThread;
	NeverLose:AddSignal(Container.MouseEnter:Connect(LPH_NO_VIRTUALIZE(function()
		if DelayThread then
			task.cancel(DelayThread);
			DelayThread = nil;
		end;

		DelayThread = task.delay(1,ToolTip.SetRender,true);
	end)));

	NeverLose:AddSignal(Container.MouseLeave:Connect(LPH_NO_VIRTUALIZE(function()
		if DelayThread then
			task.cancel(DelayThread);
			DelayThread = nil;
		end;

		ToolTip.SetRender(false);
		ToolTip.Update();
	end)))

	return ToolTip;
end;

function NeverLose:RegisiterItem(Frame: Frame , Signel)
	local idx = {Frame = Frame};
	local LayerIndex = Frame.ZIndex;

	function idx:AddLabel(Name: string,Warp: boolean)
		local BasedFrame = Instance.new("Frame")
		local BasedLabel = Instance.new("TextLabel")
		local LineFrame = Instance.new("Frame")
		local BasedHandler = Instance.new("Frame")
		local UIListLayout = Instance.new("UIListLayout")
		local UICorner = Instance.new("UICorner")

		BasedFrame.Name = NeverLose.RandomString();
		BasedFrame.Parent = Frame
		BasedFrame.BackgroundColor3 = Color3.fromRGB(25, 27, 33)
		BasedFrame.BackgroundTransparency = 1.000
		BasedFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BasedFrame.BorderSizePixel = 0
		BasedFrame.Size = UDim2.new(1, 0, 0, 30)
		BasedFrame.ZIndex = LayerIndex + 8

		NeverLose:AddQuery(BasedFrame , Name);

		BasedLabel.Name = NeverLose.RandomString();
		BasedLabel.Parent = BasedFrame
		BasedLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		BasedLabel.BackgroundTransparency = 1.000
		BasedLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BasedLabel.BorderSizePixel = 0
		BasedLabel.Position = UDim2.new(0, 11, 0, 6)
		BasedLabel.Size = UDim2.new(0,1, 0, 15)
		BasedLabel.ZIndex = LayerIndex + 9
		BasedLabel.Font = Enum.Font.GothamMedium
		BasedLabel.Text = Name
		BasedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		BasedLabel.TextSize = 13.000
		BasedLabel.TextTransparency = 0.35
		BasedLabel.TextXAlignment = Enum.TextXAlignment.Left

		LineFrame.Name = NeverLose.RandomString();
		LineFrame.Parent = BasedFrame
		LineFrame.AnchorPoint = Vector2.new(0.5, 1)
		LineFrame.BackgroundColor3 = Color3.fromRGB(45, 48, 58)
		LineFrame.BackgroundTransparency = 0.650
		LineFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		LineFrame.BorderSizePixel = 0
		LineFrame.Position = UDim2.new(0.5, 0, 1, 0)
		LineFrame.Size = UDim2.new(1, -20, 0, 1)
		LineFrame.ZIndex = LayerIndex + 11

		BasedHandler.Name = NeverLose.RandomString();
		BasedHandler.Parent = BasedFrame
		BasedHandler.AnchorPoint = Vector2.new(1, 0)
		BasedHandler.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		BasedHandler.BackgroundTransparency = 1.000
		BasedHandler.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BasedHandler.BorderSizePixel = 0
		BasedHandler.Position = UDim2.new(1, -11, 0, 2)
		BasedHandler.Size = UDim2.new(1, -20, 0, 25)
		BasedHandler.ZIndex = LayerIndex + 12

		UIListLayout.Parent = BasedHandler
		UIListLayout.FillDirection = Enum.FillDirection.Horizontal
		UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
		UIListLayout.Padding = UDim.new(0, 5)

		UICorner.CornerRadius = UDim.new(0, 10)
		UICorner.Parent = BasedFrame

		local UpdateWarp = LPH_NO_VIRTUALIZE(function()
			local size = TextService:GetTextSize(BasedLabel.Text , BasedLabel.TextSize , BasedLabel.Font , Vector2.new(math.huge,math.huge));
			NeverLose.PlayAnimate(BasedFrame , SlowyTween , {
				Size = UDim2.new(1, 0, 0, size.Y + 13);
			})

			BasedLabel.Size = UDim2.new(1, -35, 1, 0)
			BasedLabel.TextYAlignment = Enum.TextYAlignment.Top;
		end);

		if Warp then
			UpdateWarp();
		end;

		local handle = NeverLose:RegisiterHandler(BasedHandler , Signel);

		handle.Root = BasedFrame;

		handle.SetRender = LPH_NO_VIRTUALIZE(function(value)
			if value then
				NeverLose.PlayAnimate(BasedFrame , SlowyTween , {
					BackgroundTransparency = 1
				});

				NeverLose.PlayAnimate(BasedLabel , SlowyTween , {
					TextTransparency = 0.35
				})

				NeverLose.PlayAnimate(LineFrame , SlowyTween , {
					BackgroundTransparency = 0.650
				})
			else
				NeverLose.PlayAnimate(BasedFrame , SlowyTween , {
					BackgroundTransparency = 1
				});

				NeverLose.PlayAnimate(BasedLabel , SlowyTween , {
					TextTransparency = 1
				})

				NeverLose.PlayAnimate(LineFrame , SlowyTween , {
					BackgroundTransparency = 1
				})
			end;
		end);

		function handle:SetVisible(val)
			BasedFrame.Visible = val;
		end;

		NeverLose:AddSignal(BasedFrame.MouseEnter:Connect(LPH_NO_VIRTUALIZE(function()
			NeverLose.PlayAnimate(BasedFrame , SlowyTween , {
				BackgroundTransparency = 0.35
			});

			NeverLose.PlayAnimate(BasedLabel , SlowyTween , {
				TextTransparency = 0.25
			})

		end)))

		NeverLose:AddSignal(BasedFrame.MouseLeave:Connect(LPH_NO_VIRTUALIZE(function()
			NeverLose.PlayAnimate(BasedFrame , SlowyTween , {
				BackgroundTransparency = 1
			});

			NeverLose.PlayAnimate(BasedLabel , SlowyTween , {
				TextTransparency = 0.35
			})
		end)))

		function handle:SetText(t)
			local oldtxt = BasedLabel.Text;

			BasedLabel.Text = t;

			if Warp and oldtxt ~= t then
				UpdateWarp();
			end;
		end;

		function handle:ToolTip(Content: string)
			handle.ToolTip = NeverLose:CreateToolTips(BasedFrame , Name , Content);

			return handle;
		end;

		handle.SetRender(Signel:GetValue());
		Signel:Connect(handle.SetRender);

		return handle;
	end;

	function idx:AddButton(Config)
		Config = NeverLose:ProcessParams(Config , {
			Icon = 'chevron-large-left',
			Name = "Button",
			Callback = EmptyFunction,
			ToolTip = nil,
		});

		local Button = {};
		local ButtonFrame = Instance.new("Frame")
		local BasedLabel = Instance.new("TextLabel")
		local LineFrame = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local Icon = Instance.new("TextLabel")

		NeverLose:AddQuery(ButtonFrame , Config.Name);

		ButtonFrame.Name = NeverLose.RandomString();
		ButtonFrame.Parent = Frame
		ButtonFrame.BackgroundColor3 = Color3.fromRGB(25, 27, 33)
		ButtonFrame.BackgroundTransparency = 1.000
		ButtonFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ButtonFrame.BorderSizePixel = 0
		ButtonFrame.Size = UDim2.new(1, 0, 0, 30)
		ButtonFrame.ZIndex = LayerIndex + 8

		BasedLabel.Name = NeverLose.RandomString();
		BasedLabel.Parent = ButtonFrame
		BasedLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		BasedLabel.BackgroundTransparency = 1.000
		BasedLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BasedLabel.BorderSizePixel = 0
		BasedLabel.Position = UDim2.new(0, 35, 0, 6)
		BasedLabel.Size = UDim2.new(0,1, 0, 15)
		BasedLabel.ZIndex = LayerIndex + 9
		BasedLabel.Font = Enum.Font.GothamMedium
		BasedLabel.Text = Config.Name;
		BasedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		BasedLabel.TextSize = 13.000
		BasedLabel.TextTransparency = 0.200
		BasedLabel.TextXAlignment = Enum.TextXAlignment.Left

		LineFrame.Name = NeverLose.RandomString();
		LineFrame.Parent = ButtonFrame
		LineFrame.AnchorPoint = Vector2.new(0.5, 1)
		LineFrame.BackgroundColor3 = Color3.fromRGB(45, 48, 58)
		LineFrame.BackgroundTransparency = 0.650
		LineFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		LineFrame.BorderSizePixel = 0
		LineFrame.Position = UDim2.new(0.5, 0, 1, 0)
		LineFrame.Size = UDim2.new(1, -20, 0, 1)
		LineFrame.ZIndex = LayerIndex + 11

		UICorner.CornerRadius = UDim.new(0, 10)
		UICorner.Parent = ButtonFrame

		Icon.Name = NeverLose.RandomString();
		Icon.Parent = ButtonFrame
		Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Icon.BackgroundTransparency = 1.000
		Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Icon.BorderSizePixel = 0
		Icon.Position = UDim2.new(0, 11, 0, 5)
		Icon.Size = UDim2.new(0, 18, 0, 18)
		Icon.ZIndex = LayerIndex + 9
		Icon.FontFace = NeverLose.BuiltInBold
		Icon.Text = Config.Icon
		Icon.TextColor3 = Color3.fromRGB(223, 223, 223)
		Icon.TextSize = 16.000
		Icon.TextTransparency = 0.250
		Icon.TextWrapped = true

		function Button:SetText(t)
			BasedLabel.Text = t;
		end;

		function Button:SetIcon(t)
			Icon.Text = t
		end;

		local bth = NeverLose:CreateInput(ButtonFrame , LPH_NO_VIRTUALIZE(function()
			Config.Callback();
		end));

		NeverLose:AddSignal(bth.MouseEnter:Connect(LPH_NO_VIRTUALIZE(function()
			NeverLose.PlayAnimate(ButtonFrame , SlowyTween , {
				BackgroundTransparency = 0.35
			});
		end)))

		NeverLose:AddSignal(bth.MouseLeave:Connect(LPH_NO_VIRTUALIZE(function()
			NeverLose.PlayAnimate(ButtonFrame , SlowyTween , {
				BackgroundTransparency = 1
			});
		end)))

		Button.SetRender = LPH_NO_VIRTUALIZE(function(value)
			if value then
				NeverLose.PlayAnimate(ButtonFrame , SlowyTween , {
					BackgroundTransparency = 1
				});

				NeverLose.PlayAnimate(BasedLabel , SlowyTween , {
					TextTransparency = 0.200
				});

				NeverLose.PlayAnimate(LineFrame , SlowyTween , {
					BackgroundTransparency = 0.650
				});

				NeverLose.PlayAnimate(Icon , SlowyTween , {
					TextTransparency = 0.250
				});
			else
				NeverLose.PlayAnimate(ButtonFrame , SlowyTween , {
					BackgroundTransparency = 1
				});

				NeverLose.PlayAnimate(BasedLabel , SlowyTween , {
					TextTransparency = 1
				});

				NeverLose.PlayAnimate(LineFrame , SlowyTween , {
					BackgroundTransparency = 1
				});

				NeverLose.PlayAnimate(Icon , SlowyTween , {
					TextTransparency = 1
				});
			end;
		end);

		if Config.ToolTip then
			Button.ToolTip = NeverLose:CreateToolTips(ButtonFrame , Config.Name , Config.ToolTip);
		end;

		Button.SetRender(Signel:GetValue())
		Signel:Connect(Button.SetRender);

		return Button;
	end;

	function idx:AddUserFrame(Name : string , Profile: string , Expires : string)
		local UserFrame = Instance.new("Frame")
		local UserLabel = Instance.new("TextLabel")
		local LineFrame = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local LogoImage = Instance.new("ImageLabel")
		local UICorner_2 = Instance.new("UICorner")
		local UserStatusLabel = Instance.new("TextLabel")

		UserFrame.Name = NeverLose.RandomString();
		UserFrame.Parent = Frame
		UserFrame.BackgroundColor3 = Color3.fromRGB(25, 27, 33)
		UserFrame.BackgroundTransparency = 1.000
		UserFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		UserFrame.BorderSizePixel = 0
		UserFrame.Size = UDim2.new(1, 0, 0, 60)
		UserFrame.ZIndex = LayerIndex + 8

		UserLabel.Name = NeverLose.RandomString();
		UserLabel.Parent = UserFrame
		UserLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		UserLabel.BackgroundTransparency = 1.000
		UserLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		UserLabel.BorderSizePixel = 0
		UserLabel.Position = UDim2.new(0, 65, 0, 10)
		UserLabel.Size = UDim2.new(1, -35, 0, 15)
		UserLabel.ZIndex = LayerIndex + 9
		UserLabel.Font = Enum.Font.GothamMedium
		UserLabel.Text = Name or 'User'
		UserLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		UserLabel.TextSize = 13.000
		UserLabel.TextTransparency = 0.200
		UserLabel.TextXAlignment = Enum.TextXAlignment.Left

		LineFrame.Name = NeverLose.RandomString();
		LineFrame.Parent = UserFrame
		LineFrame.AnchorPoint = Vector2.new(0.5, 1)
		LineFrame.BackgroundColor3 = Color3.fromRGB(45, 48, 58)
		LineFrame.BackgroundTransparency = 0.650
		LineFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		LineFrame.BorderSizePixel = 0
		LineFrame.Position = UDim2.new(0.5, 0, 1, 0)
		LineFrame.Size = UDim2.new(1, -20, 0, 1)
		LineFrame.ZIndex = LayerIndex + 11

		UICorner.CornerRadius = UDim.new(0, 10)
		UICorner.Parent = UserFrame

		LogoImage.Name = NeverLose.RandomString();
		LogoImage.Parent = UserFrame
		LogoImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		LogoImage.BackgroundTransparency = 1.000
		LogoImage.BorderColor3 = Color3.fromRGB(0, 0, 0)
		LogoImage.BorderSizePixel = 0
		LogoImage.Position = UDim2.new(0, 10, 0, 5)
		LogoImage.Size = UDim2.new(0, 45, 0, 45)
		LogoImage.ZIndex = LayerIndex + 9
		LogoImage.Image = Profile or "rbxasset://textures/ui/clb_robux_20@3x.png";

		UICorner_2.CornerRadius = UDim.new(1, 0)
		UICorner_2.Parent = LogoImage

		UserStatusLabel.Name = NeverLose.RandomString();
		UserStatusLabel.Parent = UserFrame
		UserStatusLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		UserStatusLabel.BackgroundTransparency = 1.000
		UserStatusLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		UserStatusLabel.BorderSizePixel = 0
		UserStatusLabel.Position = UDim2.new(0, 65, 0, 25)
		UserStatusLabel.Size = UDim2.new(1, -35, 0, 15)
		UserStatusLabel.ZIndex = LayerIndex + 9
		UserStatusLabel.Font = Enum.Font.GothamMedium
		UserStatusLabel.Text = Expires or 'Never'
		UserStatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		UserStatusLabel.TextSize = 13.000
		UserStatusLabel.TextTransparency = 0.200
		UserStatusLabel.TextXAlignment = Enum.TextXAlignment.Left

		local UserFrameItem = {};

		UserFrameItem.SetRender = LPH_NO_VIRTUALIZE(function(value)
			if value then
				NeverLose.PlayAnimate(UserLabel,SlowyTween,{
					TextTransparency = 0.200
				})

				NeverLose.PlayAnimate(LineFrame,SlowyTween,{
					BackgroundTransparency = 0.650
				})

				NeverLose.PlayAnimate(LogoImage,SlowyTween,{
					ImageTransparency = 0
				})

				NeverLose.PlayAnimate(UserStatusLabel,SlowyTween,{
					TextTransparency = 0.200
				})
			else
				NeverLose.PlayAnimate(UserLabel,SlowyTween,{
					TextTransparency = 1
				})

				NeverLose.PlayAnimate(LineFrame,SlowyTween,{
					BackgroundTransparency = 1
				})

				NeverLose.PlayAnimate(LogoImage,SlowyTween,{
					ImageTransparency = 1
				})

				NeverLose.PlayAnimate(UserStatusLabel,SlowyTween,{
					TextTransparency = 1
				})
			end;
		end);

		UserFrameItem.SetRender(Signel:GetValue())
		Signel:Connect(UserFrameItem.SetRender);

		function UserFrameItem:SetUsername(name)
			UserLabel.Text = name or 'User'
		end;

		function UserFrameItem:SetProfile(Profile)
			LogoImage.Image = Profile or "rbxasset://textures/ui/clb_robux_20@3x.png";
		end;

		function UserFrameItem:SetExpires(Exp)
			UserStatusLabel.Text = Exp or 'Never';
		end;

		return UserFrameItem;
	end;

	return idx;
end;

function NeverLose:CreateWindow(Config)
	Config = NeverLose:ProcessParams(Config , {
		Logo = NeverLose.GlobalLogo,
		Name = "Neverlose",
		Content = "Counter-Strike 2",
		Size = UDim2.new(0, 640, 0, 480),
		ConfigFolder = "NeverLoseConfigs",
		Enable3DRenderer = false,
		Keybind = "Insert"
	});

	local Window = {
		Logo = Config.Logo,
		Name = Config.Name,
		Content = Config.Content,
		Size = Config.Size,
		ConfigFolder = Config.ConfigFolder,
		Signal = NeverLose:CreateSignal(true),
		Tabs = {},
		CurrentTab = 1,
		Keybind = Config.Keybind,
		Enable3DRenderer = Config.Enable3DRenderer
	};

	NeverLose.GlobalLogo = Window.Logo;

	local Logging = NeverLose:CreateLogger();
	if not isfolder(Window.ConfigFolder) then
		makefolder(Window.ConfigFolder);
	end;

	local WindowFrame = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local LeftMenuFrame = Instance.new("Frame")
	local HeadFrame = Instance.new("Frame")
	local LogoImage = Instance.new("ImageLabel")
	local UICorner_2 = Instance.new("UICorner")
	local WindowName = Instance.new("TextLabel")
	local WindowContent = Instance.new("TextLabel")
	local LineFrame = Instance.new("Frame")
	local LeftScrollingFrame = Instance.new("ScrollingFrame")
	local UIListLayout = Instance.new("UIListLayout")
	local BottomFrame = Instance.new("Frame")
	local AccountProfile = Instance.new("ImageLabel")
	local UICorner_3 = Instance.new("UICorner")
	local AccountName = Instance.new("TextLabel")
	local ExpireLabel = Instance.new("TextLabel")
	local LineFrame_2 = Instance.new("Frame")
	local UserSettingButton = Instance.new("TextLabel")
	local RightMenuFrame = Instance.new("Frame")
	local UIStroke = Instance.new("UIStroke")
	local UICorner_4 = Instance.new("UICorner")
	local RightHeader = Instance.new("Frame")
	local LineFrame_3 = Instance.new("Frame")
	local ConfigFrame = Instance.new("Frame")
	local UIStroke_2 = Instance.new("UIStroke")
	local UICorner_5 = Instance.new("UICorner")
	local ConfigIcon = Instance.new("TextLabel")
	local LineFrame_4 = Instance.new("Frame")
	local ConfigName = Instance.new("TextLabel")
	local ConfigBthIcon = Instance.new("TextLabel")
	local SearchFrame = Instance.new("Frame")
	local SearchIcon = Instance.new("TextLabel")
	local SearchBox = Instance.new("TextBox")
	local TabContainer = Instance.new("Frame")

	WindowFrame.Name = NeverLose.RandomString();
	WindowFrame.Parent = NeverLose.ScreenGui;
	WindowFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	WindowFrame.BackgroundColor3 = Color3.fromRGB(8, 8, 13)
	WindowFrame.BackgroundTransparency = 0.055
	WindowFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	WindowFrame.BorderSizePixel = 0
	WindowFrame.ClipsDescendants = true
	WindowFrame.Position = UDim2.new(255, 0, 255, 0)
	WindowFrame.Size = Window.Size
	WindowFrame.Active = true;

	if not NeverLose.EnabledBlur then
		WindowFrame.BackgroundTransparency = 0.0255
	end;

	local renderParentWindow = LPH_NO_VIRTUALIZE(function()
		if Window.__3DRender then
			if WindowFrame.BackgroundTransparency > 0.9 then
				WindowFrame.Visible = false;
				WindowFrame.Parent = nil
			else
				WindowFrame.Visible = true;

				NeverLose.PlayAnimate(WindowFrame,VSlowTween , {
					Position = UDim2.fromScale(0.5,0.5);
				});

				WindowFrame.Parent = Window.SurfaceGui;
			end;
		else
			if WindowFrame.BackgroundTransparency > 0.9 then
				WindowFrame.Visible = false;
				WindowFrame.Parent = nil
			else
				WindowFrame.Visible = true;
				WindowFrame.Parent = NeverLose.ScreenGui


			end;
		end;
	end);

	NeverLose:AddSignal(WindowFrame:GetPropertyChangedSignal('BackgroundTransparency'):Connect(renderParentWindow))

	Window.SetRender = LPH_NO_VIRTUALIZE(function(self , value)
		if value then
			NeverLose.PlayAnimate(WindowFrame , SlowyTween , {
				BackgroundTransparency = (NeverLose.EnabledBlur and 0.055) or 0.0255,
				Size = Window.Size
			})

			NeverLose.PlayAnimate(LogoImage , SlowyTween , {
				ImageTransparency = 0
			})

			NeverLose.PlayAnimate(WindowName , SlowyTween , {
				TextTransparency = 0
			})

			NeverLose.PlayAnimate(WindowContent , SlowyTween , {
				TextTransparency = 0.650
			})

			NeverLose.PlayAnimate(LineFrame , SlowyTween , {
				BackgroundTransparency = 0.650
			})

			NeverLose.PlayAnimate(AccountProfile , SlowyTween , {
				ImageTransparency = 0
			})

			NeverLose.PlayAnimate(AccountName , SlowyTween , {
				TextTransparency = 0
			})

			NeverLose.PlayAnimate(ExpireLabel , SlowyTween , {
				TextTransparency = 0.650
			})

			NeverLose.PlayAnimate(LineFrame_2 , SlowyTween , {
				BackgroundTransparency = 0.650
			})

			NeverLose.PlayAnimate(UserSettingButton , SlowyTween , {
				TextTransparency = 0.5
			})

			NeverLose.PlayAnimate(RightMenuFrame , SlowyTween , {
				BackgroundTransparency = 0.600
			})

			NeverLose.PlayAnimate(UIStroke , SlowyTween , {
				Transparency = 0.650
			})

			NeverLose.PlayAnimate(LineFrame_3 , SlowyTween , {
				BackgroundTransparency = 0.650
			})

			NeverLose.PlayAnimate(ConfigFrame , SlowyTween , {
				BackgroundTransparency = 0.750
			})

			NeverLose.PlayAnimate(UIStroke_2 , SlowyTween , {
				Transparency = 0.650
			})

			NeverLose.PlayAnimate(ConfigIcon , SlowyTween , {
				TextTransparency = 0.250
			})

			NeverLose.PlayAnimate(LineFrame_4 , SlowyTween , {
				BackgroundTransparency = 0.650
			})

			NeverLose.PlayAnimate(ConfigName , SlowyTween , {
				TextTransparency = 0.350
			})

			NeverLose.PlayAnimate(ConfigBthIcon , SlowyTween , {
				TextTransparency = 0.250
			})

			NeverLose.PlayAnimate(SearchIcon , SlowyTween , {
				TextTransparency = 0.250
			})

			NeverLose.PlayAnimate(SearchBox , SlowyTween , {
				TextTransparency = 0.350
			})

			Window.Shadow:Render(true);
		else

			NeverLose.PlayAnimate(WindowFrame , SlowyTween , {
				BackgroundTransparency = 1,
				Size = Window.Size + UDim2.fromOffset(-15,-15)
			})

			NeverLose.PlayAnimate(LogoImage , SlowyTween , {
				ImageTransparency = 1
			})

			NeverLose.PlayAnimate(WindowName , SlowyTween , {
				TextTransparency = 1
			})

			NeverLose.PlayAnimate(WindowContent , SlowyTween , {
				TextTransparency = 1
			})

			NeverLose.PlayAnimate(LineFrame , SlowyTween , {
				BackgroundTransparency = 1
			})

			NeverLose.PlayAnimate(AccountProfile , SlowyTween , {
				ImageTransparency = 1
			})

			NeverLose.PlayAnimate(AccountName , SlowyTween , {
				TextTransparency = 1
			})

			NeverLose.PlayAnimate(ExpireLabel , SlowyTween , {
				TextTransparency = 1
			})

			NeverLose.PlayAnimate(LineFrame_2 , SlowyTween , {
				BackgroundTransparency = 1
			})

			NeverLose.PlayAnimate(UserSettingButton , SlowyTween , {
				TextTransparency = 1
			})

			NeverLose.PlayAnimate(RightMenuFrame , SlowyTween , {
				BackgroundTransparency = 1
			})

			NeverLose.PlayAnimate(UIStroke , SlowyTween , {
				Transparency = 1
			})

			NeverLose.PlayAnimate(LineFrame_3 , SlowyTween , {
				BackgroundTransparency = 1
			})

			NeverLose.PlayAnimate(ConfigFrame , SlowyTween , {
				BackgroundTransparency = 1
			})

			NeverLose.PlayAnimate(UIStroke_2 , SlowyTween , {
				Transparency = 1
			})

			NeverLose.PlayAnimate(ConfigIcon , SlowyTween , {
				TextTransparency = 1
			})

			NeverLose.PlayAnimate(LineFrame_4 , SlowyTween , {
				BackgroundTransparency = 1
			})

			NeverLose.PlayAnimate(ConfigName , SlowyTween , {
				TextTransparency = 1
			})

			NeverLose.PlayAnimate(ConfigBthIcon , SlowyTween , {
				TextTransparency = 1
			})

			NeverLose.PlayAnimate(SearchIcon , SlowyTween , {
				TextTransparency = 1
			})

			NeverLose.PlayAnimate(SearchBox , SlowyTween , {
				TextTransparency = 1
			})

			Window.Shadow:Render(false);
		end;
	end);

	Window.Shadow = NeverLose:CreateShadow(WindowFrame);
	Window.Shadow:Render(false);

	task.delay(0.25,function()
		WindowFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
		Window:SetRender(true);
		NeverLose:AddSignal(Window.Signal:Connect(LPH_NO_VIRTUALIZE(function(...)
			Window:SetRender(...);
		end)))
	end)

	if NeverLose.EnabledBlur then
		NeverLose:CreateBlurModule(WindowFrame,Window.Signal);
	end;

	do
		local Frame = Instance.new("Frame")

		Frame.Parent = WindowFrame
		Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Frame.BorderSizePixel = 0
		Frame.Size = UDim2.new(1, 0, 0, 50)
		Frame.ZIndex = 7
		Frame.BackgroundTransparency = 1;

		NeverLose.Drag(Frame , WindowFrame , 0.15)
	end

	UICorner.Parent = WindowFrame

	LeftMenuFrame.Name = NeverLose.RandomString();
	LeftMenuFrame.Parent = WindowFrame
	LeftMenuFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	LeftMenuFrame.BackgroundTransparency = 1.000
	LeftMenuFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	LeftMenuFrame.BorderSizePixel = 0
	LeftMenuFrame.Size = UDim2.new(0, 175, 1, 0)

	HeadFrame.Name = NeverLose.RandomString();
	HeadFrame.Parent = LeftMenuFrame
	HeadFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	HeadFrame.BackgroundTransparency = 1.000
	HeadFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	HeadFrame.BorderSizePixel = 0
	HeadFrame.Size = UDim2.new(1, 0, 0, 50)
	HeadFrame.ZIndex = 7

	LogoImage.Name = NeverLose.RandomString();
	LogoImage.Parent = HeadFrame
	LogoImage.AnchorPoint = Vector2.new(0, 0.5)
	LogoImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	LogoImage.BackgroundTransparency = 1.000
	LogoImage.BorderColor3 = Color3.fromRGB(0, 0, 0)
	LogoImage.BorderSizePixel = 0
	LogoImage.Position = UDim2.new(0, 10, 0.5, 0)
	LogoImage.Size = UDim2.new(0, 35, 0, 35)
	LogoImage.ZIndex = 7
	LogoImage.Image = Window.Logo
	LogoImage.ImageColor3 = NeverLose.IconColor

	UICorner_2.CornerRadius = UDim.new(0, 7)
	UICorner_2.Parent = LogoImage

	WindowName.Name = NeverLose.RandomString();
	WindowName.Parent = HeadFrame
	WindowName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	WindowName.BackgroundTransparency = 1.000
	WindowName.BorderColor3 = Color3.fromRGB(0, 0, 0)
	WindowName.BorderSizePixel = 0
	WindowName.Position = UDim2.new(0, 55, 0, 4)
	WindowName.Size = UDim2.new(0, 200, 0, 25)
	WindowName.ZIndex = 7
	WindowName.Font = Enum.Font.GothamBold
	WindowName.Text = Window.Name
	WindowName.TextColor3 = Color3.fromRGB(255, 255, 255)
	WindowName.TextSize = 18.000
	WindowName.TextXAlignment = Enum.TextXAlignment.Left

	WindowContent.Name = NeverLose.RandomString();
	WindowContent.Parent = HeadFrame
	WindowContent.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	WindowContent.BackgroundTransparency = 1.000
	WindowContent.BorderColor3 = Color3.fromRGB(0, 0, 0)
	WindowContent.BorderSizePixel = 0
	WindowContent.Position = UDim2.new(0, 55, 0, 25)
	WindowContent.Size = UDim2.new(0, 200, 0, 15)
	WindowContent.ZIndex = 7
	WindowContent.Font = Enum.Font.GothamBold
	WindowContent.Text = Window.Content
	WindowContent.TextColor3 = Color3.fromRGB(255, 255, 255)
	WindowContent.TextSize = 9.000
	WindowContent.TextTransparency = 0.650
	WindowContent.TextXAlignment = Enum.TextXAlignment.Left

	LineFrame.Name = NeverLose.RandomString();
	LineFrame.Parent = HeadFrame
	LineFrame.AnchorPoint = Vector2.new(0.5, 1)
	LineFrame.BackgroundColor3 = Color3.fromRGB(45, 48, 58)
	LineFrame.BackgroundTransparency = 0.650
	LineFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	LineFrame.BorderSizePixel = 0
	LineFrame.Position = UDim2.new(0.5, 0, 1, 0)
	LineFrame.Size = UDim2.new(1, -10, 0, 1)
	LineFrame.ZIndex = 5

	LeftScrollingFrame.Name = NeverLose.RandomString();
	LeftScrollingFrame.Parent = LeftMenuFrame
	LeftScrollingFrame.Active = true
	LeftScrollingFrame.AnchorPoint = Vector2.new(0.5, 0)
	LeftScrollingFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	LeftScrollingFrame.BackgroundTransparency = 1.000
	LeftScrollingFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	LeftScrollingFrame.BorderSizePixel = 0
	LeftScrollingFrame.Position = UDim2.new(0.5, 0, 0, 60)
	LeftScrollingFrame.Size = UDim2.new(1, -10, 1, -115)
	LeftScrollingFrame.ZIndex = 7
	LeftScrollingFrame.ScrollBarThickness = 0

	UIListLayout.Parent = LeftScrollingFrame
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 5)

	NeverLose:AddSignal(UIListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(LPH_NO_VIRTUALIZE(function()
		LeftScrollingFrame.CanvasSize = UDim2.fromOffset(0,UIListLayout.AbsoluteContentSize.Y + 1)
	end)))

	BottomFrame.Name = NeverLose.RandomString();
	BottomFrame.Parent = LeftMenuFrame
	BottomFrame.AnchorPoint = Vector2.new(0, 1)
	BottomFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	BottomFrame.BackgroundTransparency = 1.000
	BottomFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	BottomFrame.BorderSizePixel = 0
	BottomFrame.Position = UDim2.new(0, 0, 1, 0)
	BottomFrame.Size = UDim2.new(1, 0, 0, 50)
	BottomFrame.ZIndex = 7

	AccountProfile.Name = NeverLose.RandomString();
	AccountProfile.Parent = BottomFrame
	AccountProfile.AnchorPoint = Vector2.new(0, 0.5)
	AccountProfile.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	AccountProfile.BackgroundTransparency = 1.000
	AccountProfile.BorderColor3 = Color3.fromRGB(0, 0, 0)
	AccountProfile.BorderSizePixel = 0
	AccountProfile.Position = UDim2.new(0, 10, 0.5, 0)
	AccountProfile.Size = UDim2.new(0, 35, 0, 35)
	AccountProfile.ZIndex = 7
	AccountProfile.Image = NeverLose.UserProfile or ""

	UICorner_3.CornerRadius = UDim.new(1, 0)
	UICorner_3.Parent = AccountProfile

	AccountName.Name = NeverLose.RandomString();
	AccountName.Parent = BottomFrame
	AccountName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	AccountName.BackgroundTransparency = 1.000
	AccountName.BorderColor3 = Color3.fromRGB(0, 0, 0)
	AccountName.BorderSizePixel = 0
	AccountName.Position = UDim2.new(0, 55, 0, 5)
	AccountName.Size = UDim2.new(0, 100, 0, 25)
	AccountName.ZIndex = 7
	AccountName.Font = Enum.Font.GothamBold
	AccountName.Text = ""
	AccountName.TextColor3 = Color3.fromRGB(255, 255, 255)
	AccountName.TextSize = 14.000
	AccountName.TextXAlignment = Enum.TextXAlignment.Left
	AccountName.TextTruncate = Enum.TextTruncate.SplitWord;

	ExpireLabel.Name = NeverLose.RandomString();
	ExpireLabel.Parent = BottomFrame
	ExpireLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ExpireLabel.BackgroundTransparency = 1.000
	ExpireLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ExpireLabel.BorderSizePixel = 0
	ExpireLabel.Position = UDim2.new(0, 55, 0, 25)
	ExpireLabel.Size = UDim2.new(0, 200, 0, 15)
	ExpireLabel.ZIndex = 7
	ExpireLabel.Font = Enum.Font.GothamBold
	ExpireLabel.Text = "never"
	ExpireLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	ExpireLabel.TextSize = 10.000
	ExpireLabel.TextTransparency = 0.650
	ExpireLabel.TextXAlignment = Enum.TextXAlignment.Left

	LineFrame_2.Name = NeverLose.RandomString();
	LineFrame_2.Parent = BottomFrame
	LineFrame_2.AnchorPoint = Vector2.new(0.5, 0)
	LineFrame_2.BackgroundColor3 = Color3.fromRGB(45, 48, 58)
	LineFrame_2.BackgroundTransparency = 0.650
	LineFrame_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	LineFrame_2.BorderSizePixel = 0
	LineFrame_2.Position = UDim2.new(0.5, 0, 0, 0)
	LineFrame_2.Size = UDim2.new(1, -10, 0, 1)
	LineFrame_2.ZIndex = 5

	UserSettingButton.Name = NeverLose.RandomString();
	UserSettingButton.Parent = BottomFrame
	UserSettingButton.AnchorPoint = Vector2.new(1, 0.5)
	UserSettingButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	UserSettingButton.BackgroundTransparency = 1.000
	UserSettingButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	UserSettingButton.BorderSizePixel = 0
	UserSettingButton.Position = UDim2.new(1, -7, 0.5, 0)
	UserSettingButton.Size = UDim2.new(0, 25, 0, 25)
	UserSettingButton.ZIndex = 7
	UserSettingButton.FontFace = NeverLose.BuiltInBold
	UserSettingButton.Text = "chevron-large-right"
	UserSettingButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	UserSettingButton.TextSize = 13.000
	UserSettingButton.TextTransparency = 0.5

	NeverLose:AddSignal(BottomFrame.MouseEnter:Connect(LPH_NO_VIRTUALIZE(function()
		NeverLose.PlayAnimate(UserSettingButton,SlowyTween , {
			TextTransparency = 0.25
		})		
	end)))

	NeverLose:AddSignal(BottomFrame.MouseLeave:Connect(LPH_NO_VIRTUALIZE(function()
		NeverLose.PlayAnimate(UserSettingButton,SlowyTween , {
			TextTransparency = 0.5
		})		
	end)))

	RightMenuFrame.Name = NeverLose.RandomString();
	RightMenuFrame.Parent = WindowFrame
	RightMenuFrame.BackgroundColor3 = Color3.fromRGB(8, 8, 13)
	RightMenuFrame.BackgroundTransparency = 0.600
	RightMenuFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	RightMenuFrame.BorderSizePixel = 0
	RightMenuFrame.ClipsDescendants = true
	RightMenuFrame.Position = UDim2.new(0, 176, 0, 0)
	RightMenuFrame.Size = UDim2.new(1, -176, 1, 0)
	RightMenuFrame.ZIndex = 8

	UIStroke.Transparency = 0.650
	UIStroke.Color = Color3.fromRGB(45, 48, 58)
	UIStroke.Parent = RightMenuFrame

	UICorner_4.CornerRadius = UDim.new(0, 13)
	UICorner_4.Parent = RightMenuFrame

	RightHeader.Name = NeverLose.RandomString();
	RightHeader.Parent = RightMenuFrame
	RightHeader.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	RightHeader.BackgroundTransparency = 1.000
	RightHeader.BorderColor3 = Color3.fromRGB(0, 0, 0)
	RightHeader.BorderSizePixel = 0
	RightHeader.Size = UDim2.new(1, 0, 0, 50)
	RightHeader.ZIndex = 9

	LineFrame_3.Name = NeverLose.RandomString();
	LineFrame_3.Parent = RightHeader
	LineFrame_3.AnchorPoint = Vector2.new(0.5, 1)
	LineFrame_3.BackgroundColor3 = Color3.fromRGB(45, 48, 58)
	LineFrame_3.BackgroundTransparency = 0.650
	LineFrame_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
	LineFrame_3.BorderSizePixel = 0
	LineFrame_3.Position = UDim2.new(0.5, 0, 1, 0)
	LineFrame_3.Size = UDim2.new(1, -10, 0, 1)
	LineFrame_3.ZIndex = 9

	ConfigFrame.Name = NeverLose.RandomString();
	ConfigFrame.Parent = RightHeader
	ConfigFrame.AnchorPoint = Vector2.new(0, 0.5)
	ConfigFrame.BackgroundColor3 = Color3.fromRGB(13, 17, 22)
	ConfigFrame.BackgroundTransparency = 0.750
	ConfigFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ConfigFrame.BorderSizePixel = 0
	ConfigFrame.Position = UDim2.new(0, 10, 0.5, 0)
	ConfigFrame.Size = UDim2.new(0, 115, 0, 30)
	ConfigFrame.ZIndex = 9

	UIStroke_2.Transparency = 0.650
	UIStroke_2.Color = Color3.fromRGB(45, 48, 58)
	UIStroke_2.Parent = ConfigFrame

	UICorner_5.CornerRadius = UDim.new(0, 4)
	UICorner_5.Parent = ConfigFrame

	ConfigIcon.Name = NeverLose.RandomString();
	ConfigIcon.Parent = ConfigFrame
	ConfigIcon.AnchorPoint = Vector2.new(0, 0.5)
	ConfigIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ConfigIcon.BackgroundTransparency = 1.000
	ConfigIcon.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ConfigIcon.BorderSizePixel = 0
	ConfigIcon.Position = UDim2.new(0, 2, 0.5, 0)
	ConfigIcon.Size = UDim2.new(0, 25, 0, 25)
	ConfigIcon.ZIndex = 9
	ConfigIcon.FontFace = NeverLose.BuiltInBold
	ConfigIcon.Text = "floppy-disk"
	ConfigIcon.TextColor3 = Color3.fromRGB(223, 223, 223)
	ConfigIcon.TextSize = 16.000
	ConfigIcon.TextTransparency = 0.250
	ConfigIcon.TextWrapped = true

	LineFrame_4.Name = NeverLose.RandomString();
	LineFrame_4.Parent = ConfigFrame
	LineFrame_4.BackgroundColor3 = Color3.fromRGB(45, 48, 58)
	LineFrame_4.BackgroundTransparency = 0.650
	LineFrame_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
	LineFrame_4.BorderSizePixel = 0
	LineFrame_4.Position = UDim2.new(0, 30, 0, 0)
	LineFrame_4.Size = UDim2.new(0, 1, 1, 0)

	ConfigName.Name = NeverLose.RandomString();
	ConfigName.Parent = ConfigFrame
	ConfigName.AnchorPoint = Vector2.new(0, 0.5)
	ConfigName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ConfigName.BackgroundTransparency = 1.000
	ConfigName.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ConfigName.BorderSizePixel = 0
	ConfigName.Position = UDim2.new(0, 40, 0.5, 0)
	ConfigName.Size = UDim2.new(1, -7, 0, 15)
	ConfigName.ZIndex = 9
	ConfigName.Font = Enum.Font.GothamMedium
	ConfigName.Text = "Default"
	ConfigName.TextColor3 = Color3.fromRGB(255, 255, 255)
	ConfigName.TextSize = 12.000
	ConfigName.TextTransparency = 0.350
	ConfigName.TextXAlignment = Enum.TextXAlignment.Left

	ConfigBthIcon.Name = NeverLose.RandomString();
	ConfigBthIcon.Parent = ConfigFrame
	ConfigBthIcon.AnchorPoint = Vector2.new(1, 0.5)
	ConfigBthIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ConfigBthIcon.BackgroundTransparency = 1.000
	ConfigBthIcon.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ConfigBthIcon.BorderSizePixel = 0
	ConfigBthIcon.Position = UDim2.new(1, -2, 0.5, 0)
	ConfigBthIcon.Size = UDim2.new(0, 25, 0, 25)
	ConfigBthIcon.ZIndex = 9
	ConfigBthIcon.FontFace = NeverLose.BuiltInBold
	ConfigBthIcon.Text = "chevron-small-down"
	ConfigBthIcon.TextColor3 = Color3.fromRGB(223, 223, 223)
	ConfigBthIcon.TextSize = 16.000
	ConfigBthIcon.TextTransparency = 0.250
	ConfigBthIcon.TextWrapped = true

	SearchFrame.Name = NeverLose.RandomString();
	SearchFrame.Parent = RightHeader
	SearchFrame.AnchorPoint = Vector2.new(1, 0.5)
	SearchFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	SearchFrame.BackgroundTransparency = 1.000
	SearchFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	SearchFrame.BorderSizePixel = 0
	SearchFrame.ClipsDescendants = true
	SearchFrame.Position = UDim2.new(1, -10, 0.5, 0)
	SearchFrame.Size = UDim2.new(0, 30, 0, 30)
	SearchFrame.ZIndex = 12

	SearchIcon.Name = NeverLose.RandomString();
	SearchIcon.Parent = SearchFrame
	SearchIcon.AnchorPoint = Vector2.new(0, 0.5)
	SearchIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	SearchIcon.BackgroundTransparency = 1.000
	SearchIcon.BorderColor3 = Color3.fromRGB(0, 0, 0)
	SearchIcon.BorderSizePixel = 0
	SearchIcon.Position = UDim2.new(0, 2, 0.5, 0)
	SearchIcon.Size = UDim2.new(0, 25, 0, 25)
	SearchIcon.ZIndex = 12
	SearchIcon.FontFace = NeverLose.BuiltInBold
	SearchIcon.Text = "magnifying-glass"
	SearchIcon.TextColor3 = Color3.fromRGB(223, 223, 223)
	SearchIcon.TextSize = 14.000
	SearchIcon.TextTransparency = 0.45
	SearchIcon.TextWrapped = true

	SearchBox.Name = NeverLose.RandomString();
	SearchBox.Parent = SearchFrame
	SearchBox.AnchorPoint = Vector2.new(0, 0.5)
	SearchBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	SearchBox.BackgroundTransparency = 1.000
	SearchBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
	SearchBox.BorderSizePixel = 0
	SearchBox.Position = UDim2.new(0, 35, 0.5, 0)
	SearchBox.Size = UDim2.new(1, -35, 0, 25)
	SearchBox.ZIndex = 12
	SearchBox.ClearTextOnFocus = false
	SearchBox.Font = Enum.Font.GothamMedium
	SearchBox.PlaceholderText = "Search"
	SearchBox.Text = ""
	SearchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
	SearchBox.TextSize = 13.000
	SearchBox.TextTransparency = 1
	SearchBox.TextXAlignment = Enum.TextXAlignment.Left

	TabContainer.Name = NeverLose.RandomString();
	TabContainer.Parent = RightMenuFrame
	TabContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TabContainer.BackgroundTransparency = 1.000
	TabContainer.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TabContainer.BorderSizePixel = 0
	TabContainer.ClipsDescendants = true
	TabContainer.Position = UDim2.new(0, 0, 0, 50)
	TabContainer.Size = UDim2.new(1, 0, 1, -50)
	TabContainer.ZIndex = 5

	do
		Window.Searching = false;
		local Input = NeverLose:CreateInput(SearchIcon , LPH_NO_VIRTUALIZE(function()
			Window.Searching = not Window.Searching;

			if Window.Searching then
				NeverLose.PlayAnimate(SearchFrame , VSlowTween , {
					Size = UDim2.new(0, 220, 0, 30)
				})

				NeverLose.PlayAnimate(SearchIcon , SlowyTween , {
					TextTransparency = 0.25
				})

				NeverLose.PlayAnimate(SearchBox , VSlowTween , {
					TextTransparency = 0.350
				})
			else
				NeverLose.PlayAnimate(SearchFrame , VSlowTween , {
					Size = UDim2.new(0, 30, 0, 30)
				})

				NeverLose.PlayAnimate(SearchIcon , SlowyTween , {
					TextTransparency = 0.45
				})

				NeverLose.PlayAnimate(SearchBox , SlowyTween , {
					TextTransparency = 1
				})

				SearchBox.Text = "";
			end;
		end));	

		local wati_for_finish = tick();
		local last_thread;
		local max_time = 0.2;

		NeverLose:AddSignal(SearchBox:GetPropertyChangedSignal('Text'):Connect(LPH_NO_VIRTUALIZE(function()
			if not SearchBox.Text:byte() then
				for i,v in next , NeverLose.NameRegisitry do
					v.Root.Visible = true;
				end;

				return;	
			end;

			wati_for_finish = tick();

			if last_thread then
				task.cancel(last_thread);
				last_thread = nil;
			end;

			last_thread = task.delay(max_time,function()
				if SearchBox.Text:byte() and (tick() - wati_for_finish) > max_time then
					for i,v in next , NeverLose.NameRegisitry do
						if string.find(string.lower(v.Idx) , string.lower(SearchBox.Text), 1, true) then
							v.Root.Visible = true;
						else
							v.Root.Visible = false;
						end;
					end;
				end;
			end);
		end)));

		NeverLose:AddSignal(Input.MouseEnter:Connect(LPH_NO_VIRTUALIZE(function()
			NeverLose.PlayAnimate(SearchIcon , SlowyTween , {
				TextTransparency = 0.25
			})
		end)))

		NeverLose:AddSignal(Input.MouseLeave:Connect(LPH_NO_VIRTUALIZE(function()
			if Window.Searching then
				NeverLose.PlayAnimate(SearchIcon , SlowyTween , {
					TextTransparency = 0.25
				})
			else
				NeverLose.PlayAnimate(SearchIcon , SlowyTween , {
					TextTransparency = 0.45
				})
			end;
		end)));
	end;

	if Window.Enable3DRenderer then
		local Part = Instance.new('Part');

		Part.Name = NeverLose.RandomString();
		Part.Anchored = true;
		Part.Transparency = 1;
		Part.CanCollide = false;
		Part.CanTouch = false;
		Part.AudioCanCollide = false;
		Part.CollisionGroup = NeverLose.RandomString();
		Part.CFrame = CFrame.new(0,0,0);
		Part.Size = Vector3.zero;

		local SurfaceGui = Instance.new("SurfaceGui")

		SurfaceGui.Parent = NeverLose.ScreenGui;
		SurfaceGui.Adornee = Part;
		SurfaceGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		SurfaceGui.AlwaysOnTop = true
		SurfaceGui.LightInfluence = 1.000
		SurfaceGui.ZIndexBehavior = Enum.ZIndexBehavior.Global;
		SurfaceGui.SizingMode = Enum.SurfaceGuiSizingMode.FixedSize;
		SurfaceGui.PixelsPerStud = 40;

		Window.SurfaceGui = SurfaceGui;
		NeverLose.GlobalSurfaceGui = SurfaceGui;

		local PerfectScale = Vector2.new(1920 , 1080 + 300)

		Window.Load3DBlock = LPH_NO_VIRTUALIZE(function()
			if not Window.Signal:GetValue() then
				local _,OnScreen = CurrentCamera:WorldToViewportPoint(Part.Position);

				if OnScreen then
					NeverLose.PlayAnimate(Part,VSlowTween , {
						CFrame = CurrentCamera.CFrame * CFrame.new(0,0,-15) * CFrame.Angles(0,math.rad(180),0);
					});
				end;

				return
			end;

			local Dimensions = 50;

			local XY_Incom = Vector2.new(PerfectScale.X + 5, PerfectScale.Y * 1.35) / (Dimensions / 2);
			local PerfectDistance = XY_Incom.Magnitude;
			local SizeIndicator = PerfectDistance / 1.35;

			Part.Parent = NeverLose.BlurModuleParent or workspace;

			NeverLose.PlayAnimate(Part,VSlowTween , {
				CFrame = (CurrentCamera.CFrame * CFrame.new(0,0,-25)) * CFrame.Angles(0,math.rad(180),0);
			});

			Part.Size = Vector3.new(PerfectScale.X / SizeIndicator,PerfectScale.Y / SizeIndicator,0);
		end);

		function Window:Set3DRender(val)
			Window.__3DRender = val;
			NeverLose.Global3DRenderMode = val;

			if val then
				Window.Load3DBlock();
			else


				Part.Parent = nil;
			end;

			renderParentWindow();
		end;
	end;

	function Window:AddTabLabel(Name: string)
		local TabLabel = Instance.new("TextLabel")

		TabLabel.Name = NeverLose.RandomString()
		TabLabel.Parent = LeftScrollingFrame
		TabLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TabLabel.BackgroundTransparency = 1.000
		TabLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TabLabel.BorderSizePixel = 0
		TabLabel.Size = UDim2.new(1, -7, 0, 15)
		TabLabel.ZIndex = 8
		TabLabel.Font = Enum.Font.GothamMedium
		TabLabel.Text = Name
		TabLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		TabLabel.TextSize = 11.000
		TabLabel.TextTransparency = 0.500
		TabLabel.TextXAlignment = Enum.TextXAlignment.Left

		local SetRender = LPH_NO_VIRTUALIZE(function(val)
			if val then
				NeverLose.PlayAnimate(TabLabel , SlowyTween,{
					TextTransparency = 0.500
				})
			else
				NeverLose.PlayAnimate(TabLabel , SlowyTween,{
					TextTransparency = 1
				})
			end
		end)

		SetRender(Window.Signal:GetValue());

		return Window.Signal:Connect(SetRender);
	end;

	function Window:AddTab(Config)
		Config = NeverLose:ProcessParams(Config , {
			Icon = "crosshairs",
			Name = "Tab",
			Type = "Double"
		});

		local Tab = {
			Signal = NeverLose:CreateSignal(false);
		};

		local TabButton = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local TabIcon = Instance.new("TextLabel")
		local TabContentLabel = Instance.new("TextLabel")

		Tab.Idx = TabButton;

		TabButton.Name = NeverLose.RandomString();
		TabButton.Parent = LeftScrollingFrame
		TabButton.BackgroundColor3 = Color3.fromRGB(41, 45, 49)
		TabButton.BackgroundTransparency = 0.500
		TabButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TabButton.BorderSizePixel = 0
		TabButton.Size = UDim2.new(1, -1, 0, 30)
		TabButton.ZIndex = 8

		UICorner.CornerRadius = UDim.new(0, 6)
		UICorner.Parent = TabButton

		TabIcon.Name = NeverLose.RandomString();
		TabIcon.Parent = TabButton
		TabIcon.AnchorPoint = Vector2.new(0, 0.5)
		TabIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TabIcon.BackgroundTransparency = 1.000
		TabIcon.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TabIcon.BorderSizePixel = 0
		TabIcon.Position = UDim2.new(0, 2, 0.5, 0)
		TabIcon.Size = UDim2.new(0, 25, 0, 25)
		TabIcon.ZIndex = 9
		TabIcon.FontFace = NeverLose.BuiltInBold
		TabIcon.Text = Config.Icon;
		TabIcon.TextColor3 = NeverLose.AccentColor
		TabIcon.TextSize = 16.000
		TabIcon.TextWrapped = true

		TabContentLabel.Name = NeverLose.RandomString();
		TabContentLabel.Parent = TabButton
		TabContentLabel.AnchorPoint = Vector2.new(0, 0.5)
		TabContentLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TabContentLabel.BackgroundTransparency = 1.000
		TabContentLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TabContentLabel.BorderSizePixel = 0
		TabContentLabel.Position = UDim2.new(0, 30, 0.5, 0)
		TabContentLabel.Size = UDim2.new(1, -7, 0, 15)
		TabContentLabel.ZIndex = 9
		TabContentLabel.Font = Enum.Font.GothamMedium
		TabContentLabel.Text = Config.Name
		TabContentLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		TabContentLabel.TextSize = 12.000
		TabContentLabel.TextXAlignment = Enum.TextXAlignment.Left

		local TabFrame = Instance.new("Frame")
		local LeftScroll = Instance.new("ScrollingFrame")
		local UIListLayout = Instance.new("UIListLayout")
		local RightScroll = Instance.new("ScrollingFrame")
		local UIListLayout_2 = Instance.new("UIListLayout")

		TabFrame.Name = NeverLose.RandomString();
		TabFrame.Parent = TabContainer
		TabFrame.AnchorPoint = Vector2.new(0.5, 0.5)
		TabFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TabFrame.BackgroundTransparency = 1.000
		TabFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TabFrame.BorderSizePixel = 0
		TabFrame.ClipsDescendants = true
		TabFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
		TabFrame.Size = UDim2.new(1, 0, 1, 0)
		TabFrame.Visible = true;

		LeftScroll.Name = NeverLose.RandomString();
		LeftScroll.Parent = TabFrame
		LeftScroll.Active = true
		LeftScroll.AnchorPoint = Vector2.new(0.5, 0.5)
		LeftScroll.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		LeftScroll.BackgroundTransparency = 1.000
		LeftScroll.BorderColor3 = Color3.fromRGB(0, 0, 0)
		LeftScroll.BorderSizePixel = 0
		LeftScroll.ClipsDescendants = false
		LeftScroll.Position = UDim2.new(0.25, 0, 0.5, 0)
		LeftScroll.Size = UDim2.new(0.5, 0, 1, -5)
		LeftScroll.ScrollBarThickness = 0

		UIListLayout.Parent = LeftScroll
		UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout.Padding = UDim.new(0, 5)

		NeverLose:AddSignal(UIListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(LPH_NO_VIRTUALIZE(function()
			LeftScroll.CanvasSize = UDim2.fromOffset(0,UIListLayout.AbsoluteContentSize.Y + 1)
		end)))

		RightScroll.Name = NeverLose.RandomString();
		RightScroll.Parent = TabFrame
		RightScroll.Active = true
		RightScroll.AnchorPoint = Vector2.new(0.5, 0.5)
		RightScroll.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		RightScroll.BackgroundTransparency = 1.000
		RightScroll.BorderColor3 = Color3.fromRGB(0, 0, 0)
		RightScroll.BorderSizePixel = 0
		RightScroll.ClipsDescendants = false
		RightScroll.Position = UDim2.new(0.75, 0, 0.5, 0)
		RightScroll.Size = UDim2.new(0.5, 0, 1, -5)
		RightScroll.ScrollBarThickness = 0

		UIListLayout_2.Parent = RightScroll
		UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout_2.Padding = UDim.new(0, 5)

		if Config.Type == "Single" then
			UIListLayout_2:Destroy();
			RightScroll:Destroy();
			RightScroll = LeftScroll;
			UIListLayout_2 = UIListLayout;
			LeftScroll.Size = UDim2.new(1, 0, 1, -5);
			LeftScroll.Position = UDim2.new(0.5, 0, 0.5, 0)
		else
			NeverLose:AddSignal(UIListLayout_2:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(LPH_NO_VIRTUALIZE(function()
				RightScroll.CanvasSize = UDim2.fromOffset(0,UIListLayout_2.AbsoluteContentSize.Y + 1)
			end)))
		end;

		NeverLose:AddSignal(TabIcon:GetPropertyChangedSignal('TextTransparency'):Connect(LPH_NO_VIRTUALIZE(function()
			if TabIcon.TextTransparency > 0.4 then
				UIListLayout.Parent = nil;
				UIListLayout_2.Parent = nil;
				TabFrame.Visible = false;
				TabFrame.Parent = nil
			else
				UIListLayout.Parent = LeftScroll;
				UIListLayout_2.Parent = RightScroll;
				TabFrame.Visible = true;
				TabFrame.Parent = TabContainer;
			end;
		end)));

		Tab.SetValue = LPH_NO_VIRTUALIZE(function(value)
			Tab.Signal:SetValue(value);

			if value then
				NeverLose.PlayAnimate(TabButton , SlowyTween , {
					BackgroundTransparency = 0.500
				})

				NeverLose.PlayAnimate(TabIcon , SlowyTween , {
					TextTransparency = 0,
					TextColor3 = NeverLose.AccentColor
				})

				NeverLose.PlayAnimate(TabContentLabel , SlowyTween , {
					TextTransparency = 0
				})
			else
				NeverLose.PlayAnimate(TabButton , SlowyTween , {
					BackgroundTransparency = 1
				})

				NeverLose.PlayAnimate(TabIcon , SlowyTween , {
					TextTransparency = 0.5,
					TextColor3 = Color3.fromRGB(252, 252, 252)
				})

				NeverLose.PlayAnimate(TabContentLabel , SlowyTween , {
					TextTransparency = 0.5
				})
			end;
		end);

		table.insert(Window.Tabs,Tab);

		if Window.Tabs[Window.CurrentTab] == Tab then
			Tab.SetValue(true)
		else
			Tab.SetValue(false);
		end;

		local over = NeverLose:CreateInput(TabButton,LPH_NO_VIRTUALIZE(function()
			for i,v in next , Window.Tabs do
				if v.Idx == TabButton then
					v.SetValue(true);
					Window.CurrentTab = i;
				else
					v.SetValue(false);
				end;
			end;
		end));

		NeverLose:AddSignal(over.MouseEnter:Connect(LPH_NO_VIRTUALIZE(function()
			if Window.Tabs[Window.CurrentTab] == Tab then
				NeverLose.PlayAnimate(TabButton , SlowyTween , {
					BackgroundTransparency = 0.500
				})
			else
				NeverLose.PlayAnimate(TabButton , SlowyTween , {
					BackgroundTransparency = 0.8
				})
			end;
		end)))

		NeverLose:AddSignal(over.MouseLeave:Connect(LPH_NO_VIRTUALIZE(function()
			if Window.Tabs[Window.CurrentTab] == Tab then
				NeverLose.PlayAnimate(TabButton , SlowyTween , {
					BackgroundTransparency = 0.500
				})
			else
				NeverLose.PlayAnimate(TabButton , SlowyTween , {
					BackgroundTransparency = 1
				})
			end;
		end)))

		Window.Signal:Connect(LPH_NO_VIRTUALIZE(function(value)
			if value then
				if Window.Tabs[Window.CurrentTab] == Tab then
					Tab.SetValue(true)
				else
					Tab.SetValue(false);
				end;
			else
				Tab.SetValue(false);

				NeverLose.PlayAnimate(TabButton , SlowyTween , {
					BackgroundTransparency = 1
				})

				NeverLose.PlayAnimate(TabIcon , SlowyTween , {
					TextTransparency = 1,
				})

				NeverLose.PlayAnimate(TabContentLabel , SlowyTween , {
					TextTransparency = 1
				})
			end;
		end));

		function Tab:AddSection(Config)
			Config = NeverLose:ProcessParams(Config , {
				Name = "SECTION",
				Position = 'left'
			});

			local SectionFrame = Instance.new("Frame")
			local SectionLabel = Instance.new("TextLabel")
			local SectionHandler = Instance.new("Frame")
			local UIStroke = Instance.new("UIStroke")
			local UICorner = Instance.new("UICorner")
			local UIListLayout = Instance.new("UIListLayout")

			SectionFrame.Name = NeverLose.RandomString();
			SectionFrame.Parent = (string.lower(Config.Position) == 'left' and LeftScroll) or RightScroll
			SectionFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SectionFrame.BackgroundTransparency = 1.000
			SectionFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SectionFrame.BorderSizePixel = 0
			SectionFrame.ClipsDescendants = true
			SectionFrame.Size = UDim2.new(1, -5, 0, 0)
			SectionFrame.ZIndex = 9

			SectionLabel.Name = NeverLose.RandomString();
			SectionLabel.Parent = SectionFrame
			SectionLabel.AnchorPoint = Vector2.new(0.5, 0)
			SectionLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SectionLabel.BackgroundTransparency = 1.000
			SectionLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SectionLabel.BorderSizePixel = 0
			SectionLabel.Position = UDim2.new(0.5, 0, 0, 0)
			SectionLabel.Size = UDim2.new(1, -35, 0, 15)
			SectionLabel.ZIndex = 9
			SectionLabel.Font = Enum.Font.GothamMedium
			SectionLabel.Text = Config.Name
			SectionLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			SectionLabel.TextSize = 11.000
			SectionLabel.TextTransparency = 0.500
			SectionLabel.TextXAlignment = Enum.TextXAlignment.Left

			SectionHandler.Name = NeverLose.RandomString();
			SectionHandler.Parent = SectionFrame
			SectionHandler.AnchorPoint = Vector2.new(0.5, 0)
			SectionHandler.BackgroundColor3 = Color3.fromRGB(20, 22, 27)
			SectionHandler.BackgroundTransparency = 0.500
			SectionHandler.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SectionHandler.BorderSizePixel = 0
			SectionHandler.ClipsDescendants = true
			SectionHandler.Position = UDim2.new(0.5, 0, 0, 20)
			SectionHandler.Size = UDim2.new(1, -10, 1, -21)
			SectionHandler.ZIndex = 9

			UIStroke.Transparency = 0.650
			UIStroke.Color = Color3.fromRGB(45, 48, 58)
			UIStroke.Parent = SectionHandler

			UICorner.CornerRadius = UDim.new(0, 10)
			UICorner.Parent = SectionHandler

			UIListLayout.Parent = SectionHandler
			UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

			UIListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(LPH_NO_VIRTUALIZE(function()


				if UIListLayout.AbsoluteContentSize.Y <= 1 then
					NeverLose.PlayAnimate(SectionFrame , VSlowTween , {
						Size = UDim2.new(1, -5, 0, 0)
					})
				else
					NeverLose.PlayAnimate(SectionFrame , VSlowTween , {
						Size = UDim2.new(1, -5, 0, UIListLayout.AbsoluteContentSize.Y + 19.5)
					})
				end;
			end));

			local Section = NeverLose:RegisiterItem(SectionHandler , Tab.Signal);

			Section.SetRender = LPH_NO_VIRTUALIZE(function(value)
				if value then
					NeverLose.PlayAnimate(SectionLabel,SlowyTween,{
						TextTransparency = 0.500
					})

					NeverLose.PlayAnimate(SectionHandler,SlowyTween,{
						BackgroundTransparency = 0.500
					})

					NeverLose.PlayAnimate(UIStroke,SlowyTween,{
						Transparency = 0.650
					})
				else
					NeverLose.PlayAnimate(SectionLabel,SlowyTween,{
						TextTransparency = 1
					})

					NeverLose.PlayAnimate(SectionHandler,SlowyTween,{
						BackgroundTransparency = 1
					})

					NeverLose.PlayAnimate(UIStroke,SlowyTween,{
						Transparency = 1
					})
				end;
			end);

			Section.SetRender(Tab.Signal:GetValue());
			Tab.Signal:Connect(Section.SetRender);

			return Section;
		end;

		return Tab;
	end;

	function Window:_InitConfig()
		local ConfigSignal = NeverLose:CreateSignal(false);
		local ConfigLib = {
			Signals = {},
		};

		local ConfigMenu = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local UIListLayout = Instance.new("UIListLayout")
		local UIStroke = Instance.new("UIStroke")
		local InputFrame = Instance.new("Frame")
		local BasedLabel = Instance.new("TextLabel")
		local LineFrame = Instance.new("Frame")
		local BasedHandler = Instance.new("Frame")
		local UIListLayout_2 = Instance.new("UIListLayout")
		local TextInput = Instance.new("Frame")
		local UICorner_2 = Instance.new("UICorner")
		local UIStroke_2 = Instance.new("UIStroke")
		local TextBox = Instance.new("TextBox")
		local LoadConfig = Instance.new("Frame")
		local Icon = Instance.new("TextLabel")
		local UICorner_3 = Instance.new("UICorner")
		local UICorner_4 = Instance.new("UICorner")

		local shadow = NeverLose:CreateShadow(ConfigMenu);

		ConfigLib.SetRender = LPH_NO_VIRTUALIZE(function(value)
			if value then
				ConfigMenu.Position = UDim2.fromOffset(ConfigFrame.AbsolutePosition.X + 110 , ConfigFrame.AbsolutePosition.Y + 96)

				NeverLose.PlayAnimate(ConfigMenu , SlowyTween , {
					BackgroundTransparency = 0.035,
					Position = UDim2.fromOffset(ConfigFrame.AbsolutePosition.X + 110 , ConfigFrame.AbsolutePosition.Y + 95)
				})	

				NeverLose.PlayAnimate(UIStroke , SlowyTween , {
					Transparency = 0.650
				})
				NeverLose.PlayAnimate(BasedLabel , SlowyTween , {
					TextTransparency = 0.200
				})	

				NeverLose.PlayAnimate(UIStroke_2 , SlowyTween , {
					Transparency = 0.65
				})	

				NeverLose.PlayAnimate(LineFrame , SlowyTween , {
					BackgroundTransparency = 0.650
				})	
				NeverLose.PlayAnimate(TextInput , SlowyTween , {
					BackgroundTransparency = 0
				})	
				NeverLose.PlayAnimate(TextBox , SlowyTween , {
					TextTransparency = 0.350
				})	
				NeverLose.PlayAnimate(Icon , SlowyTween , {
					TextTransparency = 0.350
				})	

				NeverLose.PlayAnimate(ConfigBthIcon , SlowyTween , {
					Rotation = 180
				})	

				shadow:Render(true)
			else
				NeverLose.PlayAnimate(ConfigBthIcon , SlowyTween , {
					Rotation = 0
				})

				NeverLose.PlayAnimate(ConfigMenu , SlowyTween , {
					BackgroundTransparency = 1,
					Position = UDim2.fromOffset(ConfigFrame.AbsolutePosition.X + 110 , ConfigFrame.AbsolutePosition.Y + 96)
				})	

				NeverLose.PlayAnimate(UIStroke_2 , SlowyTween , {
					Transparency = 1
				})	

				NeverLose.PlayAnimate(UIStroke , SlowyTween , {
					Transparency = 1
				})
				NeverLose.PlayAnimate(BasedLabel , SlowyTween , {
					TextTransparency = 1
				})	
				NeverLose.PlayAnimate(LineFrame , SlowyTween , {
					BackgroundTransparency = 1
				})	
				NeverLose.PlayAnimate(TextInput , SlowyTween , {
					BackgroundTransparency = 1
				})	
				NeverLose.PlayAnimate(TextBox , SlowyTween , {
					TextTransparency = 1
				})	
				NeverLose.PlayAnimate(Icon , SlowyTween , {
					TextTransparency = 1
				})	

				shadow:Render(false)
			end;
		end);

		NeverLose:AddSignal(ConfigMenu:GetPropertyChangedSignal('BackgroundTransparency'):Connect(LPH_NO_VIRTUALIZE(function()
			if ConfigMenu.BackgroundTransparency > 0.9 then
				ConfigMenu.Visible = false;
				UIListLayout.Parent = nil;
				ConfigMenu.Parent = nil;
			else

				ConfigMenu.Visible = true;
				UIListLayout.Parent = ConfigMenu

				if NeverLose.Global3DRenderMode then
					ConfigMenu.Parent = NeverLose.GlobalSurfaceGui;
				else
					ConfigMenu.Parent = NeverLose.ScreenGui;
				end;
			end
		end)))

		ConfigMenu.Name = NeverLose.RandomString();
		ConfigMenu.Parent = NeverLose.ScreenGui;
		ConfigMenu.AnchorPoint = Vector2.new(0.5, 0)
		ConfigMenu.BackgroundColor3 = Color3.fromRGB(20, 22, 27)
		ConfigMenu.BackgroundTransparency = 0.035
		ConfigMenu.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ConfigMenu.BorderSizePixel = 0
		ConfigMenu.ClipsDescendants = true
		ConfigMenu.Position = UDim2.new(255,255,255,255)
		ConfigMenu.Size = UDim2.new(0, 220,0, 110)
		ConfigMenu.ZIndex = 151

		UICorner.CornerRadius = UDim.new(0, 10)
		UICorner.Parent = ConfigMenu

		UIListLayout.Parent = ConfigMenu
		UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout.Padding = UDim.new(0, 4)

		UIStroke.Transparency = 0.650
		UIStroke.Color = Color3.fromRGB(45, 48, 58)
		UIStroke.Parent = ConfigMenu

		InputFrame.Name = NeverLose.RandomString();
		InputFrame.Parent = ConfigMenu
		InputFrame.BackgroundColor3 = Color3.fromRGB(25, 27, 33)
		InputFrame.BackgroundTransparency = 1.000
		InputFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		InputFrame.BorderSizePixel = 0
		InputFrame.Size = UDim2.new(1, 0, 0, 30)
		InputFrame.ZIndex = 154

		BasedLabel.Name = NeverLose.RandomString();
		BasedLabel.Parent = InputFrame
		BasedLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		BasedLabel.BackgroundTransparency = 1.000
		BasedLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BasedLabel.BorderSizePixel = 0
		BasedLabel.Position = UDim2.new(0, 11, 0, 6)
		BasedLabel.Size = UDim2.new(0,1, 0, 15)
		BasedLabel.ZIndex = 154
		BasedLabel.Font = Enum.Font.GothamMedium
		BasedLabel.Text = "Config"
		BasedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		BasedLabel.TextSize = 13.000
		BasedLabel.TextTransparency = 0.200
		BasedLabel.TextXAlignment = Enum.TextXAlignment.Left

		LineFrame.Name = NeverLose.RandomString();
		LineFrame.Parent = InputFrame
		LineFrame.AnchorPoint = Vector2.new(0.5, 1)
		LineFrame.BackgroundColor3 = Color3.fromRGB(45, 48, 58)
		LineFrame.BackgroundTransparency = 0.650
		LineFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		LineFrame.BorderSizePixel = 0
		LineFrame.Position = UDim2.new(0.5, 0, 1, 0)
		LineFrame.Size = UDim2.new(1, -20, 0, 1)
		LineFrame.ZIndex = 154

		BasedHandler.Name = NeverLose.RandomString();
		BasedHandler.Parent = InputFrame
		BasedHandler.AnchorPoint = Vector2.new(1, 0)
		BasedHandler.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		BasedHandler.BackgroundTransparency = 1.000
		BasedHandler.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BasedHandler.BorderSizePixel = 0
		BasedHandler.Position = UDim2.new(1, -11, 0, 2)
		BasedHandler.Size = UDim2.new(1, -20, 0, 25)
		BasedHandler.ZIndex = 154

		UIListLayout_2.Parent = BasedHandler
		UIListLayout_2.FillDirection = Enum.FillDirection.Horizontal
		UIListLayout_2.HorizontalAlignment = Enum.HorizontalAlignment.Right
		UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout_2.VerticalAlignment = Enum.VerticalAlignment.Center
		UIListLayout_2.Padding = UDim.new(0, 5)

		NeverLose:AddSignal(UIListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(LPH_NO_VIRTUALIZE(function()
			if #ConfigLib.Signals <= 0 then
				NeverLose.PlayAnimate(ConfigMenu , SlowyTween , {
					Size = UDim2.new(0, 220,0, UIListLayout.AbsoluteContentSize.Y + 0);
				})
			else
				NeverLose.PlayAnimate(ConfigMenu , SlowyTween , {
					Size = UDim2.new(0, 220,0, UIListLayout.AbsoluteContentSize.Y + 5);
				})
			end;

		end)));

		TextInput.Name = NeverLose.RandomString();
		TextInput.Parent = BasedHandler
		TextInput.BackgroundColor3 = Color3.fromRGB(26, 28, 36)
		TextInput.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TextInput.BorderSizePixel = 0
		TextInput.ClipsDescendants = true
		TextInput.Size = UDim2.new(0, 100, 0, 18)
		TextInput.ZIndex = 154

		UICorner_2.CornerRadius = UDim.new(0, 4)
		UICorner_2.Parent = TextInput

		UIStroke_2.Transparency = 0.650
		UIStroke_2.Color = Color3.fromRGB(45, 48, 58)
		UIStroke_2.Parent = TextInput

		TextBox.Parent = TextInput
		TextBox.AnchorPoint = Vector2.new(0, 0.5)
		TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TextBox.BackgroundTransparency = 1.000
		TextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TextBox.BorderSizePixel = 0
		TextBox.Position = UDim2.new(0, 5, 0.5, 0)
		TextBox.Size = UDim2.new(1, -5, 0, 17)
		TextBox.ZIndex = 154
		TextBox.ClearTextOnFocus = false
		TextBox.Font = Enum.Font.GothamMedium
		TextBox.PlaceholderText = "Config Name ..."
		TextBox.Text = ""
		TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextBox.TextSize = 11.000
		TextBox.TextTransparency = 0.350
		TextBox.TextXAlignment = Enum.TextXAlignment.Left

		LoadConfig.Name = NeverLose.RandomString();
		LoadConfig.Parent = BasedHandler
		LoadConfig.BackgroundColor3 = Color3.fromRGB(39, 40, 49)
		LoadConfig.BackgroundTransparency = 1.000
		LoadConfig.BorderColor3 = Color3.fromRGB(0, 0, 0)
		LoadConfig.BorderSizePixel = 0
		LoadConfig.ClipsDescendants = true
		LoadConfig.Size = UDim2.new(0, 20, 0, 18)
		LoadConfig.ZIndex = 153

		Icon.Name = NeverLose.RandomString();
		Icon.Parent = LoadConfig
		Icon.AnchorPoint = Vector2.new(0.5, 0.5)
		Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Icon.BackgroundTransparency = 1.000
		Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Icon.BorderSizePixel = 0
		Icon.Position = UDim2.new(0.5, 0, 0.5, 0)
		Icon.Size = UDim2.new(1, 0, 1, 0)
		Icon.ZIndex = 153
		Icon.FontFace = NeverLose.BuiltInBold
		Icon.Text = "plus-large"
		Icon.TextColor3 = Color3.fromRGB(223, 223, 223)
		Icon.TextSize = 16.000
		Icon.TextTransparency = 0.350
		Icon.TextWrapped = true

		UICorner_3.CornerRadius = UDim.new(0, 4)
		UICorner_3.Parent = LoadConfig

		UICorner_4.CornerRadius = UDim.new(0, 10)
		UICorner_4.Parent = InputFrame

		local OpenButton = Instance.new("TextButton")
		local UICorner = Instance.new("UICorner")

		OpenButton.Name = NeverLose.RandomString();
		OpenButton.Parent = ConfigFrame
		OpenButton.AnchorPoint = Vector2.new(0, 0.5)
		OpenButton.BackgroundColor3 = Color3.fromRGB(20, 22, 27)
		OpenButton.BackgroundTransparency = 1.000
		OpenButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
		OpenButton.BorderSizePixel = 0
		OpenButton.Position = UDim2.new(0, 31, 0.5, 0)
		OpenButton.Size = UDim2.new(1, -31, 1, 0)
		OpenButton.ZIndex = 10
		OpenButton.Font = Enum.Font.SourceSans
		OpenButton.Text = ""
		OpenButton.TextColor3 = Color3.fromRGB(0, 0, 0)
		OpenButton.TextSize = 14.000

		UICorner.CornerRadius = UDim.new(0, 4)
		UICorner.Parent = OpenButton

		ConfigLib.SetRender(false);
		ConfigSignal:Connect(ConfigLib.SetRender);
		ConfigLib.UnsafeThread = nil;
		ConfigLib.SelectedConfig = "Default";

		local UpdateSize = LPH_NO_VIRTUALIZE(function()
			local size = TextService:GetTextSize(ConfigName.Text , ConfigName.TextSize,ConfigName.Font,Vector2.new(math.huge,math.huge));

			NeverLose.PlayAnimate(ConfigFrame,SlowyTween , {
				Size = UDim2.fromOffset(size.X + 75, 30)
			});
		end);

		UpdateSize();

		function ConfigLib:GetData(performance)
			local ikc = {};
			
			local cd = 0;
			for Flag,v in next , NeverLose.Flags do
				if v and v.GetValue then
					local data = v:GetValue();

					if typeof(data) == 'Color3' then
						table.insert(ikc,{
							Idx = Flag,
							Value = data:ToHex(),
						});
					else
						table.insert(ikc,{
							Idx = Flag,
							Value = data
						});
					end;
				end;
				
				if performance then
					if cd % 35 == 1 then
						task.wait()
					end
				end;
				
				cd += 1;
			end;

			return NeverLose.Base64Encode(Encryption.new(HttpService:JSONEncode(ikc)));
		end;

		function ConfigLib:LoadData(data)
			local coded = HttpService:JSONDecode(Encryption.reverse(NeverLose.Base64Decode(data)));

			for i,v in next , coded do
				if v.Idx then
					if NeverLose.Flags[v.Idx] then
						task.spawn(function()
							NeverLose.Flags[v.Idx]:SetValue(v.Value)
						end)
					end;
				end;
			end;
		end;

		function ConfigLib:RefreshConfig()
			if not isfolder(Window.ConfigFolder) then
				makefolder(Window.ConfigFolder);
			end;
			
			if not isfile(Window.ConfigFolder..'/Default') then
				writefile(Window.ConfigFolder..'/Default',ConfigLib:GetData());
			end;
			
			for i,v in next,ConfigMenu:GetChildren() do
				if v:GetAttribute('ConfigItem') then
					v:Destroy();
				end;
			end;

			for i,v in next , ConfigLib.Signals do
				v:Disconnect();
			end

			table.clear(ConfigLib.Signals);

			local ConfigList = {};
			for i,v in next , listfiles(Window.ConfigFolder) do

				local name = string.sub(v , #Window.ConfigFolder + 2);

				table.insert(ConfigList , name)
			end;

			for i,ConfigNameStr in next , ConfigList do
				local ConfigItemFrame = Instance.new("Frame")
				local BasedHandler = Instance.new("Frame")
				local UIListLayout = Instance.new("UIListLayout")
				local DeleteConfig = Instance.new("Frame")
				local Icon = Instance.new("TextLabel")
				local UICorner = Instance.new("UICorner")
				local LoadConfig = Instance.new("Frame")
				local Icon_2 = Instance.new("TextLabel")
				local UICorner_2 = Instance.new("UICorner")
				local UICorner_3 = Instance.new("UICorner")
				local BasedLabel = Instance.new("TextLabel")
				local UIStroke = Instance.new("UIStroke")

				ConfigItemFrame.Name = NeverLose.RandomString();
				ConfigItemFrame.Parent = ConfigMenu
				ConfigItemFrame.BackgroundColor3 = Color3.fromRGB(21, 20, 27)
				ConfigItemFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ConfigItemFrame.BorderSizePixel = 0
				ConfigItemFrame.Size = UDim2.new(1, -10, 0, 30)
				ConfigItemFrame.ZIndex = 153
				ConfigItemFrame:SetAttribute('ConfigItem',true);

				BasedHandler.Name = NeverLose.RandomString();
				BasedHandler.Parent = ConfigItemFrame
				BasedHandler.AnchorPoint = Vector2.new(1, 0)
				BasedHandler.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				BasedHandler.BackgroundTransparency = 1.000
				BasedHandler.BorderColor3 = Color3.fromRGB(0, 0, 0)
				BasedHandler.BorderSizePixel = 0
				BasedHandler.Position = UDim2.new(1, -11, 0, 2)
				BasedHandler.Size = UDim2.new(1, -20, 0, 25)
				BasedHandler.ZIndex = 153

				UIListLayout.Parent = BasedHandler
				UIListLayout.FillDirection = Enum.FillDirection.Horizontal
				UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
				UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
				UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
				UIListLayout.Padding = UDim.new(0, 5)

				DeleteConfig.Name = NeverLose.RandomString();
				DeleteConfig.Parent = BasedHandler
				DeleteConfig.BackgroundColor3 = Color3.fromRGB(39, 40, 49)
				DeleteConfig.BackgroundTransparency = 1.000
				DeleteConfig.BorderColor3 = Color3.fromRGB(0, 0, 0)
				DeleteConfig.BorderSizePixel = 0
				DeleteConfig.ClipsDescendants = true
				DeleteConfig.Size = UDim2.new(0, 20, 0, 18)
				DeleteConfig.ZIndex = 153

				Icon.Name = NeverLose.RandomString();
				Icon.Parent = DeleteConfig
				Icon.AnchorPoint = Vector2.new(0.5, 0.5)
				Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Icon.BackgroundTransparency = 1.000
				Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Icon.BorderSizePixel = 0
				Icon.Position = UDim2.new(0.5, 0, 0.5, 0)
				Icon.Size = UDim2.new(1, 0, 1, 0)
				Icon.ZIndex = 153
				Icon.FontFace = NeverLose.BuiltInBold
				Icon.Text = "trash-can"
				Icon.TextColor3 = Color3.fromRGB(223, 223, 223)
				Icon.TextSize = 16.000
				Icon.TextTransparency = 0.400
				Icon.TextWrapped = true

				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = DeleteConfig

				LoadConfig.Name = NeverLose.RandomString();
				LoadConfig.Parent = BasedHandler
				LoadConfig.BackgroundColor3 = Color3.fromRGB(39, 40, 49)
				LoadConfig.BackgroundTransparency = 1.000
				LoadConfig.BorderColor3 = Color3.fromRGB(0, 0, 0)
				LoadConfig.BorderSizePixel = 0
				LoadConfig.ClipsDescendants = true
				LoadConfig.Size = UDim2.new(0, 20, 0, 18)
				LoadConfig.ZIndex = 153

				Icon_2.Name = NeverLose.RandomString();
				Icon_2.Parent = LoadConfig
				Icon_2.AnchorPoint = Vector2.new(0.5, 0.5)
				Icon_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Icon_2.BackgroundTransparency = 1.000
				Icon_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Icon_2.BorderSizePixel = 0
				Icon_2.Position = UDim2.new(0.5, 0, 0.5, 0)
				Icon_2.Size = UDim2.new(1, 0, 1, 0)
				Icon_2.ZIndex = 153
				Icon_2.FontFace = NeverLose.BuiltInBold
				Icon_2.Text = "arrow-right-from-portrait-rectangle"
				Icon_2.TextColor3 = Color3.fromRGB(223, 223, 223)
				Icon_2.TextSize = 16.000
				Icon_2.TextTransparency = 0.400
				Icon_2.TextWrapped = true

				UICorner_2.CornerRadius = UDim.new(0, 4)
				UICorner_2.Parent = LoadConfig

				UICorner_3.CornerRadius = UDim.new(0, 5)
				UICorner_3.Parent = ConfigItemFrame

				BasedLabel.Name = NeverLose.RandomString();
				BasedLabel.Parent = ConfigItemFrame
				BasedLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				BasedLabel.BackgroundTransparency = 1.000
				BasedLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
				BasedLabel.BorderSizePixel = 0
				BasedLabel.Position = UDim2.new(0, 11, 0, 7)
				BasedLabel.Size = UDim2.new(0, 1, 0, 15)
				BasedLabel.ZIndex = 153
				BasedLabel.Font = Enum.Font.GothamMedium
				BasedLabel.Text = ConfigNameStr
				BasedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
				BasedLabel.TextSize = 13.000
				BasedLabel.TextTransparency = 0.200
				BasedLabel.TextXAlignment = Enum.TextXAlignment.Left

				UIStroke.Transparency = 0.500
				UIStroke.Color = Color3.fromRGB(45, 48, 58)
				UIStroke.Parent = ConfigItemFrame

				local Render = LPH_NO_VIRTUALIZE(function(rst)
					if rst then
						NeverLose.PlayAnimate(ConfigItemFrame,SlowyTween,{
							BackgroundTransparency = 0
						})

						NeverLose.PlayAnimate(Icon,SlowyTween,{
							TextTransparency = 0.400
						})

						NeverLose.PlayAnimate(Icon_2,SlowyTween,{
							TextTransparency = 0.400
						})

						NeverLose.PlayAnimate(BasedLabel,SlowyTween,{
							TextTransparency = 0.200
						})

						NeverLose.PlayAnimate(UIStroke,SlowyTween,{
							Transparency = 0.500
						})
					else
						NeverLose.PlayAnimate(ConfigItemFrame,SlowyTween,{
							BackgroundTransparency = 1
						})

						NeverLose.PlayAnimate(Icon,SlowyTween,{
							TextTransparency = 1
						})

						NeverLose.PlayAnimate(Icon_2,SlowyTween,{
							TextTransparency = 1
						})

						NeverLose.PlayAnimate(BasedLabel,SlowyTween,{
							TextTransparency = 1
						})

						NeverLose.PlayAnimate(UIStroke,SlowyTween,{
							Transparency = 1
						})
					end;
				end)

				Render(ConfigSignal:GetValue());
				table.insert(ConfigLib.Signals , ConfigSignal:Connect(Render));

				table.insert(ConfigLib.Signals , ConfigItemFrame.MouseEnter:Connect(LPH_NO_VIRTUALIZE(function()
					NeverLose.PlayAnimate(UIStroke,SlowyTween,{
						Transparency = 0.25
					})
				end)));

				table.insert(ConfigLib.Signals , ConfigItemFrame.MouseLeave:Connect(LPH_NO_VIRTUALIZE(function()
					NeverLose.PlayAnimate(UIStroke,SlowyTween,{
						Transparency = 0.500
					})
				end)));

				local deleter,signal = NeverLose:CreateInput(DeleteConfig,function()
					if ConfigNameStr == "Default" then
						Logging.new("trash-can","You can't delete default config!",3.5)
						return;
					end;
					
					delfile(Window.ConfigFolder..'/'..ConfigNameStr);

					UpdateSize();

					ConfigLib:RefreshConfig();

					Logging.new("trash-can",'Deleted '..tostring(ConfigNameStr),3.5)
				end);


				local _,load_signal = NeverLose:CreateInput(LoadConfig,function()
					local path = Window.ConfigFolder..'/'..ConfigNameStr;

					if isfile(path) then
						local data = readfile(path);

						ConfigLib:LoadData(data);

						ConfigLib.SelectedConfig = ConfigNameStr;
						ConfigName.Text = ConfigNameStr;

						UpdateSize();

						ConfigLib:RefreshConfig();

						Logging.new("folder",'Loaded '..tostring(ConfigNameStr),3.5)
					end
				end);

				table.insert(ConfigLib.Signals , signal);
				table.insert(ConfigLib.Signals , load_signal);

				table.insert(ConfigLib.Signals , deleter.MouseEnter:Connect(LPH_NO_VIRTUALIZE(function()
					NeverLose.PlayAnimate(Icon,SlowyTween,{
						TextTransparency = 0.2,
						TextColor3 = Color3.fromRGB(223, 125, 125)
					})
				end)))

				table.insert(ConfigLib.Signals , deleter.MouseLeave:Connect(LPH_NO_VIRTUALIZE(function()
					NeverLose.PlayAnimate(Icon,SlowyTween,{
						TextTransparency = 0.400,
						TextColor3 = Color3.fromRGB(223, 223, 223)
					})
				end)))

				table.insert(ConfigLib.Signals , LoadConfig.MouseEnter:Connect(LPH_NO_VIRTUALIZE(function()
					NeverLose.PlayAnimate(Icon_2,SlowyTween,{
						TextTransparency = 0.2,
						TextColor3 = NeverLose.AccentColor
					})
				end)))

				table.insert(ConfigLib.Signals , LoadConfig.MouseLeave:Connect(LPH_NO_VIRTUALIZE(function()
					NeverLose.PlayAnimate(Icon_2,SlowyTween,{
						TextTransparency = 0.400,
						TextColor3 = Color3.fromRGB(223, 223, 223)
					})
				end)))
			end;

			table.clear(ConfigList);
		end;
		
		task.delay(1,function()
			if ConfigLib.SelectedConfig == "Default" then
				local path = Window.ConfigFolder..'/Default';
				local ConfigNameStr = "Default";
				
				if isfile(path) then
					local data = readfile(path);

					ConfigLib:LoadData(data);

					ConfigLib.SelectedConfig = ConfigNameStr;
					ConfigName.Text = ConfigNameStr;

					UpdateSize();

					ConfigLib:RefreshConfig();

					Logging.new("folder","Loaded Default Config",3.5);
					
					task.spawn(function()
						while true do task.wait(5.75);
							if isfile(path) and ConfigLib.SelectedConfig == "Default" then
								writefile(Window.ConfigFolder..'/Default',ConfigLib:GetData(true));
							end;
						end;
					end);
				end;
			end;
		end);

		local hover_write = NeverLose:CreateInput(ConfigIcon,function()
			local path = Window.ConfigFolder..'/'..(ConfigLib.SelectedConfig or "Default");

			if isfile(path) then
				writefile(Window.ConfigFolder..'/'..(ConfigLib.SelectedConfig or "Default"),ConfigLib:GetData());

				Logging.new("folder",'Saved '..tostring(ConfigLib.SelectedConfig),3.5)
			end;
		end);

		NeverLose:AddSignal(hover_write.MouseEnter:Connect(LPH_NO_VIRTUALIZE(function()
			NeverLose.PlayAnimate(ConfigIcon,SlowyTween,{
				TextTransparency = 0.1
			})
		end)));

		NeverLose:AddSignal(hover_write.MouseLeave:Connect(LPH_NO_VIRTUALIZE(function()
			NeverLose.PlayAnimate(ConfigIcon,SlowyTween,{
				TextTransparency = 0.25
			})
		end)));


		local mv = NeverLose:CreateInput(LoadConfig , function()
			local cfg_name = TextBox.Text;

			if cfg_name and cfg_name:byte() and not cfg_name:find('/',1,true) and not cfg_name:find('\\',1,true) then
				cfg_name = string.sub(cfg_name , 1 , 24);

				writefile(Window.ConfigFolder..'/'..cfg_name,ConfigLib:GetData());
				ConfigLib.SelectedConfig = cfg_name;
				ConfigName.Text = cfg_name;

				Logging.new("folder",'Created '..tostring(cfg_name),3.5)

				TextBox.Text = "";

				UpdateSize();

				ConfigLib:RefreshConfig();
			end;
		end);

		NeverLose:AddSignal(mv.MouseEnter:Connect(function()
			NeverLose.PlayAnimate(Icon , SlowyTween , {
				TextTransparency = 0.1
			})
		end))

		NeverLose:AddSignal(mv.MouseLeave:Connect(function()
			NeverLose.PlayAnimate(Icon , SlowyTween , {
				TextTransparency = 0.35
			})
		end))

		ConfigLib:RefreshConfig();

		OpenButton.MouseButton1Click:Connect(LPH_NO_VIRTUALIZE(function()
			if ConfigLib.UnsafeThread then
				ConfigLib.UnsafeThread:Disconnect();
				ConfigLib.UnsafeThread = nil;
			end;

			ConfigSignal:SetValue(true);

			ConfigLib.UnsafeThread = UserInputService.InputBegan:Connect(function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					if not NeverLose:IsMouseOverFrame(ConfigMenu) then
						if ConfigLib.UnsafeThread then
							ConfigLib.UnsafeThread:Disconnect();
							ConfigLib.UnsafeThread = nil;
						end;

						ConfigSignal:SetValue(false);
					end;
				end;
			end)
		end));

		return ConfigLib;
	end;

	Window:_InitConfig();

	local UserSettings = NeverLose:CreateOptionWindow(BottomFrame , BottomFrame.ZIndex + 13);
	local reciveSignal;
	NeverLose:CreateInput(BottomFrame , LPH_NO_VIRTUALIZE(function()
		if reciveSignal then
			reciveSignal:Disconnect();
			reciveSignal = nil;	
		end;

		UserSettings.Signal:SetValue(true);

		reciveSignal = UserInputService.InputBegan:Connect(function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
				if not NeverLose:IsMouseOverFrame(UserSettings.Root) and not NeverLose:IsMouseOverFrame(BottomFrame) and not NeverLose.IsMosueOverOtherFrame then
					if reciveSignal then
						reciveSignal:Disconnect();
						reciveSignal = nil;	
					end;

					UserSettings.Signal:SetValue(false);
				end
			end
		end);
	end))

	Window.UserSettings = UserSettings;

	function Window:SetAccount(Config)
		Config = NeverLose:ProcessParams(Config , {
			Profile = NeverLose.UserProfile,
			Username = LocalPlayer.DisplayName,
			Expires = "Never",
		});

		AccountName.Text = Config.Username;
		AccountProfile.Image = Config.Profile;
		ExpireLabel.Text = Config.Expires;

		Window.Username = Config.Username or Window.Username;
		Window.Profile = Config.Profile or Window.Profile;
		Window.Expires = Config.Expires or Window.Expires;

		if Window.UserSettings.UserFrame then
			Window.UserSettings.UserFrame:SetUsername(Window.Username);
			Window.UserSettings.UserFrame:SetProfile(Window.Profile);
			Window.UserSettings.UserFrame:SetExpires(Window.Expires);
		else
			Window.UserSettings.UserFrame = UserSettings:AddUserFrame(Window.Username , Window.Profile , Window.Expires);
		end;
	end;

	function Window:SetSize(newsize)
		Window.Size = newsize;

		if Window.Signal:GetValue() then
			NeverLose.PlayAnimate(WindowFrame , VSlowTween , {
				Size = Window.Size
			})
		end
	end;

	Window:SetAccount();

	NeverLose:AddSignal(UserInputService.InputBegan:Connect(LPH_NO_VIRTUALIZE(function(value,ISTYPING)
		if value.KeyCode == Window.Keybind or value.KeyCode.Name == Window.Keybind then
			if not ISTYPING then
				Window:ToggleInterface()
			end
		end;
	end)));

	function Window:ToggleInterface()
		Window.Signal:SetValue(not Window.Signal:GetValue());

		if Window.__3DRender then
			Window.Load3DBlock();
		end;
	end;

	function Window:Watermark()
		if NeverLose.__WatermarkCache then
			return NeverLose.__WatermarkCache;
		end;

		local Watermark_lb = {};
		local Watermark = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local UIListLayout = Instance.new("UIListLayout")
		local Shadow = NeverLose:CreateShadow(Watermark);

		Watermark.Name = NeverLose.RandomString();
		Watermark.Parent = NeverLose.ScreenGui
		Watermark.AnchorPoint = Vector2.new(1, 0)
		Watermark.BackgroundColor3 = Color3.fromRGB(8, 8, 13)
		Watermark.BackgroundTransparency = 0.200
		Watermark.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Watermark.BorderSizePixel = 0
		Watermark.ClipsDescendants = true
		Watermark.Position = UDim2.new(1, -10, 0, 10)
		Watermark.Size = UDim2.new(0, 120, 0, 30)
		Watermark.ZIndex = 16

		UICorner.CornerRadius = UDim.new(0, 25)
		UICorner.Parent = Watermark

		UIListLayout.Parent = Watermark
		UIListLayout.FillDirection = Enum.FillDirection.Horizontal
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right

		local empty_space = Instance.new('Frame');

		empty_space.Size = UDim2.fromOffset(15,0);
		empty_space.BackgroundTransparency = 1;
		empty_space.Parent = Watermark;
		empty_space.LayoutOrder = 5;

		Watermark:GetPropertyChangedSignal('BackgroundTransparency'):Connect(LPH_NO_VIRTUALIZE(function()
			if Watermark.BackgroundTransparency > 0.9 then
				Watermark.Visible = false;
				Watermark.Parent = nil;
			else
				Watermark.Parent = NeverLose.ScreenGui
				Watermark.Visible = true;
			end;
		end));

		UIListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(LPH_NO_VIRTUALIZE(function()
			NeverLose.PlayAnimate(Watermark , SlowyTween , {
				Size = UDim2.new(0, UIListLayout.AbsoluteContentSize.X + 5, 0, 30)
			})
		end));

		NeverLose.__WatermarkCache = Watermark_lb;

		Shadow:Render(true);

		Watermark_lb.Renders = {};
		Watermark_lb.Status = true;

		function Watermark_lb:SetRender(value)
			Watermark_lb.Status = value;

			if value then
				NeverLose.PlayAnimate(Watermark,SlowyTween , {
					BackgroundTransparency = 0.200
				})

				Shadow:Render(true);

				for i,v in next , Watermark_lb.Renders do
					pcall(v,true);
				end;
			else
				NeverLose.PlayAnimate(Watermark,SlowyTween , {
					BackgroundTransparency = 1
				})

				Shadow:Render(false);

				for i,v in next , Watermark_lb.Renders do
					pcall(v,false);
				end;
			end
		end;

		function Watermark_lb:AddBlock(IconStr , Name)
			local InnerBlock = {};

			local Frame = Instance.new("Frame")
			local Content = Instance.new("TextLabel")
			local Icon = Instance.new("TextLabel")

			Frame.Parent = Watermark
			Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Frame.BackgroundTransparency = 1.000
			Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Frame.BorderSizePixel = 0
			Frame.Size = UDim2.new(0, 50, 0, 30)

			Content.Name = NeverLose.RandomString();
			Content.Parent = Frame
			Content.AnchorPoint = Vector2.new(0, 0.5)
			Content.BackgroundColor3 = Color3.fromRGB(186, 186, 186)
			Content.BackgroundTransparency = 1.000
			Content.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Content.BorderSizePixel = 0
			Content.Position = UDim2.new(0, 35, 0.5, 0)
			Content.Size = UDim2.new(0, 1, 0, 25)
			Content.ZIndex = 17
			Content.Font = Enum.Font.GothamBold
			Content.Text = Name
			Content.TextColor3 = Color3.fromRGB(186, 186, 186)
			Content.TextSize = 15.000
			Content.TextTransparency = 0.200
			Content.TextXAlignment = Enum.TextXAlignment.Left

			Icon.Name = NeverLose.RandomString();
			Icon.Parent = Frame
			Icon.AnchorPoint = Vector2.new(0, 0.5)
			Icon.BackgroundColor3 = Color3.fromRGB(186, 186, 186)
			Icon.BackgroundTransparency = 1.000
			Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Icon.BorderSizePixel = 0
			Icon.Position = UDim2.new(0, 10, 0.5, 0)
			Icon.Size = UDim2.new(0, 20, 0, 20)
			Icon.ZIndex = 17
			Icon.FontFace = NeverLose.BuiltInBold;
			Icon.Text = IconStr
			Icon.TextColor3 = NeverLose.AccentColor
			Icon.TextSize = 18.000
			Icon.TextTransparency = 0.250
			Icon.TextWrapped = true

			InnerBlock.Update = LPH_NO_VIRTUALIZE(function(value)
				local size = TextService:GetTextSize(Content.Text , Content.TextSize,Content.Font,Vector2.new(math.huge,math.huge))

				if InnerBlock.Visible then
					NeverLose.PlayAnimate(Frame,VSlowTween,{
						Size = UDim2.new(0, size.X + 35, 0, 30)
					})
				else
					NeverLose.PlayAnimate(Frame,VSlowTween,{
						Size = UDim2.new(0, 0, 0, 30)
					})
				end;
			end);

			InnerBlock.Visible = true;

			InnerBlock.Update();

			function InnerBlock:SetVisible(v)
				InnerBlock.Visible = v;

				if Watermark_lb.Status then
					InnerBlock.SetRender(v);
				end;

				InnerBlock.Update();
			end;

			InnerBlock.SetRender = LPH_NO_VIRTUALIZE(function(value)
				if value and InnerBlock.Visible then
					NeverLose.PlayAnimate(Content,SlowyTween , {
						TextTransparency = 0.200
					})

					NeverLose.PlayAnimate(Icon,SlowyTween , {
						TextTransparency = 0.250
					})
				else

					NeverLose.PlayAnimate(Content,SlowyTween , {
						TextTransparency = 1
					})

					NeverLose.PlayAnimate(Icon,SlowyTween , {
						TextTransparency = 1
					})
				end;
			end);

			table.insert(Watermark_lb.Renders,InnerBlock.SetRender);

			function InnerBlock:SetText(t)
				Content.Text = t;

				InnerBlock.Update();
			end;

			function InnerBlock:Input(func)
				local c,s = NeverLose:CreateInput(Frame,func);

				return s;
			end;

			return InnerBlock;
		end;

		return Watermark_lb;
	end;

	Window:SetRender(false);

	return Window;
end;

function NeverLose:CreateNotification()
	if NeverLose.__Notification_Cache then
		return NeverLose.__Notification_Cache;
	end;

	local Notifier = {};
	local Notification = Instance.new("Frame")
	local UIListLayout = Instance.new("UIListLayout")

	Notification.Name = NeverLose.RandomString();
	Notification.Parent = NeverLose.ScreenGui;
	Notification.AnchorPoint = Vector2.new(1, 0)
	Notification.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Notification.BackgroundTransparency = 1.000
	Notification.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Notification.BorderSizePixel = 0
	Notification.Position = UDim2.new(1, -25, 0, 25)
	Notification.Size = UDim2.new(0, 25, 0, 25)

	UIListLayout.Parent = Notification
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 0)

	NeverLose.__Notification_Cache = Notifier;

	function Notifier.new(Config)
		Config = NeverLose:ProcessParams(Config , {
			Title = "Notification",
			Content = "Hello World!",
			Logo = NeverLose.GlobalLogo or "rbxasset://textures/ui/VerifiedBadgeNameIcon.png",
			Duration = 5,
		});

		if NeverLose.__WatermarkCache then
			NeverLose.PlayAnimate(Notification,SlowyTween , {
				Position = UDim2.new(1, -25, 0, 55)
			});
		end;

		local ContainerFrame = Instance.new("Frame")
		local NotifyFrame = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local UIStroke = Instance.new("UIStroke")
		local LogoImage = Instance.new("ImageLabel")
		local UICorner_2 = Instance.new("UICorner")
		local NotifyName = Instance.new("TextLabel")
		local NotifyContent = Instance.new("TextLabel");
		local shadow = NeverLose:CreateShadow(NotifyFrame , true);

		ContainerFrame.Name = NeverLose.RandomString();
		ContainerFrame.Parent = Notification
		ContainerFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ContainerFrame.BackgroundTransparency = 1.000
		ContainerFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ContainerFrame.BorderSizePixel = 0
		ContainerFrame.Size = UDim2.new(0, 0, 0, 100)

		NotifyFrame.Name = NeverLose.RandomString();
		NotifyFrame.Parent = ContainerFrame
		NotifyFrame.AnchorPoint = Vector2.new(1, 0)
		NotifyFrame.BackgroundColor3 = Color3.fromRGB(20, 22, 27)
		NotifyFrame.BackgroundTransparency = 0.075
		NotifyFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		NotifyFrame.BorderSizePixel = 0
		NotifyFrame.ClipsDescendants = true
		NotifyFrame.Position = UDim2.new(0, 750, 0, 0)
		NotifyFrame.Size = UDim2.new(0, 220, 0, 55)
		NotifyFrame.ZIndex = 130

		UICorner.CornerRadius = UDim.new(0, 10)
		UICorner.Parent = NotifyFrame

		UIStroke.Transparency = 0.650
		UIStroke.Color = Color3.fromRGB(45, 48, 58)
		UIStroke.Parent = NotifyFrame

		LogoImage.Name = NeverLose.RandomString();
		LogoImage.Parent = NotifyFrame
		LogoImage.AnchorPoint = Vector2.new(0, 0.5)
		LogoImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		LogoImage.BackgroundTransparency = 1.000
		LogoImage.BorderColor3 = Color3.fromRGB(0, 0, 0)
		LogoImage.BorderSizePixel = 0
		LogoImage.Position = UDim2.new(0, 10, 0.5, 0)
		LogoImage.Size = UDim2.new(0, 35, 0, 35)
		LogoImage.ZIndex = 131
		LogoImage.Image = Config.Logo
		LogoImage.ImageColor3 = NeverLose.IconColor;

		UICorner_2.CornerRadius = UDim.new(0, 7)
		UICorner_2.Parent = LogoImage

		NotifyName.Name = NeverLose.RandomString();
		NotifyName.Parent = NotifyFrame
		NotifyName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		NotifyName.BackgroundTransparency = 1.000
		NotifyName.BorderColor3 = Color3.fromRGB(0, 0, 0)
		NotifyName.BorderSizePixel = 0
		NotifyName.Position = UDim2.new(0, 50, 0, 7)
		NotifyName.Size = UDim2.new(0, 200, 0, 20)
		NotifyName.ZIndex = 132
		NotifyName.Font = Enum.Font.GothamBold
		NotifyName.Text = Config.Title
		NotifyName.TextColor3 = Color3.fromRGB(255, 255, 255)
		NotifyName.TextSize = 17.000
		NotifyName.TextXAlignment = Enum.TextXAlignment.Left

		NotifyContent.Name = NeverLose.RandomString();
		NotifyContent.Parent = NotifyFrame
		NotifyContent.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		NotifyContent.BackgroundTransparency = 1.000
		NotifyContent.BorderColor3 = Color3.fromRGB(0, 0, 0)
		NotifyContent.BorderSizePixel = 0
		NotifyContent.Position = UDim2.new(0, 50, 0, 28)
		NotifyContent.Size = UDim2.new(0, 200, 0, 15)
		NotifyContent.ZIndex = 132
		NotifyContent.Font = Enum.Font.GothamBold
		NotifyContent.Text = Config.Content
		NotifyContent.TextColor3 = Color3.fromRGB(255, 255, 255)
		NotifyContent.TextSize = 12.000
		NotifyContent.TextTransparency = 0.650
		NotifyContent.TextXAlignment = Enum.TextXAlignment.Left

		local Size1 = TextService:GetTextSize(NotifyName.Text,NotifyName.TextSize,NotifyName.Font,Vector2.new(math.huge,math.huge));
		local Size2 = TextService:GetTextSize(NotifyContent.Text,NotifyContent.TextSize,NotifyContent.Font,Vector2.new(math.huge,math.huge));

		local MainSize = math.max(Size1.X , Size2.X);

		NotifyFrame.Size = UDim2.new(0, MainSize + 65, 0, 55);

		shadow:Render(true)
		NeverLose.PlayAnimate(NotifyFrame , VSlowTween , {
			Position = UDim2.new(1, 0, 0, 0)
		})

		ContainerFrame.Size = UDim2.new(0, 0, 0, 65)

		task.delay(Config.Duration or 5 , LPH_NO_VIRTUALIZE(function()

			if NeverLose.__WatermarkCache then
				NeverLose.PlayAnimate(Notification,SlowyTween , {
					Position = UDim2.new(1, -25, 0, 55)
				});
			end;

			shadow:Render(false)

			NeverLose.PlayAnimate(NotifyFrame , SlowyTween , {
				BackgroundTransparency = 1
			})

			NeverLose.PlayAnimate(UIStroke , SlowyTween , {
				Transparency = 1
			})

			NeverLose.PlayAnimate(LogoImage , SlowyTween , {
				ImageTransparency = 1
			})

			NeverLose.PlayAnimate(NotifyName , SlowyTween , {
				TextTransparency = 1
			})

			NeverLose.PlayAnimate(NotifyContent , SlowyTween , {
				TextTransparency = 1
			})

			task.wait(0.125);

			NeverLose.PlayAnimate(ContainerFrame , SlowyTween , {
				Size = UDim2.new(0, 0, 0, 0)
			})

			task.wait(0.125);

			ContainerFrame:Destroy();
		end))
	end;

	return Notifier;
end;

function NeverLose:CreateLogger()
	if NeverLose.__LogSystem then
		return 	NeverLose.__LogSystem;
	end;

	local Logging = {};
	local Log = Instance.new("Frame")
	local UIListLayout = Instance.new("UIListLayout")

	Log.Name = NeverLose.RandomString();
	Log.Parent = NeverLose.ScreenGui
	Log.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Log.BackgroundTransparency = 1.000
	Log.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Log.BorderSizePixel = 0
	Log.Position = UDim2.new(0, 25, 0, 5 + math.abs(NeverLose.ScreenGui.AbsolutePosition.Y))
	Log.Size = UDim2.new(0, 25, 0, 25)

	UIListLayout.Parent = Log
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 12)

	NeverLose.__LogSystem = Logging;

	function Logging.new(IconStr: string , Message: string , Duration: number)
		Duration = Duration or 3;
		Message = Message or "Log";
		IconStr = IconStr or "crosshairs";

		local LogFrame = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local UIStroke = Instance.new("UIStroke")
		local LogContent = Instance.new("TextLabel")
		local Line = Instance.new("Frame")
		local UICorner_2 = Instance.new("UICorner")
		local Icon = Instance.new("TextLabel")
		local Shadow = NeverLose:CreateShadow(LogFrame , true);

		LogFrame.Name = NeverLose.RandomString();
		LogFrame.Parent = Log
		LogFrame.AnchorPoint = Vector2.new(0.5, 0)
		LogFrame.BackgroundColor3 = Color3.fromRGB(20, 22, 27)
		LogFrame.BackgroundTransparency =  1--0.075
		LogFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		LogFrame.BorderSizePixel = 0
		LogFrame.ClipsDescendants = true
		LogFrame.Position = UDim2.new(0,0,0,0)
		LogFrame.Size = UDim2.new(0, 0, 0, 20)
		LogFrame.ZIndex = 130

		UICorner.CornerRadius = UDim.new(0, 4)
		UICorner.Parent = LogFrame

		UIStroke.Transparency = 1--0.650
		UIStroke.Color = Color3.fromRGB(45, 48, 58)
		UIStroke.Parent = LogFrame

		LogContent.Name = NeverLose.RandomString();
		LogContent.Parent = LogFrame
		LogContent.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		LogContent.BackgroundTransparency = 1.000
		LogContent.BorderColor3 = Color3.fromRGB(0, 0, 0)
		LogContent.BorderSizePixel = 0
		LogContent.Position = UDim2.new(0, 25, 0, 2)
		LogContent.Size = UDim2.new(0, 200, 0, 15)
		LogContent.ZIndex = 132
		LogContent.Font = Enum.Font.GothamBold
		LogContent.Text = Message
		LogContent.TextColor3 = Color3.fromRGB(255, 255, 255)
		LogContent.TextSize = 12.000
		LogContent.TextTransparency = 1--0.250
		LogContent.TextXAlignment = Enum.TextXAlignment.Left

		Line.Name = NeverLose.RandomString();
		Line.Parent = LogFrame
		Line.AnchorPoint = Vector2.new(0, 0.5)
		Line.BackgroundColor3 = NeverLose.AccentColor
		Line.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Line.BackgroundTransparency = 1 --0
		Line.BorderSizePixel = 0
		Line.Position = UDim2.new(0, -2, 0.5, 0)
		Line.Size = UDim2.new(0, 5, 1, 0)
		Line.ZIndex = 131

		UICorner_2.CornerRadius = UDim.new(0, 4)
		UICorner_2.Parent = Line

		Icon.Name = NeverLose.RandomString();
		Icon.Parent = LogFrame
		Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Icon.BackgroundTransparency = 1.000
		Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Icon.BorderSizePixel = 0
		Icon.Position = UDim2.new(0, 7, 0, 3)
		Icon.Size = UDim2.new(0, 15, 0, 15)
		Icon.ZIndex = 133
		Icon.FontFace = NeverLose.BuiltInBold
		Icon.Text = IconStr
		Icon.TextColor3 = Color3.fromRGB(223, 223, 223)
		Icon.TextSize = 13.000
		Icon.TextTransparency = 1--0.250
		Icon.TextWrapped = true

		local size = TextService:GetTextSize(LogContent.Text,LogContent.TextSize,LogContent.Font,Vector2.new(math.huge,math.huge));

		NeverLose.PlayAnimate(LogFrame , SlowyTween , {
			Size = UDim2.new(0, size.X + 35, 0, 20),
			BackgroundTransparency =  0.075
		});

		task.delay(0.15,LPH_NO_VIRTUALIZE(function()
			Shadow:Render(true);

			NeverLose.PlayAnimate(UIStroke , SlowyTween , {
				Transparency = 0.650
			});

			NeverLose.PlayAnimate(LogContent , SlowyTween , {
				TextTransparency = 0.25
			});

			NeverLose.PlayAnimate(Line , SlowyTween , {
				BackgroundTransparency = 0
			});

			NeverLose.PlayAnimate(Icon , SlowyTween , {
				TextTransparency = 0.25
			});

			task.wait(Duration + 0.1);

			Shadow:Render(false);

			NeverLose.PlayAnimate(LogFrame , SlowyTween , {
				BackgroundTransparency =  1
			});

			NeverLose.PlayAnimate(UIStroke , SlowyTween , {
				Transparency = 1
			});

			NeverLose.PlayAnimate(LogContent , SlowyTween , {
				TextTransparency = 1
			});

			NeverLose.PlayAnimate(Line , SlowyTween , {
				BackgroundTransparency = 1
			});

			NeverLose.PlayAnimate(Icon , SlowyTween , {
				TextTransparency = 1
			});

			task.wait(0.25);

			LogFrame:Destroy();
		end))
	end;

	return Logging
end;

function NeverLose:CreateIndicator()
	local IndicatorFrame = Instance.new("Frame")
	local UIListLayout = Instance.new("UIListLayout")

	IndicatorFrame.Name = NeverLose.RandomString();
	IndicatorFrame.Parent = NeverLose.ScreenGui;
	IndicatorFrame.AnchorPoint = Vector2.new(0, 0.5)
	IndicatorFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	IndicatorFrame.BackgroundTransparency = 1.000
	IndicatorFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	IndicatorFrame.BorderSizePixel = 0
	IndicatorFrame.Position = UDim2.new(0, 15, 0.5, 0)
	IndicatorFrame.Size = UDim2.new(0, 100, 0, 100)
	IndicatorFrame.ZIndex = 15

	UIListLayout.Parent = IndicatorFrame
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 10)

	local Indicators = {};

	Indicators.Color = {
		Red = Color3.fromRGB(255, 102, 105),
		Green = Color3.fromRGB(135, 255, 143),
		White = Color3.fromRGB(186, 186, 186),
	};

	Indicators.Root = IndicatorFrame;

	function Indicators.new(Config)
		Config = NeverLose:ProcessParams(Config , {
			Name = "Indicator",
			Icon = 'crosshairs',
			Color = 'Red',
		});

		local Indicator = {
			CurrentColor = Config.Color,	
			Visible = false,
		};

		local IndicatorItem = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local Line = Instance.new("Frame")
		local UICorner_2 = Instance.new("UICorner")
		local UIGradient = Instance.new("UIGradient")
		local Icon = Instance.new("TextLabel")
		local Content = Instance.new("TextLabel")
		local Shadow = NeverLose:CreateShadow(IndicatorItem);

		IndicatorItem.Name = NeverLose.RandomString();
		IndicatorItem.BackgroundColor3 = Color3.fromRGB(8, 8, 13)
		IndicatorItem.BackgroundTransparency = 1
		IndicatorItem.BorderColor3 = Color3.fromRGB(0, 0, 0)
		IndicatorItem.BorderSizePixel = 0
		IndicatorItem.ClipsDescendants = true
		IndicatorItem.Size = UDim2.new(0, 85, 0, 40)
		IndicatorItem.ZIndex = 16
		IndicatorItem.Visible = false;

		IndicatorItem:GetPropertyChangedSignal('BackgroundTransparency'):Connect(LPH_NO_VIRTUALIZE(function()
			if IndicatorItem.BackgroundTransparency > 0.9 then
				IndicatorItem.Parent = nil;
				IndicatorItem.Visible = false;
			else
				IndicatorItem.Parent = IndicatorFrame;
				IndicatorItem.Visible = true;
			end;
		end))

		UICorner.CornerRadius = UDim.new(0, 25)
		UICorner.Parent = IndicatorItem

		Line.Name = NeverLose.RandomString();
		Line.Parent = IndicatorItem
		Line.AnchorPoint = Vector2.new(0, 0.5)
		Line.BackgroundColor3 = Color3.fromRGB(186, 186, 186)
		Line.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Line.BorderSizePixel = 0
		Line.Position = UDim2.new(0, 2, 0.5, 0)
		Line.BackgroundTransparency = 1;
		Line.Size = UDim2.new(0, 3, 0.649999976, 0)
		Line.ZIndex = 17

		UICorner_2.CornerRadius = UDim.new(0, 25)
		UICorner_2.Parent = Line

		UIGradient.Rotation = 90
		UIGradient.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 1.00), NumberSequenceKeypoint.new(0.50, 0.00), NumberSequenceKeypoint.new(1.00, 1.00)}
		UIGradient.Parent = Line

		Icon.Name = NeverLose.RandomString();
		Icon.Parent = IndicatorItem
		Icon.AnchorPoint = Vector2.new(0, 0.5)
		Icon.BackgroundColor3 = Color3.fromRGB(186, 186, 186)
		Icon.BackgroundTransparency = 1.000
		Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Icon.BorderSizePixel = 0
		Icon.Position = UDim2.new(0, 10, 0.5, 0)
		Icon.Size = UDim2.new(0, 25, 0, 25)
		Icon.ZIndex = 17
		Icon.FontFace = NeverLose.BuiltInBold;
		Icon.Text = Config.Icon
		Icon.TextColor3 = Color3.fromRGB(186, 186, 186)
		Icon.TextSize = 21.000
		Icon.TextTransparency = 1
		Icon.TextWrapped = true

		Content.Name = NeverLose.RandomString();
		Content.Parent = IndicatorItem
		Content.AnchorPoint = Vector2.new(0, 0.5)
		Content.BackgroundColor3 = Color3.fromRGB(186, 186, 186)
		Content.BackgroundTransparency = 1.000
		Content.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Content.BorderSizePixel = 0
		Content.Position = UDim2.new(0, 40, 0.5, 0)
		Content.Size = UDim2.new(1, -40, 0, 25)
		Content.ZIndex = 17
		Content.Font = Enum.Font.GothamBold
		Content.Text = Config.Name
		Content.TextColor3 = Color3.fromRGB(186, 186, 186)
		Content.TextSize = 20.000
		Content.TextTransparency = 1
		Content.TextXAlignment = Enum.TextXAlignment.Left

		Indicator.Update = LPH_NO_VIRTUALIZE(function()
			local text = TextService:GetTextSize(Content.Text,Content.TextSize , Content.Font , Vector2.new(math.huge,math.huge));

			NeverLose.PlayAnimate(IndicatorItem , SlowyTween , {
				Size = UDim2.new(0, text.X + 60, 0, 40);
			})
		end);

		Indicator.SetRender = LPH_NO_VIRTUALIZE(function(self , value)
			Indicator.Visible = value;

			if value then
				NeverLose.PlayAnimate(IndicatorItem , SlowyTween , {
					BackgroundTransparency = 0.200
				});

				NeverLose.PlayAnimate(Line , SlowyTween , {
					BackgroundTransparency = 0,
					BackgroundColor3 = Indicators.Color[Indicator.CurrentColor]
				});

				NeverLose.PlayAnimate(Icon , VSlowTween , {
					TextTransparency = 0.250,
					TextColor3 = Indicators.Color[Indicator.CurrentColor]
				});

				NeverLose.PlayAnimate(Content , VSlowTween , {
					TextTransparency = 0.2,
					TextColor3 = Indicators.Color[Indicator.CurrentColor]
				});

				Shadow:Render(true);
			else
				NeverLose.PlayAnimate(IndicatorItem , SlowyTween , {
					BackgroundTransparency = 1
				});

				NeverLose.PlayAnimate(Line , SlowyTween , {
					BackgroundTransparency = 1,
					BackgroundColor3 = Indicators.Color[Indicator.CurrentColor]
				});

				NeverLose.PlayAnimate(Icon , VSlowTween , {
					TextTransparency = 1,
					TextColor3 = Indicators.Color[Indicator.CurrentColor]
				});

				NeverLose.PlayAnimate(Content , VSlowTween , {
					TextTransparency = 1,
					TextColor3 = Indicators.Color[Indicator.CurrentColor]
				});

				Shadow:Render(false);
			end;

			Indicator.Update();
		end);

		Indicator.Update();
		Indicator:SetRender(false);

		function Indicator:SetColor(new_color)
			Indicator.CurrentColor = new_color;

			if Indicator.Visible then
				Indicator:SetRender(true);
			end;
		end;

		function Indicator:SetText(name)
			Config.Name = name;

			Content.Text = Config.Name;

			Indicator.Update();
		end;

		return Indicator;
	end;

	return Indicators;
end;

function NeverLose:Unload()
	if not NeverLose.UnloadEnabled then
		return;	
	end;

	NeverLose.ScreenGui:Destroy();

	for i,v in next , NeverLose.GlobalSignals do
		pcall(v.Disconnect,v)
	end;
end;

return NeverLose;

]=====]

local SRC_MM2 = [=====[
-- Maneware MM2 v11.14 | Loader с диагностикой (Delta, телефон)
-- Если меню не появилось, на экране будет красная плашка с текстом ошибки.
local SRC = [==[-- Maneware MM2 v11 | Mobile (Delta)
-- v11.10: GUI fix for Delta 2.743.1136 (gethui -> CoreGui -> PlayerGui, watchdog, probe)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local StarterGui = game:GetService("StarterGui")
local VirtualUser = game:GetService("VirtualUser")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() Camera = workspace.CurrentCamera end)

local DATA_DIR = "ManewareMM2"
local function ensureDir()
    pcall(function()
        if isfolder and makefolder and not isfolder(DATA_DIR) then makefolder(DATA_DIR) end
    end)
end
local function readJson(name)
    local ok, data = pcall(function()
        if isfile and readfile and isfile(DATA_DIR .. "/" .. name) then
            return HttpService:JSONDecode(readfile(DATA_DIR .. "/" .. name))
        end
    end)
    if ok and type(data) == "table" then return data end
    return nil
end
local function writeJson(name, tbl)
    ensureDir()
    return pcall(function() writefile(DATA_DIR .. "/" .. name, HttpService:JSONEncode(tbl)) end)
end
-- UID = порядковый номер запуска скрипта. v11.11: один раз возвращён на 39, дальше считает как раньше (40, 41...)
local UID = 39
pcall(function()
    ensureDir()
    if isfile and readfile and writefile then
        local marker = DATA_DIR .. "/uid_fix39.txt"
        if not isfile(marker) then
            UID = 39
            writefile(marker, "1")
        else
            local n = 38
            if isfile(DATA_DIR .. "/uid.txt") then n = tonumber(readfile(DATA_DIR .. "/uid.txt")) or 38 end
            UID = n + 1
        end
        writefile(DATA_DIR .. "/uid.txt", tostring(UID))
    end
end)

local C = {
    BG = Color3.fromRGB(18, 18, 24), SIDEBAR = Color3.fromRGB(24, 24, 32),
    TOPBAR = Color3.fromRGB(28, 28, 38), ELEMENT = Color3.fromRGB(32, 32, 44),
    ACCENT = Color3.fromRGB(99, 102, 241), GREEN = Color3.fromRGB(34, 197, 94),
    RED = Color3.fromRGB(239, 68, 68), TEXT = Color3.fromRGB(240, 240, 245),
    DIM = Color3.fromRGB(120, 120, 140), BORDER = Color3.fromRGB(45, 45, 60),
}

--------------------------------------------------
-- ИКОНКИ: "rbxassetid://ID" или ссылка "https://.../icon.png"
-- Замени любую на свою
--------------------------------------------------
local ICONS = {
    MENU   = "rbxassetid://10734898355",
    HOME   = "rbxassetid://10723407389",
    EYE    = "rbxassetid://10723346959",
    SPEED  = "rbxassetid://10709752035",
    NOCLIP = "rbxassetid://10723346871",
    FLY    = "rbxassetid://10723354359",
    TARGET = "rbxassetid://10734898355",
    HAT    = "rbxassetid://10723407389",
    AIM    = "rbxassetid://10734898355",
    TP     = "rbxassetid://10723354359",
    GUN    = "rbxassetid://10723346959",
    COIN   = "rbxassetid://10709752035",
    SHIELD = "rbxassetid://10723346871",
    UTIL   = "rbxassetid://10723407389",
    FLING  = "rbxassetid://10723354359",
}

local function resolveIcon(id, name)
    if type(id) == "string" and id:sub(1, 4) == "http" then
        local ok, res = pcall(function()
            local fname = "mw_" .. (name or "icon") .. ".png"
            writefile(fname, game:HttpGet(id))
            return getcustomasset(fname)
        end)
        return ok and res or ""
    end
    return id or ""
end
for k, v in pairs(ICONS) do ICONS[k] = resolveIcon(v, k) end

-- Логотип Maneware (замени rbxassetid на свой с фото)
local LOGO_ID = "rbxassetid://10734898355"


--------------------------------------------------
-- УТИЛИТЫ
--------------------------------------------------
local function new(class, props, parent)
    local o = Instance.new(class)
    for k, v in pairs(props or {}) do pcall(function() o[k] = v end) end
    if parent then o.Parent = parent end
    return o
end
local function tw(o, t, p)
    local ok, tween = pcall(function()
        return TweenService:Create(o, TweenInfo.new(t, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), p)
    end)
    if ok then tween:Play() return tween end
end
local function corner(r, p) return new("UICorner", {CornerRadius = UDim.new(0, r or 8)}, p) end
-- Порядок родителей: PlayerGui -> gethui -> CoreGui (в PlayerGui тач/скролл работают надёжно)
local function getGuiParents()
    local list = {}
    local pg = LocalPlayer:FindFirstChild("PlayerGui")
    if not pg then pcall(function() pg = LocalPlayer:WaitForChild("PlayerGui", 8) end) end
    if pg then table.insert(list, pg) end
    pcall(function() if gethui then table.insert(list, gethui()) end end)
    pcall(function() table.insert(list, game:GetService("CoreGui")) end)
    return list
end
local function makeGui(name, order)
    local parents = getGuiParents()
    for _, p in ipairs(parents) do
        pcall(function()
            local old = p:FindFirstChild(name)
            if old then old:Destroy() end
        end)
    end
    local sg = Instance.new("ScreenGui")
    sg.Name = name
    sg.ResetOnSpawn = false
    sg.IgnoreGuiInset = true
    sg.DisplayOrder = order or 100
    sg.Enabled = true
    sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    pcall(function() sg.ClipToDeviceSafeArea = false end)
    pcall(function() if syn and syn.protect_gui then syn.protect_gui(sg) end end)
    pcall(function() if protect_gui then protect_gui(sg) end end)
    local function attach()
        for _, p in ipairs(parents) do
            local ok = pcall(function() sg.Parent = p end)
            if ok and sg.Parent == p then return true end
        end
        return false
    end
    if not attach() then warn("[Maneware] ScreenGui " .. name .. " не удалось прикрепить") end
    task.spawn(function() -- если кто-то снял GUI с родителя, вернуть
        while task.wait(1) do
            if not sg.Parent then attach() end
        end
    end)
    return sg
end
local function createIcon(id, size, parent)
    return new("ImageLabel", {Size = size, BackgroundTransparency = 1, Image = id or "",
        ImageColor3 = C.TEXT, ScaleType = Enum.ScaleType.Fit}, parent)
end
local function onTap(btn, fn) btn.Activated:Connect(fn) end
local NT = {} -- хуки уведомлений (send/toggle заполняются ниже)
local function notify(text)
    text = tostring(text)
    local title, msg = text:match("^([^:]-):%s*(.+)$") -- "Название: сообщение" -> две строки карточки
    if NT.send then
        NT.send(title or "Maneware", msg or text)
    else
        pcall(function()
            StarterGui:SetCore("SendNotification", {Title = "Maneware", Text = text, Duration = 3})
        end)
    end
end

--------------------------------------------------
-- ГЛАВНОЕ ОКНО
--------------------------------------------------
local function addRow(holder, order, label, actions)
    local row = new("Frame", {Size = UDim2.new(1, 0, 0, 46), BackgroundColor3 = C.ELEMENT,
        BorderSizePixel = 0, LayoutOrder = order}, holder)
    corner(10, row)
    new("UIStroke", {Color = C.BORDER, Thickness = 1}, row)
    local right = 8
    for idx = #actions, 1, -1 do
        local a = actions[idx]
        local w = a.w or 76
        local b = new("TextButton", {Size = UDim2.new(0, w, 0, 32), Position = UDim2.new(1, -(right + w), 0.5, -16),
            BackgroundColor3 = a.color or C.ACCENT, Text = a.text, TextColor3 = C.TEXT, TextSize = a.size or 12,
            Font = Enum.Font.GothamBold, BorderSizePixel = 0}, row)
        corner(8, b)
        onTap(b, function() task.spawn(a.fn) end)
        right = right + w + 6
    end
    new("TextLabel", {Size = UDim2.new(1, -(right + 12), 1, 0), Position = UDim2.new(0, 12, 0, 0),
        BackgroundTransparency = 1, Text = label, TextColor3 = C.TEXT, TextSize = 13,
        Font = Enum.Font.GothamSemibold, TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd}, row)
    return row
end

local hubGui = makeGui("ManewareHub", 9999) -- оверлеи (доп. окна поверх); само меню рисует Neverlose UI
local FULL = UDim2.new(0, 0, 0, 0)
local main = new("Frame", {Name = "MWShim", Size = FULL, BackgroundTransparency = 1, Visible = true}, hubGui)
local closeBtn = new("TextButton", {Name = "MWShimClose", Size = UDim2.new(0, 1, 0, 1), BackgroundTransparency = 1,
    Text = "", Visible = false}, hubGui)

local REG = {} -- реестр: имя настройки -> get/set (для конфигов)
local ACT = {} -- кнопки-действия (для биндов)
local X = {}   -- общие функции между блоками

--------------------------------------------------
-- NEVERLOSE UI (библиотека приходит из Maneware Hub)
--------------------------------------------------
local NeverLose, NLWin
do
    local env = (getgenv and getgenv()) or _G
    local oldNL = env.__MW_NL_OBJ
    if oldNL then
        pcall(function() oldNL.ScreenGui:Destroy() end)
        pcall(function()
            for _, c in pairs(oldNL.GlobalSignals) do pcall(function() c:Disconnect() end) end
        end)
    end
    local libSrc = env.__MW_NL_SRC
    if type(libSrc) ~= "string" then
        error("Neverlose UI: библиотека не передана (запускай через Maneware Hub)")
    end
    local libFn, libErr = loadstring(libSrc, "=NeverLoseUI")
    if not libFn then error("Neverlose UI compile: " .. tostring(libErr)) end
    NeverLose = libFn()
    env.__MW_NL_OBJ = NeverLose
end
pcall(function() NeverLose.EnabledBlur = false end)

local guiScale = 1
pcall(function()
    local saved = readJson("gui.json")
    if saved and tonumber(saved.nlscale) then guiScale = math.clamp(tonumber(saved.nlscale), 0.7, 1.4) end
end)
local WINBASE = {}
do
    local vp = Vector2.new(1280, 720)
    pcall(function()
        local v = workspace.CurrentCamera.ViewportSize
        if v.X > 200 and v.Y > 200 then vp = v end
    end)
    WINBASE.w = math.min(640, math.floor(vp.X * 0.96))
    WINBASE.h = math.min(NeverLose.IsMobile and 385 or 480, math.floor(vp.Y * 0.92))
end
local function winSize()
    return UDim2.fromOffset(math.floor(WINBASE.w * guiScale), math.floor(WINBASE.h * guiScale))
end

NLWin = NeverLose:CreateWindow({
    Name = "Maneware",
    Content = "Murder Mystery 2 | v11",
    Size = winSize(),
    ConfigFolder = "ManewareNL",
    Keybind = "MWNoKey", -- открытие/закрытие делает MM2 (Insert / RightControl / кнопка)
    Logo = LOGO_ID,
})

local function setGuiScale(s)
    s = math.clamp(tonumber(s) or 1, 0.7, 1.4)
    s = math.floor(s * 10 + 0.5) / 10
    guiScale = s
    pcall(function() NLWin:SetSize(winSize()) end)
    pcall(function() writeJson("gui.json", {nlscale = s}) end)
end

-- Z-индексы для своих (сырых) строк: у Neverlose ZIndexBehavior = Global
local function zfix(obj, z)
    if obj:IsA("GuiObject") then obj.ZIndex = z end
    for _, ch in ipairs(obj:GetChildren()) do zfix(ch, z + 1) end
end

-- строка со списком кнопок (конфиги, бинды): подпись сверху, кнопки в ряд снизу
addRow = function(holder, order, label, actions)
    local row = new("Frame", {Size = UDim2.new(1, -8, 0, 64), BackgroundColor3 = Color3.fromRGB(26, 28, 36),
        BorderSizePixel = 0, LayoutOrder = order}, holder)
    corner(8, row)
    new("UIStroke", {Color = Color3.fromRGB(45, 48, 58), Thickness = 1}, row)
    new("TextLabel", {Size = UDim2.new(1, -12, 0, 24), Position = UDim2.new(0, 8, 0, 4), BackgroundTransparency = 1,
        Text = label, TextColor3 = C.TEXT, TextSize = 12, Font = Enum.Font.GothamMedium,
        TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd}, row)
    local n = #actions
    for j = 1, n do
        local a = actions[n + 1 - j]
        local b = new("TextButton", {Size = UDim2.new(1 / n, -6, 0, 26), Position = UDim2.new((j - 1) / n, 4, 1, -31),
            BackgroundColor3 = a.color or C.ACCENT, Text = a.text, TextColor3 = C.TEXT, TextSize = a.size or 11,
            Font = Enum.Font.GothamBold, BorderSizePixel = 0}, row)
        corner(6, b)
        onTap(b, function() task.spawn(a.fn) end)
    end
    zfix(row, 14)
    return row
end

local TAB_ICON = {
    ["Основное"] = "house", ["Визуалы"] = "eye", ["Шериф"] = "crosshairs", ["Телепорт"] = "compass",
    ["Утилиты"] = "gear", ["Fling"] = "arrow-large-up", ["Автофарм"] = "circle-star", ["Убийца"] = "bullet-flying",
    ["KillEffect"] = "flame", ["DupeVote"] = "circle-check", ["CustomModel"] = "hat-fedora", ["Sound"] = "headphones",
    ["Watermark"] = "flag", ["SVO"] = "cloud", ["Trigger/Assist"] = "crosshairs", ["HUD"] = "chart-line",
    ["Configs"] = "folder", ["Binds"] = "key", ["KillFeed"] = "four-bars-horizontal-left-aligned",
    ["GunModel"] = "cube-vertexes", ["JumpCircle"] = "arrow-large-up", ["KnifeModel"] = "hammer-code",
    ["UserNash"] = "head-male", ["Animation"] = "arrow-spin-clockwise", ["Emotes"] = "face-winking", ["CustomSky"] = "cloud",
}

local lastT
local function addTab(name, icon, order)
    local nlTab = NLWin:AddTab({Name = name, Icon = TAB_ICON[name] or "gear"})
    local T = {}
    local cur, nsec = nil, 0

    local function newSection(text)
        nsec = nsec + 1
        cur = nlTab:AddSection({Name = text, Position = (nsec % 2 == 1) and "left" or "right"})
        return cur
    end
    local function sec() return cur or newSection("Функции") end
    local function isLong(t, lim) return (utf8.len(t) or #t) > lim end

    function T.Section(text)
        text = tostring(text)
        if isLong(text, 30) then
            local cut = (utf8.offset(text, 29) or 29) - 1
            newSection(text:sub(1, cut) .. "…")
            pcall(function() cur:AddLabel(text, true) end)
        else
            newSection(text)
        end
    end

    function T.Toggle(text, default, callback, iconId)
        local state = default and true or false
        local silent = false
        local tg
        tg = sec():AddLabel(text, isLong(text, 24)):AddToggle({
            Default = state,
            Callback = function(v)
                state = v and true or false
                if callback then task.spawn(callback, state) end
                if not silent and NT.toggle then NT.toggle(text, state) end
            end,
        })
        REG[text] = {kind = "toggle", get = function() return state end,
            set = function(v, s)
                silent = s and true or false
                tg:SetValue(v and true or false)
                silent = false
            end}
    end

    -- Тоггл + выпадающий список выбора справа
    function T.ToggleDrop(text, default, callback, iconId, options, defIdx, onSelect)
        options = options or {}
        local state = default and true or false
        local sel = defIdx or 1
        local silent = false
        local names = {}
        for i, n in ipairs(options) do names[i] = tostring(n) end
        local h = sec():AddLabel(text, true)
        local tg
        tg = h:AddToggle({
            Default = state,
            Callback = function(v)
                state = v and true or false
                if callback then task.spawn(callback, state) end
                if not silent and NT.toggle then NT.toggle(text, state) end
            end,
        })
        local dd
        if #names > 0 then
            sel = math.clamp(math.floor(tonumber(sel) or 1), 1, #names)
            dd = h:AddDropdown({
                Values = names, Default = names[sel], Size = 105,
                Callback = function(v)
                    for i, n in ipairs(names) do
                        if n == v then
                            sel = i
                            if onSelect then task.spawn(onSelect, i) end
                            break
                        end
                    end
                end,
            })
        end
        REG[text] = {kind = "toggle", get = function() return state end,
            set = function(v, s)
                silent = s and true or false
                tg:SetValue(v and true or false)
                silent = false
            end}
        REG[text .. " [выбор]"] = {kind = "select", get = function() return sel end,
            set = function(i)
                if #names == 0 then return end
                i = math.clamp(math.floor(tonumber(i) or 1), 1, #names)
                sel = i
                if dd then dd:SetValue(names[i]) end
            end}
    end

    function T.Slider(text, min, max, default, suffix, callback, step)
        step = step or 1
        local dec, st = 0, step
        while st < 0.999 and dec < 3 do st = st * 10; dec = dec + 1 end
        local function snap(x)
            return tonumber(string.format("%.3f", math.clamp(math.floor(x / step + 0.5) * step, min, max)))
        end
        local value = default or min
        local sl
        sl = sec():AddLabel(text, true):AddSlider({
            Default = value, Min = min, Max = max, Type = suffix or "", Rounding = dec, Size = 110,
            Callback = function(v)
                value = snap(tonumber(v) or min)
                if callback then callback(value) end
            end,
        })
        REG[text] = {
            get = function() return value end,
            set = function(v)
                v = snap(tonumber(v) or min)
                value = v
                sl:SetValue(v)
            end,
        }
    end

    function T.Button(text, callback)
        if callback then ACT[text] = callback end
        sec():AddButton({Name = text, Icon = "chevron-large-right",
            Callback = function() if callback then task.spawn(callback) end end})
    end

    -- Список игроков: выпадающий список + кнопка действия по выбранному
    function T.PlayerList(actionText, callback)
        local map, selected = {}, nil
        local function build()
            map = {}
            local names = {}
            for _, pl in ipairs(Players:GetPlayers()) do
                if pl ~= LocalPlayer then
                    local label = pl.DisplayName
                    if map[label] then label = pl.DisplayName .. " (@" .. pl.Name .. ")" end
                    map[label] = pl
                    names[#names + 1] = label
                end
            end
            return names
        end
        local names = build()
        selected = names[1]
        local dd = sec():AddLabel("Игрок", false):AddDropdown({
            Values = names, Default = names[1], Size = 130,
            Callback = function(v) selected = v end,
        })
        sec():AddButton({Name = actionText, Icon = "chevron-large-right", Callback = function()
            local pl = selected and map[selected]
            if pl and pl.Parent then
                task.spawn(callback, pl)
            else
                notify("Выбери игрока из списка")
            end
        end})
        local function refresh()
            local n = build()
            pcall(function() dd:SetValues(n) end)
            if not (selected and map[selected]) then
                selected = n[1]
                if n[1] then pcall(function() dd:SetValue(n[1]) end) end
            end
        end
        Players.PlayerAdded:Connect(function() task.wait(0.3) refresh() end)
        Players.PlayerRemoving:Connect(function() task.wait(0.3) refresh() end)
        return refresh
    end

    -- Поле ввода: возвращает объект с полем .Text (чтение и запись)
    function T.TextBox(placeholder)
        local ti = sec():AddLabel(placeholder, true):AddTextInput({
            Default = "", Placeholder = "...", Size = 120, Callback = function() end,
        })
        return setmetatable({}, {
            __index = function(_, k)
                if k == "Text" then
                    local ok, v = pcall(function() return ti.Box.Text end)
                    return ok and v or ""
                end
            end,
            __newindex = function(_, k, v)
                if k == "Text" then
                    pcall(function() ti.Box.Text = tostring(v or "") end)
                end
            end,
        })
    end

    -- Контейнер для своих строк (списки конфигов, бинды)
    function T.Holder()
        local host = sec().Frame
        local holder = new("Frame", {Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1, LayoutOrder = 100000, ZIndex = 12}, host)
        new("UIListLayout", {Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder,
            HorizontalAlignment = Enum.HorizontalAlignment.Center}, holder)
        return holder
    end

    lastT = T
    return T
end

local function addSideLabel(text, order)
    pcall(function() NLWin:AddTabLabel(text) end)
end

-- бывшие кнопки сайдбара теперь лежат в отдельной секции последней вкладки
local sideDone = {}
local function addSideButton(text, icon, order, fn)
    local T = lastT
    if not T then return end
    if not sideDone[T] then
        T.Section("✎ Редактирование интерфейса")
        sideDone[T] = true
    end
    T.Button(text, fn)
end



--------------------------------------------------
-- ОБЩИЕ ФУНКЦИИ
--------------------------------------------------
local function myChar() return LocalPlayer.Character end
local function myHrp() local c = myChar() return c and c:FindFirstChild("HumanoidRootPart") end
local function myHum() local c = myChar() return c and c:FindFirstChildOfClass("Humanoid") end

local function getRole(p)
    local c = p and p.Character
    if not c then return "Unknown" end
    local b = p:FindFirstChild("Backpack")
    if b then
        if b:FindFirstChild("Knife") or b:FindFirstChild("Classic Knife") then return "Murderer" end
        if b:FindFirstChild("Gun") or b:FindFirstChild("Classic Gun") then return "Sheriff" end
    end
    if c:FindFirstChild("Knife") or c:FindFirstChild("Classic Knife") then return "Murderer" end
    if c:FindFirstChild("Gun") or c:FindFirstChild("Classic Gun") then return "Sheriff" end
    return "Innocent"
end
local function roleColor(r)
    return r == "Murderer" and C.RED or (r == "Sheriff" and Color3.fromRGB(59, 130, 246) or C.GREEN)
end
local function findByRole(role, skipSelf)
    for _, p in ipairs(Players:GetPlayers()) do
        if not (skipSelf and p == LocalPlayer) and getRole(p) == role then return p end
    end
end
local function isGameActive()
    return findByRole("Murderer") ~= nil or findByRole("Sheriff") ~= nil
end

--------------------------------------------------
-- СОСТОЯНИЯ
--------------------------------------------------
local highlightEnabled, espObjects = false, {}
local noclipEnabled, noclipConn = false, nil
local speedEnabled, speedValue = false, 16
local flyEnabled, flySpeed, bodyVel, bodyGyro = false, 50, nil, nil
local flyUp, flyDown = false, false
local targetEspEnabled, targetObj, targetConn = false, nil, nil
local hatEnabled, hat = false, nil
local gunEsp, coinEsp = false, false
local infJump, antiAfk, antiFling = false, true, false
local noclipUser = false
local spinbot = {on = false, speed = 20} -- speed 1-50 (обороты/сек примерно)

--------------------------------------------------
-- ESP РОЛЕЙ
--------------------------------------------------
local function createHighlight(player)
    if player == LocalPlayer then return end
    local function onChar(char)
        local hum = char:WaitForChild("Humanoid", 3)
        local hrp = char:WaitForChild("HumanoidRootPart", 3)
        if not hum or not hrp then return end
        local old = espObjects[player]
        if old then
            if old.H then old.H:Destroy() end
            if old.B then old.B:Destroy() end
        end
        local role = getRole(player)
        local col = roleColor(role)
        local hl = new("Highlight", {Name = "MWESP", FillColor = col, OutlineColor = col,
            FillTransparency = 0.5, Enabled = highlightEnabled}, char)
        local bb = new("BillboardGui", {Name = "MWBB", Size = UDim2.new(4, 0, 1.5, 0),
            StudsOffset = Vector3.new(0, 3, 0), AlwaysOnTop = true, Enabled = highlightEnabled}, hrp)
        local tl = new("TextLabel", {Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, Text = role,
            TextColor3 = col, TextStrokeTransparency = 0, TextScaled = true, Font = Enum.Font.GothamBold}, bb)
        espObjects[player] = {H = hl, B = bb}
        local conn
        conn = RunService.Heartbeat:Connect(function()
            if not char.Parent or hum.Health <= 0 then conn:Disconnect() return end
            local nr = getRole(player)
            if nr ~= role then
                role = nr
                local nc = roleColor(nr)
                hl.FillColor, hl.OutlineColor, tl.TextColor3, tl.Text = nc, nc, nc, nr
            end
        end)
    end
    if player.Character then task.spawn(onChar, player.Character) end
    player.CharacterAdded:Connect(onChar)
end
for _, p in ipairs(Players:GetPlayers()) do createHighlight(p) end
Players.PlayerAdded:Connect(createHighlight)
Players.PlayerRemoving:Connect(function(p) espObjects[p] = nil end)

--------------------------------------------------
-- NOCLIP / SPEED / FLY
--------------------------------------------------
local function toggleNoclip(state)
    noclipEnabled = state
    if noclipConn then noclipConn:Disconnect() noclipConn = nil end
    if state then
        noclipConn = RunService.Stepped:Connect(function()
            local c = myChar()
            if c then
                for _, p in ipairs(c:GetDescendants()) do
                    if p:IsA("BasePart") then p.CanCollide = false end
                end
            end
        end)
    end
end

RunService.Heartbeat:Connect(function(dt)
    if speedEnabled then
        local h = myHum()
        if h and h.WalkSpeed ~= speedValue then h.WalkSpeed = speedValue end
    end
    -- Spinbot: вращение персонажа вокруг оси Y
    if spinbot.on then
        local hrp = myHrp()
        if hrp then
            -- speed 1–50 ≈ 1–50 оборотов в секунду
            local ang = math.rad(spinbot.speed * 360 * (dt or 0.016))
            hrp.CFrame = hrp.CFrame * CFrame.Angles(0, ang, 0)
        end
    end
end)

local function startFly()
    local hrp, hum = myHrp(), myHum()
    if not hrp or not hum then return end
    hum.PlatformStand = true
    bodyVel = new("BodyVelocity", {MaxForce = Vector3.new(1e9, 1e9, 1e9), Velocity = Vector3.zero}, hrp)
    bodyGyro = new("BodyGyro", {MaxTorque = Vector3.new(1e9, 1e9, 1e9), P = 9e4, D = 500}, hrp)
    toggleNoclip(true)
end
local function stopFly()
    if bodyVel then bodyVel:Destroy() bodyVel = nil end
    if bodyGyro then bodyGyro:Destroy() bodyGyro = nil end
    local hum = myHum()
    if hum then hum.PlatformStand = false end
    toggleNoclip(noclipUser)
end

RunService.RenderStepped:Connect(function(dt)
    if not flyEnabled or not bodyVel or not bodyGyro then return end
    local hrp, hum = myHrp(), myHum()
    if not hrp or not hum then return end
    local cf = Camera.CFrame
    local rel = cf:VectorToObjectSpace(hum.MoveDirection)
    local dir = cf.LookVector * -rel.Z + cf.RightVector * rel.X
    if UIS:IsKeyDown(Enum.KeyCode.Space) or flyUp then dir = dir + Vector3.yAxis end
    if UIS:IsKeyDown(Enum.KeyCode.LeftShift) or flyDown then dir = dir - Vector3.yAxis end
    if dir.Magnitude > 0 then
        bodyVel.Velocity = bodyVel.Velocity:Lerp(dir.Unit * flySpeed, math.min(1, dt * 12))
    else
        bodyVel.Velocity = bodyVel.Velocity:Lerp(Vector3.zero, math.min(1, dt * 8))
    end
    local look = cf.LookVector
    bodyGyro.CFrame = CFrame.lookAt(hrp.Position, hrp.Position + Vector3.new(look.X, 0, look.Z))
end)

local flyGui = makeGui("ManewareFly", 99998)
flyGui.Enabled = false
local function flyBtn(text, yOff, setter)
    local b = new("TextButton", {Size = UDim2.new(0, 64, 0, 64), Position = UDim2.new(1, -90, 1, yOff),
        BackgroundColor3 = C.ACCENT, BackgroundTransparency = 0.2, Text = text, TextColor3 = C.TEXT,
        TextSize = 28, Font = Enum.Font.GothamBold, AutoButtonColor = false, BorderSizePixel = 0}, flyGui)
    corner(32, b)
    b.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then setter(true) end
    end)
    b.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then setter(false) end
    end)
end
flyBtn("▲", -240, function(v) flyUp = v end)
flyBtn("▼", -170, function(v) flyDown = v end)

--------------------------------------------------
-- TARGET ESP / CHINA HAT
--------------------------------------------------
-- Настройки Target ESP
-- reticle = рамка, circle = круг от макушки до ступней, circleStyle: 1 свечение / 2 тонкий / 3 заливка
local tgt = {glow = true, size = 0.5, speed = 1.0, glowStr = 1.0,
    reticle = true, circle = false, circleStyle = 1, circleSize = 1.0, ringBB = nil}
local tgtAlpha = 0 -- общая плавность: 0 = скрыто, 1 = полностью видно

local function removeTarget()
    if targetConn then targetConn:Disconnect() targetConn = nil end
    if targetObj then targetObj:Destroy() targetObj = nil end
    if tgt.ringBB then tgt.ringBB:Destroy() tgt.ringBB = nil end
    tgtAlpha = 0
end

-- Плавное появление/затухание: у каждого элемента запоминаем базовую прозрачность,
-- дальше считаем итог = 1 - непрозрачность * alpha (свечение ещё умножается на силу и пульс)
local function fadeApply(list, a, gs, pulse)
    for _, it in ipairs(list) do
        if it.obj.Parent then
            local op = 1 - it.base
            if it.glow then op = math.clamp(op * gs * pulse, 0, 0.95) end
            it.obj[it.prop] = 1 - op * a
        end
    end
end

-- Рамка из уголков + мягкое многослойное свечение
local function buildReticle()
    local fade = {}
    local function reg(obj, prop, isGlow)
        table.insert(fade, {obj = obj, prop = prop, base = obj[prop], glow = isGlow})
    end
    local bb = new("BillboardGui", {Name = "MWTargetBB", Size = UDim2.new(3, 0, 3, 0), AlwaysOnTop = true,
        LightInfluence = 0, Enabled = false})
    local spin = new("Frame", {Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, Rotation = 25}, bb)
    local glow = new("Frame", {Name = "Glow", Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1}, spin)
    local lines = {}
    local function corners(parent, color, base, transp, len, isGlow)
        for _, a in ipairs({Vector2.new(0, 0), Vector2.new(1, 0), Vector2.new(0, 1), Vector2.new(1, 1)}) do
            local hz = new("Frame", {Size = UDim2.new(len, 0, 0, base), Position = UDim2.new(a.X, 0, a.Y, 0), AnchorPoint = a,
                BackgroundColor3 = color, BackgroundTransparency = transp, BorderSizePixel = 0}, parent)
            local vt = new("Frame", {Size = UDim2.new(0, base, len, 0), Position = UDim2.new(a.X, 0, a.Y, 0), AnchorPoint = a,
                BackgroundColor3 = color, BackgroundTransparency = transp, BorderSizePixel = 0}, parent)
            reg(hz, "BackgroundTransparency", isGlow)
            reg(vt, "BackgroundTransparency", isGlow)
            table.insert(lines, {hz, true, base, len})
            table.insert(lines, {vt, false, base, len})
        end
    end
    -- свечение: 7 колец, чем дальше от рамки, тем слабее (плавный градиент)
    local glowCol = Color3.fromRGB(255, 50, 90)
    for i = 7, 1, -1 do
        local f = new("Frame", {Size = UDim2.new(1, i * 2, 1, i * 2), Position = UDim2.new(0, -i, 0, -i),
            BackgroundTransparency = 1, BorderSizePixel = 0}, glow)
        corner(6 + i * 2, f)
        local st = new("UIStroke", {Color = glowCol, Thickness = 3, Transparency = 0.5 + i * 0.07}, f)
        reg(st, "Transparency", true)
    end
    local core = new("Frame", {Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = Color3.fromRGB(255, 60, 100), BackgroundTransparency = 0.9, BorderSizePixel = 0}, glow)
    corner(6, core)
    reg(core, "BackgroundTransparency", true)
    corners(glow, Color3.fromRGB(255, 50, 90), 12, 0.55, 0.42, true)
    corners(spin, Color3.fromRGB(255, 90, 120), 3, 0, 0.36, false)
    return bb, spin, glow, lines, fade
end

-- Нимб: горизонтальное кольцо (как halo) летает от ступней до макушки и обратно.
-- Работает без Drawing: CylinderHandleAdornment с InnerRadius, привязан к Terrain (мировые координаты).
local function buildRing()
    local fade, items = {}, {}
    local function reg(obj, prop, isGlow)
        local it = {obj = obj, prop = prop, base = obj[prop], glow = isGlow}
        table.insert(fade, it)
        return it
    end
    local rb = Instance.new("Folder")
    rb.Name = "MWTargetRing"
    local function mk(kind, w, transp, lag, isGlow, col)
        local a = new("CylinderHandleAdornment", {Adornee = workspace.Terrain, Radius = 1.7, InnerRadius = 1.6,
            Height = 0.06, Angle = 360, Color3 = col or Color3.fromRGB(255, 60, 100), Transparency = transp,
            AlwaysOnTop = true, ZIndex = 1}, rb)
        local it = reg(a, "Transparency", isGlow)
        local rec = {a = a, kind = kind, w = w, lag = lag, it = it}
        table.insert(items, rec)
        return rec
    end
    local fill = mk("fill", 0, 0.93, 0, true)
    mk("glow", 1.4, 0.95, 0, true)
    mk("glow", 0.9, 0.9, 0, true)
    mk("glow", 0.5, 0.8, 0, true)
    mk("echo", 0.14, 0.7, 0.10, true)
    mk("echo", 0.14, 0.85, 0.20, true)
    mk("core", 0.14, 0, 0, false, Color3.fromRGB(255, 110, 140))
    return rb, fade, fill, items
end

local function applyTarget()
    removeTarget()
    if not targetEspEnabled then return end
    local bb, spin, glow, lines, fade = buildReticle()
    local rb, ringFade, fillRec, ringItems = buildRing()
    targetObj = bb
    tgt.ringBB = rb
    local angle, tt = 25, 0
    local last = nil            -- последний корень цели: по нему свечение плавно гаснет
    local ringFeet, ringTop = nil, nil -- мировая высота ступней и макушки цели
    targetConn = RunService.RenderStepped:Connect(function(dt)
        if not targetEspEnabled then removeTarget() return end
        tt = tt + dt
        local cam = workspace.CurrentCamera or Camera
        local pl = isGameActive() and findByRole("Murderer", true) or nil
        local ch = pl and pl.Character
        local r = ch and ch:FindFirstChild("HumanoidRootPart")
        local h = ch and ch:FindFirstChildOfClass("Humanoid")
        local alive = (r and h and h.Health > 0) and true or false
        if alive then last = r end

        -- плавный вход и уход
        tgtAlpha = tgtAlpha + ((alive and 1 or 0) - tgtAlpha) * math.clamp(dt * 7, 0, 1)
        if not alive and tgtAlpha < 0.01 then tgtAlpha = 0 end

        local root = alive and r or last
        if root and not root.Parent then root = nil last = nil end
        if not root or tgtAlpha <= 0 then
            bb.Enabled = false
            rb.Parent = nil
            return
        end

        local gs = math.clamp(tgt.glowStr or 1, 0.3, 2)
        local pulse = 1 + 0.12 * math.sin(tt * 3)

        -- Рамка
        if tgt.reticle then
            if bb.Parent ~= cam then bb.Parent = cam end
            bb.Adornee = root
            local sz = 6 * tgt.size
            bb.Size = UDim2.new(sz, 0, sz, 0)
            glow.Visible = tgt.glow
            fadeApply(fade, tgtAlpha, gs, pulse)
            local dist = (root.Position - cam.CFrame.Position).Magnitude
            local k = math.clamp((22 / math.max(dist, 8)) ^ 0.5, 0.5, 1.2)
            for _, ln in ipairs(lines) do
                local th = math.max(1, ln[3] * k)
                if ln[2] then
                    ln[1].Size = UDim2.new(ln[4], 0, 0, th)
                else
                    ln[1].Size = UDim2.new(0, th, ln[4], 0)
                end
            end
            bb.Enabled = true
            angle = angle + dt * 70 * tgt.speed
            spin.Rotation = angle % 360
        else
            bb.Enabled = false
        end

        -- Нимб: кольцо летает от ступней до макушки
        if tgt.circle then
            if alive then
                local head = ch:FindFirstChild("Head")
                if head then
                    ringTop = head.Position.Y + head.Size.Y / 2
                    ringFeet = r.Position.Y - r.Size.Y / 2
                        - (h.RigType == Enum.HumanoidRigType.R15 and h.HipHeight or 2)
                end
            end
            if not ringTop then
                ringTop = root.Position.Y + 2.8
                ringFeet = root.Position.Y - 3
            end
            local R = 1.7 * tgt.circleSize
            local sp = (tgt.speed or 1) * 1.6
            local st = tgt.circleStyle
            if rb.Parent ~= cam then rb.Parent = cam end
            for _, rec in ipairs(ringItems) do
                local k = 0.5 - 0.5 * math.cos((tt - rec.lag) * sp) -- 0 ступни -> 1 макушка (плавно туда-обратно)
                local y = ringFeet + (ringTop - ringFeet) * k
                local a = rec.a
                local show = true
                if st == 2 then show = (rec.kind == "core")
                elseif rec.kind == "fill" then show = true end
                a.Visible = show
                if rec.kind == "fill" then
                    a.Radius = R
                    a.InnerRadius = 0
                    a.Height = 0.04
                    rec.it.base = (st == 3) and 0.8 or 0.93
                else
                    a.Radius = R + rec.w / 2
                    a.InnerRadius = math.max(R - rec.w / 2, 0)
                    a.Height = (rec.kind == "core") and 0.07 or 0.05
                end
                a.CFrame = CFrame.new(root.Position.X, y, root.Position.Z) * CFrame.Angles(math.rad(90), 0, 0)
            end
            fadeApply(ringFade, tgtAlpha, gs, pulse)
        else
            rb.Parent = nil
        end
    end)
end

local function removeHat() if hat then hat:Destroy() hat = nil end end
local function applyHat(char)
    removeHat()
    if not char or not hatEnabled then return end
    local head = char:FindFirstChild("Head")
    if not head then return end
    hat = new("ConeHandleAdornment", {Name = "MWHat", Adornee = head, Height = 0.8, Radius = 1.5,
        Color3 = Color3.fromRGB(210, 160, 60), Transparency = 0.4,
        CFrame = CFrame.new(0, 0.8, 0) * CFrame.Angles(math.rad(90), 0, 0)}, head)
end

--------------------------------------------------
-- ESP ПИСТОЛЕТА (GunDrop) И МОНЕТ (CoinContainer)
--------------------------------------------------
local function clearByName(names)
    for _, d in ipairs(workspace:GetDescendants()) do
        if names[d.Name] then d:Destroy() end
    end
end

local gunDropRef = nil
local function isGunDropName(n) return n == "GunDrop" or n == "GunDrop2" end
workspace.DescendantAdded:Connect(function(d)
    if isGunDropName(d.Name) then gunDropRef = d end
end)
local lastGunScan = 0
local function findGunDrop()
    if gunDropRef and gunDropRef.Parent then return gunDropRef end
    gunDropRef = nil
    if os.clock() - lastGunScan < 1 then return nil end
    lastGunScan = os.clock()
    gunDropRef = workspace:FindFirstChild("GunDrop", true)
    return gunDropRef
end
local function gunDropPart(g)
    if not g then return nil end
    if g:IsA("BasePart") then return g end
    return g:FindFirstChildWhichIsA("BasePart", true)
end
local gunNotified = nil

task.spawn(function()
    while true do
        task.wait(0.5)
        pcall(function()
            if gunEsp then
                local g = findGunDrop()
                local part = gunDropPart(g)
                if part then
                    if gunNotified ~= g then
                        gunNotified = g
                        notify("Gun ESP: Пистолет упал")
                    end
                    if not part:FindFirstChild("MWGunBox") then -- 3D-бокс (минимум 2.5 стада)
                        new("BoxHandleAdornment", {Name = "MWGunBox", Adornee = part,
                            Size = Vector3.new(math.max(part.Size.X, 2.5), math.max(part.Size.Y, 2.5), math.max(part.Size.Z, 2.5)),
                            Color3 = Color3.fromRGB(255, 200, 0), Transparency = 0.55, AlwaysOnTop = true, ZIndex = 1}, part)
                    end
                    if not part:FindFirstChild("MWGunBox2D") then -- плоская рамка-бокс на экране
                        local bx = new("BillboardGui", {Name = "MWGunBox2D", Size = UDim2.new(0, 46, 0, 46),
                            AlwaysOnTop = true, LightInfluence = 0}, part)
                        local fr = new("Frame", {Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1}, bx)
                        new("UIStroke", {Color = Color3.fromRGB(255, 200, 0), Thickness = 2}, fr)
                    end
                    if not part:FindFirstChild("MWGun") then
                        new("Highlight", {Name = "MWGun", Adornee = part, FillColor = Color3.fromRGB(255, 200, 0),
                            OutlineColor = Color3.new(1, 1, 1), FillTransparency = 0.2,
                            DepthMode = Enum.HighlightDepthMode.AlwaysOnTop}, part)
                    end
                    if not part:FindFirstChild("MWGunTag") then
                        local bb = new("BillboardGui", {Name = "MWGunTag", Size = UDim2.new(0, 120, 0, 36),
                            StudsOffset = Vector3.new(0, 2.5, 0), AlwaysOnTop = true}, part)
                        new("TextLabel", {Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1,
                            Text = "🔫 ПИСТОЛЕТ", TextColor3 = Color3.fromRGB(255, 200, 0), TextStrokeTransparency = 0,
                            TextSize = 18, Font = Enum.Font.GothamBold}, bb)
                    end
                else
                    gunNotified = nil
                end
            end
            if coinEsp then
                local cc = workspace:FindFirstChild("CoinContainer", true)
                if cc then
                    for _, coin in ipairs(cc:GetChildren()) do
                        local cp = coin:IsA("BasePart") and coin or coin:FindFirstChildWhichIsA("BasePart", true)
                        if cp and not cp:FindFirstChild("MWCoin") then
                            new("BoxHandleAdornment", {Name = "MWCoin", Adornee = cp,
                                Size = Vector3.new(1.6, 1.6, 1.6), Color3 = Color3.fromRGB(255, 215, 0),
                                Transparency = 0.35, AlwaysOnTop = true, ZIndex = 1}, cp)
                        end
                    end
                end
            end
        end)
    end
end)

--------------------------------------------------
-- ТЕЛЕПОРТЫ
--------------------------------------------------
local function tpTo(cf)
    local hrp = myHrp()
    if hrp then hrp.CFrame = cf end
end
local function findMap()
    local cc0 = workspace:FindFirstChild("CoinContainer", true)
    if cc0 and cc0.Parent and cc0.Parent ~= workspace then return cc0.Parent end
    for _, m in ipairs(workspace:GetChildren()) do
        if m:IsA("Model") and m.Name ~= "Lobby" and (m:FindFirstChild("CoinContainer") or m:FindFirstChild("Spawns")) then
            return m
        end
    end
end
local function tpLobby()
    local lobby = workspace:FindFirstChild("Lobby")
    local spawns = lobby and lobby:FindFirstChild("Spawns")
    local target
    if spawns and #spawns:GetChildren() > 0 then
        local l = spawns:GetChildren()
        target = l[math.random(#l)]
    end
    if not target then target = workspace:FindFirstChildWhichIsA("SpawnLocation", true) end
    if target and target:IsA("BasePart") then tpTo(target.CFrame + Vector3.new(0, 4, 0))
    else notify("Лобби не найдено") end
end
local function tpMap()
    local map = findMap()
    if not map then notify("Карта не найдена (раунд не начался?)") return end
    local spawns = map:FindFirstChild("Spawns")
    local list = spawns and spawns:GetChildren() or {}
    local target = #list > 0 and list[math.random(#list)] or nil
    if target and target:IsA("BasePart") then tpTo(target.CFrame + Vector3.new(0, 4, 0))
    elseif map:IsA("Model") then tpTo(map:GetPivot() + Vector3.new(0, 10, 0))
    else notify("Точка телепорта на карте не найдена") end
end
local function tpRole(role)
    local p = findByRole(role, true)
    local hrp = p and p.Character and p.Character:FindFirstChild("HumanoidRootPart")
    if hrp then tpTo(hrp.CFrame * CFrame.new(0, 0, 3)) else notify(role .. " не найден") end
end

--------------------------------------------------
-- INFINITE JUMP / ANTI-AFK / ANTI-FLING / FPS BOOST
--------------------------------------------------
UIS.JumpRequest:Connect(function()
    if infJump then
        local h = myHum()
        if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end)

LocalPlayer.Idled:Connect(function()
    if antiAfk then
        pcall(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end)
    end
end)

do -- Улучшенный AntiFling (всё внутри блока, чтобы не расходовать лимит локальных переменных)
    -- 1) у ВСЕХ частей чужих персонажей (в т.ч. аксессуары и инструменты) отключаем столкновения, каждый кадр
    -- 2) если нас резко подбросило/закрутило - гасим скорость и возвращаем на позицию несколькими кадрами раньше
    local cache = {}
    local lastScan = 0
    local safeQ = {}
    local function rescan(pl)
        local list = {}
        local ch = pl.Character
        if ch then
            for _, d in ipairs(ch:GetDescendants()) do
                if d:IsA("BasePart") then list[#list + 1] = d end
            end
        end
        cache[pl] = list
    end
    local function hookChar(pl)
        local function onChar(ch)
            rescan(pl)
            ch.DescendantAdded:Connect(function(d)
                if d:IsA("BasePart") then
                    local l = cache[pl]
                    if l then l[#l + 1] = d end
                    if antiFling then d.CanCollide = false end
                end
            end)
        end
        if pl.Character then task.spawn(onChar, pl.Character) end
        pl.CharacterAdded:Connect(function(ch) task.wait(0.2) onChar(ch) end)
    end
    for _, pl in ipairs(Players:GetPlayers()) do
        if pl ~= LocalPlayer then hookChar(pl) end
    end
    Players.PlayerAdded:Connect(function(pl) if pl ~= LocalPlayer then hookChar(pl) end end)
    Players.PlayerRemoving:Connect(function(pl) cache[pl] = nil end)

    RunService.Stepped:Connect(function() -- перед каждым шагом физики
        if not antiFling then return end
        if os.clock() - lastScan > 0.5 then
            lastScan = os.clock()
            for pl in pairs(cache) do
                if pl.Parent then rescan(pl) end
            end
        end
        for _, list in pairs(cache) do
            for i = #list, 1, -1 do
                local p = list[i]
                if p.Parent then
                    if p.CanCollide then p.CanCollide = false end
                else
                    table.remove(list, i)
                end
            end
        end
    end)

    RunService.Heartbeat:Connect(function()
        if not antiFling then
            safeQ = {}
            return
        end
        local hrp, hum = myHrp(), myHum()
        if not hrp or not hum or flingBusy or flyEnabled then return end
        local v, w = hrp.AssemblyLinearVelocity, hrp.AssemblyAngularVelocity
        local mv = hum.MoveDirection * hum.WalkSpeed -- ожидаемая скорость ходьбы (с учётом SpeedHack)
        local dev = Vector3.new(v.X - mv.X, 0, v.Z - mv.Z).Magnitude
        if dev > 120 or math.abs(v.Y) > 300 or w.Magnitude > 40 then
            hrp.AssemblyLinearVelocity = Vector3.zero
            hrp.AssemblyAngularVelocity = Vector3.zero
            if safeQ[1] then hrp.CFrame = safeQ[1] end
            pcall(function() hum:ChangeState(Enum.HumanoidStateType.GettingUp) end)
        else
            safeQ[#safeQ + 1] = hrp.CFrame
            if #safeQ > 8 then table.remove(safeQ, 1) end
        end
    end)
end

local fpsBoost
do -- fpsSaved/fpsConn спрятаны в блок (экономим локальные переменные)
local fpsSaved = {}
local fpsConn = nil
fpsBoost = function(on)
    if fpsConn then fpsConn:Disconnect() fpsConn = nil end
    if on then
        fpsSaved = {}
        local function save(inst, prop, val)
            pcall(function()
                local old = inst[prop]
                inst[prop] = val
                table.insert(fpsSaved, {inst, prop, old})
            end)
        end
        -- Максимальный potato / soap mode
        pcall(function()
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
            settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level01
            settings().Rendering.EagerBulkExecution = true
        end)
        save(Lighting, "GlobalShadows", false)
        save(Lighting, "FogEnd", 200)
        save(Lighting, "Brightness", 1)
        save(Lighting, "OutdoorAmbient", Color3.fromRGB(128, 128, 128))
        save(Lighting, "Ambient", Color3.fromRGB(100, 100, 100))
        save(Lighting, "Technology", Enum.Technology.Compatibility)
        for _, v in ipairs(Lighting:GetChildren()) do
            if v:IsA("PostEffect") then save(v, "Enabled", false)
            elseif v:IsA("Atmosphere") then save(v, "Density", 0)
            elseif v:IsA("Sky") then save(v, "Parent", nil) end
        end
        local function strip(obj)
            for _, v in ipairs(obj:GetDescendants()) do
                if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") or v:IsA("Fire")
                    or v:IsA("Sparkles") or v:IsA("Beam") or v:IsA("PointLight")
                    or v:IsA("SpotLight") or v:IsA("SurfaceLight") then
                    save(v, "Enabled", false)
                elseif v:IsA("Decal") or v:IsA("Texture") then
                    save(v, "Transparency", 1)
                elseif v:IsA("MeshPart") then
                    pcall(function() v.TextureID = "" end)
                    save(v, "Material", Enum.Material.SmoothPlastic)
                elseif v:IsA("BasePart") and not v:IsA("Terrain") then
                    save(v, "Material", Enum.Material.SmoothPlastic)
                    save(v, "Reflectance", 0)
                    if v.Material == Enum.Material.Glass or v.Material == Enum.Material.ForceField then
                        save(v, "Transparency", math.min(v.Transparency + 0.3, 1))
                    end
                end
            end
        end
        pcall(strip, workspace)
        -- Периодически чистим новые эффекты
        fpsConn = RunService.Heartbeat:Connect(function()
            if not on then return end
            for _, v in ipairs(workspace:GetDescendants()) do
                if (v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") or v:IsA("Fire")
                    or v:IsA("Sparkles") or v:IsA("Beam")) and v.Enabled then
                    pcall(function() v.Enabled = false end)
                end
            end
        end)
        notify("FPS Boost: potato mode")
    else
        for _, s in ipairs(fpsSaved) do pcall(function() s[1][s[2]] = s[3] end) end
        fpsSaved = {}
        pcall(function()
            settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic
        end)
        notify("FPS Boost: выкл")
    end
end
end -- конец блока fps

--------------------------------------------------
-- SHERIFF AIM
--------------------------------------------------
local aim = {on = false, visible = true, predict = true, strength = 100, range = 250, cd = 1.0, last = 0, hacker = false, studs = 3}
local BULLET_SPEED = 1500 -- пуля MM2 мгновенная (hitscan): упреждаем только на задержку сети
local aimBusy = false

local function hasGun()
    local c = myChar()
    if c and c:FindFirstChild("Gun") then return true end
    local bp = LocalPlayer:FindFirstChild("Backpack")
    return bp and bp:FindFirstChild("Gun") ~= nil
end

-- Проверка видимости конкретной части (хитбокс)
local function partVisible(part)
    if not part then return false end
    local _, onScreen = Camera:WorldToViewportPoint(part.Position)
    if not onScreen then return false end
    local ignore = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p.Character then table.insert(ignore, p.Character) end
    end
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = ignore
    local origin = Camera.CFrame.Position
    local hit = workspace:Raycast(origin, part.Position - origin, params)
    return hit == nil
end

local function isVisible(targetChar)
    local head = targetChar:FindFirstChild("Head") or targetChar:FindFirstChild("HumanoidRootPart")
    return partVisible(head)
end

-- Лучшая видимая часть хитбокса (Head > Torso/UpperTorso > HRP)
local function bestHitPart(char)
    if not char then return nil end
    local order = {"Head", "UpperTorso", "Torso", "HumanoidRootPart", "LowerTorso"}
    local firstAny = nil
    for _, name in ipairs(order) do
        local p = char:FindFirstChild(name)
        if p and p:IsA("BasePart") then
            if not firstAny then firstAny = p end
            if partVisible(p) then return p end
        end
    end
    -- Hacker / wallbang: стреляем даже сквозь стены в лучшую часть
    if aim.hacker then return firstAny or char:FindFirstChild("HumanoidRootPart") end
    return nil
end

-- Трекер реальной скорости игроков (точнее, чем AssemblyLinearVelocity)
local vTrack = setmetatable({}, {__mode = "k"})
RunService.Heartbeat:Connect(function(dt)
    for _, pl in ipairs(Players:GetPlayers()) do
        local r = pl.Character and pl.Character:FindFirstChild("HumanoidRootPart")
        if r then
            local d = vTrack[r]
            if not d then
                vTrack[r] = {pos = r.Position, vel = Vector3.zero}
            else
                if dt > 0 then d.vel = d.vel:Lerp((r.Position - d.pos) / dt, 0.4) end
                d.pos = r.Position
            end
        end
    end
end)

-- задержка туда-обратно (сек): именно на неё цель успевает сместиться
local function getRtt()
    local ok, v = pcall(function() return game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue() end)
    if ok and v and v > 0 then return v / 1000 end
    local ok2, pp = pcall(function() return LocalPlayer:GetNetworkPing() end)
    return ok2 and pp * 2 or 0.1
end

local function predictAt(part, speed, strength, studsOverride)
    -- part = точка прицеливания (Head/HRP), скорость берём с HRP персонажа
    local pos = part.Position
    local my = myHrp()
    local char = part.Parent
    local hrp = char and char:FindFirstChild("HumanoidRootPart") or part
    local d = vTrack[hrp]
    local vel = d and d.vel or hrp.AssemblyLinearVelocity
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum and hum.MoveDirection.Magnitude < 0.05 then vel = vel * 0.15 end
    if vel.Magnitude > 50 then vel = vel.Unit * 50 end
    vel = Vector3.new(vel.X, vel.Y * 0.35, vel.Z)
    -- Упреждение в стадах: сколько «вперёд» по направлению движения цели
    local studs = tonumber(studsOverride)
    if studs and studs > 0 and vel.Magnitude > 0.5 then
        return pos + vel.Unit * studs
    end
    local rtt = getRtt()
    local origin = my and my.Position or Camera.CFrame.Position
    local predicted = pos
    for _ = 1, 4 do
        local t = (predicted - origin).Magnitude / math.max(speed, 1) + rtt
        predicted = pos + vel * t * strength
    end
    return predicted
end

local function predictPos(hrp)
    local char = hrp.Parent
    local targetPart = bestHitPart(char) or hrp
    if not aim.predict then return targetPart.Position end
    -- studs 0 = классическое % предсказание; >0 = упреждение на N стадов
    local st = aim.studs or 0
    if st > 0 then
        return predictAt(targetPart, BULLET_SPEED, 1, st)
    end
    return predictAt(targetPart, BULLET_SPEED, aim.strength / 100, nil)
end

-- ВАЖНО: ремоут пистолета может меняться после обновлений MM2.
-- Пробуем 2 известных варианта, потом запасной (камера + Activate).
local function shoot(pos)
    local c = myChar()
    local hum = myHum()
    if not c or not hum then return end
    local gun = c:FindFirstChild("Gun")
    if not gun then
        local bp = LocalPlayer:FindFirstChild("Backpack")
        local g = bp and bp:FindFirstChild("Gun")
        if g then hum:EquipTool(g) task.wait(0.2) end
        gun = c:FindFirstChild("Gun")
    end
    if not gun then return end

    local ks = gun:FindFirstChild("KnifeServer")
    local sg = ks and ks:FindFirstChild("ShootGun")
    if sg and sg:IsA("RemoteFunction") then
        if pcall(function() sg:InvokeServer(1, pos, "AH2") end) then return end
        if pcall(function() sg:InvokeServer(1, pos, "AH") end) then return end
    end
    local kl = gun:FindFirstChild("KnifeLocal")
    local cb = kl and kl:FindFirstChild("CreateBeam")
    local rf = cb and cb:FindFirstChild("RemoteFunction")
    if rf then
        if pcall(function() rf:InvokeServer(1, pos, "AH2") end) then return end
    end
    local sh = gun:FindFirstChild("Shoot")
    if sh and sh:IsA("RemoteEvent") then
        local hrp = myHrp()
        if hrp and pcall(function() sh:FireServer(CFrame.new(hrp.Position, pos), CFrame.new(pos)) end) then return end
    end
    Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, pos)
    pcall(function() gun:Activate() end)
end

RunService.Heartbeat:Connect(function()
    if not aim.on or aimBusy then return end
    if os.clock() - aim.last < aim.cd then return end
    local myH = myHrp()
    if not myH or not hasGun() then return end
    local m = findByRole("Murderer", true)
    local mc = m and m.Character
    local mh = mc and mc:FindFirstChild("HumanoidRootPart")
    local mhum = mc and mc:FindFirstChildOfClass("Humanoid")
    if not mh or not mhum or mhum.Health <= 0 then return end
    if (mh.Position - myH.Position).Magnitude > aim.range then return end
    -- Visible check: без Hacker — только если есть видимая часть; с Hacker — всегда
    local hitPart = bestHitPart(mc)
    if not hitPart then return end
    if aim.visible and not aim.hacker and not partVisible(hitPart) then return end
    aimBusy = true
    aim.last = os.clock()
    task.spawn(function()
        pcall(function() shoot(predictPos(mh)) end)
        aimBusy = false
    end)
end)

--------------------------------------------------
-- GRAB GUN
--------------------------------------------------
local flingBusy = false
local grabGun, grabBusy, grabLast = false, false, 0

-- GunDrop есть в workspace = шериф умер и пистолет ещё не подобрали
local function doGrabGun()
    if grabBusy or flingBusy then return end
    local g = findGunDrop()
    if not g then return end
    local part = gunDropPart(g)
    if not part then return end
    if hasGun() or getRole(LocalPlayer) == "Murderer" then return end
    local char, hrp, hum = myChar(), myHrp(), myHum()
    if not char or not hrp or not hum or hum.Health <= 0 then return end

    grabBusy = true
    grabLast = os.clock()
    local origin = hrp.CFrame
    notify("GrabGun: лечу за пистолетом")
    pcall(function() hum.Sit = false end)
    local got = false
    local t0 = os.clock()
    while os.clock() - t0 < 3 do
        hrp = myHrp()
        if not hrp or not g.Parent then break end -- нет персонажа / пистолет уже забрали
        hrp.CFrame = part.CFrame * CFrame.new(0, 1.5, 0)
        hrp.AssemblyLinearVelocity = Vector3.zero
        if firetouchinterest then
            for _, limb in ipairs(char:GetChildren()) do
                if limb:IsA("BasePart") then
                    pcall(function()
                        firetouchinterest(limb, part, 0)
                        firetouchinterest(limb, part, 1)
                    end)
                end
            end
        end
        if hasGun() then got = true break end
        task.wait(0.1)
    end
    hrp = myHrp()
    if hrp then
        hrp.AssemblyLinearVelocity = Vector3.zero
        hrp.CFrame = origin -- назад на прежнюю точку
    end
    notify(got and "GrabGun: пистолет получен ✔" or "GrabGun: не удалось забрать")
    grabBusy = false
end

task.spawn(function()
    while true do
        task.wait(0.3)
        if grabGun and not grabBusy and os.clock() - grabLast > 3 then
            if not pcall(doGrabGun) then grabBusy = false end
        end
    end
end)

--------------------------------------------------
-- FLING
-- Метод "velocity desync": в Heartbeat ставим огромную скорость и стоим
-- в цели, в Stepped/RenderStepped гасим её. Сервер видит удар, а нас самих
-- не уносит. В конце возвращаемся на исходную точку.
--------------------------------------------------
local fl = {bypass = false, tries = 3, time = 4, spectate = true}

local function flingPlayer(target)
    if flingBusy then notify("Fling уже идёт") return end
    if grabBusy then notify("Подожди, идёт GrabGun") return end
    if not target or target == LocalPlayer then return end
    if flyEnabled then notify("Выключи Fly перед флингом") return end
    local hrp, hum = myHrp(), myHum()
    local tc = target.Character
    local thrp = tc and tc:FindFirstChild("HumanoidRootPart")
    if not hrp or not hum or not thrp then notify("Игрок недоступен") return end

    flingBusy = true
    local char = myChar()
    local origin = hrp.CFrame
    local startPos = thrp.Position
    local prevAnti = antiFling
    antiFling = false          -- иначе AntiFling уберёт коллизии и фling не сработает
    toggleNoclip(false)        -- чтобы наши части сталкивались с целью
    local hold = hrp:FindFirstChild("MWFarmHold") -- удержание автофарма мешает скорости
    if hold then hold:Destroy() end
    hrp.Anchored = false
    pcall(function() hum.Sit = false end)

    -- запоминаем физику своих частей, чтобы вернуть после флинга
    local saved, allParts, direct = {}, {}, {}
    for _, d in ipairs(char:GetDescendants()) do
        if d:IsA("BasePart") then
            saved[d] = {cc = d.CanCollide, pp = d.CustomPhysicalProperties, ml = d.Massless}
            allParts[#allParts + 1] = d
            if fl.bypass then -- тяжёлые части: больше импульс при ударе
                d.CustomPhysicalProperties = PhysicalProperties.new(100, 0.3, 0, 1, 1)
                d.Massless = false
            end
        end
    end
    for _, d in ipairs(char:GetChildren()) do
        if d:IsA("BasePart") then direct[#direct + 1] = d end
    end
    local offs = {Vector3.new(0, 0, 0), Vector3.new(0, 2, 0), Vector3.new(0, -2, 0), Vector3.new(1.5, 0, 0),
        Vector3.new(-1.5, 0, 0), Vector3.new(0, 0, 1.5), Vector3.new(0, 0, -1.5)}

    local flung = false
    local stepConn, hbConn, rsConn
    local ok, err = pcall(function()
        local tries = math.clamp(math.floor(tonumber(fl.tries) or 3), 1, 5)
        local per = math.clamp((tonumber(fl.time) or 4) / tries, 0.8, 5)
        for attempt = 1, tries do
            if flung then break end
            local th0 = target.Character and target.Character:FindFirstChildOfClass("Humanoid")
            if fl.spectate and th0 then pcall(function() Camera.CameraSubject = th0 end) end -- держит цель прогруженной
            local lead = getRtt() * 0.5 + 0.02 -- упреждение на задержку сети
            -- до физики гасим свою скорость и держим столкновения включёнными
            -- (в режиме Bypass включены ВСЕ части, в том числе аксессуары и инструменты)
            stepConn = RunService.Stepped:Connect(function()
                local h = myHrp()
                if h then
                    h.AssemblyLinearVelocity = Vector3.zero
                    h.AssemblyAngularVelocity = Vector3.zero
                end
                for _, p in ipairs(fl.bypass and allParts or direct) do
                    if p.Parent and not p.CanCollide then p.CanCollide = true end
                end
            end)
            rsConn = RunService.RenderStepped:Connect(function() -- гасим скорость ещё и до кадра
                local h = myHrp()
                if h then
                    h.AssemblyLinearVelocity = Vector3.zero
                    h.AssemblyAngularVelocity = Vector3.zero
                end
            end)
            -- после физики ставим огромную скорость и сидим в цели (сервер видит удар, нас не уносит)
            local idx = attempt
            hbConn = RunService.Heartbeat:Connect(function()
                local h = myHrp()
                local tch = target.Character
                local tr = tch and tch:FindFirstChild("HumanoidRootPart")
                if not h or not tr then return end
                idx = idx % #offs + 1
                local pred = tr.Position + tr.AssemblyLinearVelocity * lead
                h.CFrame = CFrame.new(pred + offs[idx])
                    * CFrame.Angles(math.random() * 6.28, math.random() * 6.28, math.random() * 6.28)
                h.AssemblyLinearVelocity = Vector3.new(1e6, 1e6, 1e6)
                h.AssemblyAngularVelocity = Vector3.zero -- без вращения: персонажа не ломает и не убивает
            end)
            local t0 = os.clock()
            while os.clock() - t0 < per do
                task.wait(0.05)
                local tch = target.Character
                local tr = tch and tch:FindFirstChild("HumanoidRootPart")
                local th = tch and tch:FindFirstChildOfClass("Humanoid")
                if not tr or not th or th.Health <= 0 or not myHrp() then flung = true break end
                if tr.AssemblyLinearVelocity.Magnitude > 250 or (tr.Position - startPos).Magnitude > 140
                    or tr.Position.Y < startPos.Y - 300 then
                    task.wait(0.15)
                    flung = true
                    break
                end
            end
            hbConn:Disconnect() hbConn = nil
            stepConn:Disconnect() stepConn = nil
            if rsConn then rsConn:Disconnect() rsConn = nil end
            local h = myHrp()
            if h then
                h.AssemblyLinearVelocity = Vector3.zero
                h.AssemblyAngularVelocity = Vector3.zero
            end
            if not flung then task.wait(0.15) end
        end
    end)

    if hbConn then hbConn:Disconnect() end
    if stepConn then stepConn:Disconnect() end
    if rsConn then rsConn:Disconnect() end
    for part, st in pairs(saved) do -- возвращаем физику частей
        pcall(function()
            part.CanCollide = st.cc
            part.CustomPhysicalProperties = st.pp
            part.Massless = st.ml
        end)
    end
    pcall(function() Camera.CameraSubject = myHum() or hum end)
    -- возвращаемся: корень заякорен, пока гасим любую остаточную скорость (иначе при неудаче улетаешь сам)
    do
        local h0 = myHrp()
        if h0 then h0.Anchored = true end
        for _ = 1, 20 do
            local h = myHrp()
            if h then
                h.AssemblyLinearVelocity = Vector3.zero
                h.AssemblyAngularVelocity = Vector3.zero
                h.CFrame = origin
            end
            for _, p in ipairs(allParts) do
                if p.Parent then
                    p.AssemblyLinearVelocity = Vector3.zero
                    p.AssemblyAngularVelocity = Vector3.zero
                end
            end
            RunService.Heartbeat:Wait()
        end
        local h1 = myHrp()
        if h1 then
            h1.Anchored = false
            for _ = 1, 8 do
                h1.AssemblyLinearVelocity = Vector3.zero
                h1.AssemblyAngularVelocity = Vector3.zero
                RunService.Heartbeat:Wait()
            end
        end
        pcall(function() hum:ChangeState(Enum.HumanoidStateType.GettingUp) end)
    end
    antiFling = prevAnti
    toggleNoclip(noclipUser)
    flingBusy = false
    if not ok then warn("[Maneware] fling: " .. tostring(err)) end
    if flung then
        notify("Fling: цель улетела")
    else
        notify("Fling: не вышло" .. (fl.bypass and " (у цели сильный AntiFling)" or ", попробуй включить Bypass AntiFling"))
    end
end

local function flingRole(role)
    local pl = findByRole(role, true)
    if pl then flingPlayer(pl) else notify(role .. " не найден") end
end

--------------------------------------------------
-- НОЖ: удар / бросок, KillAura, Kill All, Aura Throw
--------------------------------------------------
local farmBusy = false
local killAllOn, killAllBusy = false, false

local function amMurderer() return getRole(LocalPlayer) == "Murderer" end

local function getKnife(equip)
    local c = myChar()
    if not c then return nil end
    local k = c:FindFirstChild("Knife")
    if k then return k end
    local bp = LocalPlayer:FindFirstChild("Backpack")
    local kb = bp and bp:FindFirstChild("Knife")
    if kb and equip then
        local h = myHum()
        if h then
            h:EquipTool(kb)
            task.wait(0.15)
        end
        return c:FindFirstChild("Knife")
    end
    return nil
end

-- можно ли убить игрока (жив, есть персонаж, нет ForceField)
local function canKill(pl)
    if not pl or pl == LocalPlayer then return false end
    local ch = pl.Character
    local hum = ch and ch:FindFirstChildOfClass("Humanoid")
    local r = ch and ch:FindFirstChild("HumanoidRootPart")
    if not hum or not r or hum.Health <= 0 then return false end
    if ch:FindFirstChildOfClass("ForceField") then return false end
    return true, r
end

-- ВАЖНО: имена ремоутов ножа могут меняться после обновлений MM2
local function stab(targetRoot)
    local knife = getKnife(true)
    if not knife then return false end
    local handle = knife:FindFirstChild("Handle")
    local st = knife:FindFirstChild("Stab")
    if st and st:IsA("RemoteEvent") then
        pcall(function() st:FireServer("Slash") end)
    else
        pcall(function() knife:Activate() end)
    end
    if handle and targetRoot and firetouchinterest then
        pcall(function()
            firetouchinterest(handle, targetRoot, 0)
            firetouchinterest(handle, targetRoot, 1)
        end)
    end
    return true
end

local function nearestPlayer(maxDist)
    local my = myHrp()
    if not my then return nil end
    local best, bd = nil, maxDist
    for _, pl in ipairs(Players:GetPlayers()) do
        local ok, r = canKill(pl)
        if ok then
            local d = (r.Position - my.Position).Magnitude
            if d <= bd then best, bd = pl, d end
        end
    end
    return best
end

-- KillAura: бьёт ножом (не бросает) всех в радиусе, только если ты убийца
local ka = {on = false, dist = 4, last = 0}
RunService.Heartbeat:Connect(function()
    if not ka.on or killAllBusy or flingBusy or os.clock() - ka.last < 0.25 then return end
    if not amMurderer() then return end
    local my = myHrp()
    if not my then return end
    for _, pl in ipairs(Players:GetPlayers()) do
        local ok, r = canKill(pl)
        if ok and (r.Position - my.Position).Magnitude <= ka.dist then
            ka.last = os.clock()
            task.spawn(stab, r)
            break
        end
    end
end)

-- Kill All: по очереди телепортируется к каждому и бьёт, потом возвращается назад
task.spawn(function()
    while true do
        task.wait(0.4)
        if killAllOn and not killAllBusy and not flingBusy and not grabBusy and not farmBusy and amMurderer() then
            killAllBusy = true
            pcall(function()
                local my = myHrp()
                if not my then return end
                local origin = my.CFrame
                local list = {}
                for _, pl in ipairs(Players:GetPlayers()) do
                    local ok, r = canKill(pl)
                    if ok then table.insert(list, {pl = pl, d = (r.Position - my.Position).Magnitude}) end
                end
                table.sort(list, function(a, b) return a.d < b.d end)
                for _, e in ipairs(list) do
                    if not killAllOn or not amMurderer() then break end
                    local t0 = os.clock()
                    while os.clock() - t0 < 1.5 and killAllOn do
                        local ok, r = canKill(e.pl)
                        local h = myHrp()
                        if not ok or not h then break end
                        h.CFrame = r.CFrame * CFrame.new(0, 0, 2.5)
                        h.AssemblyLinearVelocity = Vector3.zero
                        stab(r)
                        task.wait(0.2)
                    end
                end
                local h = myHrp()
                if h then
                    h.CFrame = origin
                    h.AssemblyLinearVelocity = Vector3.zero
                end
            end)
            killAllBusy = false
        end
    end
end)

-- Aura Throw: бросок ножа с сильным упреждением
local thr = {on = false, range = 80, cd = 1.2, strength = 100, last = 0}
local THROW_SPEED = 130

local function hasKnife()
    local c = myChar()
    if c and c:FindFirstChild("Knife") then return true end
    local bp = LocalPlayer:FindFirstChild("Backpack")
    return bp ~= nil and bp:FindFirstChild("Knife") ~= nil
end

-- перебираем все ремоуты ножа с "throw" в имени (Throw, KnifeThrown и т.п.)
local function fireKnifeThrow(knife, hand, pos)
    local cands = {}
    local tr = knife:FindFirstChild("Throw")
    if tr then table.insert(cands, tr) end
    for _, d in ipairs(knife:GetDescendants()) do
        if d ~= tr and (d:IsA("RemoteEvent") or d:IsA("RemoteFunction")) and d.Name:lower():find("throw") then
            table.insert(cands, d)
        end
    end
    local sent = false
    for _, r in ipairs(cands) do
        if r:IsA("RemoteEvent") then
            if pcall(function() r:FireServer(CFrame.new(hand), CFrame.new(pos)) end) then sent = true end
        elseif r:IsA("RemoteFunction") then
            task.spawn(function() pcall(function() r:InvokeServer(CFrame.new(hand), CFrame.new(pos)) end) end)
            sent = true
        end
    end
    return sent
end

local function throwAt(pl)
    local ok, r = canKill(pl)
    if not ok then return false end
    local knife = getKnife(true)
    local c = myChar()
    local my = myHrp()
    if not knife or not c or not my then return false end
    local pos = predictAt(r, THROW_SPEED, thr.strength / 100)
    local hand = (c:FindFirstChild("RightHand") or my).Position
    return fireKnifeThrow(knife, hand, pos)
end

RunService.Heartbeat:Connect(function()
    if not thr.on or flingBusy or os.clock() - thr.last < thr.cd then return end
    if not hasKnife() then return end
    local pl = nearestPlayer(thr.range)
    if pl then
        thr.last = os.clock()
        task.spawn(throwAt, pl)
    end
end)

--------------------------------------------------
-- AUTOFARM МОНЕТ / CANDY (Halloween 2026)
--------------------------------------------------
local farm = {on = false, height = 0, speed = 30, limit = 40, flingMurd = false, reset = false, walls = true,
    safe = 0, count = 0, done = false, sessionCoins = 0, waitGame = true, startTime = 0, anchored = false}
do -- блок autofarm (локальные переменные живут только тут)
local coinSkip = setmetatable({}, {__mode = "k"})
local lastContainer, cachedCC, lastCCScan, lastFarmWarn = nil, nil, 0, 0

-- контейнер монет ищем по всему workspace (карта может лежать где угодно)
local function findCoinContainer()
    if cachedCC and cachedCC.Parent then return cachedCC end
    cachedCC = nil
    if os.clock() - lastCCScan < 0.8 then return nil end
    lastCCScan = os.clock()
    -- Halloween 2026: Candies вместо Coins; пробуем оба
    local names = {"CandyContainer", "CoinContainer", "Candies", "CandyFolder", "EventCandies"}
    for _, n in ipairs(names) do
        local f = workspace:FindFirstChild(n, true)
        if f then cachedCC = f return f end
    end
    local cs = workspace:FindFirstChild("Coin_Server", true) -- конфеты/монеты MM2 лежат как Coin_Server
    if cs and cs.Parent then
        cachedCC = cs.Parent
        return cs.Parent
    end
    -- fallback: любая папка с «candy»/«coin» в имени и детьми-партами
    for _, d in ipairs(workspace:GetDescendants()) do
        if d:IsA("Folder") or d:IsA("Model") then
            local ln = d.Name:lower()
            if (ln:find("candy") or ln:find("coin")) and #d:GetChildren() > 0 then
                cachedCC = d
                return d
            end
        end
    end
    return nil
end

local function coinPart(c)
    if c:IsA("BasePart") then return c end
    local p = c:FindFirstChildWhichIsA("BasePart", true)
    if p then return p end
    -- Halloween: иногда candy — Model без BasePart сразу, ищем MeshPart
    return c:FindFirstChildWhichIsA("MeshPart", true)
end
local function hasTouch(c) return c:FindFirstChildWhichIsA("TouchInterest", true) ~= nil end

-- ближайшая нетронутая монета; если у монет есть TouchInterest - берём только с ним
local function nearestCoin(cc, my)
    local items = cc:GetChildren()
    local useTouch = false
    for _, c in ipairs(items) do
        if hasTouch(c) then useTouch = true break end
    end
    local murd = findByRole("Murderer", true)
    local mr = murd and murd.Character and murd.Character:FindFirstChild("HumanoidRootPart")
    local best, bestPart, bd = nil, nil, math.huge
    for _, c in ipairs(items) do
        local part = coinPart(c)
        if part and c.Parent and not c:GetAttribute("Collected") and (not useTouch or hasTouch(c)) then
            local skip = coinSkip[c]
            if not skip or os.clock() > skip then
                local blocked = farm.safe > 0 and mr and (mr.Position - part.Position).Magnitude < farm.safe
                if not blocked then
                    local d = (part.Position - my.Position).Magnitude
                    if d < bd then best, bestPart, bd = c, part, d end
                end
            end
        end
    end
    return best, bestPart, useTouch
end

local function coinGone(c, hadTouch)
    if not c.Parent then return true end
    if c:GetAttribute("Collected") then return true end
    if hadTouch and not hasTouch(c) then return true end
    return false
end

-- считываем реальное число монет из интерфейса (если путь есть), иначе считаем сами
local function readBag()
    local ok, n = pcall(function()
        local lbl = LocalPlayer.PlayerGui.MainGUI.Game.CoinBags.Container.Coin.CurrencyFrame.Icon.Coins
        return tonumber(lbl.Text)
    end)
    return ok and n or nil
end

-- Удержание в воздухе: BodyVelocity вместо Anchored. Anchored-персонаж не вызывает Touched,
-- поэтому сервер раньше не засчитывал конфеты.
local function holdOn()
    local h = myHrp()
    if not h then return end
    h.Anchored = false
    if not h:FindFirstChild("MWFarmHold") then
        local bv = Instance.new("BodyVelocity")
        bv.Name = "MWFarmHold"
        bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
        bv.Velocity = Vector3.zero
        bv.Parent = h
    end
end
farm.release = function()
    farm.anchored = false
    local h = myHrp()
    if h then
        local bv = h:FindFirstChild("MWFarmHold")
        if bv then bv:Destroy() end
        h.Anchored = false
    end
end

-- летим к монете напрямую (сквозь препятствия) со скоростью из слайдера
local function flyTo(part, coin)
    local h0 = myHrp()
    if not h0 then return false end
    farm.anchored = true
    holdOn() -- без удержания с NoClip гравитация тянет вниз сквозь пол
    local spd = math.clamp(tonumber(farm.speed) or 30, 8, 80)
    local limit = (part.Position - h0.Position).Magnitude / spd + 4
    local t0 = os.clock()
    while farm.on and coin.Parent and os.clock() - t0 < limit do
        local h = myHrp()
        if not h then return false end
        local dt = RunService.Heartbeat:Wait()
        if dt <= 0 or dt > 0.1 then dt = 1/60 end
        local targetPos = part.Position + Vector3.new(0, farm.height, 0)
        local diff = targetPos - h.Position
        local dist = diff.Magnitude
        if dist < 1.2 then
            h.CFrame = CFrame.new(targetPos) * h.CFrame.Rotation
            h.AssemblyLinearVelocity = Vector3.zero
            h.AssemblyAngularVelocity = Vector3.zero
            return true
        end
        local step = spd * dt
        if step >= dist then
            h.CFrame = CFrame.new(targetPos) * h.CFrame.Rotation
        else
            h.CFrame = CFrame.new(h.Position + diff.Unit * step) * h.CFrame.Rotation
        end
        h.AssemblyLinearVelocity = Vector3.zero
        h.AssemblyAngularVelocity = Vector3.zero
    end
    return false
end

local function farmLimitReached()
    farm.done = true -- остаёмся висеть на месте, пока не начнётся новый раунд
    if farm.flingMurd then
        farm.release()
        local m = findByRole("Murderer", true)
        if m then flingPlayer(m) end
    end
    if farm.reset then
        farm.release()
        local h = myHum()
        if h then
            h.Health = 0
            pcall(function() myChar():BreakJoints() end)
        end
    end
end

task.spawn(function()
    while true do
        task.wait(0.12)
        if farm.on and not farmBusy and not grabBusy and not flingBusy and not killAllBusy then
            farmBusy = true
            local moved = false
            local ok, err = pcall(function()
                -- waitGame: стоим, пока раунд не начался / после ресета ждём новую игру
                if farm.waitGame and not isGameActive() then
                    return
                end
                local cc = findCoinContainer()
                if cc ~= lastContainer then -- новый раунд / новая карта
                    lastContainer = cc
                    farm.count = 0
                    farm.done = false
                end
                if not cc then
                    if os.clock() - lastFarmWarn > 15 then
                        lastFarmWarn = os.clock()
                        notify("Автофарм: монеты не найдены (раунд не начался?)")
                    end
                    return
                end
                if farm.done then return end -- после лимита + ресета стоим и ждём новую игру
                local my, hum = myHrp(), myHum()
                if not my or not hum or hum.Health <= 0 then return end
                -- счёт ведём сами: путь к мешку в интерфейсе менялся с обновлениями и давал неверное число
                if farm.count >= farm.limit then
                    farmLimitReached()
                    return
                end
                if farm.walls and not noclipEnabled then toggleNoclip(true) end
                local coin, part, hadTouch = nearestCoin(cc, my)
                if not coin then return end
                moved = true
                if flyTo(part, coin) then
                    local got = false
                    local t0 = os.clock()
                    while os.clock() - t0 < 0.7 do
                        local h = myHrp()
                        if not h then break end
                        h.CFrame = CFrame.new(part.Position + Vector3.new(0, farm.height, 0)) * h.CFrame.Rotation
                        h.AssemblyLinearVelocity = Vector3.zero
                        if firetouchinterest then
                            local ti = coin:FindFirstChildWhichIsA("TouchInterest", true)
                            local tpart = (ti and ti.Parent and ti.Parent:IsA("BasePart")) and ti.Parent or part
                            local chr = myChar()
                            if chr then
                                for _, limb in ipairs(chr:GetChildren()) do
                                    if limb:IsA("BasePart") then
                                        pcall(function()
                                            firetouchinterest(limb, tpart, 0)
                                            firetouchinterest(limb, tpart, 1)
                                        end)
                                    end
                                end
                            end
                        end
                        if coinGone(coin, hadTouch) then got = true break end
                        task.wait(0.06)
                    end
                    if got then
                        farm.count = farm.count + 1
                        farm.sessionCoins = (farm.sessionCoins or 0) + 1
                    else
                        coinSkip[coin] = os.clock() + 8
                    end
                else
                    coinSkip[coin] = os.clock() + 8
                end
            end)
            if not ok then warn("[Maneware] autofarm: " .. tostring(err)) end
            if farm.anchored and (not farm.on or not isGameActive()) then farm.release() end
            if farm.on and not isGameActive() and noclipEnabled and not (noclipUser or flyEnabled) then toggleNoclip(false) end
            farmBusy = false
        end
    end
end)

end -- конец блока autofarm

-- Красивое окно автофарма: монеты + время сессии
do
    local farmGui = makeGui("ManewareFarmHUD", 99995)
    local farmFrame = new("Frame", {
        Size = UDim2.new(0, 200, 0, 72),
        Position = UDim2.new(0.5, -100, 0, 52),
        BackgroundColor3 = Color3.fromRGB(12, 12, 18),
        BackgroundTransparency = 0.08,
        BorderSizePixel = 0,
        Visible = false,
        AnchorPoint = Vector2.new(0.5, 0),
    }, farmGui)
    corner(14, farmFrame)
    new("UIStroke", {Color = C.ACCENT, Thickness = 2}, farmFrame)
    local topBar = new("Frame", {Size = UDim2.new(1, 0, 0, 4), BackgroundColor3 = C.ACCENT, BorderSizePixel = 0}, farmFrame)
    corner(2, topBar)
    local titleLbl = new("TextLabel", {
        Size = UDim2.new(1, -16, 0, 22), Position = UDim2.new(0, 8, 0, 10),
        BackgroundTransparency = 1, Text = "🍬 AUTOFARM", TextColor3 = C.ACCENT,
        TextSize = 13, Font = Enum.Font.GothamBold, TextXAlignment = Enum.TextXAlignment.Left,
    }, farmFrame)
    local coinsLbl = new("TextLabel", {
        Size = UDim2.new(1, -16, 0, 18), Position = UDim2.new(0, 8, 0, 32),
        BackgroundTransparency = 1, Text = "Монеты: 0", TextColor3 = C.TEXT,
        TextSize = 14, Font = Enum.Font.GothamSemibold, TextXAlignment = Enum.TextXAlignment.Left,
    }, farmFrame)
    local timeLbl = new("TextLabel", {
        Size = UDim2.new(1, -16, 0, 16), Position = UDim2.new(0, 8, 0, 50),
        BackgroundTransparency = 1, Text = "Время: 00:00", TextColor3 = C.DIM,
        TextSize = 12, Font = Enum.Font.Gotham, TextXAlignment = Enum.TextXAlignment.Left,
    }, farmFrame)
    local function fmtTime(sec)
        sec = math.max(0, math.floor(sec))
        return string.format("%02d:%02d", math.floor(sec / 60), sec % 60)
    end
    RunService.Heartbeat:Connect(function()
        if farm.on then
            farmFrame.Visible = true
            coinsLbl.Text = "Candies: " .. tostring(farm.sessionCoins or 0)
            local st = farm.startTime or 0
            if st > 0 then
                timeLbl.Text = "Время: " .. fmtTime(os.clock() - st)
            else
                timeLbl.Text = "Время: 00:00"
            end
            if farm.waitGame and not isGameActive() then
                titleLbl.Text = "⏳ Ждём игру…"
            elseif farm.done then
                titleLbl.Text = "✅ Лимит / ждём"
            else
                titleLbl.Text = "🍬 AUTOFARM"
            end
        else
            farmFrame.Visible = false
        end
    end)
end

--------------------------------------------------
-- KILL EFFECTS: эффекты, когда умирает убийца / шериф
--------------------------------------------------
local fx = {ghost = false, lightning = false, star = false, starCount = 5, starSpeed = 2,
    starSize = 1, starHue = 48, starStyle = 2, starRainbow = false, starGlow = true,
    styleNames = {"4 луча (искра)", "5 лучей (звезда)", "6 лучей", "8 лучей"}}
local fxDeath
do -- блок эффектов

-- 1) Ghost: полупрозрачная копия игрока плавно поднимается вверх и исчезает
local function spawnGhost(ch)
    if not ch then return end
    local wasArch = ch.Archivable
    ch.Archivable = true
    local clone = ch:Clone()
    ch.Archivable = wasArch
    if not clone then return end
    local kill = {}
    for _, d in ipairs(clone:GetDescendants()) do
        if d:IsA("BaseScript") or d:IsA("Humanoid") or d:IsA("BillboardGui") or d:IsA("Sound")
            or d:IsA("Highlight") or d:IsA("ForceField") or d:IsA("Tool") or d:IsA("SurfaceAppearance") then
            table.insert(kill, d)
        end
    end
    for _, d in ipairs(kill) do pcall(function() d:Destroy() end) end
    local parts, decals = {}, {}
    for _, d in ipairs(clone:GetDescendants()) do
        if d:IsA("BasePart") then
            d.Anchored = true
            d.CanCollide = false
            d.CanTouch = false
            d.CanQuery = false
            d.CastShadow = false
            d.Material = Enum.Material.Neon
            d.Color = Color3.fromRGB(190, 225, 255)
            d.Transparency = 0.45
            pcall(function() d.TextureID = "" end)
            table.insert(parts, d)
        elseif d:IsA("Decal") or d:IsA("Texture") then
            d.Transparency = 0.5
            table.insert(decals, d)
        end
    end
    clone.Name = "MWGhost"
    clone.Parent = workspace
    local base = clone:GetPivot()
    local dur, t0 = 2.6, os.clock()
    local conn
    conn = RunService.Heartbeat:Connect(function()
        local a = (os.clock() - t0) / dur
        if a >= 1 or not clone.Parent then
            conn:Disconnect()
            clone:Destroy()
            return
        end
        clone:PivotTo(base + Vector3.new(math.sin(a * 6) * 0.3, 8 * a, 0))
        local tr = 0.45 + 0.55 * a * a
        for _, pt in ipairs(parts) do pt.Transparency = tr end
        for _, dc in ipairs(decals) do dc.Transparency = 0.5 + 0.5 * a end
    end)
end

-- 2) Molnia: молния в стиле Minecraft бьёт в место смерти
local function spawnLightning(pos)
    local folder = new("Folder", {Name = "MWLightning"}, workspace)
    local ground = pos - Vector3.new(0, 2.5, 0)
    local top = ground + Vector3.new(math.random(-6, 6), 120, math.random(-6, 6))
    local pts = {top}
    local segs = 16
    for i = 1, segs - 1 do
        local a = i / segs
        local p = top:Lerp(ground, a)
        local off = (1 - a) * 8 + 1
        pts[#pts + 1] = p + Vector3.new((math.random() - 0.5) * off * 2, 0, (math.random() - 0.5) * off * 2)
    end
    pts[#pts + 1] = ground
    local parts = {}
    local function bolt(p1, p2, thick)
        local d = p2 - p1
        if d.Magnitude < 0.05 then return end
        parts[#parts + 1] = new("Part", {Anchored = true, CanCollide = false, CanTouch = false, CanQuery = false,
            CastShadow = false, Material = Enum.Material.Neon, Color = Color3.fromRGB(210, 225, 255),
            Size = Vector3.new(thick, thick, d.Magnitude), CFrame = CFrame.lookAt(p1 + d / 2, p2)}, folder)
    end
    for i = 1, #pts - 1 do bolt(pts[i], pts[i + 1], 0.7) end
    local prev = pts[math.random(5, 9)] -- ответвление
    for _ = 1, 4 do
        local np = prev + Vector3.new((math.random() - 0.5) * 14, -(8 + math.random() * 6), (math.random() - 0.5) * 14)
        bolt(prev, np, 0.35)
        prev = np
    end
    local flash = new("Part", {Shape = Enum.PartType.Ball, Size = Vector3.new(6, 6, 6), Position = ground,
        Anchored = true, CanCollide = false, CanTouch = false, CanQuery = false, CastShadow = false,
        Material = Enum.Material.Neon, Color = Color3.new(1, 1, 1), Transparency = 0.3}, folder)
    task.spawn(function()
        local function setT(t)
            for _, pt in ipairs(parts) do pt.Transparency = t end
            flash.Transparency = math.min(1, t + 0.3)
        end
        setT(0) task.wait(0.09)
        setT(1) task.wait(0.05)
        setT(0) task.wait(0.12)
        for i = 1, 10 do
            setT(i / 10)
            task.wait(0.03)
        end
        folder:Destroy()
    end)
end

-- 3) Star: кастомные неоновые звёзды (форма, размер, цвет, свечение - во вкладке KillEffect)
local function starSegments(style)
    local segs = {}
    if style == 1 then
        segs = {{0, -1, 0, 1}, {-1, 0, 1, 0}, {-0.6, -0.6, 0.6, 0.6}, {-0.6, 0.6, 0.6, -0.6}}
    elseif style == 2 then -- пентаграмма
        local pts = {}
        for k = 0, 4 do
            local a = math.rad(90 + k * 72)
            pts[k + 1] = {math.cos(a), math.sin(a)}
        end
        for k = 0, 4 do
            local p1, p2 = pts[k + 1], pts[((k + 2) % 5) + 1]
            segs[#segs + 1] = {p1[1], p1[2], p2[1], p2[2]}
        end
    else
        local n = (style == 3) and 3 or 4
        for k = 0, n - 1 do
            local a = math.rad(90 + k * 180 / n)
            segs[#segs + 1] = {-math.cos(a), -math.sin(a), math.cos(a), math.sin(a)}
        end
    end
    return segs
end

local function spawnStars(pos)
    local spd = math.clamp(fx.starSpeed, 1, 5)
    local dur = 6 / spd + 0.5
    for _ = 1, fx.starCount do
        task.delay(math.random() * 0.6, function()
            local start = pos + Vector3.new((math.random() - 0.5) * 2.5, math.random() * 2 - 0.5, (math.random() - 0.5) * 2.5)
            local folder = new("Folder", {Name = "MWStar"}, workspace)
            local size = math.clamp(fx.starSize or 1, 0.3, 4)
            local R = 1.1 * size
            local th = 0.12 * size
            local hue0 = ((fx.starHue or 48) % 360) / 360
            local function colAt(a)
                if fx.starRainbow then return Color3.fromHSV((hue0 + a) % 1, 0.9, 1) end
                return Color3.fromHSV(hue0, 0.85, 1)
            end
            local segs = starSegments(fx.starStyle or 2)
            local parts = {}
            for i, sg in ipairs(segs) do
                local len = math.sqrt((sg[3] - sg[1]) ^ 2 + (sg[4] - sg[2]) ^ 2) * R
                parts[i] = new("Part", {Anchored = true, CanCollide = false, CanTouch = false, CanQuery = false,
                    CastShadow = false, Material = Enum.Material.Neon, Color = colAt(0),
                    Size = Vector3.new(th, th, math.max(len, 0.1)), Transparency = 0.05}, folder)
            end
            local core = new("Part", {Shape = Enum.PartType.Ball, Size = Vector3.new(th * 2.2, th * 2.2, th * 2.2),
                Anchored = true, CanCollide = false, CanTouch = false, CanQuery = false, CastShadow = false,
                Material = Enum.Material.Neon, Color = colAt(0)}, folder)
            local light
            if fx.starGlow ~= false then
                light = new("PointLight", {Brightness = 2, Range = 7 * size, Color = colAt(0)}, core)
            end
            local t0 = os.clock()
            local rotSpd = 1.5 + math.random() * 1.5
            local rot0 = math.random() * math.pi * 2
            local conn
            conn = RunService.Heartbeat:Connect(function()
                local a = (os.clock() - t0) / dur
                if a >= 1 or not folder.Parent then
                    conn:Disconnect()
                    folder:Destroy()
                    return
                end
                local p = start + Vector3.new(math.sin(a * 8) * 0.25, 9 * a, math.cos(a * 8) * 0.25)
                local base = CFrame.new(p) * CFrame.Angles(0, rot0 + a * rotSpd * math.pi, 0)
                local tr = 0.05 + 0.95 * a * a * a
                local col = colAt(a)
                for i, sg in ipairs(segs) do
                    local c = base * Vector3.new((sg[1] + sg[3]) / 2 * R, (sg[2] + sg[4]) / 2 * R, 0)
                    local dir = base:VectorToWorldSpace(Vector3.new(sg[3] - sg[1], sg[4] - sg[2], 0))
                    parts[i].CFrame = CFrame.lookAt(c, c + dir)
                    parts[i].Transparency = tr
                    parts[i].Color = col
                end
                core.Position = p
                core.Transparency = tr
                core.Color = col
                if light then
                    light.Color = col
                    light.Brightness = 2 * (1 - a)
                end
            end)
        end)
    end
end

fxDeath = function(ch, pos)
    if fx.ghost then pcall(spawnGhost, ch) end
    if fx.lightning then pcall(spawnLightning, pos) end
    if fx.star then pcall(spawnStars, pos) end
end

-- запоминаем роль, пока игрок жив (после смерти инвентарь уже пуст)
local roleCache = {}
task.spawn(function()
    while true do
        task.wait(0.25)
        for _, pl in ipairs(Players:GetPlayers()) do
            local h = pl.Character and pl.Character:FindFirstChildOfClass("Humanoid")
            if h and h.Health > 0 then roleCache[pl] = getRole(pl) end
        end
    end
end)
Players.PlayerRemoving:Connect(function(pl) roleCache[pl] = nil end)

local function hookDeath(pl)
    local function onChar(ch)
        local hum = ch:WaitForChild("Humanoid", 5)
        if not hum then return end
        hum.Died:Connect(function()
            local role = roleCache[pl]
            if role ~= "Murderer" and role ~= "Sheriff" then return end
            local hrp = ch:FindFirstChild("HumanoidRootPart")
            if hrp then fxDeath(ch, hrp.Position) end
        end)
    end
    if pl.Character then task.spawn(onChar, pl.Character) end
    pl.CharacterAdded:Connect(onChar)
end
for _, pl in ipairs(Players:GetPlayers()) do hookDeath(pl) end
Players.PlayerAdded:Connect(hookDeath)
end -- конец блока эффектов

--------------------------------------------------
-- ПОИСК АССЕТОВ (Creator Store): морфы и звуки ИЩЕМ, а не создаём
--------------------------------------------------
local assetCache = readJson("assets.json") or {} -- "model:ключ"/"audio:ключ" -> id
local function saveAssets() writeJson("assets.json", assetCache) end

local function httpGetBody(url)
    local ok, res = pcall(function() return game:HttpGet(url) end)
    if ok and type(res) == "string" and #res > 0 then return res end
    local rq = request or http_request or (syn and syn.request) or (http and http.request)
    if rq then
        local ok2, resp = pcall(function() return rq({Url = url, Method = "GET"}) end)
        if ok2 and type(resp) == "table" and resp.Body then return resp.Body end
    end
    return nil
end

-- список id ассетов по запросу (kind: "model" | "audio")
local function searchAssets(kind, keyword)
    local enc = HttpService:UrlEncode(keyword)
    local urls
    if kind == "audio" then
        urls = {
            "https://apis.roblox.com/toolbox-service/v1/marketplace/3?limit=30&pageNumber=0&sortType=0&keyword=" .. enc,
            "https://apis.roblox.com/toolbox-service/v2/assets:search?searchCategoryType=Audio&maxPageSize=30&query=" .. enc,
        }
    else
        urls = {
            "https://apis.roblox.com/toolbox-service/v1/marketplace/10?limit=30&pageNumber=0&sortType=0&keyword=" .. enc,
            "https://apis.roblox.com/toolbox-service/v2/assets:search?searchCategoryType=Model&maxPageSize=30&query=" .. enc,
        }
    end
    for _, url in ipairs(urls) do
        local body = httpGetBody(url)
        if body then
            local ok, data = pcall(function() return HttpService:JSONDecode(body) end)
            if ok and type(data) == "table" then
                local list = data.data or data.creatorStoreAssets or data.assets or {}
                local ids = {}
                for _, it in ipairs(list) do
                    local id = it.id or (it.asset and it.asset.id) or it.assetId
                    if id then table.insert(ids, tonumber(id)) end
                end
                if #ids > 0 then return ids end
            end
        end
    end
    return {}
end

local modelTemplates = {}
local function fetchModel(id)
    if modelTemplates[id] then return modelTemplates[id] end
    local ok, res = pcall(function() return game:GetObjects("rbxassetid://" .. id) end)
    if not ok or type(res) ~= "table" or not res[1] then return nil end
    local m = res[1]
    local wrap
    if m:IsA("Model") then
        wrap = m
    else
        wrap = Instance.new("Model")
        if m:IsA("BasePart") then
            m.Parent = wrap
        else
            for _, ch in ipairs(m:GetChildren()) do ch.Parent = wrap end
        end
    end
    if not wrap:FindFirstChildWhichIsA("BasePart", true) then return nil end
    modelTemplates[id] = wrap
    return wrap
end

local function audioOk(id)
    local snd0 = Instance.new("Sound")
    snd0.SoundId = "rbxassetid://" .. id
    snd0.Parent = game:GetService("SoundService")
    pcall(function() game:GetService("ContentProvider"):PreloadAsync({snd0}) end)
    local ok = snd0.TimeLength > 0
    snd0:Destroy()
    return ok
end

--------------------------------------------------
-- RADIO-ГРУППА тогглов (включил один - остальные выключились)
--------------------------------------------------
local function radioGroup(tab, prefix, labels, defIdx, onPick, iconId)
    local cur = defIdx
    local keys = {}
    for i, lab in ipairs(labels) do keys[i] = prefix .. lab end
    for i = 1, #labels do
        tab.Toggle(keys[i], i == defIdx, function(v)
            if v then
                local changed = cur ~= i
                cur = i
                for j = 1, #labels do
                    if j ~= i then
                        local e = REG[keys[j]]
                        if e and e.get() then e.set(false, true) end
                    end
                end
                onPick(i, changed)
            elseif cur == i then
                local e = REG[keys[i]]
                if e then task.defer(function() e.set(true, true) end) end -- один стиль всегда выбран
            end
        end, iconId)
    end
end

--------------------------------------------------
-- CUSTOM MODEL (морфы: тунтунсахур x3 и AWP) - модели ищутся в Creator Store
--------------------------------------------------
local cm = {on = false, sel = 1, size = 1.0, busy = false, applied = nil}
local MODEL_SLOTS = {
    {key = "sahur1", label = "Tung Tung Sahur", q = "tung tung tung sahur morph"},
    {key = "sahur2", label = "Sahur #2", q = "tung tung sahur"},
    {key = "sahur3", label = "Sahur #3", q = "sahur brainrot"},
    {key = "awp", label = "AWP", q = "awp gun morph"},
    {key = "chick1", label = "Chicken Gun: Курица", q = "chicken gun chicken morph"},
    {key = "chick2", label = "Chicken Gun: Петух", q = "chicken gun rooster morph"},
    {key = "chick3", label = "Chicken Gun: Курица #3", q = "chicken gun"},
    {key = "skibidi", label = "Skibidi Toilet", q = "skibidi toilet morph"},
    {key = "shrek", label = "Shrek", q = "shrek morph"},
    {key = "huggy", label = "Huggy Wuggy", q = "huggy wuggy morph"},
    {key = "doge", label = "Doge", q = "doge morph"},
    {key = "amongus", label = "Among Us", q = "among us morph"},
    {key = "steve", label = "Minecraft Steve", q = "minecraft steve morph"},
    {key = "sonic", label = "Sonic", q = "sonic morph"},
    {key = "freddy", label = "Freddy Fazbear", q = "freddy fazbear morph"},
    {key = "siren", label = "Siren Head", q = "siren head morph"},
    {key = "capy", label = "Capybara", q = "capybara morph"},
    {key = "sans", label = "Sans", q = "sans morph"},
}
local hiddenOrig = {}

local function resolveModelSlot(slot)
    local key = "model:" .. slot.key
    local id = assetCache[key]
    if id and fetchModel(id) then return id end
    local used = {}
    for k, v in pairs(assetCache) do
        if k:sub(1, 6) == "model:" and k ~= key then used[v] = true end -- у слотов разные морфы
    end
    local ids = searchAssets("model", slot.q)
    for i = 1, math.min(#ids, 12) do
        if not used[ids[i]] and fetchModel(ids[i]) then
            assetCache[key] = ids[i]
            saveAssets()
            return ids[i]
        end
    end
    return nil
end

local function clearCustomModel()
    cm.applied = nil
    local c = myChar()
    local old = c and c:FindFirstChild("MWCustomModel")
    if old then old:Destroy() end
    for inst, tr in pairs(hiddenOrig) do pcall(function() inst.Transparency = tr end) end
    hiddenOrig = {}
end

local function applyCustomModel()
    if cm.busy then return end
    cm.busy = true
    task.spawn(function()
        pcall(function()
            local idx = cm.sel
            local slot = MODEL_SLOTS[idx]
            notify("Ищу морф: " .. slot.label .. "…")
            local id = resolveModelSlot(slot)
            if not id then notify("Морф не найден (введи ID вручную во вкладке CustomModel)") return end
            local tpl = fetchModel(id)
            local c, hrp = myChar(), myHrp()
            if not tpl or not c or not hrp or not cm.on then return end
            clearCustomModel()
            local m = tpl:Clone()
            m.Name = "MWCustomModel"
            local kill = {}
            for _, d in ipairs(m:GetDescendants()) do
                if d:IsA("BaseScript") or d:IsA("Humanoid") then table.insert(kill, d) end
            end
            for _, d in ipairs(kill) do pcall(function() d:Destroy() end) end
            pcall(function() m:ScaleTo(cm.size) end)
            local parts = {}
            for _, d in ipairs(m:GetDescendants()) do
                if d:IsA("BasePart") then
                    d.Anchored = false
                    d.CanCollide = false
                    d.CanTouch = false
                    d.CanQuery = false
                    d.Massless = true
                    table.insert(parts, d)
                end
            end
            local primary = m.PrimaryPart or parts[1]
            if not primary then return end
            m.Parent = c
            local _, size = m:GetBoundingBox()
            m:PivotTo(hrp.CFrame * CFrame.new(0, size.Y / 2 - 3, 0))
            for _, pt in ipairs(parts) do
                if pt ~= primary then
                    local w = Instance.new("WeldConstraint")
                    w.Part0, w.Part1 = primary, pt
                    w.Parent = primary
                end
            end
            local w0 = Instance.new("WeldConstraint")
            w0.Part0, w0.Part1 = hrp, primary
            w0.Parent = primary
            for _, d in ipairs(c:GetDescendants()) do -- прячем оригинальную модель (виден только морф)
                if not d:IsDescendantOf(m) then
                    if (d:IsA("BasePart") and d.Name ~= "HumanoidRootPart") or d:IsA("Decal") then
                        hiddenOrig[d] = d.Transparency
                        d.Transparency = 1
                    end
                end
            end
            cm.applied = idx
            notify("Морф: " .. slot.label .. " ✔")
        end)
        cm.busy = false
    end)
end

--------------------------------------------------
-- SOUND: замена звука пистолета (звуки ищутся в Creator Store)
--------------------------------------------------
local snd = {gun = false, sel = 1}
local SOUND_SLOTS = { -- exact = проверенный ID, без поиска (поиск находил левые звуки)
    {key = "skeet", label = "skeet", id = 5447626464, exact = true},
    {key = "neverlose", label = "neverlose", id = 8679627751, exact = true},
    {key = "gamesense", label = "gamesense", id = 4817809188, exact = true},
    {key = "bell", label = "bell", id = 6534947240, exact = true},
    {key = "uwu", label = "uwu", id = 8679659744, exact = true},
    {key = "rust", label = "rust", id = 1255040462, exact = true},
    {key = "cod", label = "cod", id = 160432334, exact = true},
    {key = "bameware", label = "bameware", id = 3124331820, exact = true},
    {key = "awp", label = "AWP (CS:GO)", q = "csgo awp"},
    {key = "deagle", label = "Deagle (CS:GO)", q = "csgo deagle"},
}
local soundId = nil
local origSounds = setmetatable({}, {__mode = "k"})

local function resolveSoundSlot(slot)
    local key = "audio:" .. slot.key
    if slot.exact then return assetCache[key .. "!"] or slot.id end
    local id = assetCache[key]
    if id and audioOk(id) then return id end
    -- встроенный ID (Click 1/2/3) — пробуем сразу
    if slot.id and audioOk(slot.id) then
        assetCache[key] = slot.id
        saveAssets()
        return slot.id
    end
    local ids = searchAssets("audio", slot.q)
    for i = 1, math.min(#ids, 12) do
        if audioOk(ids[i]) then
            assetCache[key] = ids[i]
            saveAssets()
            return ids[i]
        end
    end
    return slot.id -- fallback даже если audioOk не прошёл (на некоторых executor)
end

local function applySoundSlot(i)
    task.spawn(function()
        local slot = SOUND_SLOTS[i]
        notify("Ищу звук: " .. slot.label .. "…")
        local id = resolveSoundSlot(slot)
        if i ~= snd.sel then return end
        soundId = id
        notify(id and ("Звук: " .. slot.label .. " ✔") or "Звук не найден (введи ID вручную во вкладке Sound)")
    end)
end

local function patchSound(sd)
    if not snd.gun or not soundId then return end
    if origSounds[sd] == nil then origSounds[sd] = sd.SoundId end
    local want = "rbxassetid://" .. soundId
    if sd.SoundId ~= want then sd.SoundId = want end
end
local function isGunSound(sd)
    if not sd:IsA("Sound") then return false end
    if sd:FindFirstAncestor("Gun") then return true end
    local n = sd.Name:lower()
    return n:find("gun") ~= nil or n:find("shoot") ~= nil
end
local function restoreSounds()
    for sd, id in pairs(origSounds) do pcall(function() if sd.Parent then sd.SoundId = id end end) end
    origSounds = setmetatable({}, {__mode = "k"})
end
workspace.DescendantAdded:Connect(function(d)
    if snd.gun and soundId and isGunSound(d) then pcall(patchSound, d) end
end)
task.spawn(function()
    while true do
        task.wait(0.7)
        if snd.gun and soundId then
            pcall(function()
                for _, pl in ipairs(Players:GetPlayers()) do
                    local conts = {}
                    if pl.Character then table.insert(conts, pl.Character) end
                    local bp = pl:FindFirstChild("Backpack")
                    if bp then table.insert(conts, bp) end
                    for _, cont in ipairs(conts) do
                        local gun = cont:FindFirstChild("Gun")
                        if gun then
                            for _, d in ipairs(gun:GetDescendants()) do
                                if d:IsA("Sound") then patchSound(d) end
                            end
                        end
                    end
                end
            end)
        end
    end
end)
local function previewSound()
    if not soundId then notify("Звук ещё не найден") return end
    local sd = Instance.new("Sound")
    sd.SoundId = "rbxassetid://" .. soundId
    sd.Volume = 1
    sd.Parent = game:GetService("SoundService")
    sd:Play()
    task.delay(5, function() sd:Destroy() end)
end

--------------------------------------------------
-- NAME PROTECT: визуально скрывает ник (watermark / где возможно)
--------------------------------------------------
local np = {on = false, text = "Hidden"}
local function displayName()
    if np.on and np.text and np.text ~= "" then return tostring(np.text) end
    return LocalPlayer.Name
end

-- WATERMARK: 4 стиля (по скриншотам)
--------------------------------------------------
local wm = {on = false, style = 1, size = 5}
local wmRebuild, wmSetScale = function() end, function() end
local WM_STYLES
do -- блок стилей watermark
local StatsService = game:GetService("Stats")

local function mskTime() -- время по Москве (UTC+3)
    local t = os.date("!*t", os.time() + 3 * 3600)
    local h12 = t.hour % 12
    if h12 == 0 then h12 = 12 end
    return string.format("%02d:%02d %s", h12, t.min, t.hour >= 12 and "PM" or "AM")
end
local function getPing()
    local ok, v = pcall(function() return StatsService.Network.ServerStatsItem["Data Ping"]:GetValue() end)
    if ok and v then return math.floor(v + 0.5) end
    local ok2, p = pcall(function() return LocalPlayer:GetNetworkPing() end)
    return ok2 and math.floor(p * 1000 + 0.5) or 0
end
local function getMem()
    local ok, v = pcall(function() return StatsService:GetTotalMemoryUsageMb() end)
    return ok and math.floor(v + 0.5) or 0
end
local XY = Enum.AutomaticSize.XY
local function pad(parent, l, t)
    new("UIPadding", {PaddingLeft = UDim.new(0, l), PaddingRight = UDim.new(0, l), PaddingTop = UDim.new(0, t),
        PaddingBottom = UDim.new(0, t)}, parent)
end
local function gradStroke(parent, thick, c1, c2, rot)
    local st = new("UIStroke", {Thickness = thick, Color = Color3.new(1, 1, 1)}, parent)
    new("UIGradient", {Color = ColorSequence.new(c1, c2), Rotation = rot or 0}, st)
end

-- Стиль 1: MANEWARE » ник » UID » время МСК
local function wmStyle1(root)
    local f = new("Frame", {AutomaticSize = XY, BackgroundColor3 = Color3.fromRGB(14, 14, 20), BorderSizePixel = 0}, root)
    corner(14, f)
    gradStroke(f, 2, Color3.fromRGB(170, 80, 255), Color3.fromRGB(70, 140, 255))
    pad(f, 14, 7)
    local tl = new("TextLabel", {AutomaticSize = XY, BackgroundTransparency = 1, Text = "", TextColor3 = Color3.new(1, 1, 1),
        TextSize = 14, Font = Enum.Font.GothamBold}, f)
    return function()
        tl.Text = string.format("MANEWARE » %s » UID: %d » %s", string.upper(displayName()), UID, mskTime())
    end
end

-- Стиль 2: две вкладки - название и UID
local function wmStyle2(root)
    local col = new("Frame", {AutomaticSize = XY, BackgroundTransparency = 1}, root)
    new("UIListLayout", {Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder}, col)
    local function tab(order, logo)
        local f = new("Frame", {AutomaticSize = XY, BackgroundColor3 = Color3.fromRGB(24, 18, 40), BorderSizePixel = 0,
            LayoutOrder = order}, col)
        corner(8, f)
        gradStroke(f, 1.5, Color3.fromRGB(190, 110, 255), Color3.fromRGB(110, 70, 220), 90)
        pad(f, 12, 6)
        new("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 8),
            VerticalAlignment = Enum.VerticalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder}, f)
        if logo then
            new("TextLabel", {AutomaticSize = XY, BackgroundTransparency = 1, Text = "⚛", TextColor3 = Color3.fromRGB(200, 130, 255),
                TextSize = 20, Font = Enum.Font.GothamBold, LayoutOrder = 1}, f)
        end
        return new("TextLabel", {AutomaticSize = XY, BackgroundTransparency = 1, Text = "", TextColor3 = Color3.new(1, 1, 1),
            TextSize = 15, Font = Enum.Font.GothamBold, LayoutOrder = 2}, f)
    end
    local t1l, t2l = tab(1, true), tab(2, false)
    return function()
        t1l.Text = "Maneware"
        t2l.Text = "UID: " .. UID
    end
end

-- Стиль 3: зелёная плашка + аватар + белая табличка MANEWARE
local function wmStyle3(root)
    local f = new("Frame", {Size = UDim2.new(0, 210, 0, 58), BackgroundTransparency = 1}, root)
    local av = new("ImageLabel", {Size = UDim2.new(0, 44, 0, 44), Position = UDim2.new(0, 0, 0, 8),
        BackgroundColor3 = Color3.fromRGB(20, 20, 26), BorderSizePixel = 0, ZIndex = 3,
        Image = "rbxthumb://type=AvatarHeadShot&id=" .. LocalPlayer.UserId .. "&w=150&h=150"}, f)
    corner(22, av)
    new("UIStroke", {Thickness = 2, Color = Color3.new(1, 1, 1)}, av)
    local pill = new("Frame", {Size = UDim2.new(0, 150, 0, 30), Position = UDim2.new(0, 50, 0, 20),
        BackgroundColor3 = Color3.new(1, 1, 1), BorderSizePixel = 0, ZIndex = 2}, f)
    corner(15, pill)
    new("TextLabel", {Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, Text = "MANEWARE",
        TextColor3 = Color3.new(0, 0, 0), TextSize = 17, Font = Enum.Font.GothamBlack, ZIndex = 3}, pill)
    return function() end
end

-- Стиль 4: пинг | память | ник | название места (кастомные иконки)
local function wmStyle4(root)
    local f = new("Frame", {AutomaticSize = XY, BackgroundColor3 = Color3.fromRGB(14, 14, 22), BackgroundTransparency = 0.1,
        BorderSizePixel = 0}, root)
    corner(10, f)
    new("UIStroke", {Thickness = 1, Color = Color3.fromRGB(50, 50, 70)}, f)
    pad(f, 14, 8)
    new("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 16),
        VerticalAlignment = Enum.VerticalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder}, f)
    local function seg(order, iconId)
        local sg = new("Frame", {AutomaticSize = XY, BackgroundTransparency = 1, LayoutOrder = order}, f)
        new("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 6),
            VerticalAlignment = Enum.VerticalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder}, sg)
        local ic = new("ImageLabel", {Size = UDim2.new(0, 18, 0, 18), BackgroundTransparency = 1,
            Image = iconId or "", ImageColor3 = Color3.fromRGB(110, 120, 255), ScaleType = Enum.ScaleType.Fit, LayoutOrder = 1}, sg)
        return new("TextLabel", {AutomaticSize = XY, BackgroundTransparency = 1, Text = "", TextColor3 = Color3.new(1, 1, 1),
            TextSize = 14, Font = Enum.Font.GothamBold, LayoutOrder = 2}, sg)
    end
    -- кастомные иконки: SPEED (пинг), UTIL (память), TARGET (ник), HAT (место)
    local lPing, lMem, lNick, lPlace = seg(1, ICONS.SPEED), seg(2, ICONS.UTIL), seg(3, ICONS.TARGET), seg(4, ICONS.HAT)
    return function()
        lPing.Text = getPing() .. "MS"
        lMem.Text = getMem() .. " mb"
        lNick.Text = displayName()
        lPlace.Text = "Загадка убийства 2"
    end
end
WM_STYLES = {wmStyle1, wmStyle2, wmStyle3, wmStyle4}
end -- конец блока watermark

--------------------------------------------------
-- NOTIFY (карточки как в Celestial) / SOUNDNOTIFY / GRADIENTS (состояние)
--------------------------------------------------
local nf = {on = true}
local sn = {on = false, sel = 1, id = nil}
-- Звуки уведомлений (короткие UI-клики / enable-disable как в клиентах)
local SN_SLOTS = {
    {key = "click1", label = "Click", id = 6895079853, exact = true},
    {key = "osu", label = "Osu hit", id = 7147454322, exact = true},
    {key = "bellsn", label = "Bell", id = 131573697, exact = true},
    {key = "vineboom", label = "Vine Boom", id = 6308606116, exact = true},
    {key = "oof", label = "Oof", id = 5943191430, exact = true},
    {key = "uwusn", label = "uwu", id = 8679659744, exact = true},
}
local grad = {on = false, sel = 1}

do -- карточки-уведомления: 1 строка - название функции/событие, 2 строка - что произошло
    local toastGui = makeGui("ManewareToast", 100001)
    local holder = new("Frame", {Size = UDim2.new(0, 250, 1, -24), Position = UDim2.new(1, -262, 0, 12),
        BackgroundTransparency = 1}, toastGui)
    new("UIListLayout", {Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder,
        VerticalAlignment = Enum.VerticalAlignment.Bottom}, holder)
    local active, order = {}, 0

    local function playNotifySound()
        local sd = Instance.new("Sound")
        sd.SoundId = "rbxassetid://" .. sn.id
        sd.Volume = 1
        sd.Parent = game:GetService("SoundService")
        sd:Play()
        task.delay(4, function() sd:Destroy() end)
    end

    local function makeToast(title, msg, kind)
        local old = active[title]
        if old and old.Parent then old:Destroy() end -- новое уведомление заменяет старое с тем же названием
        order = order + 1
        local col = kind == "off" and Color3.fromRGB(239, 68, 68)
            or (kind == "info" and Color3.fromRGB(110, 120, 255) or Color3.fromRGB(80, 220, 120))
        local card = new("Frame", {Size = UDim2.new(1, 0, 0, 54), BackgroundColor3 = X.cardColor or Color3.fromRGB(14, 14, 20),
            BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = order}, holder)
        corner(10, card)
        local stroke = new("UIStroke", {Color = Color3.fromRGB(90, 90, 120), Thickness = 1, Transparency = 1}, card)
        local icon = new("TextLabel", {Size = UDim2.new(0, 30, 1, 0), Position = UDim2.new(0, 10, 0, 0),
            BackgroundTransparency = 1, Text = kind == "off" and "✖" or (kind == "info" and "ℹ" or "✔"), TextColor3 = col,
            TextSize = 22, Font = Enum.Font.GothamBold, TextTransparency = 1}, card)
        local l1 = new("TextLabel", {Size = UDim2.new(1, -54, 0, 20), Position = UDim2.new(0, 46, 0, 8),
            BackgroundTransparency = 1, Text = title, TextColor3 = Color3.new(1, 1, 1), TextSize = 15,
            Font = Enum.Font.GothamBold, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
            TextTransparency = 1}, card)
        local l2 = new("TextLabel", {Size = UDim2.new(1, -54, 0, 18), Position = UDim2.new(0, 46, 0, 28),
            BackgroundTransparency = 1, Text = msg, TextColor3 = Color3.fromRGB(205, 210, 220), TextSize = 12,
            Font = Enum.Font.GothamSemibold, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
            TextTransparency = 1}, card)
        active[title] = card
        local ti = TweenInfo.new(0.25, Enum.EasingStyle.Quad)
        TweenService:Create(card, ti, {BackgroundTransparency = 0.12}):Play()
        TweenService:Create(stroke, ti, {Transparency = 0.4}):Play()
        for _, lb in ipairs({icon, l1, l2}) do TweenService:Create(lb, ti, {TextTransparency = 0}):Play() end
        task.delay(2.8, function()
            if not card.Parent then return end
            local to = TweenInfo.new(0.3, Enum.EasingStyle.Quad)
            TweenService:Create(card, to, {BackgroundTransparency = 1}):Play()
            TweenService:Create(stroke, to, {Transparency = 1}):Play()
            for _, lb in ipairs({icon, l1, l2}) do TweenService:Create(lb, to, {TextTransparency = 1}):Play() end
            task.wait(0.35)
            card:Destroy()
        end)
    end

    NT.send = function(title, msg, kind)
        if not nf.on then -- Notify выключен: обычное уведомление Roblox
            pcall(function()
                StarterGui:SetCore("SendNotification", {Title = title, Text = msg, Duration = 3})
            end)
            return
        end
        pcall(makeToast, title, msg, kind or "info")
        if sn.on and sn.id then pcall(playNotifySound) end
    end
    NT.toggle = function(name, state)
        if not nf.on then return end
        local title = tostring(name):gsub("%s*%(.*$", "")
        NT.send(title, state and "включён" or "выключен", state and "ok" or "off")
    end
end

X.applySoundNotify = function(i)
    task.spawn(function()
        local id = resolveSoundSlot(SN_SLOTS[i])
        if i ~= sn.sel then return end
        sn.id = id
        notify("SoundNotify: " .. (id and "звук найден" or "звук не найден, введи ID вручную"))
    end)
end

--------------------------------------------------
-- SVO: управляемый дрон (Shahed и др.), игрок стоит заморожен
--------------------------------------------------
local SVO_SLOTS = {
    {key = "shahed1", label = "Shahed #1", q = "shahed 136 drone"},
    {key = "shahed2", label = "Shahed #2", q = "shahed drone morph"},
    {key = "shahed3", label = "Shahed #3", q = "geran 2 drone"},
    {key = "kamikaze", label = "Kamikaze drone", q = "kamikaze drone"},
    {key = "drone2", label = "Drone #2", q = "fpv drone"},
    {key = "drone3", label = "Drone #3", q = "military drone morph"},
}
local svo = {on = false, sel = 1, speed = 45, busy = false}

do -- блок SVO
    local function buildDrone(slot)
        local id = resolveModelSlot(slot) -- морф ищем в Creator Store, а не создаём
        local tpl = id and fetchModel(id)
        local m
        if tpl then
            m = tpl:Clone()
            local kill = {}
            for _, d in ipairs(m:GetDescendants()) do
                if d:IsA("BaseScript") or d:IsA("Humanoid") then table.insert(kill, d) end
            end
            for _, d in ipairs(kill) do pcall(function() d:Destroy() end) end
            local first
            for _, d in ipairs(m:GetDescendants()) do
                if d:IsA("BasePart") then
                    d.Anchored = true
                    d.CanCollide = false
                    d.CanTouch = false
                    d.CanQuery = false
                    d.Massless = true
                    first = first or d
                end
            end
            if not m.PrimaryPart and first then pcall(function() m.PrimaryPart = first end) end
            local _, size = m:GetBoundingBox()
            local maxd = math.max(size.X, size.Y, size.Z)
            if maxd > 14 or maxd < 2 then pcall(function() m:ScaleTo(6 / maxd) end) end
        else
            notify("SVO: морф не найден, лечу запасной моделью")
            m = Instance.new("Model")
            local body = new("Part", {Size = Vector3.new(1, 1, 6), Color = Color3.fromRGB(80, 85, 90),
                Material = Enum.Material.Metal, Anchored = true, CanCollide = false, CanTouch = false, CanQuery = false}, m)
            new("WedgePart", {Size = Vector3.new(6, 0.25, 3), Color = Color3.fromRGB(95, 100, 105),
                Material = Enum.Material.Metal, Anchored = true, CanCollide = false, CanTouch = false, CanQuery = false,
                CFrame = body.CFrame * CFrame.new(0, 0, 1.5)}, m)
            m.PrimaryPart = body
        end
        return m
    end

    local function explode(pos)
        pcall(function()
            local ex = Instance.new("Explosion")
            ex.Position = pos
            ex.BlastRadius = 12
            ex.BlastPressure = 0 -- только визуально
            ex.DestroyJointRadiusPercent = 0
            ex.Parent = workspace
        end)
        local flash = new("Part", {Shape = Enum.PartType.Ball, Size = Vector3.new(4, 4, 4), Position = pos, Anchored = true,
            CanCollide = false, CanTouch = false, CanQuery = false, Material = Enum.Material.Neon,
            Color = Color3.fromRGB(255, 170, 60), Transparency = 0.2}, workspace)
        TweenService:Create(flash, TweenInfo.new(0.5), {Size = Vector3.new(22, 22, 22), Transparency = 1}):Play()
        task.delay(0.6, function() flash:Destroy() end)
    end

    local function runSvo()
        svo.busy = true
        local drone
        local ok, err = pcall(function()
            local slot = SVO_SLOTS[svo.sel]
            notify("SVO: готовлю " .. slot.label)
            drone = buildDrone(slot)
            if not svo.on then return end
            local hrp, hum = myHrp(), myHum()
            if not hrp or not hum or hum.Health <= 0 then notify("SVO: нет персонажа") return end
            drone.Name = "MWDrone"
            drone.Parent = workspace
            local pos = hrp.Position + Vector3.new(0, 6, 0)
            local cf = CFrame.lookAt(pos, pos + hrp.CFrame.LookVector)
            drone:PivotTo(cf)
            hrp.Anchored = true -- игрок стоит заморожен, пока летит дрон
            Camera.CameraSubject = drone.PrimaryPart or drone:FindFirstChildWhichIsA("BasePart", true)
            notify("SVO: запуск, веди дрон как при ходьбе")
            local target
            local t0 = os.clock()
            while svo.on and os.clock() - t0 < 90 do
                local dt = RunService.Heartbeat:Wait()
                local h2 = myHum()
                if not h2 or h2.Health <= 0 or not myHrp() then break end
                local c = Camera.CFrame
                local rel = c:VectorToObjectSpace(h2.MoveDirection)
                local mv = c.LookVector * -rel.Z + c.RightVector * rel.X
                if mv.Magnitude > 0 then
                    pos = pos + mv.Unit * svo.speed * dt
                    cf = CFrame.lookAt(pos, pos + mv.Unit)
                else
                    cf = CFrame.new(pos) * cf.Rotation
                end
                drone:PivotTo(cf)
                for _, pl in ipairs(Players:GetPlayers()) do -- попадание в игрока
                    if pl ~= LocalPlayer then
                        local ch = pl.Character
                        local r = ch and ch:FindFirstChild("HumanoidRootPart")
                        local th = ch and ch:FindFirstChildOfClass("Humanoid")
                        if r and th and th.Health > 0 and (r.Position - pos).Magnitude < 4.5 then
                            target = pl
                            break
                        end
                    end
                end
                if target then break end
            end
            if target then explode(pos) end
            drone:Destroy()
            drone = nil
            local hrp2, hum2 = myHrp(), myHum()
            if hrp2 then hrp2.Anchored = false end -- разморозка
            if hum2 then Camera.CameraSubject = hum2 end
            if target then
                notify("SVO: попадание в " .. target.DisplayName)
                flingPlayer(target) -- флинг цели и возврат на место, где стоял до запуска
            else
                notify("SVO: полёт отменён")
            end
        end)
        if drone then pcall(function() drone:Destroy() end) end
        local hrp3, hum3 = myHrp(), myHum()
        if hrp3 then hrp3.Anchored = false end
        if hum3 then Camera.CameraSubject = hum3 end
        if not ok then
            warn("[Maneware] SVO: " .. tostring(err))
            notify("SVO: ошибка " .. tostring(err))
        end
        svo.on = false
        local e = REG["SVO"]
        if e and e.get() then e.set(false, true) end
        svo.busy = false
    end

    X.svoToggle = function(v)
        if v and not svo.busy then task.spawn(runSvo) end
    end
end

--------------------------------------------------
-- TRIGGERBOT и AIMASSIST
--------------------------------------------------
local trig = {on = false, delay = 100, last = 0}
local assist = {on = false, smooth = 1.0, speed = 1.0, visible = true, vis = true, visT = 0}

do
    local rp = RaycastParams.new()
    rp.FilterType = Enum.RaycastFilterType.Exclude

    -- TriggerBot: стреляет, когда хитбокс убийцы попал в прицел (центр экрана)
    RunService.Heartbeat:Connect(function()
        if not trig.on or aimBusy then return end
        if os.clock() - trig.last < trig.delay / 1000 then return end
        local mc0 = myChar()
        if not mc0 or not hasGun() then return end
        local m = findByRole("Murderer", true)
        local mc = m and m.Character
        if not mc then return end
        local vp = Camera.ViewportSize
        local ray = Camera:ViewportPointToRay(vp.X / 2, vp.Y / 2)
        rp.FilterDescendantsInstances = {mc0}
        local res = workspace:Raycast(ray.Origin, ray.Direction * 600, rp)
        if res and res.Instance:IsDescendantOf(mc) then
            trig.last = os.clock()
            aimBusy = true
            task.spawn(function()
                pcall(function() shoot(res.Position) end)
                aimBusy = false
            end)
        end
    end)

    -- AimAssist: плавно наводит камеру на убийцу
    RunService:BindToRenderStep("MWAimAssist", Enum.RenderPriority.Camera.Value + 1, function(dt)
        if not assist.on then return end
        local m = findByRole("Murderer", true)
        local mc = m and m.Character
        local hrp = mc and mc:FindFirstChild("HumanoidRootPart")
        local hum = mc and mc:FindFirstChildOfClass("Humanoid")
        if not hrp or not hum or hum.Health <= 0 then return end
        if assist.visible then
            if os.clock() - assist.visT > 0.1 then
                assist.visT = os.clock()
                assist.vis = isVisible(mc) -- в поле зрения и не за стеной
            end
            if not assist.vis then return end
        end
        local cam = Camera
        local want = CFrame.lookAt(cam.CFrame.Position, hrp.Position + Vector3.new(0, 0.5, 0))
        local alpha = math.clamp(dt * 8 * assist.speed / math.max(assist.smooth, 0.05), 0, 1)
        cam.CFrame = cam.CFrame:Lerp(want, alpha)
    end)
end

LocalPlayer.CharacterAdded:Connect(function(c)
    task.wait(0.5)
    if hatEnabled then applyHat(c) end
    if flyEnabled then startFly() end
    if noclipUser and not flyEnabled then toggleNoclip(true) end
    if cm.on then applyCustomModel() end
end)

--------------------------------------------------
-- v10: NameProtect+, GunModel, KillFeed, JumpCircle
--------------------------------------------------
;(function() -- своя функция = свой лимит 200 локальных переменных
local CoreGui = nil
pcall(function() CoreGui = game:GetService("CoreGui") end)

----------------------------------------------------------------
-- NAMEPROTECT+: прячет ник в Tab-списке, Esc-меню, чате, GUI игры
----------------------------------------------------------------
local npOrig = setmetatable({}, {__mode = "k"})
local npSet = setmetatable({}, {__mode = "k"})
local function esc(s) return (tostring(s):gsub("%p", "%%%0")) end
local function npFix(o)
    if not (o:IsA("TextLabel") or o:IsA("TextButton")) then return end
    local sg = o:FindFirstAncestorWhichIsA("ScreenGui")
    if sg and sg.Name:sub(1, 8) == "Maneware" then return end
    local t = o.Text
    if t == "" or npSet[o] == t then return end
    local n1, n2 = LocalPlayer.Name, LocalPlayer.DisplayName
    if not (t:find(n1, 1, true) or t:find(n2, 1, true)) then return end
    local r = (np.text ~= "" and np.text) or "Hidden"
    local out = t:gsub(esc(n1), function() return r end)
    out = out:gsub(esc(n2), function() return r end)
    if out ~= t then
        npOrig[o] = t
        npSet[o] = out
        o.Text = out
    end
end
local function npRestore()
    for o, orig in pairs(npOrig) do
        pcall(function() if o.Parent and o.Text == npSet[o] then o.Text = orig end end)
    end
    npOrig = setmetatable({}, {__mode = "k"})
    npSet = setmetatable({}, {__mode = "k"})
end
local function npScan()
    for _, root in ipairs({CoreGui or LocalPlayer, LocalPlayer:FindFirstChild("PlayerGui") or LocalPlayer}) do
        for _, o in ipairs(root:GetDescendants()) do pcall(npFix, o) end
    end
end
local function npHum()
    local h = myHum()
    if not h then return end
    if np.on then
        if not h:GetAttribute("MWDN") then h:SetAttribute("MWDN", h.DisplayName) end
        h.DisplayName = (np.text ~= "" and np.text) or "Hidden"
    else
        local o = h:GetAttribute("MWDN")
        if o then h.DisplayName = o h:SetAttribute("MWDN", nil) end
    end
end
X.npRefresh = function()
    npRestore()
    if np.on then pcall(npScan) end
    pcall(npHum)
end
if CoreGui then
    CoreGui.DescendantAdded:Connect(function(o)
        if np.on then task.delay(0.05, function() pcall(npFix, o) end) end
    end)
end
task.spawn(function()
    while true do
        task.wait(1)
        if np.on then pcall(npScan) pcall(npHum) end
    end
end)
LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    if np.on then pcall(npHum) end
end)

----------------------------------------------------------------
-- GUNMODEL: 6 разных моделей (AWP x3, Deagle x3), ищутся, не создаются
----------------------------------------------------------------
local gm = {on = false, sel = 1, size = 1, rot = 0, busy = false, fail = 0, cur = nil}
local GM_SLOTS = {
    {key = "gm_awp1", label = "AWP", q = "awp gun"},
    {key = "gm_awp2", label = "AWP #2", q = "awp sniper rifle"},
    {key = "gm_awp3", label = "AWP #3", q = "awp asiimov"},
    {key = "gm_deagle1", label = "Deagle", q = "deagle gun"},
    {key = "gm_deagle2", label = "Deagle #2", q = "desert eagle"},
    {key = "gm_deagle3", label = "Deagle #3", q = "deagle csgo"},
}
local gmHidden = {}
local function gmClearAll()
    gm.cur = nil
    local conts = {}
    if myChar() then table.insert(conts, myChar()) end
    local bp = LocalPlayer:FindFirstChild("Backpack")
    if bp then table.insert(conts, bp) end
    for _, cont in ipairs(conts) do
        for _, t in ipairs(cont:GetChildren()) do
            local o = t:FindFirstChild("MWGunModel")
            if o then o:Destroy() end
        end
    end
    for inst, tr in pairs(gmHidden) do pcall(function() inst.Transparency = tr end) end
    gmHidden = {}
end
local function gmApply(gun, key)
    gm.busy = true
    task.spawn(function()
        local ok = pcall(function()
            local slot = GM_SLOTS[gm.sel]
            local id = resolveModelSlot(slot)
            local tpl = id and fetchModel(id)
            if not tpl then
                gm.fail = os.clock()
                notify("GunModel: " .. slot.label .. " не найден (введи ID вручную)")
                return
            end
            local handle = gun:FindFirstChild("Handle") or gun:FindFirstChildWhichIsA("BasePart")
            if not handle or not gun.Parent or not gm.on then return end
            local m = tpl:Clone()
            m.Name = "MWGunModel"
            local kill = {}
            for _, d in ipairs(m:GetDescendants()) do
                if d:IsA("BaseScript") or d:IsA("Humanoid") then table.insert(kill, d) end
            end
            for _, d in ipairs(kill) do pcall(function() d:Destroy() end) end
            pcall(function() m:ScaleTo(gm.size) end)
            local parts = {}
            for _, d in ipairs(m:GetDescendants()) do
                if d:IsA("BasePart") then
                    d.Anchored = false d.CanCollide = false d.CanTouch = false
                    d.CanQuery = false d.Massless = true
                    table.insert(parts, d)
                end
            end
            local primary = m.PrimaryPart or parts[1]
            if not primary then return end
            m.Parent = gun
            m:PivotTo(handle.CFrame * CFrame.Angles(0, math.rad(gm.rot), 0))
            for _, pt in ipairs(parts) do
                if pt ~= primary then
                    local w = Instance.new("WeldConstraint")
                    w.Part0, w.Part1 = primary, pt
                    w.Parent = primary
                end
            end
            local w0 = Instance.new("WeldConstraint")
            w0.Part0, w0.Part1 = handle, primary
            w0.Parent = primary
            for _, d in ipairs(gun:GetDescendants()) do
                if not d:IsDescendantOf(m) and (d:IsA("BasePart") or d:IsA("Decal") or d:IsA("Texture")) then
                    gmHidden[d] = d.Transparency
                    d.Transparency = 1
                end
            end
            gm.cur = key
            notify("GunModel: " .. slot.label .. " ✔")
        end)
        if not ok then gm.fail = os.clock() end
        gm.busy = false
    end)
end
task.spawn(function()
    while true do
        task.wait(0.5)
        if gm.on and not gm.busy then
            pcall(function()
                local c = myChar()
                local gun = c and c:FindFirstChild("Gun")
                if not gun then return end
                local key = gm.sel .. "|" .. gm.size .. "|" .. gm.rot
                if gun:FindFirstChild("MWGunModel") and gm.cur == key then return end
                if os.clock() - gm.fail < 6 then return end
                gmClearAll()
                gmApply(gun, key)
            end)
        end
    end
end)

----------------------------------------------------------------
-- KILLFEED
----------------------------------------------------------------
local kf = {on = false, hideInn = true, hideMur = true, hideShe = true}
X.kf = kf
local kfGui = makeGui("ManewareKF", 99994)
local kfRoot = new("Frame", {Name = "KF", Size = UDim2.new(0, 270, 0, 190), Position = UDim2.new(0, 12, 0.3, 0),
    BackgroundTransparency = 1, Active = false}, kfGui)
X.kfRoot = kfRoot
local kfList = new("Frame", {Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1}, kfRoot)
new("UIListLayout", {Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder,
    VerticalAlignment = Enum.VerticalAlignment.Bottom}, kfList)
local KFC = {Murderer = Color3.fromRGB(255, 70, 70), Sheriff = Color3.fromRGB(70, 150, 255),
    Innocent = Color3.fromRGB(70, 220, 120)}
local function hex(c)
    return string.format("#%02X%02X%02X", math.floor(c.R * 255 + 0.5), math.floor(c.G * 255 + 0.5), math.floor(c.B * 255 + 0.5))
end
local function rt(s) return (tostring(s):gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;")) end
local function nmOf(pl) if pl == LocalPlayer then return displayName() end return pl.DisplayName end
local kfOrder, kfCards = 0, {}
local function kfPush(kName, kRole, vName, vRole)
    kfOrder = kfOrder + 1
    local card = new("Frame", {Size = UDim2.new(1, 0, 0, 30), BackgroundColor3 = Color3.fromRGB(12, 12, 16),
        BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = kfOrder}, kfList)
    corner(8, card)
    local st = new("UIStroke", {Color = KFC[vRole], Thickness = 1.5, Transparency = 1}, card)
    local tl = new("TextLabel", {Size = UDim2.new(1, -14, 1, 0), Position = UDim2.new(0, 7, 0, 0),
        BackgroundTransparency = 1, RichText = true, TextSize = 14, Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
        TextColor3 = Color3.new(1, 1, 1), TextTransparency = 1,
        Text = string.format('<font color="%s">%s</font>  ➜  <font color="%s">%s</font>',
            hex(KFC[kRole]), rt(kName), hex(KFC[vRole]), rt(vName))}, card)
    table.insert(kfCards, card)
    while #kfCards > 6 do
        local o = table.remove(kfCards, 1)
        if o.Parent then o:Destroy() end
    end
    local tin = TweenInfo.new(0.15)
    TweenService:Create(card, tin, {BackgroundTransparency = 0.15}):Play()
    TweenService:Create(st, tin, {Transparency = 0.2}):Play()
    TweenService:Create(tl, tin, {TextTransparency = 0}):Play()
    task.delay(1.6, function() -- всего живёт 2 секунды
        if not card.Parent then return end
        local to = TweenInfo.new(0.4)
        TweenService:Create(card, to, {BackgroundTransparency = 1}):Play()
        TweenService:Create(st, to, {Transparency = 1}):Play()
        TweenService:Create(tl, to, {TextTransparency = 1}):Play()
        task.wait(0.45)
        card:Destroy()
    end)
end
local kfRole = {}
task.spawn(function()
    while true do
        task.wait(0.2)
        for _, pl in ipairs(Players:GetPlayers()) do
            local h = pl.Character and pl.Character:FindFirstChildOfClass("Humanoid")
            if h and h.Health > 0 then kfRole[pl] = getRole(pl) end
        end
    end
end)
Players.PlayerRemoving:Connect(function(pl) kfRole[pl] = nil end)
local function kfHook(pl)
    local function onChar(ch)
        local hum = ch:WaitForChild("Humanoid", 5)
        if not hum then return end
        hum.Died:Connect(function()
            if not kf.on then return end
            local vr = kfRole[pl]
            if not vr then return end
            local want = (vr == "Murderer") and "Sheriff" or "Murderer"
            local killer
            for p, r in pairs(kfRole) do
                if p ~= pl and r == want and p.Parent then killer = p break end
            end
            if not killer then return end
            if vr == "Innocent" and not kf.hideInn then return end
            if vr == "Murderer" and not kf.hideMur then return end
            if vr == "Sheriff" and not kf.hideShe then return end
            kfPush(nmOf(killer), want, nmOf(pl), vr)
        end)
    end
    if pl.Character then task.spawn(onChar, pl.Character) end
    pl.CharacterAdded:Connect(onChar)
end
for _, pl in ipairs(Players:GetPlayers()) do kfHook(pl) end
Players.PlayerAdded:Connect(kfHook)

----------------------------------------------------------------
-- JUMPCIRCLE: незамкнутое кольцо на месте прыжка, живёт 4 секунды
----------------------------------------------------------------
local jc = {on = false, size = 3}
local jcRings = {}
local function groundPos()
    local c, hrp = myChar(), myHrp()
    if not c or not hrp then return nil end
    local rp = RaycastParams.new()
    rp.FilterType = Enum.RaycastFilterType.Exclude
    rp.FilterDescendantsInstances = {c}
    local r = workspace:Raycast(hrp.Position, Vector3.new(0, -8, 0), rp)
    return r and (r.Position + Vector3.new(0, 0.08, 0)) or (hrp.Position - Vector3.new(0, 2.9, 0))
end
local function spawnRing(pos)
    if not pos then return end
    while #jcRings >= 6 do
        local o = table.remove(jcRings, 1)
        if o.Parent then o:Destroy() end
    end
    local folder = new("Folder", {Name = "MWJump"}, workspace)
    table.insert(jcRings, folder)
    local N, arc = 28, math.rad(260)
    local seg = {}
    for i = 1, N do
        seg[i] = new("Part", {Anchored = true, CanCollide = false, CanTouch = false, CanQuery = false,
            CastShadow = false, Material = Enum.Material.Neon, Color = C.ACCENT,
            Size = Vector3.new(0.25, 0.08, 0.5)}, folder)
    end
    local t0, start = os.clock(), math.random() * math.pi * 2
    local conn
    conn = RunService.Heartbeat:Connect(function()
        local a = (os.clock() - t0) / 4
        if a >= 1 or not folder.Parent then
            conn:Disconnect()
            folder:Destroy()
            return
        end
        local radius = jc.size * (0.6 + 0.4 * math.min(a * 4, 1))
        local rot = start + a * math.pi
        local segLen = (arc * radius / N) * 1.15
        local tr = 0.15 + 0.85 * a * a
        for i, p in ipairs(seg) do
            local ang = rot + (i - 1) / (N - 1) * arc
            p.Size = Vector3.new(0.25, 0.08, segLen)
            p.CFrame = CFrame.new(pos + Vector3.new(math.cos(ang) * radius, 0, math.sin(ang) * radius))
                * CFrame.Angles(0, -ang, 0)
            p.Transparency = tr
        end
    end)
end
local function jcHook(ch)
    local hum = ch:WaitForChild("Humanoid", 5)
    if not hum then return end
    hum.StateChanged:Connect(function(_, st)
        if st == Enum.HumanoidStateType.Jumping and jc.on then pcall(function() spawnRing(groundPos()) end) end
    end)
end
if LocalPlayer.Character then task.spawn(jcHook, LocalPlayer.Character) end
LocalPlayer.CharacterAdded:Connect(jcHook)

----------------------------------------------------------------
-- UI новых вкладок (вызывается из buildUI)
----------------------------------------------------------------
X.buildNew = function()
    local tg = addTab("GunModel", ICONS.GUN)
    tg.Section("🔫 Модель пистолета (ищется в Creator Store)")
    local labs = {}
    for i, s in ipairs(GM_SLOTS) do labs[i] = s.label end
    tg.ToggleDrop("GunModel", false, function(v)
        gm.on = v
        if not v then pcall(gmClearAll) end
    end, ICONS.GUN, labs, 1, function(i) gm.sel = i gm.fail = 0 end)
    tg.Slider("GunModel: Size", 0.2, 3, 1, "x", function(v) gm.size = v end, 0.1)
    tg.Slider("GunModel: Rotate", 0, 360, 0, "°", function(v) gm.rot = v end, 90)
    local box = tg.TextBox("ID модели вручную (если поиск не нашёл)")
    tg.Button("✔ Применить ID к выбранной модели", function()
        local id = tonumber(box.Text)
        if not id then notify("Введи числовой ID") return end
        if not fetchModel(id) then notify("Модель не загрузилась") return end
        assetCache["model:" .. GM_SLOTS[gm.sel].key] = id
        saveAssets()
        gm.fail = 0
        gm.cur = nil
        notify("ID сохранён: " .. id)
    end)
    local tj = addTab("JumpCircle", ICONS.FLY)
    tj.Section("⭕ JumpCircle")
    tj.Toggle("JumpCircle", false, function(v) jc.on = v end, ICONS.FLY)
    tj.Slider("JumpCircle: Size", 1, 8, 3, " st", function(v) jc.size = v end, 0.5)

    ----------------------------------------------------------------
    -- KNIFEMODEL: butterfly / karambit / nether (только поиск, на нож)
    ----------------------------------------------------------------
    local km = {on = false, sel = 1, size = 1, rx = 0, ry = 0, rz = 0, busy = false, fail = 0, cur = nil}
    local KM_SLOTS = {
        {key = "km_bf1", label = "Butterfly", q = "csgo butterfly knife"},
        {key = "km_bf2", label = "Butterfly #2", q = "butterfly knife csgo"},
        {key = "km_bf3", label = "Butterfly #3", q = "butterfly knife morph"},
        {key = "km_kar1", label = "Karambit", q = "csgo karambit"},
        {key = "km_kar2", label = "Karambit #2", q = "karambit knife"},
        {key = "km_kar3", label = "Karambit #3", q = "karambit morph"},
        {key = "km_neth1", label = "Nether", q = "netherite sword minecraft"},
        {key = "km_neth2", label = "Nether #2", q = "minecraft netherite sword"},
        {key = "km_neth3", label = "Nether #3", q = "netherite sword"},
    }
    local kmHidden = {}
    local function kmClearAll()
        km.cur = nil
        local conts = {}
        if myChar() then table.insert(conts, myChar()) end
        local bp = LocalPlayer:FindFirstChild("Backpack")
        if bp then table.insert(conts, bp) end
        for _, cont in ipairs(conts) do
            for _, tool in ipairs(cont:GetChildren()) do
                local o = tool:FindFirstChild("MWKnifeModel")
                if o then o:Destroy() end
            end
        end
        for inst, tr in pairs(kmHidden) do pcall(function() inst.Transparency = tr end) end
        kmHidden = {}
    end
    local function kmApply(knife, key)
        km.busy = true
        task.spawn(function()
            local ok = pcall(function()
                local slot = KM_SLOTS[km.sel]
                local id = resolveModelSlot(slot)
                local tpl = id and fetchModel(id)
                if not tpl then
                    km.fail = os.clock()
                    notify("KnifeModel: " .. slot.label .. " не найден (ID вручную)")
                    return
                end
                local handle = knife:FindFirstChild("Handle") or knife:FindFirstChildWhichIsA("BasePart")
                if not handle or not knife.Parent or not km.on then return end
                local m = tpl:Clone()
                m.Name = "MWKnifeModel"
                local kill = {}
                for _, d in ipairs(m:GetDescendants()) do
                    if d:IsA("BaseScript") or d:IsA("Humanoid") then table.insert(kill, d) end
                end
                for _, d in ipairs(kill) do pcall(function() d:Destroy() end) end
                pcall(function() m:ScaleTo(km.size) end)
                local parts = {}
                for _, d in ipairs(m:GetDescendants()) do
                    if d:IsA("BasePart") then
                        d.Anchored = false d.CanCollide = false d.CanTouch = false
                        d.CanQuery = false d.Massless = true
                        table.insert(parts, d)
                    end
                end
                local primary = m.PrimaryPart or parts[1]
                if not primary then return end
                m.Parent = knife
                m:PivotTo(handle.CFrame * CFrame.Angles(math.rad(km.rx), math.rad(km.ry), math.rad(km.rz)))
                for _, pt in ipairs(parts) do
                    if pt ~= primary then
                        local w = Instance.new("WeldConstraint")
                        w.Part0, w.Part1 = primary, pt
                        w.Parent = primary
                    end
                end
                local w0 = Instance.new("WeldConstraint")
                w0.Part0, w0.Part1 = handle, primary
                w0.Parent = primary
                for _, d in ipairs(knife:GetDescendants()) do
                    if not d:IsDescendantOf(m) and (d:IsA("BasePart") or d:IsA("Decal") or d:IsA("Texture")) then
                        kmHidden[d] = d.Transparency
                        d.Transparency = 1
                    end
                end
                km.cur = key
                notify("KnifeModel: " .. slot.label .. " ✔")
            end)
            if not ok then km.fail = os.clock() end
            km.busy = false
        end)
    end
    task.spawn(function()
        while true do
            task.wait(0.45)
            if not km.on then
                if km.cur then pcall(kmClearAll) end
            elseif not km.busy then
                pcall(function()
                    local c = myChar()
                    local knife = c and (c:FindFirstChild("Knife") or c:FindFirstChild("Classic Knife"))
                    if not knife then
                        -- ножа нет в руках — модель не видна
                        if km.cur then
                            for _, cont in ipairs({c, LocalPlayer:FindFirstChild("Backpack")}) do
                                if cont then
                                    for _, tool in ipairs(cont:GetChildren()) do
                                        local o = tool:FindFirstChild("MWKnifeModel")
                                        if o then o:Destroy() end
                                    end
                                end
                            end
                            km.cur = nil
                        end
                        return
                    end
                    local key = km.sel .. "|" .. km.size .. "|" .. km.rx .. "|" .. km.ry .. "|" .. km.rz
                    if knife:FindFirstChild("MWKnifeModel") and km.cur == key then return end
                    if os.clock() - km.fail < 6 then return end
                    kmClearAll()
                    kmApply(knife, key)
                end)
            end
        end
    end)

    local tk = addTab("KnifeModel", ICONS.AIM)
    tk.Section("🔪 Модель ножа (поиск, не создание)")
    local kLabs = {}
    for i, s in ipairs(KM_SLOTS) do kLabs[i] = s.label end
    tk.ToggleDrop("KnifeModel", false, function(v)
        km.on = v
        if not v then pcall(kmClearAll) end
    end, ICONS.AIM, kLabs, 1, function(i) km.sel = i km.fail = 0 end)
    tk.Slider("KnifeModel: Size", 0.10, 10, 1, "x", function(v) km.size = v end, 0.05)
    tk.Slider("KnifeModel: Rotate X", 0, 360, 0, "°", function(v) km.rx = v end, 5)
    tk.Slider("KnifeModel: Rotate Y", 0, 360, 0, "°", function(v) km.ry = v end, 5)
    tk.Slider("KnifeModel: Rotate Z", 0, 360, 0, "°", function(v) km.rz = v end, 5)
    local kBox = tk.TextBox("ID модели ножа вручную")
    tk.Button("✔ Применить ID к KnifeModel", function()
        local id = tonumber(kBox.Text)
        if not id then notify("Введи числовой ID") return end
        if not fetchModel(id) then notify("Модель не загрузилась") return end
        assetCache["model:" .. KM_SLOTS[km.sel].key] = id
        saveAssets()
        km.fail = 0
        km.cur = nil
        notify("KnifeModel ID: " .. id)
    end)

    ----------------------------------------------------------------
    -- RELAY: канал между клиентами Maneware (публичный pub/sub ntfy.sh).
    -- Атрибуты/объекты, созданные клиентом, другие игроки не видят,
    -- поэтому раньше чат и UserNash у других пользователей не работали.
    -- Сообщения идут через ntfy.sh (тема = сервер игры), задержка ~5 сек.
    ----------------------------------------------------------------
    local relay = {enabled = true, users = {}, lastId = nil, ok = nil, seen = {}, startT = os.time(), onChat = nil,
        topic = "maneware-mm2-" .. tostring((game.JobId ~= "" and game.JobId) or game.PlaceId)}
    relay.users[LocalPlayer.UserId] = true
    local function httpReq(opts)
        local rq = request or http_request or (syn and syn.request) or (http and http.request)
        if not rq then return nil end
        local ok, res = pcall(rq, opts)
        if ok and type(res) == "table" then return res end
        return nil
    end
    local function relaySend(tbl)
        tbl.u = LocalPlayer.UserId
        local res = httpReq({Url = "https://ntfy.sh/" .. relay.topic, Method = "POST",
            Headers = {["Content-Type"] = "text/plain"}, Body = HttpService:JSONEncode(tbl)})
        return res ~= nil and (res.StatusCode == 200 or res.Success == true)
    end
    local function relayHandle(d, t)
        if type(d) ~= "table" or type(d.u) ~= "number" then return end
        if d.t == "hello" then
            if Players:GetPlayerByUserId(d.u) then relay.users[d.u] = true end
        elseif d.t == "bye" then
            if d.u ~= LocalPlayer.UserId then relay.users[d.u] = nil end
        elseif d.t == "chat" then
            if d.u ~= LocalPlayer.UserId and (tonumber(t) or 0) >= relay.startT - 2
                and type(d.m) == "string" and relay.onChat then
                relay.onChat(tostring(d.n or "?"):sub(1, 32), d.m:sub(1, 200))
            end
        end
    end
    local function relayPoll()
        local url = "https://ntfy.sh/" .. relay.topic .. "/json?poll=1&since=" .. (relay.lastId or "12h")
        local res = httpReq({Url = url, Method = "GET"})
        if not res then relay.ok = false return 15 end
        if res.StatusCode == 429 then relay.ok = false return 25 end
        if res.StatusCode ~= 200 then relay.ok = false return 15 end
        relay.ok = true
        for line in tostring(res.Body or ""):gmatch("[^\n]+") do
            local ok, m = pcall(function() return HttpService:JSONDecode(line) end)
            if ok and type(m) == "table" and m.event == "message" and m.id and not relay.seen[m.id] then
                relay.seen[m.id] = true
                relay.lastId = m.id
                local ok2, d = pcall(function() return HttpService:JSONDecode(m.message) end)
                if ok2 then pcall(relayHandle, d, m.time) end
            end
        end
        return 5
    end
    task.spawn(function()
        task.wait(2)
        local helloSent = false
        while true do
            if relay.enabled then
                if not helloSent then helloSent = relaySend({t = "hello", n = LocalPlayer.DisplayName}) end
                local ok, waitT = pcall(relayPoll)
                task.wait((ok and tonumber(waitT)) or 10)
            else
                helloSent = false
                task.wait(2)
            end
        end
    end)
    Players.PlayerRemoving:Connect(function(pl) relay.users[pl.UserId] = nil end)
    local function relaySetEnabled(v)
        relay.enabled = v and true or false
        if not v then task.spawn(relaySend, {t = "bye"}) end
    end

    ----------------------------------------------------------------
    -- USERNASH: лого над головой игроков Maneware
    ----------------------------------------------------------------
    local un = {on = false}
    local unTags = {}
    local function unClear(pl)
        local t = unTags[pl]
        if t then pcall(function() t:Destroy() end) unTags[pl] = nil end
    end
    local function unApply(pl)
        if not un.on or not pl then return end
        local ch = pl.Character
        local head = ch and ch:FindFirstChild("Head")
        if not head then return end
        if unTags[pl] and unTags[pl].Parent then return end
        unClear(pl)
        local bb = new("BillboardGui", {Name = "MWUserNash", Size = UDim2.new(0, 48, 0, 48),
            StudsOffset = Vector3.new(0, 3.2, 0), AlwaysOnTop = true, MaxDistance = 120}, head)
        local img = new("ImageLabel", {Size = UDim2.new(1, 0, 1, 0), BackgroundColor3 = Color3.fromRGB(30, 20, 55),
            BackgroundTransparency = 0.25, Image = LOGO_ID, ScaleType = Enum.ScaleType.Fit, BorderSizePixel = 0}, bb)
        corner(10, img)
        new("UIStroke", {Color = C.ACCENT, Thickness = 1.5}, img)
        unTags[pl] = bb
    end
    -- Помечаем себя как Maneware-юзера
    pcall(function() LocalPlayer:SetAttribute("ManewareUser", true) end)
    task.spawn(function()
        while true do
            task.wait(1)
            pcall(function()
                if not un.on then
                    for pl in pairs(unTags) do unClear(pl) end
                    return
                end
                for _, pl in ipairs(Players:GetPlayers()) do
                    -- свой + те, у кого атрибут ManewareUser (если реплицируется) или DisplayName с меткой
                    local isMw = (pl == LocalPlayer) or (relay.users[pl.UserId] == true)
                    if isMw then unApply(pl) else unClear(pl) end
                end
            end)
        end
    end)
    Players.PlayerRemoving:Connect(function(pl) unClear(pl) end)

    local tu = addTab("UserNash", ICONS.HAT)
    tu.Section("🏷 UserNash — лого над головой Maneware")
    tu.Toggle("UserNash", false, function(v) un.on = v if not v then for pl in pairs(unTags) do unClear(pl) end end end, ICONS.HAT)
    tu.Section("📡 Relay (чат + UserNash между пользователями Maneware)")
    tu.Toggle("Maneware Relay (видимость + чат)", true, function(v) relaySetEnabled(v) end, ICONS.UTIL)

    ----------------------------------------------------------------
    -- CHATMANEWARE: локальный чат для юзеров Maneware
    ----------------------------------------------------------------
    local chat = {on = false}
    local chatGui = makeGui("ManewareChat", 99993)
    local chatBtn = new("TextButton", {Size = UDim2.new(0, 52, 0, 52), Position = UDim2.new(0, 12, 1, -120),
        BackgroundColor3 = C.ACCENT, Text = "MW", TextColor3 = C.TEXT, TextSize = 16,
        Font = Enum.Font.GothamBold, BorderSizePixel = 0, AutoButtonColor = true}, chatGui)
    corner(14, chatBtn)
    new("UIStroke", {Color = Color3.new(1, 1, 1), Thickness = 1.5}, chatBtn)
    chatBtn.Visible = false -- пока открыто меню, кнопка чата скрыта (иначе перекрывает сайдбар)
    X.chatBtnShow = function(v)
        chatBtn.Visible = v and true or false
    end

    local chatFrame = new("Frame", {Size = UDim2.new(0, 280, 0, 220), Position = UDim2.new(0, 12, 1, -350),
        BackgroundColor3 = Color3.fromRGB(14, 14, 20), BorderSizePixel = 0, Visible = false, Active = true}, chatGui)
    corner(12, chatFrame)
    new("UIStroke", {Color = C.ACCENT, Thickness = 2}, chatFrame)
    local chatTitle = new("TextLabel", {Size = UDim2.new(1, -70, 0, 28), Position = UDim2.new(0, 10, 0, 4),
        BackgroundTransparency = 1, Text = "Maneware Chat", TextColor3 = C.ACCENT, TextSize = 14,
        Font = Enum.Font.GothamBold, TextXAlignment = Enum.TextXAlignment.Left}, chatFrame)
    local chatClose = new("TextButton", {Size = UDim2.new(0, 28, 0, 28), Position = UDim2.new(1, -34, 0, 4),
        BackgroundColor3 = C.RED, Text = "✕", TextColor3 = C.TEXT, TextSize = 14, Font = Enum.Font.GothamBold,
        BorderSizePixel = 0}, chatFrame)
    corner(8, chatClose)
    -- resize handle
    local resize = new("TextButton", {Size = UDim2.new(0, 22, 0, 22), Position = UDim2.new(1, -22, 1, -22),
        BackgroundColor3 = C.BORDER, Text = "↘", TextColor3 = C.DIM, TextSize = 12, BorderSizePixel = 0,
        AutoButtonColor = false}, chatFrame)
    corner(6, resize)

    local msgScroll = new("ScrollingFrame", {Size = UDim2.new(1, -12, 1, -70), Position = UDim2.new(0, 6, 0, 34),
        BackgroundColor3 = Color3.fromRGB(20, 20, 28), BorderSizePixel = 0, ScrollBarThickness = 4,
        CanvasSize = UDim2.new(0, 0, 0, 0), AutomaticCanvasSize = Enum.AutomaticSize.Y}, chatFrame)
    corner(8, msgScroll)
    local msgList = new("UIListLayout", {Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder}, msgScroll)
    new("UIPadding", {PaddingTop = UDim.new(0, 4), PaddingBottom = UDim.new(0, 4),
        PaddingLeft = UDim.new(0, 6), PaddingRight = UDim.new(0, 6)}, msgScroll)

    local inputBox = new("TextBox", {Size = UDim2.new(1, -70, 0, 32), Position = UDim2.new(0, 6, 1, -38),
        BackgroundColor3 = C.ELEMENT, Text = "", PlaceholderText = "Сообщение…", PlaceholderColor3 = C.DIM,
        TextColor3 = C.TEXT, TextSize = 13, Font = Enum.Font.GothamSemibold, ClearTextOnFocus = false,
        BorderSizePixel = 0}, chatFrame)
    corner(8, inputBox)
    local sendBtn = new("TextButton", {Size = UDim2.new(0, 54, 0, 32), Position = UDim2.new(1, -60, 1, -38),
        BackgroundColor3 = C.ACCENT, Text = "➤", TextColor3 = C.TEXT, TextSize = 16,
        Font = Enum.Font.GothamBold, BorderSizePixel = 0}, chatFrame)
    corner(8, sendBtn)

    local msgOrder = 0
    local function chatAdd(nick, text)
        msgOrder = msgOrder + 1
        local row = new("TextLabel", {Size = UDim2.new(1, -8, 0, 0), AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1, RichText = true, TextWrapped = true, TextSize = 13,
            Font = Enum.Font.GothamSemibold, TextXAlignment = Enum.TextXAlignment.Left,
            TextColor3 = C.TEXT, LayoutOrder = msgOrder,
            Text = string.format('<font color="#a5b4fc">"%s"</font> %s',
                (tostring(nick):gsub("<", "&lt;")), (tostring(text):gsub("<", "&lt;")))}, msgScroll)
        task.defer(function()
            msgScroll.CanvasPosition = Vector2.new(0, msgScroll.AbsoluteCanvasSize.Y)
        end)
    end

    local function chatSend()
        local text = tostring(inputBox.Text or ""):gsub("^%s+", ""):gsub("%s+$", "")
        if text == "" then return end
        text = text:sub(1, 200)
        inputBox.Text = ""
        local nick = displayName()
        chatAdd(nick, text)
        if not relay.enabled then chatAdd("System", "Relay выключен (вкладка UserNash)") return end
        task.spawn(function()
            if not relaySend({t = "chat", n = nick, m = text}) then
                chatAdd("System", "Не отправилось: нет связи с relay")
            end
        end)
    end
    onTap(sendBtn, chatSend)
    inputBox.FocusLost:Connect(function(enter) if enter then chatSend() end end)

    onTap(chatBtn, function()
        chatFrame.Visible = not chatFrame.Visible
    end)
    onTap(chatClose, function() chatFrame.Visible = false end)
    do -- при открытии меню окно чата тоже прячем (оно перекрывало бы сайдбар)
        local oldShow = X.chatBtnShow
        X.chatBtnShow = function(v)
            oldShow(v)
            if not v then chatFrame.Visible = false end
        end
    end

    -- drag chat window
    do
        local drag, sPos, sU = false, nil, nil
        chatTitle.InputBegan:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
                drag, sPos, sU = true, i.Position, chatFrame.Position
            end
        end)
        UIS.InputChanged:Connect(function(i)
            if drag and (i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseMovement) then
                local d = i.Position - sPos
                chatFrame.Position = UDim2.new(sU.X.Scale, sU.X.Offset + d.X, sU.Y.Scale, sU.Y.Offset + d.Y)
            end
        end)
        UIS.InputEnded:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then drag = false end
        end)
    end
    -- resize
    do
        local rs, start, startSize = false, nil, nil
        resize.InputBegan:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
                rs, start, startSize = true, i.Position, chatFrame.AbsoluteSize
            end
        end)
        UIS.InputChanged:Connect(function(i)
            if rs and (i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseMovement) then
                local d = i.Position - start
                local w = math.clamp(startSize.X + d.X, 200, 500)
                local h = math.clamp(startSize.Y + d.Y, 160, 450)
                chatFrame.Size = UDim2.new(0, w, 0, h)
            end
        end)
        UIS.InputEnded:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then rs = false end
        end)
    end

    -- Приём сообщений: relay вызывает onChat для сообщений других пользователей Maneware
    relay.onChat = function(nick, text) chatAdd(nick, text) end
    task.spawn(function() -- индикатор связи в заголовке чата
        while true do
            task.wait(2)
            chatTitle.Text = "Maneware Chat " .. (relay.ok == true and "●" or (relay.ok == false and "○ нет связи" or "…"))
        end
    end)

    chatAdd("System", "Чат Maneware готов. Видят только пользователи Maneware на этом сервере (задержка ~5 сек).")
end
end)() -- v10/v11 блок

local function buildUI()
--------------------------------------------------
-- ВКЛАДКИ
--------------------------------------------------
local t1 = addTab("Основное", ICONS.HOME)
local t2 = addTab("Визуалы", ICONS.EYE)
local t3 = addTab("Шериф", ICONS.AIM)
local t4 = addTab("Телепорт", ICONS.TP)
local t5 = addTab("Утилиты", ICONS.UTIL)

-- Основное
t1.Section("⚡ Движение")
t1.Toggle("SpeedHack", false, function(v)
    speedEnabled = v
    local h = myHum()
    if h and not v then h.WalkSpeed = 16 end
end, ICONS.SPEED)
t1.Slider("Скорость", 16, 300, 16, " sp", function(v) speedValue = v end)
t1.Toggle("NoClip", false, function(v) noclipUser = v if not flyEnabled then toggleNoclip(v) end end, ICONS.NOCLIP)
t1.Toggle("Fly (джойстик + ▲▼)", false, function(v)
    flyEnabled = v
    flyGui.Enabled = v
    if v then startFly() else stopFly() end
end, ICONS.FLY)
t1.Slider("Скорость полёта", 10, 150, 50, " st/s", function(v) flySpeed = v end)
t1.Toggle("Infinite Jump", false, function(v) infJump = v end, ICONS.FLY)
t1.Toggle("Spinbot", false, function(v) spinbot.on = v end, ICONS.TARGET)
t1.Slider("Spinbot: Speed", 1, 50, 20, "", function(v) spinbot.speed = v end)

-- Визуалы
t2.Section("🎨 ESP")
t2.Toggle("Подсветка ролей (ESP)", false, function(v)
    highlightEnabled = v
    for _, o in pairs(espObjects) do
        if o.H and o.H.Parent then o.H.Enabled = v end
        if o.B and o.B.Parent then o.B.Enabled = v end
    end
end, ICONS.EYE)
t2.Toggle("ESP пистолета (выпал)", false, function(v)
    gunEsp = v
    if not v then clearByName({MWGun = true, MWGunTag = true, MWGunBox = true, MWGunBox2D = true}) end
end, ICONS.GUN)
t2.Button("🔍 Где пистолет? (диагностика)", function()
    local g = findGunDrop()
    if g then notify("GunDrop: " .. g:GetFullName() .. " [" .. g.ClassName .. "]")
    else notify("GunDrop не найден (пистолет не выпал?)") end
end)
t2.Toggle("ESP монет", false, function(v)
    coinEsp = v
    if not v then clearByName({MWCoin = true}) end
end, ICONS.COIN)
t2.Toggle("Target ESP (Убийца)", false, function(v)
    targetEspEnabled = v
    if v then applyTarget() else removeTarget() end
end, ICONS.TARGET)
t2.Toggle("Target: Glow (свечение)", true, function(v) tgt.glow = v end, ICONS.TARGET)
t2.Slider("Target: Size", 0.10, 1, 0.5, "", function(v) tgt.size = v end, 0.05)
t2.Slider("Target: Speed", 0.50, 2, 1.00, "x", function(v) tgt.speed = v end, 0.05)
t2.Slider("Target: Glow Strength", 0.3, 2, 1, "x", function(v) tgt.glowStr = v end, 0.1)
t2.Toggle("Target: Рамка", true, function(v) tgt.reticle = v end, ICONS.TARGET)
t2.ToggleDrop("Target: Нимб (ноги → голова)", false, function(v) tgt.circle = v end, ICONS.TARGET,
    {"Свечение", "Тонкий нимб", "Заливка"}, 1, function(i) tgt.circleStyle = i end)
t2.Slider("Target: Размер нимба", 0.6, 1.6, 1, "x", function(v) tgt.circleSize = v end, 0.05)
t2.Toggle("China Hat", false, function(v)
    hatEnabled = v
    if v then applyHat(myChar()) else removeHat() end
end, ICONS.HAT)

-- Шериф
t3.Section("🎯 Sheriff Aim")
t3.Toggle("Sheriff Aim (авто-выстрел в убийцу)", false, function(v) aim.on = v end, ICONS.AIM)
t3.Toggle("Visible Check (вкл: только если виден / выкл: сквозь стены)", true, function(v) aim.visible = v end, ICONS.EYE)
t3.Toggle("Hacker (пуля сквозь стены)", false, function(v) aim.hacker = v end, ICONS.SHIELD)
t3.Toggle("Предсказание (куда прибежит) / выкл: прямо в него", true, function(v) aim.predict = v end, ICONS.TARGET)
t3.Slider("Предсказание (стады)", 0, 10, 3, " st", function(v) aim.studs = v end, 0.5)
t3.Slider("Сила предсказания % (если стады=0)", 0, 200, 100, "%", function(v) aim.strength = v end)
t3.Slider("Дальность", 50, 500, 250, " st", function(v) aim.range = v end)
t3.Slider("Задержка между выстрелами", 3, 30, 10, " ×0.1с", function(v) aim.cd = v / 10 end)

-- Телепорт
t4.Section("📍 Телепорты")
t4.Button("В лобби", tpLobby)
t4.Button("В игру (на карту)", tpMap)
t4.Button("К шерифу", function() tpRole("Sheriff") end)
t4.Button("К убийце", function() tpRole("Murderer") end)

-- Утилиты
t5.Section("🛠 Утилиты")
t5.Toggle("Anti-AFK", true, function(v) antiAfk = v end, ICONS.UTIL)
t5.Toggle("Anti-Fling", false, function(v) antiFling = v end, ICONS.SHIELD)
t5.Toggle("FPS Boost", false, fpsBoost, ICONS.SPEED)
t5.Section("👁 NameProtect")
t5.Toggle("NameProtect", false, function(v) np.on = v X.npRefresh() end, ICONS.EYE)
local npBox = t5.TextBox("Текст вместо ника (можно русский)")
npBox.Text = np.text
t5.Button("✔ Применить текст NameProtect", function()
    local t = tostring(npBox.Text or ""):gsub("^%s+", ""):gsub("%s+$", "")
    if t == "" then notify("Введи текст") return end
    np.text = t
    notify("NameProtect: " .. t)
    X.npRefresh()
    if wm.on then pcall(wmRebuild) end
end)

-- GrabGun во вкладке "Шериф"
t3.Section("🔫 Пистолет")
t3.Toggle("GrabGun (авто-подбор выпавшего пистолета)", false, function(v) grabGun = v end, ICONS.GUN)

-- Fling
local t6 = addTab("Fling", ICONS.FLING)
t6.Section("🌀 Fling (вернёт на прежнее место)")
t6.Button("Fling Murderer", function() flingRole("Murderer") end)
t6.Button("Fling Sheriff", function() flingRole("Sheriff") end)
t6.Section("⚙ Настройки флинга")
t6.Toggle("Fling: Bypass AntiFling", false, function(v) fl.bypass = v end, ICONS.SHIELD)
t6.Slider("Fling: попытки", 1, 5, 3, "", function(v) fl.tries = v end)
t6.Slider("Fling: общее время", 2, 10, 4, " сек", function(v) fl.time = v end)
t6.Toggle("Fling: камера на цель (точнее)", true, function(v) fl.spectate = v end, ICONS.EYE)
t6.Section("👥 Игроки на сервере")
local refreshList
t6.Button("🔄 Обновить список", function() if refreshList then refreshList() end end)
refreshList = t6.PlayerList("FLING", flingPlayer)

-- Автофарм
local t7 = addTab("Автофарм", ICONS.COIN)
t7.Section("💰 Autofarm монет")
t7.Toggle("Autofarm", false, function(v)
    farm.on = v
    if v then
        farm.sessionCoins = 0
        farm.startTime = os.clock()
        farm.done = false
    else
        farm.startTime = 0
        if farm.release then farm.release() end
        toggleNoclip(noclipUser or flyEnabled)
    end
end, ICONS.COIN)
t7.Slider("Скорость фарма", 16, 50, 30, " st/s", function(v) farm.speed = v end)
t7.Slider("Высота над монетой (0 = касаемся конфеты)", 0, 6, 0, " st", function(v) farm.height = v end)
t7.Slider("Лимит монет (мешок)", 10, 60, 40, "", function(v) farm.limit = v end)
t7.Toggle("Проверка на игру (ждать раунд)", true, function(v) farm.waitGame = v end, ICONS.UTIL)
t7.Toggle("Fling Murderer после лимита", false, function(v) farm.flingMurd = v end, ICONS.FLING)
t7.Toggle("Reset после лимита", false, function(v) farm.reset = v end, ICONS.UTIL)
t7.Toggle("Лететь сквозь стены (NoClip)", true, function(v) farm.walls = v end, ICONS.NOCLIP)
t7.Slider("Обходить монеты рядом с убийцей", 0, 40, 0, " st", function(v) farm.safe = v end)
t7.Button("Сбросить счётчик монет", function()
    farm.count = 0
    farm.done = false
    notify("Счётчик сброшен")
end)

-- Убийца
local t8 = addTab("Убийца", ICONS.AIM)
t8.Section("🔪 KillAura (только если ты убийца)")
t8.Toggle("KillAura (бьёт ножом)", false, function(v) ka.on = v end, ICONS.AIM)
t8.Slider("Дистанция KillAura", 1, 6, 4, " st", function(v) ka.dist = v end)
t8.Toggle("Kill All (убить всех)", false, function(v) killAllOn = v end, ICONS.TARGET)
t8.Section("🗡 Aura Throw (бросок ножа)")
t8.Toggle("Aura Throw (авто-бросок в ближнего)", false, function(v) thr.on = v end, ICONS.AIM)
t8.Slider("Дальность броска", 10, 200, 80, " st", function(v) thr.range = v end)
t8.Slider("Сила упреждения броска", 0, 200, 100, "%", function(v) thr.strength = v end)
t8.Slider("Задержка между бросками", 5, 30, 12, " ×0.1с", function(v) thr.cd = v / 10 end)
t8.Button("Бросить в ближнего", function()
    local pl = nearestPlayer(thr.range)
    if not pl then notify("Нет цели") return end
    if not throwAt(pl) then notify("Нож не найден / ты не убийца") end
end)
t8.Section("🎯 Бросить в выбранного")
t8.PlayerList("БРОСИТЬ", function(pl)
    if not throwAt(pl) then notify("Не удалось бросить") end
end)

-- KillEffect
local t10 = addTab("KillEffect", ICONS.TARGET)
t10.Section("💀 Эффекты при смерти убийцы / шерифа")
t10.Toggle("Ghost (призрак поднимается)", false, function(v) fx.ghost = v end, ICONS.EYE)
t10.Toggle("Molnia (молния в месте смерти)", false, function(v) fx.lightning = v end, ICONS.AIM)
t10.Toggle("Star (звёзды из тела)", false, function(v) fx.star = v end, ICONS.TARGET)
t10.Slider("Star: количество", 1, 10, 5, "", function(v) fx.starCount = v end)
t10.Slider("Star: скорость", 1, 5, 2, "", function(v) fx.starSpeed = v end)
t10.Section("⭐ Кастомные неоновые звёзды")
radioGroup(t10, "Star форма: ", fx.styleNames, 2, function(i) fx.starStyle = i end, ICONS.TARGET)
t10.Slider("Star: размер", 0.5, 3, 1, "x", function(v) fx.starSize = v end, 0.1)
t10.Slider("Star: цвет (оттенок)", 0, 360, 48, "°", function(v) fx.starHue = v end, 5)
t10.Toggle("Star: радужные", false, function(v) fx.starRainbow = v end, ICONS.TARGET)
t10.Toggle("Star: свечение", true, function(v) fx.starGlow = v end, ICONS.EYE)
t10.Button("▶ Проверить эффекты (на мне)", function()
    local h, ch = myHrp(), myChar()
    if not h or not ch then return end
    if not (fx.ghost or fx.lightning or fx.star) then notify("Включи хотя бы один эффект") return end
    fxDeath(ch, h.Position)
end)

-- DupeVote
local MM2_MAPS = {
    "Factory", "House 2", "Hotel", "Office", "Hospital", "Milbase", "Bank",
    "Police Station", "Workplace", "Research Facility", "Mansion 2", "Bio Lab",
    "Nook's Cranny", "Beach House", "Ski Lodge", "Casino", "Library", "Christmas House",
    "Ice Castle", "Village", "Colosseum", "Zoo", "Train Station", "Workshop",
}
local dupe = {map = 1, amount = 20, busy = false, rec = false, cap = nil, hooked = false, delay = 0, auto = false, interval = 2}
pcall(function()
    if hookmetamethod and getnamecallmethod then
        local old
        local function hk(self, ...)
            if dupe.rec then
                local m = getnamecallmethod()
                if (m == "FireServer" or m == "InvokeServer") and typeof(self) == "Instance" then
                    local n = self.Name:lower()
                    if n:find("vote") or n:find("map") then
                        local packed = {n = select("#", ...), ...}
                        dupe.cap = {r = self, m = m, a = packed}
                        task.defer(notify, "DupeVote: записан " .. self.Name)
                    end
                end
            end
            return old(self, ...)
        end
        old = hookmetamethod(game, "__namecall", newcclosure and newcclosure(hk) or hk)
        dupe.hooked = true
    end
end)

local function mapArgs(args)
    local out = {n = args.n}
    for i = 1, args.n do out[i] = args[i] end
    local mapName = MM2_MAPS[dupe.map]
    local done = false
    for i = 1, out.n do
        if type(out[i]) == "string" then
            for _, n in ipairs(MM2_MAPS) do
                if out[i] == n then out[i] = mapName done = true break end
            end
        end
        if done then break end
    end
    if not done then -- название карты не из списка: подменяем первый строковый аргумент
        for i = 1, out.n do
            if type(out[i]) == "string" then out[i] = mapName break end
        end
    end
    return out
end
local function btnMatches(b, name)
    local l = name:lower()
    if b.Name:lower() == l then return true end
    if b:IsA("TextButton") and b.Text:lower() == l then return true end
    for _, d in ipairs(b:GetDescendants()) do
        if d:IsA("TextLabel") and d.Text:lower() == l then return true end
    end
    return false
end
local function clickBtn(b)
    local done = false
    for _, sig in ipairs({"MouseButton1Click", "Activated", "MouseButton1Down", "MouseButton1Up"}) do
        if getconnections then
            pcall(function()
                for _, cn in ipairs(getconnections(b[sig])) do cn:Fire() done = true end
            end)
        elseif firesignal then
            pcall(function() firesignal(b[sig]) done = true end)
        end
    end
    return done
end

local function doDupeVote(silent)
    if dupe.busy then
        if not silent then notify("DupeVote: уже идёт") end
        return
    end
    dupe.busy = true
    task.spawn(function()
        pcall(function()
            local mapName = MM2_MAPS[dupe.map] or MM2_MAPS[1]
            local amt = math.clamp(math.floor(tonumber(dupe.amount) or 20), 1, 200)
            local dl = math.clamp(tonumber(dupe.delay) or 0, 0, 200) / 1000
            local up = table.unpack or unpack
            local sent = 0
            -- пауза между голосами: 0 = пачкой без ожидания (раз в 25 отправок уступаем кадр)
            local function gap(n)
                if dl > 0 then task.wait(dl) elseif n % 25 == 0 then task.wait() end
            end
            if not silent then notify("DupeVote: " .. mapName .. " x" .. amt) end
            -- 1) повтор записанного голоса (каждый вызов в своём потоке, не ждём ответ сервера)
            local cap = dupe.cap
            if cap and cap.r and cap.r.Parent then
                for n = 1, amt do
                    local a = mapArgs(cap.a)
                    if cap.m == "FireServer" then
                        task.spawn(function() pcall(function() cap.r:FireServer(up(a, 1, a.n)) end) end)
                    else
                        task.spawn(function() pcall(function() cap.r:InvokeServer(up(a, 1, a.n)) end) end)
                    end
                    sent = sent + 1
                    gap(n)
                end
            end
            -- 2) кнопка карты в GUI
            if sent == 0 then
                local pg = LocalPlayer:FindFirstChild("PlayerGui")
                if pg then
                    for _, d in ipairs(pg:GetDescendants()) do
                        if d:IsA("GuiButton") and btnMatches(d, mapName) then
                            for n = 1, amt do
                                if clickBtn(d) then sent = sent + 1 end
                                gap(n)
                            end
                            break
                        end
                    end
                end
            end
            -- 3) ремоуты с "vote" в имени
            if sent == 0 then
                for _, d in ipairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
                    if (d:IsA("RemoteEvent") or d:IsA("RemoteFunction")) and d.Name:lower():find("vote") then
                        for n = 1, amt do
                            if d:IsA("RemoteEvent") then
                                task.spawn(function() pcall(function() d:FireServer(mapName) d:FireServer(dupe.map) end) end)
                            else
                                task.spawn(function() pcall(function() d:InvokeServer(mapName) end) end)
                            end
                            sent = sent + 1
                            gap(n)
                        end
                    end
                end
            end
            if sent > 0 then
                if not silent then notify("DupeVote: отправлено " .. sent) end
            elseif not silent then
                notify("DupeVote: не сработало. Включи запись и проголосуй вручную")
            end
        end)
        dupe.busy = false
    end)
end

local tDV = addTab("DupeVote", ICONS.UTIL)
tDV.Section("🗳 DupeVote (дублирует голос за карту)")
local mapLabels = {}
for i, n in ipairs(MM2_MAPS) do mapLabels[i] = n end
tDV.ToggleDrop("Карта", true, function() end, ICONS.TP, mapLabels, 1, function(i)
    dupe.map = i
    notify("Карта: " .. (MM2_MAPS[i] or "?"))
end)
tDV.Slider("Количество голосов", 1, 200, 20, "", function(v) dupe.amount = v end)
tDV.Slider("Пауза между голосами (0 = максимально быстро)", 0, 100, 0, " мс", function(v) dupe.delay = v end, 5)
tDV.Toggle("DupeVote: запись (проголосуй вручную)", false, function(v)
    if v and not dupe.hooked then notify("DupeVote: нет hookmetamethod") return end
    dupe.rec = v
    if v then dupe.cap = nil notify("DupeVote: проголосуй за любую карту") end
end, ICONS.UTIL)
tDV.Button("▶ DupeVote сейчас", function() doDupeVote(false) end)
tDV.Slider("Авто: повтор каждые", 1, 10, 2, " сек", function(v) dupe.interval = v end, 0.5)
tDV.Toggle("DupeVote: Авто-повтор (голосует снова и снова)", false, function(v)
    dupe.auto = v
    if v then
        task.spawn(function()
            while dupe.auto do
                pcall(doDupeVote, true)
                task.wait(math.max(0.5, tonumber(dupe.interval) or 2))
            end
        end)
    end
end, ICONS.UTIL)

-- CustomModel
local t11 = addTab("CustomModel", ICONS.HAT)
t11.Section("🧬 Морфы (ищутся в Creator Store, не создаются)")
t11.Toggle("CustomModel", false, function(v)
    cm.on = v
    if v then applyCustomModel() else clearCustomModel() end
end, ICONS.HAT)
local labelsM = {}
for i, sl in ipairs(MODEL_SLOTS) do labelsM[i] = sl.label end
radioGroup(t11, "Model: ", labelsM, 1, function(i, changed)
    cm.sel = i
    if cm.on and (changed or cm.applied ~= i) then applyCustomModel() end
end, ICONS.EYE)
t11.Slider("Model: Size", 0.2, 3, 1, "x", function(v) cm.size = v end, 0.1)
t11.Button("🔄 Перезагрузить морф (применить размер)", function()
    if cm.on then
        clearCustomModel()
        applyCustomModel()
    else
        notify("Сначала включи CustomModel")
    end
end)
local mIdBox = t11.TextBox("ID морфа вручную (если поиск не нашёл)")
t11.Button("✔ Применить ID к выбранному морфу", function()
    local id = tonumber(mIdBox.Text)
    if not id then notify("Введи числовой ID") return end
    if not fetchModel(id) then notify("Модель с таким ID не загрузилась") return end
    assetCache["model:" .. MODEL_SLOTS[cm.sel].key] = id
    saveAssets()
    notify("ID сохранён: " .. id)
    if cm.on then
        clearCustomModel()
        applyCustomModel()
    end
end)

-- Sound
local t12 = addTab("Sound", ICONS.GUN)
t12.Section("🔊 Звуки (ищутся в Creator Store, не создаются)")
local labelsS = {}
for i, sl in ipairs(SOUND_SLOTS) do labelsS[i] = sl.label end
t12.ToggleDrop("Sound: Gun (звук пистолета)", false, function(v)
    snd.gun = v
    if v then applySoundSlot(snd.sel) else restoreSounds() end
end, ICONS.GUN, labelsS, 1, function(i)
    snd.sel = i
    applySoundSlot(i)
end)
t12.Button("▶ Проверить выбранный звук", previewSound)
local sIdBox = t12.TextBox("ID звука вручную (если поиск не нашёл)")
t12.Button("✔ Применить ID к выбранному звуку", function()
    local id = tonumber(sIdBox.Text)
    if not id then notify("Введи числовой ID") return end
    if not audioOk(id) then notify("Звук с таким ID не загрузился") return end
    assetCache["audio:" .. SOUND_SLOTS[snd.sel].key] = id
    assetCache["audio:" .. SOUND_SLOTS[snd.sel].key .. "!"] = id
    saveAssets()
    soundId = id
    notify("ID сохранён: " .. id)
end)

-- Watermark
local t13 = addTab("Watermark", ICONS.EYE)
t13.Section("🏷 Watermark")
t13.Toggle("Watermark", false, function(v)
    wm.on = v
    wmRebuild()
end, ICONS.EYE)
t13.Slider("Watermark: Size", 1, 10, 5, "", function(v)
    wm.size = v
    wmSetScale()
end)
radioGroup(t13, "Watermark: ", {"Style 1", "Style 2", "Style 3", "Style 4"}, 1, function(i)
    wm.style = i
    wmRebuild()
end, ICONS.EYE)

-- SVO
local t14 = addTab("SVO", ICONS.FLY)
t14.Section("🚀 SVO: дрон-камикадзе (морфы ищутся, не создаются)")
t14.Toggle("SVO", false, function(v)
    svo.on = v
    X.svoToggle(v)
end, ICONS.FLY)
local labelsV = {}
for i, sl in ipairs(SVO_SLOTS) do labelsV[i] = sl.label end
radioGroup(t14, "SVO: ", labelsV, 1, function(i) svo.sel = i end, ICONS.EYE)
t14.Slider("SVO: Speed", 10, 120, 45, " st/s", function(v) svo.speed = v end)
local vIdBox = t14.TextBox("ID морфа вручную (для выбранного дрона)")
t14.Button("✔ Применить ID к выбранному дрону", function()
    local id = tonumber(vIdBox.Text)
    if not id then notify("Введи числовой ID") return end
    if not fetchModel(id) then notify("Модель с таким ID не загрузилась") return end
    assetCache["model:" .. SVO_SLOTS[svo.sel].key] = id
    saveAssets()
    notify("ID сохранён: " .. id)
end)

-- TriggerBot / AimAssist
local t15 = addTab("Trigger/Assist", ICONS.AIM)
t15.Section("🎯 TriggerBot (стреляет, когда убийца в прицеле)")
t15.Toggle("TriggerBot", false, function(v) trig.on = v end, ICONS.AIM)
t15.Slider("Trigger: Delay", 10, 500, 100, " мс", function(v) trig.delay = v end, 10)
t15.Section("🧲 AimAssist (наводит камеру на убийцу)")
t15.Toggle("AimAssist", false, function(v) assist.on = v end, ICONS.TARGET)
t15.Slider("Assist: Smooth", 0.1, 5, 1, "", function(v) assist.smooth = v end, 0.1)
t15.Slider("Assist: Speed", 0.1, 3, 1, "", function(v) assist.speed = v end, 0.1)
t15.Toggle("Assist: Visible Check", true, function(v) assist.visible = v end, ICONS.EYE)

-- HUD: Notify / SoundNotify / Gradients
local t16 = addTab("HUD", ICONS.UTIL)
t16.Section("🔍 Размер интерфейса")
t16.Button("➕ GUI больше", function()
    setGuiScale(guiScale + 0.1)
    notify("GUI: размер x" .. guiScale)
end)
t16.Button("➖ GUI меньше", function()
    setGuiScale(guiScale - 0.1)
    notify("GUI: размер x" .. guiScale)
end)
t16.Section("🔔 Notify (карточки как в Celestial)")
t16.Toggle("Notify", true, function(v) nf.on = v end, ICONS.UTIL)
t16.Section("🔊 SoundNotify")
local labelsSN = {}
for i, sl in ipairs(SN_SLOTS) do labelsSN[i] = sl.label end
t16.ToggleDrop("SoundNotify", false, function(v)
    sn.on = v
    if v and not sn.id then X.applySoundNotify(sn.sel) end
end, ICONS.UTIL, labelsSN, 1, function(i)
    sn.sel = i
    X.applySoundNotify(i)
end)
local snBox = t16.TextBox("ID звука вручную (если поиск не нашёл)")
t16.Button("✔ Применить ID звука уведомлений", function()
    local id = tonumber(snBox.Text)
    if not id then notify("Введи числовой ID") return end
    if not audioOk(id) then notify("Звук с таким ID не загрузился") return end
    assetCache["audio:" .. SN_SLOTS[sn.sel].key] = id
    assetCache["audio:" .. SN_SLOTS[sn.sel].key .. "!"] = id
    saveAssets()
    sn.id = id
    notify("SoundNotify: ID сохранён")
end)
t16.Section("🎨 Gradients (весь HUD, ESP не меняется)")
t16.ToggleDrop("Gradients", false, function(v)
    grad.on = v
    X.applyTheme()
end, ICONS.EYE, {
    "Мятный",
    "Конфета (бирюзовый + фиолетовый)",
    "Серый + белый",
    "Кровавый",
    "Океан",
    "Закат",
    "Неон",
    "Золото",
    "Лёд",
    "Роза",
    "Токсик",
}, 1, function(i)
    grad.sel = i
    if grad.on then X.applyTheme() end
end)

-- v10: GunModel и JumpCircle
pcall(X.buildNew)

-- Configs
--------------------------------------------------
-- ANIMATION / EMOTES / CUSTOMSKY (v11.15)
--------------------------------------------------
local an = {track = nil, speed = 1, stopMove = true, busy = false, emote = false}
local function anStop()
    if an.track then pcall(function() an.track:Stop(0.2) end) an.track = nil end
end
local function anAnimator()
    local hum = myHum()
    if not hum then return nil end
    return hum:FindFirstChildOfClass("Animator") or new("Animator", {}, hum)
end
local function isR15()
    local h = myHum()
    return h and h.RigType == Enum.HumanoidRigType.R15
end
-- UGC-эмоции: достаём настоящий id анимации из ассета
local function anResolve(id)
    local ok, objs = pcall(function() return game:GetObjects("rbxassetid://" .. id) end)
    if ok and type(objs) == "table" then
        for _, o in ipairs(objs) do
            local a = o:IsA("Animation") and o or o:FindFirstChildWhichIsA("Animation", true)
            if a then
                local n = tostring(a.AnimationId):match("%d+")
                if n then return n end
            end
        end
    end
    return tostring(id)
end
local function anTry(id, looped)
    local animator = anAnimator()
    if not animator then return false end
    local a = Instance.new("Animation")
    a.AnimationId = "rbxassetid://" .. id
    local ok, tr = pcall(function() return animator:LoadAnimation(a) end)
    if not ok or not tr then return false end
    pcall(function() tr.Priority = Enum.AnimationPriority.Action4 end)
    tr.Looped = looped and true or false
    tr:Play(0.15)
    tr:AdjustSpeed(an.speed)
    local t0 = os.clock()
    while tr.Length == 0 and os.clock() - t0 < 2 do task.wait(0.05) end
    if tr.Length == 0 then pcall(function() tr:Stop(0) end) return false end
    an.track = tr
    return true
end
local function anPlay(ids, looped, resolve, label, isEmote)
    if an.busy then return end
    an.busy = true
    task.spawn(function()
        pcall(function()
            anStop()
            local ok = false
            for _, id in ipairs(ids) do
                local real = resolve and anResolve(id) or id
                if anTry(real, looped) then ok = true break end
            end
            an.emote = isEmote and true or false
            notify(ok and ("Анимация: " .. label) or ("Анимация не загрузилась: " .. label))
        end)
        an.busy = false
    end)
end
task.spawn(function() -- эмоция прерывается, когда начинаешь идти
    while true do
        task.wait(0.2)
        if an.stopMove and an.track and an.emote then
            local h = myHum()
            if h and h.MoveDirection.Magnitude > 0.1 then anStop() end
        end
    end
end)

local ANIMS = { -- {название, R15, R6}
    {"Wave", "507770239", "128777973"}, {"Point", "507770453", "128853357"},
    {"Cheer", "507770677", "129423030"}, {"Laugh", "507770818", "129423131"},
    {"Dance", "507771019", "182435998"}, {"Dance 2", "507771955", "182436842"},
    {"Dance 3", "507772104", "182436935"}, {"Sit", "2506281703", "178130996"},
    {"Idle", "507766388", "180435571"}, {"Walk", "507777826", "180426354"},
    {"Run", "507767714", "180426354"}, {"Jump", "507765000", "125750702"},
    {"Fall", "507767968", "180436148"}, {"Climb", "507765644", "180436334"},
}
local tAn = addTab("Animation", ICONS.FLY)
tAn.Section("🎬 Стандартные анимации Roblox")
tAn.Slider("Animation: Speed", 0.1, 3, 1, "x", function(v)
    an.speed = v
    if an.track then pcall(function() an.track:AdjustSpeed(v) end) end
end, 0.1)
tAn.Section("▶ Запуск (R15 и R6 определяются сами)")
for _, a in ipairs(ANIMS) do
    tAn.Button("▶ " .. a[1], function()
        anPlay({isR15() and a[2] or a[3]}, true, false, a[1], false)
    end)
end
tAn.Button("⏹ Остановить анимацию", anStop)

-- Паки анимаций из каталога (R15): подменяют idle/walk/run/jump/fall/climb в Animate
local PACKS = { -- {название, idle, walk, run, jump, fall, climb}
    {"Ninja", 656117400, 656121766, 656118852, 656117878, 656115606, 656114359},
    {"Zombie", 616158929, 616168032, 616163682, 616161997, 616157476, 616156119},
    {"Robot", 616088211, 616095330, 616091570, 616090535, 616087089, 616086039},
    {"Cartoony", 742637544, 742640026, 742638842, 742637942, 742637151, 742636889},
    {"Levitation", 616006778, 616013216, 616010382, 616008936, 616005863, 616003713},
    {"Superhero", 616111295, 616122287, 616117076, 616115533, 616108001, 616104706},
    {"Werewolf", 1083195517, 1083178339, 1083216690, 1083218792, 1083189019, 1083182000},
    {"Vampire", 1083445855, 1083473930, 1083462077, 1083455352, 1083443587, 1083439238},
    {"Knight", 657595757, 657552124, 657564596, 658409194, 657600338, 658360781},
    {"Mage", 707742142, 707897309, 707861613, 707853694, 707829716, 707826056},
    {"Stylish", 616136790, 616146177, 616140816, 616139451, 616134815, 616133594},
    {"Toy", 782841498, 782843345, 782842708, 782847020, 782846423, 782843869},
    {"Elder", 845397899, 845403856, 845386501, 845398858, 845396048, 845392038},
    {"Bubbly", 910004836, 910034870, 910025107, 910016857, 910001910, 909997997},
    {"Pirate", 750781874, 750785693, 750783738, 750782230, 750780242, 750779899},
    {"Astronaut", 891621366, 891667138, 891636393, 891627522, 891617961, 891609353},
    {"Oldschool", 5319828216, 5319847204, 5319844329, 5319841935, 5319839762, 5319816685},
}
local packOrig, packSel = {}, nil
local function packApply(p)
    local c = myChar()
    local an0 = c and c:FindFirstChild("Animate")
    if not an0 then notify("Animate не найден (подожди респавна)") return false end
    local function slot(folder, name, id)
        local f = an0:FindFirstChild(folder)
        local a = f and f:FindFirstChild(name)
        if a then
            if packOrig[a] == nil then packOrig[a] = a.AnimationId end
            a.AnimationId = "rbxassetid://" .. id
        end
    end
    slot("idle", "Animation1", p[2])
    slot("idle", "Animation2", p[2])
    slot("walk", "WalkAnim", p[3])
    slot("run", "RunAnim", p[4])
    slot("jump", "JumpAnim", p[5])
    slot("fall", "FallAnim", p[6])
    slot("climb", "ClimbAnim", p[7])
    local h = myHum()
    local animator = h and h:FindFirstChildOfClass("Animator")
    if animator then
        for _, t in ipairs(animator:GetPlayingAnimationTracks()) do pcall(function() t:Stop(0.1) end) end
    end
    return true
end
local function packReset()
    packSel = nil
    for a, id in pairs(packOrig) do pcall(function() if a.Parent then a.AnimationId = id end end) end
    packOrig = {}
    local h = myHum()
    local animator = h and h:FindFirstChildOfClass("Animator")
    if animator then
        for _, t in ipairs(animator:GetPlayingAnimationTracks()) do pcall(function() t:Stop(0.1) end) end
    end
end
LocalPlayer.CharacterAdded:Connect(function()
    if packSel then
        task.wait(1.5)
        pcall(packApply, packSel)
    end
end)
tAn.Section("📦 Паки анимаций из каталога (R15)")
for _, p in ipairs(PACKS) do
    tAn.Button("📦 " .. p[1], function()
        if not isR15() then notify("Паки работают только на R15") return end
        packSel = p
        if packApply(p) then notify("Пак: " .. p[1] .. " ✔") end
    end)
end
tAn.Button("↩ Вернуть обычные анимации", function()
    packReset()
    notify("Анимации: обычные")
end)

local GRIDDY_IDS = {"137360013072517", "71599151163683", "130175291898717", "112188228197797",
    "108776997290935", "124285036925322", "85886012143088", "113113631334973", "116150478424136"}
local tEm = addTab("Emotes", ICONS.FLY)
tEm.Section("💃 Эмоции (визуально, как в чате)")
tEm.Toggle("Emotes: стоп при движении", true, function(v) an.stopMove = v end, ICONS.UTIL)
tEm.Slider("Emotes: Speed", 0.1, 3, 1, "x", function(v)
    an.speed = v
    if an.track then pcall(function() an.track:AdjustSpeed(v) end) end
end, 0.1)
tEm.Button("🕺 Griddy", function() anPlay(GRIDDY_IDS, true, true, "Griddy", true) end)
tEm.Button("👋 Hello", function() anPlay({"3576686446"}, false, true, "Hello", true) end)
tEm.Button("🤷 Shrug", function() anPlay({"3576968026"}, false, true, "Shrug", true) end)
tEm.Button("🫡 Salute", function() anPlay({"3333474484"}, false, true, "Salute", true) end)
tEm.Button("🙃 Tilt", function() anPlay({"3334538554"}, false, true, "Tilt", true) end)
tEm.Button("⏹ Остановить эмоцию", anStop)
local emBox = tEm.TextBox("ID эмоции/анимации вручную")
tEm.Button("✔ Играть ID", function()
    local id = tostring(emBox.Text or ""):match("%d+")
    if not id then notify("Введи числовой ID") return end
    anPlay({id}, true, true, id, true)
end)

-- Лучшая видимость кастомных моделей ножа/пистолета (в том числе от 3 лица)
task.spawn(function()
    while true do
        task.wait(0.25)
        pcall(function()
            local c = myChar()
            if not c then return end
            for _, t in ipairs(c:GetChildren()) do
                if t:IsA("Tool") then
                    for _, nm in ipairs({"MWGunModel", "MWKnifeModel"}) do
                        local m = t:FindFirstChild(nm)
                        if m then
                            for _, d in ipairs(m:GetDescendants()) do
                                if d:IsA("BasePart") then
                                    if d:GetAttribute("MWT0") == nil then d:SetAttribute("MWT0", d.Transparency) end
                                    local t0 = d:GetAttribute("MWT0")
                                    if d.Transparency ~= t0 then d.Transparency = t0 end
                                    d.LocalTransparencyModifier = 0
                                end
                            end
                        end
                    end
                end
            end
        end)
    end
end)

-- CustomSky: небо ищется в Creator Store
local Lighting = game:GetService("Lighting")
local sky = {on = false, sel = 1, busy = false, orig = {}}
local SKY_SLOTS = {
    {key = "sky_space", label = "Космос", q = "space skybox"},
    {key = "sky_night", label = "Ночь со звёздами", q = "night sky skybox"},
    {key = "sky_sunset", label = "Закат", q = "sunset skybox"},
    {key = "sky_pink", label = "Розовое небо", q = "pink sky skybox"},
    {key = "sky_purple", label = "Фиолетовое небо", q = "purple sky skybox"},
    {key = "sky_galaxy", label = "Галактика", q = "galaxy skybox"},
    {key = "sky_anime", label = "Аниме небо", q = "anime sky skybox"},
    {key = "sky_blood", label = "Красная луна", q = "blood moon skybox"},
    {key = "sky_clouds", label = "Облака", q = "cloudy sky skybox"},
    {key = "sky_neon", label = "Неон", q = "neon sky skybox"},
}
local skyTpl = {}
local function fetchSky(id)
    if skyTpl[id] then return skyTpl[id] end
    local ok, res = pcall(function() return game:GetObjects("rbxassetid://" .. id) end)
    if not ok or type(res) ~= "table" then return nil end
    for _, o in ipairs(res) do
        local s = o:IsA("Sky") and o or o:FindFirstChildWhichIsA("Sky", true)
        if s then skyTpl[id] = s return s end
    end
    return nil
end
local function resolveSky(slot)
    local key = "sky:" .. slot.key
    local id = assetCache[key]
    if id and fetchSky(id) then return id end
    local ids = searchAssets("model", slot.q)
    for i = 1, math.min(#ids, 15) do
        if fetchSky(ids[i]) then
            assetCache[key] = ids[i]
            saveAssets()
            return ids[i]
        end
    end
    return nil
end
local function skyClear()
    local cur = Lighting:FindFirstChild("MWSky")
    if cur then cur:Destroy() end
    for s, p in pairs(sky.orig) do pcall(function() s.Parent = p end) end
    sky.orig = {}
end
local function skyUse(tpl, label)
    local old = Lighting:FindFirstChild("MWSky")
    if old then old:Destroy() end
    for _, s in ipairs(Lighting:GetChildren()) do
        if s:IsA("Sky") and not sky.orig[s] then
            sky.orig[s] = s.Parent
            s.Parent = nil
        end
    end
    local n = tpl:Clone()
    n.Name = "MWSky"
    n.Parent = Lighting
    notify("Sky: " .. label .. " ✔")
end
local function skyApply()
    if sky.busy then return end
    sky.busy = true
    task.spawn(function()
        pcall(function()
            local slot = SKY_SLOTS[sky.sel]
            notify("Ищу небо: " .. slot.label .. "…")
            local id = resolveSky(slot)
            local tpl = id and fetchSky(id)
            if not tpl then notify("Небо не найдено (введи ID вручную)") return end
            if not sky.on then return end
            skyUse(tpl, slot.label)
        end)
        sky.busy = false
    end)
end
local tSk = addTab("CustomSky", ICONS.EYE)
tSk.Section("🌌 Небо (ищется в Creator Store)")
tSk.Toggle("CustomSky", false, function(v)
    sky.on = v
    if v then skyApply() else skyClear() end
end, ICONS.EYE)
local labelsSky = {}
for i, sl in ipairs(SKY_SLOTS) do labelsSky[i] = sl.label end
radioGroup(tSk, "Sky: ", labelsSky, 1, function(i, changed)
    sky.sel = i
    if sky.on and changed then skyApply() end
end, ICONS.EYE)
local skBox = tSk.TextBox("ID неба вручную (ассет с Sky)")
tSk.Button("✔ Применить ID неба", function()
    local id = tonumber(skBox.Text)
    if not id then notify("Введи числовой ID") return end
    task.spawn(function()
        local tpl = fetchSky(id)
        if tpl then
            sky.on = true
            skyUse(tpl, tostring(id))
        else
            notify("В этом ассете нет Sky")
        end
    end)
end)

local t9 = addTab("Configs", ICONS.UTIL)
t9.Section("💾 Конфиги (сохранение настроек)")
local cfgName = t9.TextBox("Имя конфига")
local CFG_DIR = "ManewareMM2"
local cfgHolder
local activeCfg = nil -- последний загруженный/сохранённый конфиг

local function cleanName(n)
    n = tostring(n or ""):gsub("[/\\:%*%?\"<>|]", ""):gsub("^%s+", ""):gsub("%s+$", "")
    return n
end
local function cfgSupported()
    return writefile ~= nil and readfile ~= nil and isfolder ~= nil and makefolder ~= nil and listfiles ~= nil
end
local CFG_RESERVED = {ui = true, assets = true} -- служебные файлы, не конфиги
local function cfgSave(name)
    name = cleanName(name)
    if name == "" then notify("Конфиги: введи имя конфига") return false end
    if not cfgSupported() then notify("Конфиги: executor не поддерживает файлы") return false end
    if CFG_RESERVED[name] then notify("Конфиги: это имя зарезервировано, выбери другое") return false end
    pcall(function() if not isfolder(CFG_DIR) then makefolder(CFG_DIR) end end)
    local data = {}
    for key, e in pairs(REG) do
        local okG, v = pcall(e.get)
        local t = type(v)
        if okG and (t == "boolean" or t == "string" or t == "table"
            or (t == "number" and v == v and v ~= math.huge and v ~= -math.huge)) then
            data[key] = v
        end
    end
    -- Метаданные автора для локальной библиотеки (имя отображения, не верификация личности).
    pcall(function() data._author = LocalPlayer.DisplayName .. " (@" .. LocalPlayer.Name .. ")" end)
    data._configName = name
    data._createdAt = os.date("!%Y-%m-%d %H:%M:%S")
    -- Дополнительные параметры CustomModel / GunModel и ID моделей.
    pcall(function()
        data._custom = {customModel = {on = cm.on, sel = cm.sel, size = cm.size},
            gunModel = {on = gm.on, sel = gm.sel, size = gm.size, rot = gm.rot}, assets = {}}
        for k, v in pairs(assetCache) do
            if type(k) == "string" and (k:sub(1, 6) == "model:" or k:sub(1, 6) == "sound:") then data._custom.assets[k] = v end
        end
    end)
    -- В конфиг записывается имя и положение каждого существующего бинда.
    pcall(function() if X.collectUI then data._ui = X.collectUI() end end)
    local okE, raw = pcall(function() return HttpService:JSONEncode(data) end)
    if not okE then
        -- что-то не кодируется в JSON: убираем таблицы из настроек и пробуем снова
        for k, v in pairs(data) do
            if type(v) == "table" and k ~= "_ui" and k ~= "_custom" then data[k] = nil end
        end
        okE, raw = pcall(function() return HttpService:JSONEncode(data) end)
    end
    if not okE then
        data._ui = nil
        data._custom = nil
        okE, raw = pcall(function() return HttpService:JSONEncode(data) end)
    end
    if not okE then notify("Конфиги: ошибка кодирования: " .. tostring(raw)) return false end
    local okW, err = pcall(writefile, CFG_DIR .. "/" .. name .. ".json", raw)
    if not okW then notify("Конфиги: ошибка записи: " .. tostring(err)) return false end
    -- резервная копия: если конфиг удалят, его можно вернуть кнопкой "Восстановить"
    pcall(function()
        if not isfolder(CFG_DIR .. "/Backup") then makefolder(CFG_DIR .. "/Backup") end
        writefile(CFG_DIR .. "/Backup/" .. name .. ".json", raw)
    end)
    activeCfg = name
    notify("Конфиги: сохранено " .. name)
    return true
end
local function cfgLoad(name)
    local ok, data = pcall(function()
        return HttpService:JSONDecode(readfile(CFG_DIR .. "/" .. name .. ".json"))
    end)
    if not ok or type(data) ~= "table" then notify("Не удалось загрузить") return end
    for key, val in pairs(data) do
        if key:sub(1, 1) ~= "_" then
            local e = REG[key]
            if e then pcall(e.set, val, true) end
        end
    end
    if type(data._custom) == "table" then
        local c = data._custom
        if type(c.customModel) == "table" then
            if tonumber(c.customModel.sel) then cm.sel = math.clamp(math.floor(c.customModel.sel), 1, #MODEL_SLOTS) end
            if tonumber(c.customModel.size) then cm.size = math.clamp(c.customModel.size, 0.2, 3) end
            if type(c.customModel.on) == "boolean" then cm.on = c.customModel.on end
        end
        if type(c.gunModel) == "table" then
            if tonumber(c.gunModel.sel) then gm.sel = math.clamp(math.floor(c.gunModel.sel), 1, #GM_SLOTS) end
            if tonumber(c.gunModel.size) then gm.size = math.clamp(c.gunModel.size, 0.2, 3) end
            if tonumber(c.gunModel.rot) then gm.rot = c.gunModel.rot % 360 end
            if type(c.gunModel.on) == "boolean" then gm.on = c.gunModel.on end
        end
        if type(c.assets) == "table" then
            for k, v in pairs(c.assets) do
                if type(k) == "string" and (k:sub(1, 6) == "model:" or k:sub(1, 6) == "sound:") and tonumber(v) then assetCache[k] = tonumber(v) end
            end
            pcall(saveAssets)
        end
    end
    if data._ui and X.applyUI then pcall(X.applyUI, data._ui) end
    task.defer(function()
        if cm.on then pcall(applyCustomModel) else pcall(clearCustomModel) end
        if gm.on then gm.cur = nil else pcall(gmClearAll) end
    end)
    activeCfg = name
    notify("Загружен: " .. name)
end
local function cfgDelete(name)
    -- не стираем насовсем: копия уходит в Trash, оттуда конфиг можно вернуть
    pcall(function()
        local p = CFG_DIR .. "/" .. name .. ".json"
        if isfile(p) then
            if not isfolder(CFG_DIR .. "/Trash") then makefolder(CFG_DIR .. "/Trash") end
            writefile(CFG_DIR .. "/Trash/" .. name .. "__" .. tostring(os.time()) .. ".json", readfile(p))
            delfile(p)
        end
    end)
end
local function cfgRefresh()
    if not cfgHolder then return end
    for _, ch in ipairs(cfgHolder:GetChildren()) do
        if ch:IsA("Frame") then ch:Destroy() end
    end
    if not cfgSupported() then return end
    local names = {}
    pcall(function()
        if not isfolder(CFG_DIR) then return end
        for _, f in ipairs(listfiles(CFG_DIR)) do
            local n = tostring(f):match("([^/\\]+)%.json$")
            if n and not CFG_RESERVED[n] then table.insert(names, n) end
        end
    end)
    table.sort(names)
    for i, n in ipairs(names) do
        addRow(cfgHolder, i, n, {
            {text = "✕", color = C.RED, w = 30, fn = function() cfgDelete(n) cfgRefresh() end},
            {text = "Save", color = C.ACCENT, w = 44, fn = function() cfgSave(n) end},
            {text = "Load", color = C.GREEN, w = 44, fn = function() cfgLoad(n) end},
            {text = "Local", color = Color3.fromRGB(124, 82, 210), w = 48, fn = function()
                if not cfgSupported() then notify("Executor не поддерживает файлы") return end
                local ok, data = pcall(function()
                    return HttpService:JSONDecode(readfile(CFG_DIR .. "/" .. n .. ".json"))
                end)
                if not ok or type(data) ~= "table" then notify("Не удалось прочитать конфиг") return end
                pcall(function() if not isfolder(CFG_DIR .. "/LocalLibrary") then makefolder(CFG_DIR .. "/LocalLibrary") end end)
                data._author = data._author or (LocalPlayer.DisplayName .. " (@" .. LocalPlayer.Name .. ")")
                data._configName = n
                data._sharedAt = os.date("!%Y-%m-%d %H:%M:%S")
                local safe = n:gsub("[^%w_%-]", "_")
                local saved, err = pcall(function()
                    writefile(CFG_DIR .. "/LocalLibrary/" .. safe .. ".json", HttpService:JSONEncode(data))
                end)
                notify(saved and ("Добавлен в Local: " .. n) or ("Ошибка Local: " .. tostring(err)))
            end},
        })
    end
end
-- Восстановление конфигов: ищет копии в LocalLibrary, Backup, Trash и в старых папках Maneware*
local function cfgIsConfig(data)
    if type(data) ~= "table" then return false end
    if data._configName then return true end
    for k in pairs(data) do
        if type(k) == "string" and REG[k] then return true end
    end
    return false
end
local function cfgRestore(silent)
    if not cfgSupported() or not isfile then
        if not silent then notify("Конфиги: executor не поддерживает файлы") end
        return 0
    end
    pcall(function() if not isfolder(CFG_DIR) then makefolder(CFG_DIR) end end)
    local dirs, seen = {}, {}
    local function addDir(d) if d and not seen[d] then seen[d] = true table.insert(dirs, d) end end
    addDir(CFG_DIR .. "/LocalLibrary")
    addDir(CFG_DIR .. "/Backup")
    addDir(CFG_DIR .. "/Trash")
    addDir(CFG_DIR .. "/Configs")
    addDir(CFG_DIR .. "/configs")
    addDir("Maneware")
    addDir("ManewareConfigs")
    addDir("Maneware_MM2")
    addDir("ManewareMM2_Configs")
    pcall(function()
        for _, p in ipairs(listfiles("")) do
            local nm = tostring(p):match("([^/\\]+)$") or ""
            if nm:lower():find("manew", 1, true) and not nm:find("%.") and nm ~= CFG_DIR then addDir(tostring(p)) end
        end
    end)
    local restored = 0
    for _, d in ipairs(dirs) do
        pcall(function()
            if not isfolder(d) then return end
            for _, path in ipairs(listfiles(d)) do
                path = tostring(path)
                local stem = path:match("([^/\\]+)%.json$")
                if stem and not CFG_RESERVED[stem] then
                    local okR, data = pcall(function() return HttpService:JSONDecode(readfile(path)) end)
                    if okR and cfgIsConfig(data) then
                        local nm = cleanName(tostring(data._configName or stem))
                        if nm ~= "" and not CFG_RESERVED[nm] then
                            local target = CFG_DIR .. "/" .. nm .. ".json"
                            if not isfile(target) then
                                local okW = pcall(writefile, target, HttpService:JSONEncode(data))
                                if okW then restored += 1 end
                            end
                        end
                    end
                end
            end
        end)
    end
    if not silent then notify("Конфиги: восстановлено " .. restored) end
    return restored
end
-- Онлайн-библиотека. Требует развернутый Cloudflare Worker URL; сам Delta сервером не является.
local onlineApiBox = t9.TextBox("URL онлайн-сервера Cloudflare Worker")
local onlineHolder
local function onlineRequest(url, method, body)
    local rq = request or http_request or (syn and syn.request) or (http and http.request)
    if not rq then notify("Delta: HTTP request API недоступен") return nil end
    local opts = {Url = url, Method = method or "GET", Headers = { ["Content-Type"] = "application/json" }}
    if body then opts.Body = body end
    local ok, res = pcall(rq, opts)
    if not ok or type(res) ~= "table" or (res.StatusCode and res.StatusCode >= 400) then
        notify("Онлайн-сервер недоступен" .. (res and res.StatusCode and (" (" .. tostring(res.StatusCode) .. ")") or ""))
        return nil
    end
    local success, decoded = pcall(function() return HttpService:JSONDecode(res.Body or "{}") end)
    if not success then notify("Сервер вернул некорректный JSON") return nil end
    return decoded
end
local function onlineBase()
    local u = cleanName("") -- очистка имени не меняет URL; используется только для проверки строки ниже
    u = tostring(onlineApiBox.Text or ""):gsub("%s+$", ""):gsub("^%s+", ""):gsub("/+$", "")
    if not u:match("^https://") then notify("Вставь HTTPS URL своего Worker") return nil end
    return u
end
local function onlineUpload()
    local base = onlineBase(); if not base then return end
    local name = activeCfg or cleanName(cfgName.Text)
    if name == "" then notify("Сначала сохрани конфиг локально") return end
    local ok, raw = pcall(function() return readfile(CFG_DIR .. "/" .. name .. ".json") end)
    if not ok or type(raw) ~= "string" then notify("Не удалось прочитать локальный конфиг") return end
    local result = onlineRequest(base .. "/configs", "POST", raw)
    if result and result.id then notify("Опубликован онлайн: " .. tostring(result.name) .. " / ID " .. tostring(result.id)) end
end
local function onlineRefresh()
    local base = onlineBase(); if not base then return end
    if not onlineHolder then
        t9.Section("🌐 Онлайн-конфиги")
        onlineHolder = t9.Holder()
    end
    for _, ch in ipairs(onlineHolder:GetChildren()) do if ch:IsA("Frame") then ch:Destroy() end end
    local result = onlineRequest(base .. "/configs", "GET")
    if not result or type(result.configs) ~= "table" then return end
    for i, item in ipairs(result.configs) do
        local id = tostring(item.id or "")
        if id:match("^[a-fA-F0-9]+$") then
            addRow(onlineHolder, i, tostring(item.name or "Config") .. " • " .. tostring(item.author or "Unknown"), {
                {text = "Load", color = C.GREEN, w = 48, fn = function()
                    local b = onlineBase(); if not b then return end
                    local got = onlineRequest(b .. "/configs/" .. id, "GET")
                    if not got or type(got.config) ~= "table" then return end
                    local n = cleanName(tostring(got.config._configName or ("online_" .. id)))
                    if n == "" then n = "online_" .. id end
                    pcall(function() writefile(CFG_DIR .. "/" .. n .. ".json", HttpService:JSONEncode(got.config)) end)
                    cfgLoad(n)
                end},
                {text = "ID", color = C.ACCENT, w = 38, fn = function() notify("Online ID: " .. id) end},
            })
        end
    end
    notify("Онлайн-список обновлён")
end
t9.Button("☁️ Опубликовать открытый/последний конфиг", onlineUpload)
t9.Button("🌐 Обновить онлайн-библиотеку", onlineRefresh)

t9.Button("💾 Сохранить конфиг (по имени выше)", function()
    cfgSave(cfgName.Text)
    cfgRefresh()
end)
t9.Button("💾 Сохранить в открытый конфиг", function()
    if not activeCfg then notify("Сначала загрузи или сохрани конфиг") return end
    cfgSave(activeCfg)
end)
t9.Button("🔄 Обновить список", cfgRefresh)
t9.Button("♻️ Восстановить удалённые конфиги", function()
    cfgRestore(false)
    cfgRefresh()
end)
t9.Section("📂 Сохранённые конфиги")
cfgHolder = t9.Holder()
cfgRefresh()
-- один раз при первом запуске v11.11: вернуть конфиги из копий
pcall(function()
    if cfgSupported() and isfile and not isfile(CFG_DIR .. "/restored_v1.txt") then
        local n = cfgRestore(true)
        writefile(CFG_DIR .. "/restored_v1.txt", tostring(n))
        if n > 0 then
            cfgRefresh()
            notify("Конфиги: восстановлено " .. n)
        end
    end
end)

-- Локальная библиотека конфигов. Она общая только для файлов на этом устройстве;
-- для реального обмена между разными пользователями нужен внешний сервер/API.
local localLibraryWindow, localSearchBox, localLibraryHolder
local LOCAL_LIB_DIR = CFG_DIR .. "/LocalLibrary"

local function openLocalLibrary()
    if localLibraryWindow and localLibraryWindow.Parent then
        localLibraryWindow.Visible = true
        return
    end

    localLibraryWindow = new("Frame", {
        Name = "LocalConfigLibrary",
        Size = UDim2.new(0.94, 0, 0.82, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = C.BG,
        BorderSizePixel = 0,
        ZIndex = 50,
    }, hubGui)
    corner(12, localLibraryWindow)
    new("UIStroke", {Color = C.ACCENT, Thickness = 2}, localLibraryWindow)

    local header = new("Frame", {
        Size = UDim2.new(1, 0, 0, 44), BackgroundColor3 = C.TOPBAR,
        BorderSizePixel = 0, ZIndex = 51,
    }, localLibraryWindow)
    corner(10, header)
    new("TextLabel", {
        Size = UDim2.new(1, -60, 1, 0), Position = UDim2.new(0, 12, 0, 0),
        BackgroundTransparency = 1, Text = "LOCAL CONFIG LIBRARY",
        TextColor3 = C.TEXT, TextSize = 14, Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 52,
    }, header)
    local closeLocal = new("TextButton", {
        Size = UDim2.new(0, 34, 0, 32), Position = UDim2.new(1, -40, 0, 6),
        BackgroundColor3 = C.RED, Text = "X", TextColor3 = C.TEXT,
        TextSize = 14, Font = Enum.Font.GothamBold, BorderSizePixel = 0, ZIndex = 52,
    }, header)
    corner(7, closeLocal)
    onTap(closeLocal, function() localLibraryWindow.Visible = false end)

    localSearchBox = new("TextBox", {
        Size = UDim2.new(1, -20, 0, 38), Position = UDim2.new(0, 10, 0, 52),
        BackgroundColor3 = C.ELEMENT, PlaceholderText = "Найти по автору или конфигу...",
        Text = "", ClearTextOnFocus = false, TextColor3 = C.TEXT,
        PlaceholderColor3 = C.DIM, TextSize = 13, Font = Enum.Font.Gotham,
        BorderSizePixel = 0, ZIndex = 51,
    }, localLibraryWindow)
    corner(8, localSearchBox)

    local hint = new("TextLabel", {
        Size = UDim2.new(1, -20, 0, 32), Position = UDim2.new(0, 10, 0, 92),
        BackgroundTransparency = 1,
        Text = "Local хранится на этом устройстве. Для обмена с другими нужны экспорт/сервер.",
        TextColor3 = C.DIM, TextSize = 10, TextWrapped = true,
        Font = Enum.Font.Gotham, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 51,
    }, localLibraryWindow)

    localLibraryHolder = new("ScrollingFrame", {
        Size = UDim2.new(1, -20, 1, -136), Position = UDim2.new(0, 10, 0, 128),
        BackgroundTransparency = 1, BorderSizePixel = 0, ScrollBarThickness = 4,
        AutomaticCanvasSize = Enum.AutomaticSize.Y, CanvasSize = UDim2.new(0, 0, 0, 0),
        ScrollingDirection = Enum.ScrollingDirection.Y, Active = true, ZIndex = 51,
    }, localLibraryWindow)
    new("UIListLayout", {Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder}, localLibraryHolder)

    local function refreshLocalLibrary()
        for _, child in ipairs(localLibraryHolder:GetChildren()) do
            if child:IsA("Frame") then child:Destroy() end
        end
        local query = string.lower(tostring(localSearchBox.Text or ""))
        local files = {}
        pcall(function()
            if not isfolder or not listfiles or not isfolder(LOCAL_LIB_DIR) then return end
            for _, path in ipairs(listfiles(LOCAL_LIB_DIR)) do
                if tostring(path):match("%.json$") then table.insert(files, path) end
            end
        end)
        table.sort(files)
        local shown = 0
        for _, path in ipairs(files) do
            local ok, data = pcall(function() return HttpService:JSONDecode(readfile(path)) end)
            if ok and type(data) == "table" then
                local name = tostring(data._configName or path:match("([^/\\]+)%.json$") or "Config")
                local author = tostring(data._author or "Автор не указан")
                if query == "" or string.find(string.lower(name), query, 1, true)
                    or string.find(string.lower(author), query, 1, true) then
                    shown += 1
                    local row = new("Frame", {
                        Size = UDim2.new(1, -4, 0, 72), BackgroundColor3 = C.ELEMENT,
                        BorderSizePixel = 0, LayoutOrder = shown, ZIndex = 52,
                    }, localLibraryHolder)
                    corner(8, row)
                    new("TextLabel", {
                        Size = UDim2.new(1, -116, 1, 0), Position = UDim2.new(0, 8, 0, 0),
                        BackgroundTransparency = 1, Text = name .. "\nАвтор: " .. author,
                        TextColor3 = C.TEXT, TextSize = 11, TextWrapped = true,
                        Font = Enum.Font.GothamSemibold, TextXAlignment = Enum.TextXAlignment.Left,
                        ZIndex = 53,
                    }, row)
                    local loadBtn = new("TextButton", {
                        Size = UDim2.new(0, 48, 0, 30), Position = UDim2.new(1, -104, 0.5, -15),
                        BackgroundColor3 = C.GREEN, Text = "Load", TextColor3 = C.TEXT,
                        TextSize = 11, Font = Enum.Font.GothamBold, BorderSizePixel = 0, ZIndex = 53,
                    }, row)
                    corner(6, loadBtn)
                    onTap(loadBtn, function()
                        for key, value in pairs(data) do
                            if key ~= "_ui" and key:sub(1, 1) ~= "_" then
                                local entry = REG[key]
                                if entry then pcall(entry.set, value, true) end
                            end
                        end
                        if data._ui and X.applyUI then pcall(X.applyUI, data._ui) end
                        notify("Local загружен: " .. name)
                    end)
                    local saveBtn = new("TextButton", {
                        Size = UDim2.new(0, 48, 0, 30), Position = UDim2.new(1, -52, 0.5, -15),
                        BackgroundColor3 = C.ACCENT, Text = "Save", TextColor3 = C.TEXT,
                        TextSize = 11, Font = Enum.Font.GothamBold, BorderSizePixel = 0, ZIndex = 53,
                    }, row)
                    corner(6, saveBtn)
                    onTap(saveBtn, function()
                        local target = cleanName(cfgName.Text)
                        if target == "" then target = name end
                        cfgSave(target)
                        cfgRefresh()
                        notify("Сохранено в обычные конфиги: " .. target)
                    end)
                end
            end
        end
        if shown == 0 then
            new("TextLabel", {
                Size = UDim2.new(1, -8, 0, 42), BackgroundTransparency = 1,
                Text = "Ничего не найдено. Нажми Local рядом с конфигом, чтобы добавить его.",
                TextColor3 = C.DIM, TextSize = 12, TextWrapped = true,
                Font = Enum.Font.Gotham, ZIndex = 52,
            }, localLibraryHolder)
        end
    end

    localSearchBox:GetPropertyChangedSignal("Text"):Connect(refreshLocalLibrary)
    refreshLocalLibrary()
end

t9.Button("🌐 Открыть Local Config Manager", openLocalLibrary)

--------------------------------------------------
-- ПЛАВАЮЩАЯ КНОПКА
--------------------------------------------------
local toggleGui = makeGui("ManewareToggle", 99999)
local menuVisible = true

local function setMenu(show)
    menuVisible = show and true or false
    if X.chatBtnShow then pcall(X.chatBtnShow, not menuVisible) end
    pcall(function() NLWin.Signal:SetValue(menuVisible) end)
end

local fab = new("TextButton", {Size = UDim2.new(0, 42, 0, 42), Position = UDim2.new(1, -56, 0.5, -21),
    BackgroundColor3 = C.ACCENT, Text = "", AutoButtonColor = false, BorderSizePixel = 0, ZIndex = 10}, toggleGui)
corner(21, fab)
new("UIStroke", {Color = Color3.new(1, 1, 1), Thickness = 2}, fab)
local fabIcon = createIcon(ICONS.MENU, UDim2.new(0, 22, 0, 22), fab)
fabIcon.Position = UDim2.new(0.5, -11, 0.5, -11)
fabIcon.ImageColor3 = Color3.new(1, 1, 1)
fabIcon.ZIndex = 11

-- Режим редактирования: двигать кнопку/watermark/binds/killfeed можно ТОЛЬКО в нём
local EDIT = {mode = nil, reopen = false}

local function makeDraggable(obj, canDrag)
    local drag, startPos, startU = false, nil, nil
    obj.InputBegan:Connect(function(i)
        if (i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1) and canDrag() then
            drag, startPos, startU = true, i.Position, obj.Position
        end
    end)
    UIS.InputChanged:Connect(function(i)
        if drag and (i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseMovement) then
            local d = i.Position - startPos
            obj.Position = UDim2.new(startU.X.Scale, startU.X.Offset + d.X, startU.Y.Scale, startU.Y.Offset + d.Y)
        end
    end)
    UIS.InputEnded:Connect(function(i)
        if drag and (i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1) then
            drag = false
        end
    end)
end
makeDraggable(fab, function() return EDIT.mode == "fab" end)
onTap(fab, function()
    if EDIT.mode then return end
    setMenu(not menuVisible)
end)

onTap(closeBtn, function() setMenu(false) end)
UIS.InputBegan:Connect(function(i, gpe)
    if gpe then return end
    if i.KeyCode == Enum.KeyCode.Insert or i.KeyCode == Enum.KeyCode.RightControl then setMenu(not menuVisible) end
end)

--------------------------------------------------
-- ИНТЕРФЕЙС: watermark, binds, killfeed, режим редактирования
--------------------------------------------------
local uiData = readJson("ui.json") or {}
local function posToTbl(pp) return {pp.X.Scale, pp.X.Offset, pp.Y.Scale, pp.Y.Offset} end
local function tblToPos(t) return UDim2.new(t[1] or 0, t[2] or 0, t[3] or 0, t[4] or 0) end
if uiData.fab then pcall(function() fab.Position = tblToPos(uiData.fab) end) end
if uiData.kf then pcall(function() X.kfRoot.Position = tblToPos(uiData.kf) end) end

-- Watermark
local wmGui = makeGui("ManewareWM", 99996)
local wmRoot = new("Frame", {Name = "WM", AutomaticSize = Enum.AutomaticSize.XY, Size = UDim2.new(0, 0, 0, 0),
    BackgroundTransparency = 1, Active = false, Visible = false, AnchorPoint = Vector2.new(0.5, 0),
    Position = UDim2.new(0.5, 0, 0, 14)}, wmGui)
if uiData.wm then pcall(function() wmRoot.Position = tblToPos(uiData.wm) end) end
local wmScale = new("UIScale", {Scale = 1}, wmRoot)
local wmUpdate = nil

wmSetScale = function() wmScale.Scale = 0.5 + wm.size * 0.1 end
wmRebuild = function()
    for _, ch in ipairs(wmRoot:GetChildren()) do
        if not ch:IsA("UIScale") and ch.Name ~= "MWEditBox" then ch:Destroy() end
    end
    wmUpdate = nil
    wmSetScale()
    wmRoot.Visible = wm.on and wm.style > 0
    if not wmRoot.Visible then return end
    local build = WM_STYLES[wm.style]
    if build then
        wmUpdate = build(wmRoot)
        pcall(wmUpdate)
    end
end
task.spawn(function()
    while true do
        task.wait(0.5)
        if wmUpdate then pcall(wmUpdate) end
    end
end)
makeDraggable(wmRoot, function() return EDIT.mode == "wm" end)
makeDraggable(X.kfRoot, function() return EDIT.mode == "kf" end)

-- Binds: кнопки на экране, включают/выключают функции
local bindGui = makeGui("ManewareBinds", 99997)
local bindButtons = {}

-- Keybinds (ПК): клавиши и панель снизу слева
local pcKeys = {} -- имя функции -> английская буква клавиши
local isPC = UIS.KeyboardEnabled
local kbSig = ""
local kbGui = makeGui("ManewareKeybinds", 99995)
local kbRoot = new("Frame", {Name = "KB", Size = UDim2.new(0, 190, 0, 0), AutomaticSize = Enum.AutomaticSize.Y,
    BackgroundTransparency = 1, Active = false, Visible = false, AnchorPoint = Vector2.new(0, 1),
    Position = UDim2.new(0, 14, 1, -14)}, kbGui)
new("UIListLayout", {SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 2)}, kbRoot)
if uiData.kbp then pcall(function() kbRoot.Position = tblToPos(uiData.kbp) end) end
if type(uiData.pc) == "table" then
    for n, k in pairs(uiData.pc) do
        if type(k) == "string" and k:match("^%a$") then pcKeys[n] = k:upper() end
    end
end
local function copyPc()
    local t = {}
    for n, k in pairs(pcKeys) do t[n] = k end
    return t
end
makeDraggable(kbRoot, function() return EDIT.mode == "kb" end)

local function saveUI()
    local d = {fab = posToTbl(fab.Position), wm = posToTbl(wmRoot.Position), kf = posToTbl(X.kfRoot.Position), kbp = posToTbl(kbRoot.Position), pc = copyPc(), binds = {}}
    for name, b in pairs(bindButtons) do d.binds[name] = posToTbl(b.Position) end
    uiData = d
    writeJson("ui.json", d)
end

local createBind -- объявляем заранее: X.applyUI ниже вызывает createBind (раньше это была ошибка: глобал nil)

-- для конфигов: сохраняем/загружаем позиции FAB, watermark, killfeed, биндов
X.collectUI = function()
    local d = {fab = posToTbl(fab.Position), wm = posToTbl(wmRoot.Position), kf = posToTbl(X.kfRoot.Position), kbp = posToTbl(kbRoot.Position), pc = copyPc(), binds = {}}
    for name, b in pairs(bindButtons) do d.binds[name] = posToTbl(b.Position) end
    return d
end
X.applyUI = function(d)
    if type(d) ~= "table" then return end
    if d.fab then pcall(function() fab.Position = tblToPos(d.fab) end) end
    if d.wm then pcall(function() wmRoot.Position = tblToPos(d.wm) end) end
    if d.kf then pcall(function() X.kfRoot.Position = tblToPos(d.kf) end) end
    if d.kbp then pcall(function() kbRoot.Position = tblToPos(d.kbp) end) end
    if type(d.pc) == "table" then
        for k in pairs(pcKeys) do pcKeys[k] = nil end
        for n, k in pairs(d.pc) do
            if type(k) == "string" and k:match("^%a$") then pcKeys[n] = k:upper() end
        end
        kbSig = ""
    end
    if type(d.binds) == "table" then
        for name, t in pairs(d.binds) do
            if bindButtons[name] then
                pcall(function() bindButtons[name].Position = tblToPos(t) end)
            else
                pcall(createBind, name, tblToPos(t))
            end
        end
    end
    saveUI()
end

local bindStates = {}

-- что делает бинд: тоггл (с состоянием) или кнопка-действие
local function bindInfo(name)
    local e = REG[name]
    if e and e.kind == "toggle" then
        return function() e.set(not e.get()) end, function() return e.get() end
    end
    local fn = ACT[name]
    if fn then return function() task.spawn(fn) end, nil end
    return nil
end

createBind = function(name, pos)
    if bindButtons[name] then return false end
    local run, getState = bindInfo(name)
    if not run then return false end
    local n = 0
    for _ in pairs(bindButtons) do n = n + 1 end
    local btn = new("TextButton", {Size = UDim2.new(0, 70, 0, 42),
        Position = pos or UDim2.new(0.5, -105 + (n % 4) * 76, 0.3, math.floor(n / 4) * 50),
        BackgroundColor3 = C.ELEMENT, Text = name, TextColor3 = C.TEXT, TextScaled = true, Font = Enum.Font.GothamBold,
        AutoButtonColor = false, BorderSizePixel = 0, ZIndex = 5}, bindGui)
    new("UITextSizeConstraint", {MaxTextSize = 13, MinTextSize = 7}, btn)
    new("UIPadding", {PaddingLeft = UDim.new(0, 4), PaddingRight = UDim.new(0, 4), PaddingTop = UDim.new(0, 3),
        PaddingBottom = UDim.new(0, 3)}, btn)
    corner(10, btn)
    new("UIStroke", {Color = C.ACCENT, Thickness = 1.5}, btn)
    onTap(btn, function()
        if EDIT.mode then return end
        run()
    end)
    makeDraggable(btn, function() return EDIT.mode == "binds" end)
    bindButtons[name] = btn
    bindStates[name] = getState or false
    return true
end

local function deleteBind(name)
    local b = bindButtons[name]
    local had = (b ~= nil) or (pcKeys[name] ~= nil)
    if b then
        b:Destroy()
        bindButtons[name] = nil
        bindStates[name] = nil
    end
    pcKeys[name] = nil
    kbSig = ""
    if had then
        saveUI()
        notify("Бинды: бинд удалён")
    else
        notify("Бинды: такого бинда нет")
    end
end

task.spawn(function() -- вид кнопки = состояние функции
    while true do
        task.wait(0.3)
        for name, b in pairs(bindButtons) do
            local gs = bindStates[name]
            if b.Parent and gs then
                pcall(function()
                    if grad.on then
                        b.BackgroundTransparency = gs() and 0 or 0.55
                    else
                        b.BackgroundTransparency = 0
                        b.BackgroundColor3 = gs() and C.ACCENT or C.ELEMENT
                    end
                end)
            end
        end
    end
end)

-- Режим редактирования
local editGui = makeGui("ManewareEdit", 99900)
local catcher = new("TextButton", {Size = UDim2.new(1, 0, 1, 0), BackgroundColor3 = Color3.new(0, 0, 0),
    BackgroundTransparency = 0.55, Text = "", AutoButtonColor = false, Visible = false, Active = true,
    BorderSizePixel = 0}, editGui)
new("TextLabel", {Size = UDim2.new(1, -40, 0, 60), Position = UDim2.new(0, 20, 0, 24), BackgroundTransparency = 1,
    Text = "✎ Режим редактирования\nПеретащи элемент • нажми на пустое место — сохранить",
    TextColor3 = C.TEXT, TextSize = 15, Font = Enum.Font.GothamBold, TextWrapped = true}, catcher)

local function editBox(obj, on)
    if obj == X.kfRoot or obj == wmRoot or obj == kbRoot then obj.Active = on and true or false end -- ловит нажатия только в режиме редактирования
    local b = obj:FindFirstChild("MWEditBox")
    if on and not b then
        b = new("Frame", {Name = "MWEditBox", Size = UDim2.new(1, 8, 1, 8), Position = UDim2.new(0, -4, 0, -4),
            BackgroundTransparency = 1, ZIndex = 50, Active = false}, obj)
        new("UIStroke", {Color = Color3.fromRGB(255, 220, 0), Thickness = 2}, b)
        corner(14, b)
    elseif not on and b then
        b:Destroy()
    end
end
local function clearBoxes()
    editBox(fab, false)
    editBox(wmRoot, false)
    editBox(X.kfRoot, false)
    editBox(kbRoot, false)
    for _, b in pairs(bindButtons) do editBox(b, false) end
end

local function exitEdit()
    if not EDIT.mode then return end
    EDIT.mode = nil
    kbSig = ""
    clearBoxes()
    catcher.Visible = false
    saveUI()
    notify("Позиции сохранены")
    if EDIT.reopen then setMenu(true) end
end

local function enterEdit(mode)
    if EDIT.mode then return end
    if mode == "wm" and not (wm.on and wm.style > 0) then
        notify("Сначала включи Watermark (вкладка Watermark)")
        return
    end
    if mode == "binds" and next(bindButtons) == nil then
        notify("Нет биндов: создай их во вкладке Binds")
        return
    end
    EDIT.mode = mode
    EDIT.reopen = menuVisible
    setMenu(false)
    catcher.Visible = true
    if mode == "fab" then
        editBox(fab, true)
    elseif mode == "wm" then
        editBox(wmRoot, true)
    elseif mode == "kf" then
        editBox(X.kfRoot, true)
    elseif mode == "kb" then
        kbSig = ""
        editBox(kbRoot, true)
    else
        for _, b in pairs(bindButtons) do editBox(b, true) end
    end
end

local tapStart = nil
catcher.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
        tapStart = i.Position
    end
end)
catcher.InputEnded:Connect(function(i)
    if tapStart and (i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1) then
        if (i.Position - tapStart).Magnitude < 12 then exitEdit() end -- просто нажатие = закрыть и сохранить
        tapStart = nil
    end
end)

-- Группа слева: Binds (вкладка) + кнопки редактирования + KillFeed
addSideLabel("ИНТЕРФЕЙС", 999)
local tb = addTab("Binds", ICONS.UTIL, 1000)
addSideButton("✎ Кнопка меню", ICONS.MENU, 1001, function() enterEdit("fab") end)
addSideButton("✎ Watermark", ICONS.EYE, 1002, function() enterEdit("wm") end)
addSideButton("✎ Binds", ICONS.UTIL, 1003, function() enterEdit("binds") end)
addSideButton("✎ Keybinds", ICONS.UTIL, 1005, function() enterEdit("kb") end)

local tkf = addTab("KillFeed", ICONS.TARGET, 1004)
tkf.Section("☠ KillFeed")
tkf.Toggle("KillFeed", false, function(v) X.kf.on = v end, ICONS.TARGET)
tkf.Button("✎ Двигать KillFeed", function() enterEdit("kf") end)
tkf.Toggle("Hide Innocent (убит невиновный)", true, function(v) X.kf.hideInn = v end, ICONS.EYE)
tkf.Toggle("Hide Murder (убит убийца)", true, function(v) X.kf.hideMur = v end, ICONS.EYE)
tkf.Toggle("Hide Sheriff (убит шериф)", true, function(v) X.kf.hideShe = v end, ICONS.EYE)

tb.Section("🎛 Bind Tel: кнопка на экране • Bind PC: нажми и затем английскую клавишу")
local bindHolder = tb.Holder()
local bindNames = {}
for name, e in pairs(REG) do
    if e.kind == "toggle" then bindNames[#bindNames + 1] = name end
end
for name in pairs(ACT) do
    if not (name:find("🔄") or name:find("💾") or name:find("✔") or name:find("✎")) then bindNames[#bindNames + 1] = name end
end
table.sort(bindNames)
local pcListening = nil -- {name = ..., btn = ...}
local function pcStopListen()
    if pcListening then
        local btn = pcListening.btn
        pcListening = nil
        pcall(function() btn.Text = "Bind PC" end)
    end
end
for i, name in ipairs(bindNames) do
    local row
    row = addRow(bindHolder, i, name, {
        {text = "Delete", color = C.RED, w = 44, size = 11, fn = function() deleteBind(name) end},
        {text = "Bind Tel", color = C.ACCENT, w = 54, size = 11, fn = function()
            if createBind(name) then
                saveUI()
                notify("Бинды: создан, двигать через ✎ Binds")
            else
                notify("Бинды: бинд уже есть")
            end
        end},
        {text = "Bind PC", color = C.ACCENT, w = 54, size = 11, fn = function()
            local btn
            for _, ch in ipairs(row:GetChildren()) do
                if ch:IsA("TextButton") and (ch.Text == "Bind PC" or ch.Text == "...") then btn = ch end
            end
            if not btn then return end
            if pcListening and pcListening.btn == btn then pcStopListen() return end -- повторный тап = отмена
            pcStopListen()
            pcListening = {name = name, btn = btn}
            btn.Text = "..."
        end},
    })
end

-- ввод с клавиатуры: назначение клавиши (только английские буквы) и запуск функций
UIS.InputBegan:Connect(function(i, gpe)
    if i.UserInputType ~= Enum.UserInputType.Keyboard then return end
    local kn = i.KeyCode.Name
    if not kn:match("^%a$") then return end
    if pcListening then
        local nm = pcListening.name
        for other, k in pairs(pcKeys) do
            if k == kn and other ~= nm then pcKeys[other] = nil end
        end
        pcKeys[nm] = kn
        pcStopListen()
        kbSig = ""
        saveUI()
        notify("Бинды: " .. nm .. " → [" .. kn .. "]")
        return
    end
    if gpe or EDIT.mode then return end
    for name, k in pairs(pcKeys) do
        if k == kn then
            local run = bindInfo(name)
            if run then pcall(run) end
        end
    end
end)

-- панель Keybinds (только ПК): тумблеры видны когда включены, действия - всегда
local function kbRebuild(items)
    for _, ch in ipairs(kbRoot:GetChildren()) do
        if not ch:IsA("UIListLayout") and ch.Name ~= "MWEditBox" then ch:Destroy() end
    end
    local head = new("TextLabel", {Size = UDim2.new(1, 0, 0, 24), BackgroundColor3 = C.ACCENT, BorderSizePixel = 0,
        Text = "Keybinds", TextColor3 = C.TEXT, TextSize = 13, Font = Enum.Font.GothamBold, LayoutOrder = 0}, kbRoot)
    corner(6, head)
    for idx, it in ipairs(items) do
        local r = new("Frame", {Size = UDim2.new(1, 0, 0, 22), BackgroundColor3 = C.BG, BackgroundTransparency = 0.2,
            BorderSizePixel = 0, LayoutOrder = idx}, kbRoot)
        corner(5, r)
        new("TextLabel", {Size = UDim2.new(1, -84, 1, 0), Position = UDim2.new(0, 8, 0, 0), BackgroundTransparency = 1,
            Text = it[1], TextColor3 = C.TEXT, TextSize = 12, Font = Enum.Font.GothamSemibold,
            TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd}, r)
        local stTxt = ""
        local stCol = C.TEXT
        if it[3] == true then stTxt = " on" stCol = C.GREEN elseif it[3] == false then stTxt = " off" stCol = C.RED end
        new("TextLabel", {Size = UDim2.new(0, 76, 1, 0), Position = UDim2.new(1, -82, 0, 0), BackgroundTransparency = 1,
            Text = "[" .. it[2] .. "]" .. stTxt, TextColor3 = stCol, TextSize = 12, Font = Enum.Font.GothamBold,
            TextXAlignment = Enum.TextXAlignment.Right}, r)
    end
end
task.spawn(function()
    while true do
        task.wait(0.2)
        pcall(function()
            local items = {}
            for name, key in pairs(pcKeys) do
                local e = REG[name]
                local st = nil
                if e and e.kind == "toggle" then st = e.get() and true or false end
                items[#items + 1] = {name, key, st}
            end
            table.sort(items, function(a, b) return a[1] < b[1] end)
            if #items == 0 and EDIT.mode == "kb" then items[1] = {"Kill All", "K"} end
            local sig = ""
            for _, it in ipairs(items) do sig = sig .. it[1] .. "|" .. it[2] .. "|" .. tostring(it[3]) .. "," end
            kbRoot.Visible = (isPC or EDIT.mode == "kb") and #items > 0
            if sig ~= kbSig then
                kbSig = sig
                kbRebuild(items)
            end
        end)
    end
end)

if type(uiData.binds) == "table" then
    for name, t in pairs(uiData.binds) do pcall(createBind, name, tblToPos(t)) end
end

-- Gradients: меняем цвета только внутри наших GUI (hub, кнопка, binds, watermark, уведомления)
local THEMES = {
    {name = "mint",
        bg = {Color3.fromRGB(10, 34, 30), Color3.fromRGB(24, 74, 62)},
        side = {Color3.fromRGB(12, 42, 37), Color3.fromRGB(28, 86, 72)},
        top = {Color3.fromRGB(16, 56, 48), Color3.fromRGB(38, 110, 92)},
        el = {Color3.fromRGB(20, 58, 50), Color3.fromRGB(34, 96, 80)},
        acc = {Color3.fromRGB(80, 235, 180), Color3.fromRGB(40, 190, 140)},
        card = Color3.fromRGB(14, 46, 40)},
    {name = "candy",
        bg = {Color3.fromRGB(14, 38, 52), Color3.fromRGB(44, 22, 70)},
        side = {Color3.fromRGB(18, 46, 62), Color3.fromRGB(52, 28, 80)},
        top = {Color3.fromRGB(24, 70, 84), Color3.fromRGB(80, 40, 120)},
        el = {Color3.fromRGB(26, 58, 74), Color3.fromRGB(66, 36, 100)},
        acc = {Color3.fromRGB(64, 224, 208), Color3.fromRGB(170, 90, 255)},
        card = Color3.fromRGB(30, 30, 64)},
    {name = "gray",
        bg = {Color3.fromRGB(36, 36, 40), Color3.fromRGB(86, 86, 94)},
        side = {Color3.fromRGB(44, 44, 50), Color3.fromRGB(96, 96, 104)},
        top = {Color3.fromRGB(60, 60, 66), Color3.fromRGB(128, 128, 138)},
        el = {Color3.fromRGB(58, 58, 64), Color3.fromRGB(112, 112, 122)},
        acc = {Color3.fromRGB(215, 215, 225), Color3.fromRGB(160, 160, 170)},
        card = Color3.fromRGB(50, 50, 56)},
    {name = "blood",
        bg = {Color3.fromRGB(28, 8, 12), Color3.fromRGB(60, 14, 22)},
        side = {Color3.fromRGB(36, 10, 16), Color3.fromRGB(80, 18, 28)},
        top = {Color3.fromRGB(48, 12, 20), Color3.fromRGB(110, 25, 40)},
        el = {Color3.fromRGB(42, 12, 18), Color3.fromRGB(90, 22, 34)},
        acc = {Color3.fromRGB(255, 60, 80), Color3.fromRGB(200, 30, 50)},
        card = Color3.fromRGB(32, 10, 14)},
    {name = "ocean",
        bg = {Color3.fromRGB(6, 20, 40), Color3.fromRGB(10, 50, 90)},
        side = {Color3.fromRGB(8, 28, 52), Color3.fromRGB(14, 60, 110)},
        top = {Color3.fromRGB(12, 40, 70), Color3.fromRGB(20, 80, 140)},
        el = {Color3.fromRGB(10, 34, 60), Color3.fromRGB(18, 70, 120)},
        acc = {Color3.fromRGB(40, 200, 255), Color3.fromRGB(20, 140, 220)},
        card = Color3.fromRGB(8, 24, 48)},
    {name = "sunset",
        bg = {Color3.fromRGB(40, 18, 10), Color3.fromRGB(80, 30, 20)},
        side = {Color3.fromRGB(50, 22, 12), Color3.fromRGB(100, 40, 25)},
        top = {Color3.fromRGB(70, 30, 15), Color3.fromRGB(140, 55, 30)},
        el = {Color3.fromRGB(60, 26, 14), Color3.fromRGB(120, 48, 28)},
        acc = {Color3.fromRGB(255, 140, 50), Color3.fromRGB(255, 80, 40)},
        card = Color3.fromRGB(45, 20, 12)},
    {name = "neon",
        bg = {Color3.fromRGB(8, 8, 18), Color3.fromRGB(20, 10, 40)},
        side = {Color3.fromRGB(12, 12, 28), Color3.fromRGB(30, 15, 55)},
        top = {Color3.fromRGB(20, 15, 40), Color3.fromRGB(50, 25, 90)},
        el = {Color3.fromRGB(18, 14, 36), Color3.fromRGB(40, 22, 70)},
        acc = {Color3.fromRGB(0, 255, 170), Color3.fromRGB(180, 0, 255)},
        card = Color3.fromRGB(14, 10, 28)},
    {name = "gold",
        bg = {Color3.fromRGB(28, 22, 8), Color3.fromRGB(50, 40, 12)},
        side = {Color3.fromRGB(36, 28, 10), Color3.fromRGB(65, 50, 16)},
        top = {Color3.fromRGB(50, 38, 12), Color3.fromRGB(90, 70, 20)},
        el = {Color3.fromRGB(42, 32, 10), Color3.fromRGB(75, 58, 18)},
        acc = {Color3.fromRGB(255, 210, 60), Color3.fromRGB(220, 160, 30)},
        card = Color3.fromRGB(32, 24, 8)},
    {name = "ice",
        bg = {Color3.fromRGB(12, 22, 32), Color3.fromRGB(24, 48, 68)},
        side = {Color3.fromRGB(16, 30, 42), Color3.fromRGB(30, 58, 80)},
        top = {Color3.fromRGB(22, 42, 58), Color3.fromRGB(40, 80, 110)},
        el = {Color3.fromRGB(18, 34, 48), Color3.fromRGB(34, 64, 90)},
        acc = {Color3.fromRGB(160, 230, 255), Color3.fromRGB(80, 180, 240)},
        card = Color3.fromRGB(14, 26, 38)},
    {name = "rose",
        bg = {Color3.fromRGB(32, 12, 22), Color3.fromRGB(60, 20, 40)},
        side = {Color3.fromRGB(40, 14, 28), Color3.fromRGB(75, 25, 50)},
        top = {Color3.fromRGB(55, 18, 36), Color3.fromRGB(100, 35, 65)},
        el = {Color3.fromRGB(48, 16, 32), Color3.fromRGB(85, 28, 55)},
        acc = {Color3.fromRGB(255, 120, 180), Color3.fromRGB(220, 60, 120)},
        card = Color3.fromRGB(36, 14, 26)},
    {name = "toxic",
        bg = {Color3.fromRGB(12, 28, 8), Color3.fromRGB(24, 55, 12)},
        side = {Color3.fromRGB(16, 36, 10), Color3.fromRGB(32, 70, 16)},
        top = {Color3.fromRGB(22, 48, 12), Color3.fromRGB(45, 95, 22)},
        el = {Color3.fromRGB(18, 40, 10), Color3.fromRGB(38, 80, 18)},
        acc = {Color3.fromRGB(120, 255, 40), Color3.fromRGB(60, 200, 20)},
        card = Color3.fromRGB(14, 32, 8)},
}
local BASE = {bg = C.BG, side = C.SIDEBAR, top = C.TOPBAR, el = C.ELEMENT, acc = C.ACCENT}
local WHITE = Color3.new(1, 1, 1)

local function keyOf(c)
    if c == BASE.bg then return "bg" end
    if c == BASE.side then return "side" end
    if c == BASE.top then return "top" end
    if c == BASE.el then return "el" end
    if c == BASE.acc then return "acc" end
    return nil
end

local function themeInst(inst, key, th)
    local pair = th[key]
    inst:SetAttribute("MWK", key)
    inst:SetAttribute("MWT", th.name)
    local g = inst:FindFirstChild("MWGrad")
    local hasText = (inst:IsA("TextButton") or inst:IsA("TextLabel") or inst:IsA("TextBox")) and inst.Text ~= ""
    if hasText then -- градиент перекрасил бы и текст, поэтому у кнопок с текстом - сплошной цвет
        if g then g:Destroy() end
        inst.BackgroundColor3 = pair[1]:Lerp(pair[2], 0.5)
    else
        inst.BackgroundColor3 = WHITE
        if not g then
            g = Instance.new("UIGradient")
            g.Name = "MWGrad"
            g.Rotation = 35
            g.Parent = inst
        end
        g.Color = ColorSequence.new(pair[1], pair[2])
    end
end

local THEME_ROOTS = {hubGui, toggleGui, bindGui, kbGui}

local function scanTheme(th)
    for _, root in ipairs(THEME_ROOTS) do
        for _, inst in ipairs(root:GetDescendants()) do
            if inst:IsA("GuiObject") then
                local k = keyOf(inst.BackgroundColor3)
                if k then
                    themeInst(inst, k, th)
                else
                    local mk = inst:GetAttribute("MWK")
                    if mk and inst:GetAttribute("MWT") ~= th.name then themeInst(inst, mk, th) end
                end
                if inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox") then
                    if inst.TextColor3 == BASE.acc or inst:GetAttribute("MWTX") then
                        inst:SetAttribute("MWTX", true)
                        inst.TextColor3 = th.acc[1]
                    end
                end
            elseif inst:IsA("UIStroke") then
                if inst.Color == BASE.acc or inst:GetAttribute("MWTX") then
                    inst:SetAttribute("MWTX", true)
                    inst.Color = th.acc[1]
                end
            end
        end
    end
    for _, g in ipairs(wmGui:GetDescendants()) do -- рамки watermark
        if g:IsA("UIGradient") and g.Parent and g.Parent:IsA("UIStroke") then
            g.Color = ColorSequence.new(th.acc[1], th.acc[2])
        end
    end
    X.cardColor = th.card
end

local function revertTheme()
    for _, root in ipairs(THEME_ROOTS) do
        for _, inst in ipairs(root:GetDescendants()) do
            if inst:GetAttribute("MWT") then
                local mk = inst:GetAttribute("MWK")
                if mk and BASE[mk] and inst:IsA("GuiObject") then inst.BackgroundColor3 = BASE[mk] end
                local g = inst:FindFirstChild("MWGrad")
                if g then g:Destroy() end
                inst:SetAttribute("MWT", nil)
                inst:SetAttribute("MWK", nil)
            end
            if inst:GetAttribute("MWTX") then
                if inst:IsA("UIStroke") then
                    inst.Color = BASE.acc
                elseif inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox") then
                    inst.TextColor3 = BASE.acc
                end
                inst:SetAttribute("MWTX", nil)
            end
        end
    end
    X.cardColor = nil
    if wm.on then wmRebuild() end -- вернёт исходные цвета рамок watermark
end

X.applyTheme = function()
    if grad.on then pcall(scanTheme, THEMES[grad.sel]) else pcall(revertTheme) end
end
task.spawn(function() -- новые элементы (списки, бинды) подхватываются автоматически
    while true do
        task.wait(1)
        if grad.on then pcall(scanTheme, THEMES[grad.sel]) end
    end
end)

end -- buildUI

local okUI, errUI = pcall(buildUI)
if not okUI then
    warn("[Maneware] ошибка интерфейса: " .. tostring(errUI))
    notify("Ошибка UI: " .. tostring(errUI))
end

print("[Maneware] v11.10 загружен")
-- Принудительно показать меню
pcall(function()
    if hubGui then hubGui.Enabled = true end
    if main then
        main.Visible = true
        main.Size = FULL
        main.Position = UDim2.new(0.5, 0, 0.5, 0)
        main.AnchorPoint = Vector2.new(0.5, 0.5)
    end
    print("[Maneware] hub parent=", hubGui and hubGui.Parent and tostring(hubGui.Parent))
    print("[Maneware] main AbsSize=", main and main.AbsoluteSize)
end)
]==]

local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local statusGuis = {}

local function parents()
    local list = {}
    pcall(function() if gethui then table.insert(list, gethui()) end end)
    pcall(function() table.insert(list, game:GetService("CoreGui")) end)
    local pg = LP:FindFirstChild("PlayerGui")
    if not pg then pcall(function() pg = LP:WaitForChild("PlayerGui", 8) end) end
    if pg then table.insert(list, pg) end
    return list
end

-- плашка статуса рисуется сразу в каждом доступном родителе (где-то да покажется)
local function status(text, kind, ttl)
    for _, g in ipairs(statusGuis) do pcall(function() g:Destroy() end) end
    statusGuis = {}
    local col = kind == "err" and Color3.fromRGB(170, 30, 40)
        or (kind == "ok" and Color3.fromRGB(30, 140, 70) or Color3.fromRGB(70, 80, 200))
    for _, p in ipairs(parents()) do
        pcall(function()
            local g = Instance.new("ScreenGui")
            g.Name = "ManewareStatus"
            g.ResetOnSpawn = false
            g.IgnoreGuiInset = true
            g.DisplayOrder = 2147483647
            local b = Instance.new("TextButton")
            b.AnchorPoint = Vector2.new(0.5, 0)
            b.Position = UDim2.new(0.5, 0, 0, 30)
            b.Size = UDim2.new(0.92, 0, 0, kind == "err" and 260 or 44)
            b.BackgroundColor3 = col
            b.TextColor3 = Color3.new(1, 1, 1)
            b.TextSize = kind == "err" and 14 or 16
            b.Font = Enum.Font.GothamBold
            b.TextWrapped = true
            b.TextXAlignment = Enum.TextXAlignment.Left
            b.TextYAlignment = Enum.TextYAlignment.Top
            b.AutoButtonColor = false
            b.Text = text .. (kind == "err" and "\n\n(тап — скопировать и закрыть)" or "")
            b.Parent = g
            b.Activated:Connect(function()
                if kind == "err" and setclipboard then pcall(setclipboard, text) end
                g:Destroy()
            end)
            pcall(function() if syn and syn.protect_gui then syn.protect_gui(g) end end)
            g.Parent = p
            table.insert(statusGuis, g)
            if ttl then task.delay(ttl, function() pcall(function() g:Destroy() end) end) end
        end)
    end
end

status("Maneware v11.10 (build 10): компиляция…", "info", 3)
local fn, cerr = loadstring(SRC, "=Maneware")
if not fn then
    status("[v11.10, wrap=ON] ОШИБКА КОМПИЛЯЦИИ:\n" .. tostring(cerr), "err")
    warn("[Maneware] compile error: " .. tostring(cerr))
    return
end
status("Maneware v11.10: запуск…", "info", 3)
local ok, err = xpcall(fn, function(e) return tostring(e) .. "\n" .. tostring(debug.traceback()) end)
if not ok then
    status("[v11.10] ОШИБКА ЗАПУСКА:\n" .. tostring(err), "err")
    warn("[Maneware] runtime error: " .. tostring(err))
else
    status("Maneware v11.10 загружен ✔  (кнопка меню справа)", "ok", 5)
end

]=====]

-- ================= GUI =================
local ACC_A = Color3.fromRGB(99, 102, 241)
local ACC_B = Color3.fromRGB(168, 85, 247)
local TXT = Color3.fromRGB(240, 240, 247)
local DIM = Color3.fromRGB(128, 128, 150)

local function make(class, props, parent)
	local o = Instance.new(class)
	for k, v in pairs(props or {}) do o[k] = v end
	if parent then o.Parent = parent end
	return o
end
local function round(r, p) return make("UICorner", {CornerRadius = UDim.new(0, r)}, p) end
local function tween(o, t, props, style)
	local tw = TweenService:Create(o, TweenInfo.new(t, style or Enum.EasingStyle.Quint, Enum.EasingDirection.Out), props)
	tw:Play()
	return tw
end

local gui = make("ScreenGui", {Name = "ManewareLauncher", ResetOnSpawn = false, IgnoreGuiInset = true,
	DisplayOrder = 2147483000, ZIndexBehavior = Enum.ZIndexBehavior.Sibling})
pcall(function() if syn and syn.protect_gui then syn.protect_gui(gui) end end)
gui.Parent = guiParent

local card = make("Frame", {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.5, 0),
	Size = UDim2.fromOffset(340, 262), BackgroundColor3 = Color3.fromRGB(16, 16, 24), BorderSizePixel = 0,
	Active = true}, gui)
round(18, card)
make("UIGradient", {Rotation = 90, Color = ColorSequence.new(Color3.fromRGB(24, 24, 36), Color3.fromRGB(12, 12, 18))}, card)
local scale = make("UIScale", {Scale = 0.8}, card)
local stroke = make("UIStroke", {Thickness = 2, Color = Color3.new(1, 1, 1), ApplyStrokeMode = Enum.ApplyStrokeMode.Border}, card)
local strokeGrad = make("UIGradient", {Color = ColorSequence.new(ACC_A, ACC_B)}, stroke)

-- логотип
local logo = make("Frame", {AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 22),
	Size = UDim2.fromOffset(54, 54), BackgroundColor3 = Color3.new(1, 1, 1), BorderSizePixel = 0}, card)
round(16, logo)
make("UIGradient", {Rotation = 45, Color = ColorSequence.new(ACC_A, ACC_B)}, logo)
make("TextLabel", {Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, Text = "M", Font = Enum.Font.GothamBlack,
	TextSize = 30, TextColor3 = Color3.new(1, 1, 1)}, logo)

make("TextLabel", {Position = UDim2.new(0, 0, 0, 84), Size = UDim2.new(1, 0, 0, 30), BackgroundTransparency = 1,
	Text = "Maneware Hub", Font = Enum.Font.GothamBold, TextSize = 26, TextColor3 = TXT}, card)
make("TextLabel", {Position = UDim2.new(0, 0, 0, 114), Size = UDim2.new(1, 0, 0, 18), BackgroundTransparency = 1,
	Text = "Выбери игру для запуска", Font = Enum.Font.Gotham, TextSize = 13, TextColor3 = DIM}, card)

local line = make("Frame", {AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 144),
	Size = UDim2.new(1, -40, 0, 1), BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 0.6, BorderSizePixel = 0}, card)
make("UIGradient", {Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, 0),
	NumberSequenceKeypoint.new(1, 1)}), Color = ColorSequence.new(ACC_A, ACC_B)}, line)

-- закрыть
local close = make("TextButton", {AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -12, 0, 12),
	Size = UDim2.fromOffset(28, 28), BackgroundColor3 = Color3.fromRGB(34, 34, 48), Text = "✕", Font = Enum.Font.GothamBold,
	TextSize = 13, TextColor3 = DIM, AutoButtonColor = false, BorderSizePixel = 0}, card)
round(14, close)

local launching = false
local rsConn

local function launch(kind)
	if launching then return end
	launching = true
	tween(scale, 0.16, {Scale = 0.85})
	task.wait(0.16)
	pcall(function() if rsConn then rsConn:Disconnect() end end)
	gui:Destroy()
	if kind == "close" then return end
	env.__MW_NL_SRC = NL_LIB
	local src, name = SRC_MM2, "ManewareMM2"
	local fn, err = loadstring(src, "=" .. name)
	if not fn then
		warn("[Maneware Hub] compile error (" .. name .. "): " .. tostring(err))
		return
	end
	local ok, e = xpcall(fn, function(m) return tostring(m) .. "\n" .. tostring(debug.traceback()) end)
	if not ok then warn("[Maneware Hub] runtime error (" .. name .. "): " .. tostring(e)) end
end

close.Activated:Connect(function() launch("close") end)

local function gameButton(y, icon, title, sub, color, kind)
	local b = make("TextButton", {Position = UDim2.new(0, 20, 0, y), Size = UDim2.new(1, -40, 0, 68),
		BackgroundColor3 = Color3.fromRGB(26, 26, 38), Text = "", AutoButtonColor = false, BorderSizePixel = 0}, card)
	round(14, b)
	local s = make("UIStroke", {Color = Color3.fromRGB(48, 48, 68), Thickness = 1.5}, b)
	local bar = make("Frame", {Position = UDim2.new(0, 0, 0.5, -16), Size = UDim2.fromOffset(4, 32),
		BackgroundColor3 = color, BorderSizePixel = 0}, b)
	round(2, bar)
	local ib = make("Frame", {Position = UDim2.new(0, 16, 0.5, -22), Size = UDim2.fromOffset(44, 44),
		BackgroundColor3 = color, BackgroundTransparency = 0.8, BorderSizePixel = 0}, b)
	round(12, ib)
	make("TextLabel", {Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, Text = icon, TextSize = 22,
		Font = Enum.Font.GothamBold, TextColor3 = TXT}, ib)
	make("TextLabel", {Position = UDim2.new(0, 72, 0, 13), Size = UDim2.new(1, -110, 0, 22), BackgroundTransparency = 1,
		Text = title, Font = Enum.Font.GothamBold, TextSize = 18, TextColor3 = TXT, TextXAlignment = Enum.TextXAlignment.Left}, b)
	make("TextLabel", {Position = UDim2.new(0, 72, 0, 36), Size = UDim2.new(1, -110, 0, 18), BackgroundTransparency = 1,
		Text = sub, Font = Enum.Font.Gotham, TextSize = 12, TextColor3 = DIM, TextXAlignment = Enum.TextXAlignment.Left}, b)
	local arrow = make("TextLabel", {AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -16, 0.5, 0),
		Size = UDim2.fromOffset(24, 30), BackgroundTransparency = 1, Text = "›", Font = Enum.Font.GothamBold,
		TextSize = 30, TextColor3 = DIM}, b)
	b.MouseEnter:Connect(function()
		tween(b, 0.18, {BackgroundColor3 = Color3.fromRGB(34, 34, 50)})
		tween(s, 0.18, {Color = color})
		tween(arrow, 0.18, {TextColor3 = color, Position = UDim2.new(1, -10, 0.5, 0)})
	end)
	b.MouseLeave:Connect(function()
		tween(b, 0.18, {BackgroundColor3 = Color3.fromRGB(26, 26, 38)})
		tween(s, 0.18, {Color = Color3.fromRGB(48, 48, 68)})
		tween(arrow, 0.18, {TextColor3 = DIM, Position = UDim2.new(1, -16, 0.5, 0)})
	end)
	b.Activated:Connect(function() launch(kind) end)
	return b
end

gameButton(160, "🔪", "MM2", "Murder Mystery 2", ACC_A, "mm2")

make("TextLabel", {AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -10), Size = UDim2.new(1, -20, 0, 16),
	BackgroundTransparency = 1, Text = "Insert / RightCtrl — открыть и закрыть меню", Font = Enum.Font.Gotham,
	TextSize = 11, TextColor3 = Color3.fromRGB(90, 90, 112)}, card)

-- перетаскивание за карточку
do
	local dragging, dragStart, startPos
	card.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
			dragging, dragStart, startPos = true, i.Position, card.Position
			i.Changed:Connect(function()
				if i.UserInputState == Enum.UserInputState.End then dragging = false end
			end)
		end
	end)
	UIS.InputChanged:Connect(function(i)
		if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
			local d = i.Position - dragStart
			card.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
		end
	end)
end

-- плавное появление и бегущий градиент рамки
tween(scale, 0.4, {Scale = 1}, Enum.EasingStyle.Back)
rsConn = RunService.RenderStepped:Connect(function()
	strokeGrad.Rotation = (os.clock() * 90) % 360
end)
