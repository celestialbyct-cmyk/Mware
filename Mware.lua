-- LocalScript → StarterPlayer > StarterPlayerScripts
-- Открыть/закрыть меню: RightControl
-- ПКМ по модулю  = настройки
-- СКМ по модулю  = забиндить клавишу (Esc / Backspace = убрать бинд)
-- ЛКМ по модулю  = вкл/выкл (только визуально)
-- Interface -> настройка "Keybinds" показывает окошко с биндами

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
Осталось watermark и themes и все это элементы худа
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local TOGGLE_KEY = Enum.KeyCode.RightControl

local categories = {
	{ "Combat", { "Anti Bot", "Auto Armor", "Auto Explosion", "Auto Swap", "Auto Totem", "Crystal Spammer", "CrystalAura", "KillAura", "No Friend Damage", "Trigger Bot", "Velocity" } },
	{ "Movement", { "Air Stuck", "Dog Fly", "Elytra Motion", "ElytraBooster", "ElytraFlight", "Gui Move", "No Jump Delay", "No Slow", "No Web", "Speed", "Sprint" } },
	{ "Render", { "Client Sounds", "Fire Fly", "Full Bright", "Interface", "Kill Effect", "Predictions", "Removals", "Soul ESP", "Swing Animations", "Tags", "Target ESP", "Third Person", "Tracers", "Trails" } },
	{ "Player", { "Auto Eat", "Auto Leave", "Auto Tool", "Auto Tpaccept", "Click Pearl", "Death Coords", "Elytra Helper", "Fast Exp", "Free Camera", "No Push", "Tape Mouse", "Teleport Back" } },
	{ "Misc", { "Crystal Optimizer", "Discord RPC", "Fake Player", "Lony Helper", "RP Spoofer", "Streamer Mode", "UseTracker" } },
}

local FONT = Enum.Font.GothamMedium
local COL_OFF = Color3.fromRGB(28, 28, 30)
local COL_HOVER = Color3.fromRGB(40, 40, 44)
local COL_ON = Color3.fromRGB(70, 70, 85)

local modules, byName = {}, {}
local refreshHud -- объявлено заранее

local function keyText(kc)
	local digits = { Zero = "0", One = "1", Two = "2", Three = "3", Four = "4", Five = "5", Six = "6", Seven = "7", Eight = "8", Nine = "9" }
	if digits[kc.Name] then return digits[kc.Name] end
	if #kc.Name == 1 then return kc.Name:upper() end
	return kc.Name
end

-- ===================== Окошко Keybinds (HUD) =====================
local hudGui = Instance.new("ScreenGui")
hudGui.Name = "KeybindsHud"
hudGui.ResetOnSpawn = false
hudGui.IgnoreGuiInset = true
hudGui.DisplayOrder = 90
hudGui.Enabled = false
hudGui.Parent = playerGui

local hud = Instance.new("Frame")
hud.Position = UDim2.fromOffset(20, 260)
hud.Size = UDim2.fromOffset(150, 0)
hud.AutomaticSize = Enum.AutomaticSize.Y
hud.BackgroundColor3 = Color3.fromRGB(24, 22, 28)
hud.BackgroundTransparency = 0.05
hud.ClipsDescendants = true
hud.Parent = hudGui
Instance.new("UICorner", hud).CornerRadius = UDim.new(0, 8)
local hudLayout = Instance.new("UIListLayout", hud)
hudLayout.SortOrder = Enum.SortOrder.LayoutOrder

local hudHeader = Instance.new("TextLabel")
hudHeader.LayoutOrder = 0
hudHeader.Size = UDim2.new(1, 0, 0, 28)
hudHeader.BackgroundColor3 = Color3.new(1, 1, 1)
hudHeader.Font = Enum.Font.GothamBold
hudHeader.TextSize = 16
hudHeader.TextColor3 = Color3.new(1, 1, 1)
hudHeader.Text = "Keybinds"
hudHeader.Parent = hud
local hudGrad = Instance.new("UIGradient", hudHeader)

local RED = ColorSequence.new(Color3.fromRGB(235, 40, 50), Color3.fromRGB(150, 15, 30))
local PURPLE = ColorSequence.new(Color3.fromRGB(70, 90, 255), Color3.fromRGB(160, 60, 230))

