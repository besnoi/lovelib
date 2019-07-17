local fcursor={x=0,y=0,destReached=false,clickOnDest=nil}

function fcursor:reset() fcursor={x=0,y=0,destReached=false,clickOnDest=nil} end

function fcursor:setPosition(x,y) fcursor.x,fcursor.y=x or 0,y or 0 end

function fcursor:setDestination(x,y) fcursor.destx,fcursor.desty=x,y end

--When destination is reached press a mouse btn (1 by default) [to enable touching the second arg must be true]
function fcursor:clickOnReachingDest(mousebtn,isTouch) fcursor.clickOnDest={fcursor.destx,fcursor.desty,mousebtn or 1,isTouch or false} end

--Unlike clickOnReachingDest, clickOnDest will click on the given point which may be different than the destination point
function fcursor:clickOnDest(...) fcursor.clickOnDest={...} end

function fcursor:update(stepx,stepy)
	if not fcursor.destReached then
		stepx,stepy=stepx or 1,stepy or 1

		love.mouse.setPosition(fcursor.x,fcursor.y)

		if fcursor.destx~=0 and fcursor.destx~=fcursor.x then
			fcursor.x=fcursor.x+(fcursor.x<fcursor.destx and stepx or -stepx)
		end
		if (fcursor.destx>0 and fcursor.x>fcursor.destx) or (fcursor.destx<0 and fcursor.x<fcursor.destx) then
			fcursor.x=fcursor.destx
		end
		if fcursor.desty~=0 and fcursor.desty~=fcursor.y then
			fcursor.y=fcursor.y+(fcursor.y<fcursor.desty and stepy or -stepy)
		end
		if (fcursor.desty>0 and fcursor.y>fcursor.desty) or (fcursor.desty<0 and fcursor.y<fcursor.desty) then
			fcursor.y=fcursor.desty
		end
		if fcursor.x==fcursor.destx and fcursor.y==fcursor.desty then
			if fcursor.clickOnDest then love.mousepressed(unpack(fcursor.clickOnDest)) end
			fcursor.destReached=true
		end
	end
end

function fcursor:destinationReached() return fcursor.destReached end
function fcursor:getX() return fcursor.x end
function fcursor:getY() return fcursor.y end
function fcursor:getPosition() return fcursor.x,fcursor.y end

return fcursor