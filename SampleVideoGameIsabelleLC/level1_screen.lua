-----------------------------------------------------------------------------------------
--
-- level1_screen.lua
-- Created by: Isabelle LC
-- Date: May 2, 2019
-- Description: This is the level 1 screen of the game.
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Use Composer Libraries
local composer = require( "composer" )
local widget = require( "widget" )

-- load physics
local physics = require("physics")

-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "level1_screen"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

-- The local variables for this scene
local bkg_image

local heart1
local heart2
local numLives = 2

local rArrow
local lArrow
local uArrow

local character

local motionx = 0
local SPEED = 7
local negativeSpeed = -9
local LINEAR_VELOCITY = -100
local GRAVITY = 7

local leftW
local topW
local rightW

local platform1
local platform2
local platform3
local platform4

local earth
local saturn
local pluto
local theplanet

local questionsAnswered = 0
-----------------------------------------------------------------------------------------
-- LOCAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- when right arrow is pressed
local function right(touch)
    motionx = SPEED
    character.xScale = 1
end

-- when left arrow is pressed
local function left(touch)
    motionx = negativeSpeed
    character.xScale = -1
end

-- when up arrow is pressed
local function up(touch)
    if (character ~= nil) then
        character:setLinearVelocity(0, LINEAR_VELOCITY)
    end
end

-- move character horizontally
local function movePlayer(event)
    character.x = character.x + motionx
end

-- stop character movement when no arrow is pushed
local function stop(event)
    if (event.phase == "ended") then
        motionx = 0
    end
end

-- add arrow event listeners
local function AddArrowEventListeners()
    rArrow:addEventListener("touch", right)
    uArrow:addEventListener("touch", up)
    lArrow:addEventListener("touch", left)
end

-- remove event listeners
local function RemoveArrowEventListeners()
    rArrow:removeEventListener("touch", right)
    uArrow:removeEventListener("touch", up)
    lArrow:removeEventListener("touch", left)
end

-- add and remove runtime listeners
local function AddRuntimeListeners()
    Runtime:addEventListener("enterFrame", movePlayer)
    Runtime:addEventListener("touch", stop)
end

local function RemoveRuntimeListeners()
    Runtime:removeEventListener("enterFrame", movePlayer)
    Runtime:removeEventListener("touch", stop)
end

-- replace character
local function ReplaceCharacter()
    character = display.newImageRect("Images/character.png", 100, 150)
    character.x = display.contentWidth*1/2
    character.y = display.contentHeight*0.1/3
    character.width = 75
    character.height = 100
    character.myName = "Sam"

    -- intialize horizontal movement of character
    motionx = 0

    -- add physics body
    physics.addBody( character, "dynamic", {density=0, friction=0.5, bounce=0, rotation=0} )

    -- prevent character from being able to tip over
    character.isFixedRotation = true

    -- add back arrow listeners
    AddArrowEventListeners()

    -- add back runtime listeners
    AddRuntimeListeners()
end

local function MakeObjectCharactersVisible()
    earth.isVisible = true
    pluto.isVisible = true
    saturn.isVisible = true
end

local function onCollision()
    
    if ( event.phase == "began" ) then

        if  (event.target.myName == "ball1") or
            (event.target.myName == "ball3") or
            (event.target.myName == "ball2") then

            -- get the ball that the user hit
            theBall = event.target

            -- stop the character from moving
            motionx = 0

            -- make the character invisible
            character.isVisible = false

            -- show overlay with math question
            composer.showOverlay( "level1_question", { isModal = true, effect = "fade", time = 100})

            -- Increment questions answered
            questionsAnswered = questionsAnswered + 1
        end

        if (questionsAnswered == 3) then
            timer.performWithDelay(200, YouWinTransition)
        end
    end
end


local function AddCollisionListeners()
    -- if character collides with earth, onCollision will be called
    earth.collision = onCollision
    earth:addEventListener("collision")
    saturn.collision = onCollision
    saturn:addEventListener("collision")
    pluto.collision = onCollision
    pluto:addEventListener("collision")
end

local function RemoveCollisionListeners()
    earth:removeEventListener("collision")
    saturn:removeEventListener("collision")
    pluto:removeEventListener("collision")
end

local function AddPhysicsBodies()
    -- add to physics engine
    physics.addBody(leftW, "static", {friction=0.5, bounce=0.3})
    physics.addBody(rightW, "static", {friction=0.5, bounce=0.3})
    physics.addBody(topW, "static", {friction=0.5, bounce=0.3})

    physics.addBody(platform1, "static", {density=1, friction=0.3, bounce=0.2})
    physics.addBody(platform2, "static", {density=1, friction=0.3, bounce=0.2})
    physics.addBody(platform3, "static", {density=1, friction=0.3, bounce=0.2})
    physics.addBody(platform4, "static", {density=1, friction=0.3, bounce=0.2})

    physics.addBody(earth, "static", {density=1, friction=0.3, bounce=0.2})
    physics.addBody(saturn, "static", {density=1, friction=0.3, bounce=0.2})
    physics.addBody(pluto, "static", {density=1, friction=0.3, bounce=0.2})
end

local function RemovePhysicsBodies()
    physics.removeBody(leftW)
    physics.removeBody(rightW)
    physics.removeBody(topW)

    physics.removeBody(platform1)
    physics.removeBody(platform2)
    physics.removeBody(platform3)
    physics.removeBody(platform4)
