#!/usr/bin/env lua

--[[
--we need to do some setup first, for readability later
--]]

--metatable stuff for syntactic sugar
local hc_mt = {}
local hc = setmetatable({}, hc_mt)

function hc_mt:__index(name)
  return function(...)
    local command = {"herbstclient", name, ...}
    for i=1,#command do
      command[i] = tostring(command[i])
    end
    os.execute(table.concat(command, " "))
  end
end

--sign positive numbers
local function signed(n)
  return n > 0 and "+"..n or tostring(n)
end

--[[
--Now set up our tables of settings
--]]

local mod = 'Mod1-'
local ctrl = 'Ctrl-'
local shift = 'Shift-'
local enter = 'Return'
local resize_step = 0.05

local keybindings =
{
  [mod..shift..'q']   =   'close',
  [mod..shift..'r']   =   'reload',
  [mod..shift..'e']   =   'quit',
  [mod..enter]        =   'spawn lilyterm',
  ['Mod5-o']          =   'spawn rotate_screen.sh',
  [mod..'d']          =   'spawn dmenu_run',

  [mod..'h']          =   'focus left',
  [mod..'l']          =   'focus right',
  [mod..'j']          =   'focus down',
  [mod..'k']          =   'focus up',
  [mod..shift..'h']   =   'shift left',
  [mod..shift..'l']   =   'shift right',
  [mod..shift..'j']   =   'shift down',
  [mod..shift..'k']   =   'shift up',
  [mod..ctrl..'h']    =   'resize left '..signed(resize_step),
  [mod..ctrl..'l']    =   'resize right '..signed(resize_step),
  [mod..ctrl..'j']    =   'resize down '..signed(resize_step),
  [mod..ctrl..'k']    =   'resize up '..signed(resize_step),

  [mod..'space']      =   'cycle_layout',
  [mod..ctrl..'space']=   'split explode',
  [mod..'u']          =   'split bottom 0.5',
  [mod..'o']          =   'split right 0.5',
  [mod..'r']          =   'remove',

  [mod..'s']          =   'floating toggle',
  [mod..'f']          =   'fullscreen toggle',
  [mod..'p']          =   'pseudotile toggle',
  [mod..'Tab']        =   'cycle_all '..signed(1),
  [mod..shift..'Tab'] =   'cycle_all '..signed(-1),
  [mod..'c']          =   'cycle',
  [mod..'i']          =   'jumpto urgent',
}

local mousebindings =
{
  [mod..'Button1']    = "move",
  [mod..'Button2']    = "resize",
  [mod..'Button3']    = "zoom",
}

local settings =
{
  ['frame_bg_transparent']      = '1',
  ['frame_transparent_width']   = '1',
  ['frame_border_normal_color'] = "'#1e1e27'",
  ['frame_bg_normal_color']     = "'#cfbfad'",
  ['always_show_frame']         = '1',
  ['frame_border_active_color'] = "'#1e1e27'",
  ['frame_bg_active_color']     = "'#808bed'",
  ['frame_border_width']        = '1',
  ['frame_gap']                 = '4',
  ['window_gap']                = '0',
  ['frame_padding']             = '0',
  ['smart_window_surroundings'] = '0',
  ['smart_frame_surroundings']  = '0',
  ['mouse_recenter_gap']        = '0',
  ['focus_follows_mouse']       = '1',
  ['tree_style']                = '╾│ ├└╼─┐',
  ['auto_detect_monitors']      = '1',
}

local attributes =
{
  ['theme.background_color']      = "'#1e1e27'",
  ['theme.normal.color']          = "'#cfbfad'",
  ['theme.inner_color']           = "'#1e1e27'",
  ['theme.outer_color']           = "'#1e1e27'",
  ['theme.floating.outer_color']  = "'#1e1e27'",
  ['theme.active.color']          = "'#808bed'",
  ['theme.urgent.color']          = "'#f0ad6d'",
  ['theme.border_width']          = '3',
  ['theme.inner_width']           = '1',
  ['theme.outer_width']           = '1',
  ['theme.floating.border_width'] = '4',
  ['theme.floating.inner_width']  = '1',
  ['theme.floating.outer_width']  = '1',
}
--[[
--Now we do the actual script
--
--TODO we need to chain this
--]]

--let the daemons know that we are reloading the autostart
hc.emit_hook("reload")
--the lock should speed things up
hc.lock()

--we need to add in the tags
hc.rename('default','1')
for i=1,9 do
  hc.add(i)
  keybindings[mod..i]        = 'use '..i
  keybindings[mod..shift..i] = 'move '..i
end

--remove the 'default' tag
--hc.use_index(1)
--hc.merge_tag('default','1')

--reset the bindings
hc.keyunbind('--all')
hc.mouseunbind('--all')

--set the bindings
for key,command in pairs(keybindings) do
  hc.keybind(key,command)
end
for key,command in pairs(mousebindings) do
  hc.mousebind(key,command)
end

--settings and attributes
hc.attr('theme.tiling.reset','1')
hc.attr('theme.floating.reset','1')
  --['theme.floating.reset']        = '1',
for setting, value in pairs(settings) do
  hc.set(setting, value)
end
for path, value in pairs(attributes) do
  hc.attr(path, value)
end

--rules
hc.unrule('--all')
hc.rule('focus=on') --focus new clients
hc.rule("windowtype~'_NET_WM_WINDOW_TYPE_(DIALOG|UTILITY|SPLASH)' pseudotile=on")
hc.rule("windowtype='_NET_WM_WINDOW_TYPE_DIALOG' focus=on")
hc.rule("windowtype~'_NET_WM_WINDOW_TYPE_(NOTIFICATION|DOCK|DESKTOP)' manage=off")

--all done
hc.unlock()

