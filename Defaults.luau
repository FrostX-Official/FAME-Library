local defaults = {}

cloneref = cloneref or function(obj)
	return obj
end

-- Services

local UserInputService	= cloneref(game:GetService("UserInputService"))
local TweenService		= cloneref(game:GetService("TweenService"))
local RunService 		= cloneref(game:GetService("RunService"))
local Players 			= cloneref(game:GetService("Players"))
local Debris 			= cloneref(game:GetService("Debris"))

-- Some Variables

local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

-- Internal Settings

defaults.contentOffset = 40 -- Do not change

-- Local Presets

local function padding()
	local padding = Instance.new("UIPadding")
	padding.PaddingTop = UDim.new(0,10)
	padding.PaddingLeft = UDim.new(0,10)
	padding.PaddingRight = UDim.new(0,10)
	padding.PaddingBottom = UDim.new(0,10)
	return padding
end

local function corner()
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0,4)
	return corner
end

local function stroke()
	local stroke = Instance.new("UIStroke")
	stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	stroke.Thickness = 3
	stroke.Color = Color3.new(0.72549, 0.588235, 0.901961)
	return stroke
end

local function strokeframe()
	local frame = Instance.new("Frame")
	frame.AnchorPoint = Vector2.new(.5,.5)
	frame.Position = UDim2.new(.5,0,.5,0)
	frame.BackgroundTransparency = 1
	frame.Size = UDim2.new(1,-3,1,-3)
	stroke().Parent = frame
	return frame
end

-- Defaults

function defaults.guiDefaults(gui: ScreenGui)
	gui.ResetOnSpawn = false
	gui.DisplayOrder = math.huge
	gui.ZIndexBehavior = Enum.ZIndexBehavior.Global
	gui.IgnoreGuiInset = true
end

function defaults.titleDefaults(title: TextLabel)
	title.Size = UDim2.new(.8,0,0,30)
	title.BackgroundTransparency = 1
	title.TextColor3 = Color3.new(1,1,1)
	title.TextScaled = true
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.TextYAlignment = Enum.TextYAlignment.Top
	title.FontFace = Font.fromEnum(Enum.Font.SourceSansBold)
end

function defaults.hiderDefaults(hider: TextButton)
	hider.Text = ""
	hider.AnchorPoint = Vector2.new(1,0)
	hider.BackgroundColor3 = Color3.fromRGB(140, 133, 176)
	hider.BackgroundTransparency = .3
	hider.Position = UDim2.new(1,0,0,0)
	hider.Size = UDim2.new(.2,0,0,30)
	
	corner().Parent = hider
	
	local icon = Instance.new("ImageLabel")
	icon.Name = "Icon"
	icon.AnchorPoint = Vector2.new(.5,.5)
	icon.BackgroundTransparency = 1
	icon.Position = UDim2.new(.5,0,.5,0)
	icon.Size = UDim2.new(.5,0,.5,0)
	icon.Image = "rbxassetid://92506520323977"
	icon.ScaleType = Enum.ScaleType.Fit
	icon.Parent = hider
	
	local aspectRatio = Instance.new("UIAspectRatioConstraint")
	aspectRatio.Parent = hider
end

function defaults.frameDefaults(frame: Frame)
	frame.Size = UDim2.new(0,200,0,200)
	
	frame.BackgroundColor3 = Color3.fromRGB(55, 48, 72)
	frame.BackgroundTransparency = .2
	
	corner().Parent = frame
	
	local padding = Instance.new("UIPadding")
	padding.PaddingTop = UDim.new(0,10)
	padding.PaddingLeft = UDim.new(0,10)
	padding.PaddingRight = UDim.new(0,10)
	padding.PaddingBottom = UDim.new(0,10)
	padding.Parent = frame
	
	-------- Frame Drag
	
	local holdingFrame = false
	local lastMouseX, lastMouseY = Mouse.X, Mouse.Y
	
	frame.InputBegan:Connect(function(input: InputObject) 
		if input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
		lastMouseX, lastMouseY = Mouse.X, Mouse.Y
		holdingFrame = true
	end)
	
	UserInputService.InputEnded:Connect(function(input: InputObject, gameProcessedEvent: boolean) 
		if input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
		lastMouseX, lastMouseY = Mouse.X, Mouse.Y
		holdingFrame = false
	end)
	
	RunService.Heartbeat:Connect(function() 
		if not holdingFrame then return end
		
		local newMouseX, newMouseY = Mouse.X, Mouse.Y
		
		local lastToNewDifferenceX, lastToNewDifferenceY = newMouseX - lastMouseX, newMouseY - lastMouseY
		if frame.Position.X.Offset+lastToNewDifferenceX < -10 or frame.Position.Y.Offset+lastToNewDifferenceY < -10 then return end
		frame.Position += UDim2.new(0,lastToNewDifferenceX,0,lastToNewDifferenceY)
		
		lastMouseX, lastMouseY = newMouseX, newMouseY
	end)
