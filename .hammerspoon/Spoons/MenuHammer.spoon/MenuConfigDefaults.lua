----------------------------------------------------------------------------------------------------
--------------------------------------- General Config ---------------------------------------------
----------------------------------------------------------------------------------------------------
local key_helper = require("helpers.key_helper")
local display_helper = require("helpers.display_helper")
local media_helper = require("helpers.media_helper")
local utils = require("helpers.utils")

--============================================= Clipboard load early =============================================
spoon.SpoonInstall:andUse("ClipboardTool", {
	start = true,
	config = {
		paste_on_select = true,
		show_copied_alert = false,
		show_in_menubar = false,
		deduplicate = true,
	},
})

-- If enabled, the menus will appear over full screen applications.
-- However, the Hammerspoon dock icon will also be disabled (required for fullscreen).
menuShowInFullscreen = false

-- If enabled, a menu bar item will appear that shows what menu is currently being displayed or
-- "idle" if no menu is open.
showMenuBarItem = false

-- The number of seconds that a hotkey alert will stay on screen.
-- 0 = alerts are disabled.
hs.hotkey.alertDuration = nil

-- Show no titles for Hammerspoon windows.
hs.hints.showTitleThresh = 0

-- Disable animations
hs.window.animationDuration = 0.5

-- Editor path
menuTextEditor = "/opt/homebrew/bin/nvim"

-- Location of the askpass executable.  Required for running script with admin privs.
askpassLocation = "/usr/local/bin/ssh-askpass"

----------------------------------------------------------------------------------------------------
----------------------------------------- Menu options ---------------------------------------------
----------------------------------------------------------------------------------------------------

-- The number of columns to display in the menus (vertical layout = 1)
menuNumberOfColumns = 1

-- The minimum number of rows to show in menus
menuMinNumberOfRows = 4

-- The height of menu rows in pixels
menuRowHeight = 30

-- The padding to apply to each side of the menu
menuOuterPadding = 0

-- Menu width in pixels for vertical layout
menuWidth = 250

-- Menu positioning (bottom-left corner)
menuPaddingX = 30  -- Distance from left edge
menuPaddingY = 60  -- Distance from bottom edge

-- Extra vertical padding inside the menu (top and bottom)
menuVerticalPadding = 0

----------------------------------------------------------------------------------------------------
----------------------------------------- Font options ---------------------------------------------
----------------------------------------------------------------------------------------------------

-- The font to apply to menu items.
-- menuItemFont = "Courier-Bold"
menuItemFont = "Iosevka NF"

-- The font size to apply to menu items.
menuItemFontSize = 18

-- The text alignment to apply to menu items.
menuItemTextAlign = "left"

----------------------------------------------------------------------------------------------------
---------------------------------------- Color options ---------------------------------------------
----------------------------------------------------------------------------------------------------

menuItemColors = {
	-- The default colors to use.
	default = {
		background = "#000000",
		text = utils.colors.white,
	},
	-- The colors to use for the Exit menu item
	exit = {
		background = utils.colors.black,
		text = utils.colors.white,
	},
	-- The colors to use for the Back menu items
	back = {
		background = utils.colors.black,
		text = utils.colors.white,
	},
	-- The colors to use for menu menu items
	submenu = {
		background = "#000000",
		text = utils.colors.white,
	},
	-- The colors to use for navigation menu items
	navigation = {
		background = "#000000",
		text = utils.colors.white,
	},
	-- The colors to use for empty menu items
	empty = {
		background = "#000000",
		text = "#aaaaaa",
	},
	-- The colors to use for action menu items
	action = {
		background = "#ffffff",
		text = utils.colors.white,
	},
	menuBarActive = {
		background = "#ff0000",
		text = utils.colors.white,
	},
	menuBarIdle = {
		background = "#ffffff",
		text = utils.colors.white,
	},
	display = {
		background = "#000000",
		text = utils.colors.white,
	},
}

----------------------------------------------------------------------------------------------------
-------------------------------------- Menu bar options --------------------------------------------
----------------------------------------------------------------------------------------------------

-- Key bindings

-- The hotkey that will enable/disable MenuHammer
menuHammerToggleKey = { { "cmd", "shift", "ctrl" }, "Q" }

-- Menu Prefixes
menuItemPrefix = {
	action = " ",
	-- action = "↩",
	submenu = "+",
	-- submenu = "→",
	back = " ",
	exit = "󰛉",
	navigation = "↩",
	-- navigation = '⎋',
	empty = "",
	display = "",
}

