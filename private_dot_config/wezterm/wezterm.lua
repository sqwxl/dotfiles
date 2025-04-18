local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.default_prog = { "/usr/bin/fish" }

config.font = wezterm.font("FantasqueSansM Nerd Font Mono")
config.font_size = 12

config.color_scheme = "GruvboxDark"

config.integrated_title_button_style = "Gnome"
config.integrated_title_buttons = { "Close" }
config.use_fancy_tab_bar = false
config.window_decorations = "RESIZE"
-- config.hide_tab_bar_if_only_one_tab = true

config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }

return config
