--┌─────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
-- ██╗    ██╗██╗███╗   ██╗██████╗  ██████╗ ██╗    ██╗███████╗    
-- ██║    ██║██║████╗  ██║██╔══██╗██╔═══██╗██║    ██║██╔════╝    
-- ██║ █╗ ██║██║██╔██╗ ██║██║  ██║██║   ██║██║ █╗ ██║███████╗    
-- ██║███╗██║██║██║╚██╗██║██║  ██║██║   ██║██║███╗██║╚════██║    
-- ╚███╔███╔╝██║██║ ╚████║██████╔╝╚██████╔╝╚███╔███╔╝███████║    
--  ╚══╝╚══╝ ╚═╝╚═╝  ╚═══╝╚═════╝  ╚═════╝  ╚══╝╚══╝ ╚══════╝    
--  █████╗ ███╗   ██╗██████╗     ██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗███████╗██████╗  █████╗  ██████╗███████╗███████╗
-- ██╔══██╗████╗  ██║██╔══██╗    ██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██╔════╝██╔══██╗██╔══██╗██╔════╝██╔════╝██╔════╝
-- ███████║██╔██╗ ██║██║  ██║    ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ███████╗██████╔╝███████║██║     █████╗  ███████╗
-- ██╔══██║██║╚██╗██║██║  ██║    ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ╚════██║██╔═══╝ ██╔══██║██║     ██╔══╝  ╚════██║
-- ██║  ██║██║ ╚████║██████╔╝    ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗███████║██║     ██║  ██║╚██████╗███████╗███████║
-- ╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝      ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝  ╚═╝ ╚═════╝╚══════╝╚══════╝
--└─────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘

-- TAMANHO      Width         Height
-- size = {"window_w" XXX,"window_h" XXX}

-- CENTRALIZAR
-- move = { "(monitor_w-window_w)/2", "(monitor_h-window_h)/2"}
            
-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})

-- My WindowRules

hl.window_rule({ match = { class = "nemo"}, float = true})
hl.window_rule({ match = { class = "nwg-look"}, size = {600, 500}, float = true})
hl.window_rule({ match = { class = "org.gnome.Loupe"}, float = true})
hl.window_rule({ match = { class = "org.gnome.FileRoller"}, float = true})
hl.window_rule({ match = { class = "nvidia-settings"}, size = {600, 600}, float = true})

-- Steam
hl.window_rule({ match = { class = "steam"}, match = { title = "Friend List"}, size = {300, 725}, float = true})
hl.window_rule({ match = { class = "steam"}, match = { title = "Steam - Configurações"}, size = {800, 600}, float = true})

hl.window_rule({ match = { class = "io.github.kaii_lb.Overskride"}, size = {400, 700}, float = true})
-- hl.window_rule({ match = { class = "org.pulseaudio.pavucontrol"}, float = true})

hl.window_rule({ match = { class = "kitty"}, match = { title = "btop"}, float = true})
hl.window_rule({ match = { class = "kitty"}, match = { title = "impala"}, float = true})
hl.window_rule({ match = { class = "kitty"}, match = { title = "wiremix"}, float = true})
hl.window_rule({ match = { class = "com.network.manager"}, size = {400, 600}, float = true})
hl.window_rule({ match = { class = "file.png"}, float = true})

-- CachyOS
hl.window_rule({ match = { class = "CachyOSHello"}, match = { title = "CachyOS Hello"}, float = true})
hl.window_rule({ match = { class = "org.cachyos.scx-manager"}, match = { title = "CachyOS Configure sched-ext"}, float = true})
hl.window_rule({ match = { class = "org.cachyos.KernelManager"}, match = { title = "CachyOs Kernel Manager"}, float = true})
hl.window_rule({ match = { class = "org.cachyos.cachyos-pi"}, match = { title = "CachyOS Package Installer"}, float = true})

-- TkInter
hl.window_rule({ match = { class = "Tk"}, float = true})

-- Wlogout - Blur
hl.layer_rule({ match = {namespace = "logout_dialog"}, blur = true, ignore_alpha = false})

-- Intellij - tooltip fix
hl.window_rule({
    match = {
        class = "^jetbrains%-.*$",
        title = "^win[0-9]+$",
    },
    no_focus = true,
    float = true,
})
