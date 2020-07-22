message = "Hello World!"
function love.draw()
  love.graphics.setFont(love.graphics.newFont(50))
  love.graphics.print(message, 200, 300)
end
