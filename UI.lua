-- ZeyyMantic UI Library
-- Dibuat dengan style dan warna berbeda dari Flux
local ZeyyMantic = {RainbowColorValue = 0, HueSelectionPosition = 0}
local MainColor = Color3.fromRGB(155, 89, 182) -- Ungu
local AccentColor = Color3.fromRGB(46, 204, 113) -- Hijau
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local CloseBind = Enum.KeyCode.LeftAlt

local ZeyyGui = Instance.new("ScreenGui")
ZeyyGui.Name = "ZeyyManticUI"
ZeyyGui.Parent = game.CoreGui
ZeyyGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

coroutine.wrap(function()
    while wait() do
        ZeyyMantic.RainbowColorValue = ZeyyMantic.RainbowColorValue + 1 / 255
        ZeyyMantic.HueSelectionPosition = ZeyyMantic.HueSelectionPosition + 1
        if ZeyyMantic.RainbowColorValue >= 1 then
            ZeyyMantic.RainbowColorValue = 0
        end
        if ZeyyMantic.HueSelectionPosition == 80 then
            ZeyyMantic.HueSelectionPosition = 0
        end
    end
end)()

local function MakeDraggable(topbar, frame)
    local Dragging, DragInput, DragStart, StartPosition
    local function Update(input)
        local Delta = input.Position - DragStart
        frame.Position = UDim2.new(
            StartPosition.X.Scale,
            StartPosition.X.Offset + Delta.X,
            StartPosition.Y.Scale,
            StartPosition.Y.Offset + Delta.Y
        )
    end
    topbar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            Dragging = true
            DragStart = input.Position
            StartPosition = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    Dragging = false
                end
            end)
        end
    end)
    topbar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            DragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == DragInput and Dragging then
            Update(input)
        end
    end)
end

