local ArrayListAPI = {}

local RainbowColorBox = Color3.fromRGB(255,0,0)
local RainbowSpeedSlider = {Value = 5}
shared.ArrayListElements = {}

local ArrayList = nil
local SharedAmount = {}

shared.nig = {}
local valueRainbow = 0
ArrayListAPI.StupidMONKEYBLACKARRAYLISTTHATTOOKME2HTOMAKENIGGER = function()
    task.spawn(function()
        repeat
            task.wait()
            valueRainbow += (0.2/255)
            if valueRainbow > 1 then
                valueRainbow = 0
            end    
        until shared.nigger1 == nil    
    end)
end

ArrayListAPI.CalculateLGBTQNigger = function(yPos, name)
    if shared.nig[name] == nil then
        shared.nig[name] = {calc = 0}
    end
    if yPos == 0 then yPos = 10 end
    shared.nig[name].calc = yPos/500 + valueRainbow
    if shared.nig[name].calc > 1 then
        shared.nig[name].calc = shared.nig[name].calc - 1
    end
    return Color3.fromHSV(shared.nig[name].calc, 0.6, 1)
end

ArrayListAPI.InitializeArray = function(bool)
    RainbowEnabled = bool
    if bool then
        local ArrayListAPI2 = {}

        ArrayList = Instance.new('ScreenGui', game.CoreGui)
        local UiList = Instance.new('UIListLayout', ArrayList)
        UiList.HorizontalAlignment = 'Right'
        local FrameTest = Instance.new('Frame', ArrayList)
        FrameTest.Transparency = 1
        FrameTest.AutomaticSize = 'XY'
        local UiListBLACK = Instance.new('UIListLayout', FrameTest)
        UiListBLACK.HorizontalAlignment = 'Right'
        UiListBLACK.SortOrder = 'LayoutOrder'

        ArrayListAPI.StupidMONKEYBLACKARRAYLISTTHATTOOKME2HTOMAKENIGGER()

        ArrayListAPI2.AddElement = function(name)
            local ArrayListAPI3 = {}

            local TextLabel = Instance.new('TextLabel', FrameTest)
            TextLabel.BorderSizePixel = 0
            TextLabel.BackgroundTransparency = 0.35
            TextLabel.BackgroundColor3 = Color3.fromRGB(0,0,0)
            TextLabel.TextColor3 = Color3.fromHSV(0, 0.4, 1)
            TextLabel.TextSize = 12
            TextLabel.Size = UDim2.new(0, 0, 0, 26)
            TextLabel.AutomaticSize = 'X'
            TextLabel.Text = '  ' .. name .. ' '
            local FrameTestBLACK = Instance.new('Frame', TextLabel)
            FrameTestBLACK.BorderSizePixel = 0
            FrameTestBLACK.Size = UDim2.new(0, 4, 0, 26)
            FrameTestBLACK.BackgroundColor3 = Color3.fromHSV(0, 0.4, 1)
            SharedAmount[name] = {Instance = TextLabel}
            TextLabel.LayoutOrder = TextLabel.AbsolutePosition.X

            task.spawn(function()
                repeat
                    task.wait()
                    if SharedAmount[name] == nil then break end
                    TextLabel.TextColor3 = ArrayListAPI.CalculateLGBTQNigger(TextLabel.AbsolutePosition.Y, name)
                    FrameTestBLACK.BackgroundColor3 = ArrayListAPI.CalculateLGBTQNigger(TextLabel.AbsolutePosition.Y, name)
                until SharedAmount[name] == nil
            end)


            return ArrayListAPI3
        end

        ArrayListAPI2.RemoveElement = function(name)
            SharedAmount[name].Instance:Destroy()
            SharedAmount[name] = nil
        end

        return ArrayListAPI2
    else
        SharedAmount = {}
        if ArrayList ~= nil then ArrayList:Destroy() end
        shared.nigger1 = nil
    end
end

return ArrayListAPI