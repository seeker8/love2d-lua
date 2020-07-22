message = "Hello World!"

-- conditionals
condition = 20
if condition > 0 then
  message = "it is greater than 0"
end


function love.draw()
  love.graphics.setFont(love.graphics.newFont(50))
  love.graphics.print(message, 200, 300)
end
