-- run status: finished
-- 94 statements recorded in 2.90s
-- URLs requested:
--   https://raw.githubusercontent.com/deividcomsono/Obsidian/main/Library.lua

task.spawn(function()
end)

task.spawn(function()
end)

task.delay(405, function()
	-- [envlog] cancelled before it ran
end)

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
Frame.Position = UDim2.new(0, 0, 0, 0)
Frame.Size = UDim2.new(0, 126, 0, 160)
Frame.Parent = ScreenGui
local Path2D = Instance.new("Path2D")
Path2D.Parent = Frame
Path2D:SetControlPoints({ Path2DControlPoint.new(UDim2.new(0.25, 9, 0, -10), UDim2.new(0, 0, 0, 0), UDim2.new(0, -8, 0, -5)), Path2DControlPoint.new(UDim2.new(0.5, 3, 0.25, 3), UDim2.new(0, 0, 0, 0), UDim2.new(0, 0, 0, 0)), Path2DControlPoint.new(UDim2.new(0.25, 8, 0.5, -10), UDim2.new(0, 0, 0, 0), UDim2.new(0, 2, 0, 0)), Path2DControlPoint.new(UDim2.new(0.5, 6, 0, 8), UDim2.new(0, -3, -0.125, -7), UDim2.new(0.125, 1, 0, 6)) })
Path2D:GetLength()
Path2D:GetPositionOnCurve(0.3333333432674408)
Path2D:GetPositionOnCurve(0.5)
Path2D:GetPositionOnCurve(0.8888888955116272)
Path2D:GetTangentOnCurve(0.58333331346511841)
Path2D:GetTangentOnCurve(0.18181818723678589)
Path2D:GetTangentOnCurve(0.76923078298568726)
Path2D:GetTangentOnCurve(0.5)
Path2D:GetPositionOnCurveArcLength(0.75)
Path2D:GetPositionOnCurveArcLength(0.1428571492433548)
Path2D:GetPositionOnCurveArcLength(0.25)
Path2D:GetTangentOnCurveArcLength(0.76923078298568726)
Path2D:GetTangentOnCurveArcLength(0.125)
Path2D:GetTangentOnCurveArcLength(0.5)
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
Folder2.Name = "844534590"
Folder:WaitForChild("844534590")
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
local Players = game:GetService("Players")
local response = game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/main/Library.lua")
local Obsidian = loadstring(response)()
-- isfile("HollyScriptX/remember_key.txt") -> false
Obsidian.CornerRadius = 25
Obsidian:SetCornerRadius(25)

local Window = Obsidian:CreateWindow({
	Title = "HollyScriptX",
	AlwaysOnTop = true,
	AutoShow = true,
	Center = true,
	CornerRadius = 25,
	Footer = "https://discord.gg/hsx | Loader",
	Resizable = true,
	ShowCustomCursor = false,
	ToggleKeybind = Enum.KeyCode.Z
})

local Tab = Window:AddTab("Key", "key-round")
local Tab2 = Window:AddTab("Settings", "settings")
local LeftGroupbox = Tab:AddLeftGroupbox("Auth")
LeftGroupbox:AddLabel("Get key from discord")

LeftGroupbox:AddInput("LoaderKeyInput", {
	Text = "Key",
	Default = "",
	Finished = false,
	Numeric = false,
	Placeholder = "HSX-....",
	Callback = function()
	end
})

-- isfile("HollyScriptX/remember_key.txt") -> false
LeftGroupbox:AddToggle("RememberCorrectKey", {
	Text = "Remember Correct key",
	Default = false,
	Callback = function(state)
		makefolder("HollyScriptX")

		if state then
			writefile("HollyScriptX/remember_key.txt", "1")
		else
			writefile("HollyScriptX/remember_key.txt", "0")
		end
	end
})

LeftGroupbox:AddButton({
	Text = "Submit Key",
	Func = function()
		tostring(tostring(Obsidian.Options.LoaderKeyInput.Value)):gsub("%s+", "")
		Obsidian:Notify("Wrong key. Get key from a discord server.", 4)
	end
})

LeftGroupbox:AddButton({
	Text = "Get Permanent Key",
	Func = function()
		setclipboard("https://discord.gg/hsx")
		Obsidian:Notify("Discord link has been copied successfully.", 3)
	end
})

local RightGroupbox = Tab:AddRightGroupbox("Game Detected")
RightGroupbox:AddLabel("Game: Unknown")
RightGroupbox:AddLabel("Status: Not Supported")
RightGroupbox:AddLabel("Game ID: 0")
RightGroupbox:AddLabel("Place ID: 0")
local LeftGroupbox2 = Tab2:AddLeftGroupbox("Menu")

task.defer(function()
	local Label = LeftGroupbox2:AddLabel("Menu bind")
	Label:AddKeyPicker("MenuKeybind", { Text = "Menu keybind", Default = "Z", Mode = "Toggle", NoUI = true })
	Obsidian.ToggleKeybind = Obsidian.Options.MenuKeybind
end)

LeftGroupbox2:AddDropdown("DPIScale", {
	Text = "DPI Scale",
	Default = "100",
	Values = { "50", "75", "90", "100", "125", "150", "200" },
	Callback = function(state)
		if state then
			Obsidian:SetDPIScale(tonumber(state))
		else
			Obsidian:SetDPIScale(100)
		end
	end
})

LeftGroupbox2:AddButton({
	Text = "Clear Saved Key",
	Func = function()
		writefile("HollyScriptX/auth_key.txt", "")
		writefile("HollyScriptX/remember_key.txt", "0")
		delfile("HollyScriptX/auth_key.txt")
		delfile("HollyScriptX/remember_key.txt")
		delfile("HollyScriptX/selected_game.txt")
		Obsidian:Notify("Saved key cleared.", 2)
	end
})

LeftGroupbox2:AddButton({
	Text = "Unload Loader",
	Func = function()
		Obsidian:Unload()
	end
})
