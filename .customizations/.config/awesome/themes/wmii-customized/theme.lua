-- wmii, awesome3 theme, by Adrian C. (anrxc) --

--{{{ Main
local awful = require("awful")
awful.util = require("awful.util")

theme = {}

home          = os.getenv("HOME")
config        = awful.util.getdir("config")
shared        = "/usr/share/awesome"
if not awful.util.file_readable(shared .. "/icons/awesome16.png") then
    shared    = "/usr/share/local/awesome"
end
sharedicons   = shared .. "/icons"
sharedthemes  = shared .. "/themes"
themes        = config .. "/themes"
themename     = "/wmii"
if not awful.util.file_readable(themes .. themename .. "/theme.lua") then
       themes = sharedthemes
end
themedir      = themes .. themename

wallpaper1    = themedir .. "/background.jpg"
wallpaper2    = themedir .. "/background.png"
wallpaper3    = sharedthemes .. "/default/background.png"
wallpaper4    = sharedthemes .. "/zenburn/zenburn-background.png"
wpscript      = home .. "/.wallpaper"

wallpaperArch = themedir .. "/background-arch.png"

if awful.util.file_readable(wallpaperArch) then
    theme.wallpaper = wallpaperArch
elseif awful.util.file_readable(wallpaper1) then
	theme.wallpaper = wallpaper1
elseif awful.util.file_readable(wallpaper2) then
	theme.wallpaper = wallpaper2
elseif awful.util.file_readable(wpscript) then
	theme.wallpaper_cmd = { "sh " .. wpscript }
elseif awful.util.file_readable(wallpaper3) then
    theme.wallpaper = wallpaper3
else
    theme.wallpaper = wallpaper4
end

if awful.util.file_readable(config .. "/vain/init.lua") then
    theme.useless_gap_width  = "3"
end
--}}}


-- {{{ Styles
theme.font          = "Dejavu Sans 8"

--- Stolen from https://bitbucket.org/LK4D4/awesome-3.5/src/8216eb46cf33fa6da030f1ae56bac239a3489072/themes/awesome-solarized/dark/theme.lua?at=master
theme.colors = {}
theme.colors.base3   = "#002b36"
theme.colors.base2   = "#073642"
theme.colors.base1   = "#586e75"
theme.colors.base0   = "#657b83"
theme.colors.base00  = "#839496"
theme.colors.base01  = "#93a1a1"
theme.colors.base02  = "#eee8d5"
theme.colors.base03  = "#fdf6e3"
theme.colors.yellow  = "#b58900"
theme.colors.orange  = "#cb4b16"
theme.colors.red     = "#dc322f"
theme.colors.magenta = "#d33682"
theme.colors.violet  = "#6c71c4"
theme.colors.blue    = "#268bd2"
theme.colors.cyan    = "#2aa198"
theme.colors.green   = "#859900"

-- {{{ Colors
theme.fg_normal  = theme.colors.base02
theme.fg_focus   = theme.colors.base03
theme.fg_urgent  = theme.colors.base3

theme.bg_normal  = theme.colors.base3
theme.bg_focus   = theme.colors.base1
theme.bg_urgent  = theme.colors.red
theme.bg_systray = theme.bg_normal
-- }}}

-- {{{ Borders
theme.border_width  = "2"
theme.border_normal = theme.bg_normal
theme.border_focus  = theme.bg_focus
theme.border_marked = theme.bg_urgent
-- }}}

-- {{{ Titlebars
theme.titlebar_bg_focus  = theme.bg_focus
theme.titlebar_bg_normal = theme.bg_normal
-- }}}

--[[
-- {{{ Colors
theme.fg_normal     = "#000000"
theme.fg_focus      = "#000000"
theme.fg_urgent     = "#CF6171"
--theme.fg_minimize = "#000000"
theme.bg_normal     = "#C1C48B"
theme.bg_focus      = "#81654F"
theme.bg_urgent     = "#C1C48B"
--theme.bg_minimize = "#81654F"
-- }}}

-- {{{ Borders
theme.border_width  = "1"
theme.border_normal = "#81654F"
theme.border_focus  = "#000000"
theme.border_marked = "#CF6171"
-- }}}

-- {{{ Titlebars
theme.titlebar_bg_focus  = "#81654F"
theme.titlebar_bg_normal = "#C1C48B"
-- theme.titlebar_[normal|focus]
-- }}}

--]]

-- {{{ Other
-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- Example:
--theme.taglist_bg_focus = "#CF6171"
-- }}}

-- {{{ Widgets
-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.fg_widget        = "#AECF96"
--theme.fg_center_widget = "#88A175"
--theme.fg_end_widget    = "#FF5656"
--theme.bg_widget        = "#494B4F"
--theme.border_widget    = "#3F3F3F"
-- }}}

-- {{{ Mouse finder
theme.mouse_finder_color = "#CF6171"
-- theme.mouse_finder_[timeout|animate_timeout|radius|factor]
-- }}}

-- {{{ Menu
-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_height = "15"
theme.menu_width  = "100"
-- }}}
-- }}}

