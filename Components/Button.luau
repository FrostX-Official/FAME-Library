local Button = {}
Button.__index = Button

local fameDefaults = loadstring(game:HttpGet("https://raw.githubusercontent.com/FrostX-Official/FAME-Library/refs/heads/main/Defaults.luau"))
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local Debris = game:GetService("Debris")

local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

export type FameButtonConfig = {
	Text: string,
	Callback: () -> nil
}

local function corner()
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(1,0)
	return corner
end

function Button:new(config: FameButtonConfig)
	local Window = self
	local self = setmetatable({}, Button)
	self.new = nil
	
	Window.ContentIndex += 1
	
	local button = Instance.new("TextButton")
	fameDefaults.buttonDefaults(button)
	button.Text = config.Text
	button.MouseButton1Click:Connect(config.Callback)
	button.LayoutOrder = Window.ContentIndex
	button.Parent = Window.ContentFrame

	button.MouseButton1Click:Connect(function() 
		local enterPosInButton = Vector2.new(Mouse.X,Mouse.Y)-button.AbsolutePosition
		local enterFrame = Instance.new("Frame")
		TweenService:Create(enterFrame, TweenInfo.new(.5), {Size=UDim2.new(0,300,0,300),BackgroundTransparency=1}):Play()
		enterFrame.Name = "EnterFrame"
		enterFrame.AnchorPoint = Vector2.new(.5,.5)
		enterFrame.Position = UDim2.new(0,enterPosInButton.X-10,0,enterPosInButton.Y-10)
		enterFrame.Size = UDim2.new(0,0,0,0)
		enterFrame.Parent = button
		enterFrame.BackgroundColor3 = Color3.new(0.266667, 0.141176, 0.454902)--0.482353, 0.25098, 0.807843
		corner().Parent = enterFrame

		Debris:AddItem(enterFrame, .52)
		if config.Callback then
			config.Callback()
		end
	end)
	
	if not Window.Closed then
		if Window.ContentLayout.AbsoluteContentSize.Y ~= 0 then
			Window.WindowFrame.Size = UDim2.new(0,200,0,60+Window.ContentLayout.AbsoluteContentSize.Y)
		else
			Window.WindowFrame.Size = UDim2.new(0,200,0,50)
		end
	end
	
	return self
end

return Button