local Slider = {}
Slider.__index = Slider

cloneref = cloneref or function(obj)
	return obj
end

-- Services

local UserInputService 	= cloneref(game:GetService("UserInputService"))
local RunService 		= cloneref(game:GetService("RunService"))
local Players 			= cloneref(game:GetService("Players"))

-- Defaults

local utils = RunService:IsStudio() and require(script.Parent.Parent:WaitForChild("Utils")) or loadstring(game:HttpGet("https://raw.githubusercontent.com/FrostX-Official/FAME-Library/refs/heads/main/Utils.luau"))()
load = utils.load

local Defaults = load("Defaults")

-- Some Variables

local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

-- Config Type

export type FameSliderConfig = {
	Text: string,
	Callback: () -> nil,
	Range: NumberRange,
	Default: number
}

-- Main

local function xscale(GuiObject)
	local X = Mouse.X - GuiObject.AbsolutePosition.X
	local MaxX = GuiObject.AbsoluteSize.X
	X = math.clamp(X, 0, MaxX)
	return X/MaxX
end

function Slider:new(config: FameSliderConfig)
	local Window = self
	local self = setmetatable({}, Slider)
	self.new = nil
	self.Value = config.Default
	self.prevValue = config.Default
	self.Min = config.Range.Min
	self.Max = config.Range.Max
	self.Default = config.Default
	self.Callback = config.Callback
	self._Holding = false
	
	Window.ContentIndex += 1
	
	local slider = Instance.new("Frame")
	Defaults.sliderDefaults(slider)
	slider.LayoutOrder = Window.ContentIndex
	
	local titleText: TextLabel = slider:WaitForChild("Title")
	local minText: TextLabel = slider:WaitForChild("Min")
	local maxText: TextLabel = slider:WaitForChild("Max")
	local valueText: TextLabel = slider:WaitForChild("Value")
	local sliderBG: Frame = slider:WaitForChild("SliderBG")
	local progress: Frame = sliderBG:WaitForChild("Progress")
	local hitbox: TextButton = sliderBG:WaitForChild("Hitbox")
	
	titleText.Text = config.Text
	minText.Text = self.Min
	maxText.Text = self.Max
	valueText.Text = self.Default
	
	hitbox.MouseButton1Down:Connect(function() 
		self._Holding = true
	end)
	local con1
	local con2
	con1 = UserInputService.InputEnded:Connect(function(input: InputObject)
		if input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
		self._Holding = false
	end)
	con2 = RunService.Heartbeat:Connect(function() 
		if not self._Holding then return end
		self.Value = (self.Min + ((self.Max - self.Min) * xscale(hitbox)))
		progress.Size = UDim2.new((self.Value-self.Min)/(self.Max-self.Min), 0, 1, 0)
		valueText.Text = math.floor(self.Value)
		self.Callback(self.Value)
	end)
	slider.Destroying:Connect(function() 
		if con1 then
			con1:Disconnect()
		end
		if con2 then
			con2:Disconnect()
		end
	end)
	
	slider.Parent = Window.ContentFrame
	if not Window.Closed then
		if Window.ContentLayout.AbsoluteContentSize.Y ~= 0 then
			Window.WindowFrame.Size = UDim2.new(0,200,0,60+Window.ContentLayout.AbsoluteContentSize.Y)
		else
			Window.WindowFrame.Size = UDim2.new(0,200,0,50)
		end
	end

	return self
end

--

return Slider