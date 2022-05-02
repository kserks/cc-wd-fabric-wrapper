--- http://fabricjs.com/docs/index.html ---
--- https://montoyo.net/wdwiki/index.php?title=OpenComputers_Interface ---


-- wd.runJS("location.href = 'http://ya.ru'")
-- getResolution()

-- usage
-- line({ 50, 720, 300, 720 }, { fill = "cyan", stroke = "cyan", strokeWidth = 25 })
------------------------------------------------------------------------------------
local function line (wd, points, p)
  local shape = "new Line([ "..points[1]..", "..points[2]..", "..points[3]..", "..points[4].." ], { fill: '"..p.fill.."', stroke: '"..p.stroke.."', strokeWidth: "..p.strokeWidth.." })"  
  local js_code = "canvas.add("..shape..");"
  wd.runJS(js_code)
end
 
-- usage
-- image("http://fabricjs.com/assets/pug_small.jpg", { left = 400, top = 400, width = 300, height = 300 })
------------------------------------------------------------------------------------
local function image (wd, url, p)
  local callback = "function imageLoad(myImg) {var img1 = myImg.set({ left: "..p.left..", top: "..p.top.." ,width: "..p.width..", height: "..p.height.."});canvas.add(img1);}"
  local img = "fabric.Image.fromURL('"..url.."', imageLoad );"  
  local js_code = callback..img
  wd.runJS(js_code)
end

-- usage
--[[
      rect({ 
        fill = "rgba(0,0,0,0.5)", 
        angle = -15, 
        stroke = "#f70a7d", 
        strokeWidth = 5,
        width = 200,
        height = 200,
        top = 300,
        left = 200
      })
]]
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


-- usage
--[[
      circle({
        radius = 50,
        fill = 'rgba(0,0,0,0)',
        top = 600,
        left = 600,
        strokeWidth = 5,
        stroke = 'red'
      })
]]
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
-- usage
--[[
      polyline(
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
]]
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
-- usage
--[[
    text('hello world', {
      fill = "deepskyblue",
      fontSize = 20
      left = 500
      top = 50
    })
]]
------------------------------------------------------------------------------------
local function text (wd, text, p)
  local str = [[
          new Text('%s', {
              fontSize: %s,
              left: %s,
              top: %s,
              fill: "%s"
          })
  ]]
  local shape = string.format(str, text, p.fontSize, p.left, p.top, p.fill)
  local js_code = "canvas.add("..shape..");"
  wd.runJS(js_code)
end
-- usage
--[[
  polygon(
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
          strokeWidth = 3, 
        }
  )
]]
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


-- usage
--[[
      triangle({
          width = 100, 
          height = 100, 
          left = 50, 
          top = 300,  
          fill = 'rgba(0,0,0,0)',
          stroke = 'deepskyblue', 
          strokeWidth = 5
      })
]]
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

--canvas.setHeight(500);
--canvas.setWidth(800);

local function canvasClear (wd)
  wd.runJS("canvas.clear()")
end
local function canvasColor (wd, color)
  local str = "canvas.backgroundColor = '%s';"
  local js_code = string.format(str, color)
  wd.runJS(js_code)
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
  color = canvasColor
}

return canvas