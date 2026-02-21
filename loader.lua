local Players = game:GetService("Players")
local player = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

local correctKey = "key_blox2026"

if player.PlayerGui:FindFirstChild("FruitSteel") then
	player.PlayerGui.FruitSteel:Destroy()
end

-- =========================
-- DRAG FUNCTION
-- =========================
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
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
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
		if input.UserInputType == Enum.UserInputType.MouseMovement then
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
-- MAIN GUI (NO TOCADA)
-- =========================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FruitSteel"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = player:WaitForChild("PlayerGui")

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 440, 0, 320)
Main.Position = UDim2.new(0.5, -220, 0.5, -160)
Main.BackgroundTransparency = 1
Main.Parent = ScreenGui
Main.Active = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 20)
makeDraggable(Main)

local GoldStroke = Instance.new("UIStroke")
GoldStroke.Thickness = 6
GoldStroke.Color = Color3.fromRGB(255, 215, 0)
GoldStroke.Parent = Main

local BackgroundImage = Instance.new("ImageLabel")
BackgroundImage.Size = UDim2.new(1, 0, 1, 0)
BackgroundImage.BackgroundTransparency = 1
BackgroundImage.Image = "rbxassetid://122255224861955"
BackgroundImage.ScaleType = Enum.ScaleType.Crop
BackgroundImage.Parent = Main
Instance.new("UICorner", BackgroundImage).CornerRadius = UDim.new(0, 20)

local Close = Instance.new("TextButton")
Close.Size = UDim2.new(0, 30, 0, 30)
Close.Position = UDim2.new(1, -40, 0, 10)
Close.Text = "X"
Close.Font = Enum.Font.GothamBold
Close.TextScaled = true
Close.BackgroundColor3 = Color3.fromRGB(180, 60, 60)
Close.TextColor3 = Color3.new(1,1,1)
Close.Parent = Main
Instance.new("UICorner", Close).CornerRadius = UDim.new(1, 0)

Close.MouseButton1Click:Connect(function()
	ScreenGui:Destroy()
end)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundTransparency = 1
Title.Text = "FRUIT STEEL V2"
Title.Font = Enum.Font.GothamBlack
Title.TextScaled = true
Title.TextColor3 = Color3.fromRGB(0, 170, 255)
Title.Parent = Main

local KeyBox = Instance.new("TextBox")
KeyBox.Size = UDim2.new(0, 300, 0, 40)
KeyBox.Position = UDim2.new(0.5, -150, 0, 100)
KeyBox.BackgroundColor3 = Color3.fromRGB(30, 40, 65)
KeyBox.TextColor3 = Color3.new(1,1,1)
KeyBox.PlaceholderText = "Introduce tu key..."
KeyBox.Font = Enum.Font.Gotham
KeyBox.TextScaled = true
KeyBox.Parent = Main
Instance.new("UICorner", KeyBox).CornerRadius = UDim.new(0, 10)

local Submit = Instance.new("TextButton")
Submit.Size = UDim2.new(0, 120, 0, 40)
Submit.Position = UDim2.new(0.5, -60, 0, 160)
Submit.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
Submit.Text = "ENVIAR"
Submit.Font = Enum.Font.GothamBold
Submit.TextScaled = true
Submit.TextColor3 = Color3.new(1,1,1)
Submit.Parent = Main
Instance.new("UICorner", Submit).CornerRadius = UDim.new(0, 15)

local ResultLabel = Instance.new("TextLabel")
ResultLabel.Size = UDim2.new(0, 300, 0, 30)
ResultLabel.Position = UDim2.new(0.5, -150, 0, 210)
ResultLabel.BackgroundTransparency = 1
ResultLabel.Text = ""
ResultLabel.Font = Enum.Font.GothamBold
ResultLabel.TextScaled = true
ResultLabel.Parent = Main

