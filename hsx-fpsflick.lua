-- leak by uwustudios discord.gg/uwustudios
if not game:IsLoaded() then
	game.Loaded:Wait()
end

local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/refs/heads/main/Library.lua"))()

local v = lib:CreateWindow({
	Title = "HollyScriptX",
	Footer = "Z to close/open.",
	ToggleKeybind = Enum.KeyCode.Z,
	Center = true,
	AutoShow = true,
})

lib:Notify({ Title = "HollyScriptX", Description = "HollyScriptX loaded successfully! ✅", Time = 5 })
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local localPlayer = Players.LocalPlayer

while not localPlayer do
	task.wait()
	localPlayer = Players.LocalPlayer
end

local currentCamera = Workspace.CurrentCamera

while not currentCamera do
	Workspace:GetPropertyChangedSignal("CurrentCamera"):Wait()
	currentCamera = Workspace.CurrentCamera
end

local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
	if Workspace.CurrentCamera then
		currentCamera = Workspace.CurrentCamera
	end
end)

localPlayer.CharacterAdded:Connect(function(character2)
	character = character2
	humanoid = character2:WaitForChild("Humanoid")
	humanoidRootPart = character2:WaitForChild("HumanoidRootPart")

	if Workspace.CurrentCamera then
		currentCamera = Workspace.CurrentCamera
	end
end)

local Combat = v:AddTab("Combat", "crosshair")
local esp = v:AddTab("ESP", "eye")
local Misc = v:AddTab("Misc", "wrench")
local Aimbot = Combat:AddLeftGroupbox("Aimbot", "crosshair")
local Triggerbot = Combat:AddRightGroupbox("Triggerbot", "bot")
local v2 = Combat:AddRightGroupbox("Gun Mods", "wrench")
local flag = false
local flag2 = false
local n = 50

local v3 = Triggerbot:AddToggle("", {
	Text = "Enable Triggerbot",
	Default = false,
	Tooltip = "Automatically shoots when enemy is in the center of screen.",
	Callback = function(arg)
		flag = arg
	end,
})

local v4 = Triggerbot:AddToggle("", {
	Text = "Visibility Check",
	Default = false,
	Tooltip = "Checks to make sure enemy is visible.",
	Callback = function(arg)
		flag2 = arg
	end,
})

Triggerbot:AddDivider()

Triggerbot:AddSlider("", {
	Text = "Delay Time (MS)",
	Default = 50,
	Min = 0,
	Max = 1000,
	Rounding = 0,
	Compact = false,
	Callback = function(arg)
		n = arg
	end,
})

local n2 = 6

local function fn(arg)
	local v5, v6 = currentCamera:WorldToViewportPoint(arg.Position)
	if not v6 then
		return false
	end
	local n3 = currentCamera.ViewportSize.X / 2
	local n4 = currentCamera.ViewportSize.Y / 2
	return (Vector2.new(v5.X, v5.Y) - Vector2.new(n3, n4)).Magnitude <= n2
end

local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Blacklist

local function fn2(arg)
	raycastParams.FilterDescendantsInstances = { localPlayer.Character }
	local position = currentCamera.CFrame.Position
	local hit = Workspace:Raycast(position, arg.Position - position, raycastParams)
	if not hit then
		return false
	end
	return hit.Instance:IsDescendantOf(arg.Parent)
end

RunService.RenderStepped:Connect(function()
	if not flag then
		return
	end
	local currentCamera2 = workspace.CurrentCamera
	if not currentCamera2 then
		return
	end

	if (currentCamera2.CFrame.Position - currentCamera2.Focus.Position).Magnitude >= 1 then
		return
	end

	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= localPlayer and player.Character then
			local exitTo = nil

			for _, descendant in ipairs(player.Character:GetDescendants()) do
				if descendant:IsA("BasePart") then
					if fn(descendant) then
						if flag2 then
							if fn2(descendant) then
								exitTo = 1
								break
							end
						else
							exitTo = 1
							break
						end
					end
				end
			end

			if exitTo == 1 then
				if n > 0 then
					task.delay(n / 1000, function()
						mouse1click()
					end)
				else
					mouse1click()
				end

				return
			end
		end
	end
end)

local tbl = {
	Enabled = false,
	VisibilityCheck = false,
	Smoothness = 5,
	Bone = "Head",
	Priority = "Closest to Crosshair",
	FOV = 50,
	RainbowFOV = false,
	Ragebot = false,
}

local connection = nil
local color = Color3.fromRGB(255, 0, 0)
local circle = Drawing.new("Circle")
circle.Thickness = 2
circle.NumSides = 64
circle.Radius = tbl.FOV
circle.Filled = false
circle.Visible = true
circle.Color = color

local function fn3()
	return Color3.fromHSV(tick() % 5 / 5, 1, 1)
end

RunService.RenderStepped:Connect(function()
	local viewportSize = currentCamera.ViewportSize
	circle.Position = Vector2.new(viewportSize.X / 2, viewportSize.Y / 2)
	circle.Radius = tbl.FOV

	if tbl.RainbowFOV then
		circle.Color = fn3()
	else
		circle.Color = color
	end

	circle.Visible = tbl.ShowFOV
end)

tbl.ShowFOV = true

tbl.IsFirstPerson = function()
	local currentCamera2 = workspace.CurrentCamera
	if not currentCamera2 then
		return false
	end
	return (currentCamera2.CFrame.Position - currentCamera2.Focus.Position).Magnitude < 1
end

local function fn4(arg)
	if not arg or not arg:IsDescendantOf(workspace) then
		return false
	end
	local position = currentCamera.CFrame.Position
	local n3 = arg.Position - position
	local raycastParams2 = RaycastParams.new()
	raycastParams2.FilterType = Enum.RaycastFilterType.Blacklist
	raycastParams2.FilterDescendantsInstances = { localPlayer.Character }
	local hit = workspace:Raycast(position, n3, raycastParams2)
	if hit then
		return hit.Instance:IsDescendantOf(arg.Parent)
	end
	return false
end

local function fn5(arg)
	if not arg then
		return nil
	end

	if tbl.Bone == "Torso" then
		return arg:FindFirstChild("UpperTorso") or arg:FindFirstChild("HumanoidRootPart")
	end
	return arg:FindFirstChild("Head") or arg:FindFirstChild("UpperTorso") or arg:FindFirstChild("HumanoidRootPart")
end

local function fn6()
	local position = currentCamera.CFrame.Position
	local viewportSize = currentCamera.ViewportSize
	local vector2 = Vector2.new(viewportSize.X / 2, viewportSize.Y / 2)
	local humanoidRootPart2 = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
	humanoidRootPart2 = humanoidRootPart2 and humanoidRootPart2.Position or position
	local huge = math.huge
	local v5 = nil

	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= localPlayer then
			local character2 = player.Character

			if character2 then
				local humanoid2 = character2:FindFirstChildOfClass("Humanoid")

				if humanoid2 and humanoid2.Health > 0 then
					local v6 = fn5(character2)

					if v6 and (not tbl.VisibilityCheck or fn4(v6)) then
						if tbl.Ragebot then
							local magnitude = (v6.Position - humanoidRootPart2).Magnitude

							if magnitude < huge then
								huge = magnitude
								v5 = v6
							end
						else
							local v7, v8 = currentCamera:WorldToViewportPoint(v6.Position)

							if v8 then
								local magnitude = (Vector2.new(v7.X, v7.Y) - vector2).Magnitude
								local magnitude2 = (v6.Position - position).Magnitude

								if magnitude <= tbl.FOV then
									magnitude2 = tbl.Priority == "Closest Distance" and magnitude2 or magnitude

									if magnitude2 < huge then
										huge = magnitude2
										v5 = v6
									end
								end
							end
						end
					end
				end
			end
		end
	end

	return v5
end

local flag3 = false
local connection2 = nil
local rotation = nil
local flag4 = false
local flag5 = false

local v5 = Aimbot:AddToggle("", {
	Text = "Enable Aimbot",
	Default = false,
	Tooltip = "Automatically aims at enemies.",
	Callback = function(enabled)
		tbl.Enabled = enabled

		if enabled then
			if not connection then
				connection = RunService.RenderStepped:Connect(function()
					if not tbl.Enabled then
						return
					end

					if not tbl:IsFirstPerson() then
						return
					end
					local v5 = fn6()
					if not v5 then
						return
					end
					local cframe = CFrame.new(currentCamera.CFrame.Position, v5.Position)

					if tbl.Ragebot then
						currentCamera.CFrame = cframe
					else
						currentCamera.CFrame = currentCamera.CFrame:Lerp(cframe, 1 / tbl.Smoothness)
					end
				end)
			end
		elseif connection then
			connection:Disconnect()
			connection = nil
		end
	end,
})

Aimbot:AddToggle("", {
	Text = "Show FOV",
	Default = true,
	Tooltip = "Shows the FOV circle.",
	Callback = function(showFOV)
		tbl.ShowFOV = showFOV
		circle.Visible = showFOV
	end,
}):AddColorPicker("", {
	Default = Color3.fromRGB(255, 0, 0),
	Title = "FOV Color",
	Transparency = 0,
	Callback = function(color2)
		color = color2
		circle.Color = color2
	end,
})

local v6 = Aimbot:AddToggle("", {
	Text = "Visibility Check",
	Default = false,
	Callback = function(visibilityCheck)
		tbl.VisibilityCheck = visibilityCheck
	end,
})

Aimbot:AddDivider()

Aimbot:AddSlider("", {
	Text = "Smoothness",
	Default = 5,
	Min = 1,
	Max = 15,
	Callback = function(smoothness)
		tbl.Smoothness = smoothness
	end,
})

Aimbot:AddDropdown("", {
	Text = "Bone Target",
	Values = { "Head", "Torso" },
	Default = 1,
	Callback = function(bone)
		tbl.Bone = bone
	end,
})

Aimbot:AddDropdown("", {
	Text = "Target Priority",
	Values = { "Closest to Crosshair", "Closest Distance" },
	Default = 1,
	Callback = function(priority)
		tbl.Priority = priority
	end,
})

Aimbot:AddDivider()

Aimbot:AddSlider("", {
	Text = "FOV Size",
	Default = 50,
	Min = 10,
	Max = 500,
	Callback = function(fov)
		tbl.FOV = fov
	end,
})

Aimbot:AddToggle("", {
	Text = "Rainbow FOV",
	Default = false,
	Callback = function(rainbowFOV)
		tbl.RainbowFOV = rainbowFOV
	end,
})

Aimbot:AddDivider()

Aimbot:AddToggle("", {
	Text = "Ragebot (Detected)",
	Default = false,
	Tooltip = "Snaps instantly to enemies.",
	Callback = function(ragebot)
		tbl.Ragebot = ragebot

		if v5 and v5.SetValue then
			v5:SetValue(ragebot)
		end

		if v3 and v3.SetValue then
			v3:SetValue(ragebot)
		end

		if v6 and v6.SetValue then
			v6:SetValue(ragebot)
		end

		if v4 and v4.SetValue then
			v4:SetValue(ragebot)
		end

		if not ragebot then
			tbl.Ragebot = false
			tbl.Enabled = false
			tbl.VisibilityCheck = false
			flag = false
			flag2 = false
		end
	end,
})

Aimbot:AddDivider()

UserInputService.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		if input.Delta.Magnitude > 0.5 then
			flag5 = true
		end
	end
