local wibox = require("wibox")
local beautiful = require("beautiful")
local awful = require("awful")
local gears = require("gears")

beautiful.init("/home/ikenney/.config/awesome/themes/default/theme.lua")

local component = {}

local pbar = wibox.widget.progressbar()
local bg = wibox.container.background()

bg.fg = beautiful.border_normal
bg.opacity = 1
bg.shape = gears.shape.rounded_rect

pbar.margins = {top = 6, bottom = 6, left = 4, right = 4}

pbar.forced_width = 60
pbar.max_value = 1
pbar.value = 0.5
pbar.border_width = 1
pbar.border_color = "#ffffff"
pbar.background_color = beautiful.bg_normal
pbar.bar_shape = gears.shape.rounded_rect
pbar.shape = gears.shape.rounded_rect

local layout = wibox.layout.stack()
layout:add(pbar)

bg.widget = layout

awful.widget.watch("acpi -b", 3, function(layout, stdout)
	 pbar = layout:get_all_children()[1]

	 _, _, percent_charged = string.find(stdout, "(%d+)%%")
	 num = tonumber(percent_charged)
	 if num ~= nil then
	    pbar.value = num / 100
	 end

	 if string.find(stdout, "Charging") then
	    pbar.color = beautiful.bg_focus
	 elseif string.find(stdout, "Full") then
	    pbar.color = beautiful.bg_focus
	 elseif string.find(stdout, "Not charging") then
	    pbar.color = beautiful.bg_focus
	 else
	    pbar.color = "#ff0000"
	 end

end, layout)

local bat_tt = awful.tooltip{
   objects = {pbar},
   timer_function = function()
      local handle = io.popen("acpi -b")
      local result = handle:read("*a")
      handle:close()

      lines = {}
      for s in result:gmatch("[^\r\n]+") do
	 table.insert(lines, s)
      end

      return lines[1]
   end,
}

return bg

