-- leak by uwustudios discord.gg/uwustudios
local SoundService = game:GetService("SoundService")
local Players = game:GetService("Players")
game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local TeleportService = game:GetService("TeleportService")
local VirtualUser = game:GetService("VirtualUser")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local localPlayer = Players.LocalPlayer
local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/main/Library.lua"))()
local lib2 = loadstring(game:HttpGet("https://raw.githubusercontent.com/brojstypingshit-prog/savemanagerhollyyyy/refs/heads/main/SaveManager.luau"))()
local lib3 = loadstring(game:HttpGet("https://raw.githubusercontent.com/brojstypingshit-prog/savemanagerhollyyyy/refs/heads/main/ThemeManager.luau"))()
MainModule = MainModule or {}
MainModule.ToggleRefs = MainModule.ToggleRefs or {}
MainModule._SuppressUI = false
MainModule.Keybinds = MainModule.Keybinds or { Menu = "Z" }
MainModule.PlayerESPEnabled = false
MainModule.ESPStore = MainModule.ESPStore or {}

local function fn(arg, arg2, arg3)
	local str = "hollyscriptx"
	local str2 = ""
	local n = 0.9

	if type(arg) == "string" then
		str = tostring(arg):lower()
		str2 = tostring(arg2 or ""):lower()
		n = tonumber(arg3) or 0.9
	end

	pcall(function()
		lib:Notify(str2 ~= "" and str .. " | " .. str2 or str, n)
	end)
end

local n = 0

local function fn2()
	if MainModule._SuppressUI then
		return
	end
	local now = tick()
	if now - n < 0.12 then
		return
	end
	n = now
	local sound = Instance.new("Sound")
	sound.SoundId = "rbxassetid://10066942189"
	sound.Volume = 5
	sound.Parent = SoundService
	sound:Play()

	sound.Ended:Connect(function()
		sound:Destroy()
	end)
end

local function fn3()
	local sound = Instance.new("Sound")
	sound.SoundId = "rbxassetid://6026984224"
	sound.Volume = 1.2
	sound.Parent = SoundService
	sound:Play()

	sound.Ended:Connect(function()
		sound:Destroy()
	end)
end

local function fn4()
	local sound = Instance.new("Sound")
	sound.SoundId = "rbxassetid://17208361335"
	sound.Volume = 1
	sound.Parent = SoundService
	sound:Play()

	sound.Ended:Connect(function()
		sound:Destroy()
	end)
end

MainModule.wrapGroupbox = function(arg)
	return {
		_raw = arg,
		Toggle = function(arg2, arg3)
			local tbl = arg3 or {}
			local str = tostring(tbl.Id or tbl.Title or "t_" .. math.random(100000, 999999)):lower():gsub("%s+", "_"):gsub("[^%w_]", "")
			local callback = tbl.Callback

			local v = arg:AddToggle(str, {
				Text = tbl.Title or str,
				Default = tbl.Value and true or false,
				Tooltip = tbl.Desc,
				Callback = function(arg4)
					if MainModule._SuppressUI then
						return
					end
					fn2()

					if callback then
						if not pcall(callback, arg4) then
							fn4()
						elseif arg4 then
							fn3()
						end
					end
				end,
			})

			MainModule.ToggleRefs[str] = v
			return v
		end,
		Button = function(arg2, arg3)
			local tbl = arg3 or {}

			return arg:AddButton({
				Text = tbl.Title or "Button",
				Func = function()
					if tbl.Callback then
						if pcall(tbl.Callback) then
							fn3()
						else
							fn4()
						end
					end
				end,
			})
		end,
		Slider = function(arg2, arg3)
			local tbl = arg3 or {}
			local str = tostring(tbl.Id or tbl.Title or "s_" .. math.random(100000, 999999)):lower():gsub("%s+", "_"):gsub("[^%w_]", "")
			local tbl2 = tbl.Value or {}

			return arg:AddSlider(str, {
				Text = tbl.Title or str,
				Default = tbl2.Default or tbl.Default or 0,
				Min = tbl2.Min or tbl.Min or 0,
				Max = tbl2.Max or tbl.Max or 100,
				Rounding = 0,
				Callback = function(arg4)
					if tbl.Callback then
						pcall(tbl.Callback, arg4)
					end
				end,
			})
		end,
		Dropdown = function(arg2, arg3)
			local tbl = arg3 or {}
			local str = tostring(tbl.Id or tbl.Title or "d_" .. math.random(100000, 999999)):lower():gsub("%s+", "_"):gsub("[^%w_]", "")

			return arg:AddDropdown(str, {
				Text = tbl.Title or str,
				Values = tbl.Values or {},
				Default = tbl.Value or tbl.Default,
				Multi = tbl.Multi,
				Callback = function(arg4)
					if tbl.Callback then
						pcall(tbl.Callback, arg4)
					end
				end,
			})
		end,
		Paragraph = function(arg2, arg3)
			local tbl = arg3 or {}
			return arg:AddLabel(tostring(type(tbl) == "string" and tbl or tbl.Title or ""))
		end,
		AddKeyPicker = function(arg2, arg3, arg4)
			local tbl = arg4 or {}
			local v = arg:AddLabel(tbl.Text or arg3 or "Key")
			if v and v.AddKeyPicker then
				return v:AddKeyPicker(arg3, tbl)
			end
			return nil
		end,
	}
