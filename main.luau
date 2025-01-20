local FAME = {}
FAME.__index = FAME

--[[

Name: FAME
Author: frostxoff
Description:
A roblox UI library for cool people

--]]

local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local FAME_Parent = type(gethui) == "function" and typeof(gethui()) == "Instance" and gethui() or RunService:IsStudio() and Players.LocalPlayer.PlayerGui or CoreGui

local fameDefaults = loadstring(game:HttpGet("https://raw.githubusercontent.com/FrostX-Official/FAME-Library/refs/heads/main/Defaults.luau"))()
local Window = loadstring(game:HttpGet("https://raw.githubusercontent.com/FrostX-Official/FAME-Library/refs/heads/main/Components/Window.luau"))()

export type FameConfig = {
	Name: string
}

function FAME.new(config: FameConfig)
	local self = setmetatable({}, FAME)
	self.Config = config
	
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = self.Config.Name
	
	fameDefaults.guiDefaults(screenGui)
	
	screenGui.Parent = FAME_Parent
	screenGui.Enabled = true
	
	self.ScreenGui = screenGui
	self.WindowsCount = 0

	return self
end

FAME.newWindow = Window.new

return FAME