end)

UserInputService.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		flag4 = true
		flag5 = false
		rotation = currentCamera.CFrame.Rotation
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		flag4 = false
	end
end)

v2:AddToggle("", {
	Text = "Recoil Auto Fix",
	Default = false,
	Tooltip = "Automatically brings recoil back down.",
	Callback = function(arg)
		flag3 = arg

		if arg then
			if not connection2 then
				connection2 = RunService.RenderStepped:Connect(function()
					if not flag3 then
						return
					end

					if not rotation then
						return
					end

					if not flag4 and not flag5 then
						local cFrame = currentCamera.CFrame
						currentCamera.CFrame = cFrame:Lerp(CFrame.new(cFrame.Position) * rotation, 0.15)
					end
				end)
			end
		elseif connection2 then
			connection2:Disconnect()
			connection2 = nil
		end
	end,
})

local connection3 = nil
local flag6 = false

v2:AddToggle("", {
	Text = "Instant Scope",
	Default = false,
	Tooltip = "Instant scopes in and removes delay (visual only).",
	Callback = function(arg)
		flag6 = arg

		if not arg then
			if connection3 then
				connection3:Disconnect()
				connection3 = nil
			end

			currentCamera.FieldOfView = 100
			return
		end

		connection3 = RunService.RenderStepped:Connect(function()
			if not flag6 then
				return
			end

			if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
				currentCamera.FieldOfView = 50
			else
				currentCamera.FieldOfView = 100
			end
		end)
	end,
})

local Enemy = esp:AddLeftGroupbox("Enemy", "user")
Enemy.MaxDistance = 500

Enemy.IsInRange = function(arg, arg2)
	local character2 = localPlayer.Character
	arg2 = arg2 and arg2.Character
	character2 = character2 and character2:FindFirstChild("HumanoidRootPart")
	arg2 = arg2 and arg2:FindFirstChild("HumanoidRootPart")
	return character2 ~= nil and arg2 ~= nil and (character2.Position - arg2.Position).Magnitude <= arg.MaxDistance
end

Players.PlayerRemoving:Connect(function(player)
	if Boxes and Boxes[player] then
		Boxes[player].Box:Remove()
		Boxes[player].Outline:Remove()
		Boxes[player] = nil
	end

	if Highlights and Highlights[player] then
		Highlights[player]:Destroy()
		Highlights[player] = nil
	end

	if Tracers and Tracers[player] then
		Tracers[player].Line:Remove()
		Tracers[player].Outline:Remove()
		Tracers[player] = nil
	end

	if NameESP and NameESP[player] then
		NameESP[player].NameText:Remove()
		NameESP[player].NameOutline:Remove()
		NameESP[player].DistText:Remove()
		NameESP[player].DistOutline:Remove()
		NameESP[player] = nil
	end
end)

local tbl2 = {}
local color2 = Color3.fromRGB(255, 0, 0)

local function fn7(arg)
	if tbl2[arg] then
		tbl2[arg].Box:Remove()
		tbl2[arg].Outline:Remove()
		tbl2[arg] = nil
	end
end

local function fn8(arg)
	local square = Drawing.new("Square")
	square.Visible = false
	square.Color = color2
	square.Thickness = 3
	square.Filled = false
	local square2 = Drawing.new("Square")
	square2.Visible = false
	square2.Color = Color3.fromRGB(0, 0, 0)
	square2.Thickness = 0
	square2.Filled = false
	tbl2[arg] = { Box = square, Outline = square2, Size3D = nil }
end

local function fn9()
	for _, v7 in pairs(tbl2) do
		if v7.Box then
			v7.Box.Color = color2
		end

		if v7.Outline then
			v7.Outline.Color = Color3.fromRGB(0, 0, 0)
		end
	end
end

local connection4 = nil

BoxColor = Enemy:AddToggle("", {
	Text = "Box",
	Default = false,
	Tooltip = "Puts a box around all enemies",
	Callback = function(arg)
		if not arg then
			if connection4 then
				connection4:Disconnect()
				connection4 = nil
			end

			for k in pairs(tbl2) do
				fn7(k)
			end

			return
		end

		connection4 = RunService.RenderStepped:Connect(function()
			fn9()

			for _, player in ipairs(Players:GetPlayers()) do
				if player ~= localPlayer then
					local character2 = player.Character
					local humanoid2 = character2 and character2:FindFirstChildOfClass("Humanoid")
					local humanoidRootPart2 = character2 and character2:FindFirstChild("HumanoidRootPart")

					if humanoid2 and humanoid2.Health > 0 and humanoidRootPart2 and Enemy:IsInRange(player) then
						if not tbl2[player] then
							fn8(player)
						end

						local v7 = tbl2[player]
						local box = v7.Box
						local outline = v7.Outline

						if not v7.Size3D then
							v7.Size3D = character2:GetExtentsSize()
						end

						local size3D = v7.Size3D
						local n3 = humanoidRootPart2.Position + Vector3.new(0, size3D.Y / 2, 0)
						local n4 = humanoidRootPart2.Position - Vector3.new(0, size3D.Y / 2, 0)
						local v8, v9 = currentCamera:WorldToViewportPoint(n3)
						local v10, v11 = currentCamera:WorldToViewportPoint(n4)

						if v9 or v11 then
							local n5 = math.abs(v8.Y - v10.Y)
							local n6 = n5 * size3D.X / size3D.Y
							local n7 = v8.X - n6 / 2
							local y = v8.Y
							box.Size = Vector2.new(n6, n5)
							box.Position = Vector2.new(n7, y)
							outline.Size = box.Size
							outline.Position = box.Position
							box.Visible = true
							outline.Visible = true
						else
							box.Visible = false
							outline.Visible = false
						end
					else
						fn7(player)
					end
				end
			end
		end)
	end,
}):AddColorPicker("", {
	Default = color2,
	Title = "Box Color",
	Transparency = 0,
	Callback = function(arg)
		color2 = arg
		fn9()
	end,
})

local tbl3 = {}
local color3 = Color3.fromRGB(255, 0, 0)

local function fn10(arg)
	local character2 = arg.Character
	if not character2 then
		return
	end

	if tbl3[arg] then
		tbl3[arg]:Destroy()
		tbl3[arg] = nil
	end

	local highlight = Instance.new("Highlight")
	highlight.FillColor = color3
	highlight.OutlineColor = Color3.fromRGB(0, 0, 0)
	highlight.FillTransparency = 0.5
	highlight.OutlineTransparency = 0
	highlight.Adornee = character2
	highlight.Parent = character2
	tbl3[arg] = highlight
end

local function fn11(arg)
	if tbl3[arg] then
		tbl3[arg]:Destroy()
		tbl3[arg] = nil
	end
end

local function fn12()
	for _, v7 in pairs(tbl3) do
		v7.FillColor = color3
		v7.OutlineColor = Color3.fromRGB(0, 0, 0)
	end
end

local connection5 = nil

Enemy:AddToggle("", {
	Text = "Highlight",
	Default = false,
	Tooltip = "Highlights players through walls.",
	Callback = function(arg)
		if not arg then
			if connection5 then
				connection5:Disconnect()
				connection5 = nil
			end

			for k in pairs(tbl3) do
				fn11(k)
			end

			return
		end

		connection5 = RunService.RenderStepped:Connect(function()
			fn12()

			for _, player in ipairs(Players:GetPlayers()) do
				if player ~= localPlayer then
					local character2 = player.Character
					local humanoid2 = character2 and character2:FindFirstChildOfClass("Humanoid")

					if humanoid2 and humanoid2.Health > 0 and Enemy:IsInRange(player) then
						if not tbl3[player] then
							fn10(player)
						end

						if tbl3[player].Adornee ~= character2 then
							tbl3[player].Adornee = character2
							tbl3[player].Parent = character2
						end
					else
						fn11(player)
					end
				end
			end
		end)
	end,
}):AddColorPicker("", {
	Default = color3,
	Title = "Highlight Color",
	Transparency = 0,
	Callback = function(arg)
		color3 = arg
		fn12()
	end,
})

local tbl4 = {}
local visible = false
local color4 = Color3.fromRGB(255, 0, 0)

local function fn13(player)
	if player == localPlayer then
		return
	end

	if tbl4[player] then
		return
	end
	local text = Drawing.new("Text")
	text.Size = 18
	text.Center = true
	text.Outline = true
	text.Color = color4
	text.Text = player.Name
	text.Visible = visible
	tbl4[player] = text
end

local function fn14(player)
	if tbl4[player] then
		tbl4[player]:Remove()
		tbl4[player] = nil
	end
end

RunService.RenderStepped:Connect(function()
	for k, v7 in pairs(tbl4) do
		if visible and Enemy:IsInRange(k) then
			local character2 = k.Character
			local head = character2 and character2:FindFirstChild("Head")

			if head then
				local v8, v9 = currentCamera:WorldToViewportPoint(head.Position + Vector3.new(0, 2.5, 0))
				v7.Visible = v9
				v7.Color = color4

				if v9 then
					v7.Position = Vector2.new(v8.X, v8.Y)
				end
			else
				v7.Visible = false
			end
		else
			v7.Visible = false
		end
	end
end)

for _, player in ipairs(Players:GetPlayers()) do
	fn13(player)
end

Players.PlayerAdded:Connect(fn13)
Players.PlayerRemoving:Connect(fn14)

Enemy:AddToggle("", {
	Text = "Username",
	Default = false,
	Tooltip = "See the enemies username.",
	Callback = function(visible2)
		visible = visible2

		for _, v7 in pairs(tbl4) do
			v7.Visible = visible2
		end
	end,
}):AddColorPicker("", {
	Default = Color3.fromRGB(255, 0, 0),
	Title = "Username Color",
	Transparency = 0,
	Callback = function(color5)
		color4 = color5

		for _, v7 in pairs(tbl4) do
			v7.Color = color5
		end
	end,
})

local Players2 = game:GetService("Players")
local localPlayer2 = Players2.LocalPlayer
local RunService2 = game:GetService("RunService")
local currentCamera2 = workspace.CurrentCamera
local tbl5 = {}
local visible2 = false
local color5 = Color3.fromRGB(255, 0, 0)

local function fn15(player)
	if player == localPlayer2 then
		return
	end

	if tbl5[player] then
		return
	end
	local text = Drawing.new("Text")
	text.Size = 16
	text.Center = true
	text.Outline = true
	text.Color = color5
	text.Visible = visible2
	text.Text = ""
	tbl5[player] = text
end

local function fn16(player)
	if tbl5[player] then
		tbl5[player]:Remove()
		tbl5[player] = nil
	end
end

RunService2.RenderStepped:Connect(function()
	for k, v7 in pairs(tbl5) do
		if visible2 then
			local character2 = k.Character
			character2 = character2 and character2:FindFirstChild("HumanoidRootPart")
			local character3 = localPlayer2.Character
			character3 = character3 and character3:FindFirstChild("HumanoidRootPart")

			if character2 and character3 then
				local magnitude = (character3.Position - character2.Position).Magnitude
				v7.Text = string.format("%d studs", magnitude)
				local v8, v9 = currentCamera2:WorldToViewportPoint(character2.Position - Vector3.new(0, 3, 0))
				v7.Visible = v9 and magnitude <= Enemy.MaxDistance
				v7.Color = color5

				if v9 then
					v7.Position = Vector2.new(v8.X, v8.Y)
				end
			else
				v7.Visible = false
			end
		else
			v7.Visible = false
		end
	end
end)

