-- run status: finished
-- 353 statements recorded in 5.49s
-- URLs requested:
--   https://raw.githubusercontent.com/uhfork/Obsidian/main/Library.lua
--   https://raw.githubusercontent.com/uhfork/Obsidian/main/addons/ThemeManager.lua
--   https://raw.githubusercontent.com/uhfork/Obsidian/main/addons/SaveManager.lua
--   https://raw.githubusercontent.com/eikikrkr-ux/Obsidian-test-m/main/041e94a72daeb3c9393502ee13430cdf.png

-- [deobf] folded 0 repeated calls into 0 helper functions and 1 unrolled runs into loops
task.spawn(function()
end)

task.spawn(function()
end)

task.delay(286, function()
	-- [envlog] cancelled before it ran
end)

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
Frame.Position = UDim2.new(0, 0, 0, 0)
Frame.Size = UDim2.new(0, 126, 0, 254)
Frame.Parent = ScreenGui
local Path2D = Instance.new("Path2D")
Path2D.Parent = Frame
Path2D:SetControlPoints({ Path2DControlPoint.new(UDim2.new(0.5, -3, 0.0625, 6), UDim2.new(0, 0, 0, 0), UDim2.new(0, -8, 0, -4)), Path2DControlPoint.new(UDim2.new(0, 2, 0.25, 2), UDim2.new(0, 0, 0, 0), UDim2.new(0, -7, -0.0625, 0)), Path2DControlPoint.new(UDim2.new(0.25, 8, 0, -1), UDim2.new(0, 0, 0, 0), UDim2.new(0, 2, 0, 7)), Path2DControlPoint.new(UDim2.new(0, 3, 0.4375, 7), UDim2.new(-0.125, -3, 0, 0), UDim2.new(0, 0, 0, 0)) })
Path2D:GetLength()
Path2D:GetPositionOnCurve(0.60000002384185791)
Path2D:GetPositionOnCurve(0.5)
Path2D:GetPositionOnCurve(0.375)
Path2D:GetTangentOnCurve(0.83333331346511841)
Path2D:GetTangentOnCurve(0.77777779102325439)
Path2D:GetTangentOnCurve(0.57142859697341919)
Path2D:GetTangentOnCurve(0.8461538553237915)
Path2D:GetPositionOnCurveArcLength(0.875)
Path2D:GetPositionOnCurveArcLength(0.3333333432674408)
Path2D:GetTangentOnCurveArcLength(0.66666668653488159)
Path2D:GetTangentOnCurveArcLength(0.5)
Path2D:GetTangentOnCurveArcLength(0.80000001192092896)
ScreenGui:Destroy()

local connection = game.DescendantRemoving:Connect(function(descendant)
end)

connection:Disconnect()

local connection2 = workspace.DescendantRemoving:Connect(function(descendant2)
end)

connection2:Disconnect()
local Folder = Instance.new("Folder")

local connection3 = Folder.DescendantRemoving:Connect(function(descendant3)
end)

connection3:Disconnect()
Folder:GetChildren()
Folder:Destroy()
local Folder2 = Instance.new("Folder", Folder)

local connection4 = Folder2.DescendantRemoving:Connect(function(descendant4)
end)

connection4:Disconnect()
Folder2.Name = "1358630246"
Folder:WaitForChild("1358630246")
Folder:Destroy()
Folder2:Destroy()
local HttpService = game:GetService("HttpService")

local connection5 = HttpService.DescendantRemoving:Connect(function(descendant5)
end)

connection5:Disconnect()
local RunService = game:GetService("RunService")

local connection6 = RunService.DescendantRemoving:Connect(function(descendant6)
end)

