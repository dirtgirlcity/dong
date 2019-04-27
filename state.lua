local stateClass = { }
stateClass.__index = stateClass

local function State()
  local instance = {
    entities = { },
    score = {
      player1 = 0,
      player2 = 0
    }
  }
  setmetatable(instance, stateClass)
  return instance
end

function stateClass:addPoint(edge)
  if edge == "right" then
    self.score.player1 = self.score.player1 + 1
  end
  if edge == "left" then
    self.score.player2 = self.score.player2 + 1
  end
end

return State()