end

MainModule.wrapTab = function(arg)
	local n2 = 0

	return {
		_raw = arg,
		Section = function(arg2, arg3)
			local tbl = arg3 or {}
			n2 += 1
			local flag = n2 % 2 == 1

			if flag then
				flag = arg:AddLeftGroupbox(tbl.Title or "Section", tbl.Icon)
			end

			if not flag then
				flag = arg:AddRightGroupbox(tbl.Title or "Section", tbl.Icon)
			end

			return MainModule.wrapGroupbox(flag)
		end,
	}
end

local function fn5(arg)
	task.defer(function()
		pcall(function()
			local tbl = {}

			if lib.ScreenGui then
				table.insert(tbl, lib.ScreenGui)
			end

			if typeof(arg) == "table" and arg.Root then
				table.insert(tbl, arg.Root)
			end

			for _, v in ipairs(tbl) do
				if typeof(v) == "Instance" then
					for _, descendant in ipairs(v:GetDescendants()) do
						if descendant:IsA("UICorner") then
							descendant.CornerRadius = UDim.new(0, 25)
						end
					end
				end
			end
		end)
	end)
end

lib.CornerRadius = 25

pcall(function()
	if lib.SetCornerRadius then
		lib:SetCornerRadius(25)
	end
end)

local v = lib:CreateWindow({
	Title = "HollyScriptX",
	Center = true,
	Footer = "https://discord.gg/hollyscriptx-1504482964661076098 | 99 Nights",
	Resizable = true,
	AutoShow = true,
	ShowCustomCursor = false,
	ToggleKeybind = Enum.KeyCode.Z,
	CornerRadius = 25,
	AlwaysOnTop = true,
})

fn5(v)
local addTab = v.AddTab

v.Tab = function(arg, arg2)
	local tbl = arg2 or {}
	local v2 = addTab(v, tbl.Title or "Tab", tbl.Icon)
	local v3 = MainModule.wrapTab(v2)
	v3._raw = v2
	return v3
end

local function fn6()
	return localPlayer.Character
end

local function fn7()
	local v2 = fn6()
	return v2 and v2:FindFirstChild("HumanoidRootPart")
end

local function fn8()
	local v2 = fn6()
	return v2 and v2:FindFirstChildOfClass("Humanoid")
end

local tbl = {
	"Log",
	"Coal",
	"Fuel Canister",
	"Oil Barrel",
	"Biofuel",
	"Chair",
	"Crossbow Cultist",
	"Cultist",
	"Juggernaut Cultist",
	"Cultist King",
	"Wolf Corpse",
	"Bear Corpse",
}

