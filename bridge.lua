--[[
COPYRIGHT 2024 LETHALWARE SOFTWARE. Permmision to copy and publish as your own is denied unless you are Authorised by LuaW
Auth at our server: https://discord.gg/D9B4BNsx6S
Website: https://lovewarefr.github.io/LoveWare
]]

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
-- Create Window
local Window = Rayfield:CreateWindow({
    Name = "LethalWare | Private (snapshot 1.4bhj)",
    LoadingTitle = "LethalWare - For Bridge Duels",
    LoadingSubtitle = "by LuaW, Reallysmall",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "LethalSoftware",
        FileName = "config"
    },
    Discord = {
        Enabled = true,
        Invite = "D9B4BNsx6S",
        RememberJoins = true
    },
    KeySystem = false,
    KeySettings = {
        Title = "LuaW",
        Subtitle = "No Key Required",
        Note = "",
        FileName = "",
        SaveKey = false,
        GrabKeyFromSite = false,
        Key = ""
    }
})
function exec()
    return printidentity()
end

local exec = exec()
Rayfield:Notify({
   Title = "Exec is detected",
   Content = exec,
   Duration = 6.5,
   Image = 4483362458,
   Actions = {
      Ignore = {
         Name = "Okay!",
         Callback = function()
             print("Flow SHIT lethalware cool")
         end
      }
   },
})

-- Create Tab
local Tab = Window:CreateTab("Exploits", 4483362458)

-- Hitbox Expander
local hitboxSizeInMeters = 10
local studsPerMeter = 3.57
local hitboxSizeInStuds = hitboxSizeInMeters * studsPerMeter

local function modifyPart(char, partName, size)
    local part = char:FindFirstChild(partName)
    if part then
        part.CanCollide = false
        part.Transparency = 1
        part.Size = Vector3.new(size, size, size)
    end
end

local function applyHitboxExpansion()
    while wait(1) do
        for _, v in pairs(game:GetService("Players"):GetPlayers()) do
            if v ~= game.Players.LocalPlayer and v.Character then
                local char = v.Character
                modifyPart(char, "ProjectileHitbox", hitboxSizeInStuds)
                modifyPart(char, "CollisionBox", hitboxSizeInStuds)
                modifyPart(char, "Hitbox", hitboxSizeInStuds)
            end
        end
    end
end

local HitboxSlider = Tab:CreateSlider({
    Name = "Reach",
    Info = "You heard the name right!",
    Range = {1, 50},
    Increment = 1,
    Suffix = "Meters (1 meter = 3.57 studs)",
    CurrentValue = hitboxSizeInMeters,
    Flag = "HitboxSlider",
    Callback = function(Value)
        hitboxSizeInMeters = Value
        hitboxSizeInStuds = hitboxSizeInMeters * studsPerMeter
        print("Hitbox size set to:", hitboxSizeInMeters, "meters (", hitboxSizeInStuds, "studs)")
    end,
})

spawn(applyHitboxExpansion)

-- ESP Implementation
local espEnabled = false

local function createESP(player)
    if player.Character and player.Character:FindFirstChild("Head") then
        if not player.Character.Head:FindFirstChild("ESP") then
            local billboard = Instance.new("BillboardGui", player.Character.Head)
            billboard.Name = "ESP"
            billboard.AlwaysOnTop = true
            billboard.Size = UDim2.new(1, 0, 1, 0)
            billboard.StudsOffset = Vector3.new(0, 3, 0)

            local frame = Instance.new("Frame", billboard)
            frame.Size = UDim2.new(1, 1, 1, 1)
            frame.BackgroundTransparency = 0.5
            frame.BackgroundColor3 = Color3.new(1, 0, 0)
        end
    end
end

local function enableESP()
    espEnabled = true
    while espEnabled do
        for _, player in pairs(game:GetService("Players"):GetPlayers()) do
            if player ~= game.Players.LocalPlayer then
                createESP(player)
            end
        end
        wait(1)
    end
end

local function disableESP()
    espEnabled = false
    for _, player in pairs(game:GetService("Players"):GetPlayers()) do
        if player.Character and player.Character:FindFirstChild("Head") then
            local esp = player.Character.Head:FindFirstChild("ESP")
            if esp then
                esp:Destroy()
            end
        end
    end
end

local ESPToggle = Tab:CreateToggle({
    Name = "Enable ESP",
    Info = "Toggle ESP on or off.",
    CurrentValue = false,
    Flag = "ESPToggle",
    Callback = function(Value)
        if Value then
            print("ESP enabled")
            enableESP()
        else
            print("ESP disabled")
            disableESP()
        end
    end,
})

-- Killaura Implementation
local killauraEnabled = false

