local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local correctKey = "key_blox2026"

-- Eliminar GUI anterior
if player.PlayerGui:FindFirstChild("FruitSteel") then
	player.PlayerGui.FruitSteel:Destroy()
end

-- =========================
-- FUNCION DRAG PC + MOVIL
-- =========================
local function makeDraggable(frame)
	local dragging = false
	local dragStart
	local startPos
	local dragInput

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
-- CREAR SCREEN GUI
-- =========================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FruitSteel"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = player.PlayerGui

-- =========================
-- VENTANA PRINCIPAL (KEY)
-- =========================
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 500, 0, 330)
Main.Position = UDim2.new(0.5, -250, 0.5, -165)
Main.BackgroundColor3 = Color3.fromRGB(40, 0, 60)
Main.Parent = ScreenGui
Main.Active = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0,25)
makeDraggable(Main)

local StrokeMain = Instance.new("UIStroke")
StrokeMain.Color = Color3.fromRGB(255,200,0)
StrokeMain.Thickness = 5
StrokeMain.Parent = Main

-- Imagen de fondo
local BackgroundImage = Instance.new("ImageLabel")
BackgroundImage.Size = UDim2.new(1,0,1,0)
BackgroundImage.BackgroundTransparency = 1
BackgroundImage.Image = "rbxassetid://113824786988245"
BackgroundImage.ScaleType = Enum.ScaleType.Crop
BackgroundImage.Parent = Main

-- Título
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,0,0,60)
Title.Position = UDim2.new(0,0,0,10)
Title.BackgroundTransparency = 1
Title.Text = "FRUIT STEEL V2"
Title.Font = Enum.Font.GothamBlack
Title.TextScaled = true
Title.TextColor3 = Color3.fromRGB(0,170,255)
Title.ZIndex = 2
Title.Parent = Main

-- Botón X
local CloseMain = Instance.new("TextButton")
CloseMain.Size = UDim2.new(0,40,0,40)
CloseMain.Position = UDim2.new(1,-50,0,10)
CloseMain.Text = "X"
CloseMain.Font = Enum.Font.GothamBold
CloseMain.TextScaled = true
CloseMain.BackgroundColor3 = Color3.fromRGB(200,60,60)
CloseMain.TextColor3 = Color3.new(1,1,1)
CloseMain.ZIndex = 3
CloseMain.Parent = Main
Instance.new("UICorner", CloseMain).CornerRadius = UDim.new(1,0)

CloseMain.MouseButton1Click:Connect(function()
	Main.Visible = false
end)

-- Botón Obtener llave
local GetKey = Instance.new("TextButton")
GetKey.Size = UDim2.new(0.5,0,0,45)
GetKey.Position = UDim2.new(0.25,0,0.28,0)
GetKey.BackgroundColor3 = Color3.fromRGB(0,120,200)
GetKey.Text = "OBTENER LLAVE"
GetKey.Font = Enum.Font.GothamBold
GetKey.TextScaled = true
GetKey.TextColor3 = Color3.new(1,1,1)
GetKey.ZIndex = 2
GetKey.Parent = Main
Instance.new("UICorner", GetKey).CornerRadius = UDim.new(1,0)

-- TextBox
local KeyBox = Instance.new("TextBox")
KeyBox.Size = UDim2.new(0.7,0,0,50)
KeyBox.Position = UDim2.new(0.15,0,0.45,0)
KeyBox.BackgroundColor3 = Color3.fromRGB(20,30,50)
KeyBox.TextColor3 = Color3.new(1,1,1)
KeyBox.PlaceholderText = "Introduce tu key..."
KeyBox.Font = Enum.Font.Gotham
KeyBox.TextScaled = true
KeyBox.ZIndex = 2
KeyBox.Parent = Main
Instance.new("UICorner", KeyBox).CornerRadius = UDim.new(0,15)

-- Botón enviar
local Submit = Instance.new("TextButton")
Submit.Size = UDim2.new(0.5,0,0,50)
Submit.Position = UDim2.new(0.25,0,0.65,0)
Submit.BackgroundColor3 = Color3.fromRGB(0,160,100)
Submit.Text = "ENVIAR"
Submit.Font = Enum.Font.GothamBold
Submit.TextScaled = true
Submit.TextColor3 = Color3.new(1,1,1)
Submit.ZIndex = 2
Submit.Parent = Main
Instance.new("UICorner", Submit).CornerRadius = UDim.new(1,0)

-- Resultado
local Result = Instance.new("TextLabel")
Result.Size = UDim2.new(1,0,0,30)
Result.Position = UDim2.new(0,0,0.85,0)
Result.BackgroundTransparency = 1
Result.Text = ""
Result.Font = Enum.Font.GothamBold
Result.TextScaled = true
Result.ZIndex = 2
Result.Parent = Main

