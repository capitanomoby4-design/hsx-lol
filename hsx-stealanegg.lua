-- leak by uwustudios discord.gg/uwustudios
local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/capitanomoby4-design/hsx-lol/refs/heads/main/library/stealanegg/library.lua"))()
local lib2 = loadstring(game:HttpGet("https://raw.githubusercontent.com/capitanomoby4-design/hsx-lol/refs/heads/main/library/stealanegg/ThemeManager.lua"))()
local lib3 = loadstring(game:HttpGet("https://raw.githubusercontent.com/capitanomoby4-design/hsx-lol/raw/refs/heads/main/library/stealanegg/SaveManager.lua"))()

if not isfile("Holy.png") then
	pcall(function()
		writefile("Holy.png", game:HttpGet("https://raw.githubusercontent.com/capitanomoby4-design/hsx-lol/refs/heads/main/media/image.png"))
	end)
end

local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ProximityPromptService = game:GetService("ProximityPromptService")
local UserInputService = game:GetService("UserInputService")
local localPlayer = Players.LocalPlayer
local v = localPlayer

local tbl = {
	Workspace = Workspace,
	Players = Players,
	LocalPlayer = localPlayer,
	ReplicatedStorage = ReplicatedStorage,
	RunService = RunService,
	ProximityPromptService = ProximityPromptService,
	conns = {},
	ignoredEggs = {},
	Target = nil,
	sessionStart = os.clock(),
	lastStealTime = os.clock(),
	stats = { stolen = 0, lost = 0, hatched = 0, sold = 0 },
	areas = {
		"Forest",
		"Lake",
		"Desert",
		"Jungle",
		"Snow",
		"Volcano",
		"Abyss Ocean",
		"Prehistoric",
		"Cosmic",
		"Cherry Blossom",
		"Titan Temple",
		"Light Dark",
	},
}

local tbl2 = {}

for _, area in ipairs(tbl.areas) do
	tbl2[area] = true
end

getgenv().config = {
	killAura = false,
	attackDistance = 16.5,
	attackCooldown = 0.1,
	autoFarm = false,
	farmMode = "Teleport",
	glideSpeed = 750,
	stealDelay = 1,
	avoidTraps = true,
	stealBigEggsOnly = false,
	stealParasiteOnly = false,
	selectedStealRarities = {},
	selectedStealAreas = {},
	droneFarm = false,
	droneSelectedHp = {},
	droneDistance = 4.5,
	droneGlideSpeed = 650,
	droneAttackCooldown = 0.1,
	speedEnabled = false,
	walkSpeed = 500,
	antiRagdoll = true,
	espEnabled = false,
	minEspEarning = 0,
	plotEsp = false,
	espBeam = false,
	autoHatch = false,
	hatchInterval = 3,
	autoCollect = false,
	collectInterval = 60,
	autoPlaceEgg = false,
	placeInterval = 5,
	neverPlaceRarity = "None",
	placeMinGen = 0,
	equipBestPets = false,
	autoUpgPen = false,
	autoUpgTreadmill = false,
	autoUpgTrails = false,
	keepMoney = 0,
	autoTreadmill = false,
	trainWhenIdle = true,
	autoSellPet = false,
	sellAllPets = false,
	sellPetInterval = 5,
	sellPetRarities = {},
	autoSellEgg = false,
	sellEggInterval = 5,
	sellEggRarities = {},
	sellUnderGen = 0,
}

local tbl3 = {
	"Titan",
	"Divine",
	"Superior",
	"Eternal",
	"Limited",
	"Secret",
	"Exotic",
	"Cosmic",
	"Exclusive",
	"Mythic",
	"Rainbow",
	"Legendary",
	"Epic",
	"Rare",
	"SuperRare",
	"Uncommon",
	"Common",
}

local tbl4 = {
	Common = 1,
	Uncommon = 2,
	Rare = 3,
	SuperRare = 4,
	Epic = 5,
	Legendary = 6,
	Rainbow = 7,
	Mythic = 8,
	Exclusive = 9,
	Cosmic = 10,
	Exotic = 11,
	Secret = 12,
	Limited = 13,
	Eternal = 14,
	Superior = 15,
	Divine = 16,
	Titan = 17,
}

local tbl5 = {
	Titan = 1100,
	Divine = 1000,
	Transcendent = 1000,
	Superior = 1000,
	Eternal = 900,
	Limited = 900,
	Secret = 800,
	Exotic = 800,
	Cosmic = 700,
	Exclusive = 700,
	Mythic = 600,
	Mythical = 600,
	Prismatic = 600,
	Rainbow = 600,
	Legendary = 500,
	Epic = 400,
	Rare = 300,
	SuperRare = 200,
	Uncommon = 200,
	Common = 100,
}

local tbl6 = {}

for k, v2 in pairs({
	Common = { "Chicken", "Dog", "Frog", "Duckling", "Jerboa" },
	Uncommon = { "Bird", "Catfish", "Fennec" },
	Rare = {
		"Owl",
		"Raccoon",
		"Turtle",
		"Camel",
		"Toucan",
		"Chimpanzee",
		"Penguin",
		"Lava Gecko",
		"Parrotfish",
		"Dodo",
		"Tung Tung Sahur",
	},
	Epic = {
		"Bear",
		"Fox",
		"Trulimero Trulicina",
		"Swan",
		"Tob Tobi Tob Tob",
		"Crocodile",
		"Walrus",
		"Lava Frog",
		"Swordfish",
		"Centapede",
		"Crane",
		"Bananita Dolphinita",
	},
	Legendary = {
		"Brr Brr Patapim",
		"Axolotl",
		"Snake",
		"Gorilla",
		"Orangutini Ananassini",
		"Polar Bear",
		"Flaming Bull",
		"Lava Iguana",
		"Shark",
		"Pterodactyl",
		"Cosmic Gecko",
		"Salamander",
		"Crustacia",
		"Spideron",
		"Scorpio",
		"Mecha Scorpio",
	},
	Mythic = {
		"Scorpion",
		"Sand Spider",
		"Spider",
		"Tiger",
		"Sabertooth Tiger",
		"Mammoth",
		"Chillin Chilli",
		"Orca",
		"Ankylosaurus",
		"Cosmic Gorilla",
		"Red Panda",
		"Bladehide",
		"Belula Beluga",
		"Froggo",
		"Mecha Froggo",
	},
	Divine = { "Unicorn", "Kitsune", "Dreadscale", "Mecha Dreadscale" },
	Secret = {
		"King Snake",
		"Yeti",
		"Cerberus",
		"Kraken",
		"Tralaledon",
		"TRex",
		"Cosmic Dragon",
		"Cosmic Skeleton Boss",
		"Stag",
		"Mutant Shark",
		"Bomboclat Crocolat",
		"Crocodon",
		"Mecha Crocodon",
	},
	Cosmic = {
		"Leviathan",
		"Royal Sphinx",
		"King Mammoth",
		"Whale Shark",
		"Beluga Whale",
		"Triceratops",
		"Bronto",
		"Mosasaurus",
		"Koi",
		"Snowy Owl",
		"Mantaris",
		"Rhinotaur",
		"Mangolini Parrochini",
		"Crawler",
		"Mecha Crawler",
	},
	Eternal = {
		"Ice Dragon",
		"Phoenix",
		"Lava Dragon",
		"El Maja",
		"Eternal Lunar Dragon",
		"Oni Tiger",
		"Gorilla King",
		"Strawberry Elephant",
		"Krakenoid",
		"Mecha Krakenoid",
	},
}) do
	for _, v3 in ipairs(v2) do
		tbl6[v3] = k
	end
end

local function fn()
	local packages = ReplicatedStorage:FindFirstChild("Packages")
	return packages and packages:FindFirstChild("Networking") or ReplicatedStorage:FindFirstChild("Network") or ReplicatedStorage
end

local EggState = nil
local PlotState = nil
local Assets = nil
local Rarity = nil
local AreaEggSlotIdentity = nil
local EggToolDisplay = nil
local flag = false

local function fn2(...)
	for _, v2 in ipairs({ ... }) do
		local ok, result = pcall(function()
			local v3 = ReplicatedStorage

			for match in string.gmatch(v2, "[^.]+") do
				v3 = v3:FindFirstChild(match)
				if not v3 then
					return nil
				end
			end

			return require(v3)
		end)

		if ok and result then
			return result
		end
	end

	return nil
end

local function fn3()
	if flag then
		return true
	end
	EggState = fn2("Client.EggState", "Shared.EggState")
	PlotState = fn2("Client.PlotState", "Shared.PlotState")
	Assets = fn2("Data.Assets", "Shared.Assets", "Assets")
	Rarity = fn2("Data.Rarity", "Shared.Rarity", "Rarity")
	EggToolDisplay = fn2("Shared.Eggs.EggToolDisplay")
	AreaEggSlotIdentity = fn2("Shared.Util.AreaEggSlotIdentity", "Util.AreaEggSlotIdentity", "Shared.Utils.AreaEggSlotIdentity")
	flag = EggState ~= nil
	return flag
end

local n = -364.5
local n2 = 525

local function fn4()
	local character = v.Character
	return character and character:FindFirstChildOfClass("Humanoid")
end

local function fn5()
	local character = v.Character

	if character then
		character = character:FindFirstChild("HumanoidRootPart") or character.PrimaryPart or character:FindFirstChildWhichIsA("BasePart")
	end

	return character
end

local function fn6(arg)
	local n3 = tonumber(arg) or 0
	if n3 >= 1e12 then
		return string.format("%.1fT", n3 / 1e12)
	end

	if n3 >= 1e9 then
		return string.format("%.1fB", n3 / 1e9)
	end

	if n3 >= 1000000 then
		return string.format("%.1fM", n3 / 1000000)
	end

	if n3 >= 1000 then
		return string.format("%.1fK", n3 / 1000)
	end
	return tostring(math.floor(n3))
end

local function fn7(arg)
	if type(arg) == "number" then
		return arg
	end

	if type(arg) ~= "string" then
		return 0
	end
	local match, v2 = arg:gsub(",", ""):gsub("%s+", ""):lower():match("([%d%.]+)([kmb]?)")
	local n3 = tonumber(match) or 0
	if v2 == "k" then
		return n3 * 1000
	end

	if v2 == "m" then
		return n3 * 1000000
	end

	if v2 == "b" then
		return n3 * 1e9
	end
	return n3
end

local function fn8()
	return Vector3.new(438.5, 71, -369.9), CFrame.new(438.5, 71, -369.9)
end

local function fn9()
	local leaderstats = v:FindFirstChild("leaderstats")

	if leaderstats then
		leaderstats = leaderstats:FindFirstChild("Money") or leaderstats:FindFirstChild("Cash") or leaderstats:FindFirstChild("Coins")
	end

	if leaderstats and leaderstats:IsA("ValueBase") then
		return tonumber(leaderstats.Value) or 0
	end
	return 0
end

local tbl7 = {
	[Enum.HumanoidStateType.Ragdoll] = true,
	[Enum.HumanoidStateType.FallingDown] = true,
	[Enum.HumanoidStateType.PlatformStanding] = true,
	[Enum.HumanoidStateType.Physics] = true,
}

local function fn10(arg)
	if not arg then
		return
	end

	for k in pairs(tbl7) do
		arg:SetStateEnabled(k, not getgenv().config.antiRagdoll)
	end

	arg:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
	arg:SetStateEnabled(Enum.HumanoidStateType.Freefall, true)

	arg.StateChanged:Connect(function(old, new)
		if getgenv().config.antiRagdoll and tbl7[new] then
			arg:ChangeState(Enum.HumanoidStateType.GettingUp)
		end
	end)
end

local function fn11(arg)
	if not arg then
		return
	end

	for _, descendant in ipairs(arg:GetDescendants()) do
		if descendant:IsA("Motor6D") then
			descendant:GetPropertyChangedSignal("Enabled"):Connect(function()
				if getgenv().config.antiRagdoll and not descendant.Enabled then
					descendant.Enabled = true
				end
			end)
		elseif descendant:IsA("BallSocketConstraint") then
			if getgenv().config.antiRagdoll then
				descendant:Destroy()
			end
		end
	end

	arg.DescendantAdded:Connect(function(descendant)
		if not getgenv().config.antiRagdoll then
			return
		end

		if descendant:IsA("BallSocketConstraint") then
			RunService.Stepped:Wait()

			if getgenv().config.antiRagdoll and descendant and descendant.Parent then
				descendant:Destroy()
			end
		elseif descendant:IsA("Motor6D") then
			descendant:GetPropertyChangedSignal("Enabled"):Connect(function()
				if getgenv().config.antiRagdoll and not descendant.Enabled then
					descendant.Enabled = true
				end
			end)
		end
	end)
end

local function fn12(arg)
	local character = arg or v.Character
	if not character then
		return
	end
	local humanoid = character:FindFirstChildOfClass("Humanoid")

	if humanoid then
		fn10(humanoid)
	end

	fn11(character)

	if character:GetAttribute("IsTrapped") then
		character:SetAttribute("IsTrapped", nil)
	end
end

tbl.initAntiRagdoll = function()
	task.spawn(function()
		fn12(v.Character or v.CharacterAdded:Wait())

		v.CharacterAdded:Connect(function(character)
			task.wait(0.1)
			fn12(character)
		end)
	end)
end

local function fn13()
	local debris = Workspace:FindFirstChild("__DEBRIS")
	if not debris then
		return
	end

	for _, child in ipairs(debris:GetChildren()) do
		local flag2 = child.Name == "PlayerTrap"

		if flag2 then
			local name = v.Name
			flag2 = child:GetAttribute("Owner") ~= name
		end

		if flag2 then
			if child:IsA("BasePart") then
				child.CanTouch = false
				child.CanQuery = false
			end

			for _, child2 in ipairs(child:GetChildren()) do
				if child2:IsA("BasePart") then
					child2.CanTouch = false
					child2.CanQuery = false

					if child2.Name == "Hitbox" then
						child2.CFrame = CFrame.new(0, -999, 0)
					end
				end
			end

			local touchTransmitter = child:FindFirstChildWhichIsA("TouchTransmitter", true)

			if touchTransmitter then
				pcall(function()
					touchTransmitter:Destroy()
				end)
			end
		end
	end
