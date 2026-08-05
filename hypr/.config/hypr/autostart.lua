--┌───────────────────────────────────────────────────────────┐
-- ███████╗████████╗ █████╗ ██████╗ ████████╗██╗   ██╗██████╗ 
-- ██╔════╝╚══██╔══╝██╔══██╗██╔══██╗╚══██╔══╝██║   ██║██╔══██╗
-- ███████╗   ██║   ███████║██████╔╝   ██║   ██║   ██║██████╔╝
-- ╚════██║   ██║   ██╔══██║██╔══██╗   ██║   ██║   ██║██╔═══╝ 
-- ███████║   ██║   ██║  ██║██║  ██║   ██║   ╚██████╔╝██║     
-- ╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝    ╚═════╝ ╚═╝     
--└───────────────────────────────────────────────────────────┘                                                           

hl.on("hyprland.start", function () 
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("systemctl --user import-environment WAYLAND_DISLPAY XDG_CURRENT_DESKTOP")

	-- Polkit-Gnome
	hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")

	-- Hypr-Ecosystem
	hl.exec_cmd("hyprlock & hypridle & hyprsunset & hyprcap")
	
	-- Others
	hl.exec_cmd("swaync & swayosd-server & waybar")
	hl.exec_cmd("awww-daemon")
	hl.exec_cmd("awww img ~/Imagens/selectedWallp/gruvbox-landscape.jpg")
	hl.exec_cmd("vicinae server")	
end)
