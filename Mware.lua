-- Скрипт для executor (не Studio). Вставить целиком и выполнить.
-- RightControl: открыть/закрыть меню (плавно)
-- ЛКМ по модулю: вкл/выкл
-- ПКМ по модулю: настройки (открываются под кнопкой)
-- СКМ по модулю: назначить бинд (Esc/Backspace — снять)
-- Почти все окна можно таскать мышкой за их шапку/фон.

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local TOGGLE_KEY = Enum.KeyCode.RightControl

local function getGuiParent()
	local ok, parent = pcall(function()
		if typeof(gethui) == "function" then return gethui() end
		return game:GetService("CoreGui")
	end)
	if ok and parent then return parent end
	return playerGui
end
local guiParent = getGuiParent()

for _, n in ipairs({ "ClickGui", "KeybindsHud", "HotkeysHud", "TargetHud", "WatermarkHud", "NotifyHud", "EspHud" }) do
	local old = guiParent:FindFirstChild(n)
	if old then old:Destroy() end
end

local FONT = Enum.Font.GothamMedium

-- ===================== Перетаскивание =====================
local function makeDraggable(frame, handle)
	handle = handle or frame
	local dragging, dragStart, startPos

	handle.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = frame.Position
			local conn
			conn = input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
					conn:Disconnect()
				end
			end)
		end
	end)

	UIS.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local delta = input.Position - dragStart
			frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)
end

-- ===================== Тема (градиенты) =====================
local themes = {
	{ Color3.fromRGB(235, 35, 60), Color3.fromRGB(255, 120, 140) },
	{ Color3.fromRGB(0, 185, 255), Color3.fromRGB(60, 120, 255) },
	{ Color3.fromRGB(170, 30, 255), Color3.fromRGB(255, 90, 225) },
	{ Color3.fromRGB(0, 85, 215), Color3.fromRGB(70, 170, 255) },
	{ Color3.fromRGB(185, 185, 255), Color3.fromRGB(245, 245, 255) },
	{ Color3.fromRGB(60, 255, 215), Color3.fromRGB(140, 255, 255) },
	{ Color3.fromRGB(255, 255, 255), Color3.fromRGB(180, 180, 195) },
	{ Color3.fromRGB(115, 135, 255), Color3.fromRGB(190, 200, 255) },
}
local currentTheme = nil
local accentObjs = {}
local function addAccent(inst, prop) table.insert(accentObjs, { inst, prop }) end
local function themeSeq(th)
	return ColorSequence.new({
		ColorSequenceKeypoint.new(0, th[1]),
		ColorSequenceKeypoint.new(0.5, th[2]),
		ColorSequenceKeypoint.new(1, th[1]),
	})
end
local ACCENT_DEFAULT = Color3.fromRGB(225, 45, 60)
local function accentColor()
	if currentTheme then
		return currentTheme[1]:Lerp(currentTheme[2], (math.sin(os.clock() * 1.6) + 1) / 2)
	end
	return ACCENT_DEFAULT
end

-- ===================== Настройки модулей =====================
local settingDefs = {
	["ESP"] = {
		{ key = "Esp2D", label = "2D", type = "toggle", default = true },
		{ key = "Esp3D", label = "3D", type = "toggle" },
		{ key = "EspRounded", label = "Ровные углы", type = "toggle" },
		{ key = "EspCorner", label = "Corner", type = "toggle" },
		{ key = "EspHealth", label = "ESP Health", type = "toggle", default = true },
		{ key = "EspSkeleton", label = "ESP Skeleton", type = "toggle" },
		{ key = "EspName", label = "ESP Name", type = "toggle", default = true },
	},
	["Third Person"] = {
		{ key = "Distance", label = "Distance", type = "slider", min = 1, max = 10, step = 0.5, default = 5 },
	},
}

local modules, byName = {}, {}
local refreshHud

local function keyText(kc)
	local digits = { Zero = "0", One = "1", Two = "2", Three = "3", Four = "4", Five = "5", Six = "6", Seven = "7", Eight = "8", Nine = "9" }
	if digits[kc.Name] then return digits[kc.Name] end
	if #kc.Name == 1 then return kc.Name:upper() end
	return kc.Name
end

-- ===================== Keybind HUD стиль 1 =====================
local hudGui = Instance.new("ScreenGui")
hudGui.Name = "KeybindsHud"
hudGui.ResetOnSpawn = false
hudGui.IgnoreGuiInset = true
hudGui.DisplayOrder = 90
hudGui.Enabled = false
hudGui.Parent = guiParent

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
makeDraggable(hud, hudHeader)

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

-- ===================== Keybind HUD стиль 2 (Hotkeys) =====================
local hud2Gui = Instance.new("ScreenGui")
hud2Gui.Name = "HotkeysHud"
hud2Gui.ResetOnSpawn = false
hud2Gui.IgnoreGuiInset = true
hud2Gui.DisplayOrder = 90
hud2Gui.Enabled = false
hud2Gui.Parent = guiParent

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
makeDraggable(hud2, h2Header)

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

-- ===================== Watermark =====================
local WM_TITLE = "Maneware"

local wmGui = Instance.new("ScreenGui")
wmGui.Name = "WatermarkHud"
wmGui.ResetOnSpawn = false
wmGui.IgnoreGuiInset = true
wmGui.DisplayOrder = 89
wmGui.Enabled = false
wmGui.Parent = guiParent

local function wmBox(parent, x, y, w, h, round)
	local f = Instance.new("Frame")
	f.Position = UDim2.fromOffset(x, y)
	f.Size = UDim2.fromOffset(w, h)
	f.BackgroundColor3 = ACCENT_DEFAULT
	addAccent(f, "BackgroundColor3")
	f.BorderSizePixel = 0
	f.Parent = parent
	if round then Instance.new("UICorner", f).CornerRadius = UDim.new(1, 0) end
	return f
end

local function wmLine(p, x1, y1, x2, y2, thick)
	local dx, dy = x2 - x1, y2 - y1
	local len = math.sqrt(dx * dx + dy * dy)
	local f = Instance.new("Frame")
	f.AnchorPoint = Vector2.new(0.5, 0.5)
	f.Position = UDim2.fromOffset((x1 + x2) / 2, (y1 + y2) / 2)
	f.Size = UDim2.fromOffset(len + (thick or 2) * 0.5, thick or 2)
	f.Rotation = math.deg(math.atan2(dy, dx))
	f.BackgroundColor3 = ACCENT_DEFAULT
	addAccent(f, "BackgroundColor3")
	f.BorderSizePixel = 0
	f.Parent = p
	Instance.new("UICorner", f).CornerRadius = UDim.new(1, 0)
	return f