end

local flag2 = false

local function fn14(arg)
	if not arg or not arg:IsA("Tool") then
		return false
	end
	local v2 = string.lower(arg.Name)
	if string.find(v2, "sword") or string.find(v2, "radar") or string.find(v2, "basket") or string.find(v2, "punch") or string.find(v2, "bat") or string.find(v2, "slap") or string.find(v2, "potion") or string.find(v2, "lantern") then
		return false
	end

	if tbl6[arg.Name] then
		return false
	end
	local attribute = arg:GetAttribute("ItemType")
	if attribute == "Asset" or attribute == "Phone" or attribute == "Gear" or attribute == "Weapon" then
		return false
	end

	if arg:GetAttribute("EggUid") or arg:GetAttribute("UID") or string.find(v2, "egg") or arg:GetAttribute("Category") or attribute == "Egg" or attribute == "AssetEgg" or attribute == "PetEgg" or tbl2[arg.Name] then
		return true
	end
	return false
end

local function fn15()
	local character = v.Character

	if character then
		for _, child in ipairs(character:GetChildren()) do
			if fn14(child) then
				return child, child:GetAttribute("UID") or child:GetAttribute("EggUid") or child:GetAttribute("Uid") or child.Name
			end
		end
	end

	return nil, nil
end

local function fn16()
	local character = v.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	local backpack = v:FindFirstChild("Backpack")

	if humanoid then
		pcall(function()
			humanoid:UnequipTools()
		end)
	end

	if character and backpack then
		for _, child in ipairs(character:GetChildren()) do
			if child:IsA("Tool") then
				pcall(function()
					child.Parent = backpack
				end)
			end
		end
	end
end

local function fn17(arg)
	if not flag2 then
		if fn15() then
			pcall(fn16)
		end

		return false
	end

	local v2, v3 = fn15()

	if v2 then
		if not arg then
			return true
		end

		if v3 == arg or not v3 then
			return true
		end
	end

	local v4 = fn5()
	if v4 and v4.Position.X <= n2 + 15 then
		return false
	end

	if EggState and EggState.ReadFieldEggs then
		local ok, result = pcall(EggState.ReadFieldEggs)

		if ok and result and result.Records then
			for _, record in ipairs(result.Records) do
				if (record.State == "Carried" or record.State == 2) and (record.CarrierUserId == v.UserId or record.Carrier == v.UserId) then
					if arg then
						if record.Uid == arg then
							return true
						end
						continue
					end

					return true
				end
			end
		end
	end

	return false
end

local function fn18(arg)
	local v2, v3 = fn15()

	if v2 then
		if not arg or v3 == arg or not v3 then
			return true
		end
	end

	local backpack = v:FindFirstChild("Backpack")

	if backpack then
		for _, child in ipairs(backpack:GetChildren()) do
			if fn14(child) then
				local attribute = child:GetAttribute("UID") or child:GetAttribute("EggUid") or child:GetAttribute("Uid")
				if not arg or attribute == arg or child.Name == tostring(arg) then
					return true
				end
			end
		end
	end

	if arg and EggState and EggState.ReadFieldEggs then
		local ok, result = pcall(EggState.ReadFieldEggs)

		if ok and result and result.Records then
			for _, record in ipairs(result.Records) do
				if record.Uid == arg and (record.State == "Carried" or record.State == 2) then
					if (record.CarrierUserId or record.Carrier) == v.UserId then
						return true
					end
				end
			end
		end
	end

	return false
end

local function createPart(arg, arg2)
	local n3 = arg2 or 8
	local part = Instance.new("Part")
	part.Name = "SafetyFloorPad_AntiVoid"
	part.Size = Vector3.new(28, 1.5, 28)
	part.Position = arg - Vector3.new(0, 3.2, 0)
	part.Anchored = true
	part.Transparency = 1
	part.CanCollide = true
	part.Parent = Workspace

	task.delay(n3, function()
		pcall(function()
			part:Destroy()
		end)
	end)

	return part
end

local function fn19(arg, arg2)
	if arg then
		for _, descendant in ipairs(arg:GetDescendants()) do
			if descendant:IsA("ProximityPrompt") then
				pcall(function()
					descendant.RequiresLineOfSight = false
					descendant.HoldDuration = 0

					if typeof(fireproximityprompt) == "function" then
						fireproximityprompt(descendant, 0)
						fireproximityprompt(descendant)
					end
				end)
			end
		end
	end

	local areaEggSlotsClient = Workspace:FindFirstChild("AreaEggSlotsClient")

	if areaEggSlotsClient and arg2 then
		for _, child in ipairs(areaEggSlotsClient:GetChildren()) do
			local basePart = child:FindFirstChildWhichIsA("BasePart") or child.PrimaryPart

			if basePart and (basePart.Position - arg2).Magnitude <= 18 then
				for _, descendant in ipairs(child:GetDescendants()) do
					if descendant:IsA("ProximityPrompt") then
						pcall(function()
							descendant.RequiresLineOfSight = false
							descendant.HoldDuration = 0

							if typeof(fireproximityprompt) == "function" then
								fireproximityprompt(descendant, 0)
								fireproximityprompt(descendant)
							end
						end)
					end
				end
			end
		end
	end
end

local function fn20(arg, arg2)
	local v2 = fn()
	local v3 = v2:FindFirstChild(arg) or ReplicatedStorage:FindFirstChild(arg)
	if v3 then
		return v3
	end
	local v4 = v2:FindFirstChild(arg, true) or ReplicatedStorage:FindFirstChild(arg, true)
	if v4 then
		return v4
	end

	if arg2 then
		local v5 = v2:FindFirstChild(arg2) or ReplicatedStorage:FindFirstChild(arg2)
		if v5 then
			return v5
		end
		local v6 = v2:FindFirstChild(arg2, true) or ReplicatedStorage:FindFirstChild(arg2, true)
		if v6 then
			return v6
		end
	end

	return nil
end

local tbl8 = {
	ForestStrike = fn20("RE/GuardPatrol/ForestStrike", "ForestStrike"),
	SpeedTollOffer = fn20("SpeedTollOffer", "RE/GuardPatrol/SpeedTollOffer"),
	CarryRemote = fn20("RF/EggWorld/AskFieldEggCarry", "AskFieldEggCarry"),
}

local function fn21(arg, arg2)
	local v2 = fn5()
	if not v2 or not v.Character then
		return false
	end

	if EggState and EggState.ReadFieldEggs then
		local ok, result = pcall(EggState.ReadFieldEggs)

		if ok and result and result.Records then
			for _, record in ipairs(result.Records) do
				if record.Uid == arg then
					if record.BoundsCFrame then
						arg2 = record.BoundsCFrame.Position
					end

					break
				end
			end
		end
	end

	local areaEggSlotsClient = Workspace:FindFirstChild("AreaEggSlotsClient")
	areaEggSlotsClient = areaEggSlotsClient and areaEggSlotsClient:FindFirstChild(arg) or Workspace:FindFirstChild(arg, true)
	local v3 = nil

	if areaEggSlotsClient then
		local basePart = areaEggSlotsClient:FindFirstChildWhichIsA("BasePart") or areaEggSlotsClient.PrimaryPart

		if basePart then
			arg2 = basePart.Position
			v3 = areaEggSlotsClient
		else
			v3 = areaEggSlotsClient
		end
	end

	if not arg2 then
		return false
	end
	createPart(arg2, 8)
	v2.CFrame = CFrame.new(arg2 + Vector3.new(0, 1.5, 0))
	v2.AssemblyLinearVelocity = Vector3.zero
	v2.AssemblyAngularVelocity = Vector3.zero
	task.wait(0.1)
	local carryRemote = tbl8.CarryRemote or fn() and fn():FindFirstChild("RF/EggWorld/AskFieldEggCarry")
	local n3 = os.clock() + 4
	flag2 = true

	while true do
		if os.clock() < n3 and getgenv().config.autoFarm then
			if not (fn18(arg) or fn17(arg)) then
				v2.CFrame = CFrame.new(arg2 + Vector3.new(0, 1.2, 0))
				fn19(v3, arg2)

				if carryRemote then
					task.spawn(function()
						pcall(function()
							if carryRemote:IsA("RemoteFunction") then
								carryRemote:InvokeServer({ Uid = arg })
								carryRemote:InvokeServer(arg)
							else
								carryRemote:FireServer({ Uid = arg })
								carryRemote:FireServer(arg)
							end
						end)
					end)
				end

				RunService.Heartbeat:Wait()
				continue
			end
		end

		break
	end

	return fn18(arg) or fn17(arg)
end

local function fn22(arg, arg2, arg3, arg4)
	local v2 = fn5()
	if not v2 or not arg then
		return false
	end
	local magnitude = (arg - v2.Position).Magnitude

	if magnitude < 1 then
		local z = arg.Z
		v2.CFrame = CFrame.new(arg.X, math.max(arg.Y, 70), z)
		v2.AssemblyLinearVelocity = Vector3.zero
		v2.AssemblyAngularVelocity = Vector3.zero
		return true
	end

	local n3 = math.clamp(tonumber(arg2) or 750, 50, 750)
	local now = os.clock()

	while getgenv().config.autoFarm do
		if arg4 and not fn18(arg4) and not fn17(arg4) then
			local position = v2.Position
			local flag3 = false

			for i = 1, 5 do
				if getgenv().config.autoFarm then
					flag3 = fn21(arg4, position)
					if not flag3 then
						task.wait(0.2)
						continue
					end
				end

				break
			end

			if not flag3 then
				return false
			end
		end

		local result = RunService.Heartbeat:Wait()
		local position = v2.Position

		if position.Y < 60 then
			v2.CFrame = CFrame.new(position.X, 70.4, n)
			v2.AssemblyLinearVelocity = Vector3.zero
			v2.AssemblyAngularVelocity = Vector3.zero
			position = v2.Position
		end

		local n4 = arg - position
		local magnitude2 = n4.Magnitude
		if magnitude2 < 1 then
			break
		end
		local n5

		if arg3 then
			n5 = math.max(n3 * (1 - (1 - math.clamp(magnitude2 / magnitude, 0, 1)) * 0.8), 35)
		else
			n5 = n3
		end

		local unit = n4.Unit
		local n6 = position + unit * math.min(n5 * result, magnitude2)
		v2.CFrame = CFrame.lookAt(n6, n6 + unit)
		v2.AssemblyLinearVelocity = Vector3.zero
		v2.AssemblyAngularVelocity = Vector3.zero
		if not (magnitude / 50 + 5 < os.clock() - now) then
			continue
		end
		break
	end

	local z = arg.Z
	v2.CFrame = CFrame.new(arg.X, math.max(arg.Y, 70), z)
	v2.AssemblyLinearVelocity = Vector3.zero
	v2.AssemblyAngularVelocity = Vector3.zero
	return true
end

local function fn23(arg, arg2, arg3, arg4)
	local v2 = fn5()
	if not v2 or not arg then
		return false
	end

	if getgenv().config.avoidTraps then
		pcall(fn13)
	end

	local position = v2.Position
	local n3 = math.max(position.Y, arg.Y, 70.4)

	if arg.X < 560 and position.X > 580 then
		fn22(Vector3.new(position.X, n3, n), arg2, false, arg4)
		fn22(Vector3.new(580, n3, n), arg2, false, arg4)
		fn22(Vector3.new(arg.X, n3, n), 245, false, arg4)
		fn22(arg + Vector3.new(0, 1.2, 0), 245, arg3 == true, arg4)
		return true
	end

	local vector = Vector3.new(position.X, n3, n)
	local vector2 = Vector3.new(arg.X, n3, n)
	fn22(vector, arg2, false, arg4)
	fn22(vector2, arg2, false, arg4)
	fn22(arg + Vector3.new(0, 1.2, 0), arg2, arg3 == true, arg4)
	return true
end

local function fn24(arg, arg2)
	local v2 = fn5()
	local v3 = fn4()
	if not v2 then
		return false
	end

	if v3 then
		v3.AutoRotate = false
	end

	local n3 = math.max(100, arg or getgenv().config.glideSpeed or 600)
	local vector = Vector3.new(525, 70, n)
	createPart(vector, 20)
	v2.AssemblyLinearVelocity = Vector3.zero
	v2.AssemblyAngularVelocity = Vector3.zero
	local n4 = os.clock() + 20

	while getgenv().config.autoFarm and os.clock() < n4 do
		if arg2 and not fn18(arg2) and not fn17(arg2) then
			local position = v2.Position
			local flag3 = false

			for i = 1, 5 do
				if getgenv().config.autoFarm then
					flag3 = fn21(arg2, position)
					if not flag3 then
						task.wait(0.2)
						continue
					end
				end

				break
			end

			if not flag3 then
				if v3 then
					v3.AutoRotate = true
				end

				return false
			end
		end

		local position = v2.Position
		if position.X <= n2 + 10 or (vector - position).Magnitude <= 6 then
			pcall(fn16)
			break
		end
		local result = RunService.Heartbeat:Wait()
		local position2 = v2.Position
		local n5

		if position2.X <= 620 and position2.X > 525 then
			n5 = 130 + (n3 - 130) * math.clamp((position2.X - 525) / 95, 0, 1)
		elseif not (position2.X <= 525) then
			n5 = n3
		else
			n5 = 130
		end

		local min = math.min
		local n6 = position2.X + math.sign(vector.X - position2.X) * min(math.abs(vector.X - position2.X), n5 * result)
		local min2 = math.min
		local n7 = position2.Y + math.sign(vector.Y - position2.Y) * min2(math.abs(vector.Y - position2.Y), n5 * result * 0.5)
		local n8 = n - position2.Z
		local min3 = math.min
		local vector2 = Vector3.new(n6, n7, position2.Z + math.sign(n8) * min3(math.abs(n8), n5 * result))
		v2.CFrame = CFrame.lookAt(vector2, vector2 + ((vector2 - position2).Magnitude > 0.05 and (vector2 - position2).Unit or v2.CFrame.LookVector))
		v2.AssemblyLinearVelocity = Vector3.zero
		v2.AssemblyAngularVelocity = Vector3.zero
	end

	v2.CFrame = CFrame.new(525, math.max(68, v2.Position.Y), n)
	v2.AssemblyLinearVelocity = Vector3.zero
	v2.AssemblyAngularVelocity = Vector3.zero

	if v3 then
		v3.AutoRotate = true
	end

	pcall(fn16)
	return true
