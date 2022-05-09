-- https://github.com/uimini/uimini
-- https://tweaked.cc/module/parallel.html
-- https://tweaked.cc/module/multishell.html
-- https://tweaked.cc/module/textutils.html#v:unserializeJSON
-- app.mcap.fun/8080/ui/index.html

---------run-server---------------------
-- http://localhost:60000/0
----------------------------------------
local function initServer (wd, url, callback)
  local id = os.getComputerID() 
  local tpl =  "ui.url = '%s/%s'"
  local formatTpl = string.format(tpl, url, id)
  wd.runJS(formatTpl)
  -- listen http://localhost:60000/0
  while true do
          ev, code, path, args = os.pullEvent("webModem_request")
          if args ~=nil then
            callback(args)

          end
  end
end

---------------------------------------

local function button(wd, content, _type, left, top, lang, click_bind)
  local tpl =  "ui.button('%s', '%s', %s, %s, '%s', '%s')"
  local formatTpl = string.format(tpl, content, _type, left, top, lang, click_bind)
  wd.runJS(formatTpl)
end
---------------------------------------
local function checkbox(wd, content, left, top, checked, lang, click_bind)
  local tpl =  "ui.checkbox('%s',  %s, %s, %s, '%s', '%s')"
  local formatTpl = string.format(tpl, content,  left, top,  checked, lang, click_bind)
  wd.runJS(formatTpl)
end


---------------------------------------

local function radio(wd, array, left, top, lang)
  local tpl =  "ui.radio(%s,  %s, %s, '%s')"
  local formatTpl = string.format(tpl, textutils.serializeJSON(array),  left, top, lang)
  wd.runJS(formatTpl)
end
---------------------------------------
local function _switch(wd, content, left, top, checked, lang, bind)
  local tpl =  "ui.switch_2('%s',  %s, %s, %s, '%s', '%s')"
  local formatTpl = string.format(tpl, content,  left, top,  checked, lang, bind)
  wd.runJS(formatTpl)
end
---------------------------------------
local function input(wd, content, label, left, top,  lang, bind)
  local tpl =  "ui.input('%s', '%s',  %s, %s, '%s', '%s')"
  local formatTpl = string.format(tpl, content, label,  left, top, lang, bind)
  wd.runJS(formatTpl)
end
---------------------------------------
local function items(wd, array, left, top, lang)
  local tpl =  "ui.items(%s,  %s, %s, '%s')"
  local formatTpl = string.format(tpl, textutils.serializeJSON(array),  left, top, lang)
  wd.runJS(formatTpl)
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
local function color (wd, color)
  local tpl =  "ui.color( '%s')"
  local formatTpl = string.format(tpl, color)
  wd.runJS(formatTpl)
end
---------------------------
local function clear(wd)
  local formatTpl = "ui.clear()"
  wd.runJS(formatTpl)
end
---------------------------
local function name(wd, text)
  local tpl =  "ui.name( '%s')"
  local formatTpl = string.format(tpl, text)
  wd.runJS(formatTpl);
end
-------------------------
local function block(wd, borderWidth, borderColor, backgroundColor, left, top, width, height)
  local tpl =  "ui.block( %s, '%s', '%s', %s, %s,  %s,  %s)"
  local formatTpl = string.format(tpl, borderWidth, borderColor, backgroundColor, left, top, width, height)
  wd.runJS(formatTpl)
end
-------------------------
local function _table(wd, array, headColor, tableColor, left, top, width, height, lang)
  local tpl =  "ui.table(%s, '%s', '%s',  %s, %s, %s, %s, '%s')"
  local formatTpl = string.format(tpl, textutils.serializeJSON(array), headColor, tableColor,  left, top, width, height, lang)
  wd.runJS(formatTpl)
end


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
  color = color,
  clear = clear,
  name = name,
  table = _table
}

return ui
--  @USAGE
--[[    


require "ui"

local wd = peripheral.wrap("top")
local res = wd.getResolution()

ui.clear(wd)
ui.name(wd, 'formID')
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


ui.radio(wd, {
  "item 1",
  "item 2",
  "item 3",
}, 700, 150)

--ui.switch(wd, 'Perekluchatel', 400, 220, true, 'ru', 'bind_id-1')
ui.switch(wd, 'test 1', 400, 300, true, nil, 'bind_id-2')
ui.switch(wd, 'test 2', 400, 350, true, nil)

ui.input(wd, 'kontent 1', 'Pole dlya vvoda', 400, 370, nil, 'id-inputData')
ui.input(wd, 'kontent 2', 'Pole dlya vvoda 2', 400, 450, nil)


ui.items(wd, {
  "item 1",
  "item 2",
  "item 3",
  "item 4",
  "item 5",
  "item 6",
}, 10, 400)


ui.image(wd, "http://fabricjs.com/assets/pug_small.jpg", 770, 400, 200, 450)
ui.image(wd, "http://fabricjs.com/assets/pug_small.jpg", 900, 0, 100, 100)
ui.block(wd, 10, 'magenta', 'darkcyan', 800, 940, 100, 50)


ui.table(wd, {
  { "Indifikator", "Imya", "Opisanie", "test" },
  { 0, "Morkovmzn", "test 1 1 1", "111" },
  { 1, "Xleb", "test 33 3 3", '' },
  { '2.1', "Kapusta", "test 1 11", 333 },

}, 'brown', 'skyblue', 10, 700, 700, 500, 'ru')

-- 

----- init webModem ----

local wm = peripheral.wrap("left")

ui.initServer(wd, "http://localhost:60000",
function (jsonBody)
      local body = textutils.unserializeJSON(jsonBody)
      for key, val in pairs(body) do
         print(key..': ', val)
      end
      print('----------------------')
end)

]]
