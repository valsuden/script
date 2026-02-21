local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local correctKey = "key_blox2026"

-- Evitar duplicado
if player.PlayerGui:FindFirstChild("FruitSteel") then
	player.PlayerGui.FruitSteel:Destroy()
end

-- =========================
-- DRAG FUNCTION PC + MOVIL
-- =========================
local function makeDraggable(frame)
	local dragging = false
	local dragInput, dragStart, startPos

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

-- =========================
-- SCREEN GUI
-- =========================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FruitSteel"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = player:WaitForChild("PlayerGui")

-- =========================
-- GUI 1 (KEY SYSTEM)
-- =========================
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 440, 0, 320)
Main.Position = UDim2.new(0.5, -220, 0.5, -160)
Main.BackgroundColor3 = Color3.fromRGB(20, 25, 45)
Main.Parent = ScreenGui
Main.Active = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 20)
makeDraggable(Main)

local Stroke1 = Instance.new("UIStroke")
Stroke1.Color = Color3.fromRGB(0,170,255)
Stroke1.Thickness = 4
Stroke1.Parent = Main

-- Título
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,0,0,50)
Title.BackgroundTransparency = 1
Title.Text = "FRUIT STEEL V2"
Title.Font = Enum.Font.GothamBlack
Title.TextScaled = true
Title.TextColor3 = Color3.fromRGB(0,170,255)
Title.Parent = Main

-- Cerrar
local Close = Instance.new("TextButton")
Close.Size = UDim2.new(0,30,0,30)
Close.Position = UDim2.new(1,-40,0,10)
Close.Text = "X"
Close.Font = Enum.Font.GothamBold
Close.TextScaled = true
Close.BackgroundColor3 = Color3.fromRGB(180,60,60)
Close.TextColor3 = Color3.new(1,1,1)
Close.Parent = Main
Instance.new("UICorner", Close).CornerRadius = UDim.new(1,0)

Close.MouseButton1Click:Connect(function()
	ScreenGui:Destroy()
end)

-- GET KEY
local GetKey = Instance.new("TextButton")
GetKey.Size = UDim2.new(0,200,0,40)
GetKey.Position = UDim2.new(0.5,-100,0,70)
GetKey.BackgroundColor3 = Color3.fromRGB(0,120,200)
GetKey.Text = "OBTENER LLAVE"
GetKey.Font = Enum.Font.GothamBold
GetKey.TextScaled = true
GetKey.TextColor3 = Color3.new(1,1,1)
GetKey.Parent = Main
Instance.new("UICorner", GetKey).CornerRadius = UDim.new(0,15)

GetKey.MouseButton1Click:Connect(function()
	local discordLink = "https://discord.gg/8hSAwwz86j"
	pcall(function()
		if setclipboard then
			setclipboard(discordLink)
		end
	end)
	GetKey.Text = "COPIADO!"
	task.wait(2)
	GetKey.Text = "OBTENER LLAVE"
end)

-- KeyBox
local KeyBox = Instance.new("TextBox")
KeyBox.Size = UDim2.new(0,300,0,40)
KeyBox.Position = UDim2.new(0.5,-150,0,130)
KeyBox.BackgroundColor3 = Color3.fromRGB(30,40,65)
KeyBox.TextColor3 = Color3.new(1,1,1)
KeyBox.PlaceholderText = "Introduce tu key..."
KeyBox.Font = Enum.Font.Gotham
KeyBox.TextScaled = true
KeyBox.Parent = Main
Instance.new("UICorner", KeyBox).CornerRadius = UDim.new(0,10)

-- Submit
local Submit = Instance.new("TextButton")
Submit.Size = UDim2.new(0,120,0,40)
Submit.Position = UDim2.new(0.5,-60,0,190)
Submit.BackgroundColor3 = Color3.fromRGB(0,150,100)
Submit.Text = "ENVIAR"
Submit.Font = Enum.Font.GothamBold
Submit.TextScaled = true
Submit.TextColor3 = Color3.new(1,1,1)
Submit.Parent = Main
Instance.new("UICorner", Submit).CornerRadius = UDim.new(0,15)

