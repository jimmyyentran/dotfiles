local log = hs.logger.new('init.lua', 'debug')

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "H", function()
  hs.reload()
end)

-- Use Control+` to reload Hammerspoon config
hs.hotkey.bind({'ctrl'}, '`', nil, function()
  hs.reload()
end)

keyUpDown = function(modifiers, key)
  -- Un-comment & reload config to log each keystroke that we're triggering
  -- log.d('Sending keystroke:', hs.inspect(modifiers), key)
  hs.eventtap.keyStroke(modifiers, key, 0)
end

-- Subscribe to the necessary events on the given window filter such that the
-- given hotkey is enabled for windows that match the window filter and disabled
-- for windows that don't match the window filter.
--
-- windowFilter - An hs.window.filter object describing the windows for which
--                the hotkey should be enabled.
-- hotkey       - The hs.hotkey object to enable/disable.
--
-- Returns nothing.
enableHotkeyForWindowsMatchingFilter = function(windowFilter, hotkey)
  windowFilter:subscribe(hs.window.filter.windowFocused, function()
    hotkey:enable()
  end)

  windowFilter:subscribe(hs.window.filter.windowUnfocused, function()
    hotkey:disable()
  end)
end

local mainScreen = hs.screen.mainScreen()
local mainRes = mainScreen:fullFrame()
local localMainRes = mainScreen:absoluteToLocal(mainRes)
modal_tray = hs.canvas.new(mainScreen:localToAbsolute({x=localMainRes.w-40,y=localMainRes.h-40,w=20,h=20}))
function modal_stat(color,alpha)
    -- if not modal_tray then
        -- local mainScreen = hs.screen.mainScreen()
        -- local mainRes = mainScreen:fullFrame()
        -- local localMainRes = mainScreen:absoluteToLocal(mainRes)
        -- modal_tray = hs.canvas.new(mainScreen:localToAbsolute({x=localMainRes.w-40,y=localMainRes.h-40,w=20,h=20}))
        -- modal_tray[1] = {action="fill",type="circle",fillColor=white}
        -- modal_tray[1].fillColor.alpha=0.7
        -- modal_tray[2] = {action="fill",type="circle",fillColor=white,radius="40%"}
        -- modal_tray:level(hs.canvas.windowLevels.status)
        -- modal_tray:clickActivating(false)
        -- modal_tray:behavior(hs.canvas.windowBehaviors.canJoinAllSpaces + hs.canvas.windowBehaviors.stationary)
        -- modal_tray._default.trackMouseDown = true
    -- end
    -- modal_tray:show()
    -- modal_tray[2].fillColor = color
    -- modal_tray[2].fillColor.alpha = alpha
end
activeModals = {}
function exit_others(excepts)
    function isInExcepts(value,tbl)
        for i=1,#tbl do
           if tbl[i] == value then
               return true
           end
        end
        return false
    end
    if excepts == nil then excepts = {} end
    for i = 1, #activeModals do
        if not isInExcepts(activeModals[i].id, excepts) then
            activeModals[i].modal:exit()
        end
    end
end

