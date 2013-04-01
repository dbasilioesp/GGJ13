module( ..., package.seeall )

local bar = {}
bar.new = function (color)
	
	local mybar = {
		label = display.newText("0", 30, 460, "Arial Black", 26);
		current_value = 0;
		limit_value = 100;
		charging = false;
		factor = 1;
		color = color;
		last_color = color;
	}
	
	mybar.changeLabel = function ()
		if mybar.current_value <= mybar.limit_value then
			mybar.label.text = "" .. mybar.current_value	
		end
	end

	mybar.changeByColor = function (color)

		if color == "BLUE" then
			-- Color Blue
			mybar.label:setTextColor(0,0,255,255)
		elseif color == "RED" then
			-- Color Red
			mybar.label:setTextColor(255,0,0,255)
		elseif color == "YELLOW" then
			-- Color Yellow
			mybar.label:setTextColor(255,255,0,255)
		elseif color == "GREEN" then
			-- Color Green
			mybar.label:setTextColor(0,255,0,255)
		end

	end

	mybar.changeByColor(color)

	mybar.charge = function ( value, wheel )

		mybar.current_value = mybar.current_value + (value * mybar.factor)
		
		if mybar.current_value > 100 then
			mybar.current_value = 100
		end
		
		if mybar.current_value < 0 then
			
			mybar.current_value = 0
			
			if mybar.last_color ~= mybar.color then


				mybar.color = mybar.last_color
				
				mybar.changeByColor(mybar.color)
				wheel.changeByColor(mybar.color)
				
				mybar.factor = mybar.factor * (-1)

			end
		end

		mybar.changeLabel()
	end

	return mybar

end

return bar