end

local function fn25(arg)
	if not arg then
		return "Common", 100
	end

	if arg.Rarity then
		local rarity = arg.Rarity
		local displayName = type(rarity) == "table" and (rarity.DisplayName or rarity._id or rarity.Name) or tostring(rarity)
		return displayName, tbl5[displayName] or type(rarity) == "table" and tonumber(rarity.RarityNumber) and rarity.RarityNumber * 100 or 100
	end

	local assetCategory = arg.AssetCategory or arg.Category or arg.Name

	if assetCategory and Assets then
		local v2 = (Assets.Directory or Assets)[assetCategory]

		if v2 and v2.Rarity then
			local rarity = v2.Rarity
			local displayName = type(rarity) == "table" and (rarity.DisplayName or rarity._id or rarity.Name) or tostring(rarity)
			return displayName, tbl5[displayName] or type(rarity) == "table" and tonumber(rarity.RarityNumber) and rarity.RarityNumber * 100 or 100
		end
	end

	return "Common", 100
end

local function fn26(arg, arg2)
	if not arg2 or type(arg2) ~= "table" then
		return true
	end
	local n3 = 0

	for k in pairs(arg2) do
		n3 += 1
	end

	if n3 == 0 then
		return true
	end
	return arg2[arg] == true
end

local function fn27(arg, arg2)
	if not arg2 or type(arg2) ~= "table" then
		return true
	end
	local n3 = 0

	for k in pairs(arg2) do
		n3 += 1
	end

	if n3 == 0 then
		return true
	end
	return arg2[arg] == true
end

local function fn28(arg)
	if not arg then
		return false
	end
	local n3 = tonumber(arg.AssetScale) or 1
	local n4 = tonumber(arg.NestScale) or 1
	return n3 >= 1.35 or n4 >= 1
end

local function fn29(arg)
	if not arg then
		return false
	end
	local mutations = arg.Mutations or {}
	local flag3 = arg.HasParasite == true
	local flag4

	if flag3 then
		flag4 = flag3
	else
		flag4 = type(mutations) == "table" and table.find(mutations, "Parasite")
	end

	return flag4 or type(mutations) == "table" and table.find(mutations, "Monstrous")
end

local function fn30()
	if not EggState then
		fn3()
	end

	if not EggState or not EggState.ReadFieldEggs then
		return {}
	end
	local ok, result = pcall(EggState.ReadFieldEggs)
	if not ok or not result or not result.Records then
		return {}
	end
	local tbl9 = {}

	for _, record in ipairs(result.Records) do
		if record.State == "Slot" and record.BoundsCFrame then
			local flag3 = tbl.ignoredEggs[record.Uid]

			if flag3 then
				local v2 = tbl.ignoredEggs[record.Uid]
				flag3 = os.clock() - v2 < 3
			end

			if not flag3 and (not getgenv().config.stealBigEggsOnly or fn28(record)) then
				local v2 = fn27(record.AreaId, getgenv().config.selectedStealAreas)
				local v3, v4 = fn25(record)
				local v5 = fn26(v3, getgenv().config.selectedStealRarities)
				local mutations = record.Mutations or {}
				local v6 = fn29(record)

				if not getgenv().config.stealParasiteOnly or v6 then
					if v2 and v5 then
						local n3 = 0

						for _, mutation in ipairs(mutations) do
							if mutation == "Rainbow" then
								n3 += 35
							elseif mutation == "Gold" or mutation == "Golden" then
								n3 += 20
							elseif mutation == "Silver" then
								n3 += 10
							end
						end

						if v6 then
							n3 += 800
						end

						if fn28(record) then
							n3 += 600
						end

						table.insert(tbl9, { record = record, rarity = v3, score = v4 + n3 })
					end
				end
			end
		end
	end

	if #tbl9 > 1 then
		table.sort(tbl9, function(arg, arg2)
			return arg.score > arg2.score
		end)
	end

	return tbl9
end

tbl.toggleFlight = function(arg, flightEnabled)
	getgenv().config.flightEnabled = flightEnabled
	local v2 = fn5()
	local v3 = fn4()
	if not v2 or not v3 then
		return
	end

	if not flightEnabled then
		v3.PlatformStand = false
		v2.AssemblyLinearVelocity = Vector3.zero
		return
	end

	task.spawn(function()
		while getgenv().config.flightEnabled and v.Character and v.Character:FindFirstChild("HumanoidRootPart") do
			RunService.Heartbeat:Wait()
			local currentCamera = Workspace.CurrentCamera

			if currentCamera then
				local vector = Vector3.zero

				if UserInputService:IsKeyDown(Enum.KeyCode.W) then
					vector = Vector3.zero + currentCamera.CFrame.LookVector
				end

				if UserInputService:IsKeyDown(Enum.KeyCode.S) then
					vector -= currentCamera.CFrame.LookVector
				end

				if UserInputService:IsKeyDown(Enum.KeyCode.D) then
					vector += currentCamera.CFrame.RightVector
				end

				if UserInputService:IsKeyDown(Enum.KeyCode.A) then
					vector -= currentCamera.CFrame.RightVector
				end

				if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
					vector += Vector3.new(0, 1, 0)
				end

				if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
					vector -= Vector3.new(0, 1, 0)
				end

				local flightSpeed = getgenv().config.flightSpeed or 300

				if vector.Magnitude > 0 then
					vector = vector.Unit * flightSpeed
				end

				v3.PlatformStand = true
				v2.AssemblyLinearVelocity = vector
				v2.AssemblyAngularVelocity = Vector3.zero
			end
		end

		if v3 then
			v3.PlatformStand = false
		end
	end)
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then
		return
	end

	if input.KeyCode == (getgenv().config.flightKey or Enum.KeyCode.F) then
		tbl:toggleFlight(not getgenv().config.flightEnabled)
	end
end)

tbl.runAutoUpgrades = function()
	if fn9() <= (getgenv().config.keepMoney or 0) then
		return
	end
	local v2 = fn()
	if not v2 then
		return
	end

	if getgenv().config.autoUpgPen then
		local rfPlotAskUpgradePen = v2:FindFirstChild("RF/Plot/AskUpgradePen") or v2:FindFirstChild("RF/Plot/UpgradePen")

		if rfPlotAskUpgradePen then
			pcall(function()
				rfPlotAskUpgradePen:InvokeServer()
			end)
		end
	end

	if getgenv().config.autoUpgTreadmill then
		local rfTreadmillAskUpgrade = v2:FindFirstChild("RF/Treadmill/AskUpgrade") or v2:FindFirstChild("RF/Treadmill/Upgrade")

		if rfTreadmillAskUpgrade then
			pcall(function()
				rfTreadmillAskUpgrade:InvokeServer()
			end)
		end
	end

	if getgenv().config.autoUpgTrails then
		local rfTrailsAskBuy = v2:FindFirstChild("RF/Trails/AskBuy") or v2:FindFirstChild("RF/Trails/Upgrade")

		if rfTrailsAskBuy then
			pcall(function()
				rfTrailsAskBuy:InvokeServer()
			end)
		end
	end
end

task.spawn(function()
	while true do
		task.wait(5)

		if getgenv().config.autoUpgPen or getgenv().config.autoUpgTreadmill or getgenv().config.autoUpgTrails then
			tbl:runAutoUpgrades()
		end
	end
end)

tbl.runTreadmill = function()
	if not getgenv().config.autoTreadmill then
		return
	end

	if getgenv().config.autoFarm and not getgenv().config.trainWhenIdle then
		return
	end

	if flag2 then
		return
	end
	local v2 = fn5()
	if not v2 then
		return
	end
	local plots = Workspace:FindFirstChild("Plots")
	local v3 = nil

	if plots then
		v3 = nil

		for _, child in ipairs(plots:GetChildren()) do
			if child:FindFirstChild(v.Name, true) or (v2.Position - child:GetPivot().Position).Magnitude < 100 then
				for _, descendant in ipairs(child:GetDescendants()) do
					if descendant:IsA("BasePart") and (string.find(descendant.Name:lower(), "treadmill") or string.find(descendant.Name:lower(), "belt")) then
						v3 = descendant
						break
					end
				end
			end
		end
	end

	if v3 then
		v2.CFrame = v3.CFrame + Vector3.new(0, 3, 0)
		v2.AssemblyLinearVelocity = Vector3.zero
	end
end

task.spawn(function()
	while true do
		task.wait(2)

		if getgenv().config.autoTreadmill then
			tbl:runTreadmill()
		end
	end
end)

tbl.runClaimIndex = function()
	local v2 = fn()
	if not v2 then
		return
	end
	local rfIndexClaim = v2:FindFirstChild("RF/Index/Claim") or v2:FindFirstChild("RF/Index/AskClaim") or v2:FindFirstChild("RE/Index/ClaimAll")

	if rfIndexClaim then
		pcall(function()
			if rfIndexClaim:IsA("RemoteFunction") then
				rfIndexClaim:InvokeServer()
			else
				rfIndexClaim:FireServer()
			end
		end)
	end
end

task.spawn(function()
	while true do
		task.wait(15)

		if getgenv().config.autoClaimIndex then
			tbl:runClaimIndex()
		end
	end
end)

tbl.applyOptimizer = function(arg, arg2)
	local Lighting = game:GetService("Lighting")
	local terrain = Workspace:FindFirstChildOfClass("Terrain")

	if arg2 then
		Lighting.GlobalShadows = false
		Lighting.FogEnd = 9e9

		for _, descendant in ipairs(Lighting:GetDescendants()) do
			if descendant:IsA("PostEffect") then
				descendant.Enabled = false
			end
		end

		if terrain then
			terrain.WaterWaveSize = 0
			terrain.WaterWaveSpeed = 0
			terrain.WaterReflectance = 0
			terrain.WaterTransparency = 0
		end
	end
end

local function fn31(arg)
	local record = arg.record or arg
	if not record or not record.Uid or not record.BoundsCFrame then
		return false
	end
	local v2 = fn5()
	if not v2 then
		return false
	end
	local position = record.BoundsCFrame.Position
	local n3 = math.clamp(tonumber(getgenv().config.glideSpeed) or 750, 50, 750)
	fn23(position + Vector3.new(0, 1.2, 0), n3, true)

	if v2 then
		v2.CFrame = CFrame.new(position + Vector3.new(0, 1.2, 0))
		v2.AssemblyLinearVelocity = Vector3.zero
		v2.AssemblyAngularVelocity = Vector3.zero
	end

	task.wait(0.5)
	local str = nil

	if record.AreaId and record.NestId then
		if AreaEggSlotIdentity and AreaEggSlotIdentity.SlotKey then
			pcall(function()
				str = AreaEggSlotIdentity.SlotKey(record.AreaId, record.NestId)
			end)
		end

		str = str or tostring(record.AreaId) .. ":" .. tostring(record.NestId)
	end

	local v3 = fn()
	local rfEggWorldAskFieldEggCarry = v3 and v3:FindFirstChild("RF/EggWorld/AskFieldEggCarry")

	if rfEggWorldAskFieldEggCarry then
		pcall(function()
			rfEggWorldAskFieldEggCarry:InvokeServer(record.Uid, str)
		end)
	end

	local carryAreaEgg = nil

	pcall(function()
		local areaEggSlotsClient = Workspace:FindFirstChild("AreaEggSlotsClient")
		local v4 = areaEggSlotsClient and areaEggSlotsClient:FindFirstChild(record.Uid) or Workspace:FindFirstChild(record.Uid, true)

		if v4 then
			carryAreaEgg = v4:FindFirstChild("CarryAreaEgg", true) or v4:FindFirstChildWhichIsA("ProximityPrompt", true)
		end
	end)

	if carryAreaEgg then
		carryAreaEgg.HoldDuration = 0

		pcall(function()
			fireproximityprompt(carryAreaEgg, 0)
			fireproximityprompt(carryAreaEgg)
		end)
	end

	local v4 = fn8()
	flag2 = true
	local now = os.clock()
	local flag3

	while true do
		local autoFarm = os.clock() - now < 3 and getgenv().config.autoFarm
		flag3 = false

		if autoFarm then
			if fn17(record.Uid) then
				flag3 = true
				break
			else
				if rfEggWorldAskFieldEggCarry then
					pcall(function()
						rfEggWorldAskFieldEggCarry:InvokeServer(record.Uid, str)
					end)
				end

				if carryAreaEgg then
					carryAreaEgg.Enabled = true
					carryAreaEgg.HoldDuration = 0

					pcall(function()
						fireproximityprompt(carryAreaEgg)
					end)
				end

				task.wait(0.08)
				continue
			end
		end

		break
	end

	flag2 = false
	if not flag3 then
		tbl.ignoredEggs[record.Uid] = os.clock()
		return false
	end

	if not fn23(v4, n3, true, record.Uid) then
		return false
	end
	pcall(fn16)
	tbl:runAutoPlace()
	tbl.lastStealTime = os.clock()
	local stats = tbl.stats
	stats.stolen = stats.stolen + 1
	return true