connection6:Disconnect()
-- loadstring() of 2438 bytes: " --[[\n\t\t\t\t .@%(/*,.......      ...,,*/(#%&@@.\n\t\t\t (*   ,/(#%%&&@@@@&%((////(((##%###((/**,,.     ,//(&.\n\t\t   /* .%@@@@@@@@%,  .(&@@@&&&&&&@@@@@@&#(*,........*%@@@(.  ,#.\n\t\t */ .&@@@@@@@*  (%,   *(&&@@"
local response = game:HttpGet("https://raw.githubusercontent.com/uhfork/Obsidian/main/Library.lua")
local Obsidian = loadstring(response)()
local response2 = game:HttpGet("https://raw.githubusercontent.com/uhfork/Obsidian/main/addons/ThemeManager.lua")
local Obsidian2 = loadstring(response2)()
local response3 = game:HttpGet("https://raw.githubusercontent.com/uhfork/Obsidian/main/addons/SaveManager.lua")
local Obsidian3 = loadstring(response3)()
-- isfile("Holy.png") -> false
local response4 = game:HttpGet("https://raw.githubusercontent.com/eikikrkr-ux/Obsidian-test-m/main/041e94a72daeb3c9393502ee13430cdf.png")
writefile("Holy.png", response4)
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ProximityPromptService = game:GetService("ProximityPromptService")
local Circle = Drawing.new("Circle")
Circle.Thickness = 1.5
Circle.NumSides = 64
Circle.Radius = 250
Circle.Filled = false
Circle.Transparency = 1
Circle.Color = Color3.fromRGB(255, 255, 255)
Circle.Visible = true
local SD_Assets = ReplicatedStorage:FindFirstChild("SD_Assets")
SD_Assets:FindFirstChild("GameConfig")
require(SD_Assets.GameConfig)
SD_Assets:FindFirstChild("Modules")
SD_Assets.Modules:FindFirstChild("BulletPhysics")
require(SD_Assets.Modules.BulletPhysics)

ReplicatedStorage.DescendantAdded:Connect(function(descendant7)
end)

local attributeChangedSignal = Players.LocalPlayer:GetAttributeChangedSignal("RecoilPercent")

attributeChangedSignal:Connect(function()
end)

task.spawn(function()
	local Backpack = Players.LocalPlayer:WaitForChild("Backpack", 10)

	Backpack.ChildAdded:Connect(function(child)
	end)
end)

Players.LocalPlayer.Character.ChildAdded:Connect(function(child2)
end)

local children = Players.LocalPlayer.Character:GetChildren()

for i, v in ipairs(children) do
	local descendants = v:GetDescendants()

	for i2, v2 in ipairs(descendants) do
		require(v2)
	end
end

Players.LocalPlayer.CharacterAdded:Connect(function(character)
	character.ChildAdded:Connect(function(child3)
	end)

	local children10 = character:GetChildren()

	for i23, v23 in ipairs(children10) do
		local descendants11 = v23:GetDescendants()

		for i24, v24 in ipairs(descendants11) do
			require(v24)
		end
	end
end)

ProximityPromptService.PromptShown:Connect(function()
end)

task.spawn(function()
	task.wait(0.1)
	task.wait(0.1)
	-- [envlog] the statements above repeat forever (loop)
end)

local Window = Obsidian:CreateWindow({
	Title = "HolyscriptsX",
	Compact = true,
	CornerRadius = 8,
	Footer = "discord.gg/hollyscriptx-1504482964661076098| detour",
	Icon = "rbxasset://Holy.png",
	NotifySide = "Right",
	ShowCustomCursor = true,
	Size = UDim2.fromOffset(600, 500)
})

local Tab = Window:AddTab("Main", "gamepad")
local Tab2 = Window:AddTab("Combat", "crosshair")
local Tab3 = Window:AddTab("Visuals", "eye")
local Tab4 = Window:AddTab("Misc", "user")
local Tab5 = Window:AddTab("Settings", "settings")
local LeftGroupbox = Tab:AddLeftGroupbox("Weapon Mods")

