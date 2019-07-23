Card=require 'Card'
fcursor=require 'autocursor'

AI_MOVES={
	{toX=400,toY=400,clickOnDest=1,speedX=2.5,speedY=2.5},
	{toX=200,toY=200,clickOnDest=false,speedX=2,speedY=2}
}

function love.load()
	ace=Card:init("ace.png")
end

function love.update(dt)
	fcursor.updateT(AI_MOVES,dt)
end

function love.draw() ace:draw() end
function fcursor.click() print('CLICKED ON CARD') ace:click() end