local function hudRow(order, nameText, keyStr, empty)
	local row = Instance.new("Frame")
	row.Name = "Row"
	row.LayoutOrder = order
	row.Size = UDim2.new(1, 0, 0, 26)
	row.BackgroundTransparency = 1
	row.Parent = hud

	local l = Instance.new("TextLabel")
	l.BackgroundTransparency = 1
	l.Size = UDim2.new(empty and 1 or 0.65, empty and 0 or -8, 1, 0)
	l.Position = UDim2.fromOffset(empty and 0 or 8, 0)
	l.Font = Enum.Font.GothamBold
	l.TextSize = 14
	l.TextXAlignment = empty and Enum.TextXAlignment.Center or Enum.TextXAlignment.Left
	l.TextColor3 = empty and Color3.fromRGB(255, 200, 30) or Color3.fromRGB(240, 240, 240)
	l.Text = nameText
	l.Parent = row

	if keyStr then
		local k = Instance.new("TextLabel")
		k.BackgroundTransparency = 1
		k.AnchorPoint = Vector2.new(1, 0)
		k.Position = UDim2.new(1, -8, 0, 0)
		k.Size = UDim2.new(0.35, 0, 1, 0)
		k.Font = Enum.Font.GothamBold
		k.TextSize = 14
		k.TextXAlignment = Enum.TextXAlignment.Right
		k.TextColor3 = Color3.fromRGB(220, 220, 225)
		k.Text = "[" .. keyStr .. "]"
		k.Parent = row
	end
end

-- ---------- Стиль 2: Hotkeys ----------
local hud2Gui = Instance.new("ScreenGui")
hud2Gui.Name = "HotkeysHud"
hud2Gui.ResetOnSpawn = false
hud2Gui.IgnoreGuiInset = true
hud2Gui.DisplayOrder = 90
hud2Gui.Enabled = false
hud2Gui.Parent = playerGui

local hud2 = Instance.new("Frame")
hud2.Position = UDim2.fromOffset(200, 260)
hud2.Size = UDim2.fromOffset(170, 0)
hud2.AutomaticSize = Enum.AutomaticSize.Y
hud2.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
hud2.BackgroundTransparency = 0.1
hud2.ClipsDescendants = true
hud2.Parent = hud2Gui
Instance.new("UICorner", hud2).CornerRadius = UDim.new(0, 8)
local hud2Layout = Instance.new("UIListLayout", hud2)
hud2Layout.SortOrder = Enum.SortOrder.LayoutOrder

local h2Header = Instance.new("Frame")
h2Header.LayoutOrder = 0
h2Header.Size = UDim2.new(1, 0, 0, 32)
h2Header.BackgroundTransparency = 1
h2Header.Parent = hud2

-- иконка клавиатуры (рисуем из рамок)
local icon = Instance.new("Frame")
icon.Position = UDim2.fromOffset(10, 9)
icon.Size = UDim2.fromOffset(22, 14)
icon.BackgroundTransparency = 1
icon.Parent = h2Header
Instance.new("UICorner", icon).CornerRadius = UDim.new(0, 3)
local iconStroke = Instance.new("UIStroke", icon)
iconStroke.Color = Color3.fromRGB(235, 235, 240)
iconStroke.Thickness = 1.5
for _, x in ipairs({ 4, 9, 14 }) do
	local d = Instance.new("Frame")
	d.Position = UDim2.fromOffset(x, 3)
	d.Size = UDim2.fromOffset(3, 3)
	d.BackgroundColor3 = Color3.fromRGB(235, 235, 240)
	d.BorderSizePixel = 0
	d.Parent = icon
end
local spaceBar = Instance.new("Frame")
spaceBar.Position = UDim2.fromOffset(5, 8)
spaceBar.Size = UDim2.fromOffset(12, 2)
spaceBar.BackgroundColor3 = Color3.fromRGB(235, 235, 240)
spaceBar.BorderSizePixel = 0
spaceBar.Parent = icon

local divider = Instance.new("Frame")
divider.Position = UDim2.fromOffset(42, 6)
divider.Size = UDim2.fromOffset(1, 20)
divider.BackgroundColor3 = Color3.fromRGB(90, 90, 98)
divider.BorderSizePixel = 0
divider.Parent = h2Header

