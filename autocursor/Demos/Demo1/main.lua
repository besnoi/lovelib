fcursor=require 'autocursor'

function love.load() fcursor.setDestination(300,300) end

function love.update(dt) fcursor.update(dt) end