-- {{{ Icons
-- {{{ Taglist
theme.taglist_squares_sel   = sharedthemes .. "/zenburn/taglist/squarefz.png"
theme.taglist_squares_unsel = sharedthemes .. "/zenburn/taglist/squarez.png"
--theme.taglist_squares_resize = "false"
-- }}}

-- {{{ Misc
theme.awesome_icon           = sharedicons .. "/awesome16.png"
theme.menu_submenu_icon      = sharedthemes .. "/default/submenu.png"
theme.tasklist_floating_icon = sharedthemes .. "/default/tasklist/floating.png"
-- }}}

-- {{{ Layout
theme.layout_fairh      = sharedthemes .. "/zenburn/layouts/fairh.png"
theme.layout_fairv      = sharedthemes .. "/zenburn/layouts/fairv.png"
theme.layout_floating   = sharedthemes .. "/zenburn/layouts/floating.png"
theme.layout_magnifier  = sharedthemes .. "/zenburn/layouts/magnifier.png"
theme.layout_max        = sharedthemes .. "/zenburn/layouts/max.png"
theme.layout_fullscreen = sharedthemes .. "/zenburn/layouts/fullscreen.png"
theme.layout_tilebottom = sharedthemes .. "/zenburn/layouts/tilebottom.png"
theme.layout_tileleft   = sharedthemes .. "/zenburn/layouts/tileleft.png"
theme.layout_tile       = sharedthemes .. "/zenburn/layouts/tile.png"
theme.layout_tiletop    = sharedthemes .. "/zenburn/layouts/tiletop.png"
theme.layout_spiral     = sharedthemes .. "/zenburn/layouts/spiral.png"
theme.layout_dwindle    = sharedthemes .. "/zenburn/layouts/dwindle.png"
-- }}}

-- {{{ Titlebar
theme.titlebar_close_button_normal = sharedthemes .. "/zenburn/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = sharedthemes .. "/zenburn/titlebar/close_focus.png"

theme.titlebar_ontop_button_normal_inactive = sharedthemes .. "/zenburn/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = sharedthemes .. "/zenburn/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active   = sharedthemes .. "/zenburn/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active    = sharedthemes .. "/zenburn/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = sharedthemes .. "/zenburn/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = sharedthemes .. "/zenburn/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active   = sharedthemes .. "/zenburn/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active    = sharedthemes .. "/zenburn/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = sharedthemes .. "/zenburn/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = sharedthemes .. "/zenburn/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active   = sharedthemes .. "/zenburn/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active    = sharedthemes .. "/zenburn/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = sharedthemes .. "/zenburn/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = sharedthemes .. "/zenburn/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active   = sharedthemes .. "/zenburn/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active    = sharedthemes .. "/zenburn/titlebar/maximized_focus_active.png"
-- }}}
-- }}}

return theme
