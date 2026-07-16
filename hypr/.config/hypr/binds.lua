--┌──────────────────────────────────────────────────────────────┐
-- ██╗  ██╗███████╗██╗   ██╗██████╗ ██╗███╗   ██╗██████╗ ███████╗
-- ██║ ██╔╝██╔════╝╚██╗ ██╔╝██╔══██╗██║████╗  ██║██╔══██╗██╔════╝
-- █████╔╝ █████╗   ╚████╔╝ ██████╔╝██║██╔██╗ ██║██║  ██║███████╗
-- ██╔═██╗ ██╔══╝    ╚██╔╝  ██╔══██╗██║██║╚██╗██║██║  ██║╚════██║
-- ██║  ██╗███████╗   ██║   ██████╔╝██║██║ ╚████║██████╔╝███████║
-- ╚═╝  ╚═╝╚══════╝   ╚═╝   ╚═════╝ ╚═╝╚═╝  ╚═══╝╚═════╝ ╚══════╝
--└──────────────────────────────────────────────────────────────┘                              

local mainMod = "SUPER"

hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd("kitty"))
local closeWindowBind = hl.bind(mainMod .. " + W", hl.dsp.window.close())
-- closeWindowBind:set_enabled(false)
hl.bind(mainMod .. " + CTRL + ALT + SHIFT + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("nemo"))
hl.bind(mainMod .. " + T", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd("~/.config/rofi/launchers/type-4/launcher.sh "))
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))    -- dwindle only

--//==========================   HYPRLAND BINDS   =================================//

-- Screenshot - Window
hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -m window -o ~/Imagens/Screenshots"))

-- ScreenShot - Region
hl.bind(mainMod .. "+ PRINT", hl.dsp.exec_cmd("hyprshot -m region -o ~/Imagens/Screenshots"))

-- Hyprlock
hl.bind(mainMod .. "+ L", hl.dsp.exec_cmd("hyprlock"))

-- SDDM
--hl.bind(mainMod .. "+ L", hl.dsp.exec_cmd("dm-tool switch-to-greeter"))

-- Hyprpicker
hl.bind(mainMod .. "+ SHIFT + C", hl.dsp.exec_cmd("hyprpicker -a -n -l"))

-- Hyprcap
--hl.bind(mainMod .. "+ R", hl.dsp.exec_cmd("hyprcap rec monitor:active -o ~/Vídeos/Capturas\ de\ vídeo/")

--//===========================   MINHAS BINDS   ==================================//

-- Firefox
hl.bind(mainMod .. "+ SHIFT + B", hl.dsp.exec_cmd("firefox"))
hl.bind(mainMod .. "+ ALT + SHIFT + B", hl.dsp.exec_cmd("firefox --private-window"))

-- Restart Waybar + Swaync
hl.bind(mainMod .. "+ SHIFT + ESCAPE", hl.dsp.exec_cmd("~/.config/waybar/scripts/launch.sh"))

-- Fullscreen
hl.bind("SUPER + SHIFT + SPACE", hl.dsp.window.fullscreen())

-- Wlogout
hl.bind(mainMod .. "+ ESCAPE", hl.dsp.exec_cmd("wlogout"))

-- Wallpaper Selector
hl.bind(mainMod .. "+ P", hl.dsp.exec_cmd("~/.config/wofi/wofi-wallpaper-selector.sh"))

-- Brilho +/-
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("swayosd-client --brightness +10"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("swayosd-client --brightness -10"))

-- Volume +/-
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("swayosd-client --output-volume +5"))
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("swayosd-client --output-volume -5"))
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("swayosd-client --output-volume mute-toggle"))

-------------------------------------------------------------------------------------------

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })



