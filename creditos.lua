system.activate( "multitouch" )

local cred = {}

cred.new = function ( params )
	local localGroup = display.newGroup()

	local loadphase = function()
		
		local volta = display.newImage("asserts/intro_menu/CoracaoIcone.png", true)
		volta.x = 950
		volta.y = 630

		local function onPlayTouch ( event )
			if event.phase == "ended" then

				director:changeScene( "menu",  "crossfade" )

			end
		end

		volta:addEventListener("touch", onPlayTouch)

		local creditos_image = display.newImage("asserts/creditos.png")
		creditos_image.x = display.contentWidth/2
		creditos_image.y = display.contentHeight/2
	end

	loadphase()

	local initVars = function()

	end
	    
	initVars()

	return localGroup

end

return cred