-- =========================
-- KEY CHECK
-- =========================
Submit.MouseButton1Click:Connect(function()
	local enteredKey = KeyBox.Text:match("^%s*(.-)%s*$")

	if enteredKey == correctKey then
		ResultLabel.Text = "✅ Correct key"
		ResultLabel.TextColor3 = Color3.fromRGB(0,255,100)
		task.wait(1)
		Main.Visible = false

		-- =========================
		-- SECOND WINDOW (ARREGLADA)
		-- =========================

		local Second = Instance.new("Frame")
		Second.Size = UDim2.new(0, 420, 0, 260)
		Second.Position = UDim2.new(0.5, -210, 0.5, -130)
		Second.BackgroundColor3 = Color3.fromRGB(45,0,70)
		Second.Parent = ScreenGui
		Second.Active = true
		Instance.new("UICorner", Second).CornerRadius = UDim.new(0,20)
		makeDraggable(Second)

		local Stroke = Instance.new("UIStroke")
		Stroke.Color = Color3.fromRGB(200,0,255)
		Stroke.Thickness = 4
		Stroke.Parent = Second

		local Close2 = Instance.new("TextButton")
		Close2.Size = UDim2.new(0,30,0,30)
		Close2.Position = UDim2.new(1,-40,0,10)
		Close2.Text = "X"
		Close2.Font = Enum.Font.GothamBold
		Close2.TextScaled = true
		Close2.BackgroundColor3 = Color3.fromRGB(180,60,60)
		Close2.TextColor3 = Color3.new(1,1,1)
		Close2.Parent = Second
		Instance.new("UICorner", Close2).CornerRadius = UDim.new(1,0)

		Close2.MouseButton1Click:Connect(function()
			Second:Destroy()
			Main.Visible = true
		end)

		local SecondTitle = Instance.new("TextLabel")
		SecondTitle.Size = UDim2.new(1,0,0,50)
		SecondTitle.BackgroundTransparency = 1
		SecondTitle.Text = "FRUIT STEEL PANEL"
		SecondTitle.Font = Enum.Font.GothamBlack
		SecondTitle.TextScaled = true
		SecondTitle.TextColor3 = Color3.fromRGB(255,255,255)
		SecondTitle.Parent = Second

		local Status = Instance.new("TextLabel")
		Status.Size = UDim2.new(1,0,0,40)
		Status.Position = UDim2.new(0,0,0,60)
		Status.BackgroundTransparency = 1
		Status.Text = "Selecciona una opción"
		Status.Font = Enum.Font.GothamBold
		Status.TextScaled = true
		Status.TextColor3 = Color3.fromRGB(200,200,200)
		Status.Parent = Second

		local Button1 = Instance.new("TextButton")
		Button1.Size = UDim2.new(0,150,0,45)
		Button1.Position = UDim2.new(0.5,-170,0,130)
		Button1.Text = "OPCIÓN 1"
		Button1.BackgroundColor3 = Color3.fromRGB(0,170,255)
		Button1.TextColor3 = Color3.new(1,1,1)
		Button1.Font = Enum.Font.GothamBold
		Button1.TextScaled = true
		Button1.Parent = Second
		Instance.new("UICorner", Button1).CornerRadius = UDim.new(0,12)

		local Button2 = Instance.new("TextButton")
		Button2.Size = UDim2.new(0,150,0,45)
		Button2.Position = UDim2.new(0.5,20,0,130)
		Button2.Text = "OPCIÓN 2"
		Button2.BackgroundColor3 = Color3.fromRGB(200,0,255)
		Button2.TextColor3 = Color3.new(1,1,1)
		Button2.Font = Enum.Font.GothamBold
		Button2.TextScaled = true
		Button2.Parent = Second
		Instance.new("UICorner", Button2).CornerRadius = UDim.new(0,12)

		local busy = false

		local function runAction(text)
			if busy then return end
			busy = true

			Button1.Active = false
			Button2.Active = false
			Button1.AutoButtonColor = false
			Button2.AutoButtonColor = false

			for i = 5,1,-1 do
				Status.Text = text.." en "..i
				task.wait(1)
			end

			Status.Text = "✅ Successfully"
			task.wait(2)
			Status.Text = "Selecciona una opción"

			Button1.Active = true
			Button2.Active = true
			Button1.AutoButtonColor = true
			Button2.AutoButtonColor = true

			busy = false
		end

		Button1.MouseButton1Click:Connect(function()
			runAction("Opción 1")
		end)

		Button2.MouseButton1Click:Connect(function()
			runAction("Opción 2")
		end)

	else
		ResultLabel.Text = "❌ Key incorrecta"
		ResultLabel.TextColor3 = Color3.fromRGB(255,60,60)
	end
end)