local h2Title = Instance.new("TextLabel")
h2Title.BackgroundTransparency = 1
h2Title.Position = UDim2.fromOffset(52, 0)
h2Title.Size = UDim2.new(1, -58, 1, 0)
h2Title.Font = Enum.Font.GothamBold
h2Title.TextSize = 15
h2Title.TextXAlignment = Enum.TextXAlignment.Left
h2Title.TextColor3 = Color3.new(1, 1, 1)
h2Title.Text = "Hotkeys"
h2Title.Parent = h2Header

local function hud2Row(order, nameText, keyStr)
	local row = Instance.new("Frame")
	row.Name = "Row"
	row.LayoutOrder = order
	row.Size = UDim2.new(1, 0, 0, 24)
	row.BackgroundTransparency = 1
	row.Parent = hud2

	local l = Instance.new("TextLabel")
	l.BackgroundTransparency = 1
	l.Position = UDim2.fromOffset(10, 0)
	l.Size = UDim2.new(0.7, -10, 1, 0)
	l.Font = FONT
	l.TextSize = 14
	l.TextXAlignment = Enum.TextXAlignment.Left
	l.TextColor3 = Color3.fromRGB(215, 215, 220)
	l.Text = nameText
	l.Parent = row

	local k = Instance.new("TextLabel")
	k.BackgroundTransparency = 1
	k.AnchorPoint = Vector2.new(1, 0)
	k.Position = UDim2.new(1, -10, 0, 0)
	k.Size = UDim2.new(0.3, 0, 1, 0)
	k.Font = FONT
	k.TextSize = 14
	k.TextXAlignment = Enum.TextXAlignment.Right
	k.TextColor3 = Color3.fromRGB(215, 215, 220)
	k.Text = keyStr
	k.Parent = row
end

-- ---------- TargetHUD (3 стиля) ----------
local RunService = game:GetService("RunService")

local thGui = Instance.new("ScreenGui")
thGui.Name = "TargetHud"
thGui.ResetOnSpawn = false
thGui.IgnoreGuiInset = true
thGui.DisplayOrder = 91
thGui.Parent = playerGui

local th = nil          -- текущая карточка
local thStyle = nil
local thTarget = nil    -- Player
local thHum = nil       -- Humanoid
local thShown = 0
local thLastSeen = -1
local avatarCache = {}

