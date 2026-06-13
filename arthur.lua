-- ============================================
-- ARTHUR'S UNIVERSAL SCRIPT v3.0
-- ESP + SPEED HACK + AIMBOT
-- ============================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local Camera = workspace.CurrentCamera

repeat task.wait() until LocalPlayer and LocalPlayer.PlayerGui

-- ============================================
-- CONFIGURAÇÕES
-- ============================================
local Settings = {
    -- VISUAL
    ESP_Master = true,
    ESP_Box = true,
    ESP_Tracer = true,
    ESP_Name = true,
    ESP_Health = true,
    
    -- MOVE
    SpeedHack = false,
    SpeedValue = 16,
    SpeedMultiplier = 3,
    
    -- AIM
    Aimbot = false,
    Aimbot_FOV = 200,
    Aimbot_Smooth = 5,
}

-- ============================================
-- CORES
-- ============================================
local Theme = {
    Background = Color3.fromRGB(15, 15, 20),
    Secondary = Color3.fromRGB(25, 25, 32),
    Accent = Color3.fromRGB(0, 180, 255),
    Text = Color3.fromRGB(255, 255, 255),
    Green = Color3.fromRGB(55, 255, 55),
    Red = Color3.fromRGB(255, 55, 55),
    Border = Color3.fromRGB(45, 45, 52),
}

-- ============================================
-- GUI
-- ============================================
local gui = Instance.new("ScreenGui")
gui.Name = "ArthursScript"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.DisplayOrder = 999
gui.Parent = LocalPlayer.PlayerGui

local ESPGui = Instance.new("Frame")
ESPGui.Name = "ESP_Container"
ESPGui.Size = UDim2.new(1, 0, 1, 0)
ESPGui.BackgroundTransparency = 1
ESPGui.ZIndex = 1
ESPGui.Parent = gui

-- Botão Flutuante
local FloatButton = Instance.new("TextButton")
FloatButton.Size = UDim2.new(0, 50, 0, 50)
FloatButton.Position = UDim2.new(0, 20, 0.5, -25)
FloatButton.BackgroundColor3 = Theme.Accent
FloatButton.BorderSizePixel = 0
FloatButton.Text = "⚡"
FloatButton.TextSize = 26
FloatButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FloatButton.AutoButtonColor = false
FloatButton.ZIndex = 10
FloatButton.Parent = gui
Instance.new("UICorner", FloatButton).CornerRadius = UDim.new(1, 0)

-- Painel
local MainPanel = Instance.new("Frame")
MainPanel.Size = UDim2.new(0, 280, 0, 350)
MainPanel.Position = UDim2.new(0.5, -140, 0.5, -175)
MainPanel.BackgroundColor3 = Theme.Background
MainPanel.BorderSizePixel = 0
MainPanel.Visible = false
MainPanel.ZIndex = 5
MainPanel.Parent = gui
Instance.new("UICorner", MainPanel).CornerRadius = UDim.new(0, 10)
local ps = Instance.new("UIStroke", MainPanel)
ps.Thickness = 1.5
ps.Color = Theme.Border

-- Título
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 38)
TitleBar.BackgroundColor3 = Theme.Secondary
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainPanel
Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 10)

local tcover = Instance.new("Frame")
tcover.Size = UDim2.new(1, 0, 0.5, 0)
tcover.Position = UDim2.new(0, 0, 0.5, 0)
tcover.BackgroundColor3 = Theme.Secondary
tcover.BorderSizePixel = 0
tcover.Parent = TitleBar

local TitleText = Instance.new("TextLabel")
TitleText.Size = UDim2.new(1, -45, 1, 0)
TitleText.Position = UDim2.new(0, 12, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.TextColor3 = Theme.Accent
TitleText.Font = Enum.Font.SourceSansBold
TitleText.TextSize = 14
TitleText.Text = "ARTHUR'S UNIVERSAL"
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Parent = TitleBar

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 28, 0, 28)
CloseButton.Position = UDim2.new(1, -33, 0, 5)
CloseButton.BackgroundColor3 = Theme.Red
CloseButton.BorderSizePixel = 0
CloseButton.Text = "✕"
CloseButton.TextSize = 16
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.AutoButtonColor = false
CloseButton.Parent = TitleBar
Instance.new("UICorner", CloseButton).CornerRadius = UDim.new(1, 0)

-- Abas
local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(1, 0, 0, 32)
TabContainer.Position = UDim2.new(0, 0, 0, 38)
TabContainer.BackgroundColor3 = Theme.Secondary
TabContainer.BorderSizePixel = 0
TabContainer.Parent = MainPanel