end

local function wmRing(p, x, y, w, h, radius, thick)
	local f = Instance.new("Frame")
	f.Position = UDim2.fromOffset(x, y)
	f.Size = UDim2.fromOffset(w, h)
	f.BackgroundTransparency = 1
	f.BorderSizePixel = 0
	f.Parent = p
	Instance.new("UICorner", f).CornerRadius = radius
	local st = Instance.new("UIStroke", f)
	st.Color = ACCENT_DEFAULT
	addAccent(st, "Color")
	st.Thickness = thick or 1.5
	return st
end

local function wmBars(p, heights, step, w)
	for i, h in ipairs(heights) do
		local b = wmBox(p, (i - 1) * step + 1, 15 - h, w, h, false)
		Instance.new("UICorner", b).CornerRadius = UDim.new(0, 1)
	end
end

local wmIcons = {
	logo = function(p)
		wmRing(p, 1, 1, 14, 14, UDim.new(1, 0), 2)
		wmBox(p, 5, 5, 6, 6, true)
		wmLine(p, 11, 11, 15, 15, 2)
	end,
	user = function(p)
		wmRing(p, 5, 0, 6, 6, UDim.new(1, 0), 1.5)
		wmRing(p, 2, 8, 12, 8, UDim.new(0, 4), 1.5)
	end,
	fps = function(p)
		wmLine(p, 1, 12, 5, 7, 2)
		wmLine(p, 5, 7, 9, 10, 2)
		wmLine(p, 9, 10, 14, 3, 2)
		wmLine(p, 14, 3, 10, 3, 2)
		wmLine(p, 14, 3, 14, 7, 2)
	end,
	ping = function(p) wmBars(p, { 4, 7, 10, 14 }, 4, 2) end,
	clock = function(p)
		wmRing(p, 1, 1, 14, 14, UDim.new(1, 0), 1.5)
		wmLine(p, 8, 8, 8, 4, 1.5)
		wmLine(p, 8, 8, 11, 9, 1.5)
	end,
	speed = function(p)
		wmLine(p, 2, 3, 7, 8, 2)
		wmLine(p, 7, 8, 2, 13, 2)
		wmLine(p, 8, 3, 13, 8, 2)
		wmLine(p, 13, 8, 8, 13, 2)
	end,
}

local function wmRow(y)
	local row = Instance.new("Frame")
	row.Position = UDim2.fromOffset(10, y)
	row.Size = UDim2.fromOffset(0, 34)
	row.AutomaticSize = Enum.AutomaticSize.X
	row.BackgroundColor3 = Color3.fromRGB(12, 10, 14)
	row.BackgroundTransparency = 0.15
	row.Parent = wmGui
	Instance.new("UICorner", row).CornerRadius = UDim.new(0, 8)
	local st = Instance.new("UIStroke", row)
	st.Color = ACCENT_DEFAULT
	addAccent(st, "Color")
	st.Transparency = 0.65
	local pad = Instance.new("UIPadding", row)
	pad.PaddingLeft = UDim.new(0, 12)
	pad.PaddingRight = UDim.new(0, 12)
	local l = Instance.new("UIListLayout", row)
	l.FillDirection = Enum.FillDirection.Horizontal
	l.VerticalAlignment = Enum.VerticalAlignment.Center
	l.Padding = UDim.new(0, 18)
	l.SortOrder = Enum.SortOrder.LayoutOrder
	makeDraggable(row, row)
	return row
end

local function wmItem(row, order, iconFn, text, color)
	local item = Instance.new("Frame")
	item.LayoutOrder = order
	item.Size = UDim2.new(0, 0, 1, 0)
	item.AutomaticSize = Enum.AutomaticSize.X
	item.BackgroundTransparency = 1
	item.Parent = row
	local l = Instance.new("UIListLayout", item)
	l.FillDirection = Enum.FillDirection.Horizontal
	l.VerticalAlignment = Enum.VerticalAlignment.Center
	l.Padding = UDim.new(0, 6)
	l.SortOrder = Enum.SortOrder.LayoutOrder

	local ic = Instance.new("Frame")
	ic.LayoutOrder = 1
	ic.Size = UDim2.fromOffset(16, 16)
	ic.BackgroundTransparency = 1
	ic.Parent = item
	iconFn(ic)

	local t = Instance.new("TextLabel")
	t.LayoutOrder = 2
	t.Size = UDim2.new(0, 0, 1, 0)
	t.AutomaticSize = Enum.AutomaticSize.X
	t.BackgroundTransparency = 1
	t.Font = Enum.Font.GothamMedium
	t.TextSize = 14
	t.TextColor3 = color or Color3.new(1, 1, 1)
	t.Text = text or ""
	t.Parent = item
	return t
end

local wmRow1 = wmRow(10)
local wmTitleLabel = wmItem(wmRow1, 1, wmIcons.logo, WM_TITLE, Color3.fromRGB(225, 60, 70))
local wmNick = wmItem(wmRow1, 2, wmIcons.user, player.Name)
local wmFpsLabel = wmItem(wmRow1, 3, wmIcons.fps, "0 Fps")
local wmTime = wmItem(wmRow1, 4, wmIcons.clock, "00:00:00")

local wmRow2 = wmRow(50)
local wmPing = wmItem(wmRow2, 1, wmIcons.ping, "0 Ping")
local wmSpeed = wmItem(wmRow2, 2, wmIcons.speed, "0,0 Studs/s")

local wmStats = game:GetService("Stats")
local wmFps, wmAcc = 60, 0

