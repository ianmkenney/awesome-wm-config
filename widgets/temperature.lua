local awful = require("awful")
local gears = require("gears")

local temp_box = awful.widget.watch("acpi -t", 3, function(widget, stdout)
				       _, _, temp = string.find(stdout, "(%d+).0 degrees C")

				       if temp ~= nil then
					  widget.text = temp .. "°C"
				       else
					  widget.text = "unknown"
				       end

end)

return temp_box
