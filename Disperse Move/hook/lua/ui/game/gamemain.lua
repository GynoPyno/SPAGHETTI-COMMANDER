local KeyMapper = import('/lua/keymap/keymapper.lua')
KeyMapper.SetUserKeyAction('Disperse Move', {action = "UI_Lua import('/mods/Disperse Move/modules/dispersemove.lua').DisperseMove()", category = 'orders', order = 35})
KeyMapper.SetUserKeyAction('Shift Disperse Move', {action = "UI_Lua import('/mods/Disperse Move/modules/dispersemove.lua').DisperseMove()", category = 'orders', order = 36})
