flare=require 'flare'

flare("splash.jpg",{
	showText=false,
	showProgressBar=true
})

flare.onSplashOver=function() print("splash-screen over") end

--please note here that we are not overriding love.update,etc cause they are already over-rided by flare
--study second example for complete understanding