local tbl2 = { "Morsel", "Steak", "Ribs", "Salmon", "Mackerel" }

local tbl3 = {
	"Log",
	"Coal",
	"Fuel Canister",
	"Oil Barrel",
	"Biofuel",
	"Morsel",
	"Steak",
	"Ribs",
	"Salmon",
	"Mackerel",
	"Bandage",
	"Medkit",
	"Flashlight",
	"Axe",
	"Pickaxe",
}

local tbl4 = {
	auto_fuel = false,
	fuel_list = { "Coal", "Fuel Canister", "Oil Barrel", "Biofuel", "Chair" },
	auto_cook = false,
	cook_list = {},
	auto_open_chests = false,
	bring_enabled = false,
	bring_list = {},
	kill_aura = false,
	kill_dist = 25,
	auto_chop = false,
	tree_dist = 30,
	god_mode = false,
	speed_on = false,
	speed = 24,
	fullbright = false,
	esp_players = false,
	esp_fuel = false,
	esp_food = false,
	esp_metal = false,
	esp_chests = false,
}

local tbl5 = {}
local tbl6 = {}

local function fn9()
	for _, v2 in pairs(tbl6) do
		pcall(function()
			if v2 and v2.Parent then
				v2:Destroy()
			end
		end)
	end

	table.clear(tbl6)
end

local function fn10(parent, fillColor)
	if not parent or not parent.Parent then
		return
	end
	local highlight = Instance.new("Highlight")
	highlight.Name = "HSX_99ESP"
	highlight.FillColor = fillColor
	highlight.OutlineColor = Color3.new(1, 1, 1)
	highlight.FillTransparency = 0.55
	highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	highlight.Parent = parent
	table.insert(tbl6, highlight)
end

MainModule.toggle_player_esp = function(arg)
	MainModule.PlayerESPEnabled = arg and true or false

	for _, v2 in pairs(MainModule.ESPStore) do
		pcall(function()
			if v2 and v2.Parent then
				v2:Destroy()
			end
		end)
	end

	table.clear(MainModule.ESPStore)
	if not arg then
		return
	end

	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= localPlayer and player.Character then
			local highlight = Instance.new("Highlight")
			highlight.Name = "HSX_PlayerESP"
			highlight.FillColor = Color3.fromRGB(0, 162, 255)
			highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
			highlight.FillTransparency = 0.5
			highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
			highlight.Parent = player.Character
			MainModule.ESPStore[player] = highlight
		end
	end
end

local function fn11()
	local map = Workspace:FindFirstChild("Map")

	if map then
		local campground = map:FindFirstChild("Campground")
		if campground then
			return campground:FindFirstChild("MainFire") or campground:FindFirstChild("Campfire")
		end
	end

	for _, descendant in ipairs(Workspace:GetDescendants()) do
		local str = descendant.Name:lower()
		if (str:find("campfire") or str:find("mainfire")) and (descendant:IsA("BasePart") or descendant:IsA("Model")) then
			return descendant
		end
	end

	return nil
end

local function fn12()
	return Workspace:FindFirstChild("Items") or Workspace
end

local function fn13(arg, arg2)
	if type(arg2) ~= "table" then
		return false
	end

	for k, v2 in pairs(arg2) do
		if type(k) == "string" and v2 == true and arg == k then
			return true
		end

		if type(v2) == "string" and arg == v2 then
			return true
		end
	end

	return false
end

local function fn14(arg)
	local proximityPrompt = arg:FindFirstChildWhichIsA("ProximityPrompt", true)
	if proximityPrompt and fireproximityprompt then
		pcall(fireproximityprompt, proximityPrompt, 3)
		return true
	end
	return false
end

