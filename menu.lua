-- // ============================================
-- // MENU 99 NOITES - SISTEMA DE CHAVES REFEITO
-- // ============================================

local player = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- // ========== CONFIGURAÇÕES ==========
local CHAVE_CORRETA = "99noites2025"
local chaveValidada = false
local menuAberto = false

-- // ========== CRIAR A GUI ==========
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player.PlayerGui
screenGui.Name = "Menu99Noites"
screenGui.ResetOnSpawn = false

-- // ==========================================
-- // SISTEMA DE CHAVE (DO ZERO)
-- // ==========================================

-- // Criar a janela de chave
local keyFrame = Instance.new("Frame")
keyFrame.Parent = screenGui
keyFrame.Size = UDim2.new(0, 320, 0, 180)
keyFrame.Position = UDim2.new(0.5, -160, 0.5, -90)
keyFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
keyFrame.BorderSizePixel = 2
keyFrame.BorderColor3 = Color3.fromRGB(200, 0, 0)
keyFrame.Visible = true

local keyCorner = Instance.new("UICorner")
keyCorner.Parent = keyFrame
keyCorner.CornerRadius = UDim.new(0, 6)

-- // Título
local keyTitle = Instance.new("TextLabel")
keyTitle.Parent = keyFrame
keyTitle.Size = UDim2.new(1, 0, 0, 35)
keyTitle.Position = UDim2.new(0, 0, 0, 0)
keyTitle.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
keyTitle.Text = "🔐 SISTEMA DE CHAVE"
keyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
keyTitle.TextScaled = true
keyTitle.Font = Enum.Font.GothamBold
keyTitle.BorderSizePixel = 0

-- // Subtítulo
local keySub = Instance.new("TextLabel")
keySub.Parent = keyFrame
keySub.Size = UDim2.new(1, -20, 0, 25)
keySub.Position = UDim2.new(0, 10, 0, 45)
keySub.BackgroundTransparency = 1
keySub.Text = "Digite a chave de acesso"
keySub.TextColor3 = Color3.fromRGB(180, 180, 180)
keySub.TextScaled = true
keySub.Font = Enum.Font.Gotham

-- // Campo de texto
local keyInput = Instance.new("TextBox")
keyInput.Parent = keyFrame
keyInput.Size = UDim2.new(0.8, 0, 0, 35)
keyInput.Position = UDim2.new(0.1, 0, 0, 80)
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

-- // Botão Confirmar
local keyBtn = Instance.new("TextButton")
keyBtn.Parent = keyFrame
keyBtn.Size = UDim2.new(0.4, 0, 0, 32)
keyBtn.Position = UDim2.new(0.3, 0, 0, 130)
keyBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
keyBtn.Text = "CONFIRMAR"
keyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
keyBtn.TextScaled = true
keyBtn.Font = Enum.Font.GothamBold
keyBtn.BorderSizePixel = 0

local keyBtnCorner = Instance.new("UICorner")
keyBtnCorner.Parent = keyBtn
keyBtnCorner.CornerRadius = UDim.new(0, 4)

-- // Mensagem de erro
local keyError = Instance.new("TextLabel")
keyError.Parent = keyFrame
keyError.Size = UDim2.new(1, 0, 0, 20)
keyError.Position = UDim2.new(0, 0, 0, 168)
keyError.BackgroundTransparency = 1
keyError.Text = ""
keyError.TextColor3 = Color3.fromRGB(255, 50, 50)
keyError.TextScaled = true
keyError.Font = Enum.Font.Gotham

-- // ==========================================
-- // FUNÇÃO DE VALIDAÇÃO (SIMPLES E DIRETA)
-- // ==========================================

local function validarChave()
    local chaveDigitada = keyInput.Text
    
    if chaveDigitada == CHAVE_CORRETA then
        -- Chave correta!
        chaveValidada = true
        keyFrame.Visible = false
        keyFrame.Visible = false
        
        -- Abrir o menu
        abrirMenu()
        
        -- Feedback visual
        print("✅ Chave validada com sucesso!")
    else
        -- Chave incorreta
        keyError.Text = "❌ Chave incorreta! Tente novamente."
        keyInput.Text = ""
        keyInput:CaptureFocus()
        
        -- Efeito de tremor
        local posX = keyFrame.Position.X.Offset
        for i = 1, 3 do
            keyFrame.Position = UDim2.new(0.5, posX + 5, 0.5, -90)
            wait(0.05)
            keyFrame.Position = UDim2.new(0.5, posX - 5, 0.5, -90)
            wait(0.05)
        end
        keyFrame.Position = UDim2.new(0.5, posX, 0.5, -90)
    end
