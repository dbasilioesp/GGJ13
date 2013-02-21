module( ..., package.seeall )

local WheelClass = {}
WheelClass.new = function (bar)

	local wheel = {}
	local option

	local init = function()

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

		wheel.sprite = display.newSprite(wheelEmptyYellow, sequence)
		wheel.sprite.changeByColor = changeByColor

		wheel.sprite:scale(0.7,0.7)
		wheel.sprite.last_color = bar.mytype
		wheel.sprite.color = bar.mytype
		wheel.sprite.bar = bar
		
		physics.addBody(wheel.sprite, "static", {density=3.0, friction=0.5,  bounce=0.0})

		wheel.sprite:addEventListener("collision", wheel.onPostCollision)

	end

	function changeByColor (self, color)

		print ("Change to color: " .. color)

		if color == "BLUE" then
			self:setSequence("wheelBlue")
		elseif color == "RED" then
			self:setSequence("wheelRed")
		elseif color == "YELLOW" then
			self:setSequence("wheelYellow")
		elseif color == "GREEN" then
			self:setSequence("wheelGreen")
		end

		self:play()
	end
	
	wheel.onPostCollision = function( event )

		local wheel = event.target
	    local rat = event.other
		print ("Collision: wheel " .. wheel.color .. " - rat " .. rat.color)

	    if ( event.phase == "began" ) then
	    	
	    	rat.isVisible = true
	    	bar.last_color = rat.cor

	        if bar.mytype == rat.cor then
	        	
	        	wheel:changeColor(rat.cor)
				bar.factor = bar.factor + 1
			else
				
				bar.last_color = rat.cor

				if bar.factor > 0 then
					bar.factor = bar.factor * -1
				else
					bar.factor = -1
				end
				
			end

			if not bar.charging then
				bar.charging = true
        		bar.timer = timer.performWithDelay( 1000, upBar, 0)
        	end

	    end
	end

	init()
	return wheel

end

return WheelClass