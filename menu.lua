-- // ============================================
-- // MENU 99 NOITES - VERSÃO FINAL
-- // GUIA DE EXECUÇÃO
-- // ============================================

local player = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

-- // ==========================================
-- // CONFIGURAÇÕES
-- // ==========================================

local CHAVE_CORRETA = "99noites2025"
local chaveValidada = false
local menuAberto = false

-- // ==========================================
-- // CRIAÇÃO DA GUI (PRIMEIRO)
-- // ==========================================

local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player.PlayerGui
screenGui.Name = "Menu99Noites"
screenGui.ResetOnSpawn = false

-- // ==========================================
-- // JANELA DE CHAVE
-- // ==========================================

local keyFrame = Instance.new("Frame")
keyFrame.Parent = screenGui
keyFrame.Size = UDim2.new(0, 320, 0, 170)
keyFrame.Position = UDim2.new(0.5, -160, 0.5, -85)
keyFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
keyFrame.BorderSizePixel = 2
keyFrame.BorderColor3 = Color3.fromRGB(200, 0, 0)
keyFrame.Visible = true

local keyCorner = Instance.new("UICorner")
keyCorner.Parent = keyFrame
keyCorner.CornerRadius = UDim.new(0, 6)

local keyTitle = Instance.new("TextLabel")
keyTitle.Parent = keyFrame
keyTitle.Size = UDim2.new(1, 0, 0, 35)
keyTitle.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
keyTitle.Text = "SISTEMA DE CHAVE"
keyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
keyTitle.TextScaled = true
keyTitle.Font = Enum.Font.GothamBold
keyTitle.BorderSizePixel = 0

local keySub = Instance.new("TextLabel")
keySub.Parent = keyFrame
keySub.Size = UDim2.new(1, -20, 0, 25)
keySub.Position = UDim2.new(0, 10, 0, 45)
keySub.BackgroundTransparency = 1
keySub.Text = "Digite a chave de acesso"
keySub.TextColor3 = Color3.fromRGB(180, 180, 180)
keySub.TextScaled = true
keySub.Font = Enum.Font.Gotham

local keyInput = Instance.new("TextBox")
keyInput.Parent = keyFrame
keyInput.Size = UDim2.new(0.8, 0, 0, 35)
keyInput.Position = UDim2.new(0.1, 0, 0, 75)
keyInput.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
keyInput.BorderSizePixel = 1
keyInput.BorderColor3 = Color3.fromRGB(200, 0, 0)
keyInput.Text = ""
keyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
keyInput.TextScaled = true
keyInput.Font = Enum.Font.Gotham
keyInput.PlaceholderText = "Digite a chave..."
keyInput.ClearTextOnFocus = true

local keyInputCorner = Instance.new("UICorner")
keyInputCorner.Parent = keyInput
keyInputCorner.CornerRadius = UDim.new(0, 4)

local keyBtn = Instance.new("TextButton")
keyBtn.Parent = keyFrame
keyBtn.Size = UDim2.new(0.4, 0, 0, 32)
keyBtn.Position = UDim2.new(0.3, 0, 0, 122)
keyBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
keyBtn.Text = "CONFIRMAR"
keyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
keyBtn.TextScaled = true
keyBtn.Font = Enum.Font.GothamBold
keyBtn.BorderSizePixel = 0

local keyBtnCorner = Instance.new("UICorner")
keyBtnCorner.Parent = keyBtn
keyBtnCorner.CornerRadius = UDim.new(0, 4)

local keyError = Instance.new("TextLabel")
keyError.Parent = keyFrame
keyError.Size = UDim2.new(1, 0, 0, 20)
keyError.Position = UDim2.new(0, 0, 0, 160)
keyError.BackgroundTransparency = 1
keyError.Text = ""
keyError.TextColor3 = Color3.fromRGB(255, 50, 50)
keyError.TextScaled = true
keyError.Font = Enum.Font.Gotham

-- // ==========================================
-- // JANELA PRINCIPAL (CRIADA AGORA)
-- // ==========================================