end

-- // ==========================================
-- // EVENTOS DA CHAVE
-- // ==========================================

-- // Botão Confirmar
keyBtn.MouseButton1Click:Connect(function()
    validarChave()
end)

-- // Tecla Enter no campo de texto
keyInput.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        validarChave()
    end
end)

-- // Tecla Enter global (fallback)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.Return then
        if keyFrame.Visible and keyInput:IsFocused() then
            validarChave()
        end
    end
end)

-- // ==========================================
-- // JANELA PRINCIPAL DO MENU
-- // ==========================================

local mainFrame = Instance.new("Frame")
mainFrame.Parent = screenGui
mainFrame.Size = UDim2.new(0, 550, 0, 420)
mainFrame.Position = UDim2.new(0.5, -275, 0.5, -210)
mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
mainFrame.BorderSizePixel = 1
mainFrame.BorderColor3 = Color3.fromRGB(200, 0, 0)
mainFrame.Visible = false
mainFrame.BackgroundTransparency = 1

local mainCorner = Instance.new("UICorner")
mainCorner.Parent = mainFrame
mainCorner.CornerRadius = UDim.new(0, 4)

-- // ========== TOP BAR ==========
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

closeBtn.MouseButton1Click:Connect(function()
    fecharMenu()
end)

-- // ========== ABAS LATERAIS ==========
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

-- // ========== ÁREA DE CONTEÚDO ==========
local contentFrame = Instance.new("Frame")
contentFrame.Parent = mainFrame
contentFrame.Size = UDim2.new(1, -90, 1, -36)
contentFrame.Position = UDim2.new(0, 85, 0, 33)
contentFrame.BackgroundTransparency = 1

local abasContent = {}

-- // ==========================================
-- // FUNÇÕES DE CONTROLE DO MENU
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
    mainFrame.Size = UDim2.new(0, 450, 0, 420)
    
    TweenService:Create(mainFrame, TweenInfo.new(0.3), {
        BackgroundTransparency = 0,
        Size = UDim2.new(0, 550, 0, 420)
    }):Play()
end

function fecharMenu()
    menuAberto = false
    TweenService:Create(mainFrame, TweenInfo.new(0.2), {
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 450, 0, 420)
    }):Play()
    wait(0.2)
    mainFrame.Visible = false
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
-- // FUNÇÕES DE CRIAÇÃO DOS ELEMENTOS
-- // ==========================================

