local api1 = {}

local ClickGui = Instance.new('ScreenGui')
ClickGui.Parent = game.CoreGui
ClickGui.Enabled = true
shared.ClickGui = ClickGui
local lplr = game.Players.LocalPlayer

local getasset = (syn and getsynasset) or getcustomasset or function(black)
    print('your executor does not have custom assets')
end

playsound = function(id, volume) 
    local sound = Instance.new("Sound")
    sound.Parent = workspace
    sound.SoundId = id
    sound.PlayOnRemove = true 
    if volume then 
        sound.Volume = volume
    end
    sound:Destroy()
    return sound
end

local uis = game:GetService("UserInputService")
local input = game:GetService("UserInputService")
local ms = game.Players.LocalPlayer:GetMouse()
local ts = game:GetService("TweenService")
local tweens = {Notification = function(base)
    ts:Create(base, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {Position = UDim2.new(0.438, 0,0.053, 0)}):Play()
end}
local Background
shared.TogglesBlackNIG = {}
shared.nigger1 = nil
api1.CreateNotification = function(title, text, delay2, toggled)
    spawn(function()
        if ClickGui:FindFirstChild("Background") then ClickGui:FindFirstChild("Background"):Destroy() end
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(0, 100, 0, 115)
        frame.Position = UDim2.new(0.5, 0, 0, -115)
        frame.BorderSizePixel = 0
        frame.AnchorPoint = Vector2.new(0.5, 0)
        frame.BackgroundTransparency = 0.5
        frame.BackgroundColor3 = Color3.new(0, 0, 0)
        frame.Name = "Background"
        frame.Parent = ClickGui
        local frameborder = Instance.new("Frame")
        frameborder.Size = UDim2.new(1, 0, 0, 8)
        frameborder.BorderSizePixel = 0
        frameborder.BackgroundColor3 = (toggled and Color3.fromRGB(102, 205, 67) or Color3.fromRGB(205, 64, 78))
        frameborder.Parent = frame
        local frametitle = Instance.new("TextLabel")
        frametitle.Font = Enum.Font.SourceSans
        frametitle.BackgroundTransparency = 1
        frametitle.Position = UDim2.new(0, 0, 0, 30)
        frametitle.TextColor3 = (toggled and Color3.fromRGB(102, 205, 67) or Color3.fromRGB(205, 64, 78))
        frametitle.Size = UDim2.new(1, 0, 0, 28)
        frametitle.Text = "          "..title
        frametitle.TextSize = 24
        frametitle.TextXAlignment = Enum.TextXAlignment.Left
        frametitle.TextYAlignment = Enum.TextYAlignment.Top
        frametitle.Parent = frame
        local frametext = Instance.new("TextLabel")
        frametext.Font = Enum.Font.SourceSans
        frametext.BackgroundTransparency = 1
        frametext.Position = UDim2.new(0, 0, 0, 68)
        frametext.TextColor3 = Color3.new(1, 1, 1)
        frametext.Size = UDim2.new(1, 0, 0, 28)
        frametext.Text = "          "..text
        frametext.TextSize = 24
        frametext.TextXAlignment = Enum.TextXAlignment.Left
        frametext.TextYAlignment = Enum.TextYAlignment.Top
        frametext.Parent = frame
        local textsize = game:GetService("TextService"):GetTextSize(frametitle.Text, frametitle.TextSize, frametitle.Font, Vector2.new(100000, 100000))
        local textsize2 = game:GetService("TextService"):GetTextSize(frametext.Text, frametext.TextSize, frametext.Font, Vector2.new(100000, 100000))
        if textsize2.X > textsize.X then textsize = textsize2 end
        frame.Size = UDim2.new(0, textsize.X + 38, 0, 115)
        pcall(function()
            frame:TweenPosition(UDim2.new(0.5, 0, 0, 20), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.15)
            game:GetService("Debris"):AddItem(frame, delay2 + 0.15)
        end)
    end)
end

api1.CreateNotification("Loaded", "Press Right-Shift to toggle GUI", 3, true)

local HttpService = game:GetService('HttpService')

local ConfigLoaded = 0
local ConfigUsed = {}

if game.PlaceId == 6872274481 or game.PlaceId == 8560631822 or game.PlaceId == 8444591321 then
    ConfigLoaded = "BW"
else
    ConfigLoaded = game.PlaceId
end

if not isfolder('Moon') then
    makefolder('Moon') 
end

if not isfolder('Moon/cfg') then
    makefolder('Moon/cfg') 
end

