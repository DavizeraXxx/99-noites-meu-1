-- // ============================================
-- // PROTON MENU - BETA 1.0
-- // 99 NOITES
-- // ============================================

local player = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")

-- // ==========================================
-- // VARIAVEIS GLOBAIS
-- // ==========================================

local menuAberto = false
local corAtual = Color3.fromRGB(200, 0, 0)

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

function toggleGodMode(valor)
    godMode = valor
    if valor then
        player.Character.Humanoid.MaxHealth = math.huge
        player.Character.Humanoid.Health = math.huge
    else
        player.Character.Humanoid.MaxHealth = 100
        player.Character.Humanoid.Health = 100
    end
end

function togglePuloInfinito(valor)
    puloInfinito = valor
end

function oneHitKill()
    local enemies = workspace:FindFirstChild("Enemies") or workspace:FindFirstChild("Monsters")
    if enemies then
        for _, v in ipairs(enemies:GetChildren()) do
            if v:FindFirstChild("Humanoid") then
                v.Humanoid.Health = 0
            end
        end
    end
end

function matarTodos()
    local enemies = workspace:FindFirstChild("Enemies") or workspace:FindFirstChild("Monsters")
    if enemies then
        for _, v in ipairs(enemies:GetChildren()) do
            if v:FindFirstChild("Humanoid") then
                v.Humanoid.Health = 0
            end
        end
    end
end

function toggleKillAura(valor)
    killAura = valor
end

function toggleAutoFarmMadeira(valor)
    autoFarmMadeira = valor
end

function toggleAutoFarmPedra(valor)
    autoFarmPedra = valor
end

function toggleESPMonstros(valor)
    espMonstros = valor
end

function toggleESPItens(valor)
    espItens = valor
end

function toggleFullbright(valor)
    fullbright = valor
    if valor then
        Lighting.Brightness = 10
        Lighting.Ambient = Color3.fromRGB(255, 255, 255)
    else
        Lighting.Brightness = 1
        Lighting.Ambient = Color3.fromRGB(0, 0, 0)
    end
end

function teleportAcampamento()
    local camp = workspace:FindFirstChild("Acampamento") or workspace:FindFirstChild("Camp")
    if camp then
        player.Character.HumanoidRootPart.CFrame = camp.CFrame + Vector3.new(0, 5, 0)
    end
end

-- // ==========================================
-- // LOOPS
-- // ==========================================

RunService.Heartbeat:Connect(function()
    if puloInfinito then
        local char = player.Character
        if char and char:FindFirstChild("Humanoid") then
            local hum = char.Humanoid
            if hum:GetState() == Enum.HumanoidStateType.Landed then
                hum:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
    end
    
    if killAura then
        local enemies = workspace:FindFirstChild("Enemies") or workspace:FindFirstChild("Monsters")
        if enemies then
            for _, v in ipairs(enemies:GetChildren()) do
                if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                    local dist = (v.Position - player.Character.HumanoidRootPart.Position).Magnitude
                    if dist < 50 then
                        v.Humanoid.Health = 0
                    end
                end
            end
        end
    end
end)

-- // ==========================================
-- // CRIAR GUI
-- // ==========================================

local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player.PlayerGui
screenGui.Name = "ProtonMenu"
screenGui.ResetOnSpawn = false

-- // ==========================================
-- // SISTEMA DE CHAVE (DIFERENTE)
-- // ==========================================

local keyFrame = Instance.new("Frame")
keyFrame.Parent = screenGui
keyFrame.Size = UDim2.new(0, 280, 0, 140)
keyFrame.Position = UDim2.new(0.5, -140, 0.5, -70)
keyFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
keyFrame.BorderSizePixel = 2
keyFrame.BorderColor3 = corAtual
keyFrame.Visible = true
keyFrame.Active = true
keyFrame.Draggable = true

local keyCorner = Instance.new("UICorner")
keyCorner.Parent = keyFrame
keyCorner.CornerRadius = UDim.new(0, 6)

