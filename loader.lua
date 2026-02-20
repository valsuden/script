local Players = game:GetService("Players")
local player = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
-- =====================================================
-- CAMBIA ESTA KEY POR LA QUE QUIERAS (la correcta)
-- =====================================================
local correctKey = "TU_KEY_SECRETA" -- <-- Pon aquí tu key
-- =====================================================
-- Evitar duplicación
if player.PlayerGui:FindFirstChild("FruitSteel") then
    player.PlayerGui.FruitSteel:Destroy()
end
-- ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FruitSteel"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = player:WaitForChild("PlayerGui")
-- Frame principal (azul oscuro) - tamaño ajustado a 440x320
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 440, 0, 320)
Main.Position = UDim2.new(0.5, -220, 0.5, -160)
Main.BackgroundColor3 = Color3.fromRGB(20, 30, 55)
Main.BackgroundTransparency = 0.55  -- semi-transparente para que la neko se vea bien detrás
Main.Parent = ScreenGui
Main.Active = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 20)

-- Fondo: chica anime neko bonita (carga 100% en Delta)
local BackgroundImage = Instance.new("ImageLabel")
BackgroundImage.Name = "NekoBackground"
BackgroundImage.Size = UDim2.new(1, 0, 1, 0)
BackgroundImage.Position = UDim2.new(0, 0, 0, 0)
BackgroundImage.BackgroundTransparency = 1
BackgroundImage.Image = "rbxassetid://79690416172260"  -- neko cute pelo blanco, orejas, kawaii – ahora sí aparece
BackgroundImage.ImageTransparency = 0.35  -- ajusta: 0.2 = más visible la chica, 0.5 = más tenue para texto
BackgroundImage.ScaleType = Enum.ScaleType.Crop  -- o prueba .Fit si se ve cortada raro
BackgroundImage.ZIndex = 0  -- detrás de todo
BackgroundImage.Parent = Main

-- Borde RGB animado
local Stroke = Instance.new("UIStroke", Main)
Stroke.Thickness = 3
RunService.RenderStepped:Connect(function()
    local hue = tick() % 6 / 6
    Stroke.Color = Color3.fromHSV(hue, 1, 1)
end)
-- Sistema de arrastre (igual que el original)
local dragging, dragInput, dragStart, startPos
local function update(input)
    local delta = input.Position - dragStart
    Main.Position = UDim2.new(
        startPos.X.Scale, startPos.X.Offset + delta.X,
        startPos.Y.Scale, startPos.Y.Offset + delta.Y
    )
