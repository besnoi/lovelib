local Card={}

function Card:init(filename)
	local obj={x=330,y=315,img=love.graphics.newImage(filename)}
	setmetatable(obj,self)
	self.__index=self
	self.x,self.y,self.img=obj.x,obj.y,obj.img
	return self
end

function Card:click()
	self.img=love.graphics.newImage("back.png")
end

function Card:isHovered()
	return love.mouse.getX()>self.x and love.mouse.getX()<self.x+140 and love.mouse.getY()>self.y and love.mouse.getY()<self.y+190
end

function Card:draw()
	love.graphics.draw(self.img,self.x,self.y)
end

return Card