LeftGroupbox:AddToggle("NoRecoilToggle", {
	Text = "No Recoil",
	Default = false,
	Callback = function(state)
		if state then
			Players.LocalPlayer:SetAttribute("RecoilPercent", 0)
			local Backpack2 = Players.LocalPlayer:FindFirstChild("Backpack")
			local children2 = Backpack2:GetChildren()

			for i3, v3 in ipairs(children2) do
				local descendants2 = v3:GetDescendants()

				for i4, v4 in ipairs(descendants2) do
					require(v4)
				end
			end

			local children3 = Players.LocalPlayer.Character:GetChildren()

			for i5, v5 in ipairs(children3) do
				local descendants3 = v5:GetDescendants()

				for i6, v6 in ipairs(descendants3) do
					require(v6)
				end
			end
		else
			local Backpack3 = Players.LocalPlayer:FindFirstChild("Backpack")
			local children4 = Backpack3:GetChildren()

			for i7, v7 in ipairs(children4) do
				local descendants4 = v7:GetDescendants()

				for i8, v8 in ipairs(descendants4) do
					require(v8)
				end
			end

			local children5 = Players.LocalPlayer.Character:GetChildren()

			for i9, v9 in ipairs(children5) do
				local descendants5 = v9:GetDescendants()

				for i10, v10 in ipairs(descendants5) do
					require(v10)
				end
			end
		end
	end
})

LeftGroupbox:AddToggle("NoSpreadToggle", {
	Text = "No Spread",
	Default = false,
	Callback = function(state)
		if state then
			local Backpack4 = Players.LocalPlayer:FindFirstChild("Backpack")
			local children6 = Backpack4:GetChildren()

			for i11, v11 in ipairs(children6) do
				local descendants6 = v11:GetDescendants()

				for i12, v12 in ipairs(descendants6) do
					require(v12)
				end
			end

			local children7 = Players.LocalPlayer.Character:GetChildren()

			for i13, v13 in ipairs(children7) do
				local descendants7 = v13:GetDescendants()

				for i14, v14 in ipairs(descendants7) do
					require(v14)
				end
			end
		else
			local Backpack5 = Players.LocalPlayer:FindFirstChild("Backpack")
			local children8 = Backpack5:GetChildren()

			for i15, v15 in ipairs(children8) do
				local descendants8 = v15:GetDescendants()

				for i16, v16 in ipairs(descendants8) do
					require(v16)
				end
			end

			local children9 = Players.LocalPlayer.Character:GetChildren()

			for i17, v17 in ipairs(children9) do
				local descendants9 = v17:GetDescendants()

				for i18, v18 in ipairs(descendants9) do
					require(v18)
				end
			end
		end
	end
})

LeftGroupbox:AddToggle("FastMeleeToggle", {
	Text = "Fast Melee",
	Default = false,
	Callback = function(state)
		if state then
			ReplicatedStorage:FindFirstChild("Assets")
			local Items = ReplicatedStorage.Assets:FindFirstChild("Items")
			local descendants10 = Items:GetDescendants()

			for i19, v19 in ipairs(descendants10) do
			end
		end
	end
})

local RightGroupbox = Tab:AddRightGroupbox("Automation")

RightGroupbox:AddToggle("AutoPickupToggle", {
	Text = "auto pick up weapon",
	Default = false,
	Callback = function()
	end
})

local LeftGroupbox2 = Tab2:AddLeftGroupbox("Silent Aim")

for _, item in ipairs({
	{ text = "SilentAimToggle", text2 = "Silent Aim" },
	{ text = "ShowFOVToggle", text2 = "Show FOV Circle" },
	{ text = "TeamCheckToggle", text2 = "Team Check" },
	{ text = "WallCheckToggle", text2 = "Wall Check" },
}) do
	LeftGroupbox2:AddToggle(item.text, {
		Text = item.text2,
		Default = true,
		Callback = function()
		end
	})
end

LeftGroupbox2:AddSlider("FOVZone", {
	Text = "Silent Aim FOV",
	Default = 250,
	Max = 800,
	Min = 10,
	Rounding = 0,
	Callback = function()
	end
})

LeftGroupbox2:AddDropdown("HitPartSelect", {
	Text = "Target Part",
	Default = 1,
	Multi = false,
	Values = { "Head", "HumanoidRootPart" },
	Callback = function()
	end
})

local LeftGroupbox3 = Tab3:AddLeftGroupbox("ESP")

LeftGroupbox3:AddToggle("ESPToggle", {
	Text = "Role ESP",
	Default = false,
	Callback = function()
	end
})

LeftGroupbox3:AddToggle("ESPTeamCheckToggle", {
	Text = "Ignore Teammates",
	Default = false,
	Callback = function()
	end
})

