love.window.setTitle("Clicker")

function love.load()
  button = {}
  button.x = 200
  button.y = 200
  button.size = 50 

  score = 0
  timer = 10 

  myFont = love.graphics.newFont(40)
end

-- dt -> delta time
function love.update(dt)
  if timer > 0 then
    timer = timer - dt
  end

  if timer < 0 then
    timer = 0
  end
end


function love.draw()
  love.graphics.setColor(0, 0, 1)
  love.graphics.circle("fill", button.x, button.y, button.size)

  -- score
  love.graphics.setFont(myFont)
  love.graphics.setColor(1, 1, 1)
  love.graphics.print(score)

  -- timer
  love.graphics.print(math.ceil(timer), 200, 0)
end

function love.mousepressed(x, y, buttonClicked, istouch)
  if buttonClicked == 1 then
    d = distance(button.x, button.y, x, y)
    if d <= button.size then
      score = score + 1
      button.x = math.random(button.size, love.graphics.getWidth() - button.size)
      button.y = math.random(button.size, love.graphics.getHeight() - button.size)
    end
  end
end

function distance(x, y, x2, y2)
  return math.sqrt((y2 - y)^2 + (x2 - x)^2)
end
