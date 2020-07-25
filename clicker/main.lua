
function love.load()
  button = {}
  button.x = 200
  button.y = 200
  button.size = 50 

  score = 0
  timer = 0 

  myFont = love.graphics.newFont(40)
end

-- dt -> delta time
function love.update(dt)
  
end


function love.draw()
  love.graphics.setColor(0, 0, 1)
  love.graphics.circle("fill", button.x, button.y, button.size)

  -- score
  love.graphics.setFont(myFont)
  love.graphics.setColor(1, 1, 1)
  love.graphics.print(score)
end

function love.mousepressed(x, y, buttonClicked, istouch)
  if buttonClicked == 1 then
    d = distance(button.x, button.y, x, y)
    if d <= button.size then
      score = score + 1
    end
  end
end

function distance(x, y, x2, y2)
  return math.sqrt((y2 - y)^2 + (x2 - x)^2)
end
