love.window.setTitle("Zombie Killer")

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

  -- enemies
  zombies = {}
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

  -- enemies movement
  for i,z in ipairs(zombies) do
    z.x = z.x + math.cos(getAngleInRadians(z, player)) * z.speed * dt
    z.y = z.y + math.sin(getAngleInRadians(z, player)) * z.speed * dt

    if distance(z.x, z.y, player.x, player.y) < 30 then
      for i, z in ipairs(zombies) do
        zombies[i] = nil
      end
    end
  end
end

function love.draw()
  -- mouse
  mousePointer = {}
  mousePointer.x = love.mouse.getX()
  mousePointer.y = love.mouse.getY()

  love.graphics.draw(sprites.background, 0, 0)
  love.graphics.draw(sprites.player, player.x, player.y, getAngleInRadians(player, mousePointer),nil, nil, sprites.player:getWidth()/2, sprites.player:getHeight()/2)

  -- enemies
  for i,z in ipairs(zombies) do
    love.graphics.draw(sprites.zombie, z.x, z.y, getAngleInRadians(zombie, player), nil, nil, sprites.zombie:getWidth()/2, sprites.zombie:getHeight()/2)
  end
end

function getAngleInRadians(obj, facingPoint)
  return math.atan2(obj.y - facingPoint.y, obj.x - facingPoint.x) + math.pi
end

function spawnZombie()
  zombie = {}
  zombie.x = math.random(0, love.graphics.getWidth())
  zombie.y = math.random(0, love.graphics.getHeight())
  zombie.speed = 100

  table.insert(zombies, zombie)
end


function love.keypressed(key, scancode, isrepeat)
  if key == "space" then
    spawnZombie()
  end
end

function distance(x, y, x2, y2)
  return math.sqrt((y2 - y)^2 + (x2 - x)^2)
end
