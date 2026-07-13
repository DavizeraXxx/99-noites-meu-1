-- Proton Hub v7 - MorphUp (FUNCIONAL!)
-- Coleta automática de Berries com movimento natural

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

-- Variáveis
local FarmEnabled = false
local PvPEnabled = false
local Target = nil
local IsMoving = false
local CollectedCount = 0
local CollectRadius = 100
local MenuMinimized = false

-- =============================================
-- INTERFACE (Menu Completo)
-- =============================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ProtonHub"
ScreenGui.Parent = Player.PlayerGui
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 440, 0, 420)
MainFrame.Position = UDim2.new(0.5, -220, 0.5, -210)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
MainFrame.BackgroundTransparency = 0.1
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 16)
Corner.Parent = MainFrame

local Glass = Instance.new("Frame")
Glass.Size = UDim2.new(1, 0, 1, 0)
Glass.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Glass.BackgroundTransparency = 0.93
Glass.BorderSizePixel = 0
Glass.Parent = MainFrame

local GlassCorner = Instance.new("UICorner")
GlassCorner.CornerRadius = UDim.new(0, 16)
GlassCorner.Parent = Glass

local Shadow = Instance.new("ImageLabel")
Shadow.Size = UDim2.new(1, 30, 1, 30)
Shadow.Position = UDim2.new(0, -15, 0, -15)
Shadow.BackgroundTransparency = 1
Shadow.Image = "rbxassetid://1316045194"
Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
Shadow.ImageTransparency = 0.5
Shadow.ZIndex = 0
Shadow.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 45)
Title.Position = UDim2.new(0, 0, 0, 5)
Title.BackgroundTransparency = 1
Title.Text = "🍓 PROTON HUB v7"
Title.TextColor3 = Color3.fromRGB(255, 215, 0)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 24
Title.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
Title.TextStrokeTransparency = 0.3
Title.Parent = MainFrame

local SubTitle = Instance.new("TextLabel")
SubTitle.Size = UDim2.new(1, 0, 0, 20)
SubTitle.Position = UDim2.new(0, 0, 0, 45)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = "Farm de Berries • Movimento Natural"
SubTitle.TextColor3 = Color3.fromRGB(180, 180, 200)
SubTitle.Font = Enum.Font.Gotham
SubTitle.TextSize = 14
SubTitle.Parent = MainFrame

local Line = Instance.new("Frame")
Line.Size = UDim2.new(0.9, 0, 0, 2)
Line.Position = UDim2.new(0.05, 0, 0, 70)
Line.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
Line.BackgroundTransparency = 0.3
Line.BorderSizePixel = 0
Line.Parent = MainFrame

-- Status
local StatusFarm = Instance.new("TextLabel")
StatusFarm.Size = UDim2.new(0.45, 0, 0, 25)
StatusFarm.Position = UDim2.new(0.03, 0, 0, 85)
StatusFarm.BackgroundTransparency = 1
StatusFarm.Text = "🍓 Farm: OFF"
StatusFarm.TextColor3 = Color3.fromRGB(255, 80, 80)
StatusFarm.Font = Enum.Font.GothamBold
StatusFarm.TextSize = 15
StatusFarm.TextXAlignment = Enum.TextXAlignment.Left
StatusFarm.Parent = MainFrame

local StatusPvP = Instance.new("TextLabel")
StatusPvP.Size = UDim2.new(0.45, 0, 0, 25)
StatusPvP.Position = UDim2.new(0.52, 0, 0, 85)
StatusPvP.BackgroundTransparency = 1
StatusPvP.Text = "⚔️ PvP: OFF"
StatusPvP.TextColor3 = Color3.fromRGB(255, 80, 80)
StatusPvP.Font = Enum.Font.GothamBold
StatusPvP.TextSize = 15
StatusPvP.TextXAlignment = Enum.TextXAlignment.Left
StatusPvP.Parent = MainFrame

local StatusItems = Instance.new("TextLabel")
StatusItems.Size = UDim2.new(1, 0, 0, 20)
StatusItems.Position = UDim2.new(0.03, 0, 0, 110)
StatusItems.BackgroundTransparency = 1
StatusItems.Text = "🍓 Berries coletadas: 0"
StatusItems.TextColor3 = Color3.fromRGB(100, 255, 200)
StatusItems.Font = Enum.Font.Gotham
StatusItems.TextSize = 13
StatusItems.TextXAlignment = Enum.TextXAlignment.Left
StatusItems.Parent = MainFrame

