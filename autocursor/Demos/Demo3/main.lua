fcursor=require 'autocursor'

function love.load()
	fcursor:setDestination(200,200)
	fcursor:enableDragging()
end

function love.update(dt)
	fcursor:update(5,5)
end

function love.mousepressed(...) print("CLICKED!!!",...) end
