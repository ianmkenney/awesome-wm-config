awful = require("awful")
naughty = require("naughty")

local tools = {}

tools.terminal = "wezterm"
tools.editor = "emacs"

-- Screen brightness control
---- with brightnessctl

local brightness_cmd = "brightnessctl set 10%"

tools.brightness = {}

tools.brightness.up = function()
   awful.spawn(brightness_cmd .. "+", false)
   awesome.emit_signal("brightness_change")
end

tools.brightness.down = function()
   awful.spawn(brightness_cmd .. "-", false)
   awesome.emit_signal("brightness_change")
end

-- Volume
---- with amixer

tools.volume = {}

local volume_adjust = "amixer sset Master 10%"

tools.volume.mute = function()
   awful.spawn("amixer set Master 1+ toggle", false)
   awesome.emit_signal("volume_change")
end

tools.volume.up = function()
   awful.spawn(volume_adjust .. "+", false)
   awesome.emit_signal("volume_change")
end

tools.volume.down = function()
   awful.spawn(volume_adjust .. "-", false)
   awesome.emit_signal("volume_change")
end

return tools
