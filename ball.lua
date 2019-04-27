local ballClass = { }
ballClass.__index = ballClass

local state = require('state')
local Vector = require('vector')

local function Ball()
  local width, height = love.graphics.getDimensions()
  local instance = {
    position = Vector( width/2, height/2 ),
    velocity = Vector(100, 200),
    radius = 5
  }
  setmetatable(instance, ballClass)
  return instance
end

function ballClass:draw()
  love.graphics.setColor( 183, 3, 3 )
  love.graphics.circle( 'fill', self.position.x, self.position.y, self.radius )
end

function ballClass:update(dt)
  local edge = self:edge()
  if (edge ~= "") then
    self:reflection(edge, dt)
  end
  self.position = self.position:move(self.velocity, dt)
end

function ballClass:edge()
  local width, height = love.graphics.getDimensions()
  local edge = ""

  if self.position.x <= 0 then
    edge = "left"
  end
  if (self.position.x + self.radius) >= width then
    edge = "right"
  end
  if self.position.y <= 0 then
    edge = "top"
  end
  if (self.position.y + self.radius) >= height then
    edge = "bottom"
  end

  return edge
end

function ballClass:reflection(edge, dt)
  local width, height = love.graphics.getDimensions()
  if edge == "top" or edge == "bottom" then
    self.velocity = self.velocity:reverse("y")
    if self.position.x < 10 or self.position.x > width - 10 then
      self.velocity = self.velocity:reverse("x")
    end
  end
  if edge == "left" or edge == "right" then
    self.velocity = self.velocity:reverse("x")
    if self.position.y < 10 or self.position.y > height - 10 then
      self.velocity = self.velocity:reverse("y")
    end
    self:collisionCheck(edge, dt)
  end
end

function ballClass:collisionCheck(edge, dt)
  local save = false
  for _, entity in ipairs(state.entities) do
    if (entity.num == 1 and edge == "right")
      or (entity.num == 2 and edge == "left") then
      save = self:touching(entity, dt)
    end
  end
  if save == false then
    state:addPoint(edge)
  end
end

function ballClass:touching(player, dt)
  if self.position.y > player.y - 5 and self.position.y < player.y + player.w + 5 then
    self:hitangle(player.y - 5, player.y + player.h + 5, dt)
    return true
  else
    return false
  end
end

function ballClass:hitangle(top, bottom, dt)
  local span = bottom - top
  if self.y > top and self.y < top + span/3 then
    self.velocity = self.velocity:move(Vector(100, 200), dt)
  end

  if self.y > top + span/3 and self.y < top + (2 * span/3) then
    self.velocity = self.velocity:move(Vector(100, 0), dt)
  end

  if self.y > top + (2 * span/3) and self.y < bottom then
    self.velocity = self.velocity:move(Vector(100, -200), dt)
  end
end

return Ball