for _, player in ipairs(Players2:GetPlayers()) do
	fn15(player)
end

Players2.PlayerAdded:Connect(fn15)
Players2.PlayerRemoving:Connect(fn16)

Enemy:AddToggle("", {
	Text = "Distance",
	Default = false,
	Tooltip = "See how far away the enemy is from you.",
	Callback = function(visible3)
		visible2 = visible3

		for _, v7 in pairs(tbl5) do
			v7.Visible = visible3
		end
	end,
}):AddColorPicker("", {
	Default = Color3.fromRGB(255, 0, 0),
	Title = "Distance Color",
	Transparency = 0,
	Callback = function(color6)
		color5 = color6

		for _, v7 in pairs(tbl5) do
			v7.Color = color6
		end
	end,
})

Enemy:AddDivider()
local tbl6 = {}
local visible3 = false
local color6 = Color3.fromRGB(255, 0, 0)
local str = "Center"

local function fn17(player)
	if player == localPlayer2 then
		return
	end

	if tbl6[player] then
		return
	end
	local line = Drawing.new("Line")
	line.Visible = visible3
	line.From = Vector2.new(0, 0)
	line.To = Vector2.new(0, 0)
	line.Color = color6
	line.Thickness = 1.5
	tbl6[player] = line
end

local function fn18(player)
	if tbl6[player] then
		tbl6[player]:Remove()
		tbl6[player] = nil
	end
end

local function fn19()
	local viewportSize = currentCamera2.ViewportSize
	if str == "Center" then
		return Vector2.new(viewportSize.X / 2, viewportSize.Y / 2)
	end

	if str == "Bottom" then
		return Vector2.new(viewportSize.X / 2, viewportSize.Y)
	end

	if str == "Top" then
		return Vector2.new(viewportSize.X / 2, 0)
	end
end

RunService2.RenderStepped:Connect(function()
	if not visible3 then
		for _, v7 in pairs(tbl6) do
			v7.Visible = false
		end

		return
	end

	local v7 = fn19()

	for k, v8 in pairs(tbl6) do
		local character2 = k.Character
		character2 = character2 and character2:FindFirstChild("HumanoidRootPart")

		if character2 and Enemy:IsInRange(k) then
			local v9, v10 = currentCamera2:WorldToViewportPoint(character2.Position)

			if v10 then
				v8.Visible = true
				v8.Color = color6
				v8.From = v7
				v8.To = Vector2.new(v9.X, v9.Y)
			else
				v8.Visible = false
			end
		else
			v8.Visible = false
		end
	end
end)

for _, player in ipairs(Players2:GetPlayers()) do
	fn17(player)
end

Players2.PlayerAdded:Connect(fn17)
Players2.PlayerRemoving:Connect(fn18)

local v7 = Enemy:AddToggle("", {
	Text = "Tracer",
	Default = false,
	Tooltip = "A line leading from your selected location to the enemy.",
	Callback = function(visible4)
		visible3 = visible4

		for _, v7 in pairs(tbl6) do
			v7.Visible = visible4
		end
	end,
})

Enemy:AddDropdown("", {
	Values = { "Center", "Bottom", "Top" },
	Default = 1,
	Multi = false,
	Text = "Tracer Location",
	Tooltip = "Choose where you want the tracer to emit from.",
	Callback = function(arg)
		str = arg
	end,
})

v7:AddColorPicker("", {
	Default = Color3.fromRGB(255, 0, 0),
	Title = "Tracer Color",
	Transparency = 0,
	Callback = function(color7)
		color6 = color7

		for _, v8 in pairs(tbl6) do
			v8.Color = color7
		end
	end,
})

local tbl7 = {}
local visible4 = false
local color7 = Color3.fromRGB(255, 0, 0)

local function fn20(player)
	if player == localPlayer2 then
		return
	end

	if tbl7[player] then
		return
	end
	local text = Drawing.new("Text")
	text.Size = 16
	text.Center = true
	text.Outline = true
	text.Color = color7
	text.Text = "Weapon: None"
	text.Visible = visible4
	tbl7[player] = text
end

local function fn21(player)
	if tbl7[player] then
		tbl7[player]:Remove()
		tbl7[player] = nil
	end
end

RunService2.RenderStepped:Connect(function()
	if not visible4 then
		for _, v8 in pairs(tbl7) do
			v8.Visible = false
		end

		return
	end

	for k, v8 in pairs(tbl7) do
		local character2 = k.Character
		local humanoidRootPart2 = character2 and character2:FindFirstChild("HumanoidRootPart")

		if humanoidRootPart2 and Enemy:IsInRange(k) then
			local tool = character2:FindFirstChildOfClass("Tool")
			v8.Text = "Weapon: " .. (tool and tool.Name or "None")
			v8.Color = color7
			local v9, v10 = currentCamera2:WorldToViewportPoint(humanoidRootPart2.Position + Vector3.new(0, 3.5, 0))
			v8.Visible = v10

			if v10 then
				v8.Position = Vector2.new(v9.X, v9.Y)
			end
		else
			v8.Visible = false
		end
	end
end)

for _, player in ipairs(Players2:GetPlayers()) do
	fn20(player)
end

Players2.PlayerAdded:Connect(fn20)
Players2.PlayerRemoving:Connect(fn21)

Enemy:AddToggle("", {
	Text = "Weapon",
	Default = false,
	Tooltip = "Shows the weapon the enemy is holding.",
	Callback = function(visible5)
		visible4 = visible5

		for _, v8 in pairs(tbl7) do
			v8.Visible = visible5
		end
	end,
}):AddColorPicker("", {
	Default = Color3.fromRGB(255, 0, 0),
	Title = "Weapon Color",
	Transparency = 0,
	Callback = function(color8)
		color7 = color8

		for _, v8 in pairs(tbl7) do
			v8.Color = color8
		end
	end,
})

local Crosshair = Misc:AddLeftGroupbox("Crosshair", "crosshair")
local Camera = Misc:AddRightGroupbox("Camera", "camera")
local flag7 = false
local color8 = Color3.fromRGB(255, 0, 0)
local flag8 = false
local flag9 = false
local n3 = 180
local n4 = 10
local thickness = 5
local n5 = 5

local tbl8 = {
	Top = Drawing.new("Line"),
	Bottom = Drawing.new("Line"),
	Left = Drawing.new("Line"),
	Right = Drawing.new("Line"),
}

for _, v8 in pairs(tbl8) do
	v8.Visible = false
	v8.Color = color8
	v8.Thickness = thickness
end

local function fn22(arg)
	return Color3.fromHSV(arg % 5 / 5, 1, 1)
end

Crosshair:AddToggle("", {
	Text = "Enable Crosshair",
	Default = false,
	Tooltip = "Enables the custom crosshair.",
	Callback = function(visible5)
		flag7 = visible5

		for _, v8 in pairs(tbl8) do
			v8.Visible = visible5
		end
	end,
}):AddColorPicker("", {
	Default = Color3.fromRGB(255, 0, 0),
	Title = "Crosshair Color",
	Transparency = 0,
	Callback = function(arg)
		color8 = arg
	end,
})

Crosshair:AddToggle("", {
	Text = "Rainbow Crosshair",
	Default = false,
	Tooltip = "Makes your crosshair switch colors.",
	Callback = function(arg)
		flag8 = arg
	end,
})

Crosshair:AddToggle("", {
	Text = "Crosshair Spin",
	Default = false,
	Tooltip = "Makes your crosshair spin.",
	Callback = function(arg)
		flag9 = arg
	end,
})

Crosshair:AddDivider()

Crosshair:AddSlider("", {
	Text = "Rotation",
	Default = 360,
	Min = 0,
	Max = 360,
	Rounding = 0,
	Compact = false,
	Callback = function(arg)
		n3 = arg
	end,
})

Crosshair:AddSlider("", {
	Text = "Length",
	Default = 15,
	Min = 1,
	Max = 50,
	Rounding = 0,
	Compact = false,
	Callback = function(arg)
		n4 = arg
	end,
})

Crosshair:AddSlider("", {
	Text = "Width",
	Default = 5,
	Min = 1,
	Max = 25,
	Rounding = 0,
	Compact = false,
	Callback = function(arg)
		thickness = arg

		for _, v8 in pairs(tbl8) do
			v8.Thickness = thickness
		end
	end,
})

Crosshair:AddSlider("", {
	Text = "Spin Speed",
	Default = 1,
	Min = 0.1,
	Max = 3,
	Rounding = 1,
	Compact = false,
	Callback = function(arg)
		n5 = arg
	end,
})

RunService2.RenderStepped:Connect(function()
	if not flag7 then
		return
	end
	local n6 = currentCamera2.ViewportSize.X / 2
	local n7 = currentCamera2.ViewportSize.Y / 2

	if flag9 then
		n3 += n5 * 1.5

		if n3 >= 360 then
			n3 = 0
		end
	end

	local v8 = flag8 and fn22(tick()) or color8

	for _, v9 in pairs(tbl8) do
		v9.Color = v8
	end

	local v9 = math.rad(n3)

	for k, v10 in pairs({
		Top = v9,
		Bottom = v9 + 3.1415926535897931,
		Left = v9 - 1.5707963267948966,
		Right = v9 + 1.5707963267948966,
	}) do
		local n8 = math.cos(v10) * n4
		local n9 = math.sin(v10) * n4
		tbl8[k].From = Vector2.new(n6, n7)
		tbl8[k].To = Vector2.new(n6 + n8, n7 + n9)
		tbl8[k].Visible = true
	end
end)

local RunService3 = game:GetService("RunService")
local currentCamera3 = workspace.CurrentCamera

workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
	currentCamera3 = workspace.CurrentCamera
end)

getgenv().StretchEnabled = false
getgenv().StretchAmount = 0.5

local function fn23(arg)
	return CFrame.new(0, 0, 0, 1, 0, 0, 0, arg, 0, 0, 0, 1)
end

RunService3.RenderStepped:Connect(function()
	if getgenv().StretchEnabled and currentCamera3 then
		currentCamera3.CFrame = currentCamera3.CFrame * fn23(getgenv().StretchAmount)
	end
end)

Camera:AddToggle("StretchToggle", {
	Text = "Stretched Res",
	Default = false,
	Tooltip = "Enables the stretched resolution effect.",
	Callback = function(stretchEnabled)
		getgenv().StretchEnabled = stretchEnabled
	end,
})

Camera:AddSlider("StretchAmountSlider", {
	Text = "Stretch Amount",
	Default = 0.5,
	Min = 0.1,
	Max = 1,
	Rounding = 2,
	Tooltip = "Lower = more stretch.",
	Callback = function(stretchAmount)
		getgenv().StretchAmount = stretchAmount
	end,
})

getgenv().FullBrightEnabled = false

local tbl9 = {
	Brightness = Lighting.Brightness,
	ClockTime = Lighting.ClockTime,
	ExposureCompensation = Lighting.ExposureCompensation,
	FogEnd = Lighting.FogEnd,
	Ambient = Lighting.Ambient,
	GlobalShadows = Lighting.GlobalShadows,
}

local function fn24()
	Lighting.Brightness = 2
	Lighting.ClockTime = 14
	Lighting.FogEnd = 100000
	Lighting.GlobalShadows = false
	Lighting.ExposureCompensation = 0
	Lighting.Ambient = Color3.fromRGB(255, 255, 255)
