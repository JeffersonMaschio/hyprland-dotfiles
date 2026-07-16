------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output   = "eDP-1",
    mode     = "1366x768@60",
    position = "0x0",
    scale    = "1",
})

hl.monitor({
    output   = "HDMI-A-1",
    mode     = "1920x1080@60",
    position = "1366x0",
    scale    = "1",
})



hl.workspace_rule({ workspace = "1",  monitor = "eDP-1",   default = true })

hl.workspace_rule({ workspace = "2",  monitor = "HDMI-A-1", default = true })
hl.workspace_rule({ workspace = "3",  monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "4",  monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "5",  monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "6",  monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "7",  monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "8",  monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "9",  monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "10", monitor = "HDMI-A-1" })


-- ou
--[[======================================================

-- Workspace 1 fixo no eDP-1
hl.workspace_rule({ workspace = "1", monitor = "eDP-1", default = true })

-- Workspaces 2-10 no HDMI-A-1
for i = 2, 10 do
  hl.workspace_rule({
    workspace = tostring(i),
    monitor   = "HDMI-A-1",
    default   = (i == 2),  -- workspace padrão do monitor externo
  })
end	

======================================================]]