local function loadAvatar(userId, img)
	if avatarCache[userId] then
		img.Image = avatarCache[userId]
		return
	end
	task.spawn(function()
		local ok, content = pcall(function()
			return Players:GetUserThumbnailAsync(userId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
		end)
		if ok and content then
			avatarCache[userId] = content
			if img.Parent then img.Image = content end
		end
	end)
end

local function thLabel(parent, pos, size, text, ts, font, color)
	local l = Instance.new("TextLabel")
	l.BackgroundTransparency = 1
	l.Position = pos
	l.Size = size
	l.Font = font
	l.TextSize = ts
	l.TextXAlignment = Enum.TextXAlignment.Left
	l.TextColor3 = color
	l.Text = text
	l.Parent = parent
	return l
end

local function buildTargetHud(style)
	local f = Instance.new("Frame")
	f.Name = "Card"
	f.AnchorPoint = Vector2.new(0.5, 0)
	f.Position = UDim2.new(0.5, 160, 0.5, 40)
	f.Size = UDim2.fromOffset(240, 70)
	f.Visible = false
	f.Parent = thGui

	local stroke = Instance.new("UIStroke", f)
	local corner = Instance.new("UICorner", f)

	local avatar = Instance.new("ImageLabel")
	avatar.BackgroundColor3 = Color3.fromRGB(40, 40, 46)
	avatar.Image = ""
	avatar.Parent = f
	local avCorner = Instance.new("UICorner", avatar)

	local track = Instance.new("Frame")
	track.Parent = f
	Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0)
	local fill = Instance.new("Frame")
	fill.Size = UDim2.fromScale(1, 1)
	fill.Parent = track
	Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)

	local name, hp

	if style == 1 then
		-- Targethud 1: тёмная плашка, аватар-круг справа, зелёный бар
		f.BackgroundColor3 = Color3.fromRGB(14, 14, 18)
		f.BackgroundTransparency = 0.2
		corner.CornerRadius = UDim.new(0, 14)
		stroke.Color = Color3.fromRGB(70, 70, 78)
		stroke.Transparency = 0.5

		avatar.AnchorPoint = Vector2.new(1, 0.5)
		avatar.Position = UDim2.new(1, -12, 0.5, 0)
		avatar.Size = UDim2.fromOffset(48, 48)
		avCorner.CornerRadius = UDim.new(1, 0)
		local ring = Instance.new("UIStroke", avatar)
		ring.Color = Color3.fromRGB(210, 210, 215)
		ring.Thickness = 2

		name = thLabel(f, UDim2.fromOffset(14, 6), UDim2.new(1, -80, 0, 20), "", 15, Enum.Font.GothamMedium, Color3.new(1, 1, 1))
		hp = thLabel(f, UDim2.fromOffset(14, 26), UDim2.new(1, -80, 0, 18), "", 14, Enum.Font.Gotham, Color3.fromRGB(225, 225, 230))
		track.Position = UDim2.fromOffset(14, 52)
		track.Size = UDim2.new(1, -84, 0, 8)
		track.BackgroundColor3 = Color3.fromRGB(30, 34, 30)
		fill.BackgroundColor3 = Color3.fromRGB(60, 220, 70)

	elseif style == 2 then
		-- Targethud 2: красноватая плашка, красный бар
		f.BackgroundColor3 = Color3.fromRGB(48, 18, 26)
		f.BackgroundTransparency = 0.1
		corner.CornerRadius = UDim.new(0, 10)
		stroke.Color = Color3.fromRGB(180, 55, 75)
		stroke.Transparency = 0.2

		avatar.Position = UDim2.fromOffset(8, 9)
		avatar.Size = UDim2.fromOffset(52, 52)
		avCorner.CornerRadius = UDim.new(0, 6)

		name = thLabel(f, UDim2.fromOffset(68, 6), UDim2.new(1, -76, 0, 20), "", 16, Enum.Font.GothamBold, Color3.new(1, 1, 1))
		hp = thLabel(f, UDim2.fromOffset(68, 26), UDim2.new(1, -76, 0, 18), "", 14, Enum.Font.GothamMedium, Color3.fromRGB(235, 225, 228))
		track.Position = UDim2.fromOffset(68, 48)
		track.Size = UDim2.new(1, -78, 0, 12)
		track.BackgroundColor3 = Color3.fromRGB(80, 12, 24)
		fill.BackgroundColor3 = Color3.fromRGB(215, 25, 45)

	else
		-- Targethud 3: тёмная плашка, аватар-квадрат слева, зелёный бар
		f.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
		f.BackgroundTransparency = 0.15
		corner.CornerRadius = UDim.new(0, 10)
		stroke.Color = Color3.fromRGB(70, 70, 78)
		stroke.Transparency = 0.4

		avatar.Position = UDim2.fromOffset(8, 9)
		avatar.Size = UDim2.fromOffset(52, 52)
		avCorner.CornerRadius = UDim.new(0, 6)

		name = thLabel(f, UDim2.fromOffset(68, 6), UDim2.new(1, -76, 0, 20), "", 16, Enum.Font.GothamBold, Color3.new(1, 1, 1))
		hp = thLabel(f, UDim2.fromOffset(68, 26), UDim2.new(1, -76, 0, 18), "", 14, Enum.Font.GothamMedium, Color3.fromRGB(225, 225, 230))
		track.Position = UDim2.fromOffset(68, 48)
		track.Size = UDim2.new(1, -78, 0, 12)
		track.BackgroundColor3 = Color3.fromRGB(18, 60, 22)
		fill.BackgroundColor3 = Color3.fromRGB(50, 220, 60)
	end

	return { frame = f, name = name, hp = hp, fill = fill, avatar = avatar }
end

-- кто под прицелом / шифтлоком / курсором
local rayParams = RaycastParams.new()
rayParams.FilterType = Enum.RaycastFilterType.Exclude

