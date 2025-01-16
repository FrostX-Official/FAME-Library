local Window = {}
Window.__index = Window

local Components = script.Parent

local fameDefaults = loadstring(game:HttpGet("https://raw.githubusercontent.com/FrostX-Official/FAME-Library/refs/heads/main/Defaults.luau"))
local Button = loadstring(game:HttpGet("https://raw.githubusercontent.com/FrostX-Official/FAME-Library/refs/heads/main/Components/Button.luau"))
local Slider = loadstring(game:HttpGet("https://raw.githubusercontent.com/FrostX-Official/FAME-Library/refs/heads/main/Components/Slider.luau"))
local Toggle = loadstring(game:HttpGet("https://raw.githubusercontent.com/FrostX-Official/FAME-Library/refs/heads/main/Components/Toggle.luau"))

export type FameWindowConfig = {
	Name: string
}

function Window:new(config: FameWindowConfig)
	local FAME = self
	local self = setmetatable({}, Window)
	self.new = nil
	
	self.ContentIndex = 0
	self.FAME = FAME
	self.Closed = false
	
	local frame = Instance.new("Frame")
	frame.Name = config.Name
	fameDefaults.frameDefaults(frame)
	frame.Position = UDim2.new(0,205*FAME.WindowsCount+FAME.ScreenGui.AbsoluteSize.X/2,0,FAME.ScreenGui.AbsoluteSize.Y/2)
	
	local title = Instance.new("TextLabel")
	title.Text = config.Name
	fameDefaults.titleDefaults(title)
	title.Parent = frame
	
	local hider = Instance.new("TextButton")
	fameDefaults.hiderDefaults(hider)
	
	local contentFrame = Instance.new("Frame")
	fameDefaults.contentFrameDefaults(contentFrame)
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

return Window