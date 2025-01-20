util = {}

--[[

Name: FAME Utils
Author: frostxoff (completely skidded a lot of stuff from 7GrandDad and their VapeV4ForRoblox 🖤)
Description:
An utility library for FAME UI Library
Change util.FAMEINSTANCE to your FAME ModuleScript Instance if you're testing in studio compiled version

--]]

local oldloadstring = loadstring

util.cloneref = cloneref or function(obj)
	return obj
end
cloneref = util.cloneref

local RunService = cloneref(game:GetService("RunService"))

-- Change this to fame module path if want to run it in studio yourself
util.FAMEINSTANCE = RunService:IsStudio() and game.StarterPlayer.StarterPlayerScripts.LocalScript.FAME or nil

local function notsupported(name: string)
    if RunService:IsStudio() then
        error("\""..name.."\" is not supported in Roblox Studio! 🙄")
    else
        error("Your exploit doesn't support \""..name.."\"! 🙄")
    end
end

util.readfile = readfile or function(...)
    notsupported("readfile")
end
readfile = util.readfile

util.writefile = writefile or function(...)
    notsupported("writefile")
end
writefile = util.writefile

util.isfile = isfile or function(file)
	local suc, res = pcall(function()
		return readfile(file)
	end)
	return suc and res ~= nil and res ~= ''
end
isfile = util.isfile

util.loadstring = function(...)
	local res, err = loadstring(...)
	return res
end

util.load = RunService:IsStudio() and function(path: string)
    local inst = util.FAMEINSTANCE
	for _, index in path:split("/") do
		inst = inst:FindFirstChild(index)
		if not inst then
			error("404: Not found \""..path.."\" under FAMEINSTANCE")
		end
	end
	return require(inst)
end or function(path: string)
    return util.loadstring(game:HttpGet("https://raw.githubusercontent.com/FrostX-Official/FAME-Library/refs/heads/main/"..path..".luau"))()
end

return util