> [!NOTE]
> Currently in development!<br>
> May be not secure in production!<br>
> Or may not work at all!

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
-- loadstring should be replaced with module require if used in studio ^
local newFameUI = FAME.new({Name="Test Script"})
local newWindow = newFameUI:newWindow({Name="Test Script"})

local test_button = newWindow:newButton({
	Text = "Button",
	Callback = function(): nil
		print("clicked")
	end
})

local test_toggle = newWindow:newToggle({
	Text = "Toggle",
	Default = false,
	Callback = function(enabled: boolean): nil
		print(enabled)
	end
})

local test_slider = newWindow:newSlider({
	Text = "Slider",
	Default = 50,
	Range = NumberRange.new(0, 100),
	Callback = function(value: number): nil
		print(value)
	end
})
```

# TODO
- new components:
 - dropdowns
 - color picker
 - keybinder
 - label
- custom components creation and custom windows (like key system)
- color theme setting
- compiler for studio rbxm