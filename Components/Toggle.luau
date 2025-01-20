local Toggle = {}
Toggle.__index = Toggle

cloneref = cloneref or function(obj)
	return obj
end

-- Services

local RunService = cloneref(game:GetService("RunService"))

-- Defaults

local utils = RunService:IsStudio() and require(script.Parent.Parent:WaitForChild("Utils")) or loadstring(game:HttpGet("https://raw.githubusercontent.com/FrostX-Official/FAME-Library/refs/heads/main/Utils.luau"))()
load = utils.load

local Defaults = load("Defaults")

-- Config Type

export type FameToggleConfig = {
	Text: string,
	Callback: () -> nil,
	Default: boolean
}

-- Main

function Toggle:new(config: FameToggleConfig)
	local Window = self
	local self = setmetatable({}, Toggle)
	self.new = nil
	self.Enabled = config.Default or false

	Window.ContentIndex += 1
	
	local toggle = Instance.new("TextButton")
	Defaults.toggleDefaults(toggle)
	toggle.Text = config.Text
	toggle.LayoutOrder = Window.ContentIndex
	local strokeframe: Frame = toggle.Frame
	local stroke: UIStroke = strokeframe.UIStroke
	
	local function update()
		stroke.Color = self.Enabled and Color3.fromRGB(185, 150, 230) or Color3.fromRGB(88, 71, 110)
		stroke.Transparency = self.Enabled and 0 or .2
		stroke.Thickness = self.Enabled and 3 or 2
		strokeframe.Size = UDim2.new(1,18-stroke.Thickness,1,18-stroke.Thickness)
	end
	
	toggle.MouseButton1Click:Connect(function() 
		self.Enabled = not self.Enabled
		update()
		config.Callback(self.Enabled)
	end) 
	update()
	
	toggle.Parent = Window.ContentFrame
	
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

return Toggle