--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------  C O N T E N T S  --------------------------------------------

-- Imports
-- variable declarations
-- score display set up
-- functions
-- pre-game animation
-- draw background
-- draw tiles
-- method call
-- add listeners

--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------

-- load in external libraries ---------------------------------------------------------------------------
local ui = require( "ui" ) -- a file
local storyboard = require( "storyboard" ) -- standard Corona SDK library
local menu = require ( "menu")
---------------------------------------------------------------------------------------------
------------------------------  being implementation ----------------------------------------
---------------------------------------------------------------------------------------------

-- make an object called scene which is going to be a "scene" in the "storyboard"
local scene = storyboard.newScene()

function scene:enterScene( event ) -- function called when the scene enters

	print("entering scene") -- print to the console
	media.playSound(fileList[index]) -- play the song of the selected index
	
	-- basic necessary boolean variables
	clickNum = 0 -- clickNum is the number for what you click: 1 = green, 2 = blue, 3 = red, 4 = yellow
	flashyflash = 0 -- number for what tile is lit up
	buttonY = 60 -- the standard Y distance for some of the buttons....
	
	-- dont worry about these variables, ideas in progress
	combo = 0
	answered = false
	test=1
	lose = false
	
	-- boolean variables to inidicate if it is the first time the player hit that combo stage, to avoid redrawing the rectangles and
	-- to also avoid stack overflow errors
	firstStage = false
	secondStage = false
	thirdStage = false
	local tilePicked = false
	
	-- Variable to hold what difficulty the player is at
	difficulty = 1
	
	group = display.newGroup() -- initiate the display group that is going to contain all the images
	
	--initialize the variables for the three combo inidicators to avoid nil errors
	local rect1 = display.newRect( 0, 0, 70, 70 )
	rect1:setFillColor( 0, 255, 255)
	rect1.x = 80 rect1.y = 450 rect1.alpha = 0 -- set the location and make it clear
	group:insert(rect1)
	local rect2 = display.newRect( 0, 0, 70, 70 )
	rect2:setFillColor( 0, 255, 255)
	rect2.x = 160 rect2.y = 450 rect2.alpha = 0 -- set the location and make it clear
	group:insert(rect2)
	local rect3 = display.newRect(0, 0, 70, 70)
	rect3:setFillColor( 0, 255, 255)
	rect3.x = 240 rect3.y = 450 rect3.alpha = 0 -- set the location and make it clear
	group:insert(rect3)
	
	ran = math.random(4) -- random number from 1 to 4 which will control which tile will light up

	-- A L L   F U N C T I O N S-------------------------------------------------------------0------------------
	local function destroyCombo() -- remove all the combo stuffs
		transition.to( rect1, { time=500, delay = 0, alpha=0} ) -- animation to fade it out of view
		transition.to( rect2, { time=500, delay = 0, alpha=0} ) -- animation to fade it into view
		transition.to( rect3, { time=500, delay = 0, alpha=0} ) -- animation to fade it into view
		firstStage = false
		secondStage = false
		thirdStage = false
	end
	
	local function randomPlay() -- set randomly which signal will be lit up
		print(test) -- stuff for my use, dont worry about it
		test = test+1
		ran = math.random(4)
		
		-- Generally assuming that there was a flashed tile, this redraws all the little buttons back to normal. A little excessive. Needs to be optimized
		miniGreen = display.newImage("Pictures/green.png", 0, 0, true)
		miniGreen.x = 40; miniGreen.y = buttonY; miniGreen.rotation = 0
		miniGreen:scale(.14, .14)
		group:insert(miniGreen)
					
		miniBlue = display.newImage("Pictures/blue.png", 0, 0, true)
		miniBlue.x = 280; miniBlue.y = buttonY; miniBlue.rotation=0
		miniBlue:scale(.14, .14)
		group:insert(miniBlue)
					
					
		miniRed = display.newImage("Pictures/red.png", 0, 0, true)
		miniRed.x = 200; miniRed.y = buttonY; miniRed.rotation=0
		miniRed:scale(.14, .14)
		group:insert(miniRed)
					
							
		miniYellow = display.newImage("Pictures/yellow.png", 0, 0, true)
		miniYellow.x = 120; miniYellow.y = buttonY; miniYellow.rotation = 0
		miniYellow:scale(.14, .14)
		group:insert(miniYellow)
					
		----------------------------
		answered = false -- dont worry about this variable too, something in production
		
		-- select a random little tile to "light up" (insert a different pic in front) based on the variable 'ran' which is a random number from 1 to 4
		if ran == 1 then
			miniGreen = display.newImage("Pictures/greenFlash.png", 0, 0, true)
			miniGreen.x = 40; miniGreen.y = buttonY; miniGreen.rotation = 0
			miniGreen:scale(.14, .14)
			flashyflash = 1
			group:insert(miniGreen)
		end

		if ran == 2 then
			miniBlue = display.newImage("Pictures/blueFlash.png", 0, 0, true)
			miniBlue.x = 280; miniBlue.y = buttonY; miniBlue.rotation=0
			miniBlue:scale(.14, .14)
			flashyflash = 2
			group:insert(miniBlue)
		end

		if ran == 3 then
			miniRed = display.newImage("Pictures/redFlash.png", 0, 0, true)
			miniRed.x = 200; miniRed.y = buttonY; miniRed.rotation=0
			miniRed:scale(.14, .14)
			flashyflash = 3
			group:insert(miniRed)
		end

		if ran == 4 then
			miniYellow = display.newImage("Pictures/yellowFlash.png", 0, 0, true)
			miniYellow.x = 120; miniYellow.y = buttonY; miniYellow.rotation = 0
			miniYellow:scale(.14, .14)
			flashyflash = 4
			group:insert(miniYellow)
		end
		if(tilePicked == false) then -- checks to see if the User has picked a tile before advancing
			-- DEDUCTS POINTS FOR NOT CHOOSING A TILE -- 
			if score < 20 then
						combo = 0 -- reset the combo streak
						destroyCombo()
						score = score - 1 -- subtract one from the score
						scoreDisplay:setText(score) -- redisplay the score
						print("incorrect! score -1") -- print out to the console for debugging purposes
			end
			if (score >= 20 and score < 50) then 
						combo = 0 -- reset the combo streak
						destroyCombo()
						score = score - 4 -- subtract four from the score
						scoreDisplay:setText(score) -- redisplay the score
						print("incorrect! score -4") -- print out to the console for debugging purposes
			end
			if (score >= 50 and score < 100) then
						combo = 0 -- reset the combo streak
						destroyCombo()
						score = score - 8 -- subtract eight from the score
						scoreDisplay:setText(score) -- redisplay the score
						print("incorrect! score -8") -- print out to the console for debugging purposes
			end
			
			if score <= 0 then -- and if the score is less than or equal to 0
					print("YOU LOSE") -- print out to the console for debugging purposes
					lose = true -- dont worry about this variable, idea in progress
					--------------------------------------------------------------------------------------
					---------- FIGURE OUT WAY TO REMOVE EVENT LISTENERS ----------------------------------
					--------------------------------------------------------------------------------------
					media.stopSound() -- stop the music
					-- destroy everything
					group:removeSelf()
					group = nil
					
					-- go to the next "scene" which is the screen telling you that you lost
					storyboard.gotoScene("test")
					return
			end
		end
		tilePicked = false -- resets the tilePicked variable
		timer.performWithDelay(bpm[index]*2, randomPlay, 1)
	end

	local function draw() -- a function to draw everything. No fancy stuff here
		
		score = 10 -- initial score is 0
		
		-- Make the background ------------------------------------------------------------------------------
		local background = display.newImage("Pictures/bg.png", 0, 0, true) -- make the background object
		background:scale(.6, .61) -- scale the picture down some so that it fits nicely on the screen ( was initially too big)
		background.x = display.contentWidth / 2 -- ... I'll get around to this
		background.y = display.contentHeight / 2
		group:insert(background) -- add background to the display group
	
		-- Draw all the tiles ----------------------------------------------------------
		blueButton = display.newImage("Pictures/blue.png", 0, 0, true) -- Make the big blue tile
		blueButton.x = 240; blueButton.y = 325; blueButton.rotation=0 -- set the location and rotation
		blueButton:scale(.5, .5) -- make the picture smaller
		group:insert(blueButton) -- add blueButton to the display group
	
		redButton = display.newImage("Pictures/red.png", 0, 0, true) -- make the big red tile
		redButton.x = 240; redButton.y = 170; redButton.rotation=0 -- set the location and rotation
		redButton:scale(.5, .5) -- make the picture smaller
		group:insert(redButton) -- add redButton to the display group

		yellowButton = display.newImage("Pictures/yellow.png", 0, 0, true) -- make the big yellow tile
		yellowButton.x = 80; yellowButton.y = 325; yellowButton.rotation=0 -- set the location and rotation
		yellowButton:scale(.5, .5) -- make the picture smaller
		group:insert(yellowButton) -- add yellowButton to the display group

		greenButton = display.newImage("Pictures/green.png", 0, 0, true) -- make the big green tile
		greenButton.x = 80; greenButton.y = 170; greenButton.rotation=0 -- set the location and rotation
		greenButton:scale(.5, .5) -- make the picture smaller
		group:insert(greenButton) -- add greenButton to the display group

		-- DISPLAY OF THE LITTLE BUTTONS ---------------------------------------------------------------
		miniBlue = display.newImage("Pictures/blue.png", 0, 0, true) -- make the little blue button (uses same image as the blue tile)
		miniBlue.x = 280; miniBlue.y = buttonY; miniBlue.rotation=0 -- set the location and rotation
		miniBlue:scale(.14, .14) -- make the picture even smaller
		group:insert(miniBlue) -- add miniBlue to the display group
	
		miniRed = display.newImage("Pictures/red.png", 0, 0, true) -- make the little red button (uses same image as the red tile)
		miniRed.x = 200; miniRed.y = buttonY; miniRed.rotation=0 -- set the location and rotation
		miniRed:scale(.14, .14) -- make the picture even smaller
		group:insert(miniRed) -- add miniRed to the display group
	
		miniGreen = display.newImage("Pictures/green.png", 0, 0, true) -- make the little green button (uses the same image as the green tile)
		miniGreen.x = 40; miniGreen.y = buttonY; miniGreen.rotation = 0 -- set the location and rotation
		miniGreen:scale(.14, .14) -- make the picture even smaller
		group:insert(miniGreen) -- add miniGreen to the display group
		
		miniYellow = display.newImage("Pictures/yellow.png", 0, 0, true) -- make the little yellow button (uses the same image as the yellow tile)
		miniYellow.x = 120; miniYellow.y = buttonY; miniYellow.rotation = 0 -- set the location and rotation
		miniYellow:scale(.14, .14) -- make the picture even smaller
		group:insert(miniYellow) -- add miniYellow to the display group
		
		scoreDisplay = ui.newLabel{ -- initialize the score display
			bounds = { display.contentWidth - 120, 10 + display.screenOriginY, 100, 24 }, -- align label with right side of current screen
			text = "0", -- not sure what this is
			size = 15, -- size of the text
			align = "right" -- align the score display with the right side of the screen
		}
		
		group:insert(scoreDisplay) -- Add scoreDisplay to the display group
		
		scoreDisplay:setText( score ) -- set the text to display the initial 0
	end
	
		local function difficultyTwo() -- redraw the tiles in random locations
		ranSet = math.random(4)
		if ranSet == 1 then
			blueButton.x = 80 blueButton.y = 325
			redButton.x = 80 redButton.y = 170
			greenButton.x = 240 greenButton.y = 170
			yellowButton.x = 240 yellowButton.y = 325
		end
		if ranSet == 2 then
			blueButton.x = 80 blueButton.y = 170
			redButton.x = 240 redButton.y = 325
			greenButton.x = 240 greenButton.y = 170
			yellowButton.x = 80 yellowButton.y = 325
		end
		if ranSet == 3 then
			blueButton.x = 240 blueButton.y = 325
			redButton.x = 240 redButton.y = 325
			greenButton.x = 80 greenButton.y = 170
			yellowButton.x = 80 yellowButton.y = 170
		end
		if ranSet == 4 then
			blueButton.x = 80 blueButton.y = 325
			redButton.x = 240 redButton.y = 170
			greenButton.x = 240 greenButton.y = 170
			yellowButton.x = 80 yellowButton.y = 325
		end
	end
	
	local function listener(clickNum) -- what happens whenever you click a tile
		return function( event )
	
			-- NO TOUCHY ---------------
			local t = event.target    -- no idea what this does, but messing with it messes up the listener. gotta look into this
			local phase = event.phase --
			----------------------------
		
			tilePicked = true --records that the User has picked a tile
		
			if "began" == phase then -- not quite sure what this means either....
			
				print("-----------------------------------------------------------------------------")
				answered = true -- dont worry about this variable
				if clickNum == flashyflash then -- if the tile clicked matches the random tile lit up...
					combo = combo + 1       -- increase the combo streak
					---combo points added depending on stages---
					if combo <=5 then --- COMBO STAGE ONE --- 
						if firstStage == false then --this indicates it's the first time the person is hitting stage one
							transition.to( rect1, { time=500, delay = 0, alpha=1} ) -- animation to fade it into view
							firstStage = true -- flip the boolean
						end
						score = score + 1	-- add one to the score with no combo bonus
						scoreDisplay:setText(score) -- redisplay the scoreboard
						print("correct! score+1...combo stage 1!") -- print out the console for debugging purposes
					end
					if combo > 5 and combo <= 15 then --- COMBO STAGE TWO ---
						if secondStage == false then -- indicates if it is the first time the player is hitting stage two
							transition.to( rect2, { time=500, delay = 0, alpha=1} ) -- animation to fade it into view
							secondStage = true -- flip the boolean
						end
						score = score + 3	-- add three to the score with combo bonus
						scoreDisplay:setText(score) -- redisplay the scoreboard
						print("correct! score+3...combo stage 2!") -- print out the console for debugging purposes
						if score > 50 then
							difficultyTwo()
						end
					end
					if combo > 15 and combo <= 30 then --- COMBO STAGE THREE ---
						if thirdStage == false then -- indicates if it's the first time the player is hitting stage three
							transition.to( rect3, { time=500, delay = 0, alpha=1} ) -- animation to fade it into view
							thirdStage = true -- flip the boolean
						end
						score = score + 5	-- add five to the score with combo bonus
						scoreDisplay:setText(score) -- redisplay the scoreboard
						print("correct! score+5...combo stage 3!") -- print out the console for debugging purposes
					end
					
					-------------------------------------------------------------------------------
					
					local myIndex = t.myIndex -- not sure what this does.....
					
				else -- if they click the wrong tile...
					if score < 20 then
						combo = 0 -- reset the combo streak
						destroyCombo()
						score = score - 1 -- subtract one from the score
						scoreDisplay:setText(score) -- redisplay the score
						print("incorrect! score -1") -- print out to the console for debugging purposes
					end
					if (score >= 20 and score < 50) then 
						combo = 0 -- reset the combo streak
						destroyCombo()
						score = score - 4 -- subtract four from the score
						scoreDisplay:setText(score) -- redisplay the score
						print("incorrect! score -4") -- print out to the console for debugging purposes
					end
					if (score >= 50 and score < 100) then
						combo = 0 -- reset the combo streak
						destroyCombo()
						score = score - 8 -- subtract eight from the score
						scoreDisplay:setText(score) -- redisplay the score
						print("incorrect! score -8") -- print out to the console for debugging purposes
					end
					
					if score <= 0 then -- and if the score is less than or equal to 0
						print("YOU LOSE") -- print out to the console for debugging purposes
						lose = true -- dont worry about this variable, idea in progress
						--------------------------------------------------------------------------------------
						---------- FIGURE OUT WAY TO REMOVE EVENT LISTENERS ----------------------------------
						--------------------------------------------------------------------------------------
						media.stopSound() -- stop the music
						-- destroy everything
						group:removeSelf()
						group = nil
						
						-- go to the next "scene" which is the screen telling you that you lost
						storyboard.gotoScene("test")
						return
					end
				end
			end
		end
	end

	---------------------------------------------------------------------------------------------------------------
	
	draw() --method to draw the scene

	randomPlay()

	-- ASSIGN LISTENERS ------------------------------------------------------------------
	greenButton:addEventListener( "touch", listener(1)) -- Assign listener for when someone "touches" the green tile
	blueButton:addEventListener( "touch", listener(2)) -- Assign listener for when someone "touches" the blue tile
	redButton:addEventListener( "touch", listener(3)) -- Assign listener for when someone "touches" the red tile
	yellowButton:addEventListener( "touch", listener(4)) -- Assign listener for when someone "touches" the yellow tile
end

scene:addEventListener( "enterScene", scene ) -- listener for when the scene is entered

return scene -- return this whole script as a scene object