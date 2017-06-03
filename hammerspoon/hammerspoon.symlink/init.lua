local log = hs.logger.new('init.lua', 'debug')

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "H", function()
  hs.reload()
end)

-- Use Control+` to reload Hammerspoon config
hs.hotkey.bind({'ctrl'}, '`', nil, function()
  hs.reload()
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
