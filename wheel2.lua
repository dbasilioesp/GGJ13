module( ..., package.seeall )

local WheelClass = {}
WheelClass.new = function (bar)

	local wheel
	local option
	
	options = { 
		width=240, height=240, numFrames=2, sheetContentWidth=480, sheetContentHeight=240 
	};

	options_rodavazia = {
		width=240, height=240, numFrames=1, sheetContentWidth=240, sheetContentHeight=240
	}

	local wheelEmptyYellow  = graphics.newImageSheet("asserts/wheels/RodavaziaAmarelo1.png", options_rodavazia);
	local wheelEmptyBlue    = graphics.newImageSheet("asserts/wheels/RodavaziaAzul1.png", options_rodavazia);
	local wheelEmptyGreen   = graphics.newImageSheet("asserts/wheels/RodavaziaVerde1.png", options_rodavazia);
	local wheelEmptyRed	 	= graphics.newImageSheet("asserts/wheels/RodavaziaVermelha1.png", options_rodavazia);

	local wheelYellow = graphics.newImageSheet("asserts/wheels/RodaAmarela.png", options);
	local wheelBlue   = graphics.newImageSheet("asserts/wheels/RodaAzul.png", options);
	local wheelGreen  = graphics.newImageSheet("asserts/wheels/RodaVerde.png", options);	
	local wheelRed    = graphics.newImageSheet("asserts/wheels/RodaVermelha.png", options);

	local sequence = {

       {name="wheelYellow", 	sheet=wheelYellow, start=1, count=2, time=300, loopCount=0 },
       {name="wheelBlue", 		sheet=wheelBlue, start=1, count=2, time=300, loopCount=0 },
       {name="wheelGreen", 		sheet=wheelGreen, start=1, count=2, time=300, loopCount=0 },
       {name="wheelRed",	    sheet=wheelRed, start=1, count=2, time=300, loopCount=0 },

       {name="wheelEmptyYellow",  sheet=wheelEmptyYellow, start=1, count=1, time=300, loopCount=0 },
       {name="wheelEmptyRed", 	  sheet=wheelEmptyRed, start=1, count=1, time=300, loopCount=0 },
       {name="wheelEmptyGreen",   sheet=wheelEmptyGreen, start=1, count=1, time=300, loopCount=0 },
       {name="wheelEmptyBlue",    sheet=wheelEmptyBlue, start=1, count=1, time=300, loopCount=0 } 

	}

	wheel = display.newSprite(wheelEmptyYellow, sequence)
	
	wheel:scale(0.7,0.7)
	wheel.last_color = bar.color
	wheel.color = bar.color
	wheel.bar = bar
	
	physics.addBody(wheel, "static", {density=3.0, friction=0.5,  bounce=0.0})

	wheel.changeByColor = function(color)

		print ("Change wheel to color: ", color)

		if color == "BLUE" then
			wheel:setSequence("wheelBlue")
		elseif color == "RED" then
			wheel:setSequence("wheelRed")
		elseif color == "YELLOW" then
			wheel:setSequence("wheelYellow")
		elseif color == "GREEN" then
			wheel:setSequence("wheelGreen")
		end

		wheel:play()
	end

	wheel.upBar = function( event )
		bar.charge(1, wheel)
	end

	wheel.onPostCollision = function( event )

		local _wheel = event.target
	    local rat = event.other
		
	    if ( event.phase == "began" ) then
	    	
	    	rat.isVisible = true
	    	bar.last_color = rat.color
	    	
	    	--> Increase the points	
	        if bar.color == rat.color then
	        	_wheel.changeByColor(rat.color)
	        	bar.factor = bar.factor + 1
	        --> Decrease the points and change the last color
			else
				
				if bar.factor > 0 then
					bar.factor = bar.factor * -1
				else
					bar.factor = -1
				end

			end

			if not bar.charging then
				bar.charging = true
        		bar.timer = timer.performWithDelay( 1000, _wheel.upBar, 0)
        	end

        	rat.removeIt()

	    end
	end

	wheel:addEventListener("collision", wheel.onPostCollision)

	return wheel

end

return WheelClass