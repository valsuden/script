-- =========================
-- SECOND WINDOW PANEL PRO
-- =========================

local Second = Instance.new("Frame")
Second.Size = UDim2.new(0, 500, 0, 320)
Second.Position = UDim2.new(0.5, -250, 0.5, -160)
Second.BackgroundColor3 = Color3.fromRGB(60, 0, 80)
Second.Parent = ScreenGui
Second.Active = true
Instance.new("UICorner", Second).CornerRadius = UDim.new(0,25)

makeDraggable(Second)

local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(200, 0, 255)
Stroke.Thickness = 5
Stroke.Parent = Second

-- Close Button
local Close2 = Instance.new("TextButton")
Close2.Size = UDim2.new(0,35,0,35)
Close2.Position = UDim2.new(1,-45,0,10)
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

-- Title
local SecondTitle = Instance.new("TextLabel")
SecondTitle.Size = UDim2.new(1,0,0,70)
SecondTitle.BackgroundTransparency = 1
SecondTitle.Text = "FRUIT STEEL PANEL"
SecondTitle.Font = Enum.Font.GothamBlack
SecondTitle.TextScaled = true
SecondTitle.TextColor3 = Color3.fromRGB(255,150,255)
SecondTitle.Parent = Second

-- Status Label
local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(1,0,0,40)
Status.Position = UDim2.new(0,0,1,-50)
Status.BackgroundTransparency = 1
Status.Text = ""
Status.Font = Enum.Font.GothamBold
Status.TextScaled = true
Status.TextColor3 = Color3.fromRGB(255,255,255)
Status.Parent = Second

-- Control variable (no doble click)
local busy = false

local function createButton(text, posX)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0, 260, 0, 60)
	btn.Position = UDim2.new(0.5, posX, 0.5, -30)
	btn.Text = text
	btn.Font = Enum.Font.GothamBold
	btn.TextScaled = true
	btn.BackgroundColor3 = Color3.fromRGB(150, 0, 200)
	btn.TextColor3 = Color3.new(1,1,1)
	btn.Parent = Second
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0,20)
	
	return btn
end

local Button1 = createButton("Action One (1)", -130)
local Button2 = createButton("Action Two", 130)

local function runCountdown(buttonName)
	if busy then return end
	busy = true
	
	Button1.Active = false
	Button2.Active = false
	
	for i = 5,1,-1 do
		Status.Text = buttonName.." starting in "..i
		wait(1)
	end
	
	Status.Text = "Successfully"
	wait(2)
	Status.Text = ""
	
	Button1.Active = true
	Button2.Active = true
	
	busy = false
end

Button1.MouseButton1Click:Connect(function()
	runCountdown("Action One")
end)

Button2.MouseButton1Click:Connect(function()
	runCountdown("Action Two")
end)