end

pcall(function()
	if typeof(hookmetamethod) == "function" and not _G._DesyncAntiRagdollHooked then
		_G._DesyncAntiRagdollHooked = true
		local v2 = nil

		local function fn32(arg, arg2, arg3)
			if not checkcaller() and typeof(arg) == "Instance" then
				if arg:IsA("Motor6D") and arg2 == "Enabled" and arg3 == false then
					return nil
				end

				if arg:IsA("Humanoid") then
					if arg2 == "PlatformStand" and arg3 == true and not getgenv().config.flightEnabled then
						return nil
					end

					if arg2 == "Sit" and arg3 == true and getgenv().config.autoFarm then
						return nil
					end
				end
			end

			return v2(arg, arg2, arg3)
		end

		v2 = hookmetamethod
		v2 = v2(game, "__newindex", newcclosure(fn32))
	end
end)

local function fn32(arg)
	local forestStrike = tbl8.ForestStrike

	if forestStrike and arg then
		pcall(function()
			local cframe = fn5()
			cframe = cframe and cframe.CFrame * CFrame.new(0, 0, -3) or CFrame.new()

			if forestStrike:IsA("RemoteFunction") then
				forestStrike:InvokeServer({ EggUid = arg, GuardCFrame = cframe })
			else
				forestStrike:FireServer({ EggUid = arg, GuardCFrame = cframe })
			end
		end)
	end
end

local function fn33()
	local v2 = fn5()
	if not v2 then
		return nil
	end

	if not EggState then
		fn3()
	end

	local tbl9 = {}
	local readFieldEggs = EggState and EggState.ReadFieldEggs
	local records = nil

	if readFieldEggs then
		local ok, result = pcall(EggState.ReadFieldEggs)
		local records2 = ok and result and result.Records
		records = nil

		if records2 then
			records = result.Records
		end
	end

	if records then
		for _, record in ipairs(records) do
			local flag3 = record.State == "Slot" or record.State == "Dropped" or record.State == 1
			local flag4 = record.AreaId == "Lake"
			local flag5

			if flag4 then
				flag5 = flag4
			else
				flag5 = tostring(record.AreaId):lower():find("lake") ~= nil
			end

			if not flag5 then
				flag5 = tostring(record.Uid):lower():find("lake") ~= nil
			end

			flag5 = flag3 and flag5

			if flag5 and record.BoundsCFrame then
				local position = record.BoundsCFrame.Position

				table.insert(tbl9, {
					Uid = record.Uid,
					CFrame = record.BoundsCFrame,
					Position = position,
					Distance = (v2.Position - position).Magnitude,
					Area = "Lake",
				})
			end
		end
	end

	if #tbl9 == 0 and records then
		for _, record in ipairs(records) do
			local flag3 = record.State == "Slot" or record.State == "Dropped" or record.State == 1
			local position = record.BoundsCFrame and record.BoundsCFrame.Position

			if flag3 and position and position.X >= 545 and position.X < 850 then
				table.insert(tbl9, {
					Uid = record.Uid,
					CFrame = record.BoundsCFrame,
					Position = position,
					Distance = (v2.Position - position).Magnitude,
					Area = record.AreaId or "Field",
				})
			end
		end
	end

	if #tbl9 == 0 then
		return nil
	end

	table.sort(tbl9, function(arg, arg2)
		return arg.Distance < arg2.Distance
	end)

	local v3 = tbl9[1]
	local areaEggSlotsClient = Workspace:FindFirstChild("AreaEggSlotsClient")

	if areaEggSlotsClient and v3 then
		for _, child in ipairs(areaEggSlotsClient:GetChildren()) do
			local basePart = child:FindFirstChildWhichIsA("BasePart") or child.PrimaryPart
			if basePart and (basePart.Position - v3.Position).Magnitude <= 8 then
				v3.Model = child
				break
			end
		end
	end

	return v3
end

local function fn34(arg, arg2, arg3)
	local character = v.Character
	local v2 = fn5()
	local v3 = fn4()
	if not v2 or not v3 then
		return false
	end
	local position = arg2.Position
	createPart(position, 14)
	v2.AssemblyLinearVelocity = Vector3.zero
	v2.AssemblyAngularVelocity = Vector3.zero

	pcall(function()
		v:RequestStreamAroundAsync(position)
	end)

	if not arg3 and Workspace:FindFirstChild("AreaEggSlotsClient") then
		for _, child in ipairs(Workspace.AreaEggSlotsClient:GetChildren()) do
			local basePart = child:FindFirstChildWhichIsA("BasePart") or child.PrimaryPart
			if basePart and (basePart.Position - position).Magnitude <= 16 then
				arg3 = child
				break
			end
		end
	end

	local carryRemote = tbl8.CarryRemote
	local rfEggWorldAskFieldEggCarry

	if carryRemote then
		rfEggWorldAskFieldEggCarry = carryRemote
	else
		rfEggWorldAskFieldEggCarry = fn() and fn():FindFirstChild("RF/EggWorld/AskFieldEggCarry")
	end

	local forestStrike = tbl8.ForestStrike
	flag2 = true
	local n3 = os.clock() + 3.5

	while not fn17(arg) and os.clock() < n3 and getgenv().config.autoFarm do
		character:PivotTo(arg2 * CFrame.new(0, 0.4, 0))
		fn19(arg3, position)

		if arg and rfEggWorldAskFieldEggCarry then
			task.spawn(function()
				pcall(function()
					if rfEggWorldAskFieldEggCarry:IsA("RemoteFunction") then
						rfEggWorldAskFieldEggCarry:InvokeServer({ Uid = arg })
						rfEggWorldAskFieldEggCarry:InvokeServer(arg)
					else
						rfEggWorldAskFieldEggCarry:FireServer({ Uid = arg })
						rfEggWorldAskFieldEggCarry:FireServer(arg)
					end
				end)
			end)
		end

		RunService.Heartbeat:Wait()
	end

	if not fn17(arg) then
		flag2 = false

		if arg then
			tbl.ignoredEggs[arg] = os.clock()
		end

		return false
	end

	local n4 = os.clock() + 4.5
	local flag3 = false

	while fn17(arg) and os.clock() < n4 and getgenv().config.autoFarm do
		character:PivotTo(arg2 * CFrame.new(0, 0.4, 0))
		createPart(position, 14)

		if forestStrike and not flag3 then
			task.spawn(function()
				pcall(function()
					if forestStrike:IsA("RemoteFunction") then
						forestStrike:InvokeServer()
					else
						forestStrike:FireServer()
					end
				end)
			end)

			flag3 = true
		end

		RunService.Heartbeat:Wait()
	end

	local n5 = os.clock() + 3

	while not fn17(arg) and os.clock() < n5 and getgenv().config.autoFarm do
		character:PivotTo(arg2 * CFrame.new(0, 0.4, 0))
		fn19(arg3, position)

		if arg and rfEggWorldAskFieldEggCarry then
			task.spawn(function()
				pcall(function()
					if rfEggWorldAskFieldEggCarry:IsA("RemoteFunction") then
						rfEggWorldAskFieldEggCarry:InvokeServer({ Uid = arg })
						rfEggWorldAskFieldEggCarry:InvokeServer(arg)
					else
						rfEggWorldAskFieldEggCarry:FireServer({ Uid = arg })
						rfEggWorldAskFieldEggCarry:FireServer(arg)
					end
				end)
			end)
		end

		RunService.Heartbeat:Wait()
	end

	local v4 = fn18(arg)

	if not v4 then
		task.wait(0.12)
		v4 = fn18(arg)
	end

	flag2 = false

	if v4 then
		pcall(fn16)
	elseif arg then
		tbl.ignoredEggs[arg] = os.clock()
	end

	return v4
end

tbl.teleportStealEgg = function(arg, arg2)
	local record = arg2.record or arg2
	if not record or not record.BoundsCFrame then
		return false
	end
	local character = v.Character
	local v2 = fn5()
	local v3 = fn4()
	if not v2 or not v3 then
		return false
	end
	v3:UnequipTools()
	fn12(character)
	local boundsCFrame = record.BoundsCFrame
	local uid = record.Uid
	local position = boundsCFrame.Position
	local v4, v5 = fn15()

	if not v5 then
		local v6 = fn33()
		if not v6 then
			return false
		end
		local magnitude = (v2.Position - v6.Position).Magnitude
		local cFrame = v6.CFrame * CFrame.new(0, 0.4, 0)

		pcall(function()
			v:RequestStreamAroundAsync(v6.Position)
		end)

		createPart(v6.Position, 8)

		if magnitude > 60 then
			local v7 = fn23
			v7(v6.Position + Vector3.new(0, 1.2, 0), getgenv().config.glideSpeed or 750, true)
		else
			v2.CFrame = cFrame
			v2.AssemblyLinearVelocity = Vector3.zero
			task.wait(0.04)
		end

		v2.Anchored = true
		task.wait(0.06)
		v2.Anchored = false
		flag2 = true
		local carryRemote = tbl8.CarryRemote or fn() and fn():FindFirstChild("RF/EggWorld/AskFieldEggCarry")
		local n3 = os.clock() + 3

		while not fn17() and os.clock() < n3 and getgenv().config.autoFarm do
			fn19(v6.Model, v6.Position)

			if v6.Uid and carryRemote then
				task.spawn(function()
					pcall(function()
						if carryRemote:IsA("RemoteFunction") then
							carryRemote:InvokeServer({ Uid = v6.Uid })
						else
							carryRemote:FireServer({ Uid = v6.Uid })
						end
					end)
				end)
			end

			RunService.Heartbeat:Wait()
		end

		local v7
		v7, v5 = fn15()
		if not fn17() then
			flag2 = false
			return false
		end
	end

	pcall(function()
		v:RequestStreamAroundAsync(position)
	end)

	createPart(position, 12)
	v2.Anchored = false
	v3:ChangeState(Enum.HumanoidStateType.Running)
	local walkSpeed = v3.WalkSpeed > 0 and v3.WalkSpeed or 16
	v3.WalkSpeed = 0
	v3:Move(Vector3.zero, false)
	v2.AssemblyLinearVelocity = Vector3.zero
	v2.AssemblyAngularVelocity = Vector3.zero
	task.wait(0.04)
	local position2 = v2.Position
	local y = position2.Y
	local flag3 = false
	local connection = nil
	local speedTollOffer = tbl8.SpeedTollOffer

	if speedTollOffer and speedTollOffer:IsA("RemoteEvent") then
		connection = speedTollOffer.OnClientEvent:Connect(function()
			flag3 = true

			if connection then
				connection:Disconnect()
			end
		end)
	end

	flag2 = true
	fn32(v5)
	local now = os.clock()
	local n3 = os.clock() + 2.5
	local flag4 = false

	while true do
		if os.clock() < n3 and getgenv().config.autoFarm then
			local n4 = os.clock() - now
			local assemblyLinearVelocity = v2.AssemblyLinearVelocity
			local position3 = v2.Position
			local n5 = position3.Y - y
			local magnitude = (position3 - position2).Magnitude
			local flag5

			if n4 >= 0.08 then
				if flag3 or assemblyLinearVelocity.Y >= 10 or n5 >= 1.5 and assemblyLinearVelocity.Magnitude >= 16 or magnitude >= 2 or assemblyLinearVelocity.Magnitude >= 20 then
					flag3 = true
					break
				else
					flag5 = n4 >= 0.5 and not flag4

					if flag5 then
						fn32(v5)
						flag4 = true
					end

					RunService.Heartbeat:Wait()
					continue
				end
			else
				flag5 = n4 >= 0.5 and not flag4

				if flag5 then
					fn32(v5)
					flag4 = true
				end

				RunService.Heartbeat:Wait()
				continue
			end
		end

		break
	end

	if connection then
		connection:Disconnect()
	end

	v3.WalkSpeed = walkSpeed
	flag2 = false
	if not flag3 then
		pcall(fn16)
		return false
	end
	task.wait(0.05)
	createPart(position, 8)
	character:PivotTo(boundsCFrame * CFrame.new(0, 0.4, 0))
	v2.Anchored = true

	for _, descendant in ipairs(character:GetDescendants()) do
		if descendant:IsA("BasePart") then
			descendant.AssemblyLinearVelocity = Vector3.zero
			descendant.AssemblyAngularVelocity = Vector3.zero
		end
	end

	local backpack = v:FindFirstChild("Backpack")

	for _, child in ipairs(character:GetChildren()) do
		if child:IsA("Tool") then
			pcall(function()
				if backpack then
					child.Parent = backpack
				end
			end)
		end
	end

	task.wait(0.06)
	v2.Anchored = false
	v3:ChangeState(Enum.HumanoidStateType.Running)
	local v6 = fn34(uid, boundsCFrame, Workspace:FindFirstChild("AreaEggSlotsClient") and Workspace.AreaEggSlotsClient:FindFirstChild(uid))
	v2.Anchored = false
	v3:ChangeState(Enum.HumanoidStateType.Running)

	for _, descendant in ipairs(character:GetDescendants()) do
		if descendant:IsA("BasePart") then
			descendant.AssemblyLinearVelocity = Vector3.zero
			descendant.AssemblyAngularVelocity = Vector3.zero
		end
	end

	if not v6 then
		pcall(fn16)
		return false
	end
	pcall(fn16)
	if not fn24(getgenv().config.glideSpeed or 750, uid) then
		pcall(fn16)
		return false
	end
	pcall(fn16)

	if getgenv().config.autoPlaceEgg then
		tbl:runAutoPlace()
	end

	tbl.lastStealTime = os.clock()
	local stats = tbl.stats
	stats.stolen = stats.stolen + 1
	return true
