getgenv().OpenKeybind = getgenv().OpenKeybind or "RightShift"

local Players      = game:GetService("Players")
local UIS          = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService   = game:GetService("RunService")

local player    = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local BLUE     = Color3.fromRGB(80, 180, 255)
local BG       = Color3.fromRGB(13, 21, 26)
local ITEM_BG  = Color3.fromRGB(18, 28, 34)
local TEXT_COL = Color3.fromRGB(255, 255, 255)
local SUB_COL  = Color3.fromRGB(160, 185, 200)
local ITEM_H   = 32

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent         = playerGui
ScreenGui.Name           = "WizardryLib"
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn   = false

local NotificationHolder = Instance.new("Frame")
NotificationHolder.Parent             = ScreenGui
NotificationHolder.Name               = "NotificationHolder"
NotificationHolder.AnchorPoint        = Vector2.new(1, 1)
NotificationHolder.Position           = UDim2.new(1, -10, 1, -10)
NotificationHolder.Size               = UDim2.new(0, 280, 1, -20)
NotificationHolder.BackgroundTransparency = 1
NotificationHolder.BorderSizePixel    = 0
NotificationHolder.ZIndex             = 100

local NotifLayout = Instance.new("UIListLayout")
NotifLayout.Parent             = NotificationHolder
NotifLayout.FillDirection      = Enum.FillDirection.Vertical
NotifLayout.VerticalAlignment  = Enum.VerticalAlignment.Bottom
NotifLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
NotifLayout.SortOrder          = Enum.SortOrder.LayoutOrder
NotifLayout.Padding            = UDim.new(0, 6)

local _notifCount = 0
local function Notify(title, content, duration)
    duration = duration or 4
    _notifCount += 1
    local order = _notifCount
    local Card = Instance.new("Frame")
    Card.Name            = "Notif_"..order
    Card.LayoutOrder     = order
    Card.Size            = UDim2.new(1, 0, 0, 58)
    Card.BackgroundColor3 = Color3.fromRGB(18, 28, 34)
    Card.BorderSizePixel = 0
    Card.ZIndex          = 100
    Card.AnchorPoint     = Vector2.new(1, 0)
    Card.Position        = UDim2.new(1, 280, 0, 0)
    Card.Parent          = NotificationHolder

    local st = Instance.new("UIStroke")
    st.Parent          = Card
    st.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    st.Color           = Color3.fromRGB(40, 60, 75)
    st.Thickness       = 1

    local acc = Instance.new("Frame")
    acc.Parent          = Card
    acc.Size            = UDim2.new(0, 3, 1, -12)
    acc.Position        = UDim2.new(0, 6, 0, 6)
    acc.BackgroundColor3 = BLUE
    acc.BorderSizePixel = 0
    acc.ZIndex          = 101

    local tl = Instance.new("TextLabel")
    tl.Parent             = Card
    tl.Position           = UDim2.new(0, 16, 0, 6)
    tl.Size               = UDim2.new(1, -20, 0, 20)
    tl.BackgroundTransparency = 1
    tl.BorderSizePixel    = 0
    tl.ZIndex             = 101
    tl.Text               = title
    tl.RichText           = true
    tl.TextColor3         = TEXT_COL
    tl.TextSize           = 13
    tl.TextXAlignment     = Enum.TextXAlignment.Left
    tl.Font               = Enum.Font.GothamBold
    tl.TextTruncate       = Enum.TextTruncate.AtEnd

    local cl = Instance.new("TextLabel")
    cl.Parent             = Card
    cl.Position           = UDim2.new(0, 16, 0, 28)
    cl.Size               = UDim2.new(1, -20, 0, 24)
    cl.BackgroundTransparency = 1
    cl.BorderSizePixel    = 0
    cl.ZIndex             = 101
    cl.Text               = content
    cl.TextColor3         = Color3.fromRGB(180, 200, 215)
    cl.TextSize           = 12
    cl.TextXAlignment     = Enum.TextXAlignment.Left
    cl.Font               = Enum.Font.Gotham
    cl.TextWrapped        = true

    local pbg = Instance.new("Frame")
    pbg.Parent          = Card
    pbg.Position        = UDim2.new(0, 0, 1, -3)
    pbg.Size            = UDim2.new(1, 0, 0, 3)
    pbg.BackgroundColor3 = Color3.fromRGB(30, 45, 55)
    pbg.BorderSizePixel = 0
    pbg.ZIndex          = 101

    local pf = Instance.new("Frame")
    pf.Parent          = pbg
    pf.Size            = UDim2.new(1, 0, 1, 0)
    pf.BackgroundColor3 = BLUE
    pf.BorderSizePixel = 0
    pf.ZIndex          = 102

    local si = TweenService:Create(Card, TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = UDim2.new(0,0,0,0)})
    si:Play()
    local pt = TweenService:Create(pf, TweenInfo.new(duration, Enum.EasingStyle.Linear), {Size = UDim2.new(0,0,1,0)})
    si.Completed:Connect(function() pt:Play() end)
    task.delay(duration, function()
        local so = TweenService:Create(Card, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {Position = UDim2.new(1,20,0,0)})
        so:Play()
        so.Completed:Connect(function() Card:Destroy() end)
    end)
