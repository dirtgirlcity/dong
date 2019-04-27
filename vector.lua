local vectorClass = { }
vectorClass.__index = vectorClass

local function Vector(x, y)
  local instance = {
      x = x,
      y = y
    }
  setmetatable(instance, vectorClass)
  return instance
end

function vectorClass:move(vector, dt)
  local x = self.x + (vector.x * dt)
  local y = self.y + (vector.y * dt)

  return Vector(x, y)
end

function vectorClass:reverse(coordinate)
  if coordinate == "x" then
    return Vector(-self.x, self.y)
  end
  if coordinate == "y" then
    return Vector(self.x, -self.y)
  end
end

return Vector