local StatusBerry = Instance.new("TextLabel")
StatusBerry.Size = UDim2.new(1, 0, 0, 20)
StatusBerry.Position = UDim2.new(0.03, 0, 0, 130)
StatusBerry.BackgroundTransparency = 1
StatusBerry.Text = "📡 Berries no mapa: 0"
StatusBerry.TextColor3 = Color3.fromRGB(200, 200, 255)
StatusBerry.Font = Enum.Font.Gotham
StatusBerry.TextSize = 13
StatusBerry.TextXAlignment = Enum.TextXAlignment.Left
StatusBerry.Parent = MainFrame

-- =============================================
-- BOTÕES
-- =============================================
local function CreateButton(text, yPos, color, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.85, 0, 0, 38)
    btn.Position = UDim2.new(0.075, 0, 0, yPos)
    btn.BackgroundColor3 = color
    btn.BackgroundTransparency = 0.2
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 15
    btn.BorderSizePixel = 0
    btn.Parent = MainFrame
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 10)
    btnCorner.Parent = btn
    
    btn.MouseButton1Click:Connect(callback)
    
    btn.MouseEnter:Connect(function()
        btn.BackgroundTransparency = 0.05
        btn.TextSize = 16
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundTransparency = 0.2
        btn.TextSize = 15
    end)
    
    return btn
end

-- Botão Farm (Agora com Berries!)
CreateButton("🍓 Farm de Berries", 160, Color3.fromRGB(0, 180, 120), function()
    FarmEnabled = not FarmEnabled
    StatusFarm.Text = FarmEnabled and "🍓 Farm: ON ✅" or "🍓 Farm: OFF"
    StatusFarm.TextColor3 = FarmEnabled and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 80, 80)
    if FarmEnabled then
        CollectedCount = 0
        print("🍓 Farm de Berries ATIVADO!")
    else
        if Humanoid then
            Humanoid:MoveTo(Humanoid.RootPart.Position)
        end
        print("⏸️ Farm DESATIVADO")
    end
end)

-- Botão PvP
CreateButton("⚔️ PvP Automático", 208, Color3.fromRGB(220, 60, 60), function()
    PvPEnabled = not PvPEnabled
    StatusPvP.Text = PvPEnabled and "⚔️ PvP: ON ✅" or "⚔️ PvP: OFF"
    StatusPvP.TextColor3 = PvPEnabled and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 80, 80)
    if PvPEnabled then
        Target = nil
        for _, v in pairs(Players:GetPlayers()) do
            if v ~= Player and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
                Target = v
                break
            end
        end
    end
end)

-- Botão Raio
CreateButton("📡 Aumentar Raio (+10)", 256, Color3.fromRGB(100, 100, 200), function()
    CollectRadius = math.min(CollectRadius + 10, 200)
    StatusBerry.Text = "📡 Raio: " .. CollectRadius .. " studs"
    print("📡 Raio: " .. CollectRadius .. " studs")
end)

-- Botão Reset
CreateButton("🔄 Resetar posição", 304, Color3.fromRGB(200, 150, 0), function()
    if Character and Character:FindFirstChild("HumanoidRootPart") then
        local root = Character.HumanoidRootPart
        root.CFrame = root.CFrame + Vector3.new(math.random(-3, 3), 0, math.random(-3, 3))
        print("🔄 Resetando posição...")
    end
end)

-- Botão Minimizar
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 32, 0, 32)
MinimizeBtn.Position = UDim2.new(1, -80, 0, 5)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
MinimizeBtn.BackgroundTransparency = 0.3
MinimizeBtn.Text = "━"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.TextSize = 22
MinimizeBtn.BorderSizePixel = 0
MinimizeBtn.Parent = MainFrame

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(1, 0)
MinCorner.Parent = MinimizeBtn

MinimizeBtn.MouseEnter:Connect(function()
    MinimizeBtn.BackgroundTransparency = 0
end)
MinimizeBtn.MouseLeave:Connect(function()
    MinimizeBtn.BackgroundTransparency = 0.3
end)

MinimizeBtn.MouseButton1Click:Connect(function()
    MenuMinimized = not MenuMinimized
    if MenuMinimized then
        MainFrame.Size = UDim2.new(0, 200, 0, 45)
        MinimizeBtn.Text = "□"
        for _, child in pairs(MainFrame:GetChildren()) do
            if child ~= Title and child ~= MinimizeBtn and child ~= CloseBtn and child ~= Shadow and child ~= Glass then
                child.Visible = false
            end
        end
        Title.Text = "🍓 PROTON v7"
        Title.TextSize = 18
    else
        MainFrame.Size = UDim2.new(0, 440, 0, 420)
        MinimizeBtn.Text = "━"
        for _, child in pairs(MainFrame:GetChildren()) do
            child.Visible = true
        end
        Title.Text = "🍓 PROTON HUB v7"
        Title.TextSize = 24
    end
end)

