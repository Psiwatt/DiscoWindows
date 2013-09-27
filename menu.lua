-----------------------------------------------------
-- this file is the "menu". All it has at the moment is a play button
-----------------------------------------------------

-- load external libraries ---------------------------------------------------
local storyboard = require "storyboard" -- standard Corona SDK library
------------------------------------------------------------------------------

-- make an object called scene which is a scene object of the storyboard
local scene = storyboard.newScene()

----------------------------- MAKE AN ARRAY OF ALL THE SONGZ AND THEIR NAMEZ----------------------------------
fileList = {}
songList = {}
bpm = {}

fileList[0] = "Music/ACDC - Highway to hell.mp3" songList[0] = "Highway to Hell by ACDC" bpm[0] = 513
fileList[1] = "Music/Arctic Monkeys -  Fluorescent Adolescent.mp3" songList[1] = "Fluorescent Adolescent by Arctic Monkeys" bpm[1] = 1000
fileList[2] = "Music/cold_play_-_viva_la_vida.mp3" songList[2] = "Viva la Vida by Coldplay" bpm[2] = 1000
fileList[3] = "Music/Daft Punk - Harder, Better, Faster, Stronger.mp3" songList[3] = "Harder, Better, Faster, Stronger by Daft Punk" bpm[3] = 1000
fileList[4] = "Music/Bass_Cannon_-_Flux_Pavilion.mp3" songList[4] = "Bass Cannon by Flux Pavilion" bpm[4] = 1000

--------------------------------------------------------------------------------------------------------------
index = 0 -- will be used to reference the arrays and the songs



function scene:enterScene( event ) -- function to be called when the scene "enters"
	local group = display.newGroup() -- a group to round up and hold all diplay objects
	local playButton = display.newImage("Pictures/playbutton.png", 0, 0, true) -- draw the image
	playButton.x = 160 playButton.y = 100 -- set the image location
	group:insert(playButton) -- add the playButton to the display group
	
	local comment = display.newText("Select your Song!",35,255,250,50,nil, 30) -- just some helpful text set right above the song selector
	group:insert(comment) -- add to the display group

	--Sets up the buttons that will allow the user to pick a song--
	local songButton = display.newText(songList[0],35,300,250,100,nil, 30) -- position and display song choice
	group:insert(songButton) -- add to the display group
	local nextButton = display.newRect(290, 300, 30, 100) -- position and display next song button
	nextButton:setFillColor(72, 157, 243) -- set color of next song button
	group:insert(nextButton) -- add to the display group
	local prevButton = display.newRect(0, 300, 30, 100) -- position and display previous song button
	prevButton:setFillColor(72, 157, 243) -- set color of previous song button
	group:insert(prevButton) -- add to the display group

	local function clickBack( event )
	--NO TOUCHY
		local t = event.target
		local phase = event.phase
		------------------------
		
		if "began" == phase then
		if index == 0 then -- if you hit the end of the array...
			index = table.getn(fileList) -- go back to the beginning
		else -- otherwise continue to increase the index
			index = index-1
		end
			group:remove(songButton) -- remove the songButton from the display group to avoid stack overflow
			songButton:removeSelf() -- removes the songButton in order to be replaced in the next line
			songButton = display.newText(songList[index], 35, 300,250,100,nil, 30) -- position and display next song choice
			group:insert(songButton) -- add the new songButton to the display group
		end
	end
	
	local function clickNext( event ) -- called when the next song button is touched
		--NO TOUCHY
		local t = event.target
		local phase = event.phase
		------------------------
		
		if "began" == phase then
		if index == table.getn(songList) then -- if you hit the end of the array...
			index = 0 -- go back to the beginning
		else -- otherwise continue to increase the index
			index = index+1
		end
			group:remove(songButton) -- remove the songButton from the display group to avoid stack overflow
			songButton:removeSelf() -- removes the songButton in order to be replaced in the next line
			songButton = display.newText(songList[index], 35, 300,250,100,nil, 30) -- position and display next song choice
			group:insert(songButton) -- add the new songButton to the display group
		end
	end

	local function listenerEvent( event ) -- called when the play button is touched
		--NO TOUCHY
		local t = event.target
		local phase = event.phase
		------------------------
	
		if "began" == phase then
			group:removeSelf()
			group = nil
			storyboard.gotoScene( "gameScene") -- go the "gameScene" which is the actual game portion
		end
	end	
	
	playButton:addEventListener( "touch", listenerEvent) -- add a listener for when someone touches the playButton, go to the function listenerEvent
	nextButton:addEventListener( "touch", clickNext) -- add a listener for when someone touches the nextButton
	prevButton:addEventListener( "touch", clickBack) -- add a listener for when someone touches the prevButton
end

scene:addEventListener( "enterScene", scene) -- give the scene a listener for when it enters

return scene -- return the script as a scene object