end

local Watermark = Instance.new("Frame")
Watermark.Parent          = ScreenGui
Watermark.Name            = "Watermark"
Watermark.AnchorPoint     = Vector2.new(0, 0)
Watermark.Position        = UDim2.new(0.03125, 0, 0.1, 0)
Watermark.Size            = UDim2.new(0, 100, 0, 25)
Watermark.BackgroundColor3 = BG
Watermark.BorderSizePixel = 0
Watermark.ZIndex          = 1

local wmImg = Instance.new("ImageLabel")
wmImg.Parent              = Watermark
wmImg.AnchorPoint         = Vector2.new(0.5, 0.5)
wmImg.Position            = UDim2.new(0.87, 0, 0.5, 0)
wmImg.Size                = UDim2.new(0, 25, 0, 25)
wmImg.BackgroundTransparency = 1
wmImg.BorderSizePixel     = 0
wmImg.ZIndex              = 2
wmImg.Image               = "rbxassetid://98557818351504"

local wmText = Instance.new("TextLabel")
wmText.Parent             = Watermark
wmText.AnchorPoint        = Vector2.new(0.5, 0.5)
wmText.Position           = UDim2.new(0.3725, 0, 0.5, 0)
wmText.Size               = UDim2.new(0, 74, 0, 50)
wmText.BackgroundTransparency = 1
wmText.BorderSizePixel    = 0
wmText.ZIndex             = 2
wmText.Text               = 'wizardry<font color="rgb(80,180,255)">.lol</font>'
wmText.TextColor3         = TEXT_COL
wmText.TextSize           = 14
wmText.RichText           = true
wmText.FontFace           = Font.new("rbxasset://fonts/families/Arial.json")

UIS.InputBegan:Connect(function(input, gp)
    if gp then return end
    local ok, key = pcall(function() return Enum.KeyCode[getgenv().OpenKeybind or "RightShift"] end)
    if ok and key and input.KeyCode == key then
        for _, gui in ipairs(ScreenGui:GetChildren()) do
            if gui:IsA("Frame") and gui.Name:sub(1,7) == "Window_" then
                gui.Visible = not gui.Visible
            end
        end
    end
end)

local WizardryLib = {}
local windowCount  = 0

local function corner(parent, radius)
    local c = Instance.new("UICorner")
    c.Parent       = parent
    c.CornerRadius = UDim.new(0, radius or 4)
    return c
end

local function stroke(parent, thickness, color)
    local s = Instance.new("UIStroke")
    s.Parent          = parent
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    s.Thickness       = thickness or 1
    s.Color           = color or Color3.fromRGB(40, 60, 75)
    return s
end