RunService.Heartbeat:Connect(function(dt)
	if dt > 0 then wmFps = wmFps * 0.9 + (1 / dt) * 0.1 end
	if not wmGui.Enabled then return end
	wmAcc += dt
	if wmAcc < 0.2 then return end
	wmAcc = 0

	wmNick.Text = player.Name
	wmFpsLabel.Text = string.format("%d Fps", math.floor(wmFps + 0.5))
	wmTime.Text = os.date("!%H:%M:%S", os.time() + 3 * 3600)

	local ok, ping = pcall(function()
		return wmStats.Network.ServerStatsItem["Data Ping"]:GetValue()
	end)
	wmPing.Text = string.format("%d Ping", ok and math.floor(ping + 0.5) or 0)

	local char = player.Character
	local root = char and char:FindFirstChild("HumanoidRootPart")
	local sp = 0
	if root then
		local v = root.AssemblyLinearVelocity
		sp = Vector3.new(v.X, 0, v.Z).Magnitude
	end
	wmSpeed.Text = (string.format("%.1f", sp):gsub("%.", ",")) .. " Studs/s"
end)

-- ===================== Notify =====================
local NF_GREEN = Color3.fromRGB(60, 205, 85)
local NF_RED = Color3.fromRGB(225, 55, 65)
local NF_H, NF_GAP, NF_LIFE, NF_MAX = 38, 6, 2.5, 6

local nfGui = Instance.new("ScreenGui")
nfGui.Name = "NotifyHud"
nfGui.ResetOnSpawn = false
nfGui.IgnoreGuiInset = true
nfGui.DisplayOrder = 95
nfGui.Parent = guiParent

local nfList = {}

local function nfLayout()
	for i, n in ipairs(nfList) do
		local y = (i - 1) * (NF_H + NF_GAP)
		TweenService:Create(n.frame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Position = UDim2.new(1, -20, 0.6, y),
		}):Play()
	end
end

local function nfPaint(n, on)
	n.label.Text = "Модуль " .. n.module.name .. (on and " включен!" or " выключен!")
	TweenService:Create(n.track, TweenInfo.new(0.15), { BackgroundColor3 = on and NF_GREEN or NF_RED }):Play()
	TweenService:Create(n.knob, TweenInfo.new(0.15), { Position = UDim2.fromOffset(on and 19 or 3, 3) }):Play()
end

local function nfBuild(m)
	local f = Instance.new("Frame")
	f.AnchorPoint = Vector2.new(1, 0)
	f.Position = UDim2.new(1, 300, 0.6, 0)
	f.Size = UDim2.fromOffset(0, NF_H)
	f.AutomaticSize = Enum.AutomaticSize.X
	f.BackgroundColor3 = Color3.fromRGB(16, 16, 20)
	f.BackgroundTransparency = 0.08
	f.Parent = nfGui
	Instance.new("UICorner", f).CornerRadius = UDim.new(0, 8)
	local st = Instance.new("UIStroke", f)
	st.Color = Color3.fromRGB(80, 80, 90)
	st.Transparency = 0.5
	local pad = Instance.new("UIPadding", f)
	pad.PaddingLeft = UDim.new(0, 8)
	pad.PaddingRight = UDim.new(0, 14)
	local l = Instance.new("UIListLayout", f)
	l.FillDirection = Enum.FillDirection.Horizontal
	l.VerticalAlignment = Enum.VerticalAlignment.Center
	l.Padding = UDim.new(0, 10)
	l.SortOrder = Enum.SortOrder.LayoutOrder

	local track = Instance.new("Frame")
	track.LayoutOrder = 1
	track.Size = UDim2.fromOffset(34, 18)
	track.BackgroundColor3 = NF_RED
	track.BorderSizePixel = 0
	track.Parent = f
	Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0)
	local knob = Instance.new("Frame")
	knob.Position = UDim2.fromOffset(3, 3)
	knob.Size = UDim2.fromOffset(12, 12)
	knob.BackgroundColor3 = Color3.new(1, 1, 1)
	knob.BorderSizePixel = 0
	knob.Parent = track
	Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

	local div = Instance.new("Frame")
	div.LayoutOrder = 2
	div.Size = UDim2.fromOffset(1, 22)
	div.BackgroundColor3 = Color3.fromRGB(90, 90, 98)
	div.BorderSizePixel = 0
	div.Parent = f

	local label = Instance.new("TextLabel")
	label.LayoutOrder = 3
	label.Size = UDim2.new(0, 0, 1, 0)
	label.AutomaticSize = Enum.AutomaticSize.X
	label.BackgroundTransparency = 1
	label.Font = Enum.Font.SourceSansSemibold
	label.TextSize = 19
	label.TextColor3 = Color3.new(1, 1, 1)
	label.Text = ""
	label.Parent = f

	return { module = m, frame = f, track = track, knob = knob, label = label, token = 0 }
end

local function nfRemove(n)
	local i = table.find(nfList, n)
	if i then table.remove(nfList, i) end
	TweenService:Create(n.frame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
		Position = n.frame.Position + UDim2.fromOffset(320, 0),
	}):Play()
	task.delay(0.3, function() n.frame:Destroy() end)
	nfLayout()
end