function ZeyyMantic:Window(title, subtitle, mainclr, toclose)
    CloseBind = toclose or Enum.KeyCode.LeftAlt
    MainColor = mainclr or MainColor
    local MainFrame = Instance.new("Frame")
    local MainCorner = Instance.new("UICorner")
    local TitleBar = Instance.new("Frame")
    local TitleLabel = Instance.new("TextLabel")
    local SubLabel = Instance.new("TextLabel")
    local TabHolder = Instance.new("Frame")
    local TabLayout = Instance.new("UIListLayout")
    local DragBar = Instance.new("Frame")
    local ContainerFolder = Instance.new("Folder")

    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ZeyyGui
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.BackgroundColor3 = MainColor
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainFrame.Size = UDim2.new(0, 720, 0, 500)
    MainFrame.BackgroundTransparency = 0.05
    MainFrame.BorderSizePixel = 0

    MainCorner.CornerRadius = UDim.new(0, 18)
    MainCorner.Parent = MainFrame

    TitleBar.Name = "TitleBar"
    TitleBar.Parent = MainFrame
    TitleBar.BackgroundColor3 = AccentColor
    TitleBar.Size = UDim2.new(1, 0, 0, 48)
    TitleBar.BorderSizePixel = 0

    TitleLabel.Name = "TitleLabel"
    TitleLabel.Parent = TitleBar
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Position = UDim2.new(0, 20, 0, 0)
    TitleLabel.Size = UDim2.new(0, 300, 1, 0)
    TitleLabel.Font = Enum.Font.FredokaOne
    TitleLabel.Text = title
    TitleLabel.TextColor3 = Color3.fromRGB(255,255,255)
    TitleLabel.TextSize = 28
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

    SubLabel.Name = "SubLabel"
    SubLabel.Parent = TitleBar
    SubLabel.BackgroundTransparency = 1
    SubLabel.Position = UDim2.new(0, 20, 0, 28)
    SubLabel.Size = UDim2.new(0, 300, 0, 20)
    SubLabel.Font = Enum.Font.Gotham
    SubLabel.Text = subtitle
    SubLabel.TextColor3 = Color3.fromRGB(220,220,220)
    SubLabel.TextSize = 14
    SubLabel.TextXAlignment = Enum.TextXAlignment.Left

    TabHolder.Name = "TabHolder"
    TabHolder.Parent = MainFrame
    TabHolder.BackgroundTransparency = 1
    TabHolder.Position = UDim2.new(0, 0, 0, 48)
    TabHolder.Size = UDim2.new(0, 180, 1, -48)

    TabLayout.Name = "TabLayout"
    TabLayout.Parent = TabHolder
    TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabLayout.Padding = UDim.new(0, 8)

    DragBar.Name = "DragBar"
    DragBar.Parent = TitleBar
    DragBar.BackgroundTransparency = 1
    DragBar.Size = UDim2.new(1, 0, 1, 0)

    ContainerFolder.Name = "ContainerFolder"
    ContainerFolder.Parent = MainFrame

    MakeDraggable(DragBar, MainFrame)

    -- Animasi show/hide
    local uitoggled = false
    UserInputService.InputBegan:Connect(function(io, p)
        if io.KeyCode == CloseBind then
            if uitoggled == false then
                MainFrame.Visible = false
                uitoggled = true
            else
                MainFrame.Visible = true
                uitoggled = false
            end
        end
    end)

    local Tabs = {}
    function Tabs:Tab(text, icon)
        local Tab = Instance.new("TextButton")
        local TabIcon = Instance.new("ImageLabel")
        local TabTitle = Instance.new("TextLabel")
        Tab.Name = "Tab"
        Tab.Parent = TabHolder
        Tab.BackgroundColor3 = AccentColor
        Tab.Size = UDim2.new(1, -16, 0, 40)
        Tab.AutoButtonColor = true
        Tab.Font = Enum.Font.FredokaOne
        Tab.Text = ""
        Tab.BackgroundTransparency = 0.15
        Tab.BorderSizePixel = 0

        TabIcon.Name = "TabIcon"
        TabIcon.Parent = Tab
        TabIcon.BackgroundTransparency = 1
        TabIcon.Position = UDim2.new(0, 10, 0.5, -12)
        TabIcon.Size = UDim2.new(0, 24, 0, 24)
        TabIcon.Image = icon or "rbxassetid://6031265976"

        TabTitle.Name = "TabTitle"
        TabTitle.Parent = Tab
        TabTitle.BackgroundTransparency = 1
        TabTitle.Position = UDim2.new(0, 44, 0, 0)
        TabTitle.Size = UDim2.new(1, -44, 1, 0)
        TabTitle.Font = Enum.Font.GothamBold
        TabTitle.Text = text
        TabTitle.TextColor3 = Color3.fromRGB(255,255,255)
        TabTitle.TextSize = 18
        TabTitle.TextXAlignment = Enum.TextXAlignment.Left

        local Container = Instance.new("ScrollingFrame")
        local ContainerLayout = Instance.new("UIListLayout")
        Container.Name = "Container"
        Container.Parent = ContainerFolder
        Container.Active = true
        Container.BackgroundTransparency = 1
        Container.Position = UDim2.new(0, 190, 0, 60)
        Container.Size = UDim2.new(1, -200, 1, -70)
        Container.CanvasSize = UDim2.new(0, 0, 0, 0)
        Container.ScrollBarThickness = 6
        Container.Visible = false
        Container.ScrollBarImageColor3 = MainColor
        ContainerLayout.Name = "ContainerLayout"
        ContainerLayout.Parent = Container
        ContainerLayout.SortOrder = Enum.SortOrder.LayoutOrder
        ContainerLayout.Padding = UDim.new(0, 12)

        -- Tab switching
        Tab.MouseButton1Click:Connect(function()
            for _, v in pairs(ContainerFolder:GetChildren()) do
                if v:IsA("ScrollingFrame") then
                    v.Visible = false
                end
            end
            Container.Visible = true
            for _, v in pairs(TabHolder:GetChildren()) do
                if v:IsA("TextButton") then
                    v.BackgroundTransparency = 0.15
                end
            end
            Tab.BackgroundTransparency = 0
        end)
        -- Tab pertama auto aktif
        if #TabHolder:GetChildren() == 2 then
            Tab.BackgroundTransparency = 0
            Container.Visible = true
        end
        local Content = {}
        function Content:Button(text, callback)
            local Btn = Instance.new("TextButton")
            Btn.Parent = Container
            Btn.BackgroundColor3 = MainColor
            Btn.Size = UDim2.new(1, 0, 0, 38)
            Btn.Font = Enum.Font.GothamBold
            Btn.Text = text
            Btn.TextColor3 = Color3.fromRGB(255,255,255)
            Btn.TextSize = 16
            Btn.AutoButtonColor = true
            Btn.BackgroundTransparency = 0.08
            Btn.BorderSizePixel = 0
            Btn.MouseButton1Click:Connect(function()
                pcall(callback)
            end)
        end
        function Content:Label(text)
            local Lbl = Instance.new("TextLabel")
            Lbl.Parent = Container
            Lbl.BackgroundTransparency = 1
            Lbl.Size = UDim2.new(1, 0, 0, 28)
            Lbl.Font = Enum.Font.Gotham
            Lbl.Text = text
            Lbl.TextColor3 = AccentColor
            Lbl.TextSize = 15
            Lbl.TextXAlignment = Enum.TextXAlignment.Left
        end
        -- Tambahkan komponen lain sesuai kebutuhan (Toggle, Slider, dsb)
        return Content
    end
    return Tabs
end
return ZeyyMantic 