local function getTarget()
	local cam = workspace.CurrentCamera
	if not cam then return nil end
	local char = player.Character
	rayParams.FilterDescendantsInstances = char and { char } or {}

	local loc = UIS:GetMouseLocation() -- в шифтлуке/от первого лица это центр экрана
	local ray = cam:ViewportPointToRay(loc.X, loc.Y)
	local res = workspace:Raycast(ray.Origin, ray.Direction * 1000, rayParams)
	if res then
		local model = res.Instance:FindFirstAncestorOfClass("Model")
		if model then
			local pl = Players:GetPlayerFromCharacter(model)
			local hum = model:FindFirstChildOfClass("Humanoid")
			if pl and hum then return pl, hum end
		end
	end
	return nil
end

RunService.Heartbeat:Connect(function()
	local iface = byName["Interface"]
	local style = nil
	if iface and iface.on then
		for i = 1, 3 do
			if iface.settings["TargetHud" .. i] then
				style = i
				break
			end
		end
	end

	if style ~= thStyle then
		if th then th.frame:Destroy() end
		th = style and buildTargetHud(style) or nil
		thStyle = style
		thTarget = nil
	end
	if not th then return end

	local pl, hum = getTarget()
	if pl then
		thLastSeen = os.clock()
		if pl ~= thTarget then
			thTarget = pl
			thShown = hum.Health
			th.name.Text = pl.Name
			th.avatar.Image = ""
			loadAvatar(pl.UserId, th.avatar)
		end
		thHum = hum
	end

	local show = thTarget ~= nil and thHum ~= nil and thHum.Parent ~= nil and (os.clock() - thLastSeen) < 0.2
	th.frame.Visible = show
	if show then
		local maxHp = math.max(thHum.MaxHealth, 1)
		local hp = math.clamp(thHum.Health, 0, maxHp)
		thShown = thShown + (hp - thShown) * 0.25
		th.fill.Size = UDim2.new(math.clamp(thShown / maxHp, 0, 1), 0, 1, 0)
		th.hp.Text = string.format("HP: %.1f", hp)
	end
end)

refreshHud = function()
	local iface = byName["Interface"]
	local ifaceOn = iface ~= nil and iface.on
	hudGui.Enabled = ifaceOn and iface.settings.Keybinds == true
	hud2Gui.Enabled = ifaceOn and iface.settings.Keybinds2 == true

	for _, c in ipairs(hud:GetChildren()) do
		if c.Name == "Row" then c:Destroy() end
	end
	for _, c in ipairs(hud2:GetChildren()) do
		if c.Name == "Row" then c:Destroy() end
	end

	local n = 0
	for _, m in ipairs(modules) do
		if m.key then
			n += 1
			hudRow(n, m.name, keyText(m.key), false)
			hud2Row(n, m.name, keyText(m.key))
		end
	end
	if n == 0 then
		hudRow(1, "No active binds", nil, true)
		-- у стиля 2 без биндов остаётся только шапка
	end
	hudGrad.Color = PURPLE
end

-- ===================== Главное меню =====================
local gui = Instance.new("ScreenGui")
gui.Name = "ClickGui"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 100
gui.Enabled = false
gui.Parent = playerGui

local root = Instance.new("Frame")
root.AnchorPoint = Vector2.new(0.5, 0.5)
root.Position = UDim2.fromScale(0.5, 0.5)
root.Size = UDim2.fromOffset(1090, 520)
root.BackgroundTransparency = 1
root.Parent = gui

local scale = Instance.new("UIScale", root)
local function updateScale()
	local vp = workspace.CurrentCamera.ViewportSize
	scale.Scale = math.clamp(math.min(vp.X / 1150, vp.Y / 600), 0.5, 1.5)
end
updateScale()
workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(updateScale)

-- ===================== Попап настроек (ПКМ) =====================
local popup = Instance.new("Frame")
popup.Name = "Settings"
popup.Visible = false
popup.ZIndex = 50
popup.Size = UDim2.fromOffset(210, 0)
popup.AutomaticSize = Enum.AutomaticSize.Y
popup.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
popup.BackgroundTransparency = 0.05
popup.Parent = root
Instance.new("UICorner", popup).CornerRadius = UDim.new(0, 10)
local pst = Instance.new("UIStroke", popup)
pst.Color = Color3.fromRGB(80, 80, 90)
pst.Transparency = 0.3
local ppad = Instance.new("UIPadding", popup)
ppad.PaddingTop = UDim.new(0, 8)
ppad.PaddingBottom = UDim.new(0, 8)
ppad.PaddingLeft = UDim.new(0, 8)
ppad.PaddingRight = UDim.new(0, 8)
local pl = Instance.new("UIListLayout", popup)
pl.Padding = UDim.new(0, 6)
pl.SortOrder = Enum.SortOrder.LayoutOrder

