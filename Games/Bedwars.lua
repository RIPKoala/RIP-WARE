local UILib = loadstring(game:HttpGet("https://raw.githubusercontent.com/RIPKoala/RIP-WARE/main/UiLIbrary.lua"))()

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

local lplr = game.Players.LocalPlayer
local ItemTable = debug.getupvalue(require(game.ReplicatedStorage.TS.item["item-meta"]).getItemMeta, 1)
local InventoryUtil = require(game:GetService("ReplicatedStorage").TS.inventory["inventory-util"]).InventoryUtil
local howmuchihateblacks = math.huge

local IsAlive = function(blackmonkeyboy)
    blackmonkeyboy = blackmonkeyboy or lplr
    return blackmonkeyboy and tostring(blackmonkeyboy.Team) ~= 'Spectators' and blackmonkeyboy.Character ~= nil and blackmonkeyboy.Character:FindFirstChild('HumanoidRootPart') and blackmonkeyboy.Character:FindFirstChild("Humanoid") and blackmonkeyboy.Character.Humanoid.Health > 0 or false 
end

local GetInventory = function(blackboy)
    blackboy = blackboy or lplr
    return InventoryUtil.getInventory(blackboy)
end

local getRemoteName = function(black, index)
	local tableTargetted = debug.getconstants(black[index])
	local iSaved = nil
	for i, v in pairs(tableTargetted) do
		if v == 'Client' then iSaved = i+1 end
        if iSaved ~= nil then return tostring(tableTargetted[iSaved]) end
	end
    return nil
end

local GetBestSword = function()
    local dmg = 0
    local sword = nil
    for i, v in pairs(GetInventory().items) do
        if v.itemType:lower():find('sword') or v.itemType:lower():find('scythe') or v.itemType:lower():find('blade') then
            if ItemTable[v.itemType].sword.damage > dmg then
                sword = v.tool
            end
        end
    end
    return sword
end

local getScaffoldBlock = function()
    local Inventory = GetInventory()
    for i, v in pairs(Inventory.items) do
		if ItemTable[v.itemType].block ~= nil then return v.itemType end
    end
    return 'black'
end

local setToY = 0
local blackie = nil

local setMotionY = function(value, set)
    setToY = value
    if set then
        blackie = lplr.Character.Humanoid.Jumping:Connect(function(IsJumping)
            print(IsJumping)
            if IsJumping then
                print('jumped')
                lplr.Character.HumanoidRootPart.Velocity += Vector3.new(0, setToY*500, 0)
            end
        end)
    else
        if blackie ~= nil then blackie:Disconnect() end
    end
end

local ClientBlockEngine = require(lplr.PlayerScripts.TS.lib["block-engine"]["client-block-engine"]).ClientBlockEngine
local BlockBase = require(game:GetService("ReplicatedStorage")["rbxts_include"]["node_modules"]["@easy-games"]["block-engine"].out.client.placement["block-placer"]).BlockPlacer
local BlockUtils = require(game:GetService("ReplicatedStorage")["rbxts_include"]["node_modules"]["@easy-games"]["block-engine"].out).BlockEngine
local BlockController = BlockBase.new(ClientBlockEngine, getScaffoldBlock())

local returnScaffoldPosition = function(vector)
    return Vector3.new(vector.X/3, vector.Y/3, vector.Z/3)
end

local IsAllowedAtPosition = function(position)
    return BlockUtils:isAllowedPlacement(lplr, getScaffoldBlock(), Vector3.new(position.X, position.Y, position.Z))
end

local PlaceBlock = function(position)
    return BlockController:placeBlock(returnScaffoldPosition(position))
end

local HashVector = function(black)
    return {value = black}
end

local KnitClient = debug.getupvalue(require(lplr.PlayerScripts.TS.knit).setup, 6)
local Client = require(game:GetService("ReplicatedStorage").TS.remotes).default.Client
local HitRemoteName = getRemoteName(getmetatable(KnitClient.Controllers.SwordController), 'attackEntity')
local HitRemote = game:GetService("ReplicatedStorage")["rbxts_include"]["node_modules"]["@rbxts"].net.out._NetManaged[HitRemoteName]
local kbtable = debug.getupvalue(require(game:GetService("ReplicatedStorage").TS.damage["knockback-util"]).KnockbackUtil.calculateKnockbackVelocity, 1)

