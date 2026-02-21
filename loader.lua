local Players = game:GetService("Players")
local player = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- =====================================================
local correctKey = "key_blox2026" -- Pon tu key aquí
-- =====================================================

if player.PlayerGui:FindFirstChild("FruitSteel") then
    player.PlayerGui.FruitSteel:Destroy()
end

-- función reusable de arrastre (funciona mouse + touch)
local function makeDraggable(frame)
    local dragging = false
    local dragInput
    local dragStart
    local startPos

    local function update(input)
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

-- ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FruitSteel"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = player:WaitForChild("PlayerGui")

-- Frame principal sólido (azul oscuro fuerte, sin transparencia)
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 440, 0, 320)
Main.Position = UDim2.new(0.5, -220, 0.5, -160)
Main.BackgroundColor3 = Color3.fromRGB(20, 30, 55)
Main.BackgroundTransparency = 0  -- Fondo fuerte y opaco
Main.Parent = ScreenGui
Main.Active = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 20)

-- aplicamos drag al Main
makeDraggable(Main)

-- Bordes dorados (amarillo dorado brillante)
local GoldStroke = Instance.new("UIStroke")
GoldStroke.Thickness = 6  -- grueso para que se vea bien
GoldStroke.Color = Color3.fromRGB(255, 215, 0)  -- dorado/amariilo fuerte
GoldStroke.Transparency = 0
GoldStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
GoldStroke.Parent = Main

-- Fondo: chica anime neko (fuerte, sin transparencia)
local BackgroundImage = Instance.new("ImageLabel")
BackgroundImage.Name = "NekoBackground"
BackgroundImage.Size = UDim2.new(1, 0, 1, 0)
BackgroundImage.Position = UDim2.new(0, 0, 0, 0)
BackgroundImage.BackgroundTransparency = 1
BackgroundImage.Image = "rbxassetid://122255224861955"  -- tu ID
BackgroundImage.ImageTransparency = 0  -- totalmente opaca
BackgroundImage.ScaleType = Enum.ScaleType.Crop
BackgroundImage.ZIndex = 0
BackgroundImage.Parent = Main

-- Botón cerrar
local Close = Instance.new("TextButton")
Close.Size = UDim2.new(0, 30, 0, 30)
Close.Position = UDim2.new(1, -40, 0, 10)
Close.ZIndex = 5
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
Title.Text = "FRUIT STEEL V2"
Title.Font = Enum.Font.GothamBlack
Title.TextScaled = true
Title.TextColor3 = Color3.fromRGB(0, 170, 255)
Title.Parent = Main

-- Botón GET KEY
local Button = Instance.new("TextButton")
Button.Size = UDim2.new(0, 200, 0, 40)
Button.Position = UDim2.new(0.5, -100, 0, 60)
Button.ZIndex = 5
Button.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
Button.Text = "GET KEY"
Button.Font = Enum.Font.GothamBold
Button.TextScaled = true
Button.TextColor3 = Color3.new(1, 1, 1)
Button.Parent = Main
Instance.new("UICorner", Button).CornerRadius = UDim.new(0, 15)

Button.MouseEnter:Connect(function()
    TweenService:Create(Button, TweenInfo.new(0.2), { BackgroundColor3 = Color3.fromRGB(0, 160, 255) }):Play()
end)
Button.MouseLeave:Connect(function()
    TweenService:Create(Button, TweenInfo.new(0.2), { BackgroundColor3 = Color3.fromRGB(0, 120, 200) }):Play()
end)

Button.MouseButton1Click:Connect(function()
    local discordLink = "https://discord.gg/8hSAwwz86j"
    pcall(function()
        if setclipboard then setclipboard(discordLink) end
    end)
    Button.Text = "SUCCESSFULLY COPIED!"
    Button.BackgroundColor3 = Color3.fromRGB(0, 200, 140)
    wait(3)
    Button.Text = "GET KEY"
    Button.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
end)

-- KeyBox
local KeyBox = Instance.new("TextBox")
KeyBox.Size = UDim2.new(0, 300, 0, 40)
KeyBox.Position = UDim2.new(0.5, -150, 0, 115)
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