local function clearPopup()
	for _, c in ipairs(popup:GetChildren()) do
		if c:IsA("GuiObject") then c:Destroy() end
	end
end

local function popLabel(order, text, size, color, bold)
	local l = Instance.new("TextLabel")
	l.LayoutOrder = order
	l.Size = UDim2.new(1, 0, 0, size + 6)
	l.BackgroundTransparency = 1
	l.Font = bold and Enum.Font.GothamBold or FONT
	l.TextSize = size
	l.TextColor3 = color
	l.TextXAlignment = Enum.TextXAlignment.Left
	l.Text = text
	l.ZIndex = 51
	l.Parent = popup
	return l
end

local function openSettings(m)
	clearPopup()
	popLabel(0, m.name, 15, Color3.new(1, 1, 1), true)

	local order = 1
	if m.name == "Interface" then
		local boxes = {}
		local function paintAll()
			for key, box in pairs(boxes) do
				box.BackgroundColor3 = m.settings[key] and Color3.fromRGB(110, 90, 255) or Color3.fromRGB(55, 55, 62)
			end
		end

		local function addToggle(key, text, group)
			local row = Instance.new("TextButton")
			row.LayoutOrder = order
			row.Size = UDim2.new(1, 0, 0, 28)
			row.BackgroundColor3 = Color3.fromRGB(32, 32, 38)
			row.AutoButtonColor = false
			row.Text = ""
			row.ZIndex = 51
			row.Parent = popup
			Instance.new("UICorner", row).CornerRadius = UDim.new(0, 6)

			local t = Instance.new("TextLabel")
			t.BackgroundTransparency = 1
			t.Position = UDim2.fromOffset(8, 0)
			t.Size = UDim2.new(1, -40, 1, 0)
			t.Font = FONT
			t.TextSize = 14
			t.TextXAlignment = Enum.TextXAlignment.Left
			t.TextColor3 = Color3.fromRGB(220, 220, 225)
			t.Text = text
			t.ZIndex = 52
			t.Parent = row

			local box = Instance.new("Frame")
			box.AnchorPoint = Vector2.new(1, 0.5)
			box.Position = UDim2.new(1, -8, 0.5, 0)
			box.Size = UDim2.fromOffset(18, 18)
			box.ZIndex = 52
			box.Parent = row
			Instance.new("UICorner", box).CornerRadius = UDim.new(0, 4)
			boxes[key] = box

			row.MouseButton1Click:Connect(function()
				local new = not m.settings[key]
				-- стили взаимоисключающие
				for _, k in ipairs(group) do m.settings[k] = false end
				m.settings[key] = new
				paintAll()
				refreshHud()
			end)
			order += 1
		end

		local kbGroup = { "Keybinds", "Keybinds2" }
		local thGroup = { "TargetHud1", "TargetHud2", "TargetHud3" }

		popLabel(order, "Keybinds", 12, Color3.fromRGB(150, 150, 160), false)
		order += 1
		addToggle("Keybinds", "Keybinds", kbGroup)
		addToggle("Keybinds2", "Keybinds 2", kbGroup)

		popLabel(order, "TargetHUD", 12, Color3.fromRGB(150, 150, 160), false)
		order += 1
		addToggle("TargetHud1", "Targethud 1", thGroup)
		addToggle("TargetHud2", "Targethud 2", thGroup)
		addToggle("TargetHud3", "Targethud 3", thGroup)
		paintAll()
	else
		popLabel(order, "Нет настроек", 13, Color3.fromRGB(150, 150, 155), false)
		order += 1
	end

	popLabel(order, "Бинд: " .. (m.key and ("[" .. keyText(m.key) .. "]") or "нет") .. "  (СКМ)", 12, Color3.fromRGB(150, 150, 160), false)

	-- позиция у курсора
	local mp = UIS:GetMouseLocation()
	local rel = (mp - root.AbsolutePosition) / scale.Scale
	popup.Position = UDim2.fromOffset(rel.X + 6, rel.Y + 6)
	popup.Visible = true
