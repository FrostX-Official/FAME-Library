local FAME = {}
FAME.__index = FAME

--[[

Name: FAME
Author: frostxoff
Description:
An UI library written on Luau for Roblox.

--]]

local cloneref = cloneref or function(obj)
	return obj
end

-- Services

local RunService	= cloneref(game:GetService("RunService"))
local CoreGui		= cloneref(game:GetService("CoreGui"))
local Players		= cloneref(game:GetService("Players"))

-- Define GUIs Parent

local FAME_Parent 	= type(gethui) == "function" and typeof(gethui()) == "Instance" and gethui() or RunService:IsStudio() and Players.LocalPlayer.PlayerGui or CoreGui

-- FAME Libraries

local utils 		= RunService:IsStudio() and require(script:WaitForChild("Utils")) or loadstring(game:HttpGet("https://raw.githubusercontent.com/FrostX-Official/FAME-Library/refs/heads/main/Utils.luau"))()
load = utils.load

local Defaults		= load("Defaults")
local Window		= load("Components/Window")

-- Config Type

export type FameConfig = {
	Name: string,
	Utils: {any}? -- Change default utils library with your own if you want
}

-- Main

function FAME.new(config: FameConfig)
	local self = setmetatable({}, FAME)
	self.Config = config
	self.WindowsCount = 0
	
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = self.Config.Name
	
	Defaults.guiDefaults(screenGui)
	
	screenGui.Parent = FAME_Parent
	screenGui.Enabled = true
	
	self.ScreenGui = screenGui

	return self
end

FAME.newWindow = Window.new

return FAME