-- Botão Fechar
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 32, 0, 32)
CloseBtn.Position = UDim2.new(1, -42, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseBtn.BackgroundTransparency = 0.3
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 20
CloseBtn.BorderSizePixel = 0
CloseBtn.Parent = MainFrame

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(1, 0)
CloseCorner.Parent = CloseBtn

CloseBtn.MouseEnter:Connect(function()
    CloseBtn.BackgroundTransparency = 0
end)
CloseBtn.MouseLeave:Connect(function()
    CloseBtn.BackgroundTransparency = 0.3
end)

CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- =============================================
-- SISTEMA DE DRAG
-- =============================================
local dragging = false
local dragStart, startPos

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(
            startPos.X.Scale, 
            startPos.X.Offset + delta.X, 
            startPos.Y.Scale, 
            startPos.Y.Offset + delta.Y
        )
    end
end)

-- =============================================
-- SISTEMA DE FARM (COM BERRY!)
-- =============================================

-- Função para encontrar Berries
local function FindNearestBerry()
    local character = Player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return nil end
    
    local root = character.HumanoidRootPart
    local nearest = nil
    local nearestDist = CollectRadius
    
    -- Procura na pasta Berries
    local berriesFolder = workspace:FindFirstChild("Berries")
    if berriesFolder then
        for _, berry in pairs(berriesFolder:GetChildren()) do
            if berry:IsA("BasePart") and berry.Name == "Berry" then
                local distance = (root.Position - berry.Position).Magnitude
                if distance < nearestDist and distance > 1.5 then
                    nearest = berry
                    nearestDist = distance
                end
            end
        end
    end
    
    return nearest
end

-- Função para contar Berries no mapa
local function CountBerries()
    local count = 0
    local berriesFolder = workspace:FindFirstChild("Berries")
    if berriesFolder then
        for _, berry in pairs(berriesFolder:GetChildren()) do
            if berry:IsA("BasePart") and berry.Name == "Berry" then
                count = count + 1
            end
        end
    end
    return count
end

-- Função para coletar a Berry
local function CollectBerry(berry)
    if not berry or not berry.Parent then return false end
    
    local character = Player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return false end
    
    local root = character.HumanoidRootPart
    local distance = (root.Position - berry.Position).Magnitude
    
    -- Se já está perto, coleta
    if distance < 3 then
        pcall(function()
            -- Toca na berry
            firetouchinterest(character.HumanoidRootPart, berry, 0)
            task.wait(0.05)
            firetouchinterest(character.HumanoidRootPart, berry, 1)
            
            -- Tenta ClickDetector (se tiver)
            if berry:FindFirstChild("ClickDetector") then
                fireclickdetector(berry.ClickDetector)
            end
            
            -- Clique do mouse
            mouse1click()
        end)
        
        -- Verifica se foi coletada
        task.wait(0.3)
        if not berry.Parent then
            CollectedCount = CollectedCount + 1
            StatusItems.Text = "🍓 Berries coletadas: " .. CollectedCount
            print("🍓 Coletou uma Berry! Total: " .. CollectedCount)
            return true
        end
        return false
    end
    
    -- Calcula o tempo real de caminhada (velocidade normal)
    local walkSpeed = Humanoid.WalkSpeed or 16
    local timeToReach = distance / walkSpeed
    
    -- Adiciona pequeno delay (simula hesitação humana)
    timeToReach = timeToReach + math.random(3, 8) / 10
    
    -- Move até a berry
    Humanoid:MoveTo(berry.Position)
    
    -- Espera o tempo calculado
    task.wait(timeToReach)
    
    -- Tenta coletar
    if berry.Parent and (root.Position - berry.Position).Magnitude < 4 then
        pcall(function()
            firetouchinterest(character.HumanoidRootPart, berry, 0)
            task.wait(0.05)
            firetouchinterest(character.HumanoidRootPart, berry, 1)
            
            if berry:FindFirstChild("ClickDetector") then
                fireclickdetector(berry.ClickDetector)
            end
            mouse1click()
        end)
        
        task.wait(0.3)
        if not berry.Parent then
            CollectedCount = CollectedCount + 1
            StatusItems.Text = "🍓 Berries coletadas: " .. CollectedCount
            print("🍓 Coletou uma Berry! Total: " .. CollectedCount)
            return true
        end
    end
    
    return false