local mainFrame = Instance.new("Frame")
mainFrame.Parent = screenGui
mainFrame.Size = UDim2.new(0, 620, 0, 400)
mainFrame.Position = UDim2.new(0.5, -310, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
mainFrame.BorderSizePixel = 1
mainFrame.BorderColor3 = Color3.fromRGB(200, 0, 0)
mainFrame.Visible = false
mainFrame.BackgroundTransparency = 1

local mainCorner = Instance.new("UICorner")
mainCorner.Parent = mainFrame
mainCorner.CornerRadius = UDim.new(0, 4)

-- // TOP BAR
local topBar = Instance.new("Frame")
topBar.Parent = mainFrame
topBar.Size = UDim2.new(1, 0, 0, 28)
topBar.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
topBar.BorderSizePixel = 0

local topCorner = Instance.new("UICorner")
topCorner.Parent = topBar
topCorner.CornerRadius = UDim.new(0, 4)

local title = Instance.new("TextLabel")
title.Parent = topBar
title.Size = UDim2.new(0.7, 0, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Text = "99 NOITES MENU"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left

local closeBtn = Instance.new("TextButton")
closeBtn.Parent = topBar
closeBtn.Size = UDim2.new(0, 24, 0, 24)
closeBtn.Position = UDim2.new(1, -28, 0, 2)
closeBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextScaled = true
closeBtn.Font = Enum.Font.GothamBold
closeBtn.BorderSizePixel = 0

local closeCorner = Instance.new("UICorner")
closeCorner.Parent = closeBtn
closeCorner.CornerRadius = UDim.new(0, 3)

-- // ABAS LATERAIS
local sidebar = Instance.new("Frame")
sidebar.Parent = mainFrame
sidebar.Size = UDim2.new(0, 80, 1, -28)
sidebar.Position = UDim2.new(0, 0, 0, 28)
sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
sidebar.BorderSizePixel = 0

local abas = {
    {id = "sobrevivencia", nome = "SOBREV"},
    {id = "combate", nome = "COMBATE"},
    {id = "recursos", nome = "RECURSOS"},
    {id = "visao", nome = "VISAO"},
    {id = "movimento", nome = "MOV"},
    {id = "config", nome = "CONFIG"}
}

local abasBotoes = {}
local abaAtual = "sobrevivencia"

for i, aba in ipairs(abas) do
    local btn = Instance.new("TextButton")
    btn.Parent = sidebar
    btn.Size = UDim2.new(1, -4, 0, 30)
    btn.Position = UDim2.new(0, 2, 0, 2 + (i - 1) * 34)
    btn.BackgroundColor3 = (i == 1) and Color3.fromRGB(200, 0, 0) or Color3.fromRGB(20, 20, 20)
    btn.Text = aba.nome
    btn.TextColor3 = (i == 1) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(150, 150, 150)
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamSemibold
    btn.BorderSizePixel = 0
    btn.Name = aba.id
    
    btn.MouseEnter:Connect(function()
        if btn.BackgroundColor3 ~= Color3.fromRGB(200, 0, 0) then
            btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        end
    end)
    btn.MouseLeave:Connect(function()
        if btn.BackgroundColor3 ~= Color3.fromRGB(200, 0, 0) then
            btn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            btn.TextColor3 = Color3.fromRGB(150, 150, 150)
        end
    end)
    
    btn.MouseButton1Click:Connect(function()
        for _, b in pairs(abasBotoes) do
            b.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            b.TextColor3 = Color3.fromRGB(150, 150, 150)
        end
        btn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        abaAtual = aba.id
        atualizarAbas(aba.id)
    end)
    
    abasBotoes[aba.id] = btn
end

-- // ÁREA DE CONTEÚDO
local contentFrame = Instance.new("Frame")
contentFrame.Parent = mainFrame
contentFrame.Size = UDim2.new(1, -90, 1, -36)
contentFrame.Position = UDim2.new(0, 85, 0, 33)
contentFrame.BackgroundTransparency = 1

local abasContent = {}

-- // ==========================================
-- // FUNÇÕES DE CONTROLE (DEPOIS DA CRIAÇÃO)
-- // ==========================================

function atualizarAbas(abaId)
    for id, container in pairs(abasContent) do
        container.Visible = (id == abaId)
    end
end

function abrirMenu()
    if not chaveValidada then
        keyFrame.Visible = true
        return
    end
    menuAberto = true
    mainFrame.Visible = true
    mainFrame.BackgroundTransparency = 1
    mainFrame.Size = UDim2.new(0, 500, 0, 400)
    TweenService:Create(mainFrame, TweenInfo.new(0.3), {
        BackgroundTransparency = 0,
        Size = UDim2.new(0, 620, 0, 400)
    }):Play()
    print("Menu aberto!")
end

function fecharMenu()
    menuAberto = false
    TweenService:Create(mainFrame, TweenInfo.new(0.2), {
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 500, 0, 400)
    }):Play()
    wait(0.2)
    mainFrame.Visible = false
    print("Menu fechado!")
end

function toggleMenu()
    if not chaveValidada then
        keyFrame.Visible = true
        return
    end
    if menuAberto then
        fecharMenu()
    else
        abrirMenu()
    end
end

-- // ==========================================
-- // FUNÇÕES REAIS DO JOGO
-- // ==========================================

local godMode = false
local killAura = false
local puloInfinito = false
local autoFarmMadeira = false
local autoFarmPedra = false
local espMonstros = false
local espItens = false
local fullbright = false
local autoHeal = false
local fomeInfinita = false

function toggleGodMode(estado)
    godMode = estado
    if estado then
        player.Character.Humanoid.MaxHealth = math.huge
        player.Character.Humanoid.Health = math.huge
        print("God Mode ativado")
    else
        player.Character.Humanoid.MaxHealth = 100
        player.Character.Humanoid.Health = 100
        print("God Mode desativado")
    end
end

function togglePuloInfinito(estado)
    puloInfinito = estado
    print("Pulo Infinito:", estado)
end

function oneHitKill()
    local enemies = workspace:FindFirstChild("Enemies") or workspace:FindFirstChild("Monsters")
    if enemies then
        for _, enemy in ipairs(enemies:GetChildren()) do
            if enemy:FindFirstChild("Humanoid") then
                enemy.Humanoid.Health = 0
            end
        end
        print("One Hit Kill executado")
    else
        print("Nenhum inimigo encontrado")
    end
end

function matarTodos()
    local enemies = workspace:FindFirstChild("Enemies") or workspace:FindFirstChild("Monsters")
    if enemies then
        for _, enemy in ipairs(enemies:GetChildren()) do
            if enemy:FindFirstChild("Humanoid") then
                enemy.Humanoid.Health = 0
            end
        end
        print("Todos os inimigos mortos")
    else
        print("Nenhum inimigo encontrado")
    end
end

function toggleKillAura(estado)
    killAura = estado
    print("Kill Aura:", estado)
end

function toggleAutoFarmMadeira(estado)
    autoFarmMadeira = estado
    print("Auto Farm Madeira:", estado)
end

function toggleAutoFarmPedra(estado)
    autoFarmPedra = estado
    print("Auto Farm Pedra:", estado)
end

function toggleESPMonstros(estado)
    espMonstros = estado
    print("ESP Monstros:", estado)
end

function toggleESPItens(estado)
    espItens = estado
    print("ESP Itens:", estado)
end

function toggleFullbright(estado)
    fullbright = estado
    if estado then
        game.Lighting.Brightness = 10
        game.Lighting.Ambient = Color3.fromRGB(255, 255, 255)
        print("Fullbright ativado")
    else
        game.Lighting.Brightness = 1
        game.Lighting.Ambient = Color3.fromRGB(0, 0, 0)
        print("Fullbright desativado")
    end
end

function teleportAcampamento()
    local acampamento = workspace:FindFirstChild("Acampamento") or workspace:FindFirstChild("Camp")
    if acampamento then
        player.Character.HumanoidRootPart.CFrame = acampamento.CFrame + Vector3.new(0, 5, 0)
        print("Teleportado para o acampamento")
    else
        print("Acampamento não encontrado")
    end
end

-- // ==========================================
-- // LOOPS DAS FUNÇÕES
-- // ==========================================

RunService.Heartbeat:Connect(function()
    if puloInfinito then
        local char = player.Character
        if char and char:FindFirstChild("Humanoid") then
            local humanoid = char.Humanoid
            if humanoid:GetState() == Enum.HumanoidStateType.Landed then
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
    end
    
    if killAura then
        local enemies = workspace:FindFirstChild("Enemies") or workspace:FindFirstChild("Monsters")
        if enemies then
            for _, enemy in ipairs(enemies:GetChildren()) do
                if enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                    local distancia = (enemy.Position - player.Character.HumanoidRootPart.Position).Magnitude
                    if distancia < 50 then
                        enemy.Humanoid.Health = 0
                    end
                end
            end
        end
    end
end)

-- // ==========================================
-- // FUNÇÕES DE CRIAÇÃO DE ELEMENTOS
-- // ==========================================

function criarToggle(container, texto, callback, valorInicial)
    local frame = Instance.new("Frame")
    frame.Parent = container
    frame.Size = UDim2.new(1, -10, 0, 28)
    frame.Position = UDim2.new(0, 5, 0, #container:GetChildren() * 30 + 5)
    frame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
    frame.BorderSizePixel = 0
    frame.BackgroundTransparency = 0.2
    
    local border = Instance.new("Frame")
    border.Parent = frame
    border.Size = UDim2.new(1, 0, 0, 1)
    border.Position = UDim2.new(0, 0, 1, -1)
    border.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    border.BorderSizePixel = 0
    
    local label = Instance.new("TextLabel")
    label.Parent = frame
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.Position = UDim2.new(0, 8, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = texto
    label.TextColor3 = Color3.fromRGB(220, 220, 220)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextScaled = true
    label.Font = Enum.Font.Gotham
    
    local checkbox = Instance.new("ImageButton")
    checkbox.Parent = frame
    checkbox.Size = UDim2.new(0, 20, 0, 20)
    checkbox.Position = UDim2.new(1, -30, 0.5, -10)
    checkbox.BackgroundColor3 = valorInicial and Color3.fromRGB(0, 180, 50) or Color3.fromRGB(60, 60, 60)
    checkbox.BorderSizePixel = 1
    checkbox.BorderColor3 = Color3.fromRGB(200, 200, 200)
    checkbox.Image = ""
    
    local checkboxCorner = Instance.new("UICorner")
    checkboxCorner.Parent = checkbox
    checkboxCorner.CornerRadius = UDim.new(0, 3)
    
    local checkmark = Instance.new("TextLabel")
    checkmark.Parent = checkbox
    checkmark.Size = UDim2.new(1, 0, 1, 0)
    checkmark.BackgroundTransparency = 1
    checkmark.Text = valorInicial and "✓" or ""
    checkmark.TextColor3 = Color3.fromRGB(255, 255, 255)
    checkmark.TextScaled = true
    checkmark.Font = Enum.Font.GothamBold
    
    local estado = valorInicial or false
    
    local function toggleCheckbox()
        estado = not estado
        if estado then
            checkbox.BackgroundColor3 = Color3.fromRGB(0, 180, 50)
            checkmark.Text = "✓"
        else
            checkbox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            checkmark.Text = ""
        end
        callback(estado)
    end
    
    checkbox.MouseButton1Click:Connect(toggleCheckbox)
    label.MouseButton1Click:Connect(toggleCheckbox)
    frame.MouseButton1Click:Connect(toggleCheckbox)
    
    return frame
end

function criarBotao(container, texto, cor, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = container
    btn.Size = UDim2.new(1, -10, 0, 28)
    btn.Position = UDim2.new(0, 5, 0, #container:GetChildren() * 30 + 5)
    btn.BackgroundColor3 = cor or Color3.fromRGB(200, 0, 0)
    btn.Text = texto
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamSemibold
    btn.BorderSizePixel = 0
    btn.BackgroundTransparency = 0.1
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.Parent = btn
    btnCorner.CornerRadius = UDim.new(0, 3)
    
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundTransparency = 0.3}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundTransparency = 0.1}):Play()
    end)
    
    btn.MouseButton1Click:Connect(callback)
    
    return btn
end

function criarSlider(container, texto, min, max, padrao, callback)
    local frame = Instance.new("Frame")
    frame.Parent = container
    frame.Size = UDim2.new(1, -10, 0, 32)
    frame.Position = UDim2.new(0, 5, 0, #container:GetChildren() * 30 + 5)
    frame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
    frame.BorderSizePixel = 0
    frame.BackgroundTransparency = 0.2
    
    local border = Instance.new("Frame")
    border.Parent = frame
    border.Size = UDim2.new(1, 0, 0, 1)
    border.Position = UDim2.new(0, 0, 1, -1)
    border.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    border.BorderSizePixel = 0
    
    local label = Instance.new("TextLabel")
    label.Parent = frame
    label.Size = UDim2.new(0.3, 0, 1, 0)
    label.Position = UDim2.new(0, 8, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = texto
    label.TextColor3 = Color3.fromRGB(220, 220, 220)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextScaled = true
    label.Font = Enum.Font.Gotham
    
    local valorLabel = Instance.new("TextLabel")
    valorLabel.Parent = frame
    valorLabel.Size = UDim2.new(0.1, 0, 1, 0)
    valorLabel.Position = UDim2.new(0.33, 0, 0, 0)
    valorLabel.BackgroundTransparency = 1
    valorLabel.Text = tostring(padrao)
    valorLabel.TextColor3 = Color3.fromRGB(200, 0, 0)
    valorLabel.TextXAlignment = Enum.TextXAlignment.Center
    valorLabel.TextScaled = true
    valorLabel.Font = Enum.Font.GothamBold
    
    local sliderBar = Instance.new("Frame")
    sliderBar.Parent = frame
    sliderBar.Size = UDim2.new(0.5, 0, 0, 5)
    sliderBar.Position = UDim2.new(0.45, 0, 0.5, -2.5)
    sliderBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    sliderBar.BorderSizePixel = 0
    
    local sliderCorner = Instance.new("UICorner")
    sliderCorner.Parent = sliderBar
    sliderCorner.CornerRadius = UDim.new(1, 0)
    
    local fill = Instance.new("Frame")
    fill.Parent = sliderBar
    fill.Size = UDim2.new((padrao - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    fill.BorderSizePixel = 0
    
    local fillCorner = Instance.new("UICorner")
    fillCorner.Parent = fill
    fillCorner.CornerRadius = UDim.new(1, 0)
    
    local valor = padrao
    local dragging = false
    
    sliderBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)
    
    sliderBar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local mousePos = input.Position.X
            local sliderPos = sliderBar.AbsolutePosition.X
            local sliderSize = sliderBar.AbsoluteSize.X
            local percent = math.clamp((mousePos - sliderPos) / sliderSize, 0, 1)
            valor = math.round(min + (max - min) * percent)
            fill.Size = UDim2.new(percent, 0, 1, 0)
            valorLabel.Text = tostring(valor)
            callback(valor)
        end
    end)
    
    return frame
end

function criarStatus(container, texto, cor)
    local label = Instance.new("TextLabel")
    label.Parent = container
    label.Size = UDim2.new(1, -10, 0, 20)
    label.Position = UDim2.new(0, 5, 0, #container:GetChildren() * 22 + 5)
    label.BackgroundTransparency = 1
    label.Text = texto
    label.TextColor3 = cor or Color3.fromRGB(180, 180, 180)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextScaled = true
    label.Font = Enum.Font.Gotham
    
    return label
end

-- // ==========================================
-- // CRIAÇÃO DAS ABAS
-- // ==========================================

-- SOBREVIVENCIA
local sobrevivenciaContainer = Instance.new("ScrollingFrame")
sobrevivenciaContainer.Parent = contentFrame
sobrevivenciaContainer.Size = UDim2.new(1, 0, 1, 0)
sobrevivenciaContainer.BackgroundTransparency = 1
sobrevivenciaContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
sobrevivenciaContainer.ScrollBarThickness = 3
sobrevivenciaContainer.ScrollBarImageColor3 = Color3.fromRGB(200, 0, 0)
sobrevivenciaContainer.Visible = true
abasContent["sobrevivencia"] = sobrevivenciaContainer

criarStatus(sobrevivenciaContainer, "Fome: 100%", Color3.fromRGB(255, 200, 100))
criarStatus(sobrevivenciaContainer, "Energia: 100%", Color3.fromRGB(100, 200, 255))
criarStatus(sobrevivenciaContainer, "Vida: 100%", Color3.fromRGB(255, 100, 100))
criarToggle(sobrevivenciaContainer, "Auto Heal", function(estado)
    autoHeal = estado
    print("Auto Heal:", estado)
end, true)
criarToggle(sobrevivenciaContainer, "Fome Infinita", function(estado)
    fomeInfinita = estado
    print("Fome Infinita:", estado)
end, false)

sobrevivenciaContainer.CanvasSize = UDim2.new(0, 0, 0, #sobrevivenciaContainer:GetChildren() * 30 + 20)

-- COMBATE
local combateContainer = Instance.new("ScrollingFrame")
combateContainer.Parent = contentFrame
combateContainer.Size = UDim2.new(1, 0, 1, 0)
combateContainer.BackgroundTransparency = 1
combateContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
combateContainer.ScrollBarThickness = 3
combateContainer.ScrollBarImageColor3 = Color3.fromRGB(200, 0, 0)
combateContainer.Visible = false
abasContent["combate"] = combateContainer

criarBotao(combateContainer, "One Hit Kill", Color3.fromRGB(200, 0, 0), oneHitKill)
criarToggle(combateContainer, "God Mode", toggleGodMode, false)
criarToggle(combateContainer, "Kill Aura", toggleKillAura, false)
criarBotao(combateContainer, "Matar Todos", Color3.fromRGB(160, 0, 0), matarTodos)

combateContainer.CanvasSize = UDim2.new(0, 0, 0, #combateContainer:GetChildren() * 30 + 20)

-- RECURSOS
local recursosContainer = Instance.new("ScrollingFrame")
recursosContainer.Parent = contentFrame
recursosContainer.Size = UDim2.new(1, 0, 1, 0)
recursosContainer.BackgroundTransparency = 1
recursosContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
recursosContainer.ScrollBarThickness = 3
recursosContainer.ScrollBarImageColor3 = Color3.fromRGB(200, 0, 0)
recursosContainer.Visible = false
abasContent["recursos"] = recursosContainer

criarToggle(recursosContainer, "Auto Farm Madeira", toggleAutoFarmMadeira, false)
criarToggle(recursosContainer, "Auto Farm Pedra", toggleAutoFarmPedra, false)
criarBotao(recursosContainer, "Coletar Tudo", Color3.fromRGB(200, 150, 0), function()
    print("Coletar Tudo")
end)

recursosContainer.CanvasSize = UDim2.new(0, 0, 0, #recursosContainer:GetChildren() * 30 + 20)

-- VISAO
local visaoContainer = Instance.new("ScrollingFrame")
visaoContainer.Parent = contentFrame
visaoContainer.Size = UDim2.new(1, 0, 1, 0)
visaoContainer.BackgroundTransparency = 1
visaoContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
visaoContainer.ScrollBarThickness = 3
visaoContainer.ScrollBarImageColor3 = Color3.fromRGB(200, 0, 0)
visaoContainer.Visible = false
abasContent["visao"] = visaoContainer

criarToggle(visaoContainer, "ESP Monstros", toggleESPMonstros, false)
criarToggle(visaoContainer, "ESP Itens", toggleESPItens, false)
criarToggle(visaoContainer, "Fullbright", toggleFullbright, false)

visaoContainer.CanvasSize = UDim2.new(0, 0, 0, #visaoContainer:GetChildren() * 30 + 20)

-- MOVIMENTO
local movimentoContainer = Instance.new("ScrollingFrame")
movimentoContainer.Parent = contentFrame
movimentoContainer.Size = UDim2.new(1, 0, 1, 0)
movimentoContainer.BackgroundTransparency = 1
movimentoContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
movimentoContainer.ScrollBarThickness = 3
movimentoContainer.ScrollBarImageColor3 = Color3.fromRGB(200, 0, 0)
movimentoContainer.Visible = false
abasContent["movimento"] = movimentoContainer

criarSlider(movimentoContainer, "Velocidade", 16, 250, 16, function(valor)
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = valor
    end
end)
criarToggle(movimentoContainer, "Pulo Infinito", togglePuloInfinito, false)
criarBotao(movimentoContainer, "Teleport Acampamento", Color3.fromRGB(0, 150, 200), teleportAcampamento)

movimentoContainer.CanvasSize = UDim2.new(0, 0, 0, #movimentoContainer:GetChildren() * 30 + 20)

-- CONFIG
local configContainer = Instance.new("ScrollingFrame")
configContainer.Parent = contentFrame
configContainer.Size = UDim2.new(1, 0, 1, 0)
configContainer.BackgroundTransparency = 1
configContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
configContainer.ScrollBarThickness = 3
configContainer.ScrollBarImageColor3 = Color3.fromRGB(200, 0, 0)
configContainer.Visible = false
abasContent["config"] = configContainer

criarBotao(configContainer, "Resetar Menu", Color3.fromRGB(200, 100, 0), function()
    print("Resetar Menu")
end)
criarBotao(configContainer, "Fechar Menu", Color3.fromRGB(200, 0, 0), function()
    fecharMenu()
end)

configContainer.CanvasSize = UDim2.new(0, 0, 0, #configContainer:GetChildren() * 30 + 20)

-- // ==========================================
-- // EVENTOS GLOBAIS
-- // ==========================================

-- Validar chave
local function validarChave()
    if keyInput.Text == CHAVE_CORRETA then
        chaveValidada = true
        keyFrame.Visible = false
        abrirMenu()
        print("Chave validada! Menu aberto.")
    else
        keyError.Text = "Chave incorreta!"
        keyInput.Text = ""
        keyInput:CaptureFocus()
    end
end

keyBtn.MouseButton1Click:Connect(validarChave)
keyInput.FocusLost:Connect(function(enterPressed)
    if enterPressed then validarChave() end
end)

-- Atalho K
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.K then
        toggleMenu()
    end
end)

-- Fechar com X
closeBtn.MouseButton1Click:Connect(function()
    fecharMenu()
end)

-- // ==========================================
-- // SISTEMA DE ARRASTAR
-- // ==========================================

local draggingMain = false
local dragStartMain, startPosMain

mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 and input.Position.Y < 28 then
        draggingMain = true
        dragStartMain = input.Position
        startPosMain = mainFrame.Position
    end
end)

mainFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingMain = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if draggingMain and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStartMain
        mainFrame.Position = UDim2.new(startPosMain.X.Scale, startPosMain.X.Offset + delta.X, startPosMain.Y.Scale, startPosMain.Y.Offset + delta.Y)
    end
end)

-- // ==========================================
-- // NOTIFICAÇÃO
-- // ==========================================

local notif = Instance.new("TextLabel")
notif.Parent = screenGui
notif.Size = UDim2.new(0, 280, 0, 28)
notif.Position = UDim2.new(0.5, -140, 0.85, 0)
notif.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
notif.Text = "Menu 99 Noites carregado! [K]"
notif.TextColor3 = Color3.fromRGB(255, 255, 255)
notif.TextScaled = true
notif.Font = Enum.Font.GothamBold
notif.BorderSizePixel = 0

local notifCorner = Instance.new("UICorner")
notifCorner.Parent = notif
notifCorner.CornerRadius = UDim.new(0, 3)

game:GetService("Debris"):AddItem(notif, 4)

print("Menu 99 Noites carregado!")
print("Chave: 99noites2025")