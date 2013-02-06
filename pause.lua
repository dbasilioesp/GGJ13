module( ..., package.seeall )
local ui = require("ui")
local physics = require("physics")
local pause = {}
pause.new = function(clock_timer)

	local pauseBtn
	local resumeBtn
	local shade
	local gameIsActive = true
	local pauseBanner

	
	local onPauseTouch = function( event )

		if event.phase == "release" and pauseBtn.isActive then
			
			-- Pause the game
			
			if gameIsActive then

				gameIsActive = false
				physics.pause()
				
				local function pauseGame()
	                timer.pause( clock_timer )
	                print("timer has been paused")
	            end
	            timer.performWithDelay(1, pauseGame)

				-- SHADE
				if not shade then
					shade = display.newRect( 0, 0, display.contentWidth, display.contentHeight )
					shade:setFillColor( 0, 0, 0, 255 )
					shade.x = display.contentWidth/2; shade.y = display.contentHeight/2
				end

				shade.alpha = 0.5

				if not pauseBanner then
					pauseBanner = display.newImage("asserts/PauseBandeiras.png", 0, 0)
					pauseBanner:scale(0.5, 0.5)
					pauseBanner.x = display.contentWidth/2
					pauseBanner.y = display.contentHeight/2
					pauseBanner:toFront()
				end
				
				pauseBtn.isVisible = false
				resumeBtn.isVisible = true
				pauseBanner.isVisible = true
			
			else
				
				if shade then
					display.remove( shade )
					shade = nil
				end
				
				if not pauseBtn.isVisible then
					pauseBtn.isVisible = true
					pauseBtn.isActive = true
				end

				if resumeBtn.isVisible then
					resumeBtn.isVisible = false
					resumeBtn.isActive = false
				end

				pauseBanner.isVisible = false
				
				gameIsActive = true
				physics.start()
				
				local function resumeGame()
	                timer.resume( clock_timer )
	                print("timer has been resumed")
	            end
	            timer.performWithDelay(1, resumeGame)

			end
		end
	end
	
	pauseBtn = ui.newButton{
		defaultSrc = "asserts/PauseIcone.png",
		defaultX = 60,
		defaultY = 60,
		overSrc = "asserts/PauseIcone.png",
		overX = 60,
		overY = 60,
		onEvent = onPauseTouch,
		id = "PauseButton",
		text = "",
		font = "Helvetica",
		textColor = { 255, 255, 255, 255 },
		size = 60,
		emboss = false
	}

	pauseBtn.x = 38; pauseBtn.y = 40
	pauseBtn.isVisible = true
	pauseBtn.isActive = true

	resumeBtn = ui.newButton{
		defaultSrc = "asserts/PlayIcone.png",
		defaultX = 60,
		defaultY = 60,
		overSrc = "asserts/PlayIcone.png",
		overX = 60,
		overY = 60,
		onEvent = onPauseTouch,
		id = "PlayButton",
		text = "",
		font = "Helvetica",
		textColor = { 255, 255, 255, 255 },
		size = 60,
		emboss = false
	}

	resumeBtn.isActive = false
	resumeBtn.isVisible = false
	resumeBtn.x = 38; resumeBtn.y = 40

	return pauseBtn
end

return pause