-- Combat

local RangeSlider = {Value = 18.5}
local tickblack = {Value = 0.112}
local enslaveMonkey = function(blackboy)
    if (tick() - KnitClient.Controllers.SwordController.lastAttack) < ItemTable[GetBestSword().Name].sword.attackSpeed then 
        return nil
    end
    HitRemote:FireServer({
        entityInstance = blackboy.Character,
        chargedAttack = {
            chargeRatio = 0,
        },
        validate = {
            raycast = {
                cameraPosition = HashVector(game.Workspace.Camera.CFrame.Position), 
                cursorDirection = HashVector(Ray.new(game.Workspace.Camera.CFrame.Position, blackboy.Character.HumanoidRootPart.Position).Unit.Direction)
            },
            selfPosition = HashVector(lplr.Character.HumanoidRootPart.Position + (((blackboy.Character.HumanoidRootPart.Position - lplr.Character.HumanoidRootPart.Position).magnitude) > 14 and CFrame.lookAt(lplr.Character.HumanoidRootPart.Position, blackboy.Character.HumanoidRootPart.Position).lookVector * 4 or Vector3.zero)),
            targetPosition = HashVector(blackboy.Character.HumanoidRootPart.Position),
        },
        weapon = GetBestSword(),
    })
    KnitClient.Controllers.SwordController.lastAttack = tick() - tickblack.Value
end

local KillAuraEnabled = false
local KillAura = Combat.MakeToggle({
    Name = 'KillAura',
    Callback = function(value) 
        KillAuraEnabled = value
        if KillAuraEnabled then
            task.spawn(function()
                repeat
                    task.wait()
                    if not KillAuraEnabled then break end
                    if IsAlive() then
                        for _, blackmonkey in pairs(game.Players:GetChildren()) do
                            if IsAlive(blackmonkey) then
                                if blackmonkey.Team ~= lplr.Team and v ~= lplr then
                                    local Distance = (blackmonkey.Character.HumanoidRootPart.Position - lplr.Character.HumanoidRootPart.Position).magnitude
                                    if Distance <= RangeSlider.Value then
                                        task.spawn(enslaveMonkey, blackmonkey)
                                        lplr.Character:SetPrimaryPartCFrame(CFrame.new(lplr.Character.HumanoidRootPart.Position, Vector3.new(blackmonkey.Character.HumanoidRootPart.Position.X, lplr.Character.HumanoidRootPart.Position.Y, blackmonkey.Character.HumanoidRootPart.Position.Z)))
                                    end
                                end
                            end
                        end
                    end
                until not KillAuraEnabled
            end)
        end
    end
})

RangeSlider = KillAura.MakeSlider({
    Name = "Range",
    Min = 1,
    Max = 18.5,
    Default = 18.5,
    Round = 1,
    Function = function() end
})

tickblack = KillAura.MakeSlider({
    Name = "Tick",
    Min = 0.1,
    Max = 0.2,
    Default = 0.112,
    Round = 3,
    Function = function() end
})

local VeloEnabled = false
local HorizontalVelocity = {Value = 0}
local VerticalVelocity = {Value = 0}
local VelocityToggle = Combat.MakeToggle({
    Name = 'Velocity',
    Callback = function(value)
        VeloEnabled = value
        if VeloEnabled then
            kbtable.kbDirectionStrength = HorizontalVelocity.Value
            kbtable.kbUpwardStrength = VerticalVelocity.Value
        else
            kbtable.kbDirectionStrength = 11750
            kbtable.kbUpwardStrength = 10000
        end
    end
})

HorizontalVelocity = VelocityToggle.MakeSlider({
    Name = "Horizontal",
    Min = 0,
    Max = 1,
    Default = 0,
    Round = 1,
    Function = function(value) 
        if VeloEnabled then
            kbtable.kbDirectionStrength = value * 11750
        end
    end
})

VerticalVelocity = VelocityToggle.MakeSlider({
    Name = "Vertical",
    Min = 0,
    Max = 1,
    Default = 0,
    Round = 1,
    Function = function(value)
        if VeloEnabled then
            kbtable.kbUpwardStrength = value * 10000
        end
    end
})

