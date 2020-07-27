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

  -- ammo
  bullets = {}

  -- game
  gameState = 2
  maxTime = 2
  timer = maxTime
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
        gameState = 1
      end
    end
  end

  -- bullets
  for i,b in ipairs(bullets) do
    b.x = b.x + math.cos(b.direction) * b.speed * dt
    b.y = b.y + math.sin(b.direction) * b.speed * dt
  end

  for i=#bullets, 1, -1 do
    local b = bullets[i]
    if b.x < 0 or b.y < 0 or b.x > love.graphics.getWidth() or b.y > love.graphics.getHeight() then
      table.remove(bullets, i)
    end
  end

  -- bullets vs zombies
  for i, z in ipairs(zombies) do
    for j, b in ipairs(bullets) do
      if distance(z.x, z.y, b.x, b.y) < 20 then
        z.dead = true
        b.dead = true
      end
    end
  end

  -- remove dead
  for i=#zombies, 1, -1 do
    local z = zombies[i]
    if z.dead == true then
      table.remove(zombies, i)
    end
  end

  for i=#bullets, 1, -1 do
    local b = bullets[i]
    if b.dead == ture then
      table.remove(bullets, i)
    end
  end

  if gameState == 2 then
    timer = timer - dt
    if timer <= 0 then
      spawnZombie()
      maxTime = maxTime * 0.95
      timer = maxTime
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

  -- bullets
  for i,b in ipairs(bullets) do
    love.graphics.draw(sprites.bullet, b.x, b.y, nil, 0.5, 0.5, sprites.bullet:getWidth()/2, sprites.bullet:getHeight()/2)
  end
end

function getAngleInRadians(obj, facingPoint)
  return math.atan2(obj.y - facingPoint.y, obj.x - facingPoint.x) + math.pi
end

function spawnZombie()
  zombie = {}
  zombie.x = 0
  zombie.y = 0
  zombie.speed = 100
  zombie.dead = false

  local side = math.random(1, 4)

  if side == 1 then
    zombie.x = -30
    zombie.y = math.random(0, love.graphics.getHeight())
  elseif side == 2 then
    zombie.x = math.random(0, love.graphics.getWidth())
    zombie.y = -30
  elseif side == 3 then
    zombie.x = love.graphics.getWidth() + 30
    zombie.y = math.random(0, love.graphics.getHeight())
  else
    zombie.x = math.random(0, love.graphics.getWidth())
    zombie.y = love.graphics.getHeight() + 30
  end

  table.insert(zombies, zombie)
end

function spawnBullet()
  mouse = {}
  mouse.x = love.mouse.getX()
  mouse.y = love.mouse.getY()

  bullet = {}
  bullet.x = player.x
  bullet.y = player.y
  bullet.speed = 400
  bullet.dead = false
  bullet.direction = getAngleInRadians(bullet, mouse)

  table.insert(bullets, bullet)
end


function love.keypressed(key, scancode, isrepeat)
  if key == "space" then
    spawnZombie()
  end
end

function love.mousepressed(x, y, button, istouch)
  if button == 1 then
    spawnBullet()
  end
end

function distance(x, y, x2, y2)
  return math.sqrt((y2 - y)^2 + (x2 - x)^2)
end
