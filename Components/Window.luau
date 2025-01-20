local Window = {}
Window.__index = Window

cloneref = cloneref or function(obj)
	return obj
end

-- Services

local RunService = cloneref(game:GetService("RunService"))

-- Defaults

local utils = RunService:IsStudio() and require(script.Parent.Parent:WaitForChild("Utils")) or loadstring(game:HttpGet("https://raw.githubusercontent.com/FrostX-Official/FAME-Library/refs/heads/main/Utils.luau"))()
load = utils.load

local Defaults	= load("Defaults")

-- Components

local Button	= load("Components/Button")
local Slider	= load("Components/Slider")
local Toggle	= load("Components/Toggle")

-- Config Type

export type FameWindowConfig = {
	Name: string
}

-- Main

function Window:new(config: FameWindowConfig)
	local FAME = self
	local self = setmetatable({}, Window)
	self.new = nil
	
	self.ContentIndex = 0
	self.FAME = FAME
	self.Closed = false
	
	local frame = Instance.new("Frame")
	frame.Name = config.Name
	Defaults.frameDefaults(frame)
	frame.Position = UDim2.new(0,205*FAME.WindowsCount+FAME.ScreenGui.AbsoluteSize.X/2,0,FAME.ScreenGui.AbsoluteSize.Y/2)
	
	local title = Instance.new("TextLabel")
	title.Text = config.Name
	Defaults.titleDefaults(title)
	title.Parent = frame
	
	local hider = Instance.new("TextButton")
	Defaults.hiderDefaults(hider)
	
	local contentFrame = Instance.new("Frame")
	Defaults.contentFrameDefaults(contentFrame)
	contentFrame.Parent = frame
	local contentLayout = contentFrame.UIListLayout

	FAME.WindowsCount += 1
	self.ContentFrame = contentFrame
	self.ContentLayout = contentLayout
	self.WindowFrame = frame
	frame.Parent = FAME.ScreenGui
	
	hider.MouseButton1Click:Connect(function() 
		self.Closed = not self.Closed
		--
		frame.Size = self.Closed and UDim2.new(0,200,0,50) or UDim2.new(0,200,0,60+contentLayout.AbsoluteContentSize.Y)
		contentFrame.Visible = not self.Closed
		hider.Icon.Rotation = self.Closed and 180 or 0
		--
	end)
	hider.Parent = frame
	
	return self
end

Window.newButton = Button.new
Window.newSlider = Slider.new
Window.newToggle = Toggle.new

--

return Window