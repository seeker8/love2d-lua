love.window.setTitle("Clicker")

function love.load()
  button = {}
  button.x = 200
  button.y = 200
  button.size = 50 

  score = 0
  timer = 10
  gameState = 1 

  myFont = love.graphics.newFont(40)
end

-- dt -> delta time
function love.update(dt)
  if gameState == 2 then
    if timer > 0 then
      timer = timer - dt
    end

    if timer < 0 then
      timer = 0
      gameState = 1
    end
  end
end


function love.draw()
  if gameState == 2 then
    love.graphics.setColor(0, 0, 1)
    love.graphics.circle("fill", button.x, button.y, button.size)
  end

  if gameState == 1 then
    love.graphics.printf("Click anywhere to begin", 0 , love.graphics.getHeight()/2, love.graphics.getWidth(), "center")
  end

  -- score
  love.graphics.setFont(myFont)
  love.graphics.setColor(1, 1, 1)
  love.graphics.print("Score: " .. score)

  -- timer
  love.graphics.print("Time: " .. math.ceil(timer), 350, 0)
end

function love.mousepressed(x, y, buttonClicked, istouch)
  if buttonClicked == 1 and gameState == 2  then
    d = distance(button.x, button.y, x, y)
    if d <= button.size then
      score = score + 1
      button.x = math.random(button.size, love.graphics.getWidth() - button.size)
      button.y = math.random(button.size, love.graphics.getHeight() - button.size)
    end
  end

  if gameState == 1 then
    gameState = 2
    timer = 10
    score = 0
  end
end

function distance(x, y, x2, y2)
  return math.sqrt((y2 - y)^2 + (x2 - x)^2)
end
