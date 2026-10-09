
	local localPlayer = game:GetService("Players").LocalPlayer
	local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/main/Library.lua"))()
	local str = "HSX-7562-3194-0835-4981-2470-1488-1029-6967"
	local str2 = "https://raw.githubusercontent.com/brojstypingshit-prog/Othergames/main/"

	local tbl = {
		[7008097940] = {
			label = "Ink Game",
			url = "https://raw.githubusercontent.com/brojstypingshit-prog/main.luau/refs/heads/main/didushehhhdhddh-obfuscated.lua%20(1).txt",
		},
		[10563114921] = {
			label = "Steal an egg",
			url = "https://raw.githubusercontent.com/brojstypingshit-prog/Othergames/refs/heads/main/egg-obfuscated.lua",
		},
		[10555208613] = {
			label = "Detour",
			url = "https://raw.githubusercontent.com/brojstypingshit-prog/Othergames/refs/heads/main/detou-obfuscated.lua",
		},
		[10148749921] = { label = "Animal Hospital", file = "HollyScriptX_AnimalHospital-obfuscated.lua" },
		[8795154789] = {
			label = "Flick",
			url = "https://raw.githubusercontent.com/brojstypingshit-prog/Othergames/refs/heads/main/Flick-obfuscated.lua",
		},
		[7326934954] = { label = "99 Nights", file = "HollyScriptX_99Nights-obfuscated.lua" },
		[73885730] = { label = "Prison Life", file = "HollyScriptX_PrisonLife-obfuscated.lua" },
		[66654135] = { label = "Murder Mystery 2", file = "HollyScriptX_MM2-obfuscated.lua" },
		[7436755782] = { label = "Grow a Garden", file = "HollyScriptX_GAG2-obfuscated.lua" },
		[2440500124] = { label = "Doors | Hotel", file = "HollyScriptX_Doors_Hotel-obfuscated.lua" },
		[9584852943] = { label = "Speed Keyboard Escape", file = "HollyScriptX_SpeedKeyboardEscape-obfuscated.lua" },
		[6035872082] = { label = "Rivals", file = "HollyScriptX_Rivals-obfuscated.lua" },
		[4777817887] = { label = "Blade Ball", file = "HollyScriptX_BladeBall-obfuscated.lua" },
		[1008451066] = { label = "Da Hood", file = "HollyScriptX_DaHood-obfuscated.lua" },
		[7613921865] = { label = "Anime Expeditions", file = "HollyScriptX_AnimeExpeditions-obfuscated.lua" },
		[88070565] = { label = "Bloxburg", file = "HollyScriptX_Bloxburg-obfuscated.lua" },
		[2406191199] = { label = "MPS Futsal", file = "HollyScriptX_MPS_Futsal-obfuscated.lua" },
	}

	local v = tbl[game.GameId] or tbl[game.PlaceId]

	local function fn(arg, arg2)
		pcall(function()
			local v2 = lib
			local notify = v2.Notify
			local str3 = tostring(arg)
			local num = tonumber(arg2)
			local n

			if num then
				n = num
			else
				if num then
					error("devirt: unexplored successor 195:18")
				end

				n = 3
			end

			notify(v2, str3, n)
		end)
	end

	local function fn2()
		local v2 = makefolder

		if v2 then
			if not v2 then
				error("devirt: unexplored successor 195:1")
			end

			pcall(makefolder, "HollyScriptX")
		end
	end

	local function fn3(arg)
		fn2()
		local v2 = writefile

		if v2 then
			if not v2 then
				error("devirt: unexplored successor 195:9")
			end

			pcall(writefile, "HollyScriptX/auth_key.txt", arg)
		end
	end

	local function fn4()
		local txt = isfile and isfile("HollyScriptX/auth_key.txt") and readfile

		if txt then
			local ok, result = pcall(readfile, "HollyScriptX/auth_key.txt")

			if ok then
				ok = type(result) == "string"
			elseif ok then
				error("devirt: unexplored successor 68:27")
			end

			if ok then
				return result:gsub("%s+", "")
			end
		elseif txt then
			error("devirt: unexplored successor 149:24")
		end

		return nil
	end

	local function fn5(arg)
		fn2()
		local v2 = writefile

		if v2 then
			if not v2 then
				error("devirt: unexplored successor 195:31")
			end

			pcall(writefile, "HollyScriptX/remember_key.txt", arg and "1" or "0")
		end
	end

	local function fn6()
		local txt = isfile and isfile("HollyScriptX/remember_key.txt") and readfile

		if txt then
			if not txt then
				error("devirt: unexplored successor 149:50")
			end

			local ok, result = pcall(readfile, "HollyScriptX/remember_key.txt")
			local flag = ok and tostring(result):gsub("%s+", "") == "1"

			if flag then
				if flag then
					return true
				end
				error("devirt: unexplored successor 39:65")
			end
		end

		return false
	end

	local function fn7(arg)
		local url = arg.url

		if not url then
			local v2 = str2
			local v3 = tostring
			local file = arg.file
			local str3

			if file then
				if not file then
					error("devirt: unexplored successor 195:22")
				end

				str3 = file
			else
				str3 = ""
			end

			url = v2 .. v3(str3)
		end

		local ok, result = pcall(function()
			return game:HttpGet(url)
		end)

		local flag = not ok
		local flag2

		if flag then
			if not flag then
				error("devirt: unexplored successor 149:95")
			end

			flag2 = flag
		else
			flag2 = type(result) ~= "string"
		end

		if flag2 or #result < 50 then
			fn("Failed to download script from github.", 4)
			return false
		end
		local ok2, result2 = pcall(loadstring, result)
		if not ok2 or type(result2) ~= "function" then
			fn("Failed to compile script.", 4)
			return false
		end
		local ok3, result3 = pcall(result2)
		if not ok3 then
			fn("Script error: " .. tostring(result3), 5)
			return false
		end
		fn("Loaded " .. tostring(arg.label) .. ".", 3)
		return true
	end

	local function fn8()
		task.defer(function()
			task.wait(0.35)

			pcall(function()
				lib:Unload()
			end)
		end)
	end

	local function fn9(arg, arg2)
		local v2 = tostring
		local str3

		if arg then
			str3 = arg
		else
			if arg then
				error("devirt: unexplored successor 195:2")
			end

			str3 = ""
		end

		local str4 = v2(str3):gsub("%s+", "")
		if str4 ~= str then
			fn("Wrong key. Get key from a discord server.", 4)
			return false
		end
		local flag = not v

		if flag then
			if flag then
				fn("Current game is not supported (ID: " .. tostring(game.GameId) .. ")", 5)
				return false
			end
			error("devirt: unexplored successor 68:22")
		end

		if arg2 then
			fn3(str4)
			fn5(true)
		else
			fn5(false)
		end

		local v3 = fn7(v)

		if v3 then
			fn8()
		end

		return v3
	end

	if fn6() then
		local flag = fn4() == str and v

		if flag then
			if flag then
				task.spawn(function()
					fn7(v)
				end)

				return
			end

			error("devirt: unexplored successor 39:166")
		end
	end

	lib.CornerRadius = 25

	pcall(function()
		local setCornerRadius = lib.SetCornerRadius

		if setCornerRadius then
			lib:SetCornerRadius(25)
		elseif setCornerRadius then
			error("devirt: unexplored successor 195:2")
		end
	end)

	local v2 = lib:CreateWindow({
		Title = "HollyScriptX",
		Center = true,
		Footer = "https://discord.gg/hollyscriptx-1504482964661076098 | Loader",
		Resizable = true,
		AutoShow = true,
		ShowCustomCursor = false,
		ToggleKeybind = Enum.KeyCode.Z,
		CornerRadius = 25,
		AlwaysOnTop = true,
	})

	local tbl2 = { Key = v2:AddTab("Key", "key-round"), Settings = v2:AddTab("Settings", "settings") }
	local Auth = tbl2.Key:AddLeftGroupbox("Auth")
	Auth:AddLabel("Get key from discord")
	local LoaderKeyInput = nil

	pcall(function()
		LoaderKeyInput = Auth:AddInput("LoaderKeyInput", {
			Text = "Key",
			Default = "",
			Placeholder = "HSX-....",
			Numeric = false,
			Finished = false,
			Callback = function()
			end,
		})
	end)

	local RememberCorrectKey = nil

	pcall(function()
		RememberCorrectKey = Auth:AddToggle("RememberCorrectKey", {
			Text = "Remember Correct key",
			Default = fn6(),
			Callback = function(arg)
				local v3 = fn5
				local flag

				if arg then
					if not arg then
						error("devirt: unexplored successor 149:7")
					end

					flag = true
				else
					flag = arg
				end

				v3(flag or false)
			end,
		})
	end)

	Auth:AddButton({
		Text = "Submit Key",
		Func = function()
			local loaderKeyInput = lib.Options and lib.Options.LoaderKeyInput
			local str3

			if loaderKeyInput then
				if not loaderKeyInput then
					error("devirt: unexplored successor 195:8")
				end

				str3 = tostring(lib.Options.LoaderKeyInput.Value or "")
			else
				local value = LoaderKeyInput and LoaderKeyInput.Value
				str3 = ""

				if value then
					str3 = tostring(LoaderKeyInput.Value)
				end
			end

			local flag

			if lib.Toggles and lib.Toggles.RememberCorrectKey then
				flag = lib.Toggles.RememberCorrectKey.Value and true or false
			else
				local v3 = RememberCorrectKey
				local flag2 = RememberCorrectKey

				if v3 then
					if not v3 then
						error("devirt: unexplored successor 149:90")
					end

					flag2 = RememberCorrectKey.Value ~= nil
				end

				flag = false

				if flag2 then
					flag = RememberCorrectKey.Value

					if flag then
						flag = true
					elseif flag then
						error("devirt: unexplored successor 68:42")
					end

					if flag then
						if not flag then
							error("devirt: unexplored successor 39:61")
						end
					else
						flag = false
					end
				end
			end

			fn9(str3, flag)
		end,
	})

	Auth:AddButton({
		Text = "Get Permanent Key",
		Func = function()
			local v3 = setclipboard

			if v3 then
				if not v3 then
					error("devirt: unexplored successor 149:6")
				end

				pcall(setclipboard, "https://discord.gg/hollyscriptx-1504482964661076098")
			elseif toclipboard then
				pcall(toclipboard, "https://discord.gg/hollyscriptx-1504482964661076098")
			end

			fn("Discord link has been copied successfully.", 3)
		end,
	})

	local v3 = tbl2.Key:AddRightGroupbox("Game Detected")

	if v then
		v3:AddLabel("Game: " .. tostring(v.label))
		v3:AddLabel("Status: Supported")
	else
		if v then
			error("devirt: unexplored successor 68:246")
		end

		v3:AddLabel("Game: Unknown")
		v3:AddLabel("Status: Not Supported")
	end

	v3:AddLabel("Game ID: " .. tostring(game.GameId))
	v3:AddLabel("Place ID: " .. tostring(game.PlaceId))
	local Menu = tbl2.Settings:AddLeftGroupbox("Menu")

	task.defer(function()
		local addLabel = Menu.AddLabel and Menu:AddLabel("Menu bind")
		local v4

		if addLabel then
			v4 = addLabel
		else
			if addLabel then
				error("devirt: unexplored successor 195:100")
			end

			v4 = nil
		end

		local addKeyPicker = v4 and v4.AddKeyPicker
		local MenuKeybind = nil

		if addKeyPicker then
			MenuKeybind = v4:AddKeyPicker("MenuKeybind", { Default = "Z", Mode = "Toggle", Text = "Menu keybind", NoUI = true })
		end

		if lib.Options and lib.Options.MenuKeybind then
			lib.ToggleKeybind = lib.Options.MenuKeybind
		elseif MenuKeybind then
			lib.ToggleKeybind = MenuKeybind
		else
			if MenuKeybind then
				error("devirt: unexplored successor 39:67")
			end

			lib.ToggleKeybind = Enum.KeyCode.Z
		end
	end)

	Menu:AddDropdown("DPIScale", {
		Text = "DPI Scale",
		Values = { "50", "75", "90", "100", "125", "150", "200" },
		Default = "100",
		Callback = function(arg)
			pcall(function()
				local v4 = lib
				local setDPIScale = v4.SetDPIScale
				local num = tonumber(arg)
				local n

				if num then
					n = num
				else
					if num then
						error("devirt: unexplored successor 195:10")
					end

					n = 100
				end

				setDPIScale(v4, n)
			end)
		end,
	})

	Menu:AddButton({
		Text = "Clear Saved Key",
		Func = function()
			local v4 = writefile

			if v4 then
				pcall(writefile, "HollyScriptX/auth_key.txt", "")
				pcall(writefile, "HollyScriptX/remember_key.txt", "0")
			elseif v4 then
				error("devirt: unexplored successor 195:36")
			end

			if delfile then
				pcall(delfile, "HollyScriptX/auth_key.txt")
				pcall(delfile, "HollyScriptX/remember_key.txt")
				pcall(delfile, "HollyScriptX/selected_game.txt")
			end

			fn("Saved key cleared.", 2)
		end,
	})

	Menu:AddButton({
		Text = "Unload Loader",
		Func = function()
			pcall(function()
				lib:Unload()
			end)
		end,
	})
