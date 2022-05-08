
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


ui.image(wd, "http://fabricjs.com/assets/pug_small.jpg", 670, 400, 200, 450)
ui.image(wd, "http://fabricjs.com/assets/pug_small.jpg", 900, 0, 100, 100)
ui.block(wd, 10, 'magenta', 'darkcyan', 100, 850, 400, 100)

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
