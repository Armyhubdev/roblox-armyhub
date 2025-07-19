-- Army Hub | Emergency Hamburg GUI
local S = Instance.new("ScreenGui")
local F = Instance.new("Frame")
local T = Instance.new("TextLabel")
local C = Instance.new("TextButton")
local D = Instance.new("TextButton")
local Tabs = {"Aimbot","ESP","Teleport","Vehicle Mods","Player Mods","Misc","Credits"}
local Scripts = {
  Aimbot = "https://raw.githubusercontent.com/Armyhubdev/roblox-armyhub/main/aimbot.lua",
  ESP = "https://raw.githubusercontent.com/Armyhubdev/roblox-armyhub/main/esp.lua",
  Teleport = "https://raw.githubusercontent.com/Armyhubdev/roblox-armyhub/main/teleport.lua",
  ["Vehicle Mods"] = "https://raw.githubusercontent.com/Armyhubdev/roblox-armyhub/main/vehiclemods.lua",
  ["Player Mods"] = "https://raw.githubusercontent.com/Armyhubdev/roblox-armyhub/main/playermods.lua",
  Misc = "https://raw.githubusercontent.com/Armyhubdev/roblox-armyhub/main/misc.lua",
  Credits = "https://raw.githubusercontent.com/Armyhubdev/roblox-armyhub/main/credits.lua"
}

-- GUI
S.Name, S.Parent = "ArmyHub", game.Players.LocalPlayer:WaitForChild("PlayerGui")
F.Name, F.Parent, F.BackgroundColor3 = "Main", S, Color3.fromRGB(25,25,25)
F.Position, F.Size = UDim2.new(0.3,0,0.3,0), UDim2.new(0,420,0,280)
F.Active, F.Draggable = true, false

-- Title
T.Parent = F
T.Size, T.Text, T.Font, T.TextSize = UDim2.new(1,0,0,30),"Army Hub | Emergency Hamburg",Enum.Font.GothamBold,22
T.TextColor3, T.BackgroundTransparency = Color3.new(1,1,1),1

-- Close Button
C.Parent = F
C.Size, C.Position, C.Text, C.Font, C.TextSize = UDim2.new(0,30,0,30), UDim2.new(1,-30,0,0), "-", Enum.Font.GothamBold,24
C.TextColor3, C.BackgroundTransparency = Color3.new(1,0,0),1
C.MouseButton1Click:Connect(function() F.Visible = false end)

-- Drag bar
D.Parent, D.Size, D.Position = F, UDim2.new(1,0,0,20), UDim2.new(0,0,1,-20)
D.Text, D.Font, D.TextSize = "Click to drag", Enum.Font.Gotham,14
D.TextColor3, D.BackgroundColor3, D.Active, D.Draggable = Color3.fromRGB(200,200,200), Color3.fromRGB(40,40,40), true, true

-- Tabs Buttons
local function makeTab(name,i)
  local btn = Instance.new("TextButton")
  btn.Parent = F
  btn.Size, btn.Position = UDim2.new(0,100,0,28), UDim2.new(0.02+0.14*(i-1),0,0,35)
  btn.Text, btn.Font, btn.TextSize = name, Enum.Font.GothamSemibold,16
  btn.TextColor3, btn.BackgroundColor3 = Color3.new(1,1,1), Color3.fromRGB(35,35,35)
  btn.MouseButton1Click:Connect(function()
    local url = Scripts[name]
    if url then loadstring(game:HttpGet(url))() end
  end)
end
for i,name in ipairs(Tabs) do makeTab(name,i) end

print("✅ Army Hub loaded!")