local function fn15(arg)
	local v2 = fn7()
	if not v2 or not arg then
		return
	end
	local isBasePart = arg:IsA("BasePart") and arg or arg.PrimaryPart or arg:FindFirstChildWhichIsA("BasePart")
	if not isBasePart then
		return
	end

	pcall(function()
		if arg:IsA("Model") then
			arg:PivotTo(v2.CFrame * CFrame.new(0, 0, -3))
		else
			isBasePart.CFrame = v2.CFrame * CFrame.new(0, 0, -3)
		end
	end)
end

local function fn16()
	local v2 = fn12()
	local flag = false

	for _, child in ipairs(v2:GetChildren()) do
		local v3 = fn13(child.Name, tbl4.fuel_list)

		if not v3 then
			for _, v4 in ipairs(tbl) do
				if child.Name == v4 then
					v3 = fn13(v4, tbl4.fuel_list) or fn13(child.Name, tbl4.fuel_list)
					break
				end
			end
		end

		if v3 or type(tbl4.fuel_list) == "table" and (tbl4.fuel_list[child.Name] or table.find(tbl4.fuel_list, child.Name)) then
			fn15(child)
			task.wait(0.1)
			fn14(child)
			flag = true
		end
	end

	if not flag then
		fn("auto fuel", "no eligible items found for fueling")
	end
end

local function fn17()
	for _, descendant in ipairs(Workspace:GetDescendants()) do
		if descendant:IsA("Model") and (descendant.Name:match("^Item Chest") or descendant.Name:lower():find("chest")) then
			local proximityPrompt = descendant:FindFirstChildWhichIsA("ProximityPrompt", true)

			if proximityPrompt and fireproximityprompt then
				pcall(fireproximityprompt, proximityPrompt, 3)
			end
		end
	end
end

local function fn18()
	if not tbl4.auto_cook then
		return
	end
	local v2 = fn12()

	for _, child in ipairs(v2:GetChildren()) do
		if fn13(child.Name, tbl4.cook_list) or table.find(tbl2, child.Name) and type(tbl4.cook_list) == "table" and (next(tbl4.cook_list) == nil or fn13(child.Name, tbl4.cook_list)) then
			if fn13(child.Name, tbl4.cook_list) then
				fn15(child)
				fn14(child)
			end
		end
	end
end

local function fn19()
	if not tbl4.bring_enabled then
		return
	end
	local v2 = fn12()

	for _, child in ipairs(v2:GetChildren()) do
		if fn13(child.Name, tbl4.bring_list) or table.find(tbl3, child.Name) and fn13(child.Name, tbl4.bring_list) then
			fn15(child)
		end
	end
end

local function fn20()
	if not tbl4.kill_aura then
		return
	end
	local v2 = fn7()
	if not v2 then
		return
	end
	local tool = fn6() and fn6():FindFirstChildOfClass("Tool")
	local v3 = nil

	for _, descendant in ipairs(ReplicatedStorage:GetDescendants()) do
		if (descendant:IsA("RemoteFunction") or descendant:IsA("RemoteEvent")) and descendant.Name:lower():find("damage") then
			v3 = descendant
			break
		end
	end

	for _, descendant in ipairs(Workspace:GetDescendants()) do
		if descendant:IsA("Model") and descendant:FindFirstChildOfClass("Humanoid") and descendant ~= fn6() then
			local humanoidRootPart = descendant:FindFirstChild("HumanoidRootPart") or descendant.PrimaryPart

			if humanoidRootPart and (humanoidRootPart.Position - v2.Position).Magnitude <= tbl4.kill_dist then
				if v3 then
					pcall(function()
						if v3:IsA("RemoteFunction") then
							v3:InvokeServer(descendant, tool, 999, CFrame.new(humanoidRootPart.Position))
						else
							v3:FireServer(descendant, tool, 999, CFrame.new(humanoidRootPart.Position))
						end
					end)
				end
			end
		end
	end
end

