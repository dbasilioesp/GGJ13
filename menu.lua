system.activate( "multitouch" )
local physics = require "physics"

local menu = {}

menu.new = function (params)

	local localGroup = display.newGroup()
	local ui = require("ui")

	local loadphase = function()

		physics.start()
		physics.setDrawMode("normal")
		physics.setGravity(0,0)

		local musica = audio.loadSound("asserts/sounds/intro.ogg")
		local mus = audio.play(musica, {loops = -1})

		local img = display.newImage("asserts/intro_menu/Logo&Menu2.png", true)
		img:setReferencePoint(display.TopLeftReferencePoint)
		img.x = 0
		img.y = 0
		isLocked = false

		local play = display.newRect(410,335,345,75)
			play.myName = "play"
			play.alpha = 1.0
			physics.addBody( play , { friction = 1.0 , isSensor = true } )

		local opts = display.newRect(500,430,345,75)
			opts.myName = "opts"
			opts.alpha = 1.0
			physics.addBody( opts , { friction = 1.0 , isSensor = true } )

		local cred = display.newRect(640,530,345,75)
			cred.myName = "cred"
			cred.alpha = 1.0
			physics.addBody( cred , { friction = 1.0 , isSensor = true } )

		local exit = display.newRect(720,620,345,75)
			exit.myName = "exit"
			exit.alpha = 1.0
			physics.addBody( exit , { friction = 1.0 , isSensor = true } )


		local function onPlayTouch ( event )
			
			if event.phase == "ended" and event.target.myName == "play" then	
				audio.pause(mus)			
				director:changeScene( "intro",  "crossfade" )				
			end

			if event.phase == "ended" and event.target.myName == "opts" then
				director:changeScene( "opts", "crossfade" )
			end

			if event.phase == "ended" and event.target.myName == "cred" then				
				director:changeScene( "creditos", "crossfade" )
			end

			if event.phase == "ended" and event.target.myName == "exit" then				
				os.exit()								
			end

		end
	
		play:addEventListener("touch", onPlayTouch)
		opts:addEventListener("touch", onPlayTouch)
		cred:addEventListener("touch", onPlayTouch)
		exit:addEventListener("touch", onPlayTouch)

	end
	
	loadphase()

	local initVars = function()

	end
	    
	initVars()

	return localGroup
end

return menu