end

tbl.initFarm = function()
	task.spawn(function()
		while true do
			if getgenv().config.autoFarm then
				local v2 = fn30()

				if #v2 > 0 then
					if getgenv().config.farmMode == "Teleport" then
						local ok, result = pcall(function()
							return tbl:teleportStealEgg(v2[1])
						end)

						if not ok or result == false then
							if v2[1] and v2[1].record and v2[1].record.Uid then
								tbl.ignoredEggs[v2[1].record.Uid] = os.clock()
							end
						end
					else
						pcall(fn31, v2[1])
					end
				end
			end

			task.wait(getgenv().config.stealDelay or 0.5)
		end
	end)
end

local function fn35(arg)
	if not arg then
		return "Unknown"
	end
	return tostring(arg):gsub("_", " "):gsub("^%l", string.upper)
end

local function fn36(arg)
	if not arg then
		return {}
	end

	if Assets and arg.AssetCategory then
		local ok, result = pcall(function()
			return (Assets.Directory or Assets)[arg.AssetCategory] or {}
		end)

		if ok and result and next(result) then
			return result
		end
	end

	return {
		EarningRate = arg.EarningRate,
		ModelWeight = arg.ModelWeight,
		DropWeight = arg.DropWeight,
		DisplayName = arg.AssetCategory,
		Rarity = arg.Rarity,
		_id = arg.AssetCategory,
	}
end

local function fn37(arg)
	if arg and arg.EarningRate then
		return tonumber(arg.EarningRate) or 0
	end
	return tonumber(fn36(arg).EarningRate) or 0
end

local function fn38(arg)
	if arg and arg.Rarity then
		if type(arg.Rarity) == "table" and arg.Rarity._id then
			return arg.Rarity._id
		end

		if type(arg.Rarity) == "string" then
			return arg.Rarity
		end
	end

	local v2 = fn36(arg)
	return v2.Rarity and v2.Rarity._id or "Common"
end

local function fn39(arg)
	if arg and arg.Rarity and type(arg.Rarity) == "table" then
		if typeof(arg.Rarity.Color) == "Color3" then
			return arg.Rarity.Color
		end
	end

	local v2 = fn36(arg)
	if v2.Rarity and typeof(v2.Rarity.Color) == "Color3" then
		return v2.Rarity.Color
	end

	if Rarity and Rarity.Rarities then
		local v3 = Rarity.Rarities[fn38(arg)]
		if v3 and typeof(v3.Color) == "Color3" then
			return v3.Color
		end
	end

	return Color3.fromRGB(200, 200, 200)
end

local tbl9 = {}
local tbl10 = {}
local tbl11 = {}
local v2 = nil

local function fn40(arg)
	if tbl9[arg] then
		pcall(function()
			tbl9[arg]:Destroy()
		end)

		tbl9[arg] = nil
	end

	if tbl10[arg] then
		pcall(function()
			tbl10[arg]:Destroy()
		end)

		tbl10[arg] = nil
	end
end

local function fn41()
	for k in pairs(tbl9) do
		fn40(k)
	end

	for k in pairs(tbl10) do
		fn40(k)
	end

	if v2 then
		pcall(function()
			v2:Destroy()
		end)

		v2 = nil
	end
end

local function fn42(adornee, arg, color3, arg2, arg3, arg4)
	if not tbl9[arg] or not tbl9[arg].Parent then
		local selectionBox = Instance.new("SelectionBox")
		selectionBox.Name = "SAE_Box"
		selectionBox.Adornee = adornee
		selectionBox.Color3 = color3
		selectionBox.LineThickness = 0.04
		selectionBox.SurfaceColor3 = color3
		selectionBox.SurfaceTransparency = 0.88
		selectionBox.Parent = adornee
		tbl9[arg] = selectionBox
	else
		tbl9[arg].Color3 = color3
		tbl9[arg].SurfaceColor3 = color3
		tbl9[arg].Adornee = adornee
	end

	local primaryPart = adornee.PrimaryPart or adornee:FindFirstChildWhichIsA("BasePart", true)
	if not primaryPart then
		return
	end
	local billboardGui = tbl10[arg]

	if not billboardGui or not billboardGui.Parent then
		billboardGui = Instance.new("BillboardGui")
		billboardGui.Name = "SAE_ESP"
		billboardGui.AlwaysOnTop = true
		billboardGui.Size = UDim2.new(0, 200, 0, 32)
		billboardGui.StudsOffset = Vector3.new(0, 2.6, 0)
		billboardGui.Adornee = primaryPart
		billboardGui.Parent = primaryPart
		local frame = Instance.new("Frame")
		frame.Name = "Container"
		frame.Size = UDim2.new(1, 0, 1, 0)
		frame.BackgroundTransparency = 1
		frame.BorderSizePixel = 0
		frame.Parent = billboardGui
		local uiListLayout = Instance.new("UIListLayout", frame)
		uiListLayout.FillDirection = Enum.FillDirection.Vertical
		uiListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
		uiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
		uiListLayout.Padding = UDim.new(0, 1)
		local textLabel = Instance.new("TextLabel", frame)
		textLabel.Name = "Title"
		textLabel.Size = UDim2.new(1, 0, 0, 14)
		textLabel.BackgroundTransparency = 1
		textLabel.Font = Enum.Font.GothamBold
		textLabel.TextSize = 12
		textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		textLabel.TextStrokeTransparency = 0.5
		textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
		textLabel.TextXAlignment = Enum.TextXAlignment.Center
		local textLabel2 = Instance.new("TextLabel", frame)
		textLabel2.Name = "Sub"
		textLabel2.Size = UDim2.new(1, 0, 0, 13)
		textLabel2.BackgroundTransparency = 1
		textLabel2.Font = Enum.Font.GothamMedium
		textLabel2.TextSize = 11
		textLabel2.RichText = true
		textLabel2.TextStrokeTransparency = 0.5
		textLabel2.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
		textLabel2.TextXAlignment = Enum.TextXAlignment.Center
		tbl10[arg] = billboardGui
	end

	local floor = math.floor
	local n3 = color3.B * 255
	local str = string.format("#%02X%02X%02X", math.floor(color3.R * 255), math.floor(color3.G * 255), floor(n3))
	local container = billboardGui:FindFirstChild("Container")

	if container then
		local title = container:FindFirstChild("Title")

		if title then
			title.Text = fn35(arg2)
		end

		local sub = container:FindFirstChild("Sub")

		if sub then
			sub.Text = string.format("<font color='%s'>[%s]</font> <font color='#65E87D'>+$%s/s</font>", str, arg3, fn6(arg4))
		end
	end
end

local function fn43()
	if not getgenv().config.plotEsp then
		for _, v3 in pairs(tbl11) do
			pcall(function()
				v3:Destroy()
			end)
		end

		tbl11 = {}
		return
	end

	if not EggState then
		fn3()
	end

	if not EggState or not PlotState then
		return
	end
	local resolvePlot = PlotState.ResolvePlot and PlotState.ResolvePlot()
	if not resolvePlot or not resolvePlot.PlotFolder then
		return
	end
	local readOwnerEggs = EggState.ReadOwnerEggs and EggState.ReadOwnerEggs(localPlayer.UserId)
	if type(readOwnerEggs) ~= "table" then
		return
	end

	for k, readOwnerEgg in pairs(readOwnerEggs) do
		if type(k) == "string" and readOwnerEgg.Placement then
			local v3 = resolvePlot.PlotFolder:FindFirstChild(k, true)
			local primaryPart

			if v3 then
				primaryPart = v3.PrimaryPart or v3:FindFirstChildWhichIsA("BasePart")
			else
				primaryPart = v3
			end

			if primaryPart then
				if not tbl11[k] then
					local billboardGui = Instance.new("BillboardGui", primaryPart)
					billboardGui.AlwaysOnTop = true
					billboardGui.Size = UDim2.new(0, 140, 0, 24)
					billboardGui.StudsOffset = Vector3.new(0, 2, 0)
					local textLabel = Instance.new("TextLabel", billboardGui)
					textLabel.Size = UDim2.new(1, 0, 1, 0)
					textLabel.BackgroundTransparency = 1
					textLabel.Font = Enum.Font.GothamBold
					textLabel.TextSize = 11
					textLabel.TextColor3 = Color3.fromRGB(120, 255, 120)
					textLabel.TextStrokeTransparency = 0.4
					tbl11[k] = billboardGui
				end

				local v4 = fn37(readOwnerEgg)
				local textLabel = tbl11[k]:FindFirstChildOfClass("TextLabel")

				if textLabel then
					textLabel.Text = string.format("Plot: +$%s/s", fn6(v4))
				end
			end
		end
	end
end

local function fn44()
	if not getgenv().config.espEnabled then
		fn41()
		return
	end

	if not EggState then
		fn3()
	end

	if not EggState then
		return
	end

	local ok, result = pcall(function()
		return EggState.ReadFieldEggs()
	end)

	if not ok or not result or not result.Records then
		return
	end
	local tbl12 = {}
	local minEspEarning = getgenv().config.minEspEarning or 0

	for _, record in ipairs(result.Records) do
		local uid = record.Uid

		if uid then
			local v3 = fn37(record)

			if not (v3 < minEspEarning) then
				tbl12[uid] = true
				local areaEggSlotsClient = Workspace:FindFirstChild("AreaEggSlotsClient", true) and Workspace.AreaEggSlotsClient:FindFirstChild(uid) or Workspace:FindFirstChild(uid, true)

				if areaEggSlotsClient then
					local v4 = fn36(record)
					pcall(fn42, areaEggSlotsClient, uid, fn39(record), v4.DisplayName or record.AssetCategory or uid, fn38(record), v3)
				end
			end
		end
	end

	for k in pairs(tbl9) do
		if not tbl12[k] then
			fn40(k)
		end
	end
end

task.spawn(function()
	while true do
		task.wait(1)
		pcall(fn44)
		pcall(fn43)
	end
end)

tbl.CreateSeed = function(arg)
	local ok, result = pcall(function()
		local format = ("%*:%*:%*").format
		local userId = arg.LocalPlayer.UserId
		local n3 = math.floor(arg.Workspace:GetServerTimeNow() * 1000)
		return format("%*:%*:%*", userId, 100, n3)
	end)

	return ok and result or nil
end

tbl.CanUseTool = function(arg)
	local ok, result = pcall(function()
		local character = arg.LocalPlayer.Character
		if not character then
			return false
		end
		local tool = character:FindFirstChildOfClass("Tool")
		if not tool or tool:GetAttribute("ItemType") ~= "Gear" then
			return false
		end
		local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
		if not humanoidRootPart then
			return false
		end

		if not arg.ToolGameplayGuard or not arg.ToolGameplayGuard.IsLocalInsideArena() then
			return false
		end

		if arg.Workspace:GetAttribute("Event_MonsterEvent") then
			return humanoidRootPart.Position.Z > -268
		end
		return true
	end)

	return ok and result or false
end

tbl.attack = function(arg, arg2)
	pcall(function()
		if not arg["RE/BatSwing/Trigger"] then
			return
		end
		return arg["RE/BatSwing/Trigger"]:FireServer(arg2, arg:CreateSeed())
	end)
end

tbl.GetClosetPlayer = function(arg)
	local attackDistance = getgenv().config.attackDistance or 16.5
	local v3 = next
	local players, v4 = arg.Players:GetPlayers()
	local huge = math.huge
	local v5 = nil

	for _, v6 in v3, players, v4 do
		if v6 ~= arg.LocalPlayer and v6.Character then
			local humanoidRootPart = v6.Character:FindFirstChild("HumanoidRootPart")

			if humanoidRootPart then
				local v7 = arg.LocalPlayer:DistanceFromCharacter(humanoidRootPart.Position)

				if v7 < huge and v7 <= attackDistance then
					huge = v7
					v5 = v6
				end
			end
		end
	end

	return v5
end

local obj = setmetatable({}, { __mode = "k" })

local tbl12 = {
	forest = 450,
	lake = 700,
	desert = 1100,
	jungle = 1500,
	snow = 1900,
	volcano = 2300,
	["abyss ocean"] = 2800,
	prehistoric = 3300,
	cosmic = 3800,
	["cherry blossom"] = 4300,
	["titan temple"] = 4800,
	["light dark"] = 5300,
	["dragon event"] = 5800,
}

local function fn45(arg)
	if not arg then
		return nil
	end
	local str = arg:lower()

	if not EggState then
		fn3()
	end

	if EggState and EggState.ReadFieldEggs then
		local ok, result = pcall(EggState.ReadFieldEggs)

		if ok and result and result.Records then
			for _, record in ipairs(result.Records) do
				local areaId = record.AreaId

				if areaId then
					areaId = tostring(record.AreaId):lower()
				end

				if areaId and areaId:find(str) and record.BoundsCFrame then
					return record.BoundsCFrame.Position
				end
			end
		end
	end

	local areaEggSlotsClient = Workspace:FindFirstChild("AreaEggSlotsClient")

	if areaEggSlotsClient then
		for _, child in ipairs(areaEggSlotsClient:GetChildren()) do
			if child.Name:lower():find(str) then
				local basePart = child:FindFirstChildWhichIsA("BasePart") or child.PrimaryPart
				if basePart then
					return basePart.Position
				end
			end
		end
	end

	local areas = Workspace:FindFirstChild("Areas") or Workspace:FindFirstChild("Map")

	if areas then
		local v3 = areas:FindFirstChild(arg, true)

		if v3 then
			local basePart = v3:FindFirstChildWhichIsA("BasePart") or v3.PrimaryPart
			if basePart then
				return basePart.Position
			end
		end
	end

	for k, v3 in pairs(tbl12) do
		if str:find(k) then
			return Vector3.new(v3, 75, n)
		end
	end

	return nil
