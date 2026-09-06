hl.monitor({
  output = "",
  mode = "preferred",
  position = "auto",
  scale = "auto"
})

local home = os.getenv("HOME")

hl.env("XMODIFIERS","@im=fcitx")
hl.env("QT_IM_MODULE","fcitx")
hl.env("GTK_IM_MODULE","fcitx")

-- For VMware
hl.env("LIBGL_ALWAYS_SOFTWARE","1")

local terminal = "kitty"
local fileManager = "dolphin"
local browser = "firefox"

local customScript = home .. "/dotfiles/custom-script/"

local menu = customScript .. "app-launcher.sh"
local wallpaper_launcher = customScript .. "wallpaper.sh"
local clipboard = customScript .. "clipboard.sh"
local emoji = customScript .. "emoji.sh"
local window_tab = customScript .. "window.sh"
local run_menu = customScript .. "run-launcher.sh"

local wallpaper_cache = home .. "/dotfiles/current-wallpaper"

hl.on("hyprland.start", function()
  hl.exec_cmd("systemctl --user start hyprpolkitagent")
  hl.exec_cmd("waybar")
  hl.exec_cmd("mako")
  hl.exec_cmd("awww-daemon")
  hl.exec_cmd("fcitx5 -d --replace")
  hl.exec_cmd("sleep 0.5 && " .. customScript .. "wallpaper-change.sh ~/dotfiles/wallpapers/adipocere.png")
end)

local colors = require("colors")

hl.config({
  general = {
    gaps_in = 0,
    gaps_out = 0,

    border_size = 2,

    col = {
      active_border = colors.outline,
      inactive_border = colors.outline_variant,
    },

    
    resize_on_border = true,

    allow_tearing = true,

    layout = "dwindle",
  },

  decoration = {
    rounding = 8,
    rounding_power = 3,

    active_opacity = 1.0,
    inactive_opacity = 0.7,

    shadow = {
      enabled = true,
      range = 16,
      render_power = 3,

      color = colors.shadow,
    },

    blur = {
      enabled = true,
      size = 3,
      passes = 2,

      xray = false,
      ignore_opacity = true,
    },
    
  },

  animations = {
    enabled = true,
  },
})

hl.curve("ease", {type = "bezier", points = {{0.37, 0.06}, {0.5, 1.0}}})
hl.curve("softPop", {type = "bezier", points = {{0.1, 0.6}, {0.2, 1.1}}})
hl.curve("hardPop", {type = "bezier", points = {{0.0, 0.75}, {0.3, 1.1}}})
hl.curve("linear", {type = "bezier", points = {{1,1}, {1,1}}})

hl.animation({leaf = "global", enabled = true, speed = 10, bezier = "ease"})
hl.animation({leaf = "windowsIn", enabled = true, speed = 4.5, bezier = "softPop", style = "popin 87%"})
hl.animation({leaf = "windowsOut", enabled = true, speed = 1.5, bezier = "hardPop", style = "popin 87%"})
hl.animation({leaf = "windows", enabled = true, speed = 3.5, bezier = "ease"})
hl.animation({leaf = "fadeIn", enabled = true, speed = 3.5, bezier = "hardPop"})
hl.animation({leaf = "fadeOut", enabled = true, speed = 3.5, bezier = "softPop"})
hl.animation({leaf = "layers", enabled = true, speed = 1.5, bezier = "hardPop"})
hl.animation({leaf = "workspaces", enabled = true, speed = 1.5, bezier = "ease", style = "fade"})
hl.animation({leaf = "zoomFactor", enabled = true, speed = 7, bezier = "hardPop"})

hl.config({
  dwindle = {
    preserve_split = true,
  },
})

hl.config({
  misc = {
    vrr = 1,

    disable_hyprland_logo = true,
    disable_splash_rendering = true,
    force_default_wallpaper = 0,

    mouse_move_enables_dpms = false,
    key_press_enables_dpms = true,
    focus_on_activate = true,

    middle_click_paste = false,

    initial_workspace_tracking = 1,
  },
})

hl.config({
  input = {
    kb_layout = "us",
    kb_variant = "",
    kb_model = "",
    kb_options = "",
    kb_rules = "",

    follow_mouse = 1,

    sensitivity = 0,
    accel_profile = "flat",

    repeat_delay = 500,
    repeat_rate = 20,
    
    touchpad = {
      natural_scroll = false,
      tap_to_click = true,
    },
  },
})

hl.gesture({
  fingers = 3,
  direction = "horizontal",
  action = "workspace"
})

local mainMod = "SUPER"

hl.bind(mainMod .. " + SLASH", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(run_menu))
hl.bind(mainMod .. " + TAB", hl.dsp.exec_cmd(window_tab))
hl.bind(mainMod .. " + PERIOD", hl.dsp.exec_cmd(emoji))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd(clipboard))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd(wallpaper_launcher))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))

local closeWindowBind = hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))

hl.bind(mainMod .. " + F", hl.dsp.window.float({action = "toggle"}))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())

hl.bind(mainMod .. " + left", hl.dsp.focus({direction = "left"}))
hl.bind(mainMod .. " + right", hl.dsp.focus({direction = "right"}))
hl.bind(mainMod .. " + up", hl.dsp.focus({direction = "up"}))
hl.bind(mainMod .. " + down", hl.dsp.focus({direction = "down"}))

for i = 1, 5 do
  hl.bind(mainMod .. " + " .. i, hl.dsp.focus({workspace = i}))
  hl.bind(mainMod .. " + " .. i, hl.dsp.window.move({workspace = i}))
end

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({workspace = "e-1"}))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({workspace = "e+1"}))

hl.window_rule({
  name = "fix-xwayland-drag",
  match = {
    class = "^$",
    title = "^$",
    xwayland = true,
    float = true,
    fullscreen = false,
    pin = false,
  },

  no_focus = true,
})