-- Submit
local Submit = Instance.new("TextButton")
Submit.Size = UDim2.new(0, 120, 0, 40)
Submit.Position = UDim2.new(0.5, -60, 0, 170)
Submit.ZIndex = 5
Submit.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
Submit.Text = "SUBMIT"
Submit.Font = Enum.Font.GothamBold
Submit.TextScaled = true
Submit.TextColor3 = Color3.new(1, 1, 1)
Submit.Parent = Main
Instance.new("UICorner", Submit).CornerRadius = UDim.new(0, 15)

Submit.MouseEnter:Connect(function()
    TweenService:Create(Submit, TweenInfo.new(0.2), { BackgroundColor3 = Color3.fromRGB(0, 200, 140) }):Play()
end)
Submit.MouseLeave:Connect(function()
    TweenService:Create(Submit, TweenInfo.new(0.2), { BackgroundColor3 = Color3.fromRGB(0, 150, 100) }):Play()
end)

-- Result
local ResultLabel = Instance.new("TextLabel")
ResultLabel.Size = UDim2.new(0, 300, 0, 30)
ResultLabel.Position = UDim2.new(0.5, -150, 0, 220)
ResultLabel.ZIndex = 5
ResultLabel.BackgroundTransparency = 1
ResultLabel.Text = ""
ResultLabel.Font = Enum.Font.GothamBold
ResultLabel.TextScaled = true
ResultLabel.TextColor3 = Color3.new(1, 1, 1)
ResultLabel.Parent = Main

-- Submit behavior (key check + create second GUI if correct)
Submit.MouseButton1Click:Connect(function()

    local enteredKey = KeyBox.Text:match("^%s*(.-)%s*$")

    if enteredKey == correctKey then

        ResultLabel.Text = "✅ Correct key"
        ResultLabel.TextColor3 = Color3.fromRGB(0, 255, 100)

        wait(2)
        Main:Destroy()

        -- =========================
        -- SEGUNDA GUI MORADA
        -- =========================

        local Second = Instance.new("Frame")
        Second.Size = UDim2.new(0, 420, 0, 260)
        Second.Position = UDim2.new(0.5, -210, 0.5, -130)
        Second.BackgroundColor3 = Color3.fromRGB(45, 0, 70)
        Second.Parent = ScreenGui
        Second.Active = true
        Instance.new("UICorner", Second).CornerRadius = UDim.new(0, 20)

        -- aplicamos drag a la segunda ventana también
        makeDraggable(Second)

        local Stroke = Instance.new("UIStroke")
        Stroke.Color = Color3.fromRGB(200, 0, 255)
        Stroke.Thickness = 4
        Stroke.Parent = Second

        local Title2 = Instance.new("TextLabel")
        Title2.Size = UDim2.new(1, 0, 0, 50)
        Title2.BackgroundTransparency = 1
        Title2.Text = "FRUIT STEEL PANEL"
        Title2.Font = Enum.Font.GothamBlack
        Title2.TextScaled = true
        Title2.TextColor3 = Color3.fromRGB(210, 120, 255)
        Title2.Parent = Second

        local button1Name = "Action One"
        local button2Name = "Action Two"

        local function createButton(name, posY)

            local Btn = Instance.new("TextButton")
            Btn.Size = UDim2.new(0, 250, 0, 45)
            Btn.Position = UDim2.new(0.5, -125, 0, posY)
            Btn.BackgroundColor3 = Color3.fromRGB(120, 0, 180)
            Btn.Text = name
            Btn.Font = Enum.Font.GothamBold
            Btn.TextScaled = true
            Btn.TextColor3 = Color3.new(1,1,1)
            Btn.Parent = Second
            Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 15)

            local busy = false

            Btn.MouseButton1Click:Connect(function()
                if busy then return end
                busy = true

                local originalText = name

                for i = 5, 1, -1 do
                    Btn.Text = originalText .. " ("..i..")"
                    wait(1)
                end

                Btn.Text = "Successfully"
                Btn.BackgroundColor3 = Color3.fromRGB(0, 200, 140)

                wait(2)

                Btn.Text = originalText
                Btn.BackgroundColor3 = Color3.fromRGB(120, 0, 180)
                busy = false
            end)
        end

        createButton(button1Name, 80)
        createButton(button2Name, 140)

    else

        ResultLabel.Text = "❌ Incorrect key"
        ResultLabel.TextColor3 = Color3.fromRGB(255, 80, 80)

    end
end)   

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
