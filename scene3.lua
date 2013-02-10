module( ..., package.seeall )

local scene3 = {}

scene3.new = function ()

	local localGroup = display.newGroup()

	local label = display.newText("Welcome Scene 3", 100, 100, nil, 30)

	return localGroup

end

return scene3