local function notifyModule(m, on)
	local iface = byName["Interface"]
	if not (iface and iface.settings.Notify and (iface.on or m == iface)) then return end

	local n
	for _, x in ipairs(nfList) do
		if x.module == m then n = x break end
	end
	if n then
		table.remove(nfList, table.find(nfList, n))
		table.insert(nfList, 1, n)
	else
		n = nfBuild(m)
		table.insert(nfList, 1, n)
	end
	nfPaint(n, on)

	while #nfList > NF_MAX do
		nfRemove(nfList[#nfList])
	end

	n.token += 1
	local t = n.token
	task.delay(NF_LIFE, function()
		if n.token == t and table.find(nfList, n) then nfRemove(n) end
	end)
	nfLayout()
end

-- ===================== Главное меню =====================
local gui = Instance.new("ScreenGui")
gui.Name = "ClickGui"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 100
gui.Enabled = false
gui.Parent = guiParent

-- обёртка для плавного фейда всего меню
local fade = Instance.new("CanvasGroup")
fade.Size = UDim2.fromScale(1, 1)
fade.BackgroundTransparency = 1
fade.GroupTransparency = 1
fade.Parent = gui

local root = Instance.new("Frame")
root.AnchorPoint = Vector2.new(0.5, 0.5)
root.Position = UDim2.fromScale(0.5, 0.5)
root.Size = UDim2.fromOffset(1090, 500)
root.BackgroundTransparency = 1
root.Parent = fade

local scale = Instance.new("UIScale", root)
local function updateScale()
	local vp = workspace.CurrentCamera.ViewportSize
	scale.Scale = math.clamp(math.min(vp.X / 1150, vp.Y / 560), 0.5, 1.5)
end
updateScale()
workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(updateScale)

-- ручка для перетаскивания всего окна
local grip = Instance.new("Frame")
grip.AnchorPoint = Vector2.new(0.5, 1)
grip.Position = UDim2.new(0.5, 0, 0, -8)
grip.Size = UDim2.fromOffset(150, 22)
grip.BackgroundColor3 = Color3.fromRGB(20, 18, 16)
grip.BackgroundTransparency = 0.1
grip.Parent = root
Instance.new("UICorner", grip).CornerRadius = UDim.new(0, 8)
local gripLabel = Instance.new("TextLabel")
gripLabel.BackgroundTransparency = 1
gripLabel.Size = UDim2.fromScale(1, 1)
gripLabel.Font = FONT
gripLabel.TextSize = 13
gripLabel.TextColor3 = Color3.fromRGB(190, 190, 195)
gripLabel.Text = "⠿ Меню"
gripLabel.Parent = grip
makeDraggable(root, grip)

-- ===================== Панель градиентов =====================
local gradPanel = Instance.new("Frame")
gradPanel.Name = "Gradients"
gradPanel.Visible = false
gradPanel.AnchorPoint = Vector2.new(0.5, 1)
gradPanel.Position = UDim2.new(0.5, 0, 1, -40)
gradPanel.Size = UDim2.fromOffset(0, 46)
gradPanel.AutomaticSize = Enum.AutomaticSize.X
gradPanel.BackgroundColor3 = Color3.fromRGB(14, 14, 18)
gradPanel.BackgroundTransparency = 0.05
gradPanel.Parent = fade
Instance.new("UICorner", gradPanel).CornerRadius = UDim.new(0, 12)
local gpStroke = Instance.new("UIStroke", gradPanel)
gpStroke.Color = Color3.fromRGB(70, 70, 78)
gpStroke.Transparency = 0.4
local gpPad = Instance.new("UIPadding", gradPanel)
gpPad.PaddingLeft = UDim.new(0, 14)
gpPad.PaddingRight = UDim.new(0, 14)
local gpLayout = Instance.new("UIListLayout", gradPanel)
gpLayout.FillDirection = Enum.FillDirection.Horizontal
gpLayout.VerticalAlignment = Enum.VerticalAlignment.Center
gpLayout.Padding = UDim.new(0, 12)
gpLayout.SortOrder = Enum.SortOrder.LayoutOrder
makeDraggable(gradPanel, gradPanel)

local swatches = {}

local function applyTheme()
	hudGrad.Color = currentTheme and themeSeq(currentTheme) or PURPLE
	if not currentTheme then
		for _, a in ipairs(accentObjs) do a[1][a[2]] = ACCENT_DEFAULT end
	end
	for i, sw in ipairs(swatches) do
		sw.dot.Visible = (currentTheme == themes[i])
	end
end

for i, th in ipairs(themes) do
	local b = Instance.new("TextButton")
	b.LayoutOrder = i
	b.Size = UDim2.fromOffset(28, 28)
	b.BackgroundColor3 = Color3.new(1, 1, 1)
	b.AutoButtonColor = false
	b.Text = ""
	b.Parent = gradPanel
	Instance.new("UICorner", b).CornerRadius = UDim.new(1, 0)

	local g = Instance.new("UIGradient", b)
	g.Color = themeSeq(th)
	g.Rotation = 45

	local dot = Instance.new("Frame")
	dot.AnchorPoint = Vector2.new(0.5, 0.5)
	dot.Position = UDim2.fromScale(0.5, 0.5)
	dot.Size = UDim2.fromOffset(9, 9)
	dot.BackgroundColor3 = Color3.new(0, 0, 0)
	dot.BorderSizePixel = 0
	dot.Visible = false
	dot.Parent = b
	Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)

	b.MouseButton1Click:Connect(function()
		currentTheme = (currentTheme == th) and nil or th
		applyTheme()
	end)

	swatches[i] = { grad = g, dot = dot }
end

RunService.Heartbeat:Connect(function()
	local t = os.clock()
	local sweep = Vector2.new(math.sin(t * 1.6) * 0.5, 0)
	if gradPanel.Visible then
		for _, sw in ipairs(swatches) do sw.grad.Offset = sweep end
	end
	if hudGui.Enabled then hudGrad.Offset = sweep end
	if currentTheme then
		local c = currentTheme[1]:Lerp(currentTheme[2], (math.sin(t * 1.6) + 1) / 2)
		for _, o in ipairs(accentObjs) do o[1][o[2]] = c end
	end
	-- радужное мерцание надписи Maneware (всегда, независимо от темы)
	wmTitleLabel.TextColor3 = Color3.fromHSV((t * 0.15) % 1, 0.75, 1)
end)

-- ===================== Попап настроек (ПКМ, открывается под кнопкой) =====================
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
makeDraggable(popup, popup)

local popupConns = {}
local function clearPopup()
	for _, c in ipairs(popupConns) do c:Disconnect() end
	popupConns = {}
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
				for _, k in ipairs(group) do m.settings[k] = false end
				m.settings[key] = new
				paintAll()
				refreshHud()
			end)
			order += 1
		end

		local kbGroup = { "Keybinds", "Keybinds2" }
		local thGroup = { "TargetHud1", "TargetHud2", "TargetHud3" }

		popLabel(order, "Keybind", 12, Color3.fromRGB(150, 150, 160), false)
		order += 1
		addToggle("Keybinds", "Keybind 1", kbGroup)
		addToggle("Keybinds2", "Keybind 2", kbGroup)

		popLabel(order, "TargetHUD", 12, Color3.fromRGB(150, 150, 160), false)
		order += 1
		addToggle("TargetHud1", "Targethud 1", thGroup)
		addToggle("TargetHud2", "Targethud 2", thGroup)
		addToggle("TargetHud3", "Targethud 3", thGroup)

		addToggle("Watermark", "Watermark", { "Watermark" })
		addToggle("Notify", "Notify", { "Notify" })
		paintAll()

		popLabel(order, "Тема", 12, Color3.fromRGB(150, 150, 160), false)
		order += 1
		local gb = Instance.new("TextButton")
		gb.LayoutOrder = order
		gb.Size = UDim2.new(1, 0, 0, 28)
		gb.BackgroundColor3 = Color3.fromRGB(32, 32, 38)
		gb.AutoButtonColor = false
		gb.Font = Enum.Font.SourceSansSemibold
		gb.TextSize = 17
		gb.TextColor3 = Color3.fromRGB(220, 220, 225)
		gb.Text = gradPanel.Visible and "Закрыть градиенты" or "Открыть градиенты"
		gb.ZIndex = 51
		gb.Parent = popup
		Instance.new("UICorner", gb).CornerRadius = UDim.new(0, 6)
		gb.MouseButton1Click:Connect(function()
			gradPanel.Visible = not gradPanel.Visible
			popup.Visible = false
		end)
		order += 1

	elseif settingDefs[m.name] then
		local boxes = {}
		local function paintAll()
			for key, box in pairs(boxes) do
				box.BackgroundColor3 = m.settings[key] and Color3.fromRGB(110, 90, 255) or Color3.fromRGB(55, 55, 62)
			end
		end

		for _, d in ipairs(settingDefs[m.name]) do
			if d.type == "toggle" then
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
				t.Font = Enum.Font.SourceSansSemibold
				t.TextSize = 17
				t.TextXAlignment = Enum.TextXAlignment.Left
				t.TextColor3 = Color3.fromRGB(220, 220, 225)
				t.Text = d.label
				t.ZIndex = 52
				t.Parent = row

				local box = Instance.new("Frame")
				box.AnchorPoint = Vector2.new(1, 0.5)
				box.Position = UDim2.new(1, -8, 0.5, 0)
				box.Size = UDim2.fromOffset(18, 18)
				box.ZIndex = 52
				box.Parent = row
				Instance.new("UICorner", box).CornerRadius = UDim.new(0, 4)
				boxes[d.key] = box

				row.MouseButton1Click:Connect(function()
					m.settings[d.key] = not m.settings[d.key]
					paintAll()
				end)
			else
				local row = Instance.new("Frame")
				row.LayoutOrder = order
				row.Size = UDim2.new(1, 0, 0, 46)
				row.BackgroundColor3 = Color3.fromRGB(32, 32, 38)
				row.ZIndex = 51
				row.Parent = popup
				Instance.new("UICorner", row).CornerRadius = UDim.new(0, 6)

				local title = Instance.new("TextLabel")
				title.BackgroundTransparency = 1
				title.Position = UDim2.fromOffset(8, 4)
				title.Size = UDim2.new(0.6, 0, 0, 20)
				title.Font = Enum.Font.SourceSansSemibold
				title.TextSize = 17
				title.TextXAlignment = Enum.TextXAlignment.Left
				title.TextColor3 = Color3.fromRGB(220, 220, 225)
				title.Text = d.label
				title.ZIndex = 52
				title.Parent = row

				local valueL = Instance.new("TextLabel")
				valueL.BackgroundTransparency = 1
				valueL.AnchorPoint = Vector2.new(1, 0)
				valueL.Position = UDim2.new(1, -8, 0, 4)
				valueL.Size = UDim2.new(0.35, 0, 0, 20)
				valueL.Font = Enum.Font.SourceSansSemibold
				valueL.TextSize = 17
				valueL.TextXAlignment = Enum.TextXAlignment.Right
				valueL.TextColor3 = Color3.fromRGB(170, 160, 255)
				valueL.ZIndex = 52
				valueL.Parent = row

				local track = Instance.new("Frame")
				track.Position = UDim2.fromOffset(10, 32)
				track.Size = UDim2.new(1, -20, 0, 6)
				track.BackgroundColor3 = Color3.fromRGB(55, 55, 62)
				track.BorderSizePixel = 0
				track.ZIndex = 52
				track.Parent = row
				Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0)

				local fill = Instance.new("Frame")
				fill.BackgroundColor3 = Color3.fromRGB(110, 90, 255)
				fill.BorderSizePixel = 0
				fill.ZIndex = 53
				fill.Parent = track
				Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)

				local knob = Instance.new("Frame")
				knob.AnchorPoint = Vector2.new(0.5, 0.5)
				knob.Size = UDim2.fromOffset(12, 12)
				knob.BackgroundColor3 = Color3.new(1, 1, 1)
				knob.BorderSizePixel = 0
				knob.ZIndex = 54
				knob.Parent = track
				Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

				local function render()
					local v = m.settings[d.key]
					local r = (v - d.min) / (d.max - d.min)
					fill.Size = UDim2.new(r, 0, 1, 0)
					knob.Position = UDim2.new(r, 0, 0.5, 0)
					valueL.Text = string.format("%.1f", v)
				end

				local dragging = false
				local function setFromX(x)
					local rel = math.clamp((x - track.AbsolutePosition.X) / math.max(track.AbsoluteSize.X, 1), 0, 1)
					local v = d.min + rel * (d.max - d.min)
					v = math.floor(v / d.step + 0.5) * d.step
					m.settings[d.key] = math.clamp(v, d.min, d.max)
					render()
				end

				row.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						dragging = true
						setFromX(input.Position.X)
					end
				end)
				table.insert(popupConns, UIS.InputChanged:Connect(function(input)
					if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
						setFromX(input.Position.X)
					end
				end))
				table.insert(popupConns, UIS.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						dragging = false
					end
				end))
				render()
			end
			order += 1
		end
		paintAll()
	else
		popLabel(order, "Нет настроек", 13, Color3.fromRGB(150, 150, 155), false)
		order += 1
	end

	popLabel(order, "Бинд: " .. (m.key and ("[" .. keyText(m.key) .. "]") or "нет") .. "  (СКМ)", 12, Color3.fromRGB(150, 150, 160), false)

	-- открыть попап ПОД кнопкой модуля
	local btnPos = m.btn.AbsolutePosition
	local btnSize = m.btn.AbsoluteSize
	local rel = (btnPos - root.AbsolutePosition) / scale.Scale
	popup.Position = UDim2.fromOffset(rel.X, rel.Y + btnSize.Y / scale.Scale + 6)
	popup.Visible = true