-- Movement

local black = {}
for i, v in pairs(game.Players:GetPlayers()) do
    table.insert(black, v.Character)
end

local RCParams = RaycastParams.new()
RCParams.FilterType = Enum.RaycastFilterType.Blacklist
RCParams.FilterDescendantsInstances = {black, game.Workspace.Camera}

local StepEnabled = false
local StepSlider = {Value = 50}
local SteppingUp = false
local SpeedToggle = Movement.MakeToggle({
    Name = 'Step',
    Callback = function(value)
        StepEnabled = value 
        if StepEnabled then
            task.spawn(function()
                repeat
                    task.wait()
                    if not StepEnabled then break end
                    if IsAlive() then
                        local StepRC = Workspace:Raycast(lplr.Character.HumanoidRootPart.Position, (lplr.Character.Humanoid.MoveDirection.Unit * 2) + Vector3.new(0, -2.5, 0), RCParams)
                        if SteppingUp and not StepRC then
                            lplr.Character.HumanoidRootPart.Velocity = Vector3.new(lplr.Character.HumanoidRootPart.Velocity.X, 0, lplr.Character.HumanoidRootPart.Velocity.Z)
                        end
                        if StepRC then
                            if not StepRC.Instance:IsDescendantOf(lplr.Character) and StepRC.Instance.Parent.Name ~= 'BedAlarmZones' and StepRC.Instance.Parent.Name ~= 'BalloonRoots' then
                                SteppingUp = true
                                lplr.Character.HumanoidRootPart.Velocity = Vector3.new(lplr.Character.HumanoidRootPart.Velocity.X, StepSlider.Value, lplr.Character.HumanoidRootPart.Velocity.Z)
                            end
                        else
                            SteppingUp = false
                        end    
                    end
                until not StepEnabled
            end)
        end
    end
})

StepSlider = SpeedToggle.MakeSlider({
    Name = 'Velocity',
    Min = 20,
    Max = 100,
    Default = 50,
    Round = 0,
    Function = function() end
})

local SpeedEnabled = false
local SpeedSlider = {Value = 7}
local SpeedToggle = Movement.MakeToggle({
    Name = 'Speed',
    Callback = function(value)
        SpeedEnabled = value 
        if SpeedEnabled then
            task.spawn(function()
                repeat
                    task.wait()
                    if not SpeedEnabled then break end
                    if IsAlive() then
                        local newVelocity = lplr.Character.Humanoid.MoveDirection * (SpeedSlider.Value * 3.34285714)
                        lplr.Character.HumanoidRootPart.Velocity = Vector3.new(newVelocity.X, lplr.Character.HumanoidRootPart.Velocity.Y, newVelocity.Z)    
                    end
                until not SpeedEnabled
            end)
        end
    end
})

SpeedSlider = SpeedToggle.MakeSlider({
    Name = 'BPS',
    Min = 1,
    Max = 7,
    Default = 7,
    Round = 1,
    Function = function() end
})

local SliderThing = {Value = 1}
local HighJump = {Toggle = function(bool) end} -- to fix error cuz highjump.toggle would be nil black issues yknow
HighJump = Movement.MakeToggle({
    Name = 'HighJump',
    Callback = function(value)
        task.spawn(function()
            setMotionY(SliderThing.Value, value)
            if value then
                local oldspeed = SpeedSlider.Value
                local oldws = lplr.Character.Humanoid.WalkSpeed
                lplr.Character.Humanoid.WalkSpeed = 0
                SpeedSlider.Value = 0
                task.wait(1)
                SpeedSlider.Value = oldspeed
                lplr.Character.Humanoid.WalkSpeed = oldws
                lplr.Character.Humanoid:ChangeState('Jumping')
                HighJump.Toggle(false)
            end
        end)
    end
})

SliderThing = HighJump.MakeSlider({
    Name = 'Velocity',
    Min = 0,
    Max = 1.5,
    Default = 1,
    Round = 1,
    Function = function(v) setToY = v end
})