end

local function fn46()
	if not EggState then
		fn3()
	end

	if EggState and EggState.ReadFieldEggs then
		local ok, result = pcall(EggState.ReadFieldEggs)

		if ok and result and result.Records then
			local x = nil
			local x2 = nil

			for _, record in ipairs(result.Records) do
				local areaId = record.AreaId

				if areaId then
					areaId = tostring(record.AreaId):lower()
				end

				if areaId and record.BoundsCFrame then
					if areaId:find("abyss") then
						if not x or record.BoundsCFrame.Position.X < x then
							x = record.BoundsCFrame.Position.X
						end
					elseif areaId:find("volcano") then
						if not x2 or record.BoundsCFrame.Position.X > x2 then
							x2 = record.BoundsCFrame.Position.X
						end
					end
				end
			end

			if x then
				return x - 120
			end

			if x2 then
				return x2 + 60
			end
		end
	end

	local areaEggSlotsClient = Workspace:FindFirstChild("AreaEggSlotsClient")

	if areaEggSlotsClient then
		for _, child in ipairs(areaEggSlotsClient:GetChildren()) do
			if child.Name:lower():find("abyss") then
				local basePart = child:FindFirstChildWhichIsA("BasePart") or child.PrimaryPart
				if basePart then
					return basePart.Position.X - 120
				end
			end
		end
	end

	return 2600
end

local function fn47(arg)
	if not arg or not arg.Parent or not arg:IsDescendantOf(Workspace) then
		return false
	end

	if obj[arg] then
		return false
	end
	local attribute = arg:GetAttribute("State") or arg:GetAttribute("DroneState") or arg:GetAttribute("Status")

	if attribute then
		local str = tostring(attribute):lower()
		if str:find("dead") or str:find("death") or str:find("dying") or str:find("destroy") or str:find("kill") or str:find("despawn") or str:find("ragdoll") then
			obj[arg] = true
			return false
		end
	end

	for _, v3 in ipairs({ "Dead", "IsDead", "Dying", "IsDying", "Killed", "Destroyed" }) do
		if arg:GetAttribute(v3) == true then
			obj[arg] = true
			return false
		end
	end

	if arg:GetAttribute("Alive") == false or arg:GetAttribute("CanHit") == false then
		obj[arg] = true
		return false
	end

	for _, v3 in ipairs({ "Health", "HP", "CurrentHealth", "HitsLeft", "RemainingHits" }) do
		local attribute2 = arg:GetAttribute(v3)
		if attribute2 and tonumber(attribute2) and tonumber(attribute2) <= 0 then
			obj[arg] = true
			return false
		end
	end

	for _, v3 in ipairs({ "Health", "CurrentHealth", "HP", "HitsLeft" }) do
		local v4 = arg:FindFirstChild(v3)
		local isNumberValue

		if v4 then
			isNumberValue = v4:IsA("NumberValue") or v4:IsA("IntValue")
		else
			isNumberValue = v4
		end

		isNumberValue = isNumberValue and v4.Value <= 0
		if isNumberValue then
			obj[arg] = true
			return false
		end
	end

	local humanoid = arg:FindFirstChildOfClass("Humanoid")

	if humanoid then
		if humanoid.Health <= 0 and humanoid.MaxHealth > 0 then
			obj[arg] = true
			return false
		end

		if humanoid:GetState() == Enum.HumanoidStateType.Dead then
			obj[arg] = true
			return false
		end
	end

	for _, descendant in ipairs(arg:GetDescendants()) do
		if descendant:IsA("TextLabel") then
			local str = descendant.Text:lower():gsub("%s+", "")
			if str:find("^0/") or str == "0hp" or str == "0" or str:find("dead") then
				obj[arg] = true
				return false
			end
		end
	end

	return true
end

local function fn48(arg)
	if not arg then
		return nil
	end

	for _, v3 in ipairs({ "MaxHealth", "MaxHP", "TotalHealth", "TierHealth" }) do
		local attribute = arg:GetAttribute(v3)
		if attribute and tonumber(attribute) and tonumber(attribute) > 0 then
			return tonumber(attribute)
		end
	end

	local attribute = arg:GetAttribute("Tier") or arg:GetAttribute("DroneTier") or arg:GetAttribute("Type")

	if attribute and type(attribute) == "string" then
		local str = attribute:lower()
		if str:find("light") or str:find("3") then
			return 3
		end

		if str:find("standard") or str:find("medium") or str:find("5") then
			return 5
		end

		if str:find("heavy") or str:find("10") then
			return 10
		end
	end

	local str = arg.Name:lower()
	if str:find("light") or str:find("3hp") or str:find("3_hp") then
		return 3
	end

	if str:find("standard") or str:find("5hp") or str:find("5_hp") then
		return 5
	end

	if str:find("heavy") or str:find("10hp") or str:find("10_hp") then
		return 10
	end

	for _, descendant in ipairs(arg:GetDescendants()) do
		if descendant:IsA("TextLabel") then
			local str2 = descendant.Text:lower()
			if str2:find("light") then
				return 3
			end

			if str2:find("standard") then
				return 5
			end

			if str2:find("heavy") then
				return 10
			end
			local match = str2:match("%d+/(%d+)") or str2:match("(%d+)%s*hp")
			if match and tonumber(match) then
				return tonumber(match)
			end
		end
	end

	local humanoid = arg:FindFirstChildOfClass("Humanoid")
	if humanoid and humanoid.MaxHealth > 0 then
		return math.floor(humanoid.MaxHealth)
	end

	for _, v3 in ipairs({ "Health", "HP", "CurrentHealth", "HitsLeft" }) do
		local attribute2 = arg:GetAttribute(v3)

		if attribute2 and tonumber(attribute2) and tonumber(attribute2) > 0 then
			local num = tonumber(attribute2)
			if num <= 3 then
				return 3
			end

			if num <= 5 then
				return 5
			end
			return 10
		end
	end

	return nil
end

local function fn49(arg)
	if not arg then
		return nil
	end

	if arg:IsA("Model") then
		if arg.PrimaryPart then
			return arg.PrimaryPart.CFrame
		end
		local basePart = arg:FindFirstChildWhichIsA("BasePart")
		if basePart then
			return basePart.CFrame
		end

		local ok, result = pcall(function()
			return arg:GetPivot()
		end)

		if ok and result and result.Position ~= Vector3.zero then
			return result
		end
	elseif arg:IsA("BasePart") then
		return arg.CFrame
	end

	return nil
end

local function fn50()
	local character = v.Character
	if not character then
		return nil
	end

	for _, child in ipairs(character:GetChildren()) do
		local isTool = child:IsA("Tool")

		if isTool then
			isTool = child.Name:lower():find("bat") or child.Name:lower():find("scrambler") or child:GetAttribute("ItemType") == "Gear"
		end

		if isTool then
			return child
		end
	end

	local backpack = v:FindFirstChild("Backpack")

	if backpack then
		for _, child in ipairs(backpack:GetChildren()) do
			if child:IsA("Tool") and (child.Name:lower():find("bat") or child.Name:lower():find("scrambler") or child:GetAttribute("ItemType") == "Gear") then
				child.Parent = character
				return child
			end
		end
	end

	return nil
end

local function fn51()
	local v3 = fn5()
	if not v3 then
		return nil
	end
	local v4 = fn46()
	local lightDark = fn45("Light Dark")
	lightDark = lightDark and lightDark.X + 450 or 5800
	if v3.Position.X < v4 - 100 then
		return nil
	end
	local droneSelectedHp = getgenv().config.droneSelectedHp
	local tbl13 = {}
	local tbl14 = {}

	local function fn52(arg)
		if not arg or tbl14[arg] then
			return
		end
		tbl14[arg] = true

		for _, child in ipairs(arg:GetChildren()) do
			table.insert(tbl13, child)
		end
	end

	fn52(Workspace:FindFirstChild("ScrambleLocalVisuals"))
	fn52(Workspace:FindFirstChild("Drones"))
	fn52(Workspace:FindFirstChild("Monsters"))
	fn52(Workspace:FindFirstChild("__DEBRIS"))
	fn52(Workspace:FindFirstChild("Mobs"))
	fn52(Workspace:FindFirstChild("Entities"))

	for _, child in ipairs(Workspace:GetChildren()) do
		if child:IsA("Folder") or child:IsA("Model") then
			local str = child.Name:lower()

			if str:find("drone") or str:find("scramble") or str:find("monster") or str:find("visual") then
				fn52(child)
			end
		end

		table.insert(tbl13, child)
	end

	local tbl15 = {}
	local huge = math.huge
	local v5 = nil

	for _, v6 in ipairs(tbl13) do
		if not tbl15[v6] and v6:IsA("Instance") then
			tbl15[v6] = true
			local str = v6.Name:lower()

			if (v6:GetAttribute("DroneMotion") ~= nil or str:find("drone") ~= nil or str:find("personaldrone") ~= nil or str:find("dronevisual") ~= nil) and fn47(v6) then
				local v7 = fn48(v6)
				local n3 = 0

				if type(droneSelectedHp) == "table" then
					for _, v8 in pairs(droneSelectedHp) do
						if v8 then
							n3 += 1
						end
					end
				end

				if n3 == 0 then
					local v8 = fn49(v6)

					if v8 then
						local position = v8.Position

						if position.X >= v4 and position.X <= lightDark then
							local magnitude = (v3.Position - position).Magnitude

							if magnitude < huge then
								huge = magnitude
								v5 = v6
							end
						end
					end
				elseif v7 then
					if droneSelectedHp[tostring(v7) .. " HP"] == true then
						local v8 = fn49(v6)

						if v8 then
							local position = v8.Position

							if position.X >= v4 and position.X <= lightDark then
								local magnitude = (v3.Position - position).Magnitude

								if magnitude < huge then
									huge = magnitude
									v5 = v6
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

tbl.initDroneFarm = function()
	task.spawn(function()
		local v3 = nil
		local tbl13 = { "Abyss Ocean", "Prehistoric", "Cosmic", "Cherry Blossom", "Titan Temple", "Light Dark" }
		local n3 = 0
		local n4 = 0
		local n5 = 1

		while true do
			local result = RunService.Heartbeat:Wait()

			if getgenv().config.droneFarm then
				local character = v.Character
				local v4 = fn5()
				local v5 = fn4()

				if character and v4 and v5 and v5.Health > 0 then
					local v6 = fn51()

					if v6 and not fn47(v6) then
						obj[v6] = true
						v6 = nil
					end

					if v6 then
						n3 = os.clock()
						local v7 = fn49(v6)

						if v7 then
							fn50()
							local position = v7.Position
							local n6 = position + Vector3.new(0, 1.5, getgenv().config.droneDistance or 4.5)
							local position2 = v4.Position
							local n7 = n6 - position2
							local magnitude = n7.Magnitude
							v5.PlatformStand = true

							if not v3 or not v3.Parent then
								v3 = createPart
								v3 = v3(position2, 10)
							else
								v3.Position = position2 - Vector3.new(0, 3.2, 0)
							end

							if magnitude > 6 then
								v4.CFrame = CFrame.lookAt(position2 + n7.Unit * math.min((getgenv().config.droneGlideSpeed or 650) * result, magnitude), position)
								v4.AssemblyLinearVelocity = Vector3.zero
								v4.AssemblyAngularVelocity = Vector3.zero
							else
								v4.CFrame = CFrame.lookAt(n6, position)
								v4.AssemblyLinearVelocity = Vector3.zero
								v4.AssemblyAngularVelocity = Vector3.zero

								if (getgenv().config.droneAttackCooldown or 0.1) <= os.clock() - n4 then
									n4 = os.clock()

									pcall(function()
										if tbl["RE/BatSwing/Trigger"] then
											tbl["RE/BatSwing/Trigger"]:FireServer(v6, tbl:CreateSeed())
										end

										local tool = character:FindFirstChildOfClass("Tool")

										if tool then
											tool:Activate()
										end
									end)

									if not fn47(v6) then
										obj[v6] = true
									end
								end
							end
						end
					else
						v5.PlatformStand = true

						if not v3 or not v3.Parent then
							v3 = createPart
							v3 = v3(v4.Position, 10)
						else
							v3.Position = v4.Position - Vector3.new(0, 3.2, 0)
						end

						local position = v4.Position
						local v7 = fn46()

						if position.X < v7 then
							local abyssOcean = fn45("Abyss Ocean") or Vector3.new(v7 + 150, 75, n)
							local droneGlideSpeed = getgenv().config.droneGlideSpeed or 650
							local vector = Vector3.new(abyssOcean.X, math.max(abyssOcean.Y + 8, 75), n)
							local n6 = vector - position
							local magnitude = n6.Magnitude

							pcall(function()
								v:RequestStreamAroundAsync(vector)
							end)

							if magnitude > 5 then
								local n7 = position + n6.Unit * math.min(droneGlideSpeed * result, magnitude)
								v4.CFrame = CFrame.lookAt(n7, n7 + n6.Unit)
							end

							v4.AssemblyLinearVelocity = Vector3.zero
							v4.AssemblyAngularVelocity = Vector3.zero
						elseif os.clock() - n3 < 0.3 then
							v4.AssemblyLinearVelocity = Vector3.zero
							v4.AssemblyAngularVelocity = Vector3.zero
						else
							local v8 = fn45(tbl13[n5] or "Abyss Ocean")

							if v8 and (position - v8).Magnitude < 65 then
								n5 = n5 % #tbl13 + 1
								v8 = fn45(tbl13[n5])
							end

							if v8 then
								local droneGlideSpeed = getgenv().config.droneGlideSpeed or 650
								local vector = Vector3.new(v8.X, math.max(v8.Y + 8, 75), n)
								local n6 = vector - position
								local magnitude = n6.Magnitude

								if math.random(1, 20) == 1 then
									pcall(function()
										v:RequestStreamAroundAsync(vector)
									end)
								end

								if magnitude > 5 then
									local n7 = position + n6.Unit * math.min(droneGlideSpeed * result, magnitude)
									v4.CFrame = CFrame.lookAt(n7, n7 + n6.Unit)
								end

								v4.AssemblyLinearVelocity = Vector3.zero
								v4.AssemblyAngularVelocity = Vector3.zero
							end
						end
					end
				end
			else
				local v4 = fn4()

				if v4 and v4.PlatformStand and not getgenv().config.flightEnabled then
					v4.PlatformStand = false
				end

				if v3 then
					pcall(function()
						v3:Destroy()
					end)

					v3 = nil
				end
			end
		end
	end)