local LeftGroupbox4 = Tab4:AddLeftGroupbox("Player Teleport")

local Dropdown = LeftGroupbox4:AddDropdown("PlayerSelectDropdown", {
	Text = "Select Target",
	Default = 1,
	Multi = false,
	Values = { "None" },
	Callback = function()
	end
})

LeftGroupbox4:AddButton({
	Text = "Teleport to Player",
	Func = function()
	end
})

task.spawn(function()
	task.wait(2)
	local players = Players:GetPlayers()

	for i20, v20 in ipairs(players) do
		v20:GetAttribute("Role")
		v20.Character:GetAttribute("Role")
		v20:FindFirstChild("Role")
		string.upper(tostring(string.upper(v20.Team.Name))):find("KILL")
	end

	Dropdown:SetValues({ string.format("%s(killer)", v20.Name) })
	task.wait(2)
	local players2 = Players:GetPlayers()

	for i21, v21 in ipairs(players2) do
		v21:GetAttribute("Role")
		v21.Character:GetAttribute("Role")
		v21:FindFirstChild("Role")
		string.upper(tostring(string.upper(v21.Team.Name))):find("KILL")
	end

	Dropdown:SetValues({ string.format("%s(killer)", v21.Name) })
	task.wait(2)
	-- [envlog] the statements above repeat forever (loop)
end)

local RightGroupbox2 = Tab4:AddRightGroupbox("Touch Fling")