function resize_win(direction)
    local win = hs.window.focusedWindow()
    if win then
        local f = win:frame()
        local screen = win:screen()
        local localf = screen:absoluteToLocal(f)
        local max = screen:fullFrame()
        local stepw = max.w/30
        local steph = max.h/30
        if direction == "right" then
            localf.w = localf.w+stepw
            local absolutef = screen:localToAbsolute(localf)
            win:setFrame(absolutef)
        end
        if direction == "left" then
            localf.w = localf.w-stepw
            local absolutef = screen:localToAbsolute(localf)
            win:setFrame(absolutef)
        end
        if direction == "up" then
            localf.h = localf.h-steph
            local absolutef = screen:localToAbsolute(localf)
            win:setFrame(absolutef)
        end
        if direction == "down" then
            localf.h = localf.h+steph
            local absolutef = screen:localToAbsolute(localf)
            win:setFrame(absolutef)
        end
        if direction == "halfright" then
            localf.x = max.w/2 localf.y = 0 localf.w = max.w/2 localf.h = max.h
            local absolutef = screen:localToAbsolute(localf)
            win:setFrame(absolutef)
        end
        if direction == "halfleft" then
            localf.x = 0 localf.y = 0 localf.w = max.w/2 localf.h = max.h
            local absolutef = screen:localToAbsolute(localf)
            win:setFrame(absolutef)
        end
        if direction == "halfup" then
            localf.x = 0 localf.y = 0 localf.w = max.w localf.h = max.h/2
            local absolutef = screen:localToAbsolute(localf)
            win:setFrame(absolutef)
        end
        if direction == "halfdown" then
            localf.x = 0 localf.y = max.h/2 localf.w = max.w localf.h = max.h/2
            local absolutef = screen:localToAbsolute(localf)
            win:setFrame(absolutef)
        end
        if direction == "cornerNE" then
            localf.x = max.w/2 localf.y = 0 localf.w = max.w/2 localf.h = max.h/2
            local absolutef = screen:localToAbsolute(localf)
            win:setFrame(absolutef)
        end
        if direction == "cornerSE" then
            localf.x = max.w/2 localf.y = max.h/2 localf.w = max.w/2 localf.h = max.h/2
            local absolutef = screen:localToAbsolute(localf)
            win:setFrame(absolutef)
        end
        if direction == "cornerNW" then
            localf.x = 0 localf.y = 0 localf.w = max.w/2 localf.h = max.h/2
            local absolutef = screen:localToAbsolute(localf)
            win:setFrame(absolutef)
        end
        if direction == "cornerSW" then
            localf.x = 0 localf.y = max.h/2 localf.w = max.w/2 localf.h = max.h/2
            local absolutef = screen:localToAbsolute(localf)
            win:setFrame(absolutef)
        end
        if direction == "center" then
            localf.x = (max.w-localf.w)/2 localf.y = (max.h-localf.h)/2
            local absolutef = screen:localToAbsolute(localf)
            win:setFrame(absolutef)
        end
        if direction == "fcenter" then
            localf.x = stepw*5 localf.y = steph*5 localf.w = stepw*20 localf.h = steph*20
            local absolutef = screen:localToAbsolute(localf)
            win:setFrame(absolutef)
        end
        if direction == "fullscreen" then
            localf.x = 0 localf.y = 0 localf.w = max.w localf.h = max.h
            local absolutef = screen:localToAbsolute(localf)
            win:setFrame(absolutef)
        end
        if direction == "shrink" then
            localf.x = localf.x+stepw localf.y = localf.y+steph localf.w = localf.w-(stepw*2) localf.h = localf.h-(steph*2)
            local absolutef = screen:localToAbsolute(localf)
            win:setFrame(absolutef)
        end
        if direction == "expand" then
            localf.x = localf.x-stepw localf.y = localf.y-steph localf.w = localf.w+(stepw*2) localf.h = localf.h+(steph*2)
            local absolutef = screen:localToAbsolute(localf)
            win:setFrame(absolutef)
        end
        if direction == "mright" then
            localf.x = localf.x+stepw
            local absolutef = screen:localToAbsolute(localf)
            win:setFrame(absolutef)
        end
        if direction == "mleft" then
            localf.x = localf.x-stepw
            local absolutef = screen:localToAbsolute(localf)
            win:setFrame(absolutef)
        end
        if direction == "mup" then
            localf.y = localf.y-steph
            local absolutef = screen:localToAbsolute(localf)
            win:setFrame(absolutef)
        end
        if direction == "mdown" then
            localf.y = localf.y+steph
            local absolutef = screen:localToAbsolute(localf)
            win:setFrame(absolutef)
        end
        if direction == "ccursor" then
            localf.x = localf.x+localf.w/2 localf.y = localf.y+localf.h/2
            hs.mouse.setRelativePosition({x=localf.x,y=localf.y},screen)
        end
    else
        hs.alert.show("No focused window!")
    end
