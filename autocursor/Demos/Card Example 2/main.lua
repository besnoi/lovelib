Card=require 'Card'
fcursor=require 'autocursor'

AI_MOVES={
	{fromX=330,fromY=215,toX=530,toY=415,drag=true},
	{toX=230,toY=415}
}

function love.load()
	ace=Card:init("ace.png")
	fcursor.setSpeed(2.5,2.5)
end

function love.update(dt)
	-- this is the logic for human-controlled cursor which I think is more complicated than AI-controlled cursor
	-- if ace:isHovered() and love.mouse.isDown(1) then ace:drag() end
	fcursor.updateT(AI_MOVES,dt)
end

function love.draw()
	ace:draw()
end

function fcursor.drag() ace:drag() end