RightGroupbox2:AddToggle("TouchFlingToggle", {
	Text = "Touch Fling",
	Default = false,
	Callback = function(state)
		if state then
			task.spawn(function()
				RunService.Heartbeat:Wait()
				local HumanoidRootPart = Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
				HumanoidRootPart.Velocity = ((HumanoidRootPart.Velocity * 10000) + Vector3.new(0, 10000, 0))
				RunService.RenderStepped:Wait()
				HumanoidRootPart.Velocity = HumanoidRootPart.Velocity
				RunService.Stepped:Wait()
				HumanoidRootPart.Velocity = (HumanoidRootPart.Velocity + Vector3.new(0, 0.10000000149011612, 0))
				RunService.Heartbeat:Wait()
				local HumanoidRootPart2 = Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
				HumanoidRootPart2.Velocity = ((HumanoidRootPart2.Velocity * 10000) + Vector3.new(0, 10000, 0))
				RunService.RenderStepped:Wait()
				HumanoidRootPart2.Velocity = HumanoidRootPart2.Velocity
				RunService.Stepped:Wait()
				HumanoidRootPart2.Velocity = (HumanoidRootPart2.Velocity + Vector3.new(0, -0.10000000149011612, 0))
				RunService.Heartbeat:Wait()
				local HumanoidRootPart3 = Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
				HumanoidRootPart3.Velocity = ((HumanoidRootPart3.Velocity * 10000) + Vector3.new(0, 10000, 0))
				RunService.RenderStepped:Wait()
				HumanoidRootPart3.Velocity = HumanoidRootPart3.Velocity
				RunService.Stepped:Wait()
				HumanoidRootPart3.Velocity = (HumanoidRootPart3.Velocity + Vector3.new(0, 0.10000000149011612, 0))
				RunService.Heartbeat:Wait()
				local HumanoidRootPart4 = Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
				HumanoidRootPart4.Velocity = ((HumanoidRootPart4.Velocity * 10000) + Vector3.new(0, 10000, 0))
				RunService.RenderStepped:Wait()
				HumanoidRootPart4.Velocity = HumanoidRootPart4.Velocity
				RunService.Stepped:Wait()
				HumanoidRootPart4.Velocity = (HumanoidRootPart4.Velocity + Vector3.new(0, -0.10000000149011612, 0))
				RunService.Heartbeat:Wait()
				local HumanoidRootPart5 = Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
				HumanoidRootPart5.Velocity = ((HumanoidRootPart5.Velocity * 10000) + Vector3.new(0, 10000, 0))
				RunService.RenderStepped:Wait()
				HumanoidRootPart5.Velocity = HumanoidRootPart5.Velocity
				RunService.Stepped:Wait()
				HumanoidRootPart5.Velocity = (HumanoidRootPart5.Velocity + Vector3.new(0, 0.10000000149011612, 0))
				RunService.Heartbeat:Wait()
				local HumanoidRootPart6 = Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
				HumanoidRootPart6.Velocity = ((HumanoidRootPart6.Velocity * 10000) + Vector3.new(0, 10000, 0))
				RunService.RenderStepped:Wait()
				HumanoidRootPart6.Velocity = HumanoidRootPart6.Velocity
				RunService.Stepped:Wait()
				HumanoidRootPart6.Velocity = (HumanoidRootPart6.Velocity + Vector3.new(0, -0.10000000149011612, 0))
				RunService.Heartbeat:Wait()
				local HumanoidRootPart7 = Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
				HumanoidRootPart7.Velocity = ((HumanoidRootPart7.Velocity * 10000) + Vector3.new(0, 10000, 0))
				RunService.RenderStepped:Wait()
				HumanoidRootPart7.Velocity = HumanoidRootPart7.Velocity
				RunService.Stepped:Wait()
				HumanoidRootPart7.Velocity = (HumanoidRootPart7.Velocity + Vector3.new(0, 0.10000000149011612, 0))
				RunService.Heartbeat:Wait()
				local HumanoidRootPart8 = Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
				HumanoidRootPart8.Velocity = ((HumanoidRootPart8.Velocity * 10000) + Vector3.new(0, 10000, 0))
				RunService.RenderStepped:Wait()
				HumanoidRootPart8.Velocity = HumanoidRootPart8.Velocity
				RunService.Stepped:Wait()
				HumanoidRootPart8.Velocity = (HumanoidRootPart8.Velocity + Vector3.new(0, -0.10000000149011612, 0))
				RunService.Heartbeat:Wait()
				local HumanoidRootPart9 = Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
				HumanoidRootPart9.Velocity = ((HumanoidRootPart9.Velocity * 10000) + Vector3.new(0, 10000, 0))
				RunService.RenderStepped:Wait()
				HumanoidRootPart9.Velocity = HumanoidRootPart9.Velocity
				RunService.Stepped:Wait()
				HumanoidRootPart9.Velocity = (HumanoidRootPart9.Velocity + Vector3.new(0, 0.10000000149011612, 0))
				RunService.Heartbeat:Wait()
				local HumanoidRootPart10 = Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
				HumanoidRootPart10.Velocity = ((HumanoidRootPart10.Velocity * 10000) + Vector3.new(0, 10000, 0))
				RunService.RenderStepped:Wait()
				HumanoidRootPart10.Velocity = HumanoidRootPart10.Velocity
				RunService.Stepped:Wait()
				HumanoidRootPart10.Velocity = (HumanoidRootPart10.Velocity + Vector3.new(0, -0.10000000149011612, 0))
				RunService.Heartbeat:Wait()
				local HumanoidRootPart11 = Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
				HumanoidRootPart11.Velocity = ((HumanoidRootPart11.Velocity * 10000) + Vector3.new(0, 10000, 0))
				RunService.RenderStepped:Wait()
				HumanoidRootPart11.Velocity = HumanoidRootPart11.Velocity
				RunService.Stepped:Wait()
				HumanoidRootPart11.Velocity = (HumanoidRootPart11.Velocity + Vector3.new(0, 0.10000000149011612, 0))
				RunService.Heartbeat:Wait()
				local HumanoidRootPart12 = Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
				HumanoidRootPart12.Velocity = ((HumanoidRootPart12.Velocity * 10000) + Vector3.new(0, 10000, 0))
				RunService.RenderStepped:Wait()
				HumanoidRootPart12.Velocity = HumanoidRootPart12.Velocity
				RunService.Stepped:Wait()
				HumanoidRootPart12.Velocity = (HumanoidRootPart12.Velocity + Vector3.new(0, -0.10000000149011612, 0))
				RunService.Heartbeat:Wait()
				local HumanoidRootPart13 = Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
				HumanoidRootPart13.Velocity = ((HumanoidRootPart13.Velocity * 10000) + Vector3.new(0, 10000, 0))
				RunService.RenderStepped:Wait()
				HumanoidRootPart13.Velocity = HumanoidRootPart13.Velocity
				RunService.Stepped:Wait()
				HumanoidRootPart13.Velocity = (HumanoidRootPart13.Velocity + Vector3.new(0, 0.10000000149011612, 0))
				RunService.Heartbeat:Wait()
				local HumanoidRootPart14 = Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
				HumanoidRootPart14.Velocity = ((HumanoidRootPart14.Velocity * 10000) + Vector3.new(0, 10000, 0))
				RunService.RenderStepped:Wait()
				HumanoidRootPart14.Velocity = HumanoidRootPart14.Velocity
				RunService.Stepped:Wait()
				HumanoidRootPart14.Velocity = (HumanoidRootPart14.Velocity + Vector3.new(0, -0.10000000149011612, 0))
				RunService.Heartbeat:Wait()
				local HumanoidRootPart15 = Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
				HumanoidRootPart15.Velocity = ((HumanoidRootPart15.Velocity * 10000) + Vector3.new(0, 10000, 0))
				RunService.RenderStepped:Wait()
				HumanoidRootPart15.Velocity = HumanoidRootPart15.Velocity
				RunService.Stepped:Wait()
				HumanoidRootPart15.Velocity = (HumanoidRootPart15.Velocity + Vector3.new(0, 0.10000000149011612, 0))
				RunService.Heartbeat:Wait()
				local HumanoidRootPart16 = Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
				HumanoidRootPart16.Velocity = ((HumanoidRootPart16.Velocity * 10000) + Vector3.new(0, 10000, 0))
				RunService.RenderStepped:Wait()
				HumanoidRootPart16.Velocity = HumanoidRootPart16.Velocity
				RunService.Stepped:Wait()
				HumanoidRootPart16.Velocity = (HumanoidRootPart16.Velocity + Vector3.new(0, -0.10000000149011612, 0))
				RunService.Heartbeat:Wait()
				local HumanoidRootPart17 = Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
				HumanoidRootPart17.Velocity = ((HumanoidRootPart17.Velocity * 10000) + Vector3.new(0, 10000, 0))
				RunService.RenderStepped:Wait()
				HumanoidRootPart17.Velocity = HumanoidRootPart17.Velocity
				RunService.Stepped:Wait()
				-- [envlog] stopped after 50 waits
			end)
		end
	end
})