end

-- ===================== Кнопка модуля =====================
local bindingModule = nil

local function setOn(m, v)
	m.on = v
	TweenService:Create(m.btn, TweenInfo.new(0.15), { BackgroundColor3 = v and COL_ON or COL_OFF }):Play()
	m.label.TextColor3 = v and Color3.new(1, 1, 1) or Color3.fromRGB(200, 200, 205)
	refreshHud()
end

local function updateTag(m)
	if bindingModule == m then
		m.tag.Text = "..."
	elseif m.key then
		m.tag.Text = "[" .. keyText(m.key) .. "]"
	else
		m.tag.Text = ""
	end
end

local function makeModule(parent, name)
	local m = { name = name, on = false, key = nil, settings = {} }
	if name == "Interface" then m.settings.Keybinds = true; m.settings.Keybinds2 = false; m.settings.TargetHud1 = false; m.settings.TargetHud2 = false; m.settings.TargetHud3 = false end

	local btn = Instance.new("TextButton")
	btn.Name = name
	btn.Size = UDim2.new(1, -10, 0, 30)
	btn.BackgroundColor3 = COL_OFF
	btn.BackgroundTransparency = 0.15
	btn.AutoButtonColor = false
	btn.Text = ""
	btn.Parent = parent
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 7)
	local s = Instance.new("UIStroke", btn)
	s.Color = Color3.fromRGB(60, 60, 64)
	s.Transparency = 0.4

	local label = Instance.new("TextLabel")
	label.BackgroundTransparency = 1
	label.Position = UDim2.fromOffset(10, 0)
	label.Size = UDim2.new(1, -75, 1, 0)
	label.Font = FONT
	label.TextSize = 14
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.TextColor3 = Color3.fromRGB(200, 200, 205)
	label.Text = name
	label.Parent = btn

	local tag = Instance.new("TextLabel")
	tag.BackgroundTransparency = 1
	tag.AnchorPoint = Vector2.new(1, 0.5)
	tag.Position = UDim2.new(1, -30, 0.5, 0)
	tag.Size = UDim2.fromOffset(40, 20)
	tag.Font = Enum.Font.GothamBold
	tag.TextSize = 12
	tag.TextXAlignment = Enum.TextXAlignment.Right
	tag.TextColor3 = Color3.fromRGB(140, 130, 255)
	tag.Text = ""
	tag.Parent = btn

	local dots = Instance.new("TextLabel") -- не кнопка, чтобы ПКМ/СКМ шли в btn
	dots.BackgroundTransparency = 1
	dots.AnchorPoint = Vector2.new(1, 0.5)
	dots.Position = UDim2.new(1, -6, 0.5, 0)
	dots.Size = UDim2.fromOffset(24, 22)
	dots.Font = Enum.Font.GothamBold
	dots.TextSize = 14
	dots.TextColor3 = Color3.fromRGB(170, 170, 175)
	dots.Text = "···"
	dots.Parent = btn

	m.btn, m.label, m.tag = btn, label, tag

	-- ЛКМ: вкл/выкл (визуально)
	btn.MouseButton1Click:Connect(function()
		setOn(m, not m.on)
	end)

	-- ПКМ: настройки
	btn.MouseButton2Click:Connect(function()
		openSettings(m)
	end)

	-- СКМ: бинд
	btn.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton3 then
			if bindingModule then
				local old = bindingModule
				bindingModule = nil
				updateTag(old)
			end
			bindingModule = m
			updateTag(m)
		end
	end)

	btn.MouseEnter:Connect(function()
		if not m.on then btn.BackgroundColor3 = COL_HOVER end
	end)
	btn.MouseLeave:Connect(function()
		if not m.on then btn.BackgroundColor3 = COL_OFF end
	end)

	table.insert(modules, m)
	byName[name] = m
	return m
end

