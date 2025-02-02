local Library = loadstring(game:HttpGet('https://raw.githubusercontent.com/VisualRoblox/Roblox/main/UI-Libraries/Visual%20UI%20Library/Source.lua'))()
local Window = Library:CreateWindow('nebula.hook', 'South Bronx The Trenches', 'nebula.hook', 'rbxassetid://10618928818', false, 'nebulahook', 'Default')
-- // Tabs
local CombatTab = Window:CreateTab('Combat', true, 'rbxassetid://3926305904', Vector2.new(524, 44), Vector2.new(36, 36))
local VisualsTab = Window:CreateTab('Visuals', true, 'rbxassetid://3926305904', Vector2.new(524, 44), Vector2.new(36, 36))
local MiscTab = Window:CreateTab('Misc', true, 'rbxassetid://3926305904', Vector2.new(524, 44), Vector2.new(36, 36))
local CreditsTab = Window:CreateTab('Credits', true, 'rbxassetid://3926305904', Vector2.new(524, 44), Vector2.new(36, 36))

-- // Sections
local CombatSection = CombatTab:CreateSection('Combat')
local GunModsSection = CombatTab:CreateSection('Gun Mods')
local MiscSection = MiscTab:CreateSection('Misc')
local VisualsSection = VisualsTab:CreateSection('Visuals')

local CreditsSection = CreditsTab:CreateSection('Credits')

-- // Variables
local Variables = {
    -- # Combat
    Aimbot = false;
    ShowAimbotFOV = true;
    AimbotSmoothness = 1;

    -- # Visuals
    GlowESP = false;

    -- # Misc
    InstantLoot = false;

    -- # Gun Mods
    NoRecoil = false;
    RapidFire = false;
    NoSpread = false;
    FastBullet = false;
    MultipleBullet = false;
    QuickReload = false;
    NoJam = false;
    UnlimitedRange = false;
    UnlimitedAmmo = false;
}
Holding = false;

-- // Services
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local TweenService = game:GetService('TweenService')
local UserInputService = game:GetService('UserInputService')
local RunService = game:GetService('RunService')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Camera = game.workspace.Camera

-- // UI Handler

-- # COMBAT
local AimBotToggle = CombatSection:CreateToggle('Aimbot', false, Color3.fromRGB(0, 125, 255), 0.25, function(Value)
    Variables.Aimbot = Value
end)

local ShowAimbotFOVToggle = CombatSection:CreateToggle('Show Aimbot FOV', tr, Color3.fromRGB(0, 125, 255), 0.25, function(Value)
    Variables.ShowAimbotFOV = Value
end)

local AimbotSmoothnessSlider = CombatSection:CreateSlider('Aimbot Smoothness', 0.1, 0, 1, Color3.fromRGB(0, 125, 255), function(Value)
    Variables.AimbotSmoothness = Value
end)

CombatSection:CreateLabel('NOTE: Gun Mods are Buggy!')

-- # VISUALS
local GlowESPToggle = VisualsSection:CreateToggle('Glow ESP', false, Color3.fromRGB(0, 125, 255), 0.25, function(Value)
    Variables.GlowESP = Value
end)

-- # GUN MODS
local NoRecoilToggle = GunModsSection:CreateToggle('No Recoil', false, Color3.fromRGB(0, 125, 255), 0.25, function(Value)
    Variables.NoRecoil = Value
end)

local RapidFireToggle = GunModsSection:CreateToggle('Rapid Fire', false, Color3.fromRGB(0, 125, 255), 0.25, function(Value)
    Variables.RapidFire = Value
end)

local NoSpreadToggle = GunModsSection:CreateToggle('No Spread', false, Color3.fromRGB(0, 125, 255), 0.25, function(Value)
    Variables.NoSpread = Value
end)

local FastBulletToggle = GunModsSection:CreateToggle('Fast Bullet', false, Color3.fromRGB(0, 125, 255), 0.25, function(Value)
    Variables.FastBullet = Value
end)

local MultipleBulletToggle = GunModsSection:CreateToggle('Multiple Bullets', false, Color3.fromRGB(0, 125, 255), 0.25, function(Value)
    Variables.MultipleBullet = Value
end)

