local playerClass = { }
playerClass.__index = playerClass

local function Player(config)
  local width, height = love.graphics.getDimensions()
  local startPosition = 10
  if config.num == 2 then
    startPosition = width
  end
  local instance = {
    num = config.num,
    up = config.up,
    down = config.down,
    h = height/8,
    w = 10,
    x = startPosition - 10,
    y = height/2 - (height/16)
  }
  setmetatable(instance, playerClass)
  return instance
end

function playerClass:draw()
  love.graphics.setColor( 255, 255, 255 )
  love.graphics.rectangle( 'fill', self.x, self.y, self.w, self.h )
end

function playerClass:update(dt)
  local _, height = love.graphics.getDimensions()
  local dy = 0

  if love.keyboard.isDown(self.up) then
    dy = -300
  end

  if love.keyboard.isDown(self.down) then
    dy = 300
  end

  if self.y < 0 then
    dy = 200
  end
  if self.y + self.h > height then
    dy = -200
  end

  self.y = self.y + (dy * dt)
end

return Player