local flynoBlackNig = false
local flyConnection1
local flyConnection1side
local flyConnection2
local flyConnection2side
local isgoingdownFly = false
local isgoingupFly = false
local flyVelocity = 2
local BPS = 0
local StartPosition = Vector3.zero
local ShowBPS = {Enabled = false}
local BPSEnabled = false
local BPSFrame = nil
Fly = Movement.MakeToggle({
    Name = 'Fly',
    Callback = function(v)
        FlyVal = v
        if FlyVal then
            StartPosition = lplr.Character.HumanoidRootPart.Position
            flyConnection1 = game:GetService('UserInputService').InputBegan:Connect(function(key)
                if key.KeyCode == Enum.KeyCode.LeftControl then
                    isgoingdownFly = true
                end
            end)
            flyConnection1side = game:GetService('UserInputService').InputEnded:Connect(function(key)
                if key.KeyCode == Enum.KeyCode.LeftControl then
                    isgoingdownFly = false
                end
            end)
            flyConnection2 = game:GetService('UserInputService').InputBegan:Connect(function(key)
                if key.KeyCode == Enum.KeyCode.Space then
                    isgoingupFly = true
                end
            end)
            flyConnection2side = game:GetService('UserInputService').InputEnded:Connect(function(key)
                if key.KeyCode == Enum.KeyCode.Space then
                    isgoingupFly = false
                end
            end)
            task.spawn(function()
                repeat
                    if not FlyVal then break end
                    task.wait()
                    if not isgoingdownFly and not isgoingupFly then
                        flyVelocity = 40
                        task.wait(0.3)
                        flyVelocity = -10
                        task.wait(0.7)
                    end
                until not FlyVal
            end)
            task.spawn(function()
                repeat
                    if not FlyVal then break end
                    task.wait()
                    if isgoingdownFly then
                        flyVelocity = -30
                    elseif isgoingupFly then
                        flyVelocity = 30
                    end
                    lplr.Character.HumanoidRootPart.Velocity = Vector3.new(lplr.Character.HumanoidRootPart.Velocity.X, flyVelocity, lplr.Character.HumanoidRootPart.Velocity.Z)
                until not FlyVal
            end)
        else
            flyConnection1:Disconnect()
            flyConnection1side:Disconnect()
            flyConnection2:Disconnect()
            flyConnection2side:Disconnect()
        end
    end
})

local bpsCalc = false
ShowBPS = Fly.MakeToggleOption({
    Name = 'ShowBPS',
    Callback = function(val)
        BPSEnabled = val
        if BPSEnabled then
            BPSFrame = Instance.new('Frame', shared.ClickGui)
            BPSFrame.Size = UDim2.new(1, 0, 1, 0)
            BPSFrame.Transparency = 1
            BPSFrame.BorderSizePixel = 0
            local uilistLayout = Instance.new('UIListLayout', BPSFrame)
            local TextLabel = Instance.new('TextLabel', BPSFrame)
            uilistLayout.HorizontalAlignment = 'Right'
            uilistLayout.VerticalAlignment = 'Bottom'
            TextLabel.Size = UDim2.new(0, 0, 0, 25)
            TextLabel.TextSize = 30
            TextLabel.Font = Enum.Font.SourceSans
            TextLabel.AutomaticSize = 'X'
            TextLabel.BackgroundTransparency = 1
            TextLabel.BorderSizePixel = 0
            TextLabel.TextColor3 = Color3.fromHSV(0, 0, 1)
            TextLabel.Text = 'BPS : 0 '
            task.spawn(function()
                repeat
                    task.wait(0.1)
                    if not BPSEnabled then break end
                    if FlyVal then 
                        task.wait(0.3)
                        local BPSCheck = math.floor((Vector3.new(StartPosition.X, 0, StartPosition.Z) - Vector3.new(lplr.Character.HumanoidRootPart.Position.X, 0, lplr.Character.HumanoidRootPart.Position.Z)).magnitude / 1.3)
                        BPS = BPSCheck
                        if BPSEnabled and BPSFrame ~= nil then
                            BPSFrame.TextLabel.Text = 'BPS : ' .. BPS .. ' '
                        end
                        StartPosition = lplr.Character.HumanoidRootPart.Position
                    else
                        BPSFrame.TextLabel.Text = 'BPS : 0 '
                    end
                until not BPSEnabled
            end)
        else
            BPSFrame:Destroy()
            BPSFrame = nil
        end
    end
})

