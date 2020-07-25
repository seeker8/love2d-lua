
function love.load()
  button = {}
  button.x = 0
  button.y = 0
  button.size = 50 

  score = 0
  timer = 0 
end

-- dt -> delta time
function love.update(dt)
  
end


function love.draw()
  love.graphics.setColor(0, 0, 1)
  love.graphics.circle("fill", button.x, button.y, button.size)
end
