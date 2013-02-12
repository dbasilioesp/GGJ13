module( ..., package.seeall )
local rat = require "rat3"
local scene3 = {}

scene3.new = function ()

	local localGroup = display.newGroup()

	local label = display.newText("Welcome Scene 3", 100, 100, nil, 30)

	local myrat = rat.new("YELLOW", "LEFT")

	return localGroup

end

return scene3