local function CreateTabButton(name, key, position, isActive)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.33, -2, 1, -4)
    btn.Position = UDim2.new(position, 1, 0, 2)
    btn.BackgroundColor3 = isActive and Theme.Accent or Color3.fromRGB(40, 40, 48)
    btn.BorderSizePixel = 0
    btn.Text = name
    btn.TextSize = 11
    btn.TextColor3 = Theme.Text
    btn.Font = Enum.Font.SourceSansBold
    btn.AutoButtonColor = false
    btn.Name = key
    btn.Parent = TabContainer
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 5)
    return btn
end

local TabAim = CreateTabButton("🎯 AIM", "AIM", 0, true)
local TabVisual = CreateTabButton("👁️ VISUAL", "VISUAL", 0.33, false)
local TabMove = CreateTabButton("🏃 MOVE", "MOVE", 0.66, false)

-- Conteúdo
local ContentArea = Instance.new("ScrollingFrame")
ContentArea.Size = UDim2.new(1, -20, 1, -80)
ContentArea.Position = UDim2.new(0, 10, 0, 75)
ContentArea.BackgroundTransparency = 1
ContentArea.BorderSizePixel = 0
ContentArea.ScrollBarThickness = 4
ContentArea.ScrollBarImageColor3 = Theme.Accent
ContentArea.CanvasSize = UDim2.new(0, 0, 0, 300)
ContentArea.Parent = MainPanel
Instance.new("UIListLayout", ContentArea).Padding = UDim.new(0, 4)

-- Frames das abas
local AimFrame = Instance.new("Frame")
AimFrame.Name = "AIM"
AimFrame.Size = UDim2.new(1, 0, 0, 200)
AimFrame.BackgroundTransparency = 1
AimFrame.Visible = true
AimFrame.Parent = ContentArea
Instance.new("UIListLayout", AimFrame).Padding = UDim.new(0, 3)

local VisualFrame = Instance.new("Frame")
VisualFrame.Name = "VISUAL"
VisualFrame.Size = UDim2.new(1, 0, 0, 200)
VisualFrame.BackgroundTransparency = 1
VisualFrame.Visible = false
VisualFrame.Parent = ContentArea
Instance.new("UIListLayout", VisualFrame).Padding = UDim.new(0, 3)

local MoveFrame = Instance.new("Frame")
MoveFrame.Name = "MOVE"
MoveFrame.Size = UDim2.new(1, 0, 0, 200)
MoveFrame.BackgroundTransparency = 1
MoveFrame.Visible = false
MoveFrame.Parent = ContentArea
Instance.new("UIListLayout", MoveFrame).Padding = UDim.new(0, 3)

-- ============================================
-- FUNÇÕES DE UI
-- ============================================
local function CreateToggle(parent, name, default, callback)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 35)
    container.BackgroundColor3 = Color3.fromRGB(30, 30, 37)
    container.BorderSizePixel = 0
    container.Parent = parent
    Instance.new("UICorner", container).CornerRadius = UDim.new(0, 5)
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -55, 1, 0)
    label.Position = UDim2.new(0, 8, 0, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Theme.Text
    label.Font = Enum.Font.SourceSans
    label.TextSize = 13
    label.Text = name
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = container
    
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(0, 42, 0, 20)
    toggleBtn.Position = UDim2.new(1, -48, 0.5, -10)
    toggleBtn.BackgroundColor3 = default and Theme.Green or Color3.fromRGB(55, 55, 62)
    toggleBtn.BorderSizePixel = 0
    toggleBtn.Text = ""
    toggleBtn.AutoButtonColor = false
    toggleBtn.Parent = container
    Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(1, 0)
    
    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 16, 0, 16)
    knob.Position = default and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
    knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    knob.BorderSizePixel = 0
    knob.Parent = toggleBtn
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)
    
    local enabled = default
    
    toggleBtn.Activated:Connect(function()
        enabled = not enabled
        local targetPos = enabled and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
        TweenService:Create(knob, TweenInfo.new(0.15), {Position = targetPos}):Play()
        toggleBtn.BackgroundColor3 = enabled and Theme.Green or Color3.fromRGB(55, 55, 62)
        callback(enabled)
    end)
end