RightGroupbox2:AddToggle("FlingTargetOnlyToggle", {
	Text = "Target only killer and maniac",
	Default = false,
	Callback = function()
	end
})

RightGroupbox2:AddToggle("FlingAutoTPToggle", {
	Text = "Auto TP to killer/maniac",
	Default = false,
	Callback = function()
	end
})

RunService.RenderStepped:Connect(function(deltaTime)
	Circle.Visible = false
	Circle.Radius = false
	Circle.Position = (workspace.CurrentCamera.ViewportSize / 2)
	local players3 = Players:GetPlayers()

	for i25, v25 in ipairs(players3) do
		v25.Character:FindFirstChild("Humanoid")
		local TeamESP = v25.Character:FindFirstChild("TeamESP")
		TeamESP.Enabled = false
	end
end)

SD_Assets:FindFirstChild("Modules")
SD_Assets.Modules:FindFirstChild("BulletHandler")
local module = require(SD_Assets.Modules.BulletHandler)

module.FireFX = function(arg37, arg38)
	arg37:FireFX(arg38)
end

task.spawn(function()
	task.wait(1)
	task.wait(3)
	task.wait(6)
end)

Players.LocalPlayer.CharacterAdded:Connect(function(character2)
	task.delay(2, function()
	end)

	task.delay(5, function()
	end)

	task.delay(9, function()
	end)
end)

Obsidian2:SetLibrary(Obsidian)
Obsidian3:SetLibrary(Obsidian)
Obsidian3:IgnoreThemeSettings()
Obsidian3:SetIgnoreIndexes({})
Obsidian2:SetFolder("HollyScriptX")
Obsidian3:SetFolder("HollyScriptX/configs")
Obsidian3:BuildConfigSection(Tab5)
Obsidian2:ApplyToTab(Tab5)
Obsidian3:LoadAutoloadConfig()