-- Render

local RainbowColorBox = Color3.fromRGB(170,0,170)
local RainbowSpeedSlider = {Value = 2}
local RainbowEnabled = false
local function RainbowFunc()
    spawn(function()
        local x = 0
        repeat
            task.wait()
            if not RainbowEnabled then break end
            RainbowColorBox = Color3.fromHSV(x,0.6,1)
            x = x + RainbowSpeedSlider.Value/255
            if x >= 1 then
                x -= 1
            end
        until not RainbowEnabled
    end)
end

local swordHL = false
local highlight = nil
local highlight2 = nil
local highlightTransparency = {Value = 0.4}
local swordHighLight = Render.MakeToggle({
    Name = 'SwordHighlight',
    Callback = function(value)
        swordHL = value
        if swordHL then
            RainbowEnabled = true
            highlight = Instance.new('Highlight')
            highlight.Parent = workspace.Camera.Viewmodel[tostring(GetBestSword())].Handle
            highlight.FillTransparency = highlightTransparency.Value
            RainbowFunc()
            task.spawn(function()
                repeat
                    task.wait()
                    if not swordHL then break end
                    for i, v in pairs(workspace.Camera:GetChildren()) do
                        if v:FindFirstChild('Viewmodel') then
                            if v.Name:find('sword') or v.Name:find('scythe') or v.Name:find('blade') then
                                if not v.Handle:FindFirstChild('Highlight') then
                                    highlight = Instance.new('Highlight')
                                    highlight.Parent = v.Handle
                                    highlight.FillTransparency = highlightTransparency.Value
                                else
                                    highlight.FillTransparency = highlightTransparency.Value
                                    highlight.FillColor = RainbowColorBox    
                                end
                            end
                        end
                    end
                    for i, v in pairs(lplr.Character:GetChildren()) do
                        if v.Name:find('sword') or v.Name:find('scythe') or v.Name:find('blade') then
                            if not v.Handle:FindFirstChild('Highlight') then
                                highlight2 = Instance.new('Highlight')
                                highlight2.Parent = v.Handle
                                highlight2.FillTransparency = highlightTransparency.Value
                            else
                                highlight2.FillTransparency = highlightTransparency.Value
                                highlight2.FillColor = RainbowColorBox
                            end    
                        end
                    end
                until not swordHL
            end)
        else
            RainbowEnabled = false
            if highlight ~= nil then
                highlight:remove()
            end
            if highlight2 ~= nil then
                highlight2:remove()
            end
        end
    end
})

highlightTransparency = swordHighLight.MakeSlider({
    Name = 'Transparency',
    Min = 0,
    Max = 1,
    Default = 0.4,
    Round = 1,
    Function = function() end
})

RainbowSpeedSlider = swordHighLight.MakeSlider({
    Name = 'RainbowSpeed',
    Min = 1,
    Max = 20,
    Default = 2,
    Round = 0,
    Function = function() end
})

local TrailEnabled = false
local TrailInstance = nil
local TrailWidth = {Value = 0.04}
local TrailLifetime = {Value = 0.5}
local TrainMaxLength = {Value = 10}
local Trail = Render.MakeToggle({
    Name = 'Trail',
    Callback = function(value)
        TrailEnabled = value
        if TrailEnabled then
            if TrailInstance == nil then
                TrailInstance = Instance.new('Trail', lplr.Character)

                local attachment0 = Instance.new("Attachment")
                attachment0.Name = "Attachment0"
                attachment0.Parent = lplr.Character.HumanoidRootPart
                attachment0.Position = Vector3.new(-2, 0, 0)
                local attachment1 = Instance.new("Attachment")
                attachment1.Name = "Attachment1"
                attachment1.Parent = lplr.Character.HumanoidRootPart
                attachment1.Position = Vector3.new(2, 0, 0)

                TrailInstance.Attachment0 = attachment0
                TrailInstance.Attachment1 = attachment1
                TrailInstance.WidthScale = NumberSequence.new(TrailWidth.Value)
                TrailInstance.Lifetime = TrailLifetime.Value
                TrailInstance.MaxLength = TrainMaxLength.Value
                TrailInstance.Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0, Color3.fromHSV(0,0.6, 1)),
                    ColorSequenceKeypoint.new(0.25, Color3.fromHSV(0.25,0.6, 1)),
                    ColorSequenceKeypoint.new(0.5, Color3.fromHSV(0.5,0.6, 1)),
                    ColorSequenceKeypoint.new(0.75, Color3.fromHSV(0.75,0.6, 1)),
                    ColorSequenceKeypoint.new(1, Color3.fromHSV(1,0.6, 1))
                }
            end
        else
            if TrailInstance ~= nil then TrailInstance:Destroy() end
            TrailInstance = nil
        end
    end
})