local function CreateSlider(parent, name, min, max, default, callback)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 50)
    container.BackgroundColor3 = Color3.fromRGB(30, 30, 37)
    container.BorderSizePixel = 0
    container.Parent = parent
    Instance.new("UICorner", container).CornerRadius = UDim.new(0, 5)
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -16, 0, 18)
    label.Position = UDim2.new(0, 8, 0, 4)
    label.BackgroundTransparency = 1
    label.TextColor3 = Theme.Text
    label.Font = Enum.Font.SourceSans
    label.TextSize = 13
    label.Text = name .. ": " .. default
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = container
    
    local sliderBg = Instance.new("Frame")
    sliderBg.Size = UDim2.new(1, -16, 0, 6)
    sliderBg.Position = UDim2.new(0, 8, 0, 26)
    sliderBg.BackgroundColor3 = Color3.fromRGB(50, 50, 58)
    sliderBg.BorderSizePixel = 0
    sliderBg.Parent = container
    Instance.new("UICorner", sliderBg).CornerRadius = UDim.new(1, 0)
    
    local percent = (default - min) / (max - min)
    
    local fill = Instance.new("Frame")
    fill.Size = UDim2.new(percent, 0, 1, 0)
    fill.BackgroundColor3 = Theme.Accent
    fill.BorderSizePixel = 0
    fill.Parent = sliderBg
    Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)
    
    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 14, 0, 14)
    knob.Position = UDim2.new(percent, -7, 0.5, -7)
    knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    knob.BorderSizePixel = 0
    knob.Parent = sliderBg
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)
    
    local isDragging = false
    
    local function updateSlider(input)
        local pos = input.Position
        local absPos = sliderBg.AbsolutePosition
        local absSize = sliderBg.AbsoluteSize
        local pct = math.clamp((pos.X - absPos.X) / absSize.X, 0, 1)
        local value = math.floor(min + (max - min) * pct)
        
        fill.Size = UDim2.new(pct, 0, 1, 0)
        knob.Position = UDim2.new(pct, -7, 0.5, -7)
        label.Text = name .. ": " .. value
        
        callback(value)
    end
    
    sliderBg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            isDragging = true
            updateSlider(input)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            isDragging = false
        end
    end)
    
    UserInputService.TouchMoved:Connect(function(input)
        if isDragging then
            updateSlider(input)
        end
    end)
end

-- ============================================
-- PREENCHER ABAS
-- ============================================

-- 🎯 AIM
CreateToggle(AimFrame, "Aimbot", false, function(enabled)
    Settings.Aimbot = enabled
    print("🎯 Aimbot:", enabled and "LIGADO" or "DESLIGADO")
end)

CreateSlider(AimFrame, "Aimbot FOV", 50, 500, 200, function(value)
    Settings.Aimbot_FOV = value
    print("🎯 Aimbot FOV:", value)
end)

CreateSlider(AimFrame, "Aimbot Suavidade", 1, 10, 5, function(value)
    Settings.Aimbot_Smooth = value
    print("🎯 Aimbot Suavidade:", value)
end)

-- 👁️ VISUAL
CreateToggle(VisualFrame, "ESP Master", Settings.ESP_Master, function(enabled)
    Settings.ESP_Master = enabled
    print("👁️ ESP:", enabled and "LIGADO" or "DESLIGADO")
end)

CreateToggle(VisualFrame, "ESP Box", Settings.ESP_Box, function(enabled)
    Settings.ESP_Box = enabled
end)

CreateToggle(VisualFrame, "ESP Tracer", Settings.ESP_Tracer, function(enabled)
    Settings.ESP_Tracer = enabled
end)

CreateToggle(VisualFrame, "ESP Name", Settings.ESP_Name, function(enabled)
    Settings.ESP_Name = enabled
end)

CreateToggle(VisualFrame, "ESP Health", Settings.ESP_Health, function(enabled)
    Settings.ESP_Health = enabled
end)

-- 🏃 MOVE
CreateToggle(MoveFrame, "Speed Hack", Settings.SpeedHack, function(enabled)
    Settings.SpeedHack = enabled
    
    local char = LocalPlayer.Character
    if char then
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if humanoid then
            if enabled then
                humanoid.WalkSpeed = Settings.SpeedValue * Settings.SpeedMultiplier
            else
                humanoid.WalkSpeed = Settings.SpeedValue
            end
        end
    end
    
    print("🏃 Speed Hack:", enabled and "LIGADO" or "DESLIGADO")
end)

CreateSlider(MoveFrame, "Speed Multiplier", 1, 10, Settings.SpeedMultiplier, function(value)
    Settings.SpeedMultiplier = value
    
    if Settings.SpeedHack then
        local char = LocalPlayer.Character
        if char then
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = Settings.SpeedValue * value
            end
        end
    end
    
    print("🏃 Speed:", value .. "x")
end)

-- ============================================
-- TROCAR ABAS
-- ============================================
local function SwitchTab(tabKey)
    TabAim.BackgroundColor3 = (tabKey == "AIM") and Theme.Accent or Color3.fromRGB(40, 40, 48)
    TabVisual.BackgroundColor3 = (tabKey == "VISUAL") and Theme.Accent or Color3.fromRGB(40, 40, 48)
    TabMove.BackgroundColor3 = (tabKey == "MOVE") and Theme.Accent or Color3.fromRGB(40, 40, 48)
    
    AimFrame.Visible = (tabKey == "AIM")
    VisualFrame.Visible = (tabKey == "VISUAL")
    MoveFrame.Visible = (tabKey == "MOVE")