end

local function fn25()
	for k, v8 in pairs(tbl9) do
		Lighting[k] = v8
	end
end

task.spawn(function()
	while true do
		task.wait(1)

		if getgenv().FullBrightEnabled then
			fn24()
		end
	end
end)

Camera:AddDivider()

Camera:AddToggle("FullBrightToggle", {
	Text = "Full Bright",
	Default = false,
	Tooltip = "Brightens the entire world.",
	Callback = function(fullBrightEnabled)
		getgenv().FullBrightEnabled = fullBrightEnabled

		if fullBrightEnabled then
			fn24()
		else
			fn25()
		end
	end,
})

local screenGui = nil
local flag10 = false
local flag11 = false

Watermark = Camera:AddToggle("Watermark", {
	Text = "Watermark",
	Default = true,
	Tooltip = "Enable/Disable the watermark",
	Callback = function(arg)
		if arg then
			lib:Notify({ Title = "HollyScriptX", Description = "Watermark Enabled ✅", Time = 3 })

			if not screenGui then
				screenGui = Instance.new("ScreenGui")
				screenGui.Name = "HollyScriptXWatermark"
				screenGui.ResetOnSpawn = false
				screenGui.Parent = game:GetService("CoreGui")
				local frame = Instance.new("Frame")
				frame.Name = "Frame"
				frame.Size = UDim2.new(0, 400, 0, 35)
				frame.Position = UDim2.new(0, 10, 0, 10)
				frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
				frame.BorderSizePixel = 0
				frame.Parent = screenGui
				local uiGradient = Instance.new("UIGradient")
				local new = ColorSequenceKeypoint.new
				local color9 = Color3.fromRGB
				uiGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 255)), new(1, color9(0, 255, 255)) })
				uiGradient.Rotation = 45
				uiGradient.Parent = frame
				local uiCorner = Instance.new("UICorner")
				uiCorner.CornerRadius = UDim.new(0, 12)
				uiCorner.Parent = frame
				local uiStroke = Instance.new("UIStroke")
				uiStroke.Color = Color3.fromRGB(255, 0, 255)
				uiStroke.Thickness = 2
				uiStroke.Parent = frame
				local textLabel = Instance.new("TextLabel")
				textLabel.Name = "TextLabel"
				textLabel.Size = UDim2.new(1, -20, 1, -10)
				textLabel.Position = UDim2.new(0, 10, 0, 5)
				textLabel.BackgroundTransparency = 1
				textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
				textLabel.TextScaled = true
				textLabel.Font = Enum.Font.SourceSansBold
				textLabel.TextStrokeTransparency = 0.75
				textLabel.TextSize = 18
				textLabel.Text = "HollyScriptX | " .. localPlayer2.Name .. " | 0 FPS"
				textLabel.Parent = frame
				local flag12 = false
				local v8 = nil
				local position = nil
				local position2 = nil

				local function fn26(arg2)
					local n6 = arg2.Position - position
					frame.Position = UDim2.new(position2.X.Scale, position2.X.Offset + n6.X, position2.Y.Scale, position2.Y.Offset + n6.Y)
				end

				frame.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						flag12 = true
						position = input.Position
						position2 = frame.Position

						input.Changed:Connect(function()
							if input.UserInputState == Enum.UserInputState.End then
								flag12 = false
							end
						end)
					end
				end)

				frame.InputChanged:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseMovement then
						v8 = input
					end
				end)

				game:GetService("UserInputService").InputChanged:Connect(function(input)
					if flag12 and input == v8 then
						fn26(input)
					end
				end)

				flag10 = true
			else
				screenGui.Enabled = true
				flag10 = true
			end

			if not flag11 then
				flag11 = true

				spawn(function()
					while true do
						if flag10 and screenGui then
							local n6 = math.floor(1 / RunService3.RenderStepped:Wait())
							local textLabel = screenGui:FindFirstChild("Frame") and screenGui.Frame:FindFirstChild("TextLabel")

							if textLabel then
								textLabel.Text = "HollyScriptX | " .. localPlayer2.Name .. " | " .. n6 .. " FPS"
							end
						else
							RunService3.RenderStepped:Wait()
						end

						wait(0.2)
					end
				end)
			end
		else
			lib:Notify({ Title = "HollyScriptX", Description = "Watermark Disabled ❌", Time = 3 })

			if screenGui then
				screenGui.Enabled = false
				flag10 = false
			end
		end
	end,
})

Watermark.Callback(true)

