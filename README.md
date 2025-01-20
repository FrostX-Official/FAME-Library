> [!NOTE]
> Currently in development!
> May be not secure in production.

# FAME-Library
An UI library written on Luau for Roblox.<br>
Mostly used in exploit scripts, but note that this is not an exploit repository and Cheating/Exploiting is against Roblox TOS.

# Loadstring

```lua
local FAME = loadstring(game:HttpGet("https://raw.githubusercontent.com/FrostX-Official/FAME-Library/refs/heads/main/main.luau"))()
```

# Example

```lua
local FAME = loadstring(game:HttpGet("https://raw.githubusercontent.com/FrostX-Official/FAME-Library/refs/heads/main/main.luau"))()
local newFameUI = FAME.new({Name="Test Script"})
local newWindow = newFameUI:newWindow({Name="Test Script"})

local test_button = newWindow:newButton({
	Text="Button",
	Callback=function(): nil
		print("clicked")
	end,
})

local test_toggle = newWindow:newToggle({
	Text="Toggle",
	Default=false,
	Callback=function(enabled: boolean): nil
		print(enabled)
	end,
})

local test_slider = newWindow:newSlider({
	Text="Slider",
	Default=50,
    Range=NumberRange.new(0, 100),
	Callback=function(value: number): nil
		print(value)
	end,
})

```