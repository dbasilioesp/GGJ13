display.setStatusBar( display.HiddenStatusBar )

local director = require("director")

local mainGroup = display.newGroup()

local main = function ()
		
	mainGroup:insert(director.directorView)
	
	director:changeScene("scene2")
	
	return true
end

main()