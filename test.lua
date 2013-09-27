-----------------------------------------------------------------------
-- This is the script called when the person playing the game loses
-----------------------------------------------------------------------

-- Load external libraries ---------------------------------------------
local storyboard = require "storyboard" -- standard Corona SDK library
------------------------------------------------------------------------

-- create an object called scene which is a scene object of storyboard
local scene = storyboard.newScene()

function scene:enterScene( event ) -- function to be called when the scene "enters"

	-- draw the image
	local disp = display.newImage("Pictures/loser.png", 0, 0, true)
	disp.x = 160 disp.y = 170 -- set the image's location
	
	function click( event ) -- function to be called when the loser button is touched
		--NO TOUCHY
		local t = event.target
		local phase = event.phase
		------------------------
	
		if "began" == phase then
			storyboard.gotoScene( "menu") -- when the loser button is touched go back to the menu
			disp:removeSelf() -- and destroy all display/listeners in this script
		end
	end
	
	disp:addEventListener( "touch", click) -- add a listener to the loser button AKA "disp"
end

scene:addEventListener( "enterScene", scene) -- give this scene a listener for when it enters

return scene -- return this script as a scene object