local function fn26()
	local function fn27()
		local fn28 = cloneref or clonereference or function(arg)
			return arg
		end

		local fn29 = clonefunction or copyfunction or function(arg)
			return arg
		end

		local v8 = fn28(game:GetService("HttpService"))
		local v9 = fn28(game:GetService("SoundService"))
		local fn30 = isfolder
		local fn31 = isfile
		local fn32 = listfiles

		if typeof(fn29) == "function" then
			local v10 = fn29(fn30)
			local v11 = fn29(fn31)
			local v12 = fn29(fn32)

			local ok, result = pcall(function()
				return v10("test" .. tostring(math.random(1000000, 9999999)))
			end)

			if ok == false or typeof(result) ~= "boolean" then
				fn30 = function(arg)
					local ok2, result2 = pcall(v10, arg)
					local flag12

					if ok2 then
						flag12 = result2
					else
						flag12 = false
					end

					return flag12
				end

				fn31 = function(arg)
					local ok2, result2 = pcall(v11, arg)

					if not ok2 then
						result2 = false
					end

					return result2
				end

				fn32 = function(arg)
					local ok2, result2 = pcall(v12, arg)

					if not ok2 then
						result2 = {}
					end

					return result2
				end
			end
		end

		local function fn33()
			local sound = Instance.new("Sound")
			sound.SoundId = "rbxassetid://99979147606311"
			sound.Volume = 10
			sound.Parent = v9
			sound:Play()

			sound.Ended:Connect(function()
				sound:Destroy()
			end)
		end

		local tbl10 = { "FontColor", "MainColor", "AccentColor", "BackgroundColor", "OutlineColor" }
		local obsidianThemeManager

		obsidianThemeManager = {
			Folder = "ObsidianLibSettings",
			Library = nil,
			AppliedToTab = false,
			BuiltInThemes = {
				HollyScriptX = {
					1,
					{
						FontColor = "f6ecff",
						MainColor = "131313",
						AccentColor = "7961d9",
						BackgroundColor = "000000",
						OutlineColor = "282828",
						FontFace = "Gotham",
					},
				},
				Mspaint = {
					2,
					{
						FontColor = "ffffff",
						MainColor = "232323",
						AccentColor = "7961d9",
						BackgroundColor = "1b1919",
						OutlineColor = "282828",
						FontFace = "Gotham",
					},
				},
				BBot = {
					3,
					{
						FontColor = "ffffff",
						MainColor = "1e1e1e",
						AccentColor = "7e48a3",
						BackgroundColor = "232323",
						OutlineColor = "141414",
						FontFace = "Gotham",
					},
				},
				Fatality = {
					4,
					{
						FontColor = "ffffff",
						MainColor = "1e1842",
						AccentColor = "c50754",
						BackgroundColor = "191335",
						OutlineColor = "3c355d",
						FontFace = "Gotham",
					},
				},
				Jester = {
					5,
					{
						FontColor = "ffffff",
						MainColor = "242424",
						AccentColor = "db4467",
						BackgroundColor = "1c1c1c",
						OutlineColor = "373737",
						FontFace = "Gotham",
					},
				},
				Mint = {
					6,
					{
						FontColor = "ffffff",
						MainColor = "242424",
						AccentColor = "3db488",
						BackgroundColor = "1c1c1c",
						OutlineColor = "373737",
						FontFace = "Gotham",
					},
				},
				["Tokyo Night"] = {
					7,
					{
						FontColor = "ffffff",
						MainColor = "191925",
						AccentColor = "6759b3",
						BackgroundColor = "16161f",
						OutlineColor = "323232",
						FontFace = "Gotham",
					},
				},
				Ubuntu = {
					8,
					{
						FontColor = "ffffff",
						MainColor = "3e3e3e",
						AccentColor = "e2581e",
						BackgroundColor = "323232",
						OutlineColor = "191919",
						FontFace = "Gotham",
					},
				},
				Quartz = {
					9,
					{
						FontColor = "ffffff",
						MainColor = "232330",
						AccentColor = "426e87",
						BackgroundColor = "1d1b26",
						OutlineColor = "27232f",
						FontFace = "Gotham",
					},
				},
				Nord = {
					10,
					{
						FontColor = "eceff4",
						MainColor = "3b4252",
						AccentColor = "88c0d0",
						BackgroundColor = "2e3440",
						OutlineColor = "4c566a",
						FontFace = "Gotham",
					},
				},
				Dracula = {
					11,
					{
						FontColor = "f8f8f2",
						MainColor = "44475a",
						AccentColor = "ff79c6",
						BackgroundColor = "282a36",
						OutlineColor = "6272a4",
						FontFace = "Gotham",
					},
				},
				Monokai = {
					12,
					{
						FontColor = "f8f8f2",
						MainColor = "272822",
						AccentColor = "f92672",
						BackgroundColor = "1e1f1c",
						OutlineColor = "49483e",
						FontFace = "Gotham",
					},
				},
				Gruvbox = {
					13,
					{
						FontColor = "ebdbb2",
						MainColor = "3c3836",
						AccentColor = "fb4934",
						BackgroundColor = "282828",
						OutlineColor = "504945",
						FontFace = "Gotham",
					},
				},
				Solarized = {
					14,
					{
						FontColor = "839496",
						MainColor = "073642",
						AccentColor = "cb4b16",
						BackgroundColor = "002b36",
						OutlineColor = "586e75",
						FontFace = "Gotham",
					},
				},
				Catppuccin = {
					15,
					{
						FontColor = "d9e0ee",
						MainColor = "302d41",
						AccentColor = "f5c2e7",
						BackgroundColor = "1e1e2e",
						OutlineColor = "575268",
						FontFace = "Gotham",
					},
				},
				["One Dark"] = {
					16,
					{
						FontColor = "abb2bf",
						MainColor = "282c34",
						AccentColor = "c678dd",
						BackgroundColor = "21252b",
						OutlineColor = "5c6370",
						FontFace = "Gotham",
					},
				},
				Cyberpunk = {
					17,
					{
						FontColor = "00ff9f",
						MainColor = "0d0d1a",
						AccentColor = "ff00ff",
						BackgroundColor = "1a0033",
						OutlineColor = "330066",
						FontFace = "Gotham",
					},
				},
				["Oceanic Next"] = {
					18,
					{
						FontColor = "d8dee9",
						MainColor = "1b2b34",
						AccentColor = "6699cc",
						BackgroundColor = "16232a",
						OutlineColor = "343d46",
						FontFace = "Gotham",
					},
				},
				Material = {
					19,
					{
						FontColor = "eeffff",
						MainColor = "212121",
						AccentColor = "82aaff",
						BackgroundColor = "151515",
						OutlineColor = "424242",
						FontFace = "Gotham",
					},
				},
				Sunset = {
					20,
					{
						FontColor = "ffd700",
						MainColor = "4a1a1a",
						AccentColor = "ff6b35",
						BackgroundColor = "2d0a0a",
						OutlineColor = "8b3a3a",
						FontFace = "Gotham",
					},
				},
				["Midnight Blue"] = {
					21,
					{
						FontColor = "e0e0ff",
						MainColor = "0a1628",
						AccentColor = "4a90e2",
						BackgroundColor = "050d1a",
						OutlineColor = "1a2a4a",
						FontFace = "Gotham",
					},
				},
				["Royal Purple"] = {
					22,
					{
						FontColor = "f0e6ff",
						MainColor = "1a0a2e",
						AccentColor = "9b59b6",
						BackgroundColor = "0f0518",
						OutlineColor = "3a1e5e",
						FontFace = "Gotham",
					},
				},
				Emerald = {
					23,
					{
						FontColor = "e0ffe0",
						MainColor = "0a2e1a",
						AccentColor = "2ecc71",
						BackgroundColor = "05180a",
						OutlineColor = "1a5e3a",
						FontFace = "Gotham",
					},
				},
				["Ruby Red"] = {
					24,
					{
						FontColor = "ffe0e0",
						MainColor = "2e0a0a",
						AccentColor = "e74c3c",
						BackgroundColor = "180505",
						OutlineColor = "5e1a1a",
						FontFace = "Gotham",
					},
				},
				["Coral Reef"] = {
					25,
					{
						FontColor = "fff0e0",
						MainColor = "2e1a0a",
						AccentColor = "ff7e5e",
						BackgroundColor = "180d05",
						OutlineColor = "5e3a1a",
						FontFace = "Gotham",
					},
				},
				Silver = {
					26,
					{
						FontColor = "f0f0f0",
						MainColor = "2a2a2a",
						AccentColor = "bdc3c7",
						BackgroundColor = "1a1a1a",
						OutlineColor = "4a4a4a",
						FontFace = "Gotham",
					},
				},
				Gold = {
					27,
					{
						FontColor = "fff4e0",
						MainColor = "2e2a0a",
						AccentColor = "f39c12",
						BackgroundColor = "181505",
						OutlineColor = "5e4a1a",
						FontFace = "Gotham",
					},
				},
				["Neon Genesis"] = {
					28,
					{
						FontColor = "00ffcc",
						MainColor = "0a0a0a",
						AccentColor = "ff3366",
						BackgroundColor = "000000",
						OutlineColor = "ff6600",
						FontFace = "Gotham",
					},
				},
				Synthwave = {
					29,
					{
						FontColor = "ff6bff",
						MainColor = "1a0a2e",
						AccentColor = "00ffff",
						BackgroundColor = "0a001a",
						OutlineColor = "ff00ff",
						FontFace = "Gotham",
					},
				},
				Matrix = {
					30,
					{
						FontColor = "00ff41",
						MainColor = "0d1f0d",
						AccentColor = "008f11",
						BackgroundColor = "050f05",
						OutlineColor = "1a3f1a",
						FontFace = "Gotham",
					},
				},
				["Cherry Blossom"] = {
					31,
					{
						FontColor = "ffe0f0",
						MainColor = "2e1428",
						AccentColor = "ff69b4",
						BackgroundColor = "1a0d14",
						OutlineColor = "5e2840",
						FontFace = "Gotham",
					},
				},
				Arctic = {
					32,
					{
						FontColor = "ffffff",
						MainColor = "1a2e40",
						AccentColor = "5dade2",
						BackgroundColor = "0d1a26",
						OutlineColor = "2a4a60",
						FontFace = "Gotham",
					},
				},
				Lava = {
					33,
					{
						FontColor = "ffcc00",
						MainColor = "401a0a",
						AccentColor = "ff4500",
						BackgroundColor = "260d05",
						OutlineColor = "803020",
						FontFace = "Gotham",
					},
				},
				Forest = {
					34,
					{
						FontColor = "d4f1d4",
						MainColor = "0d2e0d",
						AccentColor = "4caf50",
						BackgroundColor = "061a06",
						OutlineColor = "1a4e1a",
						FontFace = "Gotham",
					},
				},
				Twilight = {
					35,
					{
						FontColor = "e8d4f1",
						MainColor = "1a0d26",
						AccentColor = "8e44ad",
						BackgroundColor = "0d061a",
						OutlineColor = "3a1a5e",
						FontFace = "Gotham",
					},
				},
				Ocean = {
					36,
					{
						FontColor = "e0f7ff",
						MainColor = "001a2e",
						AccentColor = "00b4d8",
						BackgroundColor = "000d1a",
						OutlineColor = "004a6e",
						FontFace = "Gotham",
					},
				},
				["Rose Gold"] = {
					37,
					{
						FontColor = "fff5f5",
						MainColor = "2e1a1a",
						AccentColor = "ffb6c1",
						BackgroundColor = "1a0d0d",
						OutlineColor = "5e3a3a",
						FontFace = "Gotham",
					},
				},
				Chocolate = {
					38,
					{
						FontColor = "f5e6d3",
						MainColor = "2e1a0d",
						AccentColor = "d2691e",
						BackgroundColor = "180d05",
						OutlineColor = "5e3a1a",
						FontFace = "Gotham",
					},
				},
				Lavender = {
					39,
					{
						FontColor = "f0e6ff",
						MainColor = "1a0d2e",
						AccentColor = "e6e6fa",
						BackgroundColor = "0d061a",
						OutlineColor = "3a1a5e",
						FontFace = "Gotham",
					},
				},
				Teal = {
					40,
					{
						FontColor = "e0ffff",
						MainColor = "002e2e",
						AccentColor = "008080",
						BackgroundColor = "001a1a",
						OutlineColor = "005e5e",
						FontFace = "Gotham",
					},
				},
				Crimson = {
					41,
					{
						FontColor = "ffe0e0",
						MainColor = "2e0000",
						AccentColor = "dc143c",
						BackgroundColor = "1a0000",
						OutlineColor = "5e0000",
						FontFace = "Gotham",
					},
				},
				Amber = {
					42,
					{
						FontColor = "fff0e0",
						MainColor = "2e1a00",
						AccentColor = "ffbf00",
						BackgroundColor = "180d00",
						OutlineColor = "5e3a00",
						FontFace = "Gotham",
					},
				},
				Plum = {
					43,
					{
						FontColor = "f5e6f5",
						MainColor = "2e1a2e",
						AccentColor = "dda0dd",
						BackgroundColor = "1a0d1a",
						OutlineColor = "5e3a5e",
						FontFace = "Gotham",
					},
				},
				Sage = {
					44,
					{
						FontColor = "e6f0e6",
						MainColor = "2e3a2e",
						AccentColor = "9cae8c",
						BackgroundColor = "1a261a",
						OutlineColor = "4a5e4a",
						FontFace = "Gotham",
					},
				},
				Terracotta = {
					45,
					{
						FontColor = "faf0e6",
						MainColor = "5e2e1a",
						AccentColor = "e2725b",
						BackgroundColor = "3a1a0d",
						OutlineColor = "8e4a2e",
						FontFace = "Gotham",
					},
				},
				Mauve = {
					46,
					{
						FontColor = "faf0fa",
						MainColor = "4a2e4a",
						AccentColor = "e0b0e0",
						BackgroundColor = "2e1a2e",
						OutlineColor = "7a5a7a",
						FontFace = "Gotham",
					},
				},
				Slate = {
					47,
					{
						FontColor = "f0f0f5",
						MainColor = "2e3a4a",
						AccentColor = "708090",
						BackgroundColor = "1a2633",
						OutlineColor = "4a5a6e",
						FontFace = "Gotham",
					},
				},
				Copper = {
					48,
					{
						FontColor = "fff5eb",
						MainColor = "4a2e1a",
						AccentColor = "b87333",
						BackgroundColor = "2e1a0d",
						OutlineColor = "8e5a33",
						FontFace = "Gotham",
					},
				},
				Indigo = {
					49,
					{
						FontColor = "e6e6ff",
						MainColor = "1a1a4a",
						AccentColor = "4b0082",
						BackgroundColor = "0d0d2e",
						OutlineColor = "3a3a7a",
						FontFace = "Gotham",
					},
				},
				Coral = {
					50,
					{
						FontColor = "fff0e6",
						MainColor = "4a1a0d",
						AccentColor = "ff7f50",
						BackgroundColor = "2e0d05",
						OutlineColor = "8e3a1a",
						FontFace = "Gotham",
					},
				},
				Viridian = {
					51,
					{
						FontColor = "e6f5f0",
						MainColor = "0d3a2e",
						AccentColor = "40826d",
						BackgroundColor = "05261a",
						OutlineColor = "1a6e5e",
						FontFace = "Gotham",
					},
				},
				Blush = {
					52,
					{
						FontColor = "fff0f0",
						MainColor = "4a1a2e",
						AccentColor = "de5d83",
						BackgroundColor = "2e0d1a",
						OutlineColor = "8e3a5e",
						FontFace = "Gotham",
					},
				},
				Azure = {
					53,
					{
						FontColor = "e6f5ff",
						MainColor = "002e4a",
						AccentColor = "007fff",
						BackgroundColor = "001a2e",
						OutlineColor = "005e8e",
						FontFace = "Gotham",
					},
				},
				Sand = {
					54,
					{
						FontColor = "faf0e0",
						MainColor = "4a3a1a",
						AccentColor = "c2b280",
						BackgroundColor = "2e260d",
						OutlineColor = "8e7a3a",
						FontFace = "Gotham",
					},
				},
				Wine = {
					55,
					{
						FontColor = "f0e0e6",
						MainColor = "4a1a2e",
						AccentColor = "722f37",
						BackgroundColor = "2e0d1a",
						OutlineColor = "8e3a5e",
						FontFace = "Gotham",
					},
				},
				Moss = {
					56,
					{
						FontColor = "e6f0e0",
						MainColor = "1a3a0d",
						AccentColor = "8a9a5b",
						BackgroundColor = "0d2605",
						OutlineColor = "4a6e1a",
						FontFace = "Gotham",
					},
				},
				Lilac = {
					57,
					{
						FontColor = "f0e6f5",
						MainColor = "3a1a4a",
						AccentColor = "c8a2c8",
						BackgroundColor = "260d2e",
						OutlineColor = "7a3a8e",
						FontFace = "Gotham",
					},
				},
				Steel = {
					58,
					{
						FontColor = "e6e6ea",
						MainColor = "1a1a2e",
						AccentColor = "4682b4",
						BackgroundColor = "0d0d1a",
						OutlineColor = "3a3a5e",
						FontFace = "Gotham",
					},
				},
				Apricot = {
					59,
					{
						FontColor = "fff0e6",
						MainColor = "4a2e0d",
						AccentColor = "fbceb1",
						BackgroundColor = "2e1a05",
						OutlineColor = "8e6a2e",
						FontFace = "Gotham",
					},
				},
				["Deep Purple"] = {
					60,
					{
						FontColor = "f0e6ff",
						MainColor = "1a002e",
						AccentColor = "6a0dad",
						BackgroundColor = "0d001a",
						OutlineColor = "4a006e",
						FontFace = "Gotham",
					},
				},
				["Electric Blue"] = {
					61,
					{
						FontColor = "e6ffff",
						MainColor = "001a4a",
						AccentColor = "00bfff",
						BackgroundColor = "000d2e",
						OutlineColor = "004a8e",
						FontFace = "Gotham",
					},
				},
				["Hot Pink"] = {
					62,
					{
						FontColor = "ffe6f0",
						MainColor = "4a001a",
						AccentColor = "ff69b4",
						BackgroundColor = "2e000d",
						OutlineColor = "8e004a",
						FontFace = "Gotham",
					},
				},
				Lime = {
					63,
					{
						FontColor = "f0ffe6",
						MainColor = "1a4a00",
						AccentColor = "bfff00",
						BackgroundColor = "0d2e00",
						OutlineColor = "3a8e00",
						FontFace = "Gotham",
					},
				},
				Tangerine = {
					64,
					{
						FontColor = "fff0e0",
						MainColor = "4a2e00",
						AccentColor = "ff8c00",
						BackgroundColor = "2e1a00",
						OutlineColor = "8e6e00",
						FontFace = "Gotham",
					},
				},
				["Mint Green"] = {
					65,
					{
						FontColor = "e6fff0",
						MainColor = "003326",
						AccentColor = "98fb98",
						BackgroundColor = "001a12",
						OutlineColor = "00663d",
						FontFace = "Gotham",
					},
				},
				Strawberry = {
					66,
					{
						FontColor = "ffe6e6",
						MainColor = "4a000a",
						AccentColor = "fc5a8d",
						BackgroundColor = "2e0005",
						OutlineColor = "8e002a",
						FontFace = "Gotham",
					},
				},
				Peach = {
					67,
					{
						FontColor = "fff5e6",
						MainColor = "4a2e1a",
						AccentColor = "ffdab9",
						BackgroundColor = "2e1a0d",
						OutlineColor = "8e6e4a",
						FontFace = "Gotham",
					},
				},
				["Ocean Breeze"] = {
					68,
					{
						FontColor = "e6f7ff",
						MainColor = "003d4d",
						AccentColor = "66c2ff",
						BackgroundColor = "00262e",
						OutlineColor = "00668e",
						FontFace = "Gotham",
					},
				},
				Velvet = {
					69,
					{
						FontColor = "f5e6f0",
						MainColor = "4d0033",
						AccentColor = "cc0066",
						BackgroundColor = "33001a",
						OutlineColor = "99004d",
						FontFace = "Gotham",
					},
				},
				Honey = {
					70,
					{
						FontColor = "fffbe6",
						MainColor = "4d3d00",
						AccentColor = "ffd700",
						BackgroundColor = "2e2600",
						OutlineColor = "9e8e00",
						FontFace = "Gotham",
					},
				},
			},
			SetLibrary = function(arg, library)
				arg.Library = library
			end,
			GetPaths = function(arg)
				local tbl11 = {}
				local parts = arg.Folder:split("/")

				for i = 1, #parts do
					tbl11[#tbl11 + 1] = table.concat(parts, "/", 1, i)
				end

				tbl11[#tbl11 + 1] = arg.Folder .. "/themes"
				return tbl11
			end,
			BuildFolderTree = function(arg)
				local paths = arg:GetPaths()

				for i = 1, #paths do
					local v10 = paths[i]

					if not fn30(v10) then
						makefolder(v10)
					end
				end
			end,
			CheckFolderTree = function(arg)
				if fn30(arg.Folder) then
					return
				end
				arg:BuildFolderTree()
				task.wait(0.1)
			end,
			SetFolder = function(arg, folder)
				arg.Folder = folder
				arg:BuildFolderTree()
			end,
			ApplyTheme = function(arg, arg2)
				local customTheme = arg:GetCustomTheme(arg2)
				local v10 = customTheme or arg.BuiltInThemes[arg2]
				if not v10 then
					return
				end
				local v11 = v10[2]
				local v12 = pairs
				local v13 = customTheme or v11

				for k, v14 in v12(v13) do
					if k ~= "VideoLink" then
						if k == "FontFace" then
							arg.Library:SetFont(Enum.Font.Gotham)

							if arg.Library.Options[k] then
								arg.Library.Options[k]:SetValue("Gotham")
							end
						else
							arg.Library.Scheme[k] = Color3.fromHex(v14)

							if arg.Library.Options[k] then
								arg.Library.Options[k]:SetValueRGB(Color3.fromHex(v14))
							end
						end
					end
				end

				arg:ThemeUpdate()
			end,
			ThemeUpdate = function(arg)
				for _, v10 in tbl10, nil, nil do
					if arg.Library.Options and arg.Library.Options[v10] then
						arg.Library.Scheme[v10] = arg.Library.Options[v10].Value
					end
				end

				arg.Library:UpdateColorsUsingRegistry()
			end,
			GetCustomTheme = function(arg, arg2)
				local str2 = arg.Folder .. "/themes/" .. arg2 .. ".json"
				if not fn31(str2) then
					return nil
				end
				local v10 = readfile(str2)
				local ok, result = pcall(v8.JSONDecode, v8, v10)
				if not ok then
					return nil
				end
				return result
			end,
			LoadDefault = function(arg)
				local v10 = fn31(arg.Folder .. "/themes/default.txt") and readfile(arg.Folder .. "/themes/default.txt")
				local str2 = "HollyScriptX"
				local flag12 = true

				if v10 then
					local flag13 = true

					if arg.BuiltInThemes[v10] then
						str2 = v10
						flag12 = flag13
					elseif arg:GetCustomTheme(v10) then
						str2 = v10
						flag12 = false
					else
						flag12 = flag13
					end
				end

				if flag12 then
					if arg.Library.Options.ThemeManager_ThemeList then
						arg.Library.Options.ThemeManager_ThemeList:SetValue(str2)
					end

					arg:ApplyTheme(str2)
				else
					arg:ApplyTheme(str2)
				end
			end,
			SaveDefault = function(arg, arg2)
				writefile(arg.Folder .. "/themes/default.txt", arg2)
			end,
			SetDefaultTheme = function(arg, arg2)
				assert(arg.Library, "Must set ThemeManager.Library first!")
				assert(not arg.AppliedToTab, "Cannot set default theme after applying ThemeManager to a tab!")
				local tbl11 = {}
				local scheme = {}

				for _, v10 in tbl10, nil, nil do
					if typeof(arg2[v10]) == "Color3" then
						tbl11[v10] = "#" .. arg2[v10]:ToHex()
						scheme[v10] = arg2[v10]
					elseif typeof(arg2[v10]) == "string" then
						local str2

						if arg2[v10]:sub(1, 1) == "#" then
							str2 = arg2[v10]
						else
							str2 = "#" .. arg2[v10]
						end

						tbl11[v10] = str2
						scheme[v10] = Color3.fromHex(arg2[v10])
					else
						tbl11[v10] = obsidianThemeManager.BuiltInThemes.Crimson[2][v10]
						scheme[v10] = Color3.fromHex(obsidianThemeManager.BuiltInThemes.Crimson[2][v10])
					end
				end

				tbl11.FontFace = "Gotham"
				scheme.Font = Font.fromEnum(Enum.Font.Gotham)

				for _, v10 in { "RedColor", "DarkColor", "WhiteColor" }, nil, nil do
					scheme[v10] = arg.Library.Scheme[v10]
				end

				arg.Library.Scheme = scheme
				arg.BuiltInThemes.Crimson = { 0, tbl11 }
				arg.Library:UpdateColorsUsingRegistry()
			end,
			SaveCustomTheme = function(arg, arg2)
				if arg2:gsub(" ", "") == "" then
					arg.Library:Notify("Invalid file name for theme (empty)", 3)
					return
				end
				local tbl11 = {}

				for _, v10 in tbl10, nil, nil do
					tbl11[v10] = arg.Library.Options[v10].Value:ToHex()
				end

				tbl11.FontFace = "Gotham"
				writefile(arg.Folder .. "/themes/" .. arg2 .. ".json", v8:JSONEncode(tbl11))
			end,
			Delete = function(arg, arg2)
				if not arg2 then
					return false, "no config file is selected"
				end
				local str2 = arg.Folder .. "/themes/" .. arg2 .. ".json"
				if not fn31(str2) then
					return false, "invalid file"
				end

				if not pcall(delfile, str2) then
					return false, "delete file error"
				end
				return true
			end,
			ReloadCustomThemes = function(arg)
				local v10 = fn32(arg.Folder .. "/themes")
				local tbl11 = {}

				for i = 1, #v10 do
					local v11 = v10[i]

					if v11:sub(-5) == ".json" then
						local pos = v11:find(".json", 1, true)
						local str2 = v11:sub(pos, pos)
						local v12 = pos

						while str2 ~= "/" and str2 ~= "\\" and str2 ~= "" do
							v12 -= 1
							str2 = v11:sub(v12, v12)
						end

						if str2 == "/" or str2 == "\\" then
							table.insert(tbl11, v11:sub(v12 + 1, pos - 1))
						end
					end
				end

				return tbl11
			end,
			CreateThemeManager = function(arg, arg2)
				arg2:AddLabel("Background color"):AddColorPicker("BackgroundColor", { Default = arg.Library.Scheme.BackgroundColor })
				arg2:AddLabel("Main color"):AddColorPicker("MainColor", { Default = arg.Library.Scheme.MainColor })
				arg2:AddLabel("Accent color"):AddColorPicker("AccentColor", { Default = arg.Library.Scheme.AccentColor })
				arg2:AddLabel("Outline color"):AddColorPicker("OutlineColor", { Default = arg.Library.Scheme.OutlineColor })
				arg2:AddLabel("Font color"):AddColorPicker("FontColor", { Default = arg.Library.Scheme.FontColor })
				local tbl11 = {}

				for k in pairs(arg.BuiltInThemes) do
					table.insert(tbl11, k)
				end

				table.sort(tbl11, function(arg3, arg4)
					return arg.BuiltInThemes[arg3][1] < arg.BuiltInThemes[arg4][1]
				end)

				arg2:AddDivider()
				arg2:AddDropdown("ThemeManager_ThemeList", { Text = "Theme list", Values = tbl11, Default = "Crimson" })

				arg2:AddButton("Set as default", function()
					arg:SaveDefault(arg.Library.Options.ThemeManager_ThemeList.Value)
					fn33()
					arg.Library:Notify(string.format("Set default theme to %q", arg.Library.Options.ThemeManager_ThemeList.Value))
				end)

				arg.Library.Options.ThemeManager_ThemeList:OnChanged(function()
					arg:ApplyTheme(arg.Library.Options.ThemeManager_ThemeList.Value)
					fn33()
				end)

				arg2:AddDivider()
				arg2:AddInput("ThemeManager_CustomThemeName", { Text = "Custom theme name" })

				arg2:AddButton("Create theme", function()
					local value = arg.Library.Options.ThemeManager_CustomThemeName.Value
					if value:gsub(" ", "") == "" then
						arg.Library:Notify("Invalid theme name (empty)", 2)
						return
					end
					arg:SaveCustomTheme(value)
					fn33()
					arg.Library:Notify(string.format("Created theme %q", value))
					arg.Library.Options.ThemeManager_CustomThemeList:SetValues(arg:ReloadCustomThemes())
					arg.Library.Options.ThemeManager_CustomThemeList:SetValue(nil)
				end)

				arg2:AddDivider()
				arg2:AddDropdown("ThemeManager_CustomThemeList", { Text = "Custom themes", Values = arg:ReloadCustomThemes(), AllowNull = true, Default = 1 })

				arg2:AddButton("Load theme", function()
					local value = arg.Library.Options.ThemeManager_CustomThemeList.Value
					arg:ApplyTheme(value)
					fn33()
					arg.Library:Notify(string.format("Loaded theme %q", value))
				end)

				arg2:AddButton("Overwrite theme", function()
					local value = arg.Library.Options.ThemeManager_CustomThemeList.Value
					arg:SaveCustomTheme(value)
					fn33()
					arg.Library:Notify(string.format("Overwrote config %q", value))
				end)

				arg2:AddButton("Delete theme", function()
					local value = arg.Library.Options.ThemeManager_CustomThemeList.Value
					local v10, failedToDeleteTheme = arg:Delete(value)
					if not v10 then
						arg.Library:Notify("Failed to delete theme: " .. failedToDeleteTheme)
						return
					end
					fn33()
					arg.Library:Notify(string.format("Deleted theme %q", value))
					arg.Library.Options.ThemeManager_CustomThemeList:SetValues(arg:ReloadCustomThemes())
					arg.Library.Options.ThemeManager_CustomThemeList:SetValue(nil)
				end)

				arg2:AddButton("Refresh list", function()
					arg.Library.Options.ThemeManager_CustomThemeList:SetValues(arg:ReloadCustomThemes())
					arg.Library.Options.ThemeManager_CustomThemeList:SetValue(nil)
					fn33()
				end)

				arg2:AddButton("Set as default", function()
					if arg.Library.Options.ThemeManager_CustomThemeList.Value ~= nil and arg.Library.Options.ThemeManager_CustomThemeList.Value ~= "" then
						arg:SaveDefault(arg.Library.Options.ThemeManager_CustomThemeList.Value)
						fn33()
						arg.Library:Notify(string.format("Set default theme to %q", arg.Library.Options.ThemeManager_CustomThemeList.Value))
					end
				end)

				arg2:AddButton("Reset default", function()
					if not pcall(delfile, arg.Folder .. "/themes/default.txt") then
						arg.Library:Notify("Failed to reset default: delete file error")
						return
					end
					fn33()
					arg.Library:Notify("Set default theme to nothing")
					arg.Library.Options.ThemeManager_CustomThemeList:SetValues(arg:ReloadCustomThemes())
					arg.Library.Options.ThemeManager_CustomThemeList:SetValue(nil)
				end)

				arg:LoadDefault()

				local function fn34()
					arg:ThemeUpdate()
				end

				arg.Library.Options.BackgroundColor:OnChanged(fn34)
				arg.Library.Options.MainColor:OnChanged(fn34)
				arg.Library.Options.AccentColor:OnChanged(fn34)
				arg.Library.Options.OutlineColor:OnChanged(fn34)
				arg.Library.Options.FontColor:OnChanged(fn34)
			end,
			CreateGroupBox = function(arg, arg2)
				assert(arg.Library, "Must set ThemeManager.Library first!")
				return arg2:AddLeftGroupbox("Themes", "paintbrush")
			end,
			ApplyToTab = function(arg, arg2)
				assert(arg.Library, "Must set ThemeManager.Library first!")
				local v10 = arg:CreateGroupBox(arg2)
				arg:CreateThemeManager(v10)
				arg.AppliedToTab = true
			end,
			ApplyToGroupbox = function(arg, arg2)
				assert(arg.Library, "Must set ThemeManager.Library first!")
				arg:CreateThemeManager(arg2)
				arg.AppliedToTab = true
			end,
		}

		obsidianThemeManager:BuildFolderTree()
		getgenv().ObsidianThemeManager = obsidianThemeManager

		if setclipboard then
			pcall(setclipboard, "https://discord.gg/fBTP3ry53Q")
		end

		return obsidianThemeManager
	end

	local v8 = fn27()

	local function fn28()
		local fn29 = cloneref or clonereference or function(arg)
			return arg
		end

		local fn30 = clonefunction or copyfunction or function(arg)
			return arg
		end

		local v9 = fn29(game:GetService("HttpService"))
		local fn31 = isfolder
		local fn32 = isfile
		local fn33 = listfiles
		local v10 = fn29(game:GetService("SoundService"))

		local function fn34()
			local sound = Instance.new("Sound")
			sound.SoundId = "rbxassetid://124439666675060"
			sound.Volume = 1
			sound.Parent = v10
			sound:Play()

			sound.Ended:Connect(function()
				sound:Destroy()
			end)
		end

		local function fn35()
			local sound = Instance.new("Sound")
			sound.SoundId = "rbxassetid://130925746992865"
			sound.Volume = 5
			sound.Parent = v10
			sound:Play()

			sound.Ended:Connect(function()
				sound:Destroy()
			end)
		end

		local function fn36()
			local sound = Instance.new("Sound")
			sound.SoundId = "rbxassetid://99979147606311"
			sound.Volume = 5
			sound.Parent = v10
			sound:Play()

			sound.Ended:Connect(function()
				sound:Destroy()
			end)
		end

		if typeof(fn30) == "function" then
			local v11 = fn30(fn31)
			local v12 = fn30(fn32)
			local v13 = fn30(fn33)

			local ok, result = pcall(function()
				return v11("test" .. tostring(math.random(1000000, 9999999)))
			end)

			if ok == false or typeof(result) ~= "boolean" then
				fn31 = function(arg)
					local ok2, result2 = pcall(v11, arg)
					local flag12

					if ok2 then
						flag12 = result2
					else
						flag12 = false
					end

					return flag12
				end

				fn32 = function(arg)
					local ok2, result2 = pcall(v12, arg)

					if not ok2 then
						result2 = false
					end

					return result2
				end

				fn33 = function(arg)
					local ok2, result2 = pcall(v13, arg)
					local tbl10

					if ok2 then
						tbl10 = result2
					else
						tbl10 = {}
					end

					return tbl10
				end
			end
		end

		local tbl10

		tbl10 = {
			Folder = "ObsidianLibSettings",
			SubFolder = "",
			Ignore = {},
			Library = nil,
			UseLoadingOrder = false,
			LoadingOrder = {},
			Parser = {
				Toggle = {
					Save = function(arg, arg2)
						return { type = "Toggle", idx = arg, value = arg2.Value }
					end,
					Load = function(arg, arg2)
						local v11 = tbl10.Library.Toggles[arg]

						if v11 and v11.Value ~= arg2.value then
							v11:SetValue(arg2.value)
						end
					end,
				},
				Slider = {
					Save = function(arg, arg2)
						return { type = "Slider", idx = arg, value = tostring(arg2.Value) }
					end,
					Load = function(arg, arg2)
						local v11 = tbl10.Library.Options[arg]

						if v11 and v11.Value ~= arg2.value then
							v11:SetValue(arg2.value)
						end
					end,
				},
				Dropdown = {
					Save = function(arg, arg2)
						return { type = "Dropdown", idx = arg, value = arg2.Value, multi = arg2.Multi }
					end,
					Load = function(arg, arg2)
						local v11 = tbl10.Library.Options[arg]

						if v11 and v11.Value ~= arg2.value then
							v11:SetValue(arg2.value)
						end
					end,
				},
				ColorPicker = {
					Save = function(arg, arg2)
						return { type = "ColorPicker", idx = arg, value = arg2.Value:ToHex(), transparency = arg2.Transparency }
					end,
					Load = function(arg, arg2)
						if tbl10.Library.Options[arg] then
							local transparency = arg2.transparency
							tbl10.Library.Options[arg]:SetValueRGB(Color3.fromHex(arg2.value), transparency)
						end
					end,
				},
				KeyPicker = {
					Save = function(arg, arg2)
						return { type = "KeyPicker", idx = arg, mode = arg2.Mode, key = arg2.Value, modifiers = arg2.Modifiers }
					end,
					Load = function(arg, arg2)
						if tbl10.Library.Options[arg] then
							tbl10.Library.Options[arg]:SetValue({ arg2.key, arg2.mode, arg2.modifiers })
						end
					end,
				},
				Input = {
					Save = function(arg, arg2)
						return { type = "Input", idx = arg, text = arg2.Value }
					end,
					Load = function(arg, arg2)
						local v11 = tbl10.Library.Options[arg]

						if v11 and v11.Value ~= arg2.text and type(arg2.text) == "string" then
							tbl10.Library.Options[arg]:SetValue(arg2.text)
						end
					end,
				},
			},
			SetLibrary = function(arg, library)
				arg.Library = library
			end,
			SetLoadingOrder = function(arg, useLoadingOrder, loadingOrder)
				arg.UseLoadingOrder = useLoadingOrder

				if typeof(loadingOrder) == "table" then
					arg.LoadingOrder = loadingOrder
				end
			end,
			IgnoreThemeSettings = function(arg)
				arg:SetIgnoreIndexes({
					"BackgroundColor",
					"MainColor",
					"AccentColor",
					"OutlineColor",
					"FontColor",
					"FontFace",
					"ThemeManager_ThemeList",
					"ThemeManager_CustomThemeList",
					"ThemeManager_CustomThemeName",
				})
			end,
			CheckSubFolder = function(arg, arg2)
				if typeof(arg.SubFolder) ~= "string" or arg.SubFolder == "" then
					return false
				end

				if arg2 == true then
					if not fn31(arg.Folder .. "/settings/" .. arg.SubFolder) then
						makefolder(arg.Folder .. "/settings/" .. arg.SubFolder)
					end
				end

				return true
			end,
			GetPaths = function(arg)
				local tbl11 = {}
				local parts = arg.Folder:split("/")

				for i = 1, #parts do
					local str2 = table.concat(parts, "/", 1, i)

					if not table.find(tbl11, str2) then
						tbl11[#tbl11 + 1] = str2
					end
				end

				tbl11[#tbl11 + 1] = arg.Folder .. "/themes"
				tbl11[#tbl11 + 1] = arg.Folder .. "/settings"

				if arg:CheckSubFolder(false) then
					local parts2 = (arg.Folder .. "/settings/" .. arg.SubFolder):split("/")

					for i = 1, #parts2 do
						local str2 = table.concat(parts2, "/", 1, i)

						if not table.find(tbl11, str2) then
							tbl11[#tbl11 + 1] = str2
						end
					end
				end

				return tbl11
			end,
			BuildFolderTree = function(arg)
				local paths = arg:GetPaths()

				for i = 1, #paths do
					local v11 = paths[i]

					if not fn31(v11) then
						makefolder(v11)
					end
				end
			end,
			CheckFolderTree = function(arg)
				if fn31(arg.Folder) then
					return
				end
				tbl10:BuildFolderTree()
				task.wait(0.1)
			end,
			SetIgnoreIndexes = function(arg, arg2)
				for _, v11 in pairs(arg2) do
					arg.Ignore[v11] = true
				end
			end,
			SetFolder = function(arg, folder)
				arg.Folder = folder
				arg:BuildFolderTree()
			end,
			SetSubFolder = function(arg, subFolder)
				arg.SubFolder = subFolder
				arg:BuildFolderTree()
			end,
			Save = function(arg, arg2)
				if not arg2 then
					return false, "no config file is selected"
				end
				tbl10:CheckFolderTree()
				local str2 = arg.Folder .. "/settings/" .. arg2 .. ".json"

				if tbl10:CheckSubFolder(true) then
					str2 = arg.Folder .. "/settings/" .. arg.SubFolder .. "/" .. arg2 .. ".json"
				end

				local tbl11 = { objects = {} }

				for k, toggle in pairs(arg.Library.Toggles) do
					if toggle.Type then
						if arg.Parser[toggle.Type] then
							if not arg.Ignore[k] then
								table.insert(tbl11.objects, arg.Parser[toggle.Type].Save(k, toggle))
							end
						end
					end
				end

				for k, option in pairs(arg.Library.Options) do
					if option.Type then
						if arg.Parser[option.Type] then
							if not arg.Ignore[k] then
								table.insert(tbl11.objects, arg.Parser[option.Type].Save(k, option))
							end
						end
					end
				end

				local ok, result = pcall(v9.JSONEncode, v9, tbl11)
				if not ok then
					return false, "failed to encode data"
				end
				writefile(str2, result)
				return true
			end,
			Load = function(arg, arg2)
				if not arg2 then
					return false, "no config file is selected"
				end
				tbl10:CheckFolderTree()
				local str2 = arg.Folder .. "/settings/" .. arg2 .. ".json"

				if tbl10:CheckSubFolder(true) then
					str2 = arg.Folder .. "/settings/" .. arg.SubFolder .. "/" .. arg2 .. ".json"
				end

				if not fn32(str2) then
					return false, "invalid file"
				end
				local ok, result = pcall(v9.JSONDecode, v9, readfile(str2))
				if not ok then
					return false, "decode error"
				end

				if arg.UseLoadingOrder == true and typeof(arg.LoadingOrder) == "table" then
					table.sort(result.objects, function(arg3, arg4)
						return (table.find(arg.LoadingOrder, arg3.type) or math.huge) < (table.find(arg.LoadingOrder, arg4.type) or math.huge)
					end)
				end

				for _, v11 in result.objects, nil, nil do
					if v11.type then
						if arg.Parser[v11.type] then
							if not arg.Ignore[v11.idx] then
								task.spawn(arg.Parser[v11.type].Load, v11.idx, v11)
							end
						end
					end
				end

				return true
			end,
			Delete = function(arg, arg2)
				if not arg2 then
					return false, "no config file is selected"
				end
				local str2 = arg.Folder .. "/settings/" .. arg2 .. ".json"

				if tbl10:CheckSubFolder(true) then
					str2 = arg.Folder .. "/settings/" .. arg.SubFolder .. "/" .. arg2 .. ".json"
				end

				if not fn32(str2) then
					return false, "invalid file"
				end

				if not pcall(delfile, str2) then
					return false, "delete file error"
				end
				return true
			end,
			RefreshConfigList = function(arg)
				local ok, result = pcall(function()
					tbl10:CheckFolderTree()
					local tbl11 = {}
					local tbl12

					if tbl10:CheckSubFolder(true) then
						tbl12 = fn33(arg.Folder .. "/settings/" .. arg.SubFolder)
					else
						tbl12 = fn33(arg.Folder .. "/settings")
					end

					if typeof(tbl12) ~= "table" then
						tbl12 = {}
					end

					for i = 1, #tbl12 do
						local v11 = tbl12[i]

						if v11:sub(-5) == ".json" then
							local pos = v11:find(".json", 1, true)
							local str2 = v11:sub(pos, pos)
							local v12 = pos

							while str2 ~= "/" and str2 ~= "\\" and str2 ~= "" do
								v12 -= 1
								str2 = v11:sub(v12, v12)
							end

							if str2 == "/" or str2 == "\\" then
								table.insert(tbl11, v11:sub(v12 + 1, pos - 1))
							end
						end
					end

					return tbl11
				end)

				if not ok then
					if arg.Library then
						arg.Library:Notify("Failed to load config list: " .. tostring(result))
					else
						warn("Failed to load config list: " .. tostring(result))
					end

					return {}
				end

				return result
			end,
			GetAutoloadConfig = function(arg)
				tbl10:CheckFolderTree()
				local str2 = arg.Folder .. "/settings/autoload.txt"

				if tbl10:CheckSubFolder(true) then
					str2 = arg.Folder .. "/settings/" .. arg.SubFolder .. "/autoload.txt"
				end

				if fn32(str2) then
					local ok, result = pcall(readfile, str2)
					if not ok then
						return "none"
					end
					local str3 = tostring(result)

					if str3 == "" then
						str3 = "none"
					end

					return str3
				end

				return "none"
			end,
			LoadAutoloadConfig = function(arg)
				tbl10:CheckFolderTree()
				local str2 = arg.Folder .. "/settings/autoload.txt"

				if tbl10:CheckSubFolder(true) then
					str2 = arg.Folder .. "/settings/" .. arg.SubFolder .. "/autoload.txt"
				end

				if fn32(str2) then
					local ok, result = pcall(readfile, str2)

					if not ok then
						if arg.Library then
							arg.Library:Notify("Failed to load autoload config: write file error")
						end

						return
					end

					local v11, failedToLoadAutoloadConfig = arg:Load(result)

					if not v11 then
						if arg.Library then
							arg.Library:Notify("Failed to load autoload config: " .. failedToLoadAutoloadConfig)
						end

						return
					end

					if arg.Library then
						arg.Library:Notify(string.format("Auto loaded config %q", result))
					end
				end
			end,
			SaveAutoloadConfig = function(arg, arg2)
				tbl10:CheckFolderTree()
				local str2 = arg.Folder .. "/settings/autoload.txt"

				if tbl10:CheckSubFolder(true) then
					str2 = arg.Folder .. "/settings/" .. arg.SubFolder .. "/autoload.txt"
				end

				if not pcall(writefile, str2, arg2) then
					return false, "write file error"
				end
				return true, ""
			end,
			DeleteAutoLoadConfig = function(arg)
				tbl10:CheckFolderTree()
				local str2 = arg.Folder .. "/settings/autoload.txt"

				if tbl10:CheckSubFolder(true) then
					str2 = arg.Folder .. "/settings/" .. arg.SubFolder .. "/autoload.txt"
				end

				if not pcall(delfile, str2) then
					return false, "delete file error"
				end
				return true, ""
			end,
			BuildConfigSection = function(arg, arg2)
				assert(arg.Library, "Must set SaveManager.Library")
				local Configuration = arg2:AddRightGroupbox("Configuration", "folder-cog")
				Configuration:AddInput("SaveManager_ConfigName", { Text = "Config name" })

				Configuration:AddButton("Create config", function()
					local value = arg.Library.Options.SaveManager_ConfigName.Value

					if value:gsub(" ", "") == "" then
						if arg.Library then
							arg.Library:Notify("Invalid config name (empty)", 2)
						end

						fn34()
						return
					end

					local v11, hollyScriptX = arg:Save(value)

					if not v11 then
						if arg.Library then
							arg.Library:Notify("HollyScriptX: " .. hollyScriptX)
						end

						fn34()
						return
					end

					if arg.Library then
						arg.Library:Notify(string.format("Created config %q", value))
					end

					fn35()
					arg.Library.Options.SaveManager_ConfigList:SetValues(arg:RefreshConfigList())
					arg.Library.Options.SaveManager_ConfigList:SetValue(nil)
				end)

				Configuration:AddDivider()

				Configuration:AddDropdown("SaveManager_ConfigList", {
					Text = "Config list",
					Values = arg:RefreshConfigList(),
					AllowNull = true,
					Callback = function()
						fn36()
					end,
				})

				Configuration:AddButton("Load config", function()
					local value = arg.Library.Options.SaveManager_ConfigList.Value
					local v11, hollyScriptX = arg:Load(value)

					if not v11 then
						if arg.Library then
							arg.Library:Notify("HollyScriptX: " .. hollyScriptX)
						end

						fn34()
						return
					end

					if arg.Library then
						arg.Library:Notify(string.format("Success Loaded config %q", value))
					end

					fn35()
				end)

				Configuration:AddButton("Overwrite config", function()
					local value = arg.Library.Options.SaveManager_ConfigList.Value
					local v11, hollyScriptX = arg:Save(value)

					if not v11 then
						if arg.Library then
							arg.Library:Notify("HollyScriptX: " .. hollyScriptX)
						end

						fn34()
						return
					end

					if arg.Library then
						arg.Library:Notify(string.format("Overwrote config %q", value))
					end

					fn35()
				end)

				Configuration:AddButton("Delete config", function()
					local value = arg.Library.Options.SaveManager_ConfigList.Value
					local v11, hollyScriptX = arg:Delete(value)

					if not v11 then
						if arg.Library then
							arg.Library:Notify("HollyScriptX: " .. hollyScriptX)
						end

						fn34()
						return
					end

					if arg.Library then
						arg.Library:Notify(string.format("Deleted config %q", value))
					end

					fn35()
					arg.Library.Options.SaveManager_ConfigList:SetValues(arg:RefreshConfigList())
					arg.Library.Options.SaveManager_ConfigList:SetValue(nil)
				end)

				Configuration:AddButton("Refresh list", function()
					arg.Library.Options.SaveManager_ConfigList:SetValues(arg:RefreshConfigList())
					arg.Library.Options.SaveManager_ConfigList:SetValue(nil)
					fn36()
				end)

				Configuration:AddButton("Set as autoload", function()
					local currentAutoloadConfig = arg.Library.Options.SaveManager_ConfigList.Value
					local v11, failedToSetAutoloadConfig = arg:SaveAutoloadConfig(currentAutoloadConfig)

					if not v11 then
						if arg.Library then
							arg.Library:Notify("Failed to set autoload config: " .. failedToSetAutoloadConfig)
						end

						fn34()
						return
					end

					if arg.Library then
						arg.Library:Notify(string.format("Set %q to auto load", currentAutoloadConfig))
					end

					fn35()
					arg.AutoloadConfigLabel:SetText("Current autoload config: " .. currentAutoloadConfig)
				end)

				Configuration:AddButton("Reset autoload", function()
					local v11, failedToResetAutoload = arg:DeleteAutoLoadConfig()

					if not v11 then
						if arg.Library then
							arg.Library:Notify("Failed to reset autoload: " .. failedToResetAutoload)
						end

						fn34()
						return
					end

					if arg.Library then
						arg.Library:Notify("Set autoload to none")
					end

					fn35()
					arg.AutoloadConfigLabel:SetText("Current autoload config: none")
				end)

				arg.AutoloadConfigLabel = Configuration:AddLabel("Current autoload config: " .. arg:GetAutoloadConfig(), true)
				arg:SetIgnoreIndexes({ "SaveManager_ConfigList", "SaveManager_ConfigName" })
			end,
		}

		tbl10:BuildFolderTree()
		return tbl10
	end

	local v9 = fn28()
	local Settings = v:AddTab("Settings", "settings")
	v8:SetLibrary(lib)
	v9:SetLibrary(lib)
	v8:SetFolder("HollyScriptX")
	v9:SetFolder("HollyScriptX")
	v9:IgnoreThemeSettings()
	v8:ApplyToTab(Settings)
	local Credits = Settings:AddRightGroupbox("Credits", "users")
	Credits:AddLabel("rezorn - dev")
	Credits:AddDivider()
	Credits:AddLabel("whonixx - owner")
	Credits:AddDivider()
	Credits:AddLabel("shades - owner")
	Credits:AddDivider()
	Credits:AddLabel("insected - helped with obf/dc server")
	Credits:AddDivider()
	Credits:AddLabel("chillnie - script tester/co-owner")
	v9:BuildConfigSection(Settings)
	v9:LoadAutoloadConfig()
end

fn26()