TrailWidth = Trail.MakeSlider({
    Name = 'Width',
    Min = 0.01,
    Max = 1,
    Default = 0.04,
    Round = 2,
    Function = function(nigvalue) 
        if TrailInstance ~= nil and Trail.Enabled then
            TrailInstance.WidthScale = NumberSequence.new(nigvalue)
        end
    end 
})

TrainLifetime = Trail.MakeSlider({
    Name = 'Lifetime',
    Min = 0.1,
    Max = 20,
    Default = 20,
    Round = 1,
    Function = function(nigvalue) 
        if TrailInstance ~= nil and Trail.Enabled then
            TrailInstance.Lifetime = nigvalue
        end
    end
})

TrainMaxLength = Trail.MakeSlider({
    Name = 'MaxLength',
    Min = 1,
    Max = 50,
    Default = 10,
    Round = 0,
    Function = function(nigvalue)
        if TrailInstance ~= nil and Trail.Enabled then
            TrailInstance.MaxLength = nigvalue
        end
    end
})

-- Player

local NoFallEnabled = false
local NoFall = Player.MakeToggle({
    Name = 'NoFall',
    Callback = function(cb)
        NoFallEnabled = cb
        if NoFallEnabled then
            task.spawn(function()
                repeat
                    if not NoFallEnabled then break end
                    task.wait(0.4)
                    game:GetService("ReplicatedStorage").rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged.GroundHit:FireServer()
                until not NoFallEnabled
            end)
        end
    end
})

-- RektSky

local ArrayListEnabled = false
local nigger2 = loadstring(readfile('RektskyRoblox/ArrayList.lua'))()
local ArrayListBLack = RektSky.MakeToggle({
    Name = 'ArrayList',
    Callback = function(blackmonkeywatermelon)
        ArrayListEnabled = blackmonkeywatermelon
        if ArrayListEnabled then
            shared.nigger1 = nigger2.InitializeArray(true)
            for i, v in pairs(shared.TogglesBlackNIG) do
                if v.Enabled then
                    shared.nigger1.AddElement(v.Name)
                end
            end
        else
            shared.nigger1 = nigger2.InitializeArray(false)
        end
    end
})

-- World

local ScaffoldEnabled = false
local ExpendSlider = {Value = 3}
local Scaffold = World.MakeToggle({
    Name = 'Scaffold',
    Callback = function(cb)
        ScaffoldEnabled = cb
        if ScaffoldEnabled then
            task.spawn(function()
                repeat task.wait() if not ScaffoldEnabled then break end until getScaffoldBlock() ~= 'black'
                if not ScaffoldEnabled then return end
                BlockController = BlockBase.new(ClientBlockEngine, getScaffoldBlock())
                repeat
                    task.wait()
                    if not ScaffoldEnabled then break end
                    if IsAlive() and getScaffoldBlock() ~= 'black' then
                        for i = 1, ExpendSlider.Value do
                            local BlockPosition = lplr.Character.HumanoidRootPart.Position + (lplr.Character.Humanoid.MoveDirection * (i*2.5)) + Vector3.new(0, -math.floor(lplr.Character.Humanoid.HipHeight * 3), 0)
                            if IsAllowedAtPosition(BlockPosition) then
                                task.spawn(PlaceBlock, BlockPosition)
                            end
                        end
                    end
                until not ScaffoldEnabled
            end)
        end
    end
})

ExpendSlider = Scaffold.MakeSlider({
    Name = 'Blocks',
    Min = 1,
    Max = 10,
    Default = 3,
    Round = 0,
    Function = function() end,
})
