-- // ============================================
-- // PROTON MENU - MORPHUP! EDITION
-- // AUTO FARM XP - DESTRAVAR FORMAS - PVP - ATTACK ALL
-- // ============================================

local player = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

-- // ==========================================
-- // VARIAVEIS
-- // ==========================================

local menuAberto = true
local corAtual = Color3.fromRGB(200, 0, 0)

-- // ==========================================
-- // ESTADOS DAS FUNÇÕES
-- // ==========================================

local estados = {
    autoFarmXP = false,
    autoEvolve = false,
    autoPvP = false,
    attackAll = false,
    unlockAll = false
}

-- // ==========================================
-- // FUNÇÕES DO JOGO (ADAPTÁVEIS)
-- // ==========================================

-- // AUTO FARM XP - Coleta XP automático
function toggleAutoFarmXP()
    estados.autoFarmXP = not estados.autoFarmXP
    print("Auto Farm XP:", estados.autoFarmXP and "ON" or "OFF")
end

-- // AUTO EVOLVE - Evolui automaticamente
function toggleAutoEvolve()
    estados.autoEvolve = not estados.autoEvolve
    print("Auto Evolve:", estados.autoEvolve and "ON" or "OFF")
end

-- // AUTO PVP - Luta automaticamente contra outros jogadores
function toggleAutoPvP()
    estados.autoPvP = not estados.autoPvP
    print("Auto PvP:", estados.autoPvP and "ON" or "OFF")
end

-- // ATTACK ALL - Ataca todos os inimigos próximos
function toggleAttackAll()
    estados.attackAll = not estados.attackAll
    print("Attack All:", estados.attackAll and "ON" or "OFF")
end

-- // DESTRAVAR TODAS AS FORMAS
function unlockAllForms()
    print("Tentando destravar todas as formas...")
    -- Tenta encontrar o sistema de formas
    local morphSystem = player:FindFirstChild("MorphSystem") or 
                        player.PlayerGui:FindFirstChild("MorphSystem") or
                        Workspace:FindFirstChild("MorphSystem")
    
    if morphSystem then
        print("Sistema de formas encontrado!")
        -- Código para destravar formas (depende da estrutura do jogo)
        -- Como o jogo está em Alpha, isso pode variar
    else
        print("Sistema de formas não encontrado. Tentando alternativa...")
        -- Tentativa alternativa: procurar por botões de desbloqueio na GUI
        local gui = player.PlayerGui:FindFirstChild("MorphGUI") or player.PlayerGui:FindFirstChild("MainGUI")
        if gui then
            print("GUI encontrada, tentando destravar formas...")
            for _, child in ipairs(gui:GetDescendants()) do
                if child:IsA("TextButton") and (child.Text:lower():find("unlock") or child.Text:lower():find("desbloquear")) then
                    child:Click()
                    wait(0.1)
                end
            end
        else
            print("Nenhum sistema de formas encontrado.")
        end
    end
end

-- // ==========================================
-- // LOOPS
-- // ==========================================