local keyTitle = Instance.new("TextLabel")
keyTitle.Parent = keyFrame
keyTitle.Size = UDim2.new(1, 0, 0, 30)
keyTitle.BackgroundColor3 = corAtual
keyTitle.Text = "PROTON MENU"
keyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
keyTitle.TextScaled = true
keyTitle.Font = Enum.Font.GothamBold
keyTitle.BorderSizePixel = 0

local keySub = Instance.new("TextLabel")
keySub.Parent = keyFrame
keySub.Size = UDim2.new(1, -20, 0, 20)
keySub.Position = UDim2.new(0, 10, 0, 38)
keySub.BackgroundTransparency = 1
keySub.Text = "beta 1.0"
keySub.TextColor3 = Color3.fromRGB(150, 150, 150)
keySub.TextScaled = true
keySub.Font = Enum.Font.Gotham

local keyInput = Instance.new("TextBox")
keyInput.Parent = keyFrame
keyInput.Size = UDim2.new(0.7, 0, 0, 30)
keyInput.Position = UDim2.new(0.15, 0, 0, 65)
keyInput.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
keyInput.BorderSizePixel = 1
keyInput.BorderColor3 = corAtual
keyInput.Text = ""
keyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
keyInput.TextScaled = true
keyInput.Font = Enum.Font.Gotham
keyInput.PlaceholderText = "chave..."
keyInput.ClearTextOnFocus = true

local keyBtn = Instance.new("TextButton")
keyBtn.Parent = keyFrame
keyBtn.Size = UDim2.new(0.3, 0, 0, 28)
keyBtn.Position = UDim2.new(0.35, 0, 0, 105)
keyBtn.BackgroundColor3 = corAtual
keyBtn.Text = "ENTRAR"
keyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
keyBtn.TextScaled = true
keyBtn.Font = Enum.Font.GothamBold
keyBtn.BorderSizePixel = 0

local keyBtnCorner = Instance.new("UICorner")
keyBtnCorner.Parent = keyBtn
keyBtnCorner.CornerRadius = UDim.new(0, 4)

local keyError = Instance.new("TextLabel")
keyError.Parent = keyFrame
keyError.Size = UDim2.new(1, 0, 0, 16)
keyError.Position = UDim2.new(0, 0, 0, 135)
keyError.BackgroundTransparency = 1
keyError.Text = ""
keyError.TextColor3 = Color3.fromRGB(255, 50, 50)
keyError.TextScaled = true
keyError.Font = Enum.Font.Gotham

-- // ==========================================
-- // JANELA PRINCIPAL
-- // ==========================================

local mainFrame = Instance.new("Frame")
mainFrame.Parent = screenGui
mainFrame.Size = UDim2.new(0, 500, 0, 380)
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -190)
mainFrame.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = corAtual
mainFrame.Visible = false
mainFrame.Active = true
mainFrame.Draggable = true

local mainCorner = Instance.new("UICorner")
mainCorner.Parent = mainFrame
mainCorner.CornerRadius = UDim.new(0, 6)

-- // TOP BAR
local topBar = Instance.new("Frame")
topBar.Parent = mainFrame
topBar.Size = UDim2.new(1, 0, 0, 28)
topBar.BackgroundColor3 = corAtual
topBar.BorderSizePixel = 0

local topCorner = Instance.new("UICorner")
topCorner.Parent = topBar
topCorner.CornerRadius = UDim.new(0, 6)

local titleLbl = Instance.new("TextLabel")
titleLbl.Parent = topBar
titleLbl.Size = UDim2.new(0.6, 0, 1, 0)
titleLbl.Position = UDim2.new(0, 10, 0, 0)
titleLbl.BackgroundTransparency = 1
titleLbl.Text = "PROTON MENU"
titleLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLbl.TextScaled = true
titleLbl.Font = Enum.Font.GothamBold
titleLbl.TextXAlignment = Enum.TextXAlignment.Left