local function baseItem(scroll, height)
    local f = Instance.new("Frame")
    f.Parent          = scroll
    f.LayoutOrder     = scroll:FindFirstChild("UIListLayout") and (#scroll:GetChildren()) or 0
    f.Size            = UDim2.new(1, 0, 0, height or ITEM_H)
    f.BackgroundColor3 = ITEM_BG
    f.BorderSizePixel = 0
    f.ZIndex          = scroll.ZIndex + 1
    corner(f, 4)
    return f
end

function WizardryLib:MakeWindow(config)
    config = config or {}
    windowCount += 1

    local winName   = config.Name or "Window"
    local winW      = config.Width  or 300
    local winH      = config.Height or 340
    local winPos    = config.Position or UDim2.new(0.5 + (windowCount-1)*0.02, (windowCount-1)*30, 0.5, 0)
    local tabs      = {}
    local tabFrames = {}
    local tabBtns   = {}
    local currentTab = nil

    local Holder = Instance.new("Frame")
    Holder.Parent          = ScreenGui
    Holder.Name            = "Window_"..windowCount
    Holder.AnchorPoint     = Vector2.new(0.5, 0.5)
    Holder.Position        = winPos
    Holder.Size            = UDim2.new(0, winW, 0, winH)
    Holder.BackgroundColor3 = BG
    Holder.BorderSizePixel = 0
    Holder.ZIndex          = 2 + windowCount
    Holder.Visible         = true

    local TopBar = Instance.new("Frame")
    TopBar.Parent             = Holder
    TopBar.Name               = "TopBar"
    TopBar.Size               = UDim2.new(1, 0, 0, 25)
    TopBar.Position           = UDim2.new(0, 0, 0, 0)
    TopBar.BackgroundColor3   = Color3.fromRGB(10, 17, 22)
    TopBar.BorderSizePixel    = 0
    TopBar.ZIndex             = 3

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Parent             = TopBar
    TitleLabel.AnchorPoint        = Vector2.new(0, 0.5)
    TitleLabel.Position           = UDim2.new(0, 8, 0.5, 0)
    TitleLabel.Size               = UDim2.new(1, -60, 1, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.BorderSizePixel    = 0
    TitleLabel.ZIndex             = 4
    TitleLabel.Text               = winName
    TitleLabel.TextColor3         = TEXT_COL
    TitleLabel.TextSize           = 16
    TitleLabel.TextWrapped        = true
    TitleLabel.TextXAlignment     = Enum.TextXAlignment.Left
    TitleLabel.RichText           = true
    TitleLabel.FontFace           = Font.new("rbxasset://fonts/families/Arial.json")

    local MinBtn = Instance.new("TextButton")
    MinBtn.Parent          = TopBar
    MinBtn.AnchorPoint     = Vector2.new(0.5, 0.5)
    MinBtn.Position        = UDim2.new(1, -30, 0.5, 0)
    MinBtn.Size            = UDim2.new(0, 13, 0, 13)
    MinBtn.BackgroundColor3 = Color3.fromRGB(255, 220, 0)
    MinBtn.BorderSizePixel = 0
    MinBtn.ZIndex          = 5
    MinBtn.Text            = ""
    MinBtn.FontFace        = Font.new("rbxasset://fonts/families/SourceSansPro.json")
    corner(MinBtn, 64)
    stroke(MinBtn, 2)
    MinBtn.MouseButton1Click:Connect(function() Holder.Visible = false end)

    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Parent          = TopBar
    CloseBtn.AnchorPoint     = Vector2.new(0.5, 0.5)
    CloseBtn.Position        = UDim2.new(1, -12, 0.5, 0)
    CloseBtn.Size            = UDim2.new(0, 13, 0, 13)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    CloseBtn.BorderSizePixel = 0
    CloseBtn.ZIndex          = 5
    CloseBtn.Text            = ""
    CloseBtn.FontFace        = Font.new("rbxasset://fonts/families/SourceSansPro.json")
    corner(CloseBtn, 64)
    stroke(CloseBtn, 2)
    CloseBtn.MouseButton1Click:Connect(function()
        if config.CloseCallback then config.CloseCallback() end
        ScreenGui:Destroy()
    end)

    local Mouse = player:GetMouse()
    local dragHovered = false
    local dragHolding = false
    local dragMoveCon = nil
    local dragInitX, dragInitY, dragInitPos

    TopBar.MouseEnter:Connect(function() dragHovered = true end)
    TopBar.MouseLeave:Connect(function() dragHovered = false end)

    UIS.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 and dragHovered then
            dragHolding = true
            dragInitX   = Mouse.X
            dragInitY   = Mouse.Y
            dragInitPos = Holder.Position
            dragMoveCon = Mouse.Move:Connect(function()
                if not dragHolding then dragMoveCon:Disconnect(); return end
                local dx = dragInitX - Mouse.X
                local dy = dragInitY - Mouse.Y
                Holder.Position = dragInitPos - UDim2.new(0, dx, 0, dy)
            end)
        end
    end)

    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragHolding = false
        end
    end)

    local TabBar = Instance.new("Frame")
    TabBar.Parent             = Holder
    TabBar.Position           = UDim2.new(0, 0, 0, 25)
    TabBar.Size               = UDim2.new(1, 0, 0, 25)
    TabBar.BackgroundTransparency = 1
    TabBar.BorderSizePixel    = 0
    TabBar.ZIndex             = 3

    local TAB_W = 100
    local Selector = Instance.new("Frame")
    Selector.Parent          = Holder
    Selector.Size            = UDim2.new(0, math.floor((TAB_W - 20) * 0.6), 0, 2)
    Selector.Position        = UDim2.new(0, 26, 0, 48)
    Selector.BackgroundColor3 = TEXT_COL
    Selector.BorderSizePixel = 0
    Selector.ZIndex          = 5
    corner(Selector, 32)

    local ContentArea = Instance.new("Frame")
    ContentArea.Parent             = Holder
    ContentArea.Position           = UDim2.new(0, 0, 0, 50)
    ContentArea.Size               = UDim2.new(1, 0, 1, -50)
    ContentArea.BackgroundTransparency = 1
    ContentArea.BorderSizePixel    = 0
    ContentArea.ZIndex             = 3

    local Window = {}

    local function selectTab(idx)
        currentTab = idx
        for i, f in ipairs(tabFrames) do
            f.Visible = i == idx
        end
        local sx = (idx - 1) * TAB_W + 26
        TweenService:Create(Selector, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
            {Position = UDim2.new(0, sx, 0, 48)}):Play()
    end

    function Window:MakeTab(tabConfig)
        tabConfig = tabConfig or {}
        local tabName = tabConfig.Name or "Tab"
        local tabIdx  = #tabs + 1

        local tabW = math.floor(winW / math.max(1, tabIdx))

        local btn = Instance.new("TextButton")
        btn.Parent             = TabBar
        btn.Position           = UDim2.new(0, (tabIdx - 1) * TAB_W, 0, 0)
        btn.Size               = UDim2.new(0, TAB_W, 1, 0)
        btn.BackgroundTransparency = 1
        btn.BorderSizePixel    = 0
        btn.Text               = tabName
        btn.TextColor3         = TEXT_COL
        btn.TextSize           = 13
        btn.Font               = Enum.Font.Gotham
        btn.ZIndex             = 4

        local page = Instance.new("Frame")
        page.Parent             = ContentArea
        page.Size               = UDim2.new(1, 0, 1, 0)
        page.BackgroundTransparency = 1
        page.BorderSizePixel    = 0
        page.ZIndex             = 3
        page.Visible            = false

        local scroll = Instance.new("ScrollingFrame")
        scroll.Parent                = page
        scroll.Size                  = UDim2.new(1, 0, 1, 0)
        scroll.BackgroundTransparency = 1
        scroll.BorderSizePixel       = 0
        scroll.ScrollBarThickness    = 3
        scroll.ScrollBarImageColor3  = BLUE
        scroll.CanvasSize            = UDim2.new(0, 0, 0, 0)
        scroll.AutomaticCanvasSize   = Enum.AutomaticSize.Y
        scroll.ZIndex                = 4

        local layout = Instance.new("UIListLayout")
        layout.Parent        = scroll
        layout.FillDirection = Enum.FillDirection.Vertical
        layout.SortOrder     = Enum.SortOrder.LayoutOrder
        layout.Padding       = UDim.new(0, 4)

        local pad = Instance.new("UIPadding")
        pad.Parent       = scroll
        pad.PaddingTop   = UDim.new(0, 6)
        pad.PaddingLeft  = UDim.new(0, 8)
        pad.PaddingRight = UDim.new(0, 8)

        tabs[tabIdx]      = tabName
        tabFrames[tabIdx] = page
        tabBtns[tabIdx]   = btn

        btn.MouseButton1Click:Connect(function() selectTab(tabIdx) end)

        if tabIdx == 1 then
            task.defer(function() selectTab(1) end)
        end

        local Tab = {}
        local itemOrder = 0
        local function nextOrder() itemOrder += 1; return itemOrder end

        local function item(h)
            local f = Instance.new("Frame")
            f.Parent          = scroll
            f.LayoutOrder     = nextOrder()
            f.Size            = UDim2.new(1, 0, 0, h or ITEM_H)
            f.BackgroundColor3 = ITEM_BG
            f.BorderSizePixel = 0
            f.ZIndex          = 5
            corner(f, 4)
            return f
        end

        function Tab:AddText(cfg)
            cfg = cfg or {}
            local text = cfg.Text or ""
            local f = item(24)
            f.BackgroundTransparency = 1
            local lbl = Instance.new("TextLabel")
            lbl.Parent             = f
            lbl.Size               = UDim2.new(1, -10, 1, 0)
            lbl.Position           = UDim2.new(0, 10, 0, 0)
            lbl.BackgroundTransparency = 1
            lbl.BorderSizePixel    = 0
            lbl.ZIndex             = 6
            lbl.Text               = text
            lbl.RichText           = true
            lbl.TextColor3         = cfg.Color == "white" and TEXT_COL or SUB_COL
            lbl.TextSize           = cfg.Size or 12
            lbl.TextXAlignment     = Enum.TextXAlignment.Left
            lbl.TextWrapped        = true
            lbl.Font               = Enum.Font.Gotham
            return lbl
        end

        function Tab:AddButton(cfg)
            cfg = cfg or {}
            local f = item(ITEM_H)
            local acc = Instance.new("Frame")
            acc.Parent          = f
            acc.Size            = UDim2.new(0, 2, 0.6, 0)
            acc.Position        = UDim2.new(0, 0, 0.2, 0)
            acc.BackgroundColor3 = BLUE
            acc.BorderSizePixel = 0
            acc.ZIndex          = 6
            corner(acc, 2)
            local btn2 = Instance.new("TextButton")
            btn2.Parent             = f
            btn2.Size               = UDim2.new(1, 0, 1, 0)
            btn2.BackgroundTransparency = 1
            btn2.BorderSizePixel    = 0
            btn2.ZIndex             = 7
            btn2.Text               = cfg.Name or "Button"
            btn2.TextColor3         = TEXT_COL
            btn2.TextSize           = 13
            btn2.Font               = Enum.Font.GothamBold
            btn2.MouseButton1Click:Connect(function()
                TweenService:Create(f, TweenInfo.new(0.08), {BackgroundColor3 = Color3.fromRGB(25,40,50)}):Play()
                task.delay(0.08, function()
                    TweenService:Create(f, TweenInfo.new(0.15), {BackgroundColor3 = ITEM_BG}):Play()
                end)
                if cfg.Callback then cfg.Callback() end
            end)
            return btn2
        end

        function Tab:AddToggle(cfg)
            cfg = cfg or {}
            local state = cfg.Default or false
            local f = item(ITEM_H)
            local lbl = Instance.new("TextLabel")
            lbl.Parent             = f
            lbl.Size               = UDim2.new(1, -52, 1, 0)
            lbl.Position           = UDim2.new(0, 10, 0, 0)
            lbl.BackgroundTransparency = 1
            lbl.BorderSizePixel    = 0
            lbl.ZIndex             = 6
            lbl.Text               = cfg.Name or "Toggle"
            lbl.TextColor3         = TEXT_COL
            lbl.TextSize           = 13
            lbl.TextXAlignment     = Enum.TextXAlignment.Left
            lbl.Font               = Enum.Font.Gotham
            local track = Instance.new("Frame")
            track.Parent          = f
            track.Size            = UDim2.new(0, 32, 0, 16)
            track.Position        = UDim2.new(1, -40, 0.5, -8)
            track.BackgroundColor3 = Color3.fromRGB(35, 50, 60)
            track.BorderSizePixel = 0
            track.ZIndex          = 6
            corner(track, 8)
            local knob = Instance.new("Frame")
            knob.Parent          = track
            knob.Size            = UDim2.new(0, 12, 0, 12)
            knob.Position        = UDim2.new(0, 2, 0.5, -6)
            knob.BackgroundColor3 = SUB_COL
            knob.BorderSizePixel = 0
            knob.ZIndex          = 7
            corner(knob, 6)
            local function updateVisual()
                if state then
                    TweenService:Create(track, TweenInfo.new(0.15), {BackgroundColor3 = BLUE}):Play()
                    TweenService:Create(knob,  TweenInfo.new(0.15), {Position = UDim2.new(0,18,0.5,-6), BackgroundColor3 = TEXT_COL}):Play()
                else
                    TweenService:Create(track, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(35,50,60)}):Play()
                    TweenService:Create(knob,  TweenInfo.new(0.15), {Position = UDim2.new(0,2,0.5,-6), BackgroundColor3 = SUB_COL}):Play()
                end
            end
            updateVisual()
            local hitbox = Instance.new("TextButton")
            hitbox.Parent             = f
            hitbox.Size               = UDim2.new(1, 0, 1, 0)
            hitbox.BackgroundTransparency = 1
            hitbox.BorderSizePixel    = 0
            hitbox.ZIndex             = 8
            hitbox.Text               = ""
            hitbox.MouseButton1Click:Connect(function()
                state = not state
                updateVisual()
                if cfg.Callback then cfg.Callback(state) end
            end)
            return {
                GetValue = function() return state end,
                SetValue = function(v) state = v; updateVisual() end
            }
        end

        function Tab:AddDropdown(cfg)
            cfg = cfg or {}
            local options  = cfg.Options or {}
            local selected = cfg.Default or options[1]
            local open     = false
            local OPTION_H = 26
            local CLOSED_H = ITEM_H
            local totalH   = CLOSED_H + #options * OPTION_H

            local wrapper = Instance.new("Frame")
            wrapper.Parent             = scroll
            wrapper.LayoutOrder        = nextOrder()
            wrapper.Size               = UDim2.new(1, 0, 0, CLOSED_H)
            wrapper.BackgroundTransparency = 1
            wrapper.BorderSizePixel    = 0
            wrapper.ZIndex             = 5
            wrapper.ClipsDescendants   = true

            local header = Instance.new("Frame")
            header.Parent          = wrapper
            header.Size            = UDim2.new(1, 0, 0, CLOSED_H)
            header.BackgroundColor3 = ITEM_BG
            header.BorderSizePixel = 0
            header.ZIndex          = 6
            corner(header, 4)

            local nameLbl = Instance.new("TextLabel")
            nameLbl.Parent             = header
            nameLbl.Size               = UDim2.new(1, -92, 1, 0)
            nameLbl.Position           = UDim2.new(0, 10, 0, 0)
            nameLbl.BackgroundTransparency = 1
            nameLbl.BorderSizePixel    = 0
            nameLbl.ZIndex             = 7
            nameLbl.Text               = cfg.Name or "Dropdown"
            nameLbl.TextColor3         = TEXT_COL
            nameLbl.TextSize           = 13
            nameLbl.TextXAlignment     = Enum.TextXAlignment.Left
            nameLbl.Font               = Enum.Font.Gotham

            local valLbl = Instance.new("TextLabel")
            valLbl.Parent             = header
            valLbl.Size               = UDim2.new(0, 80, 1, 0)
            valLbl.Position           = UDim2.new(1, -88, 0, 0)
            valLbl.BackgroundTransparency = 1
            valLbl.BorderSizePixel    = 0
            valLbl.ZIndex             = 7
            valLbl.Text               = (selected or "") .. " ▾"
            valLbl.TextColor3         = BLUE
            valLbl.TextSize           = 12
            valLbl.TextXAlignment     = Enum.TextXAlignment.Right
            valLbl.Font               = Enum.Font.Gotham

            local optList = Instance.new("Frame")
            optList.Parent          = wrapper
            optList.Position        = UDim2.new(0, 0, 0, CLOSED_H + 2)
            optList.Size            = UDim2.new(1, 0, 0, #options * OPTION_H)
            optList.BackgroundColor3 = Color3.fromRGB(16, 26, 32)
            optList.BorderSizePixel = 0
            optList.ZIndex          = 6
            corner(optList, 4)

            local ol = Instance.new("UIListLayout")
            ol.Parent    = optList
            ol.SortOrder = Enum.SortOrder.LayoutOrder
            ol.Padding   = UDim.new(0, 0)

            for i, opt in ipairs(options) do
                local ob = Instance.new("TextButton")
                ob.Parent             = optList
                ob.LayoutOrder        = i
                ob.Size               = UDim2.new(1, 0, 0, OPTION_H)
                ob.BackgroundTransparency = 1
                ob.BorderSizePixel    = 0
                ob.ZIndex             = 8
                ob.Text               = opt
                ob.TextColor3         = opt == selected and BLUE or SUB_COL
                ob.TextSize           = 12
                ob.Font               = Enum.Font.Gotham
                ob.MouseButton1Click:Connect(function()
                    selected = opt
                    valLbl.Text = selected .. " ▾"
                    for _, child in ipairs(optList:GetChildren()) do
                        if child:IsA("TextButton") then
                            child.TextColor3 = child.Text == selected and BLUE or SUB_COL
                        end
                    end
                    open = false
                    TweenService:Create(wrapper, TweenInfo.new(0.18, Enum.EasingStyle.Quint), {Size = UDim2.new(1,0,0,CLOSED_H)}):Play()
                    if cfg.Callback then cfg.Callback(selected) end
                end)
            end

            local hbtn = Instance.new("TextButton")
            hbtn.Parent             = header
            hbtn.Size               = UDim2.new(1, 0, 1, 0)
            hbtn.BackgroundTransparency = 1
            hbtn.BorderSizePixel    = 0
            hbtn.ZIndex             = 9
            hbtn.Text               = ""
            hbtn.MouseButton1Click:Connect(function()
                open = not open
                TweenService:Create(wrapper, TweenInfo.new(0.18, Enum.EasingStyle.Quint),
                    {Size = UDim2.new(1,0,0, open and totalH or CLOSED_H)}):Play()
            end)

            return {
                GetValue = function() return selected end,
                SetValue = function(v)
                    selected = v
                    valLbl.Text = v .. " ▾"
                end
            }
        end

        function Tab:AddSlider(cfg)
            cfg = cfg or {}
            local min     = cfg.Min     or 0
            local max     = cfg.Max     or 100
            local default = cfg.Default or min
            local suffix  = cfg.Suffix  or ""
            local value   = math.clamp(default, min, max)

            local f = item(46)

            local topRow = Instance.new("Frame")
            topRow.Parent             = f
            topRow.Size               = UDim2.new(1, -10, 0, 18)
            topRow.Position           = UDim2.new(0, 6, 0, 4)
            topRow.BackgroundTransparency = 1
            topRow.BorderSizePixel    = 0
            topRow.ZIndex             = 6

            local nameLbl2 = Instance.new("TextLabel")
            nameLbl2.Parent             = topRow
            nameLbl2.Size               = UDim2.new(0.7, 0, 1, 0)
            nameLbl2.BackgroundTransparency = 1
            nameLbl2.BorderSizePixel    = 0
            nameLbl2.ZIndex             = 7
            nameLbl2.Text               = cfg.Name or "Slider"
            nameLbl2.TextColor3         = TEXT_COL
            nameLbl2.TextSize           = 13
            nameLbl2.TextXAlignment     = Enum.TextXAlignment.Left
            nameLbl2.Font               = Enum.Font.Gotham

            local valDisp = Instance.new("TextLabel")
            valDisp.Parent             = topRow
            valDisp.Size               = UDim2.new(0.3, 0, 1, 0)
            valDisp.Position           = UDim2.new(0.7, 0, 0, 0)
            valDisp.BackgroundTransparency = 1
            valDisp.BorderSizePixel    = 0
            valDisp.ZIndex             = 7
            valDisp.Text               = tostring(value) .. suffix
            valDisp.TextColor3         = BLUE
            valDisp.TextSize           = 12
            valDisp.TextXAlignment     = Enum.TextXAlignment.Right
            valDisp.Font               = Enum.Font.Gotham

            local track = Instance.new("Frame")
            track.Parent          = f
            track.Size            = UDim2.new(1, -16, 0, 6)
            track.Position        = UDim2.new(0, 8, 0, 30)
            track.BackgroundColor3 = Color3.fromRGB(30, 45, 55)
            track.BorderSizePixel = 0
            track.ZIndex          = 6
            corner(track, 3)

            local fill = Instance.new("Frame")
            fill.Parent          = track
            fill.Size            = UDim2.new((value - min) / (max - min), 0, 1, 0)
            fill.BackgroundColor3 = BLUE
            fill.BorderSizePixel = 0
            fill.ZIndex          = 7
            corner(fill, 3)

            local knob = Instance.new("Frame")
            knob.Parent          = track
            knob.Size            = UDim2.new(0, 12, 0, 12)
            knob.AnchorPoint     = Vector2.new(0.5, 0.5)
            knob.Position        = UDim2.new((value - min) / (max - min), 0, 0.5, 0)
            knob.BackgroundColor3 = TEXT_COL
            knob.BorderSizePixel = 0
            knob.ZIndex          = 8
            corner(knob, 6)

            local dragging = false

            local function updateFromX(absX)
                local rel = math.clamp((absX - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
                local stepped = cfg.Step and (math.round(rel * (max - min) / cfg.Step) * cfg.Step) or (rel * (max - min))
                value = math.clamp(math.round(min + stepped), min, max)
                local pct = (value - min) / (max - min)
                fill.Size     = UDim2.new(pct, 0, 1, 0)
                knob.Position = UDim2.new(pct, 0, 0.5, 0)
                valDisp.Text  = tostring(value) .. suffix
                if cfg.Callback then cfg.Callback(value) end
            end

            local hitbox = Instance.new("TextButton")
            hitbox.Parent             = track
            hitbox.Size               = UDim2.new(1, 0, 3, -6)
            hitbox.Position           = UDim2.new(0, 0, 0.5, -10)
            hitbox.BackgroundTransparency = 1
            hitbox.BorderSizePixel    = 0
            hitbox.ZIndex             = 9
            hitbox.Text               = ""
            hitbox.MouseButton1Down:Connect(function(x)
                dragging = true
                updateFromX(x)
            end)

            UIS.InputChanged:Connect(function(input)
                if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                    updateFromX(input.Position.X)
                end
            end)
            UIS.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = false
                end
            end)

            return {
                GetValue = function() return value end,
                SetValue = function(v)
                    value = math.clamp(v, min, max)
                    local pct = (value - min) / (max - min)
                    fill.Size     = UDim2.new(pct, 0, 1, 0)
                    knob.Position = UDim2.new(pct, 0, 0.5, 0)
                    valDisp.Text  = tostring(value) .. suffix
                end
            }
        end

        function Tab:AddInput(cfg)
            cfg = cfg or {}
            local f = item(46)

            local nameLbl3 = Instance.new("TextLabel")
            nameLbl3.Parent             = f
            nameLbl3.Size               = UDim2.new(1, -10, 0, 18)
            nameLbl3.Position           = UDim2.new(0, 8, 0, 4)
            nameLbl3.BackgroundTransparency = 1
            nameLbl3.BorderSizePixel    = 0
            nameLbl3.ZIndex             = 6
            nameLbl3.Text               = cfg.Name or "Input"
            nameLbl3.TextColor3         = TEXT_COL
            nameLbl3.TextSize           = 13
            nameLbl3.TextXAlignment     = Enum.TextXAlignment.Left
            nameLbl3.Font               = Enum.Font.Gotham

            local inputBG = Instance.new("Frame")
            inputBG.Parent          = f
            inputBG.Size            = UDim2.new(1, -16, 0, 18)
            inputBG.Position        = UDim2.new(0, 8, 0, 24)
            inputBG.BackgroundColor3 = Color3.fromRGB(10, 17, 21)
            inputBG.BorderSizePixel = 0
            inputBG.ZIndex          = 6
            corner(inputBG, 3)
            stroke(inputBG, 1, Color3.fromRGB(40, 60, 75))

            local box = Instance.new("TextBox")
            box.Parent             = inputBG
            box.Size               = UDim2.new(1, -8, 1, 0)
            box.Position           = UDim2.new(0, 4, 0, 0)
            box.BackgroundTransparency = 1
            box.BorderSizePixel    = 0
            box.ZIndex             = 7
            box.Text               = cfg.Default or ""
            box.PlaceholderText    = cfg.Placeholder or "type here..."
            box.TextColor3         = TEXT_COL
            box.PlaceholderColor3  = SUB_COL
            box.TextSize           = 12
            box.Font               = Enum.Font.Gotham
            box.TextXAlignment     = Enum.TextXAlignment.Left
            box.ClearTextOnFocus   = cfg.ClearOnFocus ~= false and true or false

            box.FocusLost:Connect(function(enter)
                if cfg.Callback then cfg.Callback(box.Text, enter) end
                stroke(inputBG, 1, Color3.fromRGB(40, 60, 75))
            end)
            box.Focused:Connect(function()
                stroke(inputBG, 1, BLUE)
            end)

            return {
                GetValue = function() return box.Text end,
                SetValue = function(v) box.Text = v end
            }
        end

        return Tab
    end

    return Window
end

local _fakemodules = {}
local req = require
local require = function(obj)
    local fake = _fakemodules[obj]
    if fake then return fake() end
    return req(obj)
end

local Win1 = WizardryLib:MakeWindow({
    Name     = 'wizardry<font color="rgb(80,180,255)">.lol</font>',
    Width    = 300,
    Height   = 340,
    Position = UDim2.new(0.5, 0, 0.5, 0),
})

local MainTab = Win1:MakeTab({Name = "main"})
MainTab:AddText({Text = "configure stuff below"})
MainTab:AddButton({Name = "click me", Callback = function()
    Notify('wizardry<font color="rgb(80,180,255)">.lol</font>', "button clicked!", 3)
end})
MainTab:AddToggle({Name = "some toggle", Default = false, Callback = function(v)
    Notify('wizardry<font color="rgb(80,180,255)">.lol</font>', "toggle: " .. tostring(v), 2)
end})
MainTab:AddSlider({Name = "speed", Min = 0, Max = 100, Default = 50, Suffix = "%", Callback = function(v)
end})
MainTab:AddDropdown({Name = "pick option", Options = {"option 1","option 2","option 3"}, Callback = function(v)
    Notify('wizardry<font color="rgb(80,180,255)">.lol</font>', "selected: "..v, 2)
end})
MainTab:AddInput({Name = "player name", Placeholder = "enter name...", Callback = function(v, enter)
    if enter then
        Notify('wizardry<font color="rgb(80,180,255)">.lol</font>', "input: "..v, 2)
    end
end})

local SettingsTab = Win1:MakeTab({Name = "settings"})
SettingsTab:AddText({Text = "settings"})
SettingsTab:AddToggle({Name = "setting a", Default = true})
SettingsTab:AddToggle({Name = "setting b", Default = false})
SettingsTab:AddSlider({Name = "fov", Min = 60, Max = 120, Default = 90, Suffix = "°"})
SettingsTab:AddDropdown({Name = "theme", Options = {"dark","darker","darkest"}})
SettingsTab:AddInput({Name = "keybind", Placeholder = "e.g. RightShift", Callback = function(v, enter)
    if enter and v ~= "" then getgenv().OpenKeybind = v end
end})

local CreditsTab = Win1:MakeTab({Name = "credits"})
CreditsTab:AddText({Text = 'made by wizardry<font color="rgb(80,180,255)">.lol</font>', Color = "white"})
CreditsTab:AddButton({Name = "discord", Callback = function()
    setclipboard("https://discord.gg/pTKuVPnqE3")
    Notify('wizardry<font color="rgb(80,180,255)">.lol</font>', "discord link copied to clipboard!", 3)
end})
CreditsTab:AddButton({Name = "website", Callback = function()
    setclipboard("https://wizardry.lol/")
    Notify('wizardry<font color="rgb(80,180,255)">.lol</font>', "website link copied to clipboard!", 3)
end})

Notify('wizardry<font color="rgb(80,180,255)">.lol</font>', "loaded. press [".. (getgenv().OpenKeybind or "RightShift") .."] to toggle.", 5)