local function makeColumn(index, title, names)
	local col = Instance.new("Frame")
	col.Name = title
	col.Size = UDim2.fromOffset(205, 480)
	col.Position = UDim2.fromOffset((index - 1) * 221, 0)
	col.BackgroundColor3 = Color3.fromRGB(18, 16, 14)
	col.BackgroundTransparency = 0.12
	col.Parent = root
	Instance.new("UICorner", col).CornerRadius = UDim.new(0, 14)
	local st = Instance.new("UIStroke", col)
	st.Color = Color3.fromRGB(70, 70, 75)
	st.Transparency = 0.5

	local header = Instance.new("TextLabel")
	header.BackgroundTransparency = 1
	header.Size = UDim2.new(1, 0, 0, 38)
	header.Font = FONT
	header.TextSize = 17
	header.TextColor3 = Color3.new(1, 1, 1)
	header.Text = title
	header.Parent = col

	local list = Instance.new("ScrollingFrame")
	list.BackgroundTransparency = 1
	list.BorderSizePixel = 0
	list.Position = UDim2.fromOffset(8, 40)
	list.Size = UDim2.new(1, -16, 1, -48)
	list.CanvasSize = UDim2.new()
	list.AutomaticCanvasSize = Enum.AutomaticSize.Y
	list.ScrollBarThickness = 3
	list.ScrollBarImageColor3 = Color3.fromRGB(120, 120, 125)
	list.Parent = col
	local layout = Instance.new("UIListLayout", list)
	layout.Padding = UDim.new(0, 6)
	layout.SortOrder = Enum.SortOrder.LayoutOrder

	for i, name in ipairs(names) do
		makeModule(list, name).btn.LayoutOrder = i
	end
end

for i, cat in ipairs(categories) do
	makeColumn(i, cat[1], cat[2])
end

-- Поиск
local search = Instance.new("TextBox")
search.AnchorPoint = Vector2.new(0.5, 0)
search.Position = UDim2.new(0.5, 0, 0, 485)
search.Size = UDim2.fromOffset(280, 34)
search.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
search.BackgroundTransparency = 0.1
search.ClearTextOnFocus = false
search.Font = FONT
search.TextSize = 14
search.TextColor3 = Color3.fromRGB(230, 230, 235)
search.PlaceholderText = "Search..."
search.PlaceholderColor3 = Color3.fromRGB(150, 150, 155)
search.Text = ""
search.Parent = root
Instance.new("UICorner", search).CornerRadius = UDim.new(0, 10)
local ss = Instance.new("UIStroke", search)
ss.Color = Color3.fromRGB(70, 70, 75)
ss.Transparency = 0.4

search:GetPropertyChangedSignal("Text"):Connect(function()
	local q = search.Text:lower()
	for _, m in ipairs(modules) do
		m.btn.Visible = q == "" or m.name:lower():find(q, 1, true) ~= nil
	end
end)

-- ===================== Ввод =====================
UIS.InputBegan:Connect(function(input, gp)
	-- закрыть попап при клике вне его
	if popup.Visible and input.UserInputType == Enum.UserInputType.MouseButton1 then
		local mp = UIS:GetMouseLocation()
		local p, sz = popup.AbsolutePosition, popup.AbsoluteSize
		if mp.X < p.X or mp.X > p.X + sz.X or mp.Y < p.Y or mp.Y > p.Y + sz.Y then
			popup.Visible = false
		end
	end

	if input.UserInputType ~= Enum.UserInputType.Keyboard then return end

	-- режим назначения бинда
	if bindingModule then
		local m = bindingModule
		bindingModule = nil
		if input.KeyCode == Enum.KeyCode.Escape or input.KeyCode == Enum.KeyCode.Backspace then
			m.key = nil
		elseif input.KeyCode ~= TOGGLE_KEY and input.KeyCode ~= Enum.KeyCode.Unknown then
			m.key = input.KeyCode
		end
		updateTag(m)
		refreshHud()
		return
	end

	if UIS:GetFocusedTextBox() then return end

	if input.KeyCode == TOGGLE_KEY then
		gui.Enabled = not gui.Enabled
		if not gui.Enabled then
			popup.Visible = false
			bindingModule = nil
		end
		return
	end

	-- нажатие забинденной клавиши (только визуальное вкл/выкл)
	for _, m in ipairs(modules) do
		if m.key == input.KeyCode then
			setOn(m, not m.on)
		end
	end
end)

refreshHud()
