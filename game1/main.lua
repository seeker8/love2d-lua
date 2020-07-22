message = "Hello World!"

function changeMessage()
  message = "This message was changed inside a function"
end

function increase(i)
  local var = i
  var = var * var
  return var
end

-- conditionals
condition = 20
if condition > 0 then
  message = "it is greater than 0"
end

changeMessage()
increase(2)

function love.draw()
  love.graphics.setFont(love.graphics.newFont(50))
  love.graphics.print(var)
end