end

tbl.initCombat = function(arg)
	if not arg.LocalPlayer then
		return
	end
	arg.Packages = arg.ReplicatedStorage:FindFirstChild("Packages")
	arg.Networking = arg.Packages and arg.Packages:FindFirstChild("Networking")
	arg["RE/BatSwing/Trigger"] = arg.Networking and arg.Networking:FindFirstChild("RE/BatSwing/Trigger")
	arg.Client = arg.ReplicatedStorage:FindFirstChild("Client")
	local toolGameplayGuard = arg.Client and arg.Client:FindFirstChild("ToolGameplayGuard")

	if toolGameplayGuard then
		arg.ToolGameplayGuard = require(toolGameplayGuard)
	end

	arg.lastAttack = tick()

	arg.combatConn = arg.RunService.Heartbeat:Connect(function()
		if not getgenv().config.killAura then
			return
		end
		arg.Target = arg:GetClosetPlayer()

		if arg.Target then
			local attackCooldown = getgenv().config.attackCooldown or 0.1
			local lastAttack = arg.lastAttack

			if tick() - lastAttack >= attackCooldown and arg:CanUseTool() then
				arg:attack(arg.Target)
				arg.lastAttack = tick()
			end
		end
	end)
end

tbl.collectgarbage = function()
	local ok, result = pcall(function()
		return getgc()
	end)

	return ok and result or nil
end

tbl.safehook = function(arg, arg2)
	local ok, result = pcall(function()
		return hookfunction(arg, newlclosure(arg2))
	end)

	return ok and result or nil
end

tbl.findfunction = function(arg, arg2, arg3)
	local ok, result = pcall(function()
		local v3 = next
		local v4, v5 = arg.collectgarbage()

		for _, v6 in v3, v4, v5 do
			if typeof(v6) == "function" and islclosure(v6) then
				local v7 = debug.info(v6, "l")
				local v8 = debug.info(v6, "s")

				if v7 == arg3 or v8 and v8:find("ContentCatalog") then
					local v9 = debug.getupvalues(v6)
					if v9 and #v9 == arg2 and typeof(v9[2]) == "function" then
						return v6
					end
				end
			end
		end

		return nil
	end)

	return ok and result or nil
end

tbl.initbypass = function(arg)
	if not arg.LocalPlayer then
		return
	end
	local v3 = arg:findfunction(19, 634)
	if not v3 then
		return
	end
	local v4 = debug.getupvalue(v3, 2)
	if not v4 or typeof(v4) ~= "function" then
		return
	end
	local v5 = nil

	v5 = arg.safehook(v4, function(arg2, arg3)
		if arg3 and typeof(arg3) == "table" then
			setmetatable(arg3, {})
		end

		return v5(arg2, arg3)
	end)

	if arg.speedconn then
		arg.speedconn:Disconnect()
		arg.speedconn = nil
	end

	arg.speedconn = arg.RunService.Heartbeat:Connect(function()
		if not getgenv().config.speedEnabled then
			return
		end
		local character = arg.LocalPlayer.Character
		character = character and character:FindFirstChildOfClass("Humanoid")

		if character then
			character.WalkSpeed = getgenv().config.walkSpeed
		end
	end)
end

tbl.runAutoHatch = function()
	if not EggState then
		fn3()
	end

	if not EggState then
		return
	end

	pcall(function()
		local v3 = fn()
		if not v3 then
			return
		end
		local rfEggWorldAskHatch = v3:FindFirstChild("RF/EggWorld/AskHatch")
		local rfEggWorldAskFinishHatch = v3:FindFirstChild("RF/EggWorld/AskFinishHatch")
		if not rfEggWorldAskHatch and not rfEggWorldAskFinishHatch then
			return
		end
		local v4 = EggState.ReadOwnerEggs(localPlayer.UserId)
		if type(v4) ~= "table" then
			return
		end

		for k in pairs(v4) do
			if getgenv().config.autoHatch then
				if type(k) == "string" then
					if rfEggWorldAskHatch then
						pcall(function()
							rfEggWorldAskHatch:InvokeServer(k)
						end)

						task.wait(0.05)
					end

					if rfEggWorldAskFinishHatch then
						pcall(function()
							rfEggWorldAskFinishHatch:InvokeServer(k)
							local stats = tbl.stats
							stats.hatched = stats.hatched + 1
						end)

						task.wait(0.05)
					end
				end

				continue
			end

			break
		end
	end)
end

task.spawn(function()
	while true do
		task.wait(getgenv().config.hatchInterval or 3)

		if getgenv().config.autoHatch then
			tbl:runAutoHatch()
		end
	end
end)

tbl.runCollectMoney = function()
	pcall(function()
		local rfAwayEarningsAskCollect = fn()
		rfAwayEarningsAskCollect = rfAwayEarningsAskCollect and rfAwayEarningsAskCollect:FindFirstChild("RF/AwayEarnings/AskCollect")

		if rfAwayEarningsAskCollect then
			rfAwayEarningsAskCollect:InvokeServer({ Kind = "Claim" })
		end
	end)
end

task.spawn(function()
	while true do
		task.wait(getgenv().config.collectInterval or 60)

		if getgenv().config.autoCollect then
			tbl:runCollectMoney()
		end
	end
end)

tbl.runEquipBest = function()
	pcall(function()
		local v3 = fn()
		local rfPetSatchelEquipBest = v3 and (v3:FindFirstChild("RF/PetSatchel/EquipBest") or v3:FindFirstChild("RE/PetSatchel/EquipBest"))

		if rfPetSatchelEquipBest then
			if rfPetSatchelEquipBest:IsA("RemoteFunction") then
				rfPetSatchelEquipBest:InvokeServer()
			else
				rfPetSatchelEquipBest:FireServer()
			end
		end
	end)
end

tbl.runAutoPlace = function()
	if not PlotState then
		fn3()
	end

	if not PlotState then
		return
	end

	pcall(function()
		local v3 = PlotState.ResolvePlot()
		if not v3 or not v3.CenterPoint or not v3.PetArea then
			return
		end
		local v4 = fn()
		local rfEggWorldAskPlaceEgg = v4 and v4:FindFirstChild("RF/EggWorld/AskPlaceEgg")
		local rfEggWorldAskWearTool = v4 and v4:FindFirstChild("RF/EggWorld/AskWearTool")
		if not rfEggWorldAskPlaceEgg then
			return
		end
		local petArea = v3.PetArea
		local cFrame = v3.CenterPoint.CFrame
		local size = petArea.Size
		local position = petArea.Position

		local function fn52()
			local n3 = size.X * 0.4
			local n4 = size.Z * 0.4
			local v5 = cFrame:PointToObjectSpace(position + Vector3.new((math.random() * 2 - 1) * n3, 0, (math.random() * 2 - 1) * n4))
			return CFrame.new(v5)
		end

		pcall(function()
			EggState.SyncOwnedEggs()
		end)

		task.wait(0.2)

		local ok, result = pcall(function()
			return EggState.ReadOwnerEggs(localPlayer.UserId)
		end)

		if not ok or type(result) ~= "table" or not next(result) then
			return
		end
		local n3 = tbl4[getgenv().config.neverPlaceRarity] or 999
		local placeMinGen = getgenv().config.placeMinGen or 0
		local n4 = 0

		for k, v5 in pairs(result) do
			if not (n4 >= 10) then
				local flag3 = type(k) == "string" and k
				local uid

				if flag3 then
					uid = flag3
				else
					uid = type(v5) == "table" and v5.Uid
				end

				if not (not uid or type(k) ~= "string" or v5.Placement ~= nil) then
					if not (n3 <= (tbl4[fn38(v5)] or 1)) then
						if not (placeMinGen > 0 and fn37(v5) < placeMinGen) then
							local v6 = nil
							local character = localPlayer.Character

							if character then
								for _, child in ipairs(character:GetChildren()) do
									if fn14(child) then
										v6 = child
										break
									end
								end
							end

							if not v6 and localPlayer:FindFirstChild("Backpack") then
								for _, child in ipairs(localPlayer.Backpack:GetChildren()) do
									if fn14(child) then
										v6 = child

										pcall(function()
											v6.Parent = localPlayer.Character
										end)

										task.wait(0.15)
										break
									end
								end
							end

							if not v6 and rfEggWorldAskWearTool then
								pcall(function()
									rfEggWorldAskWearTool:InvokeServer(uid)
								end)

								task.wait(0.2)
							end

							local v7 = fn52()

							local ok2, result2 = pcall(function()
								return rfEggWorldAskPlaceEgg:InvokeServer({ Uid = uid, LocalCFrame = v7 })
							end)

							if ok2 and result2 == true then
								n4 += 1
							end

							task.wait(0.1)
						end
					end
				end

				continue
			end

			break
		end
	end)
end

task.spawn(function()
	while true do
		task.wait(getgenv().config.placeInterval or 5)

		if getgenv().config.autoPlaceEgg then
			tbl:runAutoPlace()
		end
	end
end)

tbl.runAutoSellPet = function()
	pcall(function()
		local v3 = fn()
		if not v3 then
			return
		end

		if getgenv().config.sellAllPets then
			local rePetSatchelSellEveryPet = v3:FindFirstChild("RE/PetSatchel/SellEveryPet")

			if rePetSatchelSellEveryPet then
				rePetSatchelSellEveryPet:FireServer()
			end

			return
		end

		local rePetSatchelSellPet = v3:FindFirstChild("RE/PetSatchel/SellPet")
		local rfEggWorldAskWearTool = v3:FindFirstChild("RF/EggWorld/AskWearTool")
		if not rePetSatchelSellPet then
			return
		end

		for _, child in ipairs(localPlayer.Backpack:GetChildren()) do
			if not (not getgenv().config.autoSellPet or not child:IsA("Tool")) then
				local attribute = child:GetAttribute("ItemType")

				if not (attribute ~= "Asset" and attribute ~= "Phone") then
					local v4 = tbl6[child.Name]

					if not (not v4 or getgenv().config.sellPetRarities and next(getgenv().config.sellPetRarities) and not getgenv().config.sellPetRarities[v4]) then
						if not (child:GetAttribute("IsFavorited") or child:GetAttribute("Favorited")) then
							local attribute2 = child:GetAttribute("EarningRate") or 0

							if not (getgenv().config.sellUnderGen > 0 and attribute2 >= getgenv().config.sellUnderGen) then
								local attribute3 = child:GetAttribute("Uid") or child:GetAttribute("uid")

								if attribute3 then
									if rfEggWorldAskWearTool then
										pcall(function()
											rfEggWorldAskWearTool:InvokeServer(attribute3)
										end)

										task.wait(0.15)
									end

									pcall(function()
										rePetSatchelSellPet:FireServer({ attribute3 })
									end)

									local stats = tbl.stats
									stats.sold = stats.sold + 1
									task.wait(0.1)
								end
							end
						end
					end
				end
			end
		end
	end)
end

task.spawn(function()
	while true do
		task.wait(getgenv().config.sellPetInterval or 5)

		if getgenv().config.autoSellPet then
			tbl:runAutoSellPet()
		end
	end
end)

tbl.runAutoSellEgg = function()
	if not EggState then
		fn3()
	end

	if not EggState then
		return
	end

	pcall(function()
		local v3 = fn()
		local rePetSatchelSellPet = v3 and v3:FindFirstChild("RE/PetSatchel/SellPet")
		local rfEggWorldAskWearTool = v3 and v3:FindFirstChild("RF/EggWorld/AskWearTool")
		if not rePetSatchelSellPet then
			return
		end
		local v4 = EggState.ReadOwnerEggs(localPlayer.UserId)
		if type(v4) ~= "table" then
			return
		end

		for k, v5 in pairs(v4) do
			if not (not getgenv().config.autoSellEgg or type(k) ~= "string" or v5.Placement ~= nil) then
				local v6 = fn38(v5)

				if (tbl4[v6] or 0) ~= 0 then
					if not (getgenv().config.sellEggRarities and next(getgenv().config.sellEggRarities) and not getgenv().config.sellEggRarities[v6]) then
						local v7 = fn37(v5)

						if not (getgenv().config.sellUnderGen > 0 and v7 >= getgenv().config.sellUnderGen) then
							if rfEggWorldAskWearTool then
								pcall(function()
									rfEggWorldAskWearTool:InvokeServer(k)
								end)

								task.wait(0.15)
							end

							pcall(function()
								rePetSatchelSellPet:FireServer({ k })
							end)

							local stats = tbl.stats
							stats.sold = stats.sold + 1
							task.wait(0.1)
						end
					end
				end
			end
		end
	end)
end

task.spawn(function()
	while true do
		task.wait(getgenv().config.sellEggInterval or 5)

		if getgenv().config.autoSellEgg then
			tbl:runAutoSellEgg()
		end
	end
end)

tbl:initFarm()
tbl:initbypass()
tbl:initCombat()
tbl:initAntiRagdoll()
tbl:initDroneFarm()