-- Footer
local Footer = Instance.new("TextLabel")
Footer.Size = UDim2.new(1,0,0,30)
Footer.Position = UDim2.new(0,0,1,-35)
Footer.BackgroundTransparency = 1
Footer.Text = "Only Blox Fruits"
Footer.Font = Enum.Font.GothamBold
Footer.TextScaled = true
Footer.TextColor3 = Color3.fromRGB(150,180,255)
Footer.ZIndex = 2
Footer.Parent = Main

-- =========================
-- SEGUNDA VENTANA (TUYA)
-- =========================
local function openSecondPanel()
	Main.Visible = false

	local Panel = Instance.new("Frame")
	Panel.Size = UDim2.new(0, 500, 0, 350)
	Panel.Position = UDim2.new(0.5, -250, 0.5, -175)
	Panel.BackgroundColor3 = Color3.fromRGB(60,0,90)
	Panel.Parent = ScreenGui
	Panel.Active = true
	Instance.new("UICorner", Panel).CornerRadius = UDim.new(0,25)
	makeDraggable(Panel)

	local Stroke = Instance.new("UIStroke")
	Stroke.Color = Color3.fromRGB(220,0,255)
	Stroke.Thickness = 5
	Stroke.Parent = Panel

	local Title2 = Instance.new("TextLabel")
	Title2.Size = UDim2.new(1,0,0,70)
	Title2.BackgroundTransparency = 1
	Title2.Text = "FRUIT STEEL PANEL"
	Title2.Font = Enum.Font.GothamBlack
	Title2.TextScaled = true
	Title2.TextColor3 = Color3.fromRGB(255,170,255)
	Title2.Parent = Panel

	local Status = Instance.new("TextLabel")
	Status.Size = UDim2.new(1,0,0,40)
	Status.Position = UDim2.new(0,0,1,-50)
	Status.BackgroundTransparency = 1
	Status.Text = ""
	Status.Font = Enum.Font.GothamBold
	Status.TextScaled = true
	Status.TextColor3 = Color3.new(1,1,1)
	Status.Parent = Panel

	local busy = false

	local function createButton(text, posY)
		local btn = Instance.new("TextButton")
		btn.Size = UDim2.new(0.6,0,0,60)
		btn.Position = UDim2.new(0.2,0,posY,0)
		btn.BackgroundColor3 = Color3.fromRGB(170,0,230)
		btn.Text = text
		btn.Font = Enum.Font.GothamBold
		btn.TextScaled = true
		btn.TextColor3 = Color3.new(1,1,1)
		btn.Parent = Panel
		Instance.new("UICorner", btn).CornerRadius = UDim.new(0,20)
		return btn
	end

	local Button1 = createButton("Action One (1)", 0.35)
	local Button2 = createButton("Action Two", 0.55)

	local function runAction(name)
		if busy then return end
		busy = true

		Button1.Active = false
		Button2.Active = false

		for i = 5,1,-1 do
			Status.Text = name.." in "..i
			task.wait(1)
		end

		Status.Text = "Successfully"
		task.wait(2)
		Status.Text = ""

		Button1.Active = true
		Button2.Active = true
		busy = false
	end

	Button1.MouseButton1Click:Connect(function()
		runAction("Action One")
	end)

	Button2.MouseButton1Click:Connect(function()
		runAction("Action Two")
	end)

	local Close = Instance.new("TextButton")
	Close.Size = UDim2.new(0,35,0,35)
	Close.Position = UDim2.new(1,-45,0,10)
	Close.Text = "X"
	Close.Font = Enum.Font.GothamBold
	Close.TextScaled = true
	Close.BackgroundColor3 = Color3.fromRGB(180,60,60)
	Close.TextColor3 = Color3.new(1,1,1)
	Close.Parent = Panel
	Instance.new("UICorner", Close).CornerRadius = UDim.new(1,0)

	Close.MouseButton1Click:Connect(function()
		Panel:Destroy()
		Main.Visible = true
	end)
end

-- =========================
-- VALIDAR KEY
-- =========================
Submit.MouseButton1Click:Connect(function()
	local enteredKey = KeyBox.Text:match("^%s*(.-)%s*$")

	if enteredKey == correctKey then
		Result.Text = "Correct key"
		Result.TextColor3 = Color3.fromRGB(0,255,100)
		task.wait(1)
		openSecondPanel()
	else
		Result.Text = "Incorrect key"
		Result.TextColor3 = Color3.fromRGB(255,80,80)
	end
end)
