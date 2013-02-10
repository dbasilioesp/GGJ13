module( ..., package.seeall )

local wheel = {}
wheel.new = function (bar)
	
	local options = { width=240, height=240, numFrames=2, sheetContentWidth=480, sheetContentHeight=240 };
	local options_rodavazia = {width=240, height=240, numFrames=1, sheetContentWidth=240, sheetContentHeight=240}

	local rodavaziaAmarela = graphics.newImageSheet("asserts/wheels/RodavaziaAmarelo1.png", options_rodavazia);
	local rodavaziaVerde = graphics.newImageSheet("asserts/wheels/RodavaziaVerde1.png", options_rodavazia);
	local rodavaziaVermelha = graphics.newImageSheet("asserts/wheels/RodavaziaVermelha1.png", options_rodavazia);
	local rodavaziaAzul = graphics.newImageSheet("asserts/wheels/RodavaziaAzul1.png", options_rodavazia);

	local rodaAmarela = graphics.newImageSheet("asserts/wheels/RodaAmarela.png", options);
	local rodaAzul = graphics.newImageSheet("asserts/wheels/RodaAzul.png", options);
	local rodaVerde = graphics.newImageSheet("asserts/wheels/RodaVerde.png", options);	
	local rodaVermelha = graphics.newImageSheet("asserts/wheels/RodaVermelha.png", options);	


    local dadosSequencia = {
           {name="rodaAmarela", 	sheet=rodaAmarela, start=1, count=2, time=300, loopCount=0 },
           {name="rodaAzul", 		sheet=rodaAzul, start=1, count=2, time=300, loopCount=0 },
           {name="rodaVerde", 		sheet=rodaVerde, start=1, count=2, time=300, loopCount=0 },
           {name="rodaVermelha",	sheet=rodaVermelha, start=1, count=2, time=300, loopCount=0 },

           {name="rodavaziaAmarela",  sheet=rodavaziaAmarela, start=1, count=1, time=300, loopCount=0 },
           {name="rodavaziaAzul", 	  sheet=rodavaziaAzul, start=1, count=1, time=300, loopCount=0 },
           {name="rodavaziaVerde", 	  sheet=rodavaziaVerde, start=1, count=1, time=300, loopCount=0 },
           {name="rodavaziaVermelha", sheet=rodavaziaVermelha, start=1, count=1, time=300, loopCount=0 } 

	}
	local mywheel
	
	if bar.mytype == "BLUE" then
		mywheel = display.newSprite(rodaAzul, dadosSequencia)
	
	elseif bar.mytype == "RED" then
		mywheel = display.newSprite(rodaVermelha, dadosSequencia)
	
	elseif bar.mytype == "YELLOW" then
		mywheel = display.newSprite(rodaAmarela, dadosSequencia)
	
	elseif bar.mytype == "GREEN" then
		mywheel = display.newSprite(rodaVerde, dadosSequencia)
	end

	mywheel:scale(0.7,0.7)
	mywheel.x = -100; mywheel.y = -100
	
	mywheel.last_color = bar.mytype
	mywheel.color = bar.mytype
	mywheel.bar = bar

	physics.addBody(mywheel, "static", {density=3.0, friction=0.5,  bounce=0.0})

	local function upBar( event )
		bar.charge(1, mywheel)
	end

	mywheel.changeColor = function(color)
		if color == "BLUE" then
			mywheel:setSequence("rodaAzul")	
		elseif color == "RED" then
			mywheel:setSequence("rodaVermelha")
		elseif color == "YELLOW" then
			mywheel:setSequence("rodaAmarela")
		elseif color == "GREEN" then
			mywheel:setSequence("rodaVerde")
		end

		mywheel:play()
	end

	local function onPostCollision( event )
		
		local wheel = event.target
	    local rat = event.other

	    if ( event.phase == "began" ) then
	    	
	    	rat.isVisible = true
	    	bar.last_color = rat.cor

	    	print(bar.mytype, rat.cor)
	        if bar.mytype == rat.cor then
	        	
	        	wheel.changeColor(rat.cor)
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

        	--Runtime:removeEventListener("enterFrame", rat.moveLeft)
        	rat.stopMove()

        	rat:removeSelf()
        	rat = nil

	    elseif ( event.phase == "ended" ) then
	        print("end")
	    end
	end

	mywheel:addEventListener( "collision", onPostCollision )

	return mywheel

end

return wheel