end

-- ===================== Кнопка модуля =====================
local bindingModule = nil
local COL_OFF = Color3.fromRGB(28, 28, 30)
local COL_HOVER = Color3.fromRGB(40, 40, 44)
local COL_ON = Color3.fromRGB(70, 70, 85)

local function setOn(m, v)
	m.on = v
	TweenService:Create(m.btn, TweenInfo.new(0.15), { BackgroundColor3 = v and COL_ON or COL_OFF }):Play()
	m.label.TextColor3 = v and Color3.new(1, 1, 1) or Color3.fromRGB(200, 200, 205)
	refreshHud()
	notifyModule(m, v)
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
	if name == "Interface" then
		m.settings.Keybinds = true
		m.settings.Keybinds2 = false
		m.settings.TargetHud1 = false
		m.settings.TargetHud2 = false
		m.settings.TargetHud3 = false
		m.settings.Watermark = false
		m.settings.Notify = false
	end
	local defs = settingDefs[name]
	if defs then for _, d in ipairs(defs) do m.settings[d.key] = d.default or false end end

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

	local dots = Instance.new("TextLabel")
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

	btn.MouseButton1Click:Connect(function()
		setOn(m, not m.on)
	end)

	btn.MouseButton2Click:Connect(function()
		openSettings(m)
	end)

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
	col.Size = UDim2.fromOffset(205, 440)
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