end

-- Loop principal do Farm
RunService.Heartbeat:Connect(function()
    if not FarmEnabled then return end
    
    local berry = FindNearestBerry()
    
    if berry then
        CollectBerry(berry)
    else
        -- Se não tiver berry perto, explora aleatoriamente
        if math.random(1, 100) > 97 then
            local root = Character and Character:FindFirstChild("HumanoidRootPart")
            if root then
                local randomPos = root.Position + Vector3.new(
                    math.random(-40, 40),
                    0,
                    math.random(-40, 40)
                )
                Humanoid:MoveTo(randomPos)
                task.wait(math.random(2, 4))
            end
        end
    end
    
    -- Atualiza contador de berries no mapa
    StatusBerry.Text = "📡 Berries no mapa: " .. CountBerries()
end)

-- =============================================
-- DETECTA QUANDO UMA BERRY SPAWNA
-- =============================================
workspace.DescendantAdded:Connect(function(obj)
    if FarmEnabled and obj:IsA("BasePart") and obj.Name == "Berry" then
        local parent = obj.Parent
        if parent and parent.Name == "Berries" then
            print("🍓 Nova Berry spawnou!")
            -- Tenta coletar imediatamente se estiver perto
            task.wait(0.2)
            if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                local root = Player.Character.HumanoidRootPart
                local distance = (root.Position - obj.Position).Magnitude
                if distance < CollectRadius then
                    CollectBerry(obj)
                end
            end
        end
    end
end)

-- =============================================
-- PVP AUTOMÁTICO
-- =============================================
RunService.RenderStepped:Connect(function()
    if not PvPEnabled then return end
    
    if Target and (not Target.Character or not Target.Character:FindFirstChild("Humanoid") or Target.Character.Humanoid.Health <= 0) then
        Target = nil
    end
    
    if not Target then
        local closest = nil
        local closestDist = math.huge
        for _, v in pairs(Players:GetPlayers()) do
            if v ~= Player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
                local dist = (Player.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).Magnitude
                if dist < closestDist and dist < 60 then
                    closest = v
                    closestDist = dist
                end
            end
        end
        Target = closest
    end
    
    if Target and Target.Character and Target.Character:FindFirstChild("HumanoidRootPart") then
        local root = Player.Character.HumanoidRootPart
        local targetRoot = Target.Character.HumanoidRootPart
        
        Humanoid:MoveTo(targetRoot.Position + Vector3.new(0, 0, 5))
        
        if (root.Position - targetRoot.Position).Magnitude < 8 then
            mouse1click()
            task.wait(0.25)
        end
    end
end)

-- =============================================
-- ANTI-KICK
-- =============================================
RunService.RenderStepped:Connect(function()
    if Character and Character:FindFirstChild("HumanoidRootPart") and not FarmEnabled and not PvPEnabled then
        local root = Character.HumanoidRootPart
        root.Position = root.Position + Vector3.new(
            math.sin(tick()*0.5)*0.001,
            0,
            math.cos(tick()*0.5)*0.001
        )
    end
end)

-- =============================================
-- INICIALIZAÇÃO
-- =============================================
print("========================================")
print("🍓 PROTON HUB v7 - MORPHUP")
print("========================================")
print("✅ Farm de BERRY (nome correto!)")
print("✅ Movimento NATURAL (anti-cheat)")
print("✅ Coleta por TOQUE + CLICK")
print("📡 Raio: " .. CollectRadius .. " studs")
print("========================================")

local notif = Instance.new("TextLabel")
notif.Size = UDim2.new(0, 400, 0, 45)
notif.Position = UDim2.new(0.5, -200, 0.85, 0)
notif.BackgroundColor3 = Color3.fromRGB(255, 100, 50)
notif.BackgroundTransparency = 0.15
notif.Text = "🍓 PROTON HUB v7 - Farm de Berries!"
notif.TextColor3 = Color3.fromRGB(255, 255, 255)
notif.Font = Enum.Font.GothamBold
notif.TextSize = 18
notif.Parent = ScreenGui

local notifCorner = Instance.new("UICorner")
notifCorner.CornerRadius = UDim.new(0, 10)
notifCorner.Parent = notif

task.wait(3)
notif:Destroy()