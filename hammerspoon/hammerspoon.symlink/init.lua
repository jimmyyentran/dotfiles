local log = hs.logger.new('init.lua', 'debug')

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "H", function()
  hs.reload()
end)

hs.hotkey.bind({"cmd", "shift"}, "L", function()
  hs.caffeinate.lockScreen()
end)

modal_list = {}
-- require('control-escape')
-- require('delete-words')
-- require('hyper')
-- require('markdown')
-- require('microphone')
-- require('panes')
-- require('super')
-- require('windows')
require('vim')
require('basicmode')
require('modalmgr')

-- Vimouse
local vimouse = require('vimouse')
vimouse('cmd', 'm')

hs.notify.new({title='Hammerspoon', informativeText='Ready to rock 🤘'}):send()