RunService.Heartbeat:Connect(function()
    -- AUTO FARM XP
    if estados.autoFarmXP then
        -- Procura por XP no mapa
        local xpParts = Workspace:FindFirstChild("XP") or Workspace:FindFirstChild("Experience")
        if xpParts then
            for _, v in ipairs(xpParts:GetChildren()) do
                if v:IsA("BasePart") or v:IsA("Part") then
                    -- Move o jogador para perto do XP
                    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        player.Character.HumanoidRootPart.CFrame = v.CFrame + Vector3.new(0, 3, 0)
                        wait(0.1)
                    end
                end
            end
        else
            -- Fallback: procura por itens de XP na GUI
            print("Procurando XP na GUI...")
        end
    end
    
    -- AUTO PVP
    if estados.autoPvP then
        -- Procura por outros jogadores próximos
        for _, v in ipairs(Workspace:GetChildren()) do
            if v:IsA("Model") and v:FindFirstChild("Humanoid") and v ~= player.Character then
                local dist = (v.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
                if dist < 100 then
                    -- Move em direção ao jogador
                    player.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
                    
                    -- Tenta atacar
                    if player.Character:FindFirstChild("Humanoid") then
                        player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Attacking)
                    end
                    wait(0.5)
                end
            end
        end
    end
    
    -- ATTACK ALL
    if estados.attackAll then
        -- Ataca todos os inimigos (jogadores e NPCs)
        local targets = Workspace:GetChildren()
        for _, v in ipairs(targets) do
            if v:IsA("Model") and v:FindFirstChild("Humanoid") and v ~= player.Character then
                local dist = (v.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
                if dist < 80 then
                    -- Ataca o alvo
                    if player.Character:FindFirstChild("Humanoid") then
                        player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Attacking)
                    end
                    wait(0.2)
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
screenGui.Name = "ProtonMenuMorphUp"
screenGui.ResetOnSpawn = false

-- // ==========================================
-- // JANELA PRINCIPAL (400x300)
-- // ==========================================

local mainFrame = Instance.new("Frame")
mainFrame.Parent = screenGui
mainFrame.Size = UDim2.new(0, 500, 0, 300)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = corAtual
mainFrame.Visible = true
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.BackgroundTransparency = 0.05

local mainCorner = Instance.new("UICorner")
mainCorner.Parent = mainFrame
mainCorner.CornerRadius = UDim.new(0, 6)

-- // ==========================================
-- // TOP BAR
-- // ==========================================

local topBar = Instance.new("Frame")
topBar.Parent = mainFrame
topBar.Size = UDim2.new(1, 0, 0, 26)
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
versionLbl.Size = UDim2.new(0.25, 0, 1, 0)
versionLbl.Position = UDim2.new(0.55, 0, 0, 0)
versionLbl.BackgroundTransparency = 1
versionLbl.Text = "morphup"
versionLbl.TextColor3 = Color3.fromRGB(200, 200, 200)
versionLbl.TextScaled = true
versionLbl.Font = Enum.Font.Gotham
versionLbl.TextXAlignment = Enum.TextXAlignment.Center

local closeBtn = Instance.new("TextButton")
closeBtn.Parent = topBar
closeBtn.Size = UDim2.new(0, 26, 0, 26)
closeBtn.Position = UDim2.new(1, -28, 0, 0)
closeBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextScaled = true
closeBtn.Font = Enum.Font.GothamBold
closeBtn.BorderSizePixel = 0
closeBtn.BackgroundTransparency = 0.2

local closeCorner = Instance.new("UICorner")
closeCorner.Parent = closeBtn
closeCorner.CornerRadius = UDim.new(0, 4)

closeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
end)

closeBtn.MouseEnter:Connect(function()
    closeBtn.BackgroundTransparency = 0
end)
closeBtn.MouseLeave:Connect(function()
    closeBtn.BackgroundTransparency = 0.2
end)

-- // ==========================================
-- // ABAS
-- // ==========================================

local tabBar = Instance.new("Frame")
tabBar.Parent = mainFrame
tabBar.Size = UDim2.new(1, 0, 0, 26)
tabBar.Position = UDim2.new(0, 0, 0, 26)
tabBar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
tabBar.BorderSizePixel = 0

local tabs = {
    {id = "farm", nome = "FARM"},
    {id = "pvp", nome = "PVP"},
    {id = "unlock", nome = "UNLOCK"},
    {id = "config", nome = "CONFIG"}
}

local tabBtns = {}
local tabAtual = "farm"

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
    btn.BackgroundTransparency = 0.2
    btn.Name = tab.id
    
    btn.MouseButton1Click:Connect(function()
        for _, b in pairs(tabBtns) do
            b.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            b.TextColor3 = Color3.fromRGB(150, 150, 150)
            b.BackgroundTransparency = 0.2
        end
        btn.BackgroundColor3 = corAtual
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.BackgroundTransparency = 0
        tabAtual = tab.id
        atualizarTabs(tab.id)
    end)
    
    tabBtns[tab.id] = btn
end

-- // ==========================================
-- // CONTEUDO
-- // ==========================================

local content = Instance.new("ScrollingFrame")
content.Parent = mainFrame
content.Size = UDim2.new(1, -12, 1, -72)
content.Position = UDim2.new(0, 6, 0, 56)
content.BackgroundTransparency = 1
content.CanvasSize = UDim2.new(0, 0, 0, 0)
content.ScrollBarThickness = 3
content.ScrollBarImageColor3 = corAtual

local tabContent = {}

function atualizarTabs(id)
    for k, v in pairs(tabContent) do
        v.Visible = (k == id)
    end
end

-- // ==========================================
-- // CRIAR ELEMENTOS (VERSÃO COMPACTA)
-- // ==========================================

function criarToggle(container, texto, callback, padrao)
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
    border.BackgroundColor3 = corAtual
    border.BorderSizePixel = 0
    border.BackgroundTransparency = 0.5
    
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
        callback()
    end
    
    check.MouseButton1Click:Connect(toggle)
    label.MouseButton1Click:Connect(toggle)
    frame.MouseButton1Click:Connect(toggle)
    
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
    btn.BackgroundTransparency = 0.3
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.Parent = btn
    btnCorner.CornerRadius = UDim.new(0, 3)
    
    btn.MouseButton1Click:Connect(callback)
    
    btn.MouseEnter:Connect(function()
        btn.BackgroundTransparency = 0.1
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundTransparency = 0.3
    end)
    
    return btn
end

-- // ==========================================
-- // CRIAR ABAS
-- // ==========================================

-- // ABA FARM
local farmTab = Instance.new("Frame")
farmTab.Parent = content
farmTab.Size = UDim2.new(1, 0, 1, 0)
farmTab.BackgroundTransparency = 1
farmTab.Visible = true
tabContent["farm"] = farmTab

criarToggle(farmTab, "AUTO FARM XP", toggleAutoFarmXP, false)
criarToggle(farmTab, "AUTO EVOLVE", toggleAutoEvolve, false)
criarBotao(farmTab, "DESTRAVAR TODAS FORMAS", unlockAllForms)
content.CanvasSize = UDim2.new(0, 0, 0, #farmTab:GetChildren() * 28 + 20)

-- // ABA PVP
local pvpTab = Instance.new("Frame")
pvpTab.Parent = content
pvpTab.Size = UDim2.new(1, 0, 1, 0)
pvpTab.BackgroundTransparency = 1
pvpTab.Visible = false
tabContent["pvp"] = pvpTab

criarToggle(pvpTab, "AUTO PVP", toggleAutoPvP, false)
criarToggle(pvpTab, "ATTACK ALL", toggleAttackAll, false)
if #pvpTab:GetChildren() * 28 + 20 > content.CanvasSize.Y.Offset then
    content.CanvasSize = UDim2.new(0, 0, 0, #pvpTab:GetChildren() * 28 + 20)
end

-- // ABA UNLOCK
local unlockTab = Instance.new("Frame")
unlockTab.Parent = content
unlockTab.Size = UDim2.new(1, 0, 1, 0)
unlockTab.BackgroundTransparency = 1
unlockTab.Visible = false
tabContent["unlock"] = unlockTab

criarBotao(unlockTab, "DESTRAVAR FORMAS", unlockAllForms)
criarBotao(unlockTab, "DESTRAVAR TUDO", function()
    print("Destravando tudo...")
    unlockAllForms()
    -- Tenta destravar outras coisas também
    local remotes = player:FindFirstChild("ReplicatedStorage") or game:GetService("ReplicatedStorage")
    if remotes then
        for _, v in ipairs(remotes:GetDescendants()) do
            if v:IsA("RemoteEvent") and (v.Name:lower():find("unlock") or v.Name:lower():find("buy")) then
                v:FireServer()
                wait(0.1)
            end
        end
    end
end)
if #unlockTab:GetChildren() * 28 + 20 > content.CanvasSize.Y.Offset then
    content.CanvasSize = UDim2.new(0, 0, 0, #unlockTab:GetChildren() * 28 + 20)
end

-- // ABA CONFIG
local configTab = Instance.new("Frame")
configTab.Parent = content
configTab.Size = UDim2.new(1, 0, 1, 0)
configTab.BackgroundTransparency = 1
configTab.Visible = false
tabContent["config"] = configTab

criarBotao(configTab, "FECHAR MENU", function()
    mainFrame.Visible = false
end)
criarBotao(configTab, "REINICIAR", function()
    print("Reiniciando funções...")
    for k, v in pairs(estados) do
        estados[k] = false
    end
end)
if #configTab:GetChildren() * 28 + 20 > content.CanvasSize.Y.Offset then
    content.CanvasSize = UDim2.new(0, 0, 0, #configTab:GetChildren() * 28 + 20)
end

-- // ==========================================
-- // ATALHO K
-- // ==========================================

UserInputService.InputBegan:Connect(function(input, processed)
    if not processed and input.KeyCode == Enum.KeyCode.K then
        mainFrame.Visible = not mainFrame.Visible
    end
end)

-- // ==========================================
-- // NOTIFICACAO
-- // ==========================================

local notif = Instance.new("TextLabel")
notif.Parent = screenGui
notif.Size = UDim2.new(0, 220, 0, 26)
notif.Position = UDim2.new(0.5, -110, 0.85, 0)
notif.BackgroundColor3 = corAtual
notif.Text = "PROTON MENU [K]"
notif.TextColor3 = Color3.fromRGB(255, 255, 255)
notif.TextScaled = true
notif.Font = Enum.Font.GothamBold
notif.BorderSizePixel = 0
notif.BackgroundTransparency = 0.2

local notifCorner = Instance.new("UICorner")
notifCorner.Parent = notif
notifCorner.CornerRadius = UDim.new(0, 4)

game:GetService("Debris"):AddItem(notif, 3)

print("===== PROTON MENU - MORPHUP! =====")
print("Pressione K para abrir/fechar")
print("ATENCAO: Jogo em Alpha, algumas funções podem precisar de ajustes")