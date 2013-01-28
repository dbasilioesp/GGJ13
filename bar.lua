module( ..., package.seeall )

local bar = {}
bar.new = function (mytype)
	
	local mybar = {
		label = display.newText("0", 30, 460, native.systemFont, 26);
		current_value = 0;
		limit_value = 100;
		charging = false;
		factor = 1;
		mytype = mytype;
	}
	
	mybar.changeLabel = function ()
		if mybar.current_value <= mybar.limit_value then
			mybar.label.text = "" .. mybar.current_value	
		end
	end

	mybar.changeColor = function (color)

		if color == "AZUL" then
			-- Color Blue
			mybar.label:setTextColor(0,0,255,255)
		elseif color == "VERMELHO" then
			-- Color Red
			mybar.label:setTextColor(255,0,0,255)
		elseif color == "AMARELO" then
			-- Color Yellow
			mybar.label:setTextColor(255,255,0,255)
		elseif color == "VERDE" then
			-- Color Green
			mybar.label:setTextColor(0,255,0,255)
		end

	end

	mybar.changeColor(mytype)

	mybar.charge = function ( value, wheel )

		mybar.current_value = mybar.current_value + (value * mybar.factor)
		
		if mybar.current_value > 100 then
			mybar.current_value = 100
		end

		if mybar.current_value < 0 then
			mybar.current_value = 0
			if mybar.last_color ~= mybar.mytype then

				mybar.mytype = mybar.last_color
				mybar.changeColor(mybar.last_color)
				mybar.factor = mybar.factor * -1
				wheel.changeColor(mybar.last_color)
			end
		end

		mybar.changeLabel()
	end

	return mybar

end

return bar