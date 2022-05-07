-- https://github.com/uimini/uimini
-- https://tweaked.cc/module/parallel.html
-- https://tweaked.cc/module/multishell.html
-- https://tweaked.cc/module/textutils.html#v:unserializeJSON

-- utils
local function luaArrayToJSArray (array)
  local formatedContent = "["
  for i = 1, #array do 
     formatedContent  = formatedContent .. "'"..array[i].."',"
  end
  formatedContent = formatedContent.."]"
  return formatedContent
end

--------------------------


local function button(wd, content, _type, left, top, lang, click_bind)
  local tpl =  "ui.button('%s', '%s', %s, %s, '%s', '%s')"
  local formatTpl = string.format(tpl, content, _type, left, top, lang, click_bind)
  wd.runJS(formatTpl)
end

local function checkbox(wd, content, left, top, checked, lang, click_bind)
  local tpl =  "ui.checkbox('%s',  %s, %s, %s, '%s', '%s')"
  local formatTpl = string.format(tpl, content,  left, top,  checked, lang, click_bind)
  wd.runJS(formatTpl)
end




local function radio(wd, array, left, top, lang)
  local tpl =  "ui.radio(%s,  %s, %s, '%s')"
  local formatTpl = string.format(tpl, luaArrayToJSArray(array),  left, top, lang)
  wd.runJS(formatTpl)
end

local function _switch(wd, content, left, top, checked, lang, bind)
  local tpl =  "ui.switch_2('%s',  %s, %s, %s, '%s', '%s')"
  local formatTpl = string.format(tpl, content,  left, top,  checked, lang, bind)
  wd.runJS(formatTpl)
end

local function input(wd, content, left, top,  lang, bind)
  local tpl =  "ui.input('%s',  %s, %s, '%s', '%s')"
  local formatTpl = string.format(tpl, content,  left, top, lang, bind)
  wd.runJS(formatTpl)
end

local function items(wd, array, left, top, lang)
  local tpl =  "ui.items(%s,  %s, %s, '%s')"
  local formatTpl = string.format(tpl, luaArrayToJSArray(array),  left, top, lang)
  wd.runJS(formatTpl)
end
---------run-server---------------------
-- http://localhost:60000/0
----------------------------------------
local function initServer (wd, callback)
  local id = os.getComputerID()
  wd.runJS('ui.ccID='..id)
  -- listen http://localhost:60000/0
  while true do
          ev, code, path, args = os.pullEvent("webModem_request")
          if args ~=nil then
            callback(args)
          end
  end
end
-----------------------------------------
local function getData(wd)
  wd.runJS('ui.getData()')
end
-------------------------
local function image(wd, url, left, top, width, height)
  local tpl =  "ui.image('%s',  %s, %s, %s, %s)"
  local formatTpl = string.format(tpl, url, left, top, width, height)
  wd.runJS(formatTpl)
end
-------------------------
function color (wd, color)
  local tpl =  "ui.color( '%s')"
  local formatTpl = string.format(tpl, color)
  wd.runJS(formatTpl)
end
-------------------------
local function block(wd, borderWidth, borderColor, backgroundColor, left, top, width, height)
  local tpl =  "ui.block( %s, '%s', '%s', %s, %s,  %s,  %s)"
  local formatTpl = string.format(tpl, borderWidth, borderColor, backgroundColor, left, top, width, height)
  wd.runJS(formatTpl)
end
-------------------------
ui = {
  button = button,
  checkbox = checkbox,
  radio = radio,
  switch = _switch,
  input = input,
  items = items,
  initServer = initServer,
  getData = getData,
  image = image,
  block = block,
  color = color
}

return ui

--[[


require "ui"

local wd = peripheral.wrap("top")
local res = wd.getResolution()
ui.color(wd, 'black')
----------------------

ui.button(wd, 'Po umolchaniyu', 'default', 10, 10, 'ru')
ui.button(wd, 'Vnimanie', 'primary', 10, 60, 'ru')

ui.button(wd, 'Vnimanie', 'warning', 10, 180, 'ru')
ui.button(wd, 'Vnimanie', 'light', 10, 240, 'ru')
ui.button(wd, 'Dangerous', 'dangerous', 10, 300, nil)

ui.checkbox(wd, 'Variant', 400, 10, true, 'ru', 'checkbox_1')
ui.checkbox(wd, 'Variant 2', 400, 50, false, 'ru')

ui.button(wd, 'Soxranitmzn', 'success', 10, 350, 'ru', 'click_btn')



--ui.switch(wd, 'Perekluchatel', 400, 220, true, 'ru', 'bind_id-1')
ui.switch(wd, 'test 1', 400, 300, true, nil, 'bind_id-2')
ui.switch(wd, 'test 2', 400, 350, true, nil)

ui.input(wd, 'Pole dlya vvoda', 400, 370, 'ru', 'id-inputData')
ui.input(wd, 'Pole dlya vvoda 2', 400, 450, 'ru')

ui.items(wd, {
  "item 1",
  "item 2",
  "item 3",
  "item 4",
  "item 5",
  "item 6",
}, 10, 450)


ui.image(wd, "http://fabricjs.com/assets/pug_small.jpg", 670, 400, 200, 450)
ui.image(wd, "http://fabricjs.com/assets/pug_small.jpg", 900, 0, 100, 100)
ui.block(wd, 10, 'magenta', 'darkcyan', 100, 850, 400, 100)

os.sleep(3)
ui.getData(wd)

------init webModem-----

local wm = peripheral.wrap("left")
ui.initServer(wd, 
function (jsonBody)
  local body = textutils.unserializeJSON(jsonBody)
  for key, val in pairs(body) do
     print(key..': ', val)
  end
  print('----------------------')
end)





-- ru-EN


]]