local QuickReloadToggle = GunModsSection:CreateToggle('Quick Reload', false, Color3.fromRGB(0, 125, 255), 0.25, function(Value)
    Variables.QuickReload = Value
end)

local NoJamToggle = GunModsSection:CreateToggle('No Jam', false, Color3.fromRGB(0, 125, 255), 0.25, function(Value)
    Variables.NoJam = Value
end)

local UnlimitedRangeToggle = GunModsSection:CreateToggle('Unlimited Range', false, Color3.fromRGB(0, 125, 255), 0.25, function(Value)
    Variables.UnlimitedRange = Value
end)

local UnlimitedAmmoToggle = GunModsSection:CreateToggle('Unlimited Ammo', false, Color3.fromRGB(0, 125, 255), 0.25, function(Value)
    Variables.UnlimitedAmmo = Value
end)

-- # MISC
local InstantLootToggle = MiscSection:CreateToggle('Auto Loot', false, Color3.fromRGB(0, 125, 255), 0.25, function(Value)
    Variables.InstantLoot = Value
end)

local CustomNameTextBox = MiscSection:CreateTextbox('Custom Name', 'Input', function(Value)
    CustomName(Value)
end)

local CustomNameTextBox = MiscSection:CreateTextbox('Rank Tag', 'Input', function(Value)
    CustomRankTag(Value)
end)

-- # CREDITS
CreditsSection:CreateLabel('Scripted by: 0yxllxws')
CreditsSection:CreateLabel('Special Thanks to zCxsmic for making it work!')

-- // Functions
function CustomName(Text : string)
    if Player then
        if Player.Character then
            local Head = Player.Character:FindFirstChild('Head')
            if Head.NameTag then
                local NameTag = Head.NameTag
                NameTag.MainFrame.NameLabel.Text = Text
            end
        end
    end
end

function CustomRankTag(Text : string)
    if Player then
        if Player.Character then
            local Head = Player.Character:FindFirstChild('Head')
            if Head.RankTag then
                local RankTag = Head.RankTag
                RankTag.MainFrame.NameLabel.Text = Text
            end
        end
    end
end

function GunModHandler()
    local function EnableGunMods(tool)
        if tool:IsA("Tool") then
            local settingModule = tool:FindFirstChild("Setting")

            if settingModule and settingModule:IsA("ModuleScript") then
                local success, settings = pcall(require, settingModule)

                if success and type(settings) == "table" and settings.FireRate ~= nil then
                    if Variables.RapidFire then
                        print('rapid fire')
                        settings.Auto = true;
                        settings.FireRate = 0.015;
                    end
                    if Variables.MultipleBullet then
                        print('multi bullet')
                        settings.ShotgunEnabled = true;
                        settings.BulletPerShoot = 100;
                    end
                    if Variables.FastBullet then
                        print('fast bullet')
                        settings.BulletSpeed = 10000;
                    end
                    if Variables.QuickReload then
                        print('no reload')
                        settings.ReloadTime = 0;
                        settings.ReloadAnimationID = nil;
                        settings.ReloadAnimationSpeed = 1;
                    end
                    if Variables.NoSpread then
                        print('no spread')
                        settings.Accuracy = 1;
                        settings.SpreadX = 0;
                        settings.SpreadY = 0;
                    end
                    if Variables.NoJam then
                        print('no jam')
                        settings.JamChance = 0;
                    end
                    if Variables.UnlimitedRange then
                        print('no range')
                        settings.Range = 50000;
                    end
                    if Variables.NoRecoil then
                        print('no recoil')
                        settings.CameraRecoilingEnabled = false;
                        settings.Recoil = 0;
                    end
                    if Variables.UnlimitedAmmo then
                        print('unlimited ammo')
                        settings.LimitedAmmoEnabled = false;
                        settings.MaxAmmo = 69420911;
                        settings.Ammo = 69420911;
                    end
                    print('enabled mods')
                end
            else
                warn('Nebula Hook | No settings module.')
            end
        end
    end

    local function DetectTools(Character)
        Character.Head.RankTag.MainFrame.NameLabel.Text = "nebula.hook"
        Character.ChildAdded:Connect(function(Child)
            if Child:IsA("Tool") then
                EnableGunMods(Child)
            end
        end)

        for _, Child in ipairs(Character:GetChildren()) do
            if Child:IsA("Tool") then
                EnableGunMods(child)
            end
        end
    end

    if Player.Character then
        DetectTools(Player.Character)
    end

    Player.CharacterAdded:Connect(DetectTools)
