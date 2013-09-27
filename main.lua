------------------------------------------------------------------------
------------------- STORYBOARD -----------------------------------------
--------- the main file, where the whole application starts ------------
------------------------------------------------------------------------

-- Load external libraries ---------------------------------------------
local storyboard = require "storyboard" -- standard Corona SDK library
------------------------------------------------------------------------

local theTimer

-- make a display group to hold all the display objects for easy disposal
local dispGroup = display.newGroup()

-- function to be called which will go to the menu and destroy all the display objects in thie script
local nextScene = function()
	storyboard.gotoScene("menu") -- go the "menu"
	dispGroup:removeSelf() -- destroy display
	dispGroup = nil -- free up some memory
end


---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
------------------------ This portion is the pre-game animation -----------------------------
---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
local function move()
square = display.newRect( 0, 0, 100, 100 ) -- create a new rectangle
square:setFillColor( 255,255,255 ) -- give it some color
dispGroup:insert(square) -- add it to the display group
 
-- store w and h with the width and height of the screen (?)
local w,h = display.contentWidth, display.contentHeight
 
square2 = display.newRect( 0, 0, 100, 100 ) -- a second rectangle of same size
square2:setFillColor( 255,255,255 ) -- and same color
dispGroup:insert(square2) -- and add it to the display group
 
local w,h = display.contentWidth, display.contentHeight
 
-- (1) move square2 to bottom right corner; subtract half side-length
--     b/c the local origin is at the square's center; fade out square2
transition.to( square, { time=500, alpha=1.0, x=(w-10), y=(h-10) } )
 
-- (2) fade square2 back in after 2.5 seconds
transition.to( square, { time=500, delay = 0, alpha=0 } )

-- (3) square (the first square) never moves or animates
end

---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------


move() -- call the animation function
theTimer = timer.performWithDelay(1000, nextScene, 1) -- give the animation one second to run before called the nextScene function