local LoadConfig = function(black)
    local config = {}
    if isfile(black) then
        config = HttpService:JSONDecode(readfile(black))
    else
        writefile(black, HttpService:JSONEncode({}))
    end
    return config
end

local TableToJSON = function(NI)
    return HttpService:JSONEncode(NI)
end

ConfigUsed = LoadConfig("Moon/cfg/" .. ConfigLoaded .. '.json')

local window = {Visible = false}
api1.MakeWindow = function()
    local api2 = {}

    window = Instance.new('Frame')
    local layout = Instance.new('UIListLayout')
    window.Parent = ClickGui
    window.Position = UDim2.new(0, 6, 0, 6)
    window.Size = UDim2.new(0, 200, 0, 36)
    window.AutomaticSize = "X"
    window.Transparency = 1
    layout.Parent = window
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.FillDirection = "Horizontal"
    layout.Padding = UDim.new(0, 40)

    api2.MakeTab = function(info)
        local api3 = {}

        local name, tabcolor, iconPath = info.Name, info.Color, info.Icon
        local tab = Instance.new('Frame')
        local tabname = Instance.new('TextLabel')
        local tablayout = Instance.new('UIListLayout')
        local icon = Instance.new('ImageLabel')
        tab.Parent = window
        tab.Size = UDim2.new(0, 200, 0, 36)
        tab.BackgroundColor3 = Color3.fromRGB(36, 35, 51)
        tab.BorderSizePixel = 0
        tabname.Font = Enum.Font.SourceSans
        tabname.TextSize = 24
        tabname.Text = '  ' .. name
        tabname.Parent = tab
        tabname.BorderSizePixel = 0
        tabname.BackgroundTransparency = 1
        tabname.TextColor3 = tabcolor
        tabname.Size = UDim2.new(0, 200, 0, 36)
        tabname.TextXAlignment = "Left"
        tablayout.Parent = tabname
        tablayout.SortOrder = Enum.SortOrder.LayoutOrder
        icon.BackgroundTransparency = 1
        icon.Parent = tab
        icon.ScaleType = "Stretch"
        icon.Size = UDim2.new(0, 24, 0, 24)
        icon.Position = UDim2.new(0, 167, 0, 6)
        icon.Image = getasset('Moon/Assets/' .. iconPath .. '.png')
        local stupidthing = Instance.new('Frame')
        stupidthing.Parent = tabname
        stupidthing.Size = UDim2.new(0, 200, 0, 36)
        stupidthing.Transparency = 1

        if ConfigUsed[info.Name] == nil then
            ConfigUsed[info.Name] = {}
        end
        local tabName = info.Name

        api3.MakeToggle = function(info)
            local api4 = {Enabled = (ConfigUsed[tabName][info.Name] ~= nil and ConfigUsed[tabName][info.Name].Enabled) or false, Keybind = (ConfigUsed[tabName][info.Name] ~= nil and ConfigUsed[tabName][info.Name].Keybind) or 'NONE'}

            local name, callback = info.Name, info.Callback or function() end
            local toggle = Instance.new('TextButton')
            local togglename = Instance.new('TextLabel')
            toggle.Parent = tabname
            toggle.Size = UDim2.new(0, 200, 0, 36)
            toggle.BackgroundColor3 = Color3.fromRGB(35, 38, 35)
            toggle.BorderSizePixel = 0
            toggle.Text = ""
            toggle.AutoButtonColor = false
            togglename.Font = Enum.Font.SourceSans
            togglename.TextSize = 24
            togglename.Text = '  ' .. name
            togglename.Parent = toggle
            togglename.AutomaticSize = "XY"
            togglename.BorderSizePixel = 0
            togglename.BackgroundTransparency = 1
            togglename.TextColor3 = Color3.fromRGB(255, 255, 255)
            togglename.Position = UDim2.new(0, 0, 0, 5)
            togglename.TextXAlignment = "Left"
            shared.TogglesBlackNIG[info.Name] = {Enabled = api4.Enabled, Name = info.Name}
            local toggleOpt = {Visible = false}

            if ConfigUsed[tabName][info.Name] == nil then
                ConfigUsed[tabName][info.Name] = {Enabled = false, Keybind = 'NONE'}
            end
            local toggleName = info.Name

            api4.Toggle = function(bool)
                api4.Enabled = (bool ~= nil and bool) or not api4.Enabled
                if api4.Enabled then
                    spawn(function() callback(true) end)
                    playsound(getasset('Moon/Assets/enable.mp3'))
                    if toggleOpt.Visible then
                        togglename.TextColor3 = tabcolor
                    else
                        toggle.BackgroundColor3 = tabcolor
                        togglename.TextColor3 = Color3.fromRGB(255, 255, 255)
                    end
                    api1.CreateNotification(info.Name, 'Enabled ' .. info.Name, 3, true)
                    shared.TogglesBlackNIG[info.Name].Enabled = api4.Enabled
                    if shared.nigger1 ~= nil then
                        shared.nigger1.AddElement(info.Name)
                    end
                    if toggleOpt.Visible then
                        togglename.TextColor3 = tabcolor
                    end
                    ConfigUsed[tabName][info.Name].Enabled = true
                else
                    spawn(function() callback(false) end)
                    playsound(getasset('Moon/Assets/disable.mp3'))
                    toggle.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                    api1.CreateNotification(info.Name, 'Disabled ' .. info.Name, 3, false)
                    shared.TogglesBlackNIG[info.Name].Enabled = api4.Enabled
                    if shared.nigger1 ~= nil then
                        shared.nigger1.RemoveElement(info.Name)
                    end
                    if toggleOpt.Visible then
                        togglename.TextColor3 = Color3.fromRGB(255, 255, 255)
                    end
                    ConfigUsed[tabName][info.Name].Enabled = false
                end
            end

            api4.SilentToggle = function(bool)
                api4.Enabled = (bool ~= nil and bool) or not api4.Enabled
                if api4.Enabled then
                    spawn(function() callback(true) end)
                    if toggleOpt.Visible then
                        togglename.TextColor3 = tabcolor
                    else
                        toggle.BackgroundColor3 = tabcolor
                        togglename.TextColor3 = Color3.fromRGB(255, 255, 255)
                    end
                    shared.TogglesBlackNIG[info.Name].Enabled = api4.Enabled
                    if shared.nigger1 ~= nil then
                        shared.nigger1.AddElement(info.Name)
                    end
                    if toggleOpt.Visible then
                        togglename.TextColor3 = tabcolor
                    end
                    ConfigUsed[tabName][info.Name].Enabled = true
                else
                    spawn(function() callback(false) end)
                    toggle.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                    shared.TogglesBlackNIG[info.Name].Enabled = api4.Enabled
                    if shared.nigger1 ~= nil then
                        shared.nigger1.RemoveElement(info.Name)
                    end
                    if toggleOpt.Visible then
                        togglename.TextColor3 = Color3.fromRGB(255, 255, 255)
                    end
                    ConfigUsed[tabName][info.Name].Enabled = false
                end
            end

            toggle.MouseButton1Down:Connect(function()
                api4.Toggle()
            end)

            toggleOpt = Instance.new('Frame')
            local toggleOptBind = Instance.new('TextButton')
            local tOptLayout = Instance.new('UIListLayout')
            local stupid1 = Instance.new('Frame')
            local stupid2 = Instance.new('Frame')
            toggleOpt.Parent = tabname
            toggleOpt.Size = UDim2.new(0, 200, 0, 0)
            toggleOpt.BackgroundColor3 = Color3.fromRGB(42, 44, 64)
            toggleOpt.BorderSizePixel = 0
            toggleOpt.AutomaticSize = 'Y'
            toggleOpt.Visible = false
            toggleOptBind.Font = Enum.Font.SourceSans
            toggleOptBind.TextSize = 22
            toggleOptBind.Text = '   Bind ' .. api4.Keybind
            toggleOptBind.Parent = toggleOpt
            toggleOptBind.BorderSizePixel = 0
            toggleOptBind.BackgroundTransparency = 1
            toggleOptBind.TextColor3 = Color3.fromRGB(255, 255, 255)
            toggleOptBind.TextXAlignment = "Left"
            toggleOptBind.LayoutOrder = 999998
            toggleOptBind.Size = UDim2.new(0, 193, 0, 30)
            stupid1.Parent = toggleOpt
            stupid1.LayoutOrder = 999999
            stupid2.Parent = toggleOpt
            stupid2.LayoutOrder = -1
            tOptLayout.Parent = toggleOpt
            tOptLayout.SortOrder = Enum.SortOrder.LayoutOrder
            tOptLayout.FillDirection = "Vertical"
            tOptLayout.Padding = UDim.new(0, 10)
            tOptLayout.HorizontalAlignment = "Center"

            toggle.MouseButton2Down:Connect(function()
                toggleOpt.Visible = not toggleOpt.Visible
                if toggleOpt.Visible then
                    if api4.Enabled then
                        togglename.TextColor3 = tabcolor
                    else
                        togglename.TextColor3 = Color3.fromRGB(255, 255, 255)
                    end
                    toggle.BackgroundColor3 = Color3.fromRGB(24, 26, 23)
                else
                    if api4.Enabled then
                        toggle.BackgroundColor3 = tabcolor
                    else
                        toggle.BackgroundColor3 = Color3.fromRGB(35, 38, 35)
                    end
                    togglename.TextColor3 = Color3.fromRGB(255, 255, 255)
                end
            end)

            local conecthing = nil
            local registering = false

            conecthing = game:GetService('UserInputService').InputBegan:Connect(function(key)
                for _, bar in pairs(lplr.PlayerGui:WaitForChild('Chat'):GetDescendants()) do
                    if bar:IsA('TextBox') and bar.Name == 'ChatBar' then
                        if bar:IsFocused() then
                            return
                        end
                    end
                end
                if key.KeyCode ~= Enum.KeyCode.Unknown and key.KeyCode.Name == api4.Keybind and api4.Keybind ~= 'NONE' then
                    if not registering then
                        api4.Toggle()    
                    end
                end
            end)

            toggleOptBind.MouseButton1Down:Connect(function()
                toggleOptBind.Text = '   Bind ...'
                conecthing = game:GetService('UserInputService').InputBegan:Connect(function(key)
                    for _, bar in pairs(lplr.PlayerGui:WaitForChild('Chat'):GetDescendants()) do
                        if bar:IsA('TextBox') and bar.Name == 'ChatBar' then
                            if bar:IsFocused() then
                                return
                            end
                        end
                    end
                    registering = true
                    if key.KeyCode ~= Enum.KeyCode.Unknown and key.KeyCode.Name ~= api4.Keybind then
                        task.wait()
                        api4.Keybind = key.KeyCode.Name
                        toggleOptBind.Text = '   Bind ' .. api4.Keybind
                        ConfigUsed[tabName][info.Name].Keybind = api4.Keybind
                        conecthing:Disconnect()
                        registering = false
                    elseif key.KeyCode.Name == api4.Keybind then
                        task.wait()
                        api4.Keybind = 'NONE'
                        toggleOptBind.Text = '   Bind NONE'
                        ConfigUsed[tabName][info.Name].Keybind = 'NONE'
                        conecthing:Disconnect()
                        registering = false
                    end
                end)
            end)

            if ConfigUsed[tabName][info.Name].Enabled then
                api4.SilentToggle(true)
            end

            api4.MakeToggleOption = function(info)
                local api5 = {Enabled = (ConfigUsed[tabName][toggleName][info.Name] ~= nil and ConfigUsed[tabName][toggleName][info.Name].Enabled ~= nil and ConfigUsed[tabName][toggleName][info.Name].Enabled) or false}

                local toggleOptTO = Instance.new('TextButton')
                local toggleOptTO2 = Instance.new('TextButton')
                toggleOptTO.Font = Enum.Font.SourceSans
                toggleOptTO.TextSize = 22
                toggleOptTO.Text = '   ' .. info.Name
                toggleOptTO.Parent = toggleOpt
                toggleOptTO.BorderSizePixel = 0
                toggleOptTO.BackgroundTransparency = 1
                toggleOptTO.TextColor3 = Color3.fromRGB(255, 255, 255)
                toggleOptTO.TextXAlignment = "Left"
                toggleOptTO.AutoButtonColor = false
                toggleOptTO.Size = UDim2.new(0, 193, 0, 30)
                toggleOptTO2.Text = ""
                toggleOptTO2.Size = UDim2.new(0, 29, 0, 29)
                toggleOptTO2.Parent = toggleOptTO
                toggleOptTO2.Position = UDim2.new(0, 155, 0, 5)
                toggleOptTO2.AutoButtonColor = false
                toggleOptTO2.BorderSizePixel = 0
                toggleOptTO2.BackgroundColor3 = Color3.fromRGB(66, 68, 67)

                if ConfigUsed[tabName][toggleName][info.Name] == nil then
                    ConfigUsed[tabName][toggleName][info.Name] = {Enabled = false}
                end

                api5.Toggle = function(bool)
                    api5.Enabled = bool or not api5.Enabled
                    if api5.Enabled then
                        spawn(function() info.Callback(true) end)
                        toggleOptTO2.BackgroundColor3 = tabcolor
                        ConfigUsed[tabName][toggleName][info.Name].Enabled = true
                    else
                        spawn(function() info.Callback(false) end)
                        toggleOptTO2.BackgroundColor3 = Color3.fromRGB(66, 68, 67)
                        ConfigUsed[tabName][toggleName][info.Name].Enabled = false
                    end
                end

                toggleOptTO2.MouseButton1Down:Connect(function()
                    api5.Toggle()
                end)

                if ConfigUsed[tabName][toggleName][info.Name].Enabled then
                    api5.Toggle(true)
                end

                return api5
            end

            api4.MakeSlider = function(argstable)
                local api6 = {Value = (ConfigUsed[tabName][toggleName][argstable.Name] ~= nil and ConfigUsed[tabName][toggleName][argstable.Name].Value) or argstable.Default or argstable.Min or 0}

                local min, max, roundval = argstable.Min, argstable.Max, (argstable.Round or 2)
                local slider = Instance.new("TextButton")
                local slidertext = Instance.new("TextLabel")
                local slider2 = Instance.new("Frame")
                slider.Name = "slider"
                slider.Parent = toggleOpt
                slider.BackgroundColor3 = Color3.fromRGB(42, 44, 64)
                slider.BorderSizePixel = 0
                slider.Position = UDim2.new(0.083, 0, 0.109, 0)
                slider.Size = UDim2.new(0, 176, 0, 26)
                slider.Text = ""
                slider.AutoButtonColor = false
                slidertext.Name = "slidertext"
                slidertext.Parent = slider
                slidertext.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                slidertext.BackgroundTransparency = 1
                slidertext.BorderSizePixel = 0
                slidertext.Position = UDim2.new(0, 5, 0, -1)
                slidertext.Size = UDim2.new(0, 176, 0, 26)
                slidertext.ZIndex = 3
                slidertext.Font = Enum.Font.SourceSans
                slidertext.Text = ""
                slidertext.TextColor3 = Color3.fromRGB(255, 255, 255)
                slidertext.TextSize = 21
                slidertext.TextXAlignment = Enum.TextXAlignment.Left
                slider2.Name = "slider"
                slider2.Parent = slider
                slider2.BackgroundColor3 = tabcolor
                slider2.BorderSizePixel = 0
                slider2.Position = UDim2.new(0.0078, 0, -0.00825, 0)
                slider2.Size = UDim2.new(0, 0, 0, 34)
                slider2.ZIndex = 2

                if ConfigUsed[tabName][toggleName][argstable.Name] == nil then
                    ConfigUsed[tabName][toggleName][argstable.Name] = {Value = argstable.Default or argstable.Min or 0}
                end

                local mouse = game.Players.LocalPlayer:GetMouse()
                local function slide(input)
                    local sizeX = math.clamp((input.Position.X - slider.AbsolutePosition.X) / slider.AbsoluteSize.X, 0, 1)
                    slider2.Size = UDim2.new(sizeX, 0, 1, 0)
                    local value = math.floor(((((max - min) * sizeX) + min) * (10 ^ roundval)) +0.5)/(10 ^ roundval)
                    api6["Value"] = value
                    ConfigUsed[tabName][toggleName][argstable.Name].Value = value
                    slidertext.Text = argstable.Name..": "..tostring(value)
                    if not argstable["OnInputEnded"] then
                        argstable.Function(value)
                    end
                end
                local sliding
                slider.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        sliding = true
                        slide(input)
                    end
                end)

                slider.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        if argstable["OnInputEnded"] then
                            argstable.Function(api6api6.Value)
                        end
                        sliding = false
                    end
                end)

                game:GetService('UserInputService').InputChanged:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseMovement then
                        if sliding then
                            slide(input)
                        end
                    end
                end)

                api6["Set"] = function(value)
                    local value = math.floor((math.clamp(value, min, max) * (10^roundval))+0.5)/(10^roundval)
                    api6["Value"] = value
                    slider2.Size = UDim2.new((value - min) / (max - min), 0, 1, 0)
                    slidertext.Text = argstable.Name..": "..tostring(value)
                    argstable.Function(value)
                end

                api6.Set(api6["Value"])

                return api6
            end
            
            return api4
        end

        return api3
    end

    return api2
end

api1.ToggleGui = function()
    window.Visible = not window.Visible
end

api1.ToggleGui()

game:GetService('UserInputService').InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightShift then
        api1.ToggleGui()
    end
end)

shared.configSaving = true
task.spawn(function()
    repeat
        task.wait(6)
        if not shared.configSaving then break end
        writefile('Moon/cfg/' .. ConfigLoaded .. '.json', HttpService:JSONEncode(ConfigUsed))
    until not shared.configSaving
end)

return api1