end

function ESPThread(Bool : Bool)
    if Bool == true then
        for _, PlayerFromMemory in pairs(Players:GetChildren()) do
            if workspace.Characters:FindFirstChild(PlayerFromMemory.Name) then
                local CharacterFromMemory = workspace.Characters:FindFirstChild(PlayerFromMemory.Name)
                if not CharacterFromMemory:FindFirstChild('nebula_glow') then
                    local Highlight = Instance.new('Highlight')
                    Highlight.Name = "nebula_glow"
                    Highlight.Parent = CharacterFromMemory
                    Highlight.Adornee = CharacterFromMemory
                    Highlight.FillColor = Color3.fromRGB(140, 0, 255)
                end
            end
        end
    elseif Bool == false then
        for _, PlayerFromMemory in pairs(Players:GetChildren()) do
            if workspace.Characters:FindFirstChild(PlayerFromMemory.Name) then
                local CharacterFromMemory = workspace.Characters:FindFirstChild(PlayerFromMemory.Name)
                if CharacterFromMemory:FindFirstChild('nebula_glow') then
                    CharacterFromMemory:FindFirstChild('nebula_glow'):Destroy()
                end
            end
        end
    end
end

function InstantLootThread(Bool : Bool)
    if Bool == true then
        for _, Prompt in pairs(game:GetDescendants()) do
            if Prompt:IsA('ProximityPrompt') then
                Prompt.HoldDuration = 0
            end
        end
    end
end

GunModHandler()

-- // Aimbot
local FOVCircle = Drawing.new("Circle")
FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
FOVCircle.Radius = 500
FOVCircle.Filled = true
FOVCircle.Color = Color3.fromRGB(140,0,255)
FOVCircle.Visible = Variables.ShowAimbotFOV
FOVCircle.Radius = 500
FOVCircle.Transparency = 0
FOVCircle.Thickness = 0

local function GetClosestPlayer()
	local MaximumDistance = _G.CircleRadius
	local Target = nil

	for _, v in next, Players:GetPlayers() do
		if v.Name ~= LocalPlayer.Name then
			if v.Character ~= nil then
				if v.Character:FindFirstChild("HumanoidRootPart") ~= nil then
					if v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("Humanoid").Health ~= 0 then
						local ScreenPoint = Camera:WorldToScreenPoint(v.Character:WaitForChild("HumanoidRootPart", math.huge).Position)
						local VectorDistance = (Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2.new(ScreenPoint.X, ScreenPoint.Y)).Magnitude
								
						if VectorDistance < MaximumDistance then
							Target = v
						end
					end
				end
			else
				if v.Character ~= nil then
					if v.Character:FindFirstChild("HumanoidRootPart") ~= nil then
						if v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("Humanoid").Health ~= 0 then
							local ScreenPoint = Camera:WorldToScreenPoint(v.Character:WaitForChild("HumanoidRootPart", math.huge).Position)
							local VectorDistance = (Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2.new(ScreenPoint.X, ScreenPoint.Y)).Magnitude
							
							if VectorDistance < MaximumDistance then
								Target = v
							end
						end
					end
				end
			end
		end
	end

	return Target
end

UserInputService.InputBegan:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton2 then
        Holding = true
    end
end)

UserInputService.InputEnded:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton2 then
        Holding = false
    end
end)

RunService.RenderStepped:Connect(function()
    FOVCircle.Position = Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y)
    FOVCircle.Radius = 500
    FOVCircle.Filled = true
    FOVCircle.Color = Color3.fromRGB(140,0,255)
    FOVCircle.Visible = Variables.ShowAimbotFOV
    FOVCircle.Radius = 500
    FOVCircle.Transparency = 0
    FOVCircle.Thickness = 0 

    if Holding == true and Variables.Aimbot == true then
        TweenService:Create(Camera, TweenInfo.new(Variables.AimbotSmoothness, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {CFrame = CFrame.new(Camera.CFrame.Position, GetClosestPlayer().Character['Head'].Position)}):Play()
    end
end)

while task.wait(1) do
    ESPThread(Variables.GlowESP)
    InstantLootThread(Variables.InstantLoot)
end
