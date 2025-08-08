----------------------------------------------------------------------------------------------------
--------------------------------------- General Config ---------------------------------------------
----------------------------------------------------------------------------------------------------
local key_helper = require("helpers.key_helper")
local display_helper = require("helpers.display_helper")
local utils = require("helpers.utils")

-- If enabled, the menus will appear over full screen applications.
-- However, the Hammerspoon dock icon will also be disabled (required for fullscreen).
menuShowInFullscreen = false

-- If enabled, a menu bar item will appear that shows what menu is currently being displayed or
-- "idle" if no menu is open.
showMenuBarItem = false

-- The number of seconds that a hotkey alert will stay on screen.
-- 0 = alerts are disabled.
hs.hotkey.alertDuration = 0

-- Show no titles for Hammerspoon windows.
hs.hints.showTitleThresh = 0

-- Disable animations
hs.window.animationDuration = 0

-- Editor path
menuTextEditor = "/opt/homebrew/bin/nvim"

-- Location of the askpass executable.  Required for running script with admin privs.
askpassLocation = "/usr/local/bin/ssh-askpass"

----------------------------------------------------------------------------------------------------
----------------------------------------- Menu options ---------------------------------------------
----------------------------------------------------------------------------------------------------

-- The number of columns to display in the menus.  Setting this too high or too low will
-- probably have odd results.
menuNumberOfColumns = 5

-- The minimum number of rows to show in menus
menuMinNumberOfRows = 4

-- The height of menu rows in pixels
menuRowHeight = 25

-- The padding to apply to each side of the menu
menuOuterPadding = 50

----------------------------------------------------------------------------------------------------
----------------------------------------- Font options ---------------------------------------------
----------------------------------------------------------------------------------------------------

-- The font to apply to menu items.
menuItemFont = "Courier-Bold"
-- menuItemFont = "ShureTechMono Nerd Font"

-- The font size to apply to menu items.
menuItemFontSize = 22

-- The text alignment to apply to menu items.
menuItemTextAlign = "left"

----------------------------------------------------------------------------------------------------
---------------------------------------- Color options ---------------------------------------------
----------------------------------------------------------------------------------------------------

