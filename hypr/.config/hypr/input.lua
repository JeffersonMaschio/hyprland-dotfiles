
----------------
----  MISC  ----
----------------

hl.config({
    misc = {
        force_default_wallpaper = -1,    -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo   = false, -- If true disables the random hyprland logo / anime girl background. :(
    },
})


--┌───────────────────────────────────────┐
-- ██╗███╗   ██╗██████╗ ██╗   ██╗████████╗
-- ██║████╗  ██║██╔══██╗██║   ██║╚══██╔══╝
-- ██║██╔██╗ ██║██████╔╝██║   ██║   ██║   
-- ██║██║╚██╗██║██╔═══╝ ██║   ██║   ██║   
-- ██║██║ ╚████║██║     ╚██████╔╝   ██║   
-- ╚═╝╚═╝  ╚═══╝╚═╝      ╚═════╝    ╚═╝   
--└───────────────────────────────────────┘                              

hl.config({
    input = {
        kb_layout  = "br",
        kb_variant = "abnt2",
        kb_model   = "abnt2",
        kb_options = "",
        kb_rules   = "",

        follow_mouse = 1,

		accel_profile = flat,
		force_no_accel = true,

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = true,
            disable_while_typing = true,
        },
    },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})