end
Main.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)
Main.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)
-- Botón cerrar
local Close = Instance.new("TextButton")
Close.Size = UDim2.new(0, 30, 0, 30)
Close.Position = UDim2.new(1, -40, 0, 10)
Close.ZIndex = 10  -- encima de la neko
Close.Text = "X"
Close.Font = Enum.Font.GothamBold
Close.TextScaled = true
Close.BackgroundColor3 = Color3.fromRGB(180, 60, 60)
Close.TextColor3 = Color3.new(1, 1, 1)
Close.Parent = Main
Instance.new("UICorner", Close).CornerRadius = UDim.new(1, 0)
Close.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)
-- Título
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundTransparency = 1
Title.ZIndex = 5
Title.Text = "FRUIT STEEL"
Title.Font = Enum.Font.GothamBlack
Title.TextScaled = true
Title.TextColor3 = Color3.fromRGB(0, 170, 255)
Title.Parent = Main
-- Botón GET KEY (más pequeño: 200x40)
local Button = Instance.new("TextButton")
Button.Size = UDim2.new(0, 200, 0, 40)
Button.Position = UDim2.new(0.5, -100, 0, 60) -- justo debajo del título
Button.ZIndex = 5
Button.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
Button.Text = "GET KEY"
Button.Font = Enum.Font.GothamBold
Button.TextScaled = true
Button.TextColor3 = Color3.new(1, 1, 1)
Button.Parent = Main
Instance.new("UICorner", Button).CornerRadius = UDim.new(0, 15)
-- Efecto hover
Button.MouseEnter:Connect(function()
    TweenService:Create(Button, TweenInfo.new(0.2), { BackgroundColor3 = Color3.fromRGB(0, 160, 255) }):Play()
end)
Button.MouseLeave:Connect(function()
    TweenService:Create(Button, TweenInfo.new(0.2), { BackgroundColor3 = Color3.fromRGB(0, 120, 200) }):Play()
end)
-- Función copiar al portapapeles
Button.MouseButton1Click:Connect(function()
    local discordLink = "https://discord.gg/TU_LINK_AQUI" -- Cambia por tu enlace
    pcall(function()
        setclipboard(discordLink)
    end)
    Button.Text = "SUCCESSFULLY COPIED!"
    Button.BackgroundColor3 = Color3.fromRGB(0, 200, 140)
    wait(3)
    Button.Text = "GET KEY"
    Button.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
end)
-- ==================== NUEVA SECCIÓN: VERIFICADOR DE KEY ====================
-- Caja de texto para escribir la key
local KeyBox = Instance.new("TextBox")
KeyBox.Size = UDim2.new(0, 300, 0, 40)
KeyBox.Position = UDim2.new(0.5, -150, 0, 115) -- debajo del botón GET KEY
KeyBox.ZIndex = 5
KeyBox.BackgroundColor3 = Color3.fromRGB(30, 40, 65)
KeyBox.TextColor3 = Color3.new(1, 1, 1)
KeyBox.PlaceholderText = "Introduce tu key..."
KeyBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
KeyBox.Font = Enum.Font.Gotham
KeyBox.TextScaled = true
KeyBox.ClearTextOnFocus = false
KeyBox.Parent = Main
Instance.new("UICorner", KeyBox).CornerRadius = UDim.new(0, 10)
-- Botón Submit
local Submit = Instance.new("TextButton")
Submit.Size = UDim2.new(0, 120, 0, 40)
Submit.Position = UDim2.new(0.5, -60, 0, 170) -- debajo del TextBox
Submit.ZIndex = 5
Submit.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
Submit.Text = "SUBMIT"
Submit.Font = Enum.Font.GothamBold
Submit.TextScaled = true
Submit.TextColor3 = Color3.new(1, 1, 1)
Submit.Parent = Main
Instance.new("UICorner", Submit).CornerRadius = UDim.new(0, 15)
-- Efecto hover para Submit
Submit.MouseEnter:Connect(function()
    TweenService:Create(Submit, TweenInfo.new(0.2), { BackgroundColor3 = Color3.fromRGB(0, 200, 140) }):Play()
end)
Submit.MouseLeave:Connect(function()
    TweenService:Create(Submit, TweenInfo.new(0.2), { BackgroundColor3 = Color3.fromRGB(0, 150, 100) }):Play()
end)
-- Etiqueta para mostrar resultado (Correct/Incorrect)
local ResultLabel = Instance.new("TextLabel")
ResultLabel.Size = UDim2.new(0, 300, 0, 30)
ResultLabel.Position = UDim2.new(0.5, -150, 0, 220) -- debajo del botón Submit
ResultLabel.ZIndex = 5
ResultLabel.BackgroundTransparency = 1
ResultLabel.Text = ""
ResultLabel.Font = Enum.Font.GothamBold
ResultLabel.TextScaled = true
ResultLabel.TextColor3 = Color3.new(1, 1, 1)
ResultLabel.Parent = Main
-- Función del botón Submit
Submit.MouseButton1Click:Connect(function()
    local enteredKey = KeyBox.Text:gsub("^%s+", ""):gsub("%s+$", "") -- elimina espacios al inicio/final
    if enteredKey == correctKey then
        ResultLabel.Text = "✅ Correct key"
        ResultLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
    else
        ResultLabel.Text = "❌ Incorrect key"
        ResultLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
    end
end)
-- ==================== FIN NUEVA SECCIÓN ====================
-- Footer
local Footer = Instance.new("TextLabel")
Footer.Size = UDim2.new(1, 0, 0, 30)
Footer.Position = UDim2.new(0, 0, 1, -35)
Footer.ZIndex = 5
Footer.BackgroundTransparency = 1
Footer.Text = "Only Blox Fruits"
Footer.Font = Enum.Font.GothamBold
Footer.TextScaled = true
Footer.TextColor3 = Color3.fromRGB(120, 150, 200)
Footer.Parent = Main