menuItemColors = {
	-- The default colors to use.
	default = {
		background = "#000000",
		text = utils.colors.glossy_pink,
	},
	-- The colors to use for the Exit menu item
	exit = {
		background = utils.colors.black,
		text = utils.colors.red,
	},
	-- The colors to use for the Back menu items
	back = {
		background = utils.colors.black,
		text = utils.colors.yellow,
	},
	-- The colors to use for menu menu items
	submenu = {
		background = "#000000",
		text = utils.colors.glossy_pink,
	},
	-- The colors to use for navigation menu items
	navigation = {
		background = "#000000",
		text = utils.colors.cyan,
	},
	-- The colors to use for empty menu items
	empty = {
		background = "#000000",
		text = "#aaaaaa",
	},
	-- The colors to use for action menu items
	action = {
		background = "#000000",
		text = utils.colors.glossy_pink,
	},
	menuBarActive = {
		background = "#ff0000",
		text = "#000000",
	},
	menuBarIdle = {
		background = "#00ff00",
		text = "#000000",
	},
	display = {
		background = "#000000",
		text = "#48A9A6",
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
	action = "↩",
	submenu = "→",
	back = "←",
	exit = "x",
	navigation = "↩",
	-- navigation = '⎋',
	empty = "",
	display = "",
}

-- Menu item separator
menuKeyItemSeparator = ": "

----------------------------------------------------------------------------------------------------
--------------------------------------- Default Menus ----------------------------------------------
----------------------------------------------------------------------------------------------------

-- Menus
local mainMenu = "mainMenu"

-- Help menu
local helpMenu = "helpMenu"

-- Applications Menus
local applicationMenu = "applicationMenu"
local utilitiesMenu = "utilitiesMenu"

-- Browser menus
local browserMenu = "browserMenu"

-- Display menus
local displayMenu = "displayMenu"

-- Display menus
local powerMenu = "powerMenu"

-- Documents menu
local documentsMenu = "documentsMenu"

-- Finder menu
local finderMenu = "finderMenu"

-- Games menu
local gamesMenu = "gamesMenu"

-- Hammerspoon menu
local hammerspoonMenu = "hammerspoonMenu"

-- Help menu
local helpMenu = "helpMenu"

-- Layout menu
local layoutMenu = "layoutMenu"

-- Media menu
local mediaMenu = "mediaMenu"

-- Resolution menu
local resolutionMenu = "resolutionMenu"

-- Scripts menu
local scriptsMenu = "scriptsMenu"

-- System menus
local systemMenu = "systemMenu"

-- Text menu
local textMenu = "textMenu"

-- Toggles menu
local toggleMenu = "toggleMenu"

-- Window menu
local resizeMenu = "resizeMenu"

menuHammerMenuList = {

	------------------------------------------------------------------------------------------------
	-- Main Menu
	------------------------------------------------------------------------------------------------
	[mainMenu] = {
		parentMenu = nil,
		menuHotkey = { key_helper.hyper, "space" },
		menuItems = {
			{ cons.cat.submenu, "shift", "/", "Help", {
				{ cons.act.menu, helpMenu },
			} },
			{
				cons.cat.submenu,
				"",
				"O",
				"Applications",
				{
					{ cons.act.menu, applicationMenu },
				},
			},
			-- { cons.cat.submenu, "", "B", "Browser", {
			-- 	{ cons.act.menu, browserMenu },
			-- } },
			{ cons.cat.submenu, "", "b", "Display", {
				{ cons.act.menu, displayMenu },
			} },
			{ cons.cat.submenu, "", "D", "Documents", {
				{ cons.act.menu, documentsMenu },
			} },
			{ cons.cat.submenu, "", "F", "Finder", {
				{ cons.act.menu, finderMenu },
			} },
			{ cons.cat.submenu, "", "G", "Games", {
				{ cons.act.menu, gamesMenu },
			} },
			{
				cons.cat.submenu,
				"",
				"H",
				"Hammerspoon",
				{
					{ cons.act.menu, hammerspoonMenu },
				},
			},
			-- { cons.cat.submenu, "", "L", "Layouts", {
			-- 	{ cons.act.menu, layoutMenu },
			-- } },
			{ cons.cat.submenu, "", "M", "Media Controls", {
				{ cons.act.menu, mediaMenu },
			} },
			{
				cons.cat.submenu,
				"",
				"R",
				"Resolution",
				{
					{ cons.act.menu, resolutionMenu },
				},
			},
			{
				cons.cat.submenu,
				"shift",
				"s",
				"System Prefs",
				{
					{ cons.act.menu, systemMenu },
				},
			},
			{ cons.cat.submenu, "", "T", "Toggles", {
				{ cons.act.menu, toggleMenu },
			} },
			{ cons.cat.submenu, "", "X", "Text", {
				{ cons.act.menu, textMenu },
			} },
			{ cons.cat.submenu, "", "s", "Scripts", {
				{ cons.act.menu, scriptsMenu },
			} },
			{
				cons.cat.action,
				"",
				"space",
				"Spotlight",
				{
					{ cons.act.keycombo, { "cmd" }, "space" },
				},
			},
		},
	},

	------------------------------------------------------------------------------------------------
	-- Help Menu
	------------------------------------------------------------------------------------------------
	helpMenu = {
		parentMenu = mainMenu,
		menuHotkey = nil,
		menuItems = {
			{
				cons.cat.action,
				"",
				"H",
				"Hammerspoon Manual",
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
				"M",
				"MenuHammer Documentation",
				{
					{ cons.act.openurl, "https://github.com/FryJay/MenuHammer" },
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
			{ cons.cat.action, "", "F", "Finder", {
				{ cons.act.launcher, "Finder" },
			} },
			{ cons.cat.action, "", "z", "Zen Browser", {
				{ cons.act.launcher, "Zen" },
			} },
			{ cons.cat.action, "", "w", "WezTerm", {
				{ cons.act.launcher, "WezTerm" },
			} },
			{ cons.cat.action, "", "o", "Obsidian", {
				{ cons.act.launcher, "Obsidian" },
			} },
			{ cons.cat.action, "", "h", "Hammerspoon", {
				{ cons.act.launcher, "Hammerspoon" },
			} },
			{
				cons.cat.action,
				"",
				"l",
				"Karabiner",
				{
					{ cons.act.launcher, "Karabiner-Elements" },
				},
			},
			{
				cons.cat.action,
				"",
				"s",
				"Spotify",
				{
					{ cons.act.launcher, "Spotify" },
				},
			},
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
				"s",
				"Simulator",
				{
					{ cons.act.launcher, "Simulator" },
				},
			},
			{ cons.cat.action, "", "m", "Mail", {
				{ cons.act.launcher, "Mail" },
			} },
			{ cons.cat.action, "", "b", "Bitwarden", {
				{ cons.act.launcher, "Bitwarden" },
			} },
			{ cons.cat.action, "", "v", "Stremio", {
				{ cons.act.launcher, "Stremio" },
			} },
			-- { cons.cat.submenu, "", "U", "Utilities", {
			-- 	{ cons.act.menu, utilitiesMenu },
			-- } },
			{ cons.cat.action, "shift", "w", "WhatsApp", {
				{ cons.act.launcher, "WhatsApp" },
			} },
		},
	},

	------------------------------------------------------------------------------------------------
	-- Utilities Menu
	------------------------------------------------------------------------------------------------
	utilitiesMenu = {
		parentMenu = applicationMenu,
		menuHotkey = { key_helper.hyper, "t" },
		menuItems = {
			{
				cons.cat.action,
				"",
				"K",
				"Keychain Access",
				{
					{ cons.act.launcher, "Keychain Access" },
				},
			},
			{
				cons.cat.action,
				"",
				"S",
				"System Information",
				{
					{ cons.act.launcher, "System Information" },
				},
			},
		},
	},

	------------------------------------------------------------------------------------------------
	-- Browser Menu
	------------------------------------------------------------------------------------------------
	browserMenu = {
		parentMenu = mainMenu,
		meunHotkey = nil,
		menuItems = {
			{
				cons.cat.action,
				"",
				"C",
				"Chrome",
				{
					{ cons.act.launcher, "Google Chrome" },
				},
			},
			{ cons.cat.action, "", "F", "Firefox", {
				{ cons.act.launcher, "Firefox" },
			} },
			{
				cons.cat.action,
				"",
				"M",
				"Movie Lookup",
				{
					{
						cons.act.userinput,
						"movieLookup",
						"Movie Lookup",
						"Enter search criteria",
					},
					{
						cons.act.openurl,
						"http://www.google.com/search?q=@@movieLookup@@%20film%20site:wikipedia.org&meta=&btnI",
					},
					{
						cons.act.openurl,
						"http://www.google.com/search?q=@@movieLookup@@%20site:imdb.com&meta=&btnI",
					},
					{
						cons.act.openurl,
						"http://www.google.com/search?q=@@movieLookup@@%20site:rottentomatoes.com&meta=&btnI",
					},
				},
			},
			{ cons.cat.action, "", "S", "Safari", {
				{ cons.act.launcher, "Safari" },
			} },
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
	-- Games Menu
	------------------------------------------------------------------------------------------------
	[gamesMenu] = {
		parentMenu = applicationMenu,
		menuHotkey = nil,
		menuItems = {
			{
				cons.cat.action,
				"",
				"G",
				"GOG Galaxy",
				{
					{ cons.act.launcher, "GOG Galaxy" },
				},
			},
			{ cons.cat.action, "", "S", "Steam", {
				{ cons.act.launcher, "Steam" },
			} },
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
				"Hammerspoon Console",
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
				"H",
				"Hammerspoon Manual",
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
				"R",
				"Reload Hammerspoon",
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
				"Q",
				"Quit Hammerspoon",
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
	-- Layout Menu <<don't need this for now>>
	------------------------------------------------------------------------------------------------
	-- [layoutMenu] = {
	-- 	parentMenu = mainMenu,
	-- 	menuHotkey = nil,
	-- 	menuItems = {
	-- 		{
	-- 			cons.cat.action,
	-- 			"",
	-- 			"E",
	-- 			"Split Safari/iTunes",
	-- 			{
	-- 				{
	-- 					cons.act.func,
	-- 					function()
	-- 						-- See Hammerspoon layout documentation for more info on this
	-- 						local mainScreen = hs.screen({ x = 0, y = 0 })
	-- 						hs.layout.apply({
	-- 							{ "Safari", nil, mainScreen, hs.layout.left50, nil, nil },
	-- 							{ "iTunes", nil, mainScreen, hs.layout.right50, nil, nil },
	-- 						})
	-- 					end,
	-- 				},
	-- 			},
	-- 		},
	-- 	},
	-- },

	------------------------------------------------------------------------------------------------
	-- Media Menu
	------------------------------------------------------------------------------------------------
	mediaMenu = {
		parentMenu = mainMenu,
		menuHotkey = nil,
		menuItems = {
			{ cons.cat.action, "", "A", "iTunes", {
				{ cons.act.launcher, "iTunes" },
			} },
			{
				cons.cat.action,
				"",
				"H",
				"Previous Track",
				{
					{ cons.act.mediakey, "previous" },
				},
			},
			{
				cons.cat.action,
				"",
				"J",
				"Volume Down",
				{
					{ cons.act.mediakey, "volume", -10 },
				},
			},
			{
				cons.cat.action,
				"",
				"K",
				"Volume Up",
				{
					{ cons.act.mediakey, "volume", 10 },
				},
			},
			{ cons.cat.action, "", "L", "Next Track", {
				{ cons.act.mediakey, "next" },
			} },
			{ cons.cat.action, "", "X", "Mute/Unmute", {
				{ cons.act.mediakey, "mute" },
			} },
			{
				cons.cat.action,
				"",
				"S",
				"Play/Pause",
				{
					{ cons.act.mediakey, "playpause" },
				},
			},
			{
				cons.cat.action,
				"",
				"I",
				"Brightness Down",
				{
					{ cons.act.mediakey, "brightness", -10 },
				},
			},
			{
				cons.cat.action,
				"",
				"O",
				"Brightness Up",
				{
					{ cons.act.mediakey, "brightness", 10 },
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
				"Brightness Down",
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
				"Brightness Up",
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
	-- Scripts Menu
	------------------------------------------------------------------------------------------------
	[scriptsMenu] = {
		parentMenu = mainMenu,
		menuHotkey = { key_helper.hyper, "s" },
		menuItems = {
			{
				cons.cat.action,
				"shift",
				"s",
				"Restart sim app",
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
				"a",
				"Aerospace Reload",
				{
					{
						cons.act.script,
						utils.SCRIPTS .. "/aerospace/reload.sh",
					},
				},
			},
			{
				cons.cat.action,
				"",
				"s",
				"Sketchybar Reload",
				{
					{
						cons.act.script,
						utils.SCRIPTS .. "/sketchybar/reload.sh",
					},
				},
			},
		},
	},

	------------------------------------------------------------------------------------------------
	-- System Menu
	------------------------------------------------------------------------------------------------
	systemMenu = {
		parentMenu = mainMenu,
		menuHotkey = { key_helper.hyper_shift, "s" },
		menuItems = {
			{
				cons.cat.action,
				"",
				"q",
				"Kill Front App",
				{
					{ cons.act.system, cons.sys.forcequit },
				},
			},
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
				"shift",
				"r",
				"Restart",
				{
					{ cons.act.system, cons.sys.restart, true },
				},
			},
			{
				cons.cat.action,
				"shift",
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
			--TODO: write script to run <pik> in floating zellij pane
			-- {
			-- 	cons.cat.action,
			-- 	"",
			-- 	"V",
			-- 	"Activity Monitor",
			-- 	{
			-- 		{ cons.act.launcher, "Activity Monitor" },
			-- 	},
			-- },
			{
				cons.cat.action,
				"",
				"x",
				"System Prefs",
				{
					{ cons.act.launcher, "System Preferences" },
				},
			},
		},
	},

	------------------------------------------------------------------------------------------------
	-- Text Menu
	------------------------------------------------------------------------------------------------
	[textMenu] = {
		parentMenu = mainMenu,
		menuHotkey = nil,
		menuItems = {
			{
				cons.cat.action,
				"",
				"C",
				"Remove clipboard format",
				{
					{
						cons.act.func,
						function()
							local pasteboardContents = hs.pasteboard.getContents()
							hs.pasteboard.setContents(pasteboardContents)
						end,
					},
				},
			},
			{
				cons.cat.action,
				"",
				"E",
				"Empty the clipboard",
				{
					{
						cons.act.func,
						function()
							hs.pasteboard.setContents("")
						end,
					},
				},
			},
			{
				cons.cat.action,
				"",
				"T",
				"Type clipboard contents",
				{
					{ cons.act.typetext, "@@mhClipboardText@@" },
				},
			},
		},
	},

	------------------------------------------------------------------------------------------------
	-- Toggle menu
	------------------------------------------------------------------------------------------------
	[toggleMenu] = {
		parentMenu = mainMenu,
		menuHotkey = nil,
		menuItems = {
			{
				cons.cat.action,
				"",
				"C",
				"Caffeine",
				{
					{
						cons.act.func,
						function()
							toggleCaffeine()
						end,
					},
				},
			},
			{
				cons.cat.action,
				"",
				"D",
				"Hide/Show Dock",
				{
					{ cons.act.keycombo, { "cmd", "alt" }, "d" },
				},
			},
			{
				cons.cat.action,
				"",
				"S",
				"Start Screensaver",
				{
					{ cons.act.system, cons.sys.screensaver },
				},
			},
			{
				cons.cat.action,
				"shift",
				"W",
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
				"W",
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
