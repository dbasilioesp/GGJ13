module( ..., package.seeall )

local wheel = {}
wheel.new = function (bar)
	
	local mywheel = display.newCircle(0, 0, 60)
	
	mywheel:setFillColor(255, 102, 102, 255)
	mywheel.last_color = bar.mytype
	mywheel.color = bar.mytype
	mywheel.bar = bar
	physics.addBody(mywheel, "static", {density=3.0, friction=0.5,  bounce=0.3})

	local function upBar( event )
		bar.charge(1)
	end

	local function onPostCollision( event )
		
	    if ( event.phase == "began" ) then
	    	
	    	local rat = event.other
	    	rat.isVisible = false
	    	bar.last_color = rat.cor
	    	print(bar.mytype, rat.cor)
	        if bar.mytype == rat.cor then
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
        		bar.timer = timer.performWithDelay( 100, upBar, 0)
        	end

	    elseif ( event.phase == "ended" ) then
	        
	    end
	end

	mywheel:addEventListener( "collision", onPostCollision )
	
	return mywheel

end

return wheel