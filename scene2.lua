system.activate( "multitouch" )

local scene2 = {}

scene2.new = function ( params )
	
	local localGroup = display.newGroup()
	local label = display.newText("Welcome Scene 2", 100, 100, native.systemFont, 30)
	
	localGroup:insert(label)

	return localGroup

end

return scene2
