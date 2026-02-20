local Players = game:GetService("Players")
local player = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- Evitar duplicación
if player.PlayerGui:FindFirstChild("FruitSteel") then
	player.PlayerGui.FruitSteel:Destroy()
end

-- ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FruitSteel"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = player:WaitForChild("PlayerGui")

-- Frame principal (azul oscuro masculino)
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 440, 0, 260)
Main.Position = UDim2.new(0.5,-220,0.5,-130)
Main.BackgroundColor3 = Color3.fromRGB(20, 30, 55)
Main.Parent = ScreenGui
Main.Active = true

Instance.new("UICorner", Main).CornerRadius = UDim.new(0,20)

-- Borde RGB
local Stroke = Instance.new("UIStroke", Main)
Stroke.Thickness = 3

RunService.RenderStepped:Connect(function()
	local hue = tick() % 6 / 6
	Stroke.Color = Color3.fromHSV(hue,1,1)
end)

-- Drag system (igual que el primero)
local dragging, dragInput, dragStart, startPos

local function update(input)
	local delta = input.Position - dragStart
	Main.Position = UDim2.new(
		startPos.X.Scale,
		startPos.X.Offset + delta.X,
		startPos.Y.Scale,
		startPos.Y.Offset + delta.Y
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

-- Título
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,0,0,60)
Title.BackgroundTransparency = 1
Title.Text = "FRUIT STEEL"
Title.Font = Enum.Font.GothamBlack
Title.TextScaled = true
Title.TextColor3 = Color3.fromRGB(0,170,255)
Title.Parent = Main

-- Botón Get Key (centrado correctamente)
local Button = Instance.new("TextButton")
Button.Size = UDim2.new(0,240,0,60)
Button.Position = UDim2.new(0.5,-120,0.55,0)
Button.BackgroundColor3 = Color3.fromRGB(0,120,200)
Button.Text = "GET KEY"
Button.Font = Enum.Font.GothamBold
Button.TextScaled = true
Button.TextColor3 = Color3.new(1,1,1)
Button.Parent = Main

Instance.new("UICorner", Button).CornerRadius = UDim.new(0,15)

-- Hover efecto simple
Button.MouseEnter:Connect(function()
	TweenService:Create(Button,TweenInfo.new(0.2),{
		BackgroundColor3 = Color3.fromRGB(0,160,255)
	}):Play()
end)

Button.MouseLeave:Connect(function()
	TweenService:Create(Button,TweenInfo.new(0.2),{
		BackgroundColor3 = Color3.fromRGB(0,120,200)
	}):Play()
end)

-- Función copiar (compatible)
Button.MouseButton1Click:Connect(function()
	local discordLink = "https://discord.gg/TU_LINK_AQUI"

	pcall(function()
		setclipboard(discordLink)
	end)

	Button.Text = "SUCCESSFULLY COPIED!"
	Button.BackgroundColor3 = Color3.fromRGB(0,200,140)

	wait(3)

	Button.Text = "GET KEY"
	Button.BackgroundColor3 = Color3.fromRGB(0,120,200)
end)

-- Footer
local Footer = Instance.new("TextLabel")
Footer.Size = UDim2.new(1,0,0,30)
Footer.Position = UDim2.new(0,0,1,-35)
Footer.BackgroundTransparency = 1
Footer.Text = "Only Blox Fruits"
Footer.Font = Enum.Font.GothamBold
Footer.TextScaled = true
Footer.TextColor3 = Color3.fromRGB(120,150,200)
Footer.Parent = Main