local function enableKillaura()
    killauraEnabled = true
    while killauraEnabled do
        for _, player in pairs(game:GetService("Players"):GetPlayers()) do
            if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local distance = (player.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude
                if distance <= 10 then
                    game:GetService("VirtualUser"):Button1Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
                    wait(0.1)
                    game:GetService("VirtualUser"):Button1Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
                end
            end
        end
        wait(0.5)
    end
end

local function disableKillaura()
    killauraEnabled = false
end

local KillauraToggle = Tab:CreateToggle({
    Name = "Enable Killaura",
    Info = "Toggle Killaura on or off.",
    CurrentValue = false,
    Flag = "KillauraToggle",
    Callback = function(Value)
        if Value then
            print("Killaura enabled")
            enableKillaura()
        else
            print("Killaura disabled")
            disableKillaura()
        end
    end,
})

-- Auto-Clicker Implementation
local autoClickerEnabled = false
local autoClickInterval = 0.00000000000000000000000000000000001
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local function clickLoop()
    while autoClickerEnabled do
        if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
            game:GetService("VirtualUser"):Button1Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
            wait(autoClickInterval)
            game:GetService("VirtualUser"):Button1Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
            wait(autoClickInterval)
        else
            wait(0.1)
        end
    end
end

local function enableAutoClicker()
    autoClickerEnabled = true
    RunService:BindToRenderStep("AutoClicker", Enum.RenderPriority.Input.Value, clickLoop)
end

local function disableAutoClicker()
    autoClickerEnabled = false
    RunService:UnbindFromRenderStep("AutoClicker")
end

local AutoClickerToggle = Tab:CreateToggle({
    Name = "Enable Auto-Clicker",
    Info = "Toggle Auto-Clicker on or off.",
    CurrentValue = false,
    Flag = "AutoClickerToggle",
    Callback = function(Value)
        if Value then
            print("Auto-Clicker enabled")
            enableAutoClicker()
        else
            print("Auto-Clicker disabled")
            disableAutoClicker()
        end
    end,
})

-- Infinite Health Implementation
local function setInfiniteHealth()
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("Humanoid") then
        local humanoid = player.Character:FindFirstChild("Humanoid")
        while true do
            wait(0.1)
            humanoid.MaxHealth = math.huge
            humanoid.Health = math.huge
        end
    end
end

local InfiniteHealthButton = Tab:CreateButton({
    Name = "Set Infinite Health",
    Info = "Set your health to infinite.",
    Callback = function()
        spawn(setInfiniteHealth)
        print("Infinite health set.")
    end,
})

-- Teleport to Enemy Base
local function teleportToEnemyBase()
    local enemyBasePosition = Vector3.new(0, 0, 0)
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(enemyBasePosition)
    end
end

local TeleportButton = Tab:CreateButton({
    Name = "Teleport to Enemy Base",
    Info = "Teleport to the enemy base.",
    Callback = function()
        teleportToEnemyBase()
        print("Teleported to enemy base.")
    end,
})

-- Fly Implementation
local flyEnabled = false

local function flyLoop()
    local player = game.Players.LocalPlayer
    local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
    while flyEnabled do
        humanoid:Move(Vector3.new(0, 1, 0), true)
        wait(0.1)
    end
end

local function enableFly()
    flyEnabled = true
    spawn(flyLoop)
end

local function disableFly()
    flyEnabled = false
end

local FlyToggle = Tab:CreateToggle({
    Name = "Enable Fly",
    Info = "Toggle fly on or off.",
    CurrentValue = false,
    Flag = "FlyToggle",
    Callback = function(Value)
        if Value then
            print("Fly enabled")
            enableFly()
        else
            print("Fly disabled")
            disableFly()
        end
    end,
})

-- No-Clip Implementation
local noClipEnabled = false

local function noClipLoop()
    local player = game.Players.LocalPlayer
    while noClipEnabled do
        for _, v in pairs(player.Character:GetDescendants()) do
            if v:IsA("BasePart") and v.CanCollide then
                v.CanCollide = false
            end
        end
        wait(0.1)
    end
end

local function enableNoClip()
    noClipEnabled = true
    spawn(noClipLoop)
end

local function disableNoClip()
    noClipEnabled = false
end

local NoClipToggle = Tab:CreateToggle({
    Name = "Enable No-Clip",
    Info = "Toggle no-clip on or off.",
    CurrentValue = false,
    Flag = "NoClipToggle",
    Callback = function(Value)
        if Value then
            print("No-Clip enabled")
            enableNoClip()
        else
            print("No-Clip disabled")
            disableNoClip()
        end
    end,
})

-- Anti-Hit Implementation
local function antiHit()
    local player = game.Players.LocalPlayer
    local character = player.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        local originalPosition = character.HumanoidRootPart.Position
        while wait(0.1) do
            if (character.HumanoidRootPart.Position - originalPosition).magnitude > 5 then
                character.HumanoidRootPart.CFrame = CFrame.new(originalPosition)
                print("Teleported back to original position to avoid hit.")
            end
        end
    end
end

local AntiHitButton = Tab:CreateButton({
    Name = "Enable Anti-Hit",
    Info = "Teleport back to original position to avoid hits.",
    Callback = function()
        spawn(antiHit)
        print("Anti-Hit enabled.")
    end,
})

-- Final Debugging
print("Script Loaded. Ensure that all functionalities are working correctly.")
Tab:CreateLabel("LethalWare Copyright. Only Authorized People like LuaW, Reallysmall And VoidedX Can Edit")