local v3 = lib:CreateWindow({
	Title = "HollyScriptX",
	Footer = "discord.gg/hollyscriptx-1504482964661076098",
	Icon = getcustomasset("Holy.png"),
	NotifySide = "Right",
	ShowCustomCursor = true,
	Compact = true,
	Size = UDim2.fromOffset(620, 520),
	CornerRadius = 8,
})

local tbl13 = {
	Main = v3:AddTab("Main", "gamepad"),
	Combat = v3:AddTab("Combat", "swords"),
	Visual = v3:AddTab("Visual", "eye"),
	Misc = v3:AddTab("Misc", "user"),
	Settings = v3:AddTab("Settings", "settings"),
}

local v4 = tbl13.Main:AddLeftGroupbox("Auto Farm")
local v5 = tbl13.Main:AddRightGroupbox("Drone Auto Farm")
local v6 = tbl13.Main:AddLeftGroupbox("Auto Lay Eggs")
local v7 = tbl13.Main:AddLeftGroupbox("Hatch & Collect")
local v8 = tbl13.Main:AddLeftGroupbox("Base Upgrades")
local v9 = tbl13.Main:AddRightGroupbox("Auto Sell Pet")
local v10 = tbl13.Main:AddRightGroupbox("Auto Sell Egg")
local Treadmill = tbl13.Main:AddRightGroupbox("Treadmill")

v4:AddToggle("AutoFarmToggle", {
	Text = "Auto Steal Eggs",
	Default = false,
	Tooltip = "Autofarm",
	Callback = function(autoFarm)
		getgenv().config.autoFarm = autoFarm
	end,
})

v4:AddDropdown("FarmModeDropdown", {
	Values = { "Teleport", "Glide" },
	Default = "Teleport",
	Multi = false,
	Text = "Farm Mode",
	Callback = function(farmMode)
		getgenv().config.farmMode = farmMode
	end,
})

v4:AddSlider("GlideSpeedSlider", {
	Text = "Return Speed",
	Default = 750,
	Min = 50,
	Max = 750,
	Rounding = 0,
	Compact = false,
	Callback = function(glideSpeed)
		getgenv().config.glideSpeed = glideSpeed
	end,
})

v4:AddSlider("StealDelaySlider", {
	Text = "Steal Delay (s)",
	Default = 1,
	Min = 0.5,
	Max = 10,
	Rounding = 1,
	Compact = false,
	Callback = function(stealDelay)
		getgenv().config.stealDelay = stealDelay
	end,
})

v4:AddDropdown("StealRaritiesDropdown", {
	Values = tbl3,
	Default = {},
	Multi = true,
	Text = "Target Rarities (Empty = All)",
	Callback = function(selectedStealRarities)
		getgenv().config.selectedStealRarities = selectedStealRarities
	end,
})

v4:AddDropdown("StealAreasDropdown", {
	Values = tbl.areas,
	Default = {},
	Multi = true,
	Text = "Target Areas (Empty = All)",
	Callback = function(selectedStealAreas)
		getgenv().config.selectedStealAreas = selectedStealAreas
	end,
})

v4:AddToggle("FastInteractToggle", {
	Text = "Fast Interact",
	Default = true,
	Tooltip = "Instantly pick up eggs",
	Callback = function(arg)
		if arg then
			tbl.fastInteractConnection = ProximityPromptService.PromptButtonHoldBegan:Connect(function(prompt, player)
				if player == v and tostring(prompt) == "CarryAreaEgg" then
					prompt.HoldDuration = 0
				end
			end)
		elseif tbl.fastInteractConnection then
			tbl.fastInteractConnection:Disconnect()
			tbl.fastInteractConnection = nil
		end
	end,
})

v6:AddToggle("AutoPlaceToggle", {
	Text = "Auto Lay Eggs",
	Default = false,
	Callback = function(autoPlaceEgg)
		getgenv().config.autoPlaceEgg = autoPlaceEgg
	end,
})

v6:AddSlider("PlaceIntervalSlider", {
	Text = "Place Interval (s)",
	Default = 5,
	Min = 1,
	Max = 60,
	Rounding = 0,
	Compact = false,
	Callback = function(placeInterval)
		getgenv().config.placeInterval = placeInterval
	end,
})

v6:AddDropdown("NeverPlaceRarityDropdown", {
	Values = { "None", unpack(tbl3) },
	Default = "None",
	Multi = false,
	Text = "Never Place Rarer Than",
	Callback = function(neverPlaceRarity)
		getgenv().config.neverPlaceRarity = neverPlaceRarity
	end,
})

v6:AddInput("PlaceMinGenInput", {
	Default = "",
	Numeric = false,
	Finished = true,
	Text = "Min Earning to Place ($/s)",
	Placeholder = "e.g. 1.5m",
	Callback = function(arg)
		getgenv().config.placeMinGen = fn7(arg)
	end,
})

v6:AddButton({
	Text = "Lay Eggs Now",
	Func = function()
		tbl:runAutoPlace()
	end,
	DoubleClick = false,
})

v7:AddToggle("AutoHatchToggle", {
	Text = "Auto Hatch",
	Default = false,
	Callback = function(autoHatch)
		getgenv().config.autoHatch = autoHatch
	end,
})

v7:AddSlider("HatchIntervalSlider", {
	Text = "Hatch Interval (s)",
	Default = 3,
	Min = 1,
	Max = 30,
	Rounding = 0,
	Compact = false,
	Callback = function(hatchInterval)
		getgenv().config.hatchInterval = hatchInterval
	end,
})

v7:AddToggle("AutoCollectToggle", {
	Text = "Auto Collect Money",
	Default = false,
	Callback = function(autoCollect)
		getgenv().config.autoCollect = autoCollect
	end,
})

v7:AddButton({
	Text = "Equip Best Pets",
	Func = function()
		tbl:runEquipBest()
	end,
	DoubleClick = false,
})

v8:AddToggle("UpgPenToggle", {
	Text = "Auto Upgrade Pen",
	Default = false,
	Callback = function(autoUpgPen)
		getgenv().config.autoUpgPen = autoUpgPen
	end,
})

v8:AddToggle("UpgTreadmillToggle", {
	Text = "Auto Upgrade Treadmill",
	Default = false,
	Callback = function(autoUpgTreadmill)
		getgenv().config.autoUpgTreadmill = autoUpgTreadmill
	end,
})

v8:AddToggle("UpgTrailsToggle", {
	Text = "Auto Upgrade Trails",
	Default = false,
	Callback = function(autoUpgTrails)
		getgenv().config.autoUpgTrails = autoUpgTrails
	end,
})

v8:AddInput("KeepMoneyInput", {
	Default = "",
	Numeric = false,
	Finished = true,
	Text = "Keep Money Reserve",
	Placeholder = "e.g. 500m",
	Callback = function(arg)
		getgenv().config.keepMoney = fn7(arg)
	end,
})

v9:AddToggle("AutoSellPetToggle", {
	Text = "Auto Sell Pet",
	Default = false,
	Callback = function(autoSellPet)
		getgenv().config.autoSellPet = autoSellPet
	end,
})

v9:AddToggle("SellAllPetsToggle", {
	Text = "Sell All Pets (Instant)",
	Default = false,
	Callback = function(sellAllPets)
		getgenv().config.sellAllPets = sellAllPets
	end,
})

v9:AddDropdown("SellPetRaritiesDropdown", {
	Values = tbl3,
	Default = { "Common", "Uncommon", "Rare" },
	Multi = true,
	Text = "Pet Rarities",
	Callback = function(sellPetRarities)
		getgenv().config.sellPetRarities = sellPetRarities
	end,
})

v10:AddToggle("AutoSellEggToggle", {
	Text = "Auto Sell Egg",
	Default = false,
	Callback = function(autoSellEgg)
		getgenv().config.autoSellEgg = autoSellEgg
	end,
})

v10:AddDropdown("SellEggRaritiesDropdown", {
	Values = tbl3,
	Default = { "Common", "Uncommon", "Rare" },
	Multi = true,
	Text = "Egg Rarities",
	Callback = function(sellEggRarities)
		getgenv().config.sellEggRarities = sellEggRarities
	end,
})

v10:AddInput("SellUnderGenInput", {
	Default = "",
	Numeric = false,
	Finished = true,
	Text = "Sell Under Earning ($/s)",
	Placeholder = "e.g. 250k",
	Callback = function(arg)
		getgenv().config.sellUnderGen = fn7(arg)
	end,
})

Treadmill:AddToggle("AutoTreadmillToggle", {
	Text = "Auto Treadmill Training",
	Default = false,
	Callback = function(autoTreadmill)
		getgenv().config.autoTreadmill = autoTreadmill
	end,
})

Treadmill:AddToggle("TrainWhenIdleToggle", {
	Text = "Train Only When Idle",
	Default = true,
	Callback = function(trainWhenIdle)
		getgenv().config.trainWhenIdle = trainWhenIdle
	end,
})

v5:AddToggle("DroneFarmToggle", {
	Text = "Auto Farm Drones",
	Default = false,
	Tooltip = "Autofarm drones",
	Callback = function(droneFarm)
		getgenv().config.droneFarm = droneFarm
	end,
})

v5:AddDropdown("DroneHpDropdown", {
	Values = { "3 HP", "5 HP", "10 HP" },
	Default = {},
	Multi = true,
	Text = "Target drone (Empty = All)",
	Callback = function(droneSelectedHp)
		getgenv().config.droneSelectedHp = droneSelectedHp
	end,
})

v5:AddSlider("DroneGlideSpeedSlider", {
	Text = "Fly speed",
	Default = 650,
	Min = 100,
	Max = 800,
	Rounding = 0,
	Compact = false,
	Callback = function(droneGlideSpeed)
		getgenv().config.droneGlideSpeed = droneGlideSpeed
	end,
})

v5:AddSlider("DroneDistanceSlider", {
	Text = "attack range",
	Default = 4.5,
	Min = 2,
	Max = 10,
	Rounding = 1,
	Compact = false,
	Callback = function(droneDistance)
		getgenv().config.droneDistance = droneDistance
	end,
})

v5:AddSlider("DroneCooldownSlider", {
	Text = "cd attack(s)",
	Default = 0.1,
	Min = 0.05,
	Max = 0.5,
	Rounding = 2,
	Compact = false,
	Callback = function(droneAttackCooldown)
		getgenv().config.droneAttackCooldown = droneAttackCooldown
	end,
})

local v11 = tbl13.Combat:AddLeftGroupbox("Kill Aura")

v11:AddToggle("KillAuraToggle", {
	Text = "Kill Aura",
	Default = false,
	Tooltip = "Automatic bat attack",
	Callback = function(killAura)
		getgenv().config.killAura = killAura
	end,
})

v11:AddSlider("CombatDistanceSlider", {
	Text = "Attack Distance",
	Default = 16.5,
	Min = 5,
	Max = 30,
	Rounding = 1,
	Compact = false,
	Callback = function(attackDistance)
		getgenv().config.attackDistance = attackDistance
	end,
})

v11:AddSlider("CombatCooldownSlider", {
	Text = "Attack Interval (s)",
	Default = 0.1,
	Min = 0.05,
	Max = 1,
	Rounding = 2,
	Compact = false,
	Callback = function(attackCooldown)
		getgenv().config.attackCooldown = attackCooldown
	end,
})

local v12 = tbl13.Visual:AddLeftGroupbox("ESP & Visuals")

v12:AddToggle("EggEspToggle", {
	Text = "Field Egg ESP",
	Default = false,
	Callback = function(espEnabled)
		getgenv().config.espEnabled = espEnabled

		if not espEnabled then
			fn41()
		end
	end,
})

v12:AddToggle("PlotEspToggle", {
	Text = "Plot Egg ESP",
	Default = false,
	Callback = function(plotEsp)
		getgenv().config.plotEsp = plotEsp

		if not plotEsp then
			fn43()
		end
	end,
})

v12:AddSlider("MinEarningSlider", {
	Text = "Min Earning (M/s)",
	Default = 0,
	Min = 0,
	Max = 100,
	Rounding = 0,
	Compact = false,
	Callback = function(arg)
		getgenv().config.minEspEarning = arg * 1000000
	end,
})

local v13 = tbl13.Misc:AddLeftGroupbox("Player & Movement")
local v14 = tbl13.Misc:AddRightGroupbox("Extra & Optimizer")

v13:AddToggle("AntiRagdollToggle", {
	Text = "Anti Ragdoll & Anti Trap",
	Default = true,
	Callback = function(antiRagdoll)
		getgenv().config.antiRagdoll = antiRagdoll
		local character = v.Character

		if character then
			fn12(character)
		end
	end,
})

v13:AddToggle("SpeedHackToggle", {
	Text = "Speed Hack",
	Default = false,
	Callback = function(speedEnabled)
		getgenv().config.speedEnabled = speedEnabled
	end,
})

v13:AddSlider("WalkSpeedSlider", {
	Text = "WalkSpeed Value",
	Default = 500,
	Min = 16,
	Max = 1000,
	Rounding = 0,
	Compact = false,
	Callback = function(walkSpeed)
		getgenv().config.walkSpeed = walkSpeed
	end,
})

v14:AddToggle("ClaimIndexToggle", {
	Text = "Auto Claim Index Rewards",
	Default = false,
	Callback = function(autoClaimIndex)
		getgenv().config.autoClaimIndex = autoClaimIndex
	end,
})

lib2:SetLibrary(lib)
lib3:SetLibrary(lib)
lib3:IgnoreThemeSettings()
lib3:SetIgnoreIndexes({})
lib2:SetFolder("HollyScriptX")
lib3:SetFolder("HollyScriptX/configs")
lib3:BuildConfigSection(tbl13.Settings)
lib2:ApplyToTab(tbl13.Settings)
lib3:LoadAutoloadConfig()