end

TabAim.Activated:Connect(function() SwitchTab("AIM") end)
TabVisual.Activated:Connect(function() SwitchTab("VISUAL") end)
TabMove.Activated:Connect(function() SwitchTab("MOVE") end)

-- ============================================
-- ABRIR/FECHAR PAINEL
-- ============================================
local panelOpen = false

FloatButton.Activated:Connect(function()
    if not draggingFloat then
        panelOpen = not panelOpen
        MainPanel.Visible = panelOpen
    end
end)

CloseButton.Activated:Connect(function()
    panelOpen = false
    MainPanel.Visible = false
end)

-- ============================================
-- ARRASTAR BOTÃO (SEM LIMITES)
-- ============================================
local draggingFloat = false
local dragStartPos = nil
local startBtnPos = nil

FloatButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        draggingFloat = true
        dragStartPos = input.Position
        startBtnPos = FloatButton.Position
    end
end)

UserInputService.TouchMoved:Connect(function(input)
    if draggingFloat then
        local delta = input.Position - dragStartPos
        FloatButton.Position = UDim2.new(0, startBtnPos.X.Offset + delta.X, 0, startBtnPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        draggingFloat = false
    end
end)

-- ============================================
-- ARRASTAR PAINEL (SEM LIMITES)
-- ============================================
local draggingPanel = false
local panelDragStart = nil
local panelStartPos = nil

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        draggingPanel = true
        panelDragStart = input.Position
        panelStartPos = MainPanel.Position
    end
end)

UserInputService.TouchMoved:Connect(function(input)
    if draggingPanel then
        local delta = input.Position - panelDragStart
        MainPanel.Position = UDim2.new(0, panelStartPos.X.Offset + delta.X, 0, panelStartPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        draggingPanel = false
    end
end)

-- ============================================
-- SPEED HACK NO RESPAWN
-- ============================================
LocalPlayer.CharacterAdded:Connect(function(char)
    local humanoid = char:WaitForChild("Humanoid", 5)
    if humanoid then
        task.wait(0.1)
        Settings.SpeedValue = humanoid.WalkSpeed
        if Settings.SpeedHack then
            humanoid.WalkSpeed = Settings.SpeedValue * Settings.SpeedMultiplier
        end
    end
end)

-- ============================================
-- 🎯 AIMBOT SYSTEM
-- ============================================
local function GetClosestPlayer()
    local closestPlayer = nil
    local closestDistance = Settings.Aimbot_FOV
    
    local mousePos = UserInputService:GetMouseLocation()
    local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local head = player.Character:FindFirstChild("Head")
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            
            if head and humanoid and humanoid.Health > 0 then
                local screenPos, onScreen = Camera:WorldToScreenPoint(head.Position)
                
                if onScreen then
                    local distance = (Vector2.new(screenPos.X, screenPos.Y) - screenCenter).Magnitude
                    
                    if distance < closestDistance then
                        closestDistance = distance
                        closestPlayer = player
                    end
                end
            end
        end
    end
    
    return closestPlayer
end

-- Aimbot Loop
RunService.RenderStepped:Connect(function()
    if Settings.Aimbot then
        local target = GetClosestPlayer()
        
        if target and target.Character then
            local head = target.Character:FindFirstChild("Head")
            if head then
                local targetPos = head.Position
                local currentCFrame = Camera.CFrame
                local targetCFrame = CFrame.new(currentCFrame.Position, targetPos)
                
                -- Suavidade (quanto menor o número, mais rápido)
                local smoothFactor = 1 / (Settings.Aimbot_Smooth * 2)
                Camera.CFrame = currentCFrame:Lerp(targetCFrame, smoothFactor)
            end
        end
    end
end)

-- ============================================
-- ESP SYSTEM
-- ============================================
local ESP_Players = {}

local function CreateESP(player)
    if player == LocalPlayer then return end
    
    local container = Instance.new("Frame")
    container.Name = player.Name
    container.BackgroundTransparency = 1
    container.Size = UDim2.new(1, 0, 1, 0)
    container.Parent = ESPGui
    
    local box = Instance.new("Frame")
    box.Name = "Box"
    box.BackgroundTransparency = 1
    box.BorderSizePixel = 2
    box.BorderColor3 = Color3.fromRGB(255, 50, 50)
    box.Visible = false
    box.Parent = container
    
    local tracer = Instance.new("Frame")
    tracer.Name = "Tracer"
    tracer.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    tracer.BorderSizePixel = 0
    tracer.Visible = false
    tracer.Parent = container
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Name = "Name"
    nameLabel.BackgroundTransparency = 1
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.TextStrokeTransparency = 0
    nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    nameLabel.Font = Enum.Font.SourceSansBold
    nameLabel.TextSize = 12
    nameLabel.TextX