end

function defaults.contentFrameDefaults(frame: Frame)
	frame.Name = "Content"
	frame.BackgroundTransparency = 1
	frame.Position = UDim2.new(0,0,0,defaults.contentOffset)
	frame.Size = UDim2.new(1,0,1,-defaults.contentOffset)
	
	local listLayout = Instance.new("UIListLayout")
	listLayout.SortOrder = Enum.SortOrder.LayoutOrder
	listLayout.Padding = UDim.new(0,4)
	listLayout.Parent = frame
end

function defaults.sliderDefaults(slider: Frame)
	slider.Name = "Slider"
	slider.BackgroundColor3 = Color3.fromRGB(140, 133, 176)
	slider.BackgroundTransparency = .3
	slider.Size = UDim2.new(1,0,0,70)
	
	corner().Parent = slider
	
	local Title = Instance.new("TextLabel")
	Title.Name = "Title"
	Title.Text = "Slider Text"
	Title.BackgroundTransparency = 1
	Title.Size = UDim2.new(1,0,0,20)
	Title.TextSize = 18
	Title.TextColor3 = Color3.new(1,1,1)
	Title.TextXAlignment = Enum.TextXAlignment.Left
	Title.TextYAlignment = Enum.TextYAlignment.Top
	Title.FontFace = Font.fromEnum(Enum.Font.SourceSans)
	Title.Parent = slider
	
	local Min = Title:Clone()
	Min.Name = "Min"
	Min.Text = "0"
	Min.TextColor3 = Color3.fromRGB(188, 188, 209)
	Min.Size = UDim2.new(1,0,0,20)
	Min.AnchorPoint = Vector2.new(0,1)
	Min.Position = UDim2.new(0,0,1,-10)
	Min.TextYAlignment = Enum.TextYAlignment.Bottom
	Min.Parent = slider
	
	local Max = Min:Clone()
	Max.Name = "Max"
	Max.TextXAlignment = Enum.TextXAlignment.Right
	Max.Text = "100"
	Max.Parent = slider
	
	local Value = Max:Clone()
	Value.Name = "Value"
	Value.TextColor3 = Color3.new(1,1,1)
	Value.TextXAlignment = Enum.TextXAlignment.Center
	Value.Text = "50"
	Value.Parent = slider
	
	local SliderBG = Instance.new("Frame")
	SliderBG.Name = "SliderBG"
	SliderBG.AnchorPoint = Vector2.new(0,1)
	SliderBG.BackgroundColor3 = Color3.fromRGB(103, 96, 139)
	SliderBG.Position = UDim2.new(0,0,1,0)
	SliderBG.Size = UDim2.new(1,0,0,10)
	corner().Parent = SliderBG
	SliderBG.Parent = slider
	
	local Progress = SliderBG:Clone()
	Progress.AnchorPoint = Vector2.zero
	Progress.Name = "Progress"
	Progress.BackgroundColor3 = Color3.new(1,1,1)
	Progress.Size = UDim2.new(.5,0,0,10)
	Progress.Position = UDim2.new(0,0,0,0)
	Progress.Parent = SliderBG
	corner().Parent = Progress
	
	local Hitbox = Instance.new("TextButton")
	Hitbox.Name = "Hitbox"
	Hitbox.Text = ""
	Hitbox.BackgroundTransparency = 1
	Hitbox.Parent = SliderBG
	Hitbox.Size = UDim2.new(1,0,1,0)
	
	padding().Parent = slider
end

function defaults.buttonDefaults(button: TextButton)
	button.BackgroundColor3 = Color3.fromRGB(140, 133, 176)
	button.BackgroundTransparency = .3
	button.Size = UDim2.new(1,0,0,30)
	button.TextSize = 18
	button.TextColor3 = Color3.new(1,1,1)
	button.TextXAlignment = Enum.TextXAlignment.Left
	button.FontFace = Font.fromEnum(Enum.Font.SourceSans)
	button.AutoButtonColor = false
	button.ClipsDescendants = true

	corner().Parent = button
	padding().Parent = button
end

function defaults.toggleDefaults(toggle: TextButton)
	toggle.BackgroundColor3 = Color3.fromRGB(140, 133, 176)
	toggle.BackgroundTransparency = .3
	toggle.Size = UDim2.new(1,0,0,30)
	toggle.TextSize = 18
	toggle.TextColor3 = Color3.new(1,1,1)
	toggle.TextXAlignment = Enum.TextXAlignment.Left
	toggle.FontFace = Font.fromEnum(Enum.Font.SourceSans)
	toggle.AutoButtonColor = false
	--toggle.ClipsDescendants = true

	corner().Parent = toggle
	padding().Parent = toggle
	strokeframe().Parent = toggle
end

--

return defaults