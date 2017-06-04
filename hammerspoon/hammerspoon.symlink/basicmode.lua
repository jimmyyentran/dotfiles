viewM = hs.hotkey.modal.new()
local modalpkg = {}
modalpkg.id = "viewM"
modalpkg.modal = viewM
table.insert(modal_list, modalpkg)

-- From init.lua
keyUpDown = function(modifiers, key)
  -- Un-comment & reload config to log each keystroke that we're triggering
  -- log.d('Sending keystroke:', hs.inspect(modifiers), key)
  hs.eventtap.keyStroke(modifiers, key, 0)
end

enableHotkeyForWindowsMatchingFilter = function(windowFilter, hotkey)
  windowFilter:subscribe(hs.window.filter.windowFocused, function()
    hotkey:enable()
  end)

  windowFilter:subscribe(hs.window.filter.windowUnfocused, function()
    hotkey:disable()
  end)
end

function move_win(direction)
    local win = hs.window.focusedWindow()
    local screen = win:screen()
    if win then
        if direction == 'up' then win:moveOneScreenNorth() end
        if direction == 'down' then win:moveOneScreenSouth() end
        if direction == 'left' then win:moveOneScreenWest() end
        if direction == 'right' then win:moveOneScreenEast() end
        if direction == 'next' then win:moveToScreen(screen:next()) end
        if direction == 'previous' then win:moveToScreen(screen:previous()) end
    end
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
-- End from init.lua

resizeM = hs.hotkey.modal.new()
local modalpkg = {}
modalpkg.id = "resizeM"
modalpkg.modal = resizeM
table.insert(modal_list, modalpkg)

function resizeM:entered()
    resize_current_winnum = 1
    resize_win_list = hs.window.visibleWindows()
end

function resizeM:exited() end

resizeM:bind('', 'escape', function() resizeM:exit() end)
resizeM:bind('', 'I', function() resizeM:exit() end)
resizeM:bind('', 'tab', function() showavailableHotkey() end)

resizeM:bind('', 'F', 'Fullscreen', function() resize_win('fullscreen') end, nil, nil)
resizeM:bind('', 'M', 'Fullscreen', function() resize_win('fullscreen') end, nil, nil)
resizeM:bind('', 'C', 'Center Window', function() resize_win('center') end, nil, nil)
resizeM:bind('shift', 'C', 'Resize & Center', function() resize_win('fcenter') end, nil, nil)
resizeM:bind('', '=', 'Stretch Outward', function() resize_win('expand') end, nil, function() resize_win('expand') end)
resizeM:bind('', '-', 'Shrink Inward', function() resize_win('shrink') end, nil, function() resize_win('shrink') end)

resizeM:bind('shift', 'Y', 'Shrink Leftward', function() resize_win('left') end, nil, function() resize_win('left') end)
resizeM:bind('shift', 'O', 'Stretch Rightward', function() resize_win('right') end, nil, function() resize_win('right') end)
resizeM:bind('shift', 'U', 'Stretch Downward', function() resize_win('down') end, nil, function() resize_win('down') end)
resizeM:bind('shift', 'I', 'Shrink Upward', function() resize_win('up') end, nil, function() resize_win('up') end)

resizeM:bind('', 'H', 'Lefthalf of Screen', function() resize_win('halfleft') end, nil, nil)
resizeM:bind('', 'L', 'Righthalf of Screen', function() resize_win('halfright') end, nil, nil)
resizeM:bind('', 'J', 'Downhalf of Screen', function() resize_win('halfdown') end, nil, nil)
resizeM:bind('', 'K', 'Uphalf of Screen', function() resize_win('halfup') end, nil, nil)

resizeM:bind('', '1', 'NorthWest Corner', function() resize_win('cornerNW') end, nil, nil)
resizeM:bind('', '2', 'NorthEast Corner', function() resize_win('cornerNE') end, nil, nil)
resizeM:bind('', '3', 'SouthWest Corner', function() resize_win('cornerSW') end, nil, nil)
resizeM:bind('', '4', 'SouthEast Corner', function() resize_win('cornerSE') end, nil, nil)

resizeM:bind('', 'Y', 'Move Leftward', function() resize_win('mleft') end, nil, function() resize_win('mleft') end)
resizeM:bind('', 'O', 'Move Rightward', function() resize_win('mright') end, nil, function() resize_win('mright') end)
resizeM:bind('', 'U', 'Move Downward', function() resize_win('mdown') end, nil, function() resize_win('mdown') end)
resizeM:bind('', 'I', 'Move Upward', function() resize_win('mup') end, nil, function() resize_win('mup') end)

resizeM:bind('', '`', 'Center Cursor', function() resize_win('ccursor') end, nil, nil)
resizeM:bind('', '[', 'Focus Westward', function() cycle_wins_pre() end, nil, function() cycle_wins_pre() end)
resizeM:bind('', ']', 'Focus Eastward', function() cycle_wins_next() end, nil, function() cycle_wins_next() end)

resizeM:bind('shift', 'H', 'Move to monitor left', function() move_win('left') end, nil, nil)
resizeM:bind('shift', 'L', 'Move to monitor right', function() move_win('right') end, nil, nil)
resizeM:bind('shift', 'J', 'Move to monitor below', function() move_win('down') end, nil, nil)
resizeM:bind('shift', 'K', 'Move to monitor above', function() move_win('up') end, nil, nil)

resizeM:bind('', 'space', 'Move to next monitor', function() move_win('next') end, nil, nil)
resizeM:bind('', 'X', 'Move to next monitor', function() move_win('next') end, nil, nil)
resizeM:bind('', 'Z', 'Move to previous monitor', function() move_win('previous') end, nil, nil)

function cycle_wins_next()
    resize_win_list[resize_current_winnum]:focus()
    resize_current_winnum = resize_current_winnum + 1
    if resize_current_winnum > #resize_win_list then resize_current_winnum = 1 end
end

function cycle_wins_pre()
    resize_win_list[resize_current_winnum]:focus()
    resize_current_winnum = resize_current_winnum - 1
    if resize_current_winnum < 1 then resize_current_winnum = #resize_win_list end
end

