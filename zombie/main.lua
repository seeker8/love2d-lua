
function love.load()
  sprites = {}
  sprites.player = love.graphics.newImage('sprites/player.png')
  sprites.bullet = love.graphics.newImage('sprites/bullet.png')
  sprites.zombie = love.graphics.newImage('sprites/zombie.png')
  sprites.background = love.graphics.newImage('sprites/background.png')

  -- player
  player = {}
  player.x = 200
  player.y = 200
  player.speed = 180
end

function love.update(dt)
  if love.keyboard.isDown("s") and player.y <= love.graphics.getHeight() - 45 then
    player.y = player.y + player.speed * dt
  end

  if love.keyboard.isDown("w") and player.y > 0 then
    player.y = player.y - player.speed * dt
  end

  if love.keyboard.isDown("a") and player.x > 0 then
    player.x = player.x - player.speed * dt
  end

  if love.keyboard.isDown("d") and player.x <= love.graphics.getWidth() - 30 then
    player.x = player.x + player.speed * dt
  end
end

function love.draw()
  love.graphics.draw(sprites.background, 0, 0)
  love.graphics.draw(sprites.player, player.x, player.y, getAngleInRadians(),nil, nil, sprites.player:getWidth()/2, sprites.player:getHeight()/2)
end

function getAngleInRadians()
  return math.atan2(player.y - love.mouse.getY(), player.x - love.mouse.getX()) + math.pi
end