-- Resultado
local Result = Instance.new("TextLabel")
Result.Size = UDim2.new(1,0,0,30)
Result.Position = UDim2.new(0,0,0,240)
Result.BackgroundTransparency = 1
Result.Font = Enum.Font.GothamBold
Result.TextScaled = true
Result.Parent = Main

-- =========================
-- VERIFICACION
-- =========================
Submit.MouseButton1Click:Connect(function()

	if KeyBox.Text == correctKey then
		Main:Destroy()

		-- =========================
		-- GUI 2 ESTILO MORADO
		-- =========================

		local Second = Instance.new("Frame")
		Second.Size = UDim2.new(0,500,0,330)
		Second.Position = UDim2.new(0.5,-250,0.5,-165)
		Second.BackgroundColor3 = Color3.fromRGB(70,0,110)
		Second.Parent = ScreenGui
		Second.Active = true
		Instance.new("UICorner", Second).CornerRadius = UDim.new(0,25)
		makeDraggable(Second)

		local Stroke2 = Instance.new("UIStroke")
		Stroke2.Color = Color3.fromRGB(200,0,255)
		Stroke2.Thickness = 6
		Stroke2.Parent = Second

		local Title2 = Instance.new("TextLabel")
		Title2.Size = UDim2.new(1,0,0,70)
		Title2.BackgroundTransparency = 1
		Title2.Text = "FRUIT STEEL PANEL"
		Title2.Font = Enum.Font.GothamBlack
		Title2.TextScaled = true
		Title2.TextColor3 = Color3.fromRGB(255,170,255)
		Title2.Parent = Second

		local Close2 = Instance.new("TextButton")
		Close2.Size = UDim2.new(0,40,0,40)
		Close2.Position = UDim2.new(1,-50,0,15)
		Close2.Text = "X"
		Close2.Font = Enum.Font.GothamBold
		Close2.TextScaled = true
		Close2.BackgroundColor3 = Color3.fromRGB(180,60,60)
		Close2.TextColor3 = Color3.new(1,1,1)
		Close2.Parent = Second
		Instance.new("UICorner", Close2).CornerRadius = UDim.new(1,0)

		Close2.MouseButton1Click:Connect(function()
			Second:Destroy()
		end)

		local CustomBox = Instance.new("TextBox")
		CustomBox.Size = UDim2.new(0.7,0,0,60)
		CustomBox.Position = UDim2.new(0.15,0,0.35,0)
		CustomBox.BackgroundColor3 = Color3.fromRGB(110,0,180)
		CustomBox.TextColor3 = Color3.new(1,1,1)
		CustomBox.PlaceholderText = "Escribe texto para copiar..."
		CustomBox.Font = Enum.Font.GothamBold
		CustomBox.TextScaled = true
		CustomBox.Parent = Second
		Instance.new("UICorner", CustomBox).CornerRadius = UDim.new(0,20)

		local CopyButton = Instance.new("TextButton")
		CopyButton.Size = UDim2.new(0.7,0,0,60)
		CopyButton.Position = UDim2.new(0.15,0,0.60,0)
		CopyButton.BackgroundColor3 = Color3.fromRGB(150,0,255)
		CopyButton.Text = "Copiar Key"
		CopyButton.Font = Enum.Font.GothamBlack
		CopyButton.TextScaled = true
		CopyButton.TextColor3 = Color3.new(1,1,1)
		CopyButton.Parent = Second
		Instance.new("UICorner", CopyButton).CornerRadius = UDim.new(0,25)

		CopyButton.MouseButton1Click:Connect(function()
			pcall(function()
				if setclipboard then
					setclipboard(CustomBox.Text)
				end
			end)

			CopyButton.Text = "COPIADO!"
			task.wait(2)
			CopyButton.Text = "Copiar Key"
		end)

	else
		Result.Text = "❌ Incorrect key"
		Result.TextColor3 = Color3.fromRGB(255,80,80)
	end
end)
