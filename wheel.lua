module( ..., package.seeall )

local wheel = {}
wheel.new = function (bar, container)
	
	local mywheel = display.newCircle(0, 0, 60)
	
	mywheel:setFillColor(255, 102, 102, 255)
	mywheel.last_color = bar.mytype
	physics.addBody(mywheel, "static", {density=3.0, friction=0.5,  bounce=0.3})

	local function upBar( event )
		bar.charge(1)
	end

	local function onPostCollision( event )
		
	    if ( event.phase == "began" ) then
	    	
	    	local rat = event.other
	    	rat.isVisible = false
	    	bar.last_color = rat.cor
	        if bar.mytype == rat.cor then

	        	if not bar.charging then
	        		bar.timer = timer.performWithDelay( 100, upBar, 0)
	        	end
				
				bar.charging = true
				bar.factor = bar.factor + 1

			
			else
				
				bar.last_color = rat.cor

				if bar.factor > 0 then
					bar.factor = bar.factor * -1	
				else
					bar.factor = -1
				end
				
			end

	    elseif ( event.phase == "ended" ) then
	        
	    end
	end

	local function onTap ( event )
		container.charge(bar.current_value)
		bar.current_value = 0
		bar.changeLabel()
	end

	mywheel:addEventListener( "collision", onPostCollision )
	Runtime:addEventListener( "tap", onTap)
	--local function onTapWheel(event)

		
		--elseif bar.charging then

			--if "vermelho" ~= "azul" then
			--	bar.factor = -1
			--end

		--end

    --end
 
 	--mywheel:addEventListener("tap", onTapWheel)

	return mywheel

end

return wheel