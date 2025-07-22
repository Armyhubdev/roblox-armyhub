-- Army Hub GUI (Offline Version)
-- Fully Embedded, No 404s – Made for Gupta Rudra

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local uis = game:GetService("UserInputService")
local tween = game:GetService("TweenService")

-- GUI base
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "ArmyHub"

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 500, 0, 300)
main.Position = UDim2.new(0.5, -250, 0.5, -150)
main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "Army Hub"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

local closeBtn = Instance.new("TextButton", main)
closeBtn.Size = UDim2.new(0, 40, 0, 40)
closeBtn.Position = UDim2.new(1, -40, 0, 0)
closeBtn.Text = "–"
closeBtn.TextScaled = true
closeBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

local tabList = {
	"Aimbot", "ESP", "Teleport", "Vehicle Mods", "Player Mods", "Misc", "Credits"
}

local selectedTab = nil
local content = Instance.new("Frame", main)
content.Position = UDim2.new(0, 140, 0, 40)
content.Size = UDim2.new(1, -140, 1, -40)
content.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

local tabHolder = Instance.new("Frame", main)
tabHolder.Size = UDim2.new(0, 140, 1, -40)
tabHolder.Position = UDim2.new(0, 0, 0, 40)
tabHolder.BackgroundColor3 = Color3.fromRGB(45, 45, 45)

local function clearContent()
	for _, v in pairs(content:GetChildren()) do
		if not v:IsA("UIListLayout") then v:Destroy() end
	end
end

local function addButton(name, callback)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, -10, 0, 35)
	btn.Text = name
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.TextScaled = true
	btn.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
	btn.Parent = content
	btn.MouseButton1Click:Connect(callback)
end

local function loadTab(tab)
	clearContent()
	if tab == "Aimbot" then
		addButton("Enable Aimbot", function()
			local Players = game:GetService("Players")
			local lp = Players.LocalPlayer
			local mouse = lp:GetMouse()
			local camera = workspace.CurrentCamera
			local rs = game:GetService("RunService")

			local function getClosest()
				local dist, target = math.huge
				for i,v in pairs(Players:GetPlayers()) do
					if v ~= lp and v.Character and v.Character:FindFirstChild("Head") then
						local pos, onScreen = camera:WorldToViewportPoint(v.Character.Head.Position)
						if onScreen then
							local mag = (Vector2.new(mouse.X, mouse.Y) - Vector2.new(pos.X, pos.Y)).Magnitude
							if mag < dist then
								dist = mag
								target = v
							end
						end
					end
				end
				return target
			end

			rs.RenderStepped:Connect(function()
				local target = getClosest()
				if target and target.Character and target.Character:FindFirstChild("Head") then
					camera.CFrame = CFrame.new(camera.CFrame.Position, target.Character.Head.Position)
				end
			end)
		end)
	elseif tab == "ESP" then
		addButton("Enable ESP", function()
			local Players = game:GetService("Players")
			local lp = Players.LocalPlayer
			local rs = game:GetService("RunService")

			local function createESP(plr)
				if plr == lp then return end
				local box = Drawing.new("Text")
				box.Text = plr.Name
				box.Size = 15
				box.Center = true
				box.Outline = true
				box.Color = Color3.fromRGB(0,255,0)

				rs.RenderStepped:Connect(function()
					if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
						local pos, visible = workspace.CurrentCamera:WorldToViewportPoint(plr.Character.HumanoidRootPart.Position)
						box.Position = Vector2.new(pos.X, pos.Y)
						box.Visible = visible
					else
						box.Visible = false
					end
				end)
			end

			for _, plr in pairs(Players:GetPlayers()) do
				createESP(plr)
			end

			Players.PlayerAdded:Connect(createESP)
		end)
	elseif tab == "Teleport" then
		addButton("To Police", function() player.Character:MoveTo(Vector3.new(835, 20, -245)) end)
		addButton("To Bank", function() player.Character:MoveTo(Vector3.new(125, 20, 325)) end)
		addButton("To Hospital", function() player.Character:MoveTo(Vector3.new(-525, 20, 115)) end)
	elseif tab == "Vehicle Mods" then
		addButton("Boost Car Speed", function()
			local car = player.Character and player.Character.Parent
			if car and car:FindFirstChild("Engine") then
				for _,v in pairs(car:GetDescendants()) do
					if v:IsA("VehicleSeat") then
						v.MaxSpeed = 999
						v.Torque = 9999
					end
				end
			end
		end)
	elseif tab == "Player Mods" then
		addButton("WalkSpeed 50", function() player.Character.Humanoid.WalkSpeed = 50 end)
		addButton("JumpPower 100", function() player.Character.Humanoid.JumpPower = 100 end)
	elseif tab == "Misc" then
		addButton("No Clip", function()
			game:GetService("RunService").Stepped:Connect(function()
				if player.Character then
					for _, part in pairs(player.Character:GetDescendants()) do
						if part:IsA("BasePart") then part.CanCollide = false end
					end
				end
			end)
		end)
		addButton("Car Fly", function()
			local car = player.Character and player.Character.Parent
			if car then
				local bg = Instance.new("BodyGyro", car.PrimaryPart)
				bg.CFrame = car.PrimaryPart.CFrame
				bg.MaxTorque = Vector3.new(999999,999999,999999)
				local bv = Instance.new("BodyVelocity", car.PrimaryPart)
				bv.Velocity = Vector3.new(0,50,0)
				bv.MaxForce = Vector3.new(999999,999999,999999)
			end
		end)
	elseif tab == "Credits" then
		addButton("Made by", function() print("Army Hub | Gupta Rudra") end)
	end
end

local layout = Instance.new("UIListLayout", tabHolder)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Padding = UDim.new(0, 5)

for _, tab in ipairs(tabList) do
	local b = Instance.new("TextButton", tabHolder)
	b.Size = UDim2.new(1, -10, 0, 35)
	b.Text = tab
	b.TextScaled = true
	b.TextColor3 = Color3.new(1,1,1)
	b.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
	b.MouseButton1Click:Connect(function()
		loadTab(tab)
	end)
end