local function fn21()
	if not tbl4.auto_chop then
		return
	end
	local v2 = fn7()
	if not v2 then
		return
	end
	local map = Workspace:FindFirstChild("Map")
	local tbl7 = {}
	local foliage = map and map:FindFirstChild("Foliage")
	map = map and map:FindFirstChild("Landmarks")
	local v3 = Workspace
	tbl7[1] = foliage
	tbl7[2] = map
	tbl7[3] = v3

	for _, v4 in ipairs(tbl7) do
		if v4 then
			for _, descendant in ipairs(v4:GetDescendants()) do
				local str = descendant.Name:lower()

				if (str:find("tree") or str:find("log")) and (descendant:IsA("Model") or descendant:IsA("BasePart")) then
					local isBasePart = descendant:IsA("BasePart") and descendant or descendant.PrimaryPart or descendant:FindFirstChildWhichIsA("BasePart")

					if isBasePart and (isBasePart.Position - v2.Position).Magnitude <= tbl4.tree_dist then
						fn14(descendant)
					end
				end
			end
		end
	end
end

local function fn22()
	fn9()
	local v2 = fn12()

	for _, child in ipairs(v2:GetChildren()) do
		local name = child.Name
		local str = child.Name:lower()

		if tbl4.esp_fuel then
			for _, v3 in ipairs(tbl) do
				if name == v3 or str:find(v3:lower()) then
					fn10(child, Color3.fromRGB(255, 140, 0))
					break
				end
			end
		end

		if tbl4.esp_food then
			for _, v3 in ipairs(tbl2) do
				if name == v3 then
					fn10(child, Color3.fromRGB(0, 255, 100))
					break
				end
			end
		end

		if tbl4.esp_metal and (str:find("metal") or str:find("scrap")) then
			fn10(child, Color3.fromRGB(180, 180, 200))
		end

		if tbl4.esp_chests and (str:find("chest") or name:match("^Item Chest")) then
			fn10(child, Color3.fromRGB(255, 215, 0))
		end
	end
end

local function fn23(arg)
	if tbl5.afk then
		tbl5.afk:Disconnect()
		tbl5.afk = nil
	end

	if arg then
		local v2 = getconnections or get_signal_cons

		if v2 then
			for _, v3 in pairs(v2(localPlayer.Idled)) do
				pcall(function()
					if v3.Disable then
						v3:Disable()
					elseif v3.Disconnect then
						v3:Disconnect()
					end
				end)
			end
		end

		tbl5.afk = localPlayer.Idled:Connect(function()
			pcall(function()
				VirtualUser:CaptureController()
				VirtualUser:ClickButton2(Vector2.new())
			end)
		end)
	end
end

RunService.Heartbeat:Connect(function()
	local v2 = fn8()

	if tbl4.god_mode and v2 then
		if v2.MaxHealth < 1e9 then
			v2.MaxHealth = math.huge
		end

		v2.Health = v2.MaxHealth
	end

	if tbl4.speed_on and v2 then
		v2.WalkSpeed = tbl4.speed
	end

	if tbl4.fullbright then
		Lighting.Ambient = Color3.new(1, 1, 1)
		Lighting.Brightness = 2
		Lighting.GlobalShadows = false
		Lighting.FogEnd = 9e9
	end

	fn20()
	fn21()
end)

task.spawn(function()
	while true do
		task.wait(1.2)

		if tbl4.auto_fuel then
			pcall(fn16)
		end

		if tbl4.auto_open_chests then
			pcall(fn17)
		end

		if tbl4.auto_cook then
			pcall(fn18)
		end

		if tbl4.bring_enabled then
			pcall(fn19)
		end

		if tbl4.esp_fuel or tbl4.esp_food or tbl4.esp_metal or tbl4.esp_chests then
			pcall(fn22)
		end
	end
end)

local v2 = v:Tab({ Title = "Main", Icon = "flame" })
local v3 = v2:Section({ Title = "campfire", Icon = "flame", Opened = true })

v3:Dropdown({
	Title = "Fuel Items",
	Values = tbl,
	Value = tbl4.fuel_list,
	Multi = true,
	Callback = function(fuelList)
		tbl4.fuel_list = fuelList
	end,
})