end

function showavailableHotkey()
    if not hotkeytext then
        local hotkey_list=hs.hotkey.getHotkeys()
        local mainScreen = hs.screen.mainScreen()
        local mainRes = mainScreen:fullFrame()
        local localMainRes = mainScreen:absoluteToLocal(mainRes)
        local hkbgrect = hs.geometry.rect(mainScreen:localToAbsolute(localMainRes.w/5,localMainRes.h/5,localMainRes.w/5*3,localMainRes.h/5*3))
        hotkeybg = hs.drawing.rectangle(hkbgrect)
        -- hotkeybg:setStroke(false)
        -- if not hotkey_tips_bg then hotkey_tips_bg = "light" end
        -- if hotkey_tips_bg == "light" then
            -- hotkeybg:setFillColor({red=238/255,blue=238/255,green=238/255,alpha=0.95})
        -- elseif hotkey_tips_bg == "dark" then
        hotkeybg:setFillColor({red=0,blue=0,green=0,alpha=0.65})
        -- end
        hotkeybg:setRoundedRectRadii(10,10)
        hotkeybg:setLevel(hs.drawing.windowLevels.modalPanel)
        hotkeybg:behavior(hs.drawing.windowBehaviors.stationary)
        local hktextrect = hs.geometry.rect(hkbgrect.x+40,hkbgrect.y+30,hkbgrect.w-80,hkbgrect.h-60)
        hotkeytext = hs.drawing.text(hktextrect,"")
        hotkeytext:setLevel(hs.drawing.windowLevels.modalPanel)
        hotkeytext:behavior(hs.drawing.windowBehaviors.stationary)
        hotkeytext:setClickCallback(nil,function() hotkeytext:delete() hotkeytext=nil hotkeybg:delete() hotkeybg=nil end)
        hotkey_filtered = {}
        for i=1,#hotkey_list do
            if hotkey_list[i].idx ~= hotkey_list[i].msg then
                table.insert(hotkey_filtered,hotkey_list[i])
            end
        end
        local availablelen = 70
        local hkstr = ''
        for i=2,#hotkey_filtered,2 do
            local tmpstr = hotkey_filtered[i-1].msg .. hotkey_filtered[i].msg
            if string.len(tmpstr)<= availablelen then
                local tofilllen = availablelen-string.len(hotkey_filtered[i-1].msg)
                hkstr = hkstr .. hotkey_filtered[i-1].msg .. string.format('%'..tofilllen..'s',hotkey_filtered[i].msg) .. '\n'
            else
                hkstr = hkstr .. hotkey_filtered[i-1].msg .. '\n' .. hotkey_filtered[i].msg .. '\n'
            end
        end
        if math.fmod(#hotkey_filtered,2) == 1 then hkstr = hkstr .. hotkey_filtered[#hotkey_filtered].msg end
        local hkstr_styled = hs.styledtext.new(hkstr, {font={name="Courier-Bold",size=16}, color=dodgerblue, paragraphStyle={lineSpacing=12.0,lineBreak='truncateMiddle'}, shadow={offset={h=0,w=0},blurRadius=0.5,color=darkblue}})
        hotkeytext:setStyledText(hkstr_styled)
        hotkeybg:show()
        hotkeytext:show()
    else
        hotkeytext:delete()
        hotkeytext=nil
        hotkeybg:delete()
        hotkeybg=nil
    end
end

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

-- if #modal_list > 0 then require("modalmgr") end

-- Vimouse
local vimouse = require('vimouse')
vimouse('cmd', 'm')

hs.notify.new({title='Hammerspoon', informativeText='Ready to rock 🤘'}):send()
