local UILib = loadstring(readfile('RektskyRoblox/UiLibrary.lua'))()

local window = UILib.MakeWindow()

local Combat = window.MakeTab({
    Name = 'Combat',
    Color = Color3.fromRGB(250, 61, 59),
    Icon = 'combat'
})

local Movement = window.MakeTab({
    Name = 'Movement',
    Color = Color3.fromRGB(254, 150, 39),
    Icon = 'movement'
})

local Render = window.MakeTab({
    Name = 'Render',
    Color = Color3.fromRGB(59, 170, 223),
    Icon = 'render'
})

local Player = window.MakeTab({
    Name = 'Player',
    Color = Color3.fromRGB(84, 216, 106),
    Icon = 'player'
})

local Exploits = window.MakeTab({
    Name = 'Exploits',
    Color = Color3.fromRGB(159, 38, 37),
    Icon = 'exploit'
})

local RektSky = window.MakeTab({
    Name = 'RektSky',
    Color = Color3.fromRGB(59, 126, 250),
    Icon = 'rektsky'
})

local World = window.MakeTab({
    Name = 'World',
    Color = Color3.fromRGB(84, 59, 250),
    Icon = 'world'
})

local UtilityFunctions = {
    IsAlive = function(blackmonkeyboy)
        blackmonkeyboy = lplr or blackmonkeyboy
        local alive = false
        if blackmonkeyboy and blackmonkeyboy.Character then
            if blackmonkeyboy.Character.PrimaryPart and blackmonkeyboy.Character:FindFirstChild('HumanoidRootPart') and blackmonkeyboy.Character:FindFirstChild('Humanoid') then
                if blackmonkeyboy.Character:FindFirstChild('Humanoid').Health > 0 then
                    alive = true
                end
            end
        end
        return alive
    end,
}

local lplr = game.Players.LocalPlayer

local black = Combat.MakeToggle({
    Name = 'black',
    Callback = function() end
})

local SpeedEnabled = false
local SpeedSlider = {Value = 21}
local SpeedToggle = Movement.MakeToggle({
    Name = 'Speed',
    Callback = function(value)
        SpeedEnabled = value 
        if SpeedEnabled then
            spawn(function()
                repeat
                    task.wait()
                    if not SpeedEnabled then break end
                    if lplr.Character.Humanoid.MoveDirection.Magnitude > 0 and isnetworkowner(lplr.Character.HumanoidRootPart) then
                        print('a')
                        lplr.Character:TranslateBy((lplr.Character.Humanoid.MoveDirection * SpeedSlider.Value) / 100)
                    end
                until not SpeedEnabled
            end)
        end
    end
})

SpeedSlider = SpeedToggle.MakeSlider({
    Name = 'Speed',
    Min = 1,
    Max = 40,
    Default = 21,
    Round = 2,
    Function = function() end
})