function criarToggle(container, texto, callback, valorInicial)
    local frame = Instance.new("Frame")
    frame.Parent = container
    frame.Size = UDim2.new(1, -10, 0, 26)
    frame.Position = UDim2.new(0, 5, 0, #container:GetChildren() * 28 + 5)
    frame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
    frame.BorderSizePixel = 0
    frame.BackgroundTransparency = 0.3
    
    local border = Instance.new("Frame")
    border.Parent = frame
    border.Size = UDim2.new(1, 0, 0, 1)
    border.Position = UDim2.new(0, 0, 1, -1)
    border.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    border.BorderSizePixel = 0
    
    local label = Instance.new("TextLabel")
    label.Parent = frame
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.Position = UDim2.new(0, 6, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = texto
    label.TextColor3 = Color3.fromRGB(220, 220, 220)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextScaled = true
    label.Font = Enum.Font.Gotham
    
    local switch = Instance.new("Frame")
    switch.Parent = frame
    switch.Size = UDim2.new(0, 32, 0, 16)
    switch.Position = UDim2.new(1, -38, 0.5, -8)
    switch.BackgroundColor3 = valorInicial and Color3.fromRGB(0, 180, 50) or Color3.fromRGB(150, 30, 30)
    switch.BorderSizePixel = 0
    
    local switchCorner = Instance.new("UICorner")
    switchCorner.Parent = switch
    switchCorner.CornerRadius = UDim.new(1, 0)
    
    local thumb = Instance.new("Frame")
    thumb.Parent = switch
    thumb.Size = UDim2.new(0, 12, 0, 12)
    thumb.Position = valorInicial and UDim2.new(0, 18, 0.5, -6) or UDim2.new(0, 2, 0.5, -6)
    thumb.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    thumb.BorderSizePixel = 0
    
    local thumbCorner = Instance.new("UICorner")
    thumbCorner.Parent = thumb
    thumbCorner.CornerRadius = UDim.new(1, 0)
    
    local estado = valorInicial or false
    
    local function toggleSwitch()
        estado = not estado
        if estado then
            switch.BackgroundColor3 = Color3.fromRGB(0, 180, 50)
            thumb.Position = UDim2.new(0, 18, 0.5, -6)
        else
            switch.BackgroundColor3 = Color3.fromRGB(150, 30, 30)
            thumb.Position = UDim2.new(0, 2, 0.5, -6)
        end
        callback(estado)
    end
    
    switch.MouseButton1Click:Connect(toggleSwitch)
    label.MouseButton1Click:Connect(toggleSwitch)
    frame.MouseButton1Click:Connect(toggleSwitch)
    
    return frame
end

function criarBotao(container, texto, cor, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = container
    btn.Size = UDim2.new(1, -10, 0, 26)
    btn.Position = UDim2.new(0, 5, 0, #container:GetChildren() * 28 + 5)
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
    frame.Size = UDim2.new(1, -10, 0, 30)
    frame.Position = UDim2.new(0, 5, 0, #container:GetChildren() * 28 + 5)
    frame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
    frame.BorderSizePixel = 0
    frame.BackgroundTransparency = 0.3
    
    local border = Instance.new("Frame")
    border.Parent = frame
    border.Size = UDim2.new(1, 0, 0, 1)
    border.Position = UDim2.new(0, 0, 1, -1)
    border.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    border.BorderSizePixel = 0
    
    local label = Instance.new("TextLabel")
    label.Parent = frame
    label.Size = UDim2.new(0.35, 0, 1, 0)
    label.Position = UDim2.new(0, 6, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = texto
    label.TextColor3 = Color3.fromRGB(220, 220, 220)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextScaled = true
    label.Font = Enum.Font.Gotham
    
    local valorLabel = Instance.new("TextLabel")
    valorLabel.Parent = frame
    valorLabel.Size = UDim2.new(0.1, 0, 1, 0)
    valorLabel.Position = UDim2.new(0.38, 0, 0, 0)
    valorLabel.BackgroundTransparency = 1
    valorLabel.Text = tostring(padrao)
    valorLabel.TextColor3 = Color3.fromRGB(200, 0, 0)
    valorLabel.TextXAlignment = Enum.TextXAlignment.Center
    valorLabel.TextScaled = true
    valorLabel.Font = Enum.Font.GothamBold
    
    local sliderBar = Instance.new("Frame")
    sliderBar.Parent = frame
    sliderBar.Size = UDim2.new(0.45, 0, 0, 4)
    sliderBar.Position = UDim2.new(0.5, 0, 0.5, -2)
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
    label.Size = UDim2.new(1, -10, 0, 18)
    label.Position = UDim2.new(0, 5, 0, #container:GetChildren() * 20 + 5)
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

-- // SOBREVIVENCIA
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
criarToggle(sobrevivenciaContainer, "Auto Heal", function(estado) print("Auto Heal:", estado) end, true)
criarToggle(sobrevivenciaContainer, "Fome Infinita", function(estado) print("Fome Infinita:", estado) end, false)

sobrevivenciaContainer.CanvasSize = UDim2.new(0, 0, 0, #sobrevivenciaContainer:GetChildren() * 28 + 20)

-- // COMBATE
local combateContainer = Instance.new("ScrollingFrame")
combateContainer.Parent = contentFrame
combateContainer.Size = UDim2.new(1, 0, 1, 0)
combateContainer.BackgroundTransparency = 1
combateContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
combateContainer.ScrollBarThickness = 3
combateContainer.ScrollBarImageColor3 = Color3.fromRGB(200, 0, 0)
combateContainer.Visible = false
abasContent["combate"] = combateContainer

criarBotao(combateContainer, "One Hit Kill", Color3.fromRGB(200, 0, 0), function() print("One Hit Kill") end)
criarToggle(combateContainer, "God Mode", function(estado) print("God Mode:", estado) end, false)
criarToggle(combateContainer, "Kill Aura", function(estado) print("Kill Aura:", estado) end, false)
criarBotao(combateContainer, "Matar Todos", Color3.fromRGB(160, 0, 0), function() print("Matar Todos") end)

combateContainer.CanvasSize = UDim2.new(0, 0, 0, #combateContainer:GetChildren() * 28 + 20)

-- // RECURSOS
local recursosContainer = Instance.new("ScrollingFrame")
recursosContainer.Parent = contentFrame
recursosContainer.Size = UDim2.new(1, 0, 1, 0)
recursosContainer.BackgroundTransparency = 1
recursosContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
recursosContainer.ScrollBarThickness = 3
recursosContainer.ScrollBarImageColor3 = Color3.fromRGB(200, 0, 0)
recursosContainer.Visible = false
abasContent["recursos"] = recursosContainer

criarToggle(recursosContainer, "Auto Farm Madeira", function(estado) print("Auto Farm Madeira:", estado) end, false)
criarToggle(recursosContainer, "Auto Farm Pedra", function(estado) print("Auto Farm Pedra:", estado) end, false)
criarToggle(recursosContainer, "Farm Rapido", function(estado) print("Farm Rapido:", estado) end, false)
criarBotao(recursosContainer, "Coletar Tudo", Color3.fromRGB(200, 150, 0), function() print("Coletar Tudo") end)

recursosContainer.CanvasSize = UDim2.new(0, 0, 0, #recursosContainer:GetChildren() * 28 + 20)

-- // VISAO
local visaoContainer = Instance.new("ScrollingFrame")
visaoContainer.Parent = contentFrame
visaoContainer.Size = UDim2.new(1, 0, 1, 0)
visaoContainer.BackgroundTransparency = 1
visaoContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
visaoContainer.ScrollBarThickness = 3
visaoContainer.ScrollBarImageColor3 = Color3.fromRGB(200, 0, 0)
visaoContainer.Visible = false
abasContent["visao"] = visaoContainer

criarToggle(visaoContainer, "ESP Monstros", function(estado) print("ESP Monstros:", estado) end, false)
criarToggle(visaoContainer, "ESP Itens", function(estado) print("ESP Itens:", estado) end, false)
criarToggle(visaoContainer, "Fullbright", function(estado) print("Fullbright:", estado) end, false)

visaoContainer.CanvasSize = UDim2.new(0, 0, 0, #visaoContainer:GetChildren() * 28 + 20)

-- // MOVIMENTO
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
    print("Velocidade:", valor)
end)
criarToggle(movimentoContainer, "Pulo Infinito", function(estado) print("Pulo Infinito:", estado) end, false)
criarBotao(movimentoContainer, "Teleport Acampamento", Color3.fromRGB(0, 150, 200), function() print("Teleport Acampamento") end)

movimentoContainer.CanvasSize = UDim2.new(0, 0, 0, #movimentoContainer:GetChildren() * 28 + 20)

-- // CONFIG
local configContainer = Instance.new("ScrollingFrame")
configContainer.Parent = contentFrame
configContainer.Size = UDim2.new(1, 0, 1, 0)
configContainer.BackgroundTransparency = 1
configContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
configContainer.ScrollBarThickness = 3
configContainer.ScrollBarImageColor3 = Color3.fromRGB(200, 0, 0)
configContainer.Visible = false
abasContent["config"] = configContainer

criarBotao(configContainer, "Resetar Menu", Color3.fromRGB(200, 100, 0), function() print("Resetar Menu") end)
criarBotao(configContainer, "Fechar Menu", Color3.fromRGB(200, 0, 0), function() fecharMenu() end)

configContainer.CanvasSize = UDim2.new(0, 0, 0, #configContainer:GetChildren() * 28 + 20)

-- // ==========================================
-- // ATALHO DO TECLADO (K)
-- // ==========================================

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.K then
        toggleMenu()
    end
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
-- // NOTIFICAÇÃO INICIAL
-- // ==========================================

local notif = Instance.new("TextLabel")
notif.Parent = screenGui
notif.Size = UDim2.new(0, 280, 0, 28)
notif.Position = UDim2.new(0.5, -140, 0.85, 0)
notif.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
notif.Text = "🔑 Digite a chave para acessar"
notif.TextColor3 = Color3.fromRGB(255, 255, 255)
notif.TextScaled = true
notif.Font = Enum.Font.GothamBold
notif.BorderSizePixel = 0

local notifCorner = Instance.new("UICorner")
notifCorner.Parent = notif
notifCorner.CornerRadius = UDim.new(0, 3)

game:GetService("Debris"):AddItem(notif, 4)

print("✅ Menu 99 Noites carregado!")
print("🔑 Chave: 99noites2025")
print("📌 Digite a chave e confirme")