v3:Toggle({
	Title = "Auto Fuel Campfire",
	Desc = "auto fuel campfire with selected items",
	Callback = function(autoFuel)
		tbl4.auto_fuel = autoFuel
	end,
})

v3:Button({ Title = "Fuel Campfire Once", Callback = fn16 })

v3:Button({
	Title = "Teleport to Campfire",
	Callback = function()
		local v4 = fn11()
		local v5 = fn7()

		if v4 and v5 then
			local isBasePart = v4:IsA("BasePart") and v4 or v4.PrimaryPart or v4:FindFirstChildWhichIsA("BasePart")

			if isBasePart then
				v5.CFrame = isBasePart.CFrame + Vector3.new(0, 5, 0)
			else
				fn4()
			end
		else
			fn("campfire", "campfire not found")
			fn4()
		end
	end,
})

local v4 = v2:Section({ Title = "chests & cook", Icon = "package", Opened = true })

v4:Toggle({
	Title = "Auto Open Chests",
	Callback = function(autoOpenChests)
		tbl4.auto_open_chests = autoOpenChests
	end,
})

v4:Button({ Title = "Open Chests Once", Callback = fn17 })

v4:Dropdown({
	Title = "Cook Items",
	Values = tbl2,
	Value = {},
	Multi = true,
	Callback = function(cookList)
		tbl4.cook_list = cookList
	end,
})

v4:Toggle({
	Title = "Auto Cook Food",
	Callback = function(autoCook)
		tbl4.auto_cook = autoCook
	end,
})

local v5 = v:Tab({ Title = "Bring", Icon = "package" }):Section({ Title = "bring items", Icon = "package", Opened = true })

v5:Dropdown({
	Title = "Bring List",
	Values = tbl3,
	Value = {},
	Multi = true,
	Callback = function(bringList)
		tbl4.bring_list = bringList
	end,
})

v5:Toggle({
	Title = "Bring Items",
	Desc = "pull selected items to you",
	Callback = function(bringEnabled)
		tbl4.bring_enabled = bringEnabled
	end,
})

v5:Button({
	Title = "Bring Selected Once",
	Callback = function()
		local bringEnabled = tbl4.bring_enabled
		tbl4.bring_enabled = true
		fn19()
		tbl4.bring_enabled = bringEnabled
	end,
})

v5:Button({
	Title = "Stop All Brings",
	Callback = function()
		tbl4.bring_enabled = false
	end,
})

local v6 = v:Tab({ Title = "Combat", Icon = "swords" }):Section({ Title = "aura", Icon = "skull", Opened = true })

v6:Toggle({
	Title = "Kill Aura",
	Callback = function(killAura)
		tbl4.kill_aura = killAura
	end,
})

v6:Slider({
	Title = "Kill Aura Distance",
	Value = { Min = 5, Max = 80, Default = 25 },
	Callback = function(killDist)
		tbl4.kill_dist = killDist
	end,
})

v6:Toggle({
	Title = "Auto Chop Trees",
	Callback = function(autoChop)
		tbl4.auto_chop = autoChop
	end,
})

v6:Slider({
	Title = "Tree Aura Distance",
	Value = { Min = 5, Max = 80, Default = 30 },
	Callback = function(treeDist)
		tbl4.tree_dist = treeDist
	end,
})

local v7 = v:Tab({ Title = "Player", Icon = "user" }):Section({ Title = "movement", Icon = "person-standing", Opened = true })

v7:Toggle({
	Title = "Toggle Speed",
	Callback = function(speedOn)
		tbl4.speed_on = speedOn
	end,
})

v7:Slider({
	Title = "WalkSpeed",
	Value = { Min = 16, Max = 100, Default = 24 },
	Callback = function(speed)
		tbl4.speed = speed
	end,
})

v7:Toggle({
	Title = "God Mode",
	Callback = function(godMode)
		tbl4.god_mode = godMode
	end,
})

