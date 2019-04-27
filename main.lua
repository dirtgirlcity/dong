local Ball = require('ball')
local Player = require('player')
local state = require('state')

function love.load()
	love.graphics.setBackgroundColor(0, 0, 0)
	love.window.setTitle("dong")

  local ball = Ball()
  local player1 = Player({
    num = 1,
    up = 'up',
    down = 'down'
  })
  local player2 = Player({
    num = 2,
    up = 'w',
    down = 's'
  })

  table.insert(state.entities, ball)
  table.insert(state.entities, player1)
  table.insert(state.entities, player2)
end

function love.draw()
  for _, entity in ipairs(state.entities) do
    entity:draw()
  end
end

function love.update(dt)
	for _, entity in ipairs(state.entities) do
		entity:update(dt)
	end
end
