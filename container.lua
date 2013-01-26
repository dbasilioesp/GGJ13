module( ..., package.seeall )

local container = {}
container.new = function ()
	
	container = {
		label = display.newText("0", 30, display.contentHeight - 60, native.systemFont, 26);
		current_value = 0;
		limit_value = 50
	}
	
	container.changeLabel = function ()
		container.label.text = "" .. container.current_value
	end

	container.charge = function ( value )

		container.current_value = container.current_value + value
		
		if container.current_value > 100 then
			container.current_value = 100
		end

		container.changeLabel()
	end

	return container

end

return container