local versionLbl = Instance.new("TextLabel")
versionLbl.Parent = topBar
versionLbl.Size = UDim2.new(0.3, 0, 1, 0)
versionLbl.Position = UDim2.new(0.6, 0, 0, 0)
versionLbl.BackgroundTransparency = 1
versionLbl.Text = "beta 1.0"
versionLbl.TextColor3 = Color3.fromRGB(200, 200, 200)
versionLbl.TextScaled = true
versionLbl.Font = Enum.Font.Gotham
versionLbl.TextXAlignment = Enum.TextXAlignment.Right

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

-- // ABAS
local tabBar = Instance.new("Frame")
tabBar.Parent = mainFrame
tabBar.Size = UDim2.new(1, 0, 0, 30)
tabBar.Position = UDim2.new(0, 0, 0, 28)
tabBar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
tabBar.BorderSizePixel = 0

local tabs = {
    {id = "combate", nome = "COMBATE"},
    {id = "recursos", nome = "RECURSOS"},
    {id = "visao", nome = "VISAO"},
    {id = "movimento", nome = "MOV"},
    {id = "cores", nome = "CORES"}
}

local tabBtns = {}
local tabAtual = "combate"

for i, tab in ipairs(tabs) do
    local btn = Instance.new("TextButton")
    btn.Parent = tabBar
    btn.Size = UDim2.new(1 / #tabs, -2, 1, -4)
    btn.Position = UDim2.new((i - 1) / #tabs, 1, 0, 2)
    btn.BackgroundColor3 = (i == 1) and corAtual or Color3.fromRGB(20, 20, 20)
    btn.Text = tab.nome
    btn.TextColor3 = (i == 1) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(150, 150, 150)
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamSemibold
    btn.BorderSizePixel = 0
    btn.Name = tab.id
    
    btn.MouseButton1Click:Connect(function()
        for _, b in pairs(tabBtns) do
            b.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            b.TextColor3 = Color3.fromRGB(150, 150, 150)
        end
        btn.BackgroundColor3 = corAtual
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        tabAtual = tab.id
        atualizarTabs(tab.id)
    end)
    
    tabBtns[tab.id] = btn
end

-- // CONTEUDO
local content = Instance.new("Frame")
content.Parent = mainFrame
content.Size = UDim2.new(1, -20, 1, -78)
content.Position = UDim2.new(0, 10, 0, 62)
content.BackgroundTransparency = 1

local tabContent = {}

-- // ==========================================
-- // FUNÇÕES
-- // ==========================================

function atualizarTabs(id)
    for k, v in pairs(tabContent) do
        v.Visible = (k == id)
    end
end

function abrirMenu()
    menuAberto = true
    mainFrame.Visible = true
    mainFrame.BackgroundTransparency = 1
    TweenService:Create(mainFrame, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
end

function fecharMenu()
    menuAberto = false
    TweenService:Create(mainFrame, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
    wait(0.2)
    mainFrame.Visible = false
end

function toggleMenu()
    if menuAberto then
        fecharMenu()
    else
        abrirMenu()
    end
end

-- // ==========================================
-- // CRIAR ELEMENTOS
-- // ==========================================

function criarToggle(container, texto, callback, padrao)
    local frame = Instance.new("Frame")
    frame.Parent = container
    frame.Size = UDim2.new(1, -10, 0, 26)
    frame.Position = UDim2.new(0, 5, 0, #container:GetChildren() * 28 + 5)
    frame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
    frame.BorderSizePixel = 0
    
    local border = Instance.new("Frame")
    border.Parent = frame
    border.Size = UDim2.new(1, 0, 0, 1)
    border.Position = UDim2.new(0, 0, 1, -1)
    border.BackgroundColor3 = corAtual
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
    
    local check = Instance.new("ImageButton")
    check.Parent = frame
    check.Size = UDim2.new(0, 18, 0, 18)
    check.Position = UDim2.new(1, -26, 0.5, -9)
    check.BackgroundColor3 = padrao and Color3.fromRGB(0, 180, 50) or Color3.fromRGB(50, 50, 50)
    check.BorderSizePixel = 1
    check.BorderColor3 = Color3.fromRGB(100, 100, 100)
    check.Image = ""
    
    local checkCorner = Instance.new("UICorner")
    checkCorner.Parent = check
    checkCorner.CornerRadius = UDim.new(0, 2)
    
    local mark = Instance.new("TextLabel")
    mark.Parent = check
    mark.Size = UDim2.new(1, 0, 1, 0)
    mark.BackgroundTransparency = 1
    mark.Text = padrao and "✓" or ""
    mark.TextColor3 = Color3.fromRGB(255, 255, 255)
    mark.TextScaled = true
    mark.Font = Enum.Font.GothamBold
    
    local estado = padrao or false
    
    local function toggle()
        estado = not estado
        if estado then
            check.BackgroundColor3 = Color3.fromRGB(0, 180, 50)
            mark.Text = "✓"
        else
            check.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            mark.Text = ""
        end
        callback(estado)
    end
    
    check.MouseButton1Click:Connect(toggle)
    label.MouseButton1Click:Connect(toggle)
    
    return frame
end

function criarBotao(container, texto, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = container
    btn.Size = UDim2.new(1, -10, 0, 26)
    btn.Position = UDim2.new(0, 5, 0, #container:GetChildren() * 28 + 5)
    btn.BackgroundColor3 = corAtual
    btn.Text = texto
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamSemibold
    btn.BorderSizePixel = 0
    btn.BackgroundTransparency = 0.2
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.Parent = btn
    btnCorner.CornerRadius = UDim.new(0, 3)
    
    btn.MouseButton1Click:Connect(callback)
    
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundTransparency = 0}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundTransparency = 0.2}):Play()
    end)
    
    return btn
end

function criarSlider(container, texto, min, max, padrao, callback)
    local frame = Instance.new("Frame")
    frame.Parent = container
    frame.Size = UDim2.new(1, -10, 0, 32)
    frame.Position = UDim2.new(0, 5, 0, #container:GetChildren() * 28 + 5)
    frame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
    frame.BorderSizePixel = 0
    
    local border = Instance.new("Frame")
    border.Parent = frame
    border.Size = UDim2.new(1, 0, 0, 1)
    border.Position = UDim2.new(0, 0, 1, -1)
    border.BackgroundColor3 = corAtual
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
    
    local valLbl = Instance.new("TextLabel")
    valLbl.Parent = frame
    valLbl.Size = UDim2.new(0.08, 0, 1, 0)
    valLbl.Position = UDim2.new(0.32, 0, 0, 0)
    valLbl.BackgroundTransparency = 1
    valLbl.Text = tostring(padrao)
    valLbl.TextColor3 = corAtual
    valLbl.TextXAlignment = Enum.TextXAlignment.Center
    valLbl.TextScaled = true
    valLbl.Font = Enum.Font.GothamBold
    
    local bar = Instance.new("Frame")
    bar.Parent = frame
    bar.Size = UDim2.new(0.5, 0, 0, 4)
    bar.Position = UDim2.new(0.42, 0, 0.5, -2)
    bar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    bar.BorderSizePixel = 0
    
    local barCorner = Instance.new("UICorner")
    barCorner.Parent = bar
    barCorner.CornerRadius = UDim.new(1, 0)
    
    local fill = Instance.new("Frame")
    fill.Parent = bar
    fill.Size = UDim2.new((padrao - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = corAtual
    fill.BorderSizePixel = 0
    
    local fillCorner = Instance.new("UICorner")
    fillCorner.Parent = fill
    fillCorner.CornerRadius = UDim.new(1, 0)
    
    local valor = padrao
    local dragging = false
    
    bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)
    
    bar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local mx = input.Position.X
            local bx = bar.AbsolutePosition.X
            local bw = bar.AbsoluteSize.X
            local p = math.clamp((mx - bx) / bw, 0, 1)
            valor = math.round(min + (max - min) * p)
            fill.Size = UDim2.new(p, 0, 1, 0)
            valLbl.Text = tostring(valor)
            callback(valor)
        end
    end)
    
    return frame
end

-- // ==========================================
-- // CRIAR ABAS
-- // ==========================================

-- COMBATE
local combateTab = Instance.new("ScrollingFrame")
combateTab.Parent = content
combateTab.Size = UDim2.new(1, 0, 1, 0)
combateTab.BackgroundTransparency = 1
combateTab.CanvasSize = UDim2.new(0, 0, 0, 0)
combateTab.ScrollBarThickness = 3
combateTab.ScrollBarImageColor3 = corAtual
combateTab.Visible = true
tabContent["combate"] = combateTab

criarBotao(combateTab, "ONE HIT KILL", oneHitKill)
criarToggle(combateTab, "GOD MODE", toggleGodMode, false)
criarToggle(combateTab, "KILL AURA", toggleKillAura, false)
criarBotao(combateTab, "MATAR TODOS", matarTodos)

combateTab.CanvasSize = UDim2.new(0, 0, 0, #combateTab:GetChildren() * 28 + 20)

-- RECURSOS
local recursosTab = Instance.new("ScrollingFrame")
recursosTab.Parent = content
recursosTab.Size = UDim2.new(1, 0, 1, 0)
recursosTab.BackgroundTransparency = 1
recursosTab.CanvasSize = UDim2.new(0, 0, 0, 0)
recursosTab.ScrollBarThickness = 3
recursosTab.ScrollBarImageColor3 = corAtual
recursosTab.Visible = false
tabContent["recursos"] = recursosTab

criarToggle(recursosTab, "AUTO FARM MADEIRA", toggleAutoFarmMadeira, false)
criarToggle(recursosTab, "AUTO FARM PEDRA", toggleAutoFarmPedra, false)
criarBotao(recursosTab, "COLETAR TUDO", function()
    print("Coletar tudo")
end)

recursosTab.CanvasSize = UDim2.new(0, 0, 0, #recursosTab:GetChildren() * 28 + 20)

-- VISAO
local visaoTab = Instance.new("ScrollingFrame")
visaoTab.Parent = content
visaoTab.Size = UDim2.new(1, 0, 1, 0)
visaoTab.BackgroundTransparency = 1
visaoTab.CanvasSize = UDim2.new(0, 0, 0, 0)
visaoTab.ScrollBarThickness = 3
visaoTab.ScrollBarImageColor3 = corAtual
visaoTab.Visible = false
tabContent["visao"] = visaoTab

criarToggle(visaoTab, "ESP MONSTROS", toggleESPMonstros, false)
criarToggle(visaoTab, "ESP ITENS", toggleESPItens, false)
criarToggle(visaoTab, "FULLBRIGHT", toggleFullbright, false)

visaoTab.CanvasSize = UDim2.new(0, 0, 0, #visaoTab:GetChildren() * 28 + 20)

-- MOVIMENTO
local movimentoTab = Instance.new("ScrollingFrame")
movimentoTab.Parent = content
movimentoTab.Size = UDim2.new(1, 0, 1, 0)
movimentoTab.BackgroundTransparency = 1
movimentoTab.CanvasSize = UDim2.new(0, 0, 0, 0)
movimentoTab.ScrollBarThickness = 3
movimentoTab.ScrollBarImageColor3 = corAtual
movimentoTab.Visible = false
tabContent["movimento"] = movimentoTab

criarSlider(movimentoTab, "VELOCIDADE", 16, 250, 16, function(val)
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = val
    end
end)
criarToggle(movimentoTab, "PULO INFINITO", togglePuloInfinito, false)
criarBotao(movimentoTab, "TELEPORT ACAMPAMENTO", teleportAcampamento)

movimentoTab.CanvasSize = UDim2.new(0, 0, 0, #movimentoTab:GetChildren() * 28 + 20)

-- CORES
local coresTab = Instance.new("ScrollingFrame")
coresTab.Parent = content
coresTab.Size = UDim2.new(1, 0, 1, 0)
coresTab.BackgroundTransparency = 1
coresTab.CanvasSize = UDim2.new(0, 0, 0, 0)
coresTab.ScrollBarThickness = 3
coresTab.ScrollBarImageColor3 = corAtual
coresTab.Visible = false
tabContent["cores"] = coresTab

local cores = {
    {nome = "VERMELHO", cor = Color3.fromRGB(200, 0, 0)},
    {nome = "AZUL", cor = Color3.fromRGB(0, 100, 255)},
    {nome = "VERDE", cor = Color3.fromRGB(0, 200, 50)},
    {nome = "ROXO", cor = Color3.fromRGB(150, 0, 255)},
    {nome = "LARANJA", cor = Color3.fromRGB(255, 150, 0)},
    {nome = "BRANCO", cor = Color3.fromRGB(255, 255, 255)}
}

for _, c in ipairs(cores) do
    local btn = Instance.new("TextButton")
    btn.Parent = coresTab
    btn.Size = UDim2.new(0.45, 0, 0, 30)
    btn.Position = UDim2.new((_ % 2 == 0) and 0.5 or 0.02, 0, 0, math.floor(_ / 2) * 35 + 5)
    btn.BackgroundColor3 = c.cor
    btn.Text = c.nome
    btn.TextColor3 = (c.cor == Color3.fromRGB(255, 255, 255)) and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(255, 255, 255)
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamBold
    btn.BorderSizePixel = 0
    btn.BackgroundTransparency = 0.2
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.Parent = btn
    btnCorner.CornerRadius = UDim.new(0, 3)
    
    btn.MouseButton1Click:Connect(function()
        corAtual = c.cor
        keyFrame.BorderColor3 = corAtual
        keyTitle.BackgroundColor3 = corAtual
        keyInput.BorderColor3 = corAtual
        keyBtn.BackgroundColor3 = corAtual
        mainFrame.BorderColor3 = corAtual
        topBar.BackgroundColor3 = corAtual
        for _, b in pairs(tabBtns) do
            if b.BackgroundColor3 == corAtual then
                b.BackgroundColor3 = corAtual
            end
        end
        for _, container in pairs(tabContent) do
            container.ScrollBarImageColor3 = corAtual
            for _, child in ipairs(container:GetChildren()) do
                if child:IsA("Frame") and child:FindFirstChild("Border") then
                    child.Border.BackgroundColor3 = corAtual
                end
            end
        end
    end)
end

coresTab.CanvasSize = UDim2.new(0, 0, 0, math.ceil(#cores / 2) * 35 + 20)

-- // ==========================================
-- // VALIDAR CHAVE
-- // ==========================================

local function validarChave()
    if keyInput.Text == "proton2025" then
        keyFrame.Visible = false
        abrirMenu()
    else
        keyError.Text = "chave incorreta"
        keyInput.Text = ""
        keyInput:CaptureFocus()
    end
end

keyBtn.MouseButton1Click:Connect(validarChave)
keyInput.FocusLost:Connect(function(enter)
    if enter then validarChave() end
end)

-- // ==========================================
-- // ATALHOS
-- // ==========================================

UserInputService.InputBegan:Connect(function(input, processed)
    if not processed and input.KeyCode == Enum.KeyCode.K then
        if keyFrame.Visible then
            validarChave()
        else
            toggleMenu()
        end
    end
end)

closeBtn.MouseButton1Click:Connect(fecharMenu)

-- // ==========================================
-- // NOTIFICACAO
-- // ==========================================

local notif = Instance.new("TextLabel")
notif.Parent = screenGui
notif.Size = UDim2.new(0, 240, 0, 26)
notif.Position = UDim2.new(0.5, -120, 0.85, 0)
notif.BackgroundColor3 = corAtual
notif.Text = "PROTON MENU [K]"
notif.TextColor3 = Color3.fromRGB(255, 255, 255)
notif.TextScaled = true
notif.Font = Enum.Font.GothamBold
notif.BorderSizePixel = 0

local notifCorner = Instance.new("UICorner")
notifCorner.Parent = notif
notifCorner.CornerRadius = UDim.new(0, 3)

game:GetService("Debris"):AddItem(notif, 3)

print("PROTON MENU - BETA 1.0")
print("CHAVE: proton2025")