local categories = {
	{ "Combat", { "Anti Bot", "Auto Armor", "Auto Explosion", "Auto Swap", "Auto Totem", "Crystal Spammer", "CrystalAura", "KillAura", "No Friend Damage", "Trigger Bot", "Velocity" } },
	{ "Movement", { "Air Stuck", "Dog Fly", "Elytra Motion", "ElytraBooster", "ElytraFlight", "Gui Move", "No Jump Delay", "No Slow", "No Web", "Speed", "Sprint" } },
	{ "Player", { "Auto Eat", "Auto Leave", "Auto Tool", "Auto Tpaccept", "Click Pearl", "Death Coords", "Elytra Helper", "Fast Exp", "Free Camera", "No Push", "Tape Mouse", "Teleport Back" } },
	{ "Misc", { "Crystal Optimizer", "Discord RPC", "Fake Player", "Lony Helper", "RP Spoofer", "Streamer Mode", "UseTracker", "Interface", "AntiFling" } },
	{ "Visual", { "ESP", "China Hat", "Third Person", "Trails" } },
}
for i, cat in ipairs(categories) do
	makeColumn(i, cat[1], cat[2])
end

-- Поиск
local search = Instance.new("TextBox")
search.AnchorPoint = Vector2.new(0.5, 0)
search.Position = UDim2.new(0.5, 0, 0, 445)
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

-- ===================== TargetHUD (3 стиля) =====================
local thGui = Instance.new("ScreenGui")
thGui.Name = "TargetHud"
thGui.ResetOnSpawn = false
thGui.IgnoreGuiInset = true
thGui.DisplayOrder = 91
thGui.Parent = guiParent

local th = nil
local thStyle = nil
local thTarget = nil
local thHum = nil
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
	makeDraggable(f, f)

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

local rayParams = RaycastParams.new()
rayParams.FilterType = Enum.RaycastFilterType.Exclude

local function getTarget()
	local cam = workspace.CurrentCamera
	if not cam then return nil end
	local char = player.Character
	rayParams.FilterDescendantsInstances = char and { char } or {}

	local loc = UIS:GetMouseLocation()
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
	wmGui.Enabled = ifaceOn and iface.settings.Watermark == true

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
	end
	hudGrad.Color = currentTheme and themeSeq(currentTheme) or PURPLE
end

-- ===================== ESP =====================
local espGui = Instance.new("ScreenGui")
espGui.Name = "EspHud"
espGui.ResetOnSpawn = false
espGui.IgnoreGuiInset = true
espGui.DisplayOrder = 80
espGui.Parent = guiParent

local SIGNS = {
	{ -1, -1, -1 }, { 1, -1, -1 }, { 1, -1, 1 }, { -1, -1, 1 },
	{ -1, 1, -1 }, { 1, 1, -1 }, { 1, 1, 1 }, { -1, 1, 1 },
}
local EDGES = {
	{ 1, 2 }, { 2, 3 }, { 3, 4 }, { 4, 1 },
	{ 5, 6 }, { 6, 7 }, { 7, 8 }, { 8, 5 },
	{ 1, 5 }, { 2, 6 }, { 3, 7 }, { 4, 8 },
}
local R15_BONES = {
	{ "Head", "UpperTorso" }, { "UpperTorso", "LowerTorso" },
	{ "UpperTorso", "LeftUpperArm" }, { "LeftUpperArm", "LeftLowerArm" }, { "LeftLowerArm", "LeftHand" },
	{ "UpperTorso", "RightUpperArm" }, { "RightUpperArm", "RightLowerArm" }, { "RightLowerArm", "RightHand" },
	{ "LowerTorso", "LeftUpperLeg" }, { "LeftUpperLeg", "LeftLowerLeg" }, { "LeftLowerLeg", "LeftFoot" },
	{ "LowerTorso", "RightUpperLeg" }, { "RightUpperLeg", "RightLowerLeg" }, { "RightLowerLeg", "RightFoot" },
}
local R6_BONES = {
	{ "Head", "Torso" }, { "Torso", "Left Arm" }, { "Torso", "Right Arm" },
	{ "Torso", "Left Leg" }, { "Torso", "Right Leg" },
}

local espObjs = {}
local espWasOn = false

local function newLine()
	local f = Instance.new("Frame")
	f.AnchorPoint = Vector2.new(0.5, 0.5)
	f.BorderSizePixel = 0
	f.BackgroundColor3 = ACCENT_DEFAULT
	f.Visible = false
	f.Parent = espGui
	return f
end

local function placeLine(f, x1, y1, x2, y2, thick, color)
	local dx, dy = x2 - x1, y2 - y1
	f.Position = UDim2.fromOffset((x1 + x2) / 2, (y1 + y2) / 2)
	f.Size = UDim2.fromOffset(math.sqrt(dx * dx + dy * dy) + thick * 0.5, thick)
	f.Rotation = math.deg(math.atan2(dy, dx))
	f.BackgroundColor3 = color
	f.Visible = true
end

local function hideList(list)
	for _, l in ipairs(list) do l.Visible = false end
end

