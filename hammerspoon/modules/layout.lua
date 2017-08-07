local window = require 'hs.window'
local hotkey = require 'hs.hotkey'
local geometry = require 'hs.geometry'
local mouse = require 'hs.mouse'
local layout = require 'hs.layout'

local hyper = {'alt', 'cmd'}
local screenSwitchMeta = {'ctrl', 'alt', 'cmd'}

-- Left side layout
hotkey.bind(hyper, 'Left', function ()
  local focused = window.focusedWindow()
  local f = focused:frame()
  local screen = focused:screen()
  local max = screen:frame()
  local half = max.w / 2
  local oneThird = max.w / 3
  local fromRight = f.x > 0
  -- print(focused:application():name())
  -- print('cur frame:', f)

  -- focused:moveToUnit'[0,0,50,100]'
  if f.w > oneThird and f.w < oneThird * 2 then
    if fromRight then
      focused:moveToUnit(layout.left50, 0)
    else
      focused:moveToUnit(layout.left70, 0)
    end
  elseif f.w > half then
    if fromRight then
      focused:moveToUnit(layout.left70, 0)
    else
      focused:moveToUnit(layout.left30, 0)
    end
  else
    if fromRight then
      focused:moveToUnit(layout.left30, 0)
    else
      focused:moveToUnit(layout.left50, 0)
    end
  end
end)

-- Right side layout
hotkey.bind(hyper, 'Right', function ()
  local focused = window.focusedWindow()
  local f = focused:frame()
  local screen = focused:screen()
  local max = screen:frame()
  local half = max.w / 2
  local oneThird = max.w / 3
  local fromLeft = f.x < 1

  if f.w > oneThird and f.w < oneThird * 2 then
    if fromLeft then
      focused:moveToUnit(layout.right50, 0)
    else
      focused:moveToUnit(layout.right70, 0)
    end
  elseif f.w > half then
    if fromLeft then
      focused:moveToUnit(layout.right70, 0)
    else
      focused:moveToUnit(layout.right30, 0)
    end
  else
    if fromLeft then
      focused:moveToUnit(layout.right30, 0)
    else
      focused:moveToUnit(layout.right50, 0)
    end
  end
end)

local function moveMouseToScreen(screen)
  local point = geometry.rectMidPoint(screen:fullFrame())
  mouse.setAbsolutePosition(point)
end

local function moveToNextScreen()
  local focused = window.focusedWindow()
  -- if not focused then return end
  local sc = focused:screen()
  -- if not sc then return end
  local another = sc:next()
  if not another then return end
  focused:moveToScreen(another, 0)
  moveMouseToScreen(another)
end

--Bring focus to next display/screen
hotkey.bind(screenSwitchMeta, 'Left', moveToNextScreen)
--Bring focus to previous display/screen
hotkey.bind(screenSwitchMeta, 'Right', moveToNextScreen)