-- Menu item separator
menuKeyItemSeparator = ":"

----------------------------------------------------------------------------------------------------
--------------------------------------- Default Menus ----------------------------------------------
----------------------------------------------------------------------------------------------------

local mainMenu = "mainMenu"
local helpMenu = "helpMenu"
local applicationMenu = "applicationMenu"

--============================================= Utilities =============================================
local utilitiesMenu = "utilitiesMenu"
local aerospaceMenu = "aerospaceMenu"
local clipboardMenu = "clipboardMenu"
local frontmostAppMenu = "frontmostAppMenu"
local simulatorMenu = "simulatorMenu"

-- Display menus
local displayMenu = "displayMenu"

-- Documents menu
local documentsMenu = "documentsMenu"

-- Finder menu
local finderMenu = "finderMenu"

-- Hammerspoon menu
local hammerspoonMenu = "hammerspoonMenu"

-- Media menu
local mediaMenu = "mediaMenu"
local spotifyMenu = "spotifyMenu"

-- Resolution menu
local resolutionMenu = "resolutionMenu"

-- System menus
local systemMenu = "systemMenu"

------------------------------------------------------------------------------------------------
-- Main Menu
------------------------------------------------------------------------------------------------

menuHammerMenuList = {
	[mainMenu] = {
		parentMenu = nil,
		menuHotkey = { key_helper.hyper, "space" },
		menuItems = {
			{
				cons.cat.submenu,
				"",
				"b",
				"Display",
				{
					{ cons.act.menu, displayMenu },
				},
			},
			{
				cons.cat.submenu,
				"",
				"O",
				"Applications",
				{
					{ cons.act.menu, applicationMenu },
				},
			},
			{
				cons.cat.submenu,
				"",
				"d",
				"Documents",
				{
					{ cons.act.menu, documentsMenu },
				},
			},
			{
				cons.cat.submenu,
				"",
				"u",
				"Utilities",
				{
					{ cons.act.menu, utilitiesMenu },
				},
			},
			{
				cons.cat.submenu,
				"",
				"M",
				"Media Controls",
				{
					{ cons.act.menu, mediaMenu },
				},
			},
			{
				cons.cat.submenu,
				"",
				"h",
				"Help",
				{
					{ cons.act.menu, helpMenu },
				},
			},
		},
	},

	------------------------------------------------------------------------------------------------
	-- Help Menu
	------------------------------------------------------------------------------------------------
	helpMenu = {
		parentMenu = mainMenu,
		menuHotkey = { key_helper.hyper, "h" },
		menuItems = {
			{
				cons.cat.action,
				"",
				"a",
				"Aerospace docs",
				{
					{ cons.act.openurl, "https://nikitabobko.github.io/AeroSpace/guide#installation" },
				},
			},
			{
				cons.cat.action,
				"",
				"h",
				"HS docs",
				{
					{
						cons.act.func,
						function()
							hs.doc.hsdocs.forceExternalBrowser(true)
							hs.doc.hsdocs.moduleEntitiesInSidebar(true)
							hs.doc.hsdocs.help()
						end,
					},
				},
			},
			{
				cons.cat.action,
				"",
				"m",
				"MH docs",
				{
					{ cons.act.openurl, "https://github.com/FryJay/MenuHammer" },
				},
			},
			{
				cons.cat.action,
				"",
				"l",
				"LazyVim docs",
				{
					{ cons.act.openurl, "https://www.lazyvim.org/" },
				},
			},
			{
				cons.cat.action,
				"",
				"w",
				"Wezterm docs",
				{
					{ cons.act.openurl, "https://wezterm.org/" },
				},
			},
			{
				cons.cat.action,
				"",
				"z",
				"Zellij docs",
				{
					{ cons.act.openurl, "https://zellij.dev/" },
				},
			},
		},
	},

	------------------------------------------------------------------------------------------------
	-- Application Menu
	------------------------------------------------------------------------------------------------
	applicationMenu = {
		parentMenu = mainMenu,
		menuHotkey = { key_helper.hyper, "o" },
		menuItems = {
			{
				cons.cat.action,
				"",
				"a",
				"Android studio",
				{
					{
						cons.act.script,
						"open -a 'Android Studio'",
					},
				},
			},
			{
				cons.cat.action,
				"shift",
				"a",
				"AVD",
				{
					{
						cons.act.script,
						utils.SCRIPTS .. "/mac-os/launch_avd.sh",
					},
				},
			},
			{
				cons.cat.action,
				"shift",
				"b",
				"Books",
				{
					{ cons.act.launcher, "Books" },
				},
			},
			{
				cons.cat.action,
				"",
				"c",
				"ChatGPT",
				{
					{ cons.act.launcher, "ChatGPT" },
				},
			},
			{
				cons.cat.action,
				"",
				"d",
				"Discord",
				{
					{ cons.act.launcher, "Discord" },
				},
			},
			{
				cons.cat.action,
				"",
				"F",
				"Finder",
				{
					{ cons.act.launcher, "Finder" },
				},
			},
			{
				cons.cat.action,
				"shift",
				"F",
				"Figma",
				{
					{ cons.act.launcher, "Figma" },
				},
			},
			{
				cons.cat.action,
				"",
				"g",
				"Ghostty",
				{
					{ cons.act.launcher, "Ghostty" },
				},
			},
			-- {
			-- 	cons.cat.action,
			-- 	"",
			-- 	"w",
			-- 	"WezTerm",
			-- 	{
			-- 		{ cons.act.launcher, "WezTerm" },
			-- 	},
			-- },
			{
				cons.cat.action,
				"",
				"x",
				"Xcode",
				{
					{ cons.act.launcher, "Xcode" },
				},
			},
			{
				cons.cat.action,
				"",
				"o",
				"Obsidian",
				{
					{ cons.act.launcher, "Obsidian" },
				},
			},
			{
				cons.cat.action,
				"",
				"h",
				"Hammerspoon",
				{
					{ cons.act.launcher, "Hammerspoon" },
				},
			},
			-- {
			-- 	cons.cat.action,
			-- 	"",
			-- 	"k",
			-- 	"Kitty",
			-- 	{
			-- 		{ cons.act.launcher, "Kitty" },
			-- 	},
			-- },
			{
				cons.cat.action,
				"shift",
				"k",
				"Karabiner",
				{
					{ cons.act.launcher, "Karabiner-Elements" },
				},
			},
			-- {
			-- 	cons.cat.action,
			-- 	"",
			-- 	"s",
			-- 	"Spotify",
			-- 	{
			-- 		{ cons.act.launcher, "Spotify" },
			-- 	},
			-- },
			{
				cons.cat.action,
				"",
				"p",
				"Postman",
				{
					{ cons.act.launcher, "Postman" },
				},
			},
			{
				cons.cat.action,
				"shift",
				"p",
				"Settings",
				{
					{ cons.act.launcher, "System Preferences" },
				},
			},
			{
				cons.cat.action,
				"shift",
				"s",
				"Simulator",
				{
					{ cons.act.launcher, "Simulator" },
				},
			},
			{
				cons.cat.action,
				"",
				"m",
				"Mail",
				{
					{ cons.act.launcher, "Mail" },
				},
			},
			{
				cons.cat.action,
				"shift",
				"m",
				"Apple Music",
				{
					{ cons.act.launcher, "Apple Music" },
				},
			},
			{
				cons.cat.action,
				"",
				"b",
				"Bitwarden",
				{
					{ cons.act.launcher, "Bitwarden" },
				},
			},
			{
				cons.cat.action,
				"shift",
				"v",
				"VSCode",
				{
					{
						cons.act.launcher,
						"Visual Studio Code",
					},
				},
			},
			{
				cons.cat.action,
				"",
				"v",
				"Stremio",
				{
					{ cons.act.launcher, "Stremio" },
				},
			},
			{
				cons.cat.action,
				"shift",
				"w",
				"WhatsApp",
				{
					{ cons.act.launcher, "WhatsApp" },
				},
			},
			{
				cons.cat.action,
				"",
				"z",
				"Zen Browser",
				{
					{ cons.act.launcher, "Zen" },
				},
			},
		},
	},

	------------------------------------------------------------------------------------------------
	-- Utilities Menu
	------------------------------------------------------------------------------------------------
	utilitiesMenu = {
		parentMenu = mainMenu,
		menuHotkey = { key_helper.hyper, "t" },
		menuItems = {
			{
				cons.cat.submenu,
				"",
				"a",
				"Aerospace",
				{
					{ cons.act.menu, aerospaceMenu },
				},
			},
			{
				cons.cat.submenu,
				"",
				"c",
				"Clipboard",
				{
					{ cons.act.menu, clipboardMenu },
				},
			},
			{
				cons.cat.submenu,
				"",
				"h",
				"Hammerspoon",
				{
					{ cons.act.menu, hammerspoonMenu },
				},
			},
			{
				cons.cat.submenu,
				"",
				"f",
				"frontmostApp",
				{
					{ cons.act.menu, frontmostAppMenu },
				},
			},
			{
				cons.cat.submenu,
				"",
				"s",
				"Simulator",
				{
					{ cons.act.menu, simulatorMenu },
				},
			},
			{
				cons.cat.submenu,
				"shift",
				"s",
				"System",
				{
					{ cons.act.menu, systemMenu },
				},
			},
		},
	},

	------------------------------------------------------------------------------------------------
	-- clipboard Menu
	------------------------------------------------------------------------------------------------
	clipboardMenu = {
		parentMenu = mainMenu,
		menuHotkey = { key_helper.hyper, "c" },
		menuItems = {
			{
				cons.cat.action,
				"",
				"t",
				"Toggle CB",
				{
					{
						cons.act.func,
						function()
							spoon.ClipboardTool:showClipboard()
						end,
					},
				},
			},
		},
	},

	------------------------------------------------------------------------------------------------
	-- frontmostApp Menu
	------------------------------------------------------------------------------------------------
	frontmostAppMenu = {
		parentMenu = utilitiesMenu,
		menuHotkey = nil,
		menuItems = {
			{
				cons.cat.action,
				"",
				"m",
				"Maximize",
				{
					{
						cons.act.func,
						function()
							utils:maximizeAppWindow()
						end,
					},
				},
			},
			{
				cons.cat.action,
				"",
				"q",
				"Kill App",
				{
					{ cons.act.system, cons.sys.forcequit },
				},
			},
			{
				cons.cat.action,
				"",
				"r",
				"Restart App",
				{
					{
						cons.act.func,
						function()
							utils:restartFrontmostApp()
						end,
					},
				},
			},
		},
	},

	------------------------------------------------------------------------------------------------
	-- simulator Menu
	------------------------------------------------------------------------------------------------
	simulatorMenu = {
		parentMenu = utilitiesMenu,
		menuHotkey = nil,
		menuItems = {
			{
				cons.cat.action,
				"",
				"r",
				"Restart app",
				{
					{
						cons.act.script,
						utils.SCRIPTS .. "/mac-os/restart_sim_app.sh",
					},
				},
			},
			{
				cons.cat.action,
				"",
				"u",
				"uninstall app",
				{
					{
						cons.act.script,
						utils.SCRIPTS .. "/mac-os/uninstall-sim-app.sh",
					},
				},
			},
		},
	},
	------------------------------------------------------------------------------------------------
	-- Documents Menu
	------------------------------------------------------------------------------------------------
	[documentsMenu] = {
		parentMenu = mainMenu,
		menuHotkey = nil,
		menuItems = {
			{
				cons.cat.action,
				"",
				"C",
				".config",
				{
					{ cons.act.launcher, "Finder" },
					{ cons.act.keycombo, { "cmd", "shift" }, "g" },
					{ cons.act.typetext, "~/.config\n" },
				},
			},
			{
				cons.cat.action,
				"",
				"D",
				"Google Drive (local)",
				{
					{ cons.act.launcher, "Finder" },
					{ cons.act.keycombo, { "cmd", "shift" }, "g" },
					{ cons.act.typetext, "~/Google Drive\n" },
				},
			},
			{
				cons.cat.action,
				"shift",
				"D",
				"Google Drive (online)",
				{
					{ cons.act.openurl, "https://drive.google.com/" },
				},
			},
			{
				cons.cat.action,
				"",
				"I",
				"iCloud Drive (local)",
				{
					{ cons.act.launcher, "Finder" },
					{ cons.act.keycombo, { "cmd", "shift" }, "i" },
				},
			},
			{
				cons.cat.action,
				"",
				"H",
				"Hammerspoon",
				{
					{ cons.act.launcher, "Finder" },
					{ cons.act.keycombo, { "cmd", "shift" }, "g" },
					{ cons.act.typetext, "~/.hammerspoon\n" },
				},
			},
			{
				cons.cat.action,
				"",
				"M",
				"MenuHammer Custom Config",
				{
					{ cons.act.openfile, "~/.hammerspoon/menuHammerCustomConfig.lua" },
				},
			},
			{
				cons.cat.action,
				"shift",
				"M",
				"MenuHammer Default Config",
				{
					{ cons.act.openfile, "~/.hammerspoon/Spoons/MenuHammer.spoon/MenuConfigDefaults.lua" },
				},
			},
			{
				cons.cat.action,
				"shift",
				"H",
				"Hammerspoon init.lua",
				{
					{ cons.act.openfile, "~/.hammerspoon/init.lua" },
				},
			},
		},
	},

	------------------------------------------------------------------------------------------------
	-- Finder Menu
	------------------------------------------------------------------------------------------------
	finderMenu = {
		parentMenu = mainMenu,
		menuHotkey = nil,
		menuItems = {
			{
				cons.cat.action,
				"",
				"A",
				"Applications Folder",
				{
					{ cons.act.launcher, "Finder" },
					{ cons.act.keycombo, { "cmd", "shift" }, "a" },
				},
			},
			{
				cons.cat.action,
				"shift",
				"A",
				"Airdrop",
				{
					{ cons.act.launcher, "Finder" },
					{ cons.act.keycombo, { "cmd", "shift" }, "r" },
				},
			},
			{
				cons.cat.action,
				"",
				"C",
				"Computer",
				{
					{ cons.act.launcher, "Finder" },
					{ cons.act.keycombo, { "cmd", "shift" }, "c" },
				},
			},
			{
				cons.cat.action,
				"",
				"D",
				"Desktop",
				{
					{ cons.act.launcher, "Finder" },
					{ cons.act.keycombo, { "cmd", "shift" }, "d" },
				},
			},
			{
				cons.cat.action,
				"shift",
				"D",
				"Downloads",
				{
					{ cons.act.launcher, "Finder" },
					{ cons.act.keycombo, { "cmd", "alt" }, "l" },
				},
			},
			{ cons.cat.action, "", "F", "Finder", {
				{ cons.act.launcher, "Finder" },
			} },
			{
				cons.cat.action,
				"",
				"G",
				"Go to Folder...",
				{
					{ cons.act.launcher, "Finder" },
					{ cons.act.keycombo, { "cmd", "shift" }, "g" },
				},
			},
			{
				cons.cat.action,
				"",
				"H",
				"Home",
				{
					{ cons.act.launcher, "Finder" },
					{ cons.act.keycombo, { "cmd", "shift" }, "h" },
				},
			},
			{
				cons.cat.action,
				"shift",
				"H",
				"Hammerspoon",
				{
					{ cons.act.launcher, "Finder" },
					{ cons.act.keycombo, { "cmd", "shift" }, "g" },
					{ cons.act.typetext, "~/.hammerspoon\n" },
				},
			},
			{
				cons.cat.action,
				"",
				"I",
				"iCloud Drive",
				{
					{ cons.act.launcher, "Finder" },
					{ cons.act.keycombo, { "cmd", "shift" }, "i" },
				},
			},
			{
				cons.cat.action,
				"",
				"K",
				"Connect to Server...",
				{
					{ cons.act.launcher, "Finder" },
					{ cons.act.keycombo, { "cmd" }, "K" },
				},
			},
			{
				cons.cat.action,
				"",
				"L",
				"Library",
				{
					{ cons.act.launcher, "Finder" },
					{ cons.act.keycombo, { "cmd", "shift" }, "l" },
				},
			},
			{
				cons.cat.action,
				"",
				"N",
				"Network",
				{
					{ cons.act.launcher, "Finder" },
					{ cons.act.keycombo, { "cmd", "shift" }, "k" },
				},
			},
			{
				cons.cat.action,
				"",
				"O",
				"Documents",
				{
					{ cons.act.launcher, "Finder" },
					{ cons.act.keycombo, { "cmd", "shift" }, "o" },
				},
			},
			{
				cons.cat.action,
				"",
				"R",
				"Recent",
				{
					{ cons.act.launcher, "Finder" },
					{ cons.act.keycombo, { "cmd", "shift" }, "f" },
				},
			},
			{
				cons.cat.action,
				"",
				"U",
				"Utilities",
				{
					{ cons.act.launcher, "Finder" },
					{ cons.act.keycombo, { "cmd", "shift" }, "u" },
				},
			},
		},
	},

	------------------------------------------------------------------------------------------------
	-- Hammerspoon Menu
	------------------------------------------------------------------------------------------------
	hammerspoonMenu = {
		parentMenu = mainMenu,
		menuHotkey = nil,
		menuItems = {
			{
				cons.cat.action,
				"",
				"C",
				"HS Console",
				{
					{
						cons.act.func,
						function()
							hs.toggleConsole()
						end,
					},
				},
			},
			{
				cons.cat.action,
				"",
				"d",
				"HS Manual",
				{
					{
						cons.act.func,
						function()
							hs.doc.hsdocs.forceExternalBrowser(true)
							hs.doc.hsdocs.moduleEntitiesInSidebar(true)
							hs.doc.hsdocs.help()
						end,
					},
				},
			},
			{
				cons.cat.action,
				"",
				"r",
				"Reload HS",
				{
					{
						cons.act.func,
						function()
							hs.reload()
						end,
					},
				},
			},
			{
				cons.cat.action,
				"",
				"q",
				"Quit HS",
				{
					{
						cons.act.func,
						function()
							os.exit()
						end,
					},
				},
			},
		},
	},

	------------------------------------------------------------------------------------------------
	-- Aerospace Menu
	------------------------------------------------------------------------------------------------
	aerospaceMenu = {
		parentMenu = mainMenu,
		menuHotkey = nil,
		menuItems = {
			{
				cons.cat.action,
				"",
				"d",
				"Aerospace Docs",
				{
					{
						-- modify to accept search query
						cons.act.openurl,
						"https://nikitabobko.github.io/AeroSpace/guide",
					},
				},
			},
			{
				cons.cat.action,
				"",
				"r",
				"Reload Aerospace",
				{
					{
						cons.act.func,
						function()
							local output, status = hs.execute("/opt/homebrew/bin/aerospace reload-config")
							if status then
								utils:nerd_alert(string.format(" Aerospace config reloaded"))
							else
								utils:nerd_alert(string.format(" Aerospace config reload failed: %s", output))
							end
						end,
					},
				},
			},
			{
				cons.cat.action,
				"shift",
				"r",
				"Restart Aerospace",
				{
					{
						cons.act.func,
						function()
							local output, status = hs.execute("killall AeroSpace && sleep 1 && open -a AeroSpace")
							if status then
								utils:nerd_alert(string.format(" Aerospace restarted"))
							else
								utils:nerd_alert(string.format(" error restarting aerospace: %s", output))
							end
						end,
					},
				},
			},
			{
				cons.cat.action,
				"",
				"q",
				"Kill Aerospace",
				{
					{
						cons.act.script,
						"killall AeroSpace",
					},
				},
			},
		},
	},

	------------------------------------------------------------------------------------------------
	-- Media Menu
	------------------------------------------------------------------------------------------------
	spotifyMenu = {
		parentMenu = mediaMenu,
		menuHotkey = nil,
		menuItems = {
			{
				cons.cat.action,
				"",
				"j",
				" Volume Down",
				{
					{
						cons.act.func,
						function()
							hs.spotify.setVolume(hs.spotify.getVolume() - 10)
							utils:nerd_alert(string.format("  Volume down: %d%%", hs.spotify.getVolume()))
						end,
					},
				},
			},
			{
				cons.cat.action,
				"",
				"K",
				"  Volume Up",
				{
					{
						cons.act.func,
						function()
							hs.spotify.setVolume(hs.spotify.getVolume() + 10)
							utils:nerd_alert(string.format("  Volume Up: %d%%", hs.spotify.getVolume()))
						end,
					},
				},
			},
			{
				cons.cat.action,
				"",
				"m",
				"󰝟 Mute/Unmute",
				{
					{
						cons.act.func,
						function()
							hs.spotify.setVolume(0)
							utils:nerd_alert("󰝟 Mute/Unmute")
						end,
					},
				},
			},
			{
				cons.cat.action,
				"",
				"l",
				"󰼧 Next Track",
				{
					{
						cons.act.func,
						function()
							hs.spotify.next()
							utils:nerd_alert("󰼧 Next Track")
						end,
					},
				},
			},
			{
				cons.cat.action,
				"",
				"h",
				"󰼨 Prev Track",
				{
					{
						cons.act.func,
						function()
							hs.spotify.previous()
							utils:nerd_alert("󰼨 Prev Track")
						end,
					},
				},
			},
			{
				cons.cat.action,
				"",
				"p",
				"󰐎 Play/Pause",
				{
					{
						cons.act.func,
						function()
							hs.spotify.playpause()
							utils:nerd_alert("󰐎 Play/Pause")
						end,
					},
				},
			},
		},
	},

	mediaMenu = {
		parentMenu = mainMenu,
		menuHotkey = { key_helper.hyper, "v" },
		menuItems = {
			{
				cons.cat.submenu,
				"",
				"s",
				" Spotify",
				{
					{
						cons.act.menu,
						spotifyMenu,
					},
				},
			},
			{
				cons.cat.action,
				"",
				"J",
				" Volume Down",
				{
					{
						cons.act.func,
						function()
							media_helper.set_volume(-25)
						end,
					},
				},
			},
			{
				cons.cat.action,
				"",
				"K",
				"  Volume Up",
				{
					{
						cons.act.func,
						function()
							media_helper.set_volume(25)
						end,
					},
				},
			},
			{
				cons.cat.action,
				"",
				"m",
				"󰝟 Mute/Unmute",
				{
					{
						cons.act.func,
						function()
							media_helper.volume_mute()
						end,
					},
				},
			},
			{
				cons.cat.action,
				"",
				"l",
				"󰼧 Next Track",
				{
					{
						cons.act.func,
						function()
							media_helper.next_track()
						end,
					},
				},
			},
			{
				cons.cat.action,
				"",
				"h",
				"󰼨 Prev Track",
				{
					{
						cons.act.func,
						function()
							media_helper.prev_track()
						end,
					},
				},
			},
			{
				cons.cat.action,
				"",
				"p",
				"󰐎 Play/Pause",
				{
					{
						cons.act.func,
						function()
							media_helper.play_pause()
						end,
					},
				},
			},
		},
	},

	------------------------------------------------------------------------------------------------
	-- Display Menu
	------------------------------------------------------------------------------------------------
	displayMenu = {
		parentMenu = mainMenu,
		menuHotkey = { key_helper.hyper, "b" },
		menuItems = {
			{
				cons.cat.action,
				"",
				"j",
				" Brightness",
				{
					{
						cons.act.func,
						function()
							display_helper.decrease_brightness()
						end,
					},
				},
			},
			{
				cons.cat.action,
				"",
				"k",
				" Brightness",
				{
					{
						cons.act.func,
						function()
							display_helper.increase_brightness()
						end,
					},
				},
			},
		},
	},

	------------------------------------------------------------------------------------------------
	-- Open Files Menu
	------------------------------------------------------------------------------------------------
	openFilesMenu = {
		parentMenu = mainMenu,
		menuHotkey = nil,
		menuItems = {},
	},

	------------------------------------------------------------------------------------------------
	-- Resolution Menu
	------------------------------------------------------------------------------------------------
	resolutionMenu = {
		parentMenu = mainMenu,
		menuHotkey = nil,
		menuItems = resolutionMenuItems,
	},

	------------------------------------------------------------------------------------------------
	-- System Menu
	------------------------------------------------------------------------------------------------
	systemMenu = {
		parentMenu = utilitiesMenu,
		menuHotkey = nil,
		menuItems = {
			{
				cons.cat.action,
				"",
				"l",
				"Lock Screen",
				{
					{ cons.act.system, cons.sys.lockscreen },
				},
			},
			{
				cons.cat.action,
				"",
				"r",
				"Restart",
				{
					{ cons.act.system, cons.sys.restart, true },
				},
			},
			{
				cons.cat.action,
				"",
				"S",
				"Shutdown",
				{
					{ cons.act.system, cons.sys.shutdown, true },
				},
			},
			{
				cons.cat.action,
				"shift",
				"l",
				"Logout",
				{
					{ cons.act.system, cons.sys.logoutnow },
				},
			},
			{
				cons.cat.action,
				"",
				"d",
				"Hide/Show Dock",
				{
					{ cons.act.keycombo, { "cmd", "alt" }, "d" },
				},
			},
			{
				cons.cat.action,
				"shift",
				"w",
				"Disable wi-fi",
				{
					{
						cons.act.func,
						function()
							hs.wifi.setPower(false)
						end,
					},
				},
			},
			{
				cons.cat.action,
				"",
				"w",
				"Enable wi-fi",
				{
					{
						cons.act.func,
						function()
							hs.wifi.setPower(true)
						end,
					},
				},
			},
		},
	},
}
