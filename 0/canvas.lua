--- http://fabricjs.com/docs/index.html ---
--- https://montoyo.net/wdwiki/index.php?title=OpenComputers_Interface ---
-----------------------------------------------------------------------------------

local function line (wd, points, p)
  local shape = "new Line([ "..points[1]..", "..points[2]..", "..points[3]..", "..points[4].." ], { fill: '"..p.fill.."', stroke: '"..p.stroke.."', strokeWidth: "..p.strokeWidth.." })"  
  local js_code = "canvas.add("..shape..");"
  wd.runJS(js_code)
end

------------------------------------------------------------------------------------

local function image (wd, url, p)
  local callback = "function imageLoad(myImg) {var img1 = myImg.set({ left: "..p.left..", top: "..p.top.." ,width: "..p.width..", height: "..p.height.."});canvas.add(img1);}"
  local img = "fabric.Image.fromURL('"..url.."', imageLoad );"  
  local js_code = callback..img
  wd.runJS(js_code)
end

------------------------------------------------------------------------------------

local function rect (wd, p)
  local str = [[
      new Rect({ 
            width: %s, 
            height: %s, 
            left: %s, 
            top: %s, 
            angle: %s, 
            fill: '%s', 
            stroke: '%s', 
            strokeWidth: %s
      })
  ]]  
  local shape = string.format(str, p.width, p.height, p.left, p.top, p.angle, p.fill, p.stroke, p.strokeWidth)
  local js_code = "canvas.add("..shape..");"
  wd.runJS(js_code)
end

------------------------------------------------------------------------------------
-- strokeDashArray = '[5, 5]' - штриховка границы. ширина и отступ
local function circle (wd, p)
  local str = [[
          new Circle({
            radius: %s, 
            left: %s, 
            top: %s, 
            fill: '%s',
            stroke: '%s', 
            strokeWidth: %s
          })
  ]]
  local shape = string.format(str, p.radius, p.left, p.top, p.fill, p.stroke, p.strokeWidth)
  local js_code = "canvas.add("..shape..");"
  wd.runJS(js_code)
end
------------------------------------------------------------------------------------

local function polyline (wd, points, p)
  local str = [[
      new Polyline(
        [
          { x: %s, y: %s }, { x: %s, y: %s }, { x: %s, y: %s }, { x: %s, y: %s }
        ], 
        {
          fill: '%s',
          stroke: '%s',
          strokeWidth: %s 
        }
      )
  ]]
  local shape = string.format(str, points[1].x, points[1].y, points[2].x, points[2].y, points[3].x, points[3].y, points[4].x, points[4].y,  p.fill, p.stroke, p.strokeWidth)
  local js_code = "canvas.add("..shape..");"
  wd.runJS(js_code)
end
------------------------------------------------------------------------------------

local function text (wd, text, p, lang)
  local str = [[
          textFormat('%s', {
              fontSize: %s,
              left: %s,
              top: %s,
              fill: "%s"
          }, "%s")
  ]]
  local js_code = ''
  if (lang) then
    js_code = string.format(str, text, p.fontSize, p.left, p.top, p.fill, lang)
 
  else
    js_code = string.format(str, text, p.fontSize, p.left, p.top, p.fill, "null")
  end
  wd.runJS(js_code)
end
------------------------------------------------------------------------------------

local function polygon (wd, points, p)
  local str = [[
    new Polygon(
        [
          { x: %s, y: %s },
          { x: %s, y: %s },
          { x: %s, y: %s },
          { x: %s, y: %s },
          { x: %s, y: %s }
        ], 
        {
          fill: '%s', 
          stroke: '%s',
          strokeWidth: %s, 
        }
      )
  ]]
  local shape = string.format(str, points[1].x, points[1].y, points[2].x, points[2].y, points[3].x, points[3].y, points[4].x, points[4].y, points[5].x, points[5].y, p.fill, p.stroke, p.strokeWidth)
  local js_code = "canvas.add("..shape..");"
  wd.runJS(js_code)
end

------------------------------------------------------------------------------------
local function triangle (wd, p)
  local str = [[
      new Triangle({
          width: %s, 
          height: %s, 
          left: %s, 
          top: %s,  
          fill: '%s',
          stroke: '%s', 
          strokeWidth: %s
      })
  ]]
  local shape = string.format(str, p.width, p.height, p.left, p.top, p.fill, p.stroke, p.strokeWidth)
  local js_code = "canvas.add("..shape..");"
  wd.runJS(js_code)
end
------------------------------------------------------------------------------------


local function canvasClear (wd)
  wd.runJS("canvas.clear()")
end
------------------------------------------------------------------------------------

local function canvasColor (wd, color)
  local str = "canvas.backgroundColor = '%s';canvas.renderAll();"
  local js_code = string.format(str, color)
  wd.runJS(js_code)
end
------------------------------------------------------------------------------------

local function canvasSize (wd, width, height)
  local str = "canvas.setWidth(%s);canvas.setHeight(%s);"
  local js_code = string.format(str, width, height)
  wd.runJS(js_code)
end
------------------------------------------------------------------------------------

local function setURL (wd, url)
  wd.setURL(url)
end

canvas = {
  line = line,
  image = image,
  rect = rect,
  circle = circle,
  polyline = polyline,
  text = text,
  polygon = polygon,
  triangle = triangle,
  clear = canvasClear,
  color = canvasColor,
  size = canvasSize,
  setURL = setURL
}

return canvas

--[[
  @USAGE
require "canvas"

local wd = peripheral.wrap("top")
local res = wd.getResolution()

canvas.setURL(wd, 'app.mcap.fun/8080/canvas/index.html')
os.sleep(2)

canvas.clear(wd)
canvas.size(wd, res, res)
canvas.color(wd, "black")

canvas.line(wd, { 50, 720, 300, 720 }, { fill = "cyan", stroke = "cyan", strokeWidth = 25 })

canvas.image(wd, "http://fabricjs.com/assets/pug_small.jpg", { left = 480, top = 100, width = 300, height = 300 })

canvas.rect(wd, { 
  fill = "rgba(0,0,0,0.5)", 
  angle = -15, 
  stroke = "#f70a7d", 
  strokeWidth = 5,
  width = 200,
  height = 200,
  top = 300,
  left = 50
})


canvas.circle(wd, {
  radius = 50,
  fill = 'rgba(0,0,0,0)',
  top = 670,
  left = 670,
  strokeWidth = 5,
  stroke = 'red'
})

canvas.polyline(wd, 
  { 
    { x = 0, y = 0 }, 
    { x = 100, y = 50 }, 
    { x = 250, y = 200 }, 
    { x = 200, y = 10 }
  }, 
  {
    fill = 'rgba(0,0,0,0)',
    stroke = 'lightgreen',
    strokeWidth = 10
  }
)



canvas.polygon(wd, 
  {
    { x = 400, y = 410 },
    { x = 450, y = 450 },
    { x = 450, y = 680 },
    { x = 350, y = 680 },
    { x = 350, y = 450 }
  }, 
  {
    fill = 'rgba(100,0,0,0.5)', 
    stroke = "gold",
    strokeWidth = 3
  }
)

canvas.text(wd, 'Privet Mir', {
    fill = "deepskyblue",
    fontSize = 40,
    left = 300,
    top = 50
}, 'ru')

canvas.triangle(wd, {
    width = 100, 
    height = 100, 
    left = 300, 
    top = 220,  
    fill = 'rgba(0,0,0,0)',
    stroke = 'deepskyblue', 
    strokeWidth = 5
})

]]