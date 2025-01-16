local FAME = {}
FAME.__index = FAME

--[[

Name: FAME
Author: frostxoff
Description:
A roblox UI library for cool people

--]]

local Players = game:GetService("Players")

local fameDefaults = loadstring(game:HttpGet("https://raw.githubusercontent.com/FrostX-Official/FAME-Library/refs/heads/main/Defaults.luau"))
local Window = loadstring(game:HttpGet("https://raw.githubusercontent.com/FrostX-Official/FAME-Library/refs/heads/main/Components/Window.luau"))

local Player = Players.LocalPlayer
local PlayerGui = Player.PlayerGui

export type FameConfig = {
	Name: string
}

function FAME.new(config: FameConfig)
	local self = setmetatable({}, FAME)
	self.Config = config
	
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = self.Config.Name
	
	fameDefaults.guiDefaults(screenGui)
	
	screenGui.Parent = PlayerGui
	screenGui.Enabled = true
	
	self.ScreenGui = screenGui
	self.WindowsCount = 0

	return self
end

FAME.newWindow = Window.new

return FAME