local function createEsp()
	local o = { all = {} }
	local function reg(i)
		table.insert(o.all, i)
		return i
	end

	o.box = reg(Instance.new("Frame"))
	o.box.BackgroundTransparency = 1
	o.box.BorderSizePixel = 0
	o.box.Visible = false
	o.box.Parent = espGui
	o.stroke = Instance.new("UIStroke", o.box)
	o.stroke.Thickness = 1.5
	o.round = Instance.new("UICorner", o.box)
	o.round.CornerRadius = UDim.new(0, 0)

	o.corners, o.edges, o.skel = {}, {}, {}
	for i = 1, 8 do o.corners[i] = reg(newLine()) end
	for i = 1, 12 do o.edges[i] = reg(newLine()) end
	for i = 1, 14 do o.skel[i] = reg(newLine()) end

	o.hpBack = reg(Instance.new("Frame"))
	o.hpBack.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
	o.hpBack.BackgroundTransparency = 0.3
	o.hpBack.BorderSizePixel = 0
	o.hpBack.ClipsDescendants = true
	o.hpBack.Visible = false
	o.hpBack.Parent = espGui
	o.hpFill = Instance.new("Frame")
	o.hpFill.AnchorPoint = Vector2.new(0, 1)
	o.hpFill.Position = UDim2.fromScale(0, 1)
	o.hpFill.BorderSizePixel = 0
	o.hpFill.Parent = o.hpBack

	o.name = reg(Instance.new("TextLabel"))
	o.name.AnchorPoint = Vector2.new(0.5, 1)
	o.name.Size = UDim2.fromOffset(0, 16)
	o.name.AutomaticSize = Enum.AutomaticSize.X
	o.name.BackgroundTransparency = 1
	o.name.Font = Enum.Font.SourceSansSemibold
	o.name.TextSize = 16
	o.name.TextColor3 = Color3.new(1, 1, 1)
	o.name.TextStrokeTransparency = 0.4
	o.name.Visible = false
	o.name.Parent = espGui
	return o
end

local function hideEsp(o)
	o.box.Visible = false
	hideList(o.corners)
	hideList(o.edges)
	hideList(o.skel)
	o.hpBack.Visible = false
	o.name.Visible = false
end

local function drawEsp(pl, o, cam, st, color)
	local char = pl.Character
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	local root2 = char and char:FindFirstChild("HumanoidRootPart")
	if not (hum and root2 and hum.Health > 0) then
		hideEsp(o)
		return
	end

	local cf, size = char:GetBoundingBox()
	local top = cam:WorldToViewportPoint(cf.Position + Vector3.new(0, size.Y / 2, 0))
	local bot = cam:WorldToViewportPoint(cf.Position - Vector3.new(0, size.Y / 2, 0))
	if top.Z <= 0 or bot.Z <= 0 then
		hideEsp(o)
		return
	end

	local h = math.abs(bot.Y - top.Y)
	local w = h * 0.55
	local cx = (top.X + bot.X) / 2
	local left = cx - w / 2
	local topY = math.min(top.Y, bot.Y)
	local right = left + w
	local bottomY = topY + h

	if st.Esp2D then
		o.box.Position = UDim2.fromOffset(left, topY)
		o.box.Size = UDim2.fromOffset(w, h)
		o.stroke.Color = color
		o.round.CornerRadius = UDim.new(0, st.EspRounded and 8 or 0)
		o.box.Visible = true
	else
		o.box.Visible = false
	end

	if st.EspCorner then
		local L = math.clamp(math.min(w, h) * 0.28, 4, 18)
		local c = o.corners
		placeLine(c[1], left, topY, left + L, topY, 1.5, color)
		placeLine(c[2], left, topY, left, topY + L, 1.5, color)
		placeLine(c[3], right, topY, right - L, topY, 1.5, color)
		placeLine(c[4], right, topY, right, topY + L, 1.5, color)
		placeLine(c[5], left, bottomY, left + L, bottomY, 1.5, color)
		placeLine(c[6], left, bottomY, left, bottomY - L, 1.5, color)
		placeLine(c[7], right, bottomY, right - L, bottomY, 1.5, color)
		placeLine(c[8], right, bottomY, right, bottomY - L, 1.5, color)
	else
		hideList(o.corners)
	end

	if st.Esp3D then
		local pts, ok = {}, true
		for i, sg in ipairs(SIGNS) do
			local v = cam:WorldToViewportPoint(cf * Vector3.new(sg[1] * size.X / 2, sg[2] * size.Y / 2, sg[3] * size.Z / 2))
			if v.Z <= 0 then
				ok = false
				break
			end
			pts[i] = v
		end
		if ok then
			for i, e in ipairs(EDGES) do
				placeLine(o.edges[i], pts[e[1]].X, pts[e[1]].Y, pts[e[2]].X, pts[e[2]].Y, 1.5, color)
			end
		else
			hideList(o.edges)
		end
	else
		hideList(o.edges)
	end

	if st.EspHealth then
		local ratio = math.clamp(hum.Health / math.max(hum.MaxHealth, 1), 0, 1)
		o.hpBack.Position = UDim2.fromOffset(left - 7, topY)
		o.hpBack.Size = UDim2.fromOffset(3, h)
		o.hpFill.Size = UDim2.new(1, 0, ratio, 0)
		o.hpFill.BackgroundColor3 = Color3.fromRGB(255, 60, 60):Lerp(Color3.fromRGB(60, 255, 90), ratio)
		o.hpBack.Visible = true
	else
		o.hpBack.Visible = false
	end

	if st.EspSkeleton then
		local bones = char:FindFirstChild("UpperTorso") and R15_BONES or R6_BONES
		for i, line in ipairs(o.skel) do
			local pair = bones[i]
			local shown = false
			if pair then
				local a, b = char:FindFirstChild(pair[1]), char:FindFirstChild(pair[2])
				if a and b and a:IsA("BasePart") and b:IsA("BasePart") then
					local pa = cam:WorldToViewportPoint(a.Position)
					local pb = cam:WorldToViewportPoint(b.Position)
					if pa.Z > 0 and pb.Z > 0 then
						placeLine(line, pa.X, pa.Y, pb.X, pb.Y, 1.5, color)
						shown = true
					end
				end
			end
			if not shown then line.Visible = false end
		end
	else
		hideList(o.skel)
	end

	if st.EspName then
		o.name.Text = pl.Name
		o.name.Position = UDim2.fromOffset(cx, topY - 3)
		o.name.Visible = true
	else
		o.name.Visible = false
	end
end

Players.PlayerRemoving:Connect(function(pl)
	local o = espObjs[pl]
	if o then
		for _, i in ipairs(o.all) do i:Destroy() end
		espObjs[pl] = nil
	end
end)

RunService.RenderStepped:Connect(function()
	local esp = byName["ESP"]
	if not (esp and esp.on) then
		if espWasOn then
			espWasOn = false
			for _, o in pairs(espObjs) do hideEsp(o) end
		end
		return
	end
	espWasOn = true

	local cam = workspace.CurrentCamera
	local color = accentColor()
	for _, pl in ipairs(Players:GetPlayers()) do
		if pl ~= player then
			local o = espObjs[pl]
			if not o then
				o = createEsp()
				espObjs[pl] = o
			end
			drawEsp(pl, o, cam, esp.settings, color)
		end
	end
end)

-- ===================== China Hat =====================
-- остриё направлено вверх; если у тебя вдруг смотрит вниз — поставь HAT_FLIP = false
local HAT_FLIP = true
local hat = nil

RunService.RenderStepped:Connect(function()
	local ch = byName["China Hat"]
	local char = player.Character
	local head = char and char:FindFirstChild("Head")
	if ch and ch.on and head then
		if not hat or not hat.Parent then
			hat = Instance.new("ConeHandleAdornment")
			hat.Radius = 1.7
			hat.Height = 0.9
			hat.CFrame = CFrame.new(0, 0.5, 0) * CFrame.Angles(HAT_FLIP and math.pi / 2 or -math.pi / 2, 0, 0)
			hat.Transparency = 0.1
			hat.AlwaysOnTop = false
			hat.ZIndex = 1
			hat.Parent = workspace.CurrentCamera
		end
		hat.Adornee = head
		hat.Color3 = accentColor()
	elseif hat then
		hat:Destroy()
		hat = nil
	end
end)

-- ===================== Third Person =====================
local tpSaved, tpLast = nil, nil

RunService.RenderStepped:Connect(function()
	local tp = byName["Third Person"]
	if tp and tp.on then
		if not tpSaved then
			tpSaved = {
				min = player.CameraMinZoomDistance,
				max = player.CameraMaxZoomDistance,
				mode = player.CameraMode,
			}
		end
		local d = tp.settings.Distance or 5
		if d ~= tpLast or player.CameraMode ~= Enum.CameraMode.Classic then
			tpLast = d
			player.CameraMode = Enum.CameraMode.Classic
			player.CameraMinZoomDistance = 0.5
			player.CameraMaxZoomDistance = d
			player.CameraMinZoomDistance = d
		end
	elseif tpSaved then
		player.CameraMinZoomDistance = 0.5
		player.CameraMaxZoomDistance = tpSaved.max
		player.CameraMinZoomDistance = tpSaved.min
		player.CameraMode = tpSaved.mode
		tpSaved, tpLast = nil, nil
	end
end)

-- ===================== Trails =====================
-- линия-след позади персонажа, начинается от спины
local trailObjs = nil

local function destroyTrail()
	if trailObjs then
		for _, i in ipairs(trailObjs) do i:Destroy() end
		trailObjs = nil
	end
end

local function buildTrail(root2)
	local a1 = Instance.new("Attachment")
	a1.Position = Vector3.new(0, 1, 1) -- верх спины
	a1.Parent = root2
	local a2 = Instance.new("Attachment")
	a2.Position = Vector3.new(0, -1, 1) -- низ спины
	a2.Parent = root2

	local trail = Instance.new("Trail")
	trail.Attachment0 = a1
	trail.Attachment1 = a2
	trail.Lifetime = 0.5
	trail.MinLength = 0.05
	trail.FaceCamera = true
	trail.Color = ColorSequence.new(accentColor())
	trail.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0.2),
		NumberSequenceKeypoint.new(1, 1),
	})
	trail.Parent = root2
	trailObjs = { a1, a2, trail }
	return trail
end

local trailInstance = nil
RunService.RenderStepped:Connect(function()
	local tr = byName["Trails"]
	local char = player.Character
	local root2 = char and char:FindFirstChild("HumanoidRootPart")
	if tr and tr.on and root2 then
		if not trailObjs or not trailObjs[3].Parent then
			trailInstance = buildTrail(root2)
		end
		trailInstance.Color = ColorSequence.new(accentColor())
	else
		destroyTrail()
	end
end)

player.CharacterAdded:Connect(function()
	destroyTrail()
end)

-- ===================== AntiFling =====================
-- гасит резкий скачок скорости (фling) по себе, стоять и двигаться после можно сразу
local lastVel = Vector3.new()

RunService.Heartbeat:Connect(function()
	local af = byName["AntiFling"]
	if not (af and af.on) then return end

	local char = player.Character
	local root2 = char and char:FindFirstChild("HumanoidRootPart")
	if not root2 then return end

	local vel = root2.AssemblyLinearVelocity
	local delta = (vel - lastVel).Magnitude

	-- резкий скачок скорости за кадр — похоже на фling, гасим
	if delta > 90 or vel.Magnitude > 220 then
		root2.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
		root2.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
		vel = Vector3.new()
	end

	lastVel = vel
end)

-- ===================== Открытие/закрытие меню =====================
local menuOpen = false
local function setMenuOpen(v)
	if v == menuOpen then return end
	menuOpen = v
	if v then
		gui.Enabled = true
		TweenService:Create(fade, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { GroupTransparency = 0 }):Play()
	else
		local tw = TweenService:Create(fade, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In), { GroupTransparency = 1 })
		tw:Play()
		tw.Completed:Connect(function()
			if not menuOpen then gui.Enabled = false end
		end)
		popup.Visible = false
		bindingModule = nil
	end
end

UIS.InputBegan:Connect(function(input, gp)
	if popup.Visible and input.UserInputType == Enum.UserInputType.MouseButton1 then
		local mp = UIS:GetMouseLocation()
		local p, sz = popup.AbsolutePosition, popup.AbsoluteSize
		if mp.X < p.X or mp.X > p.X + sz.X or mp.Y < p.Y or mp.Y > p.Y + sz.Y then
			popup.Visible = false
		end
	end

	if input.UserInputType ~= Enum.UserInputType.Keyboard then return end

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
		setMenuOpen(not menuOpen)
		return
	end

	for _, m in ipairs(modules) do
		if m.key == input.KeyCode then
			setOn(m, not m.on)
		end
	end
end)

refreshHud()