v7:Toggle({
	Title = "Fullbright",
	Callback = function(fullbright)
		tbl4.fullbright = fullbright

		if not fullbright then
			Lighting.Ambient = Color3.fromRGB(128, 128, 128)
			Lighting.Brightness = 1
			Lighting.GlobalShadows = true
		end
	end,
})

v7:Toggle({ Title = "Anti AFK", Callback = fn23 })

v7:Button({
	Title = "Rejoin",
	Callback = function()
		TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, localPlayer)
	end,
})

local v8 = v:Tab({ Title = "ESP", Icon = "eye" }):Section({ Title = "world esp", Icon = "scan", Opened = true })

v8:Toggle({
	Title = "Players ESP",
	Desc = "highlight all players",
	Callback = function(espPlayers)
		tbl4.esp_players = espPlayers
		MainModule.toggle_player_esp(espPlayers)
	end,
})

v8:Toggle({
	Title = "Fuel ESP",
	Callback = function(espFuel)
		tbl4.esp_fuel = espFuel
		fn22()
	end,
})

v8:Toggle({
	Title = "Food ESP",
	Callback = function(espFood)
		tbl4.esp_food = espFood
		fn22()
	end,
})

v8:Toggle({
	Title = "Metal ESP",
	Callback = function(espMetal)
		tbl4.esp_metal = espMetal
		fn22()
	end,
})

v8:Toggle({
	Title = "Chests ESP",
	Callback = function(espChests)
		tbl4.esp_chests = espChests
		fn22()
	end,
})

local v9 = v:Tab({ Title = "Settings", Icon = "settings" })
local raw = v9._raw or v9
local v10 = v9:Section({ Title = "Menu", Icon = "menu", Opened = true })

task.defer(function()
	local raw2 = v10._raw or v10
	local addLabel = raw2.AddLabel and raw2:AddLabel("Menu bind") or nil
	local addKeyPicker = addLabel and addLabel.AddKeyPicker
	local MenuKeybind = nil

	if addKeyPicker then
		MenuKeybind = addLabel:AddKeyPicker("MenuKeybind", { Default = "Z", Mode = "Toggle", Text = "Menu keybind", NoUI = true })
	end

	if lib.Options and lib.Options.MenuKeybind then
		lib.ToggleKeybind = lib.Options.MenuKeybind
	elseif MenuKeybind then
		lib.ToggleKeybind = MenuKeybind
	else
		lib.ToggleKeybind = Enum.KeyCode.Z
	end
end)

v10:Dropdown({
	Title = "DPI Scale",
	Values = { "50", "75", "90", "100", "125", "150", "200" },
	Value = "100",
	Callback = function(arg)
		lib:SetDPIScale(tonumber(arg) or 100)
	end,
})

v10:Button({
	Title = "Unload Script",
	Callback = function()
		fn9()

		pcall(function()
			lib:Unload()
		end)
	end,
})

pcall(function()
	lib3:SetLibrary(lib)
	lib3:SetFolder("HollyScriptX_99Nights")
	lib3:ApplyToTab(raw)
end)

pcall(function()
	lib2:SetLibrary(lib)
	lib2:IgnoreThemeSettings()
	lib2:SetIgnoreIndexes({ "MenuKeybind" })
	lib2:SetFolder("HollyScriptX_99Nights")
	lib2:BuildConfigSection(raw)
	lib2:LoadAutoloadConfig()
end)

local v11 = v9:Section({ Title = "Credits", Icon = "heart", Opened = true })
v11:Paragraph({ Title = "whonixx - script owner" })
v11:Paragraph({ Title = "shades - script owner" })
v11:Paragraph({ Title = "insected - helped with obf/dc server" })
v11:Paragraph({ Title = "chillnie - script tester/co-owner" })
v11:Paragraph({ Title = "rezorn - script helper/developer" })

task.defer(function()
	task.wait(0.25)

	pcall(function()
		if setclipboard then
			setclipboard("https://discord.gg/hollyscriptx-1504482964661076098")
		end
	end)

	fn("hollyscriptx", "99 nights loaded")
	fn3()
end)