end

-----------------------------------------------------------------------------------------
-- GLOBAL FUNCTIONS
-----------------------------------------------------------------------------------------

function ResumeGame()

    -- make character visible again
    character.isVisible = true

    if (questionsAnswered > 0) then
        if (theplanet~= nil) and (theplanet.isBodyActive == true) then
            physics.removeBody(theplanet)
            theplanet.isVisible = false
        end
    end
end

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    -- Insert the background image
    bkg_image = display.newImageRect("Images/Level1Screen.png", display.contentWidth, display.contentHeight)
    bkg_image.x = display.contentCenterX
    bkg_image.y = display.contentCenterY
    bkg_image.width = display.contentWidth
    bkg_image.height = display.contentHeight

    -- Send the background image to the back layer so all other objects can be on top
    bkg_image:toBack()

    -- Insert background image into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( bkg_image )    

   --Insert the right arrow
    rArrow = display.newImageRect("Images/arrow.png", 100, 50)
    rArrow.x = display.contentWidth * 9.2 / 10
    rArrow.y = display.contentHeight * 9.5 / 10
   
    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert(rArrow)

    -- Insert the up arrow
    uArrow = display.newImageRect("Images/arrow.png", 100, 50)
    uArrow.x = display.contentWidth * 8.2 / 10
    uArrow.y = display.contentHeight * 8.5 / 10

    uArrow:rotate(-90)

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert(uArrow)

    -- Insert the left arrow
    lArrow = display.newImageRect("Images/arrow.png", 100, 50)
    lArrow.x = display.contentWidth * 7.2 / 10
    lArrow.y = display.contentHeight * 9.5 / 10

    lArrow:rotate(180)

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert(lArrow)

    -- walls
    topW = display.newLine (0, 0, display.contentWidth, 0)
    topW.isVisible = true

    -- insert the wall into scene group
    sceneGroup:insert(topW)

    leftW = display.newLine (0, 0, 0, display.contentHeight)
    leftW.isVisible = true

    -- insert the wall into scene group
    sceneGroup:insert(leftW)

    rightW = display.newLine (0, 0, 0, display.contentHeight)
    rightW.x = display.contentCenterX * 2
    rightW.isVisible = true

    -- insert the wall into scene group
    sceneGroup:insert(rightW)

    platform1 = display.newImage("Images/PlatformIsabelleLC.png", 200, 100)
    platform1.x = display.contentWidth/11
    platform1.y = display.contentHeight/6

    -- insert platform1 into sceneGroup
    sceneGroup:insert(platform1)

    platform2 = display.newImage("Images/PlatformIsabelleLC.png", 200, 100)
    platform2.x = display.contentWidth/1.25
    platform2.y = display.contentHeight/5

    -- insert platform1 into sceneGroup
    sceneGroup:insert(platform2)

    platform3 = display.newImage("Images/PlatformIsabelleLC.png", 200, 100)
    platform3.x = display.contentWidth/2
    platform3.y = display.contentHeight/3

    -- insert platform1 into sceneGroup
    sceneGroup:insert(platform3)

    platform4 = display.newImage("Images/PlatformIsabelleLC.png", 200, 100)
    platform4.x = display.contentWidth/2
    platform4.y = display.contentHeight/1.75

    -- insert platform1 into sceneGroup
    sceneGroup:insert(platform4)

    earth = display.newImage("Images/earthIsabelleLC.png", 100, 100)
    earth.x = display.contentWidth/2
    earth.y = display.contentHeight/2.15
    earth.width = 100
    earth.height = 100

    -- insert earth into sceneGroup
    sceneGroup:insert(earth)

    saturn = display.newImage("Images/saturnIsabelleLC.png", 100, 100)
    saturn.x = display.contentWidth/1.25
    saturn.y = display.contentHeight/8.5
    saturn.width = 100
    saturn.height = 100

    -- insert earth into sceneGroup
    sceneGroup:insert(saturn)

    pluto = display.newImage("Images/PlutoIsabelleLC.png", 100, 100)
    pluto.x = display.contentWidth/8
    pluto.y = display.contentHeight/8.5
    pluto.width = 100
    pluto.height = 100

    -- insert earth into sceneGroup
    sceneGroup:insert(pluto)
end --function scene:create( event )


-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then

        -- Called when the scene is still off screen (but is about to come on screen).
    -----------------------------------------------------------------------------------------
        -- start physics
        physics.start()

        -- set gravity
        physics.setGravity( 0, GRAVITY)

    elseif ( phase == "did" ) then

        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.

        --create the character, add physics bodies and runtime listeners
        ReplaceCharacter()

        -- add physics bodies to each object
        AddPhysicsBodies()

        -- add collision listeners to objects
        AddCollisionListeners()

        -- make planes visible
        MakeObjectCharactersVisible()
    end
end --function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.

    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.

        RemovePhysicsBodies()
        RemoveCollisionListeners()

        physics.stop()
        RemoveArrowEventListeners()
        RemoveRuntimeListeners()
        display.remove(character)
    end

end --function scene:hide( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.

end -- function scene:destroy( event )

-----------------------------------------------------------------------------------------
-- EVENT LISTENERS
-----------------------------------------------------------------------------------------

-- Adding Event Listeners
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
