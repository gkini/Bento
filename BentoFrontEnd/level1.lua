-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------


local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local tileWidth=32
local tileHeight=32
local sprite = require("sprite")
        
local player={}

               
local offsetX=0      
local offsetY=0
local offsetPx=0
local offsetPy=0   

local focusX=224
local focusY=160    

local mapWidth=25	
local mapHeight=15

local screenWidth=16
local screenHeight=11

-- Displays the background image

local sky = display.newImage( "sky.jpg" )

--[[
Sets options for picking images from the image sheet
]]--
local options = 
{
	-- Required params
	width = 32,
	height = 32,
	numFrames = 16,
	-- content scaling
	sheetContentWidth = 128,
	sheetContentHeight = 128,
}
--[[
Setting local pic to pick up the game-tiles.png as an imagesheet
]]--
local pic = graphics.newImageSheet( "game-tiles.png", options )

local screen= {}
screen[1]={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0} 
screen[2]={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
screen[3]={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
screen[4]={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
screen[5]={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
screen[6]={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
screen[7]={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
screen[8]={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
screen[9]={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
screen[10]={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
screen[11]={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}

local iv={}

iv.map={}

iv.map[1]={}
iv.map[1].type="tile"
iv.map[1].z_order=1
iv.map[1][1] ={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}     
iv.map[1][2] ={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
iv.map[1][3] ={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
iv.map[1][4] ={0,0,0,0,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
iv.map[1][5] ={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
iv.map[1][6] ={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,0,0,0}
iv.map[1][7] ={0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,1,0,0,0,1,1,1,0,0}
iv.map[1][8] ={0,1,0,0,1,0,1,0,0,0,0,0,0,0,0,0,2,0,0,0,1,0,0,0,0}
iv.map[1][9] ={0,1,1,1,1,0,1,1,1,0,0,0,1,1,1,0,1,1,1,1,1,0,0,0,0}
iv.map[1][10]={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}  
iv.map[1][11]={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}  
iv.map[1][12]={0,1,1,0,1,1,0,1,1,1,1,1,1,1,1,0,1,1,0,1,1,0,0,0,0}
iv.map[1][13]={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0} 
iv.map[1][14]={0,0,1,1,0,1,1,0,1,1,0,1,1,0,1,1,0,1,1,0,1,1,0,0,0} 
iv.map[1][15]={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}  

iv.map[3]={}
iv.map[3].type="tile"
iv.map[3].z_order=1
iv.map[3][1] ={9,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,9,0}     
iv.map[3][2] ={9,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,9,0}
iv.map[3][3] ={9,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,9,0}
iv.map[3][4] ={9,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,9,0}
iv.map[3][5] ={9,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,9,0}
iv.map[3][6] ={9,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,9,0}
iv.map[3][7] ={9,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,9,0}
iv.map[3][8] ={9,1,0,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,9,0}
iv.map[3][9] ={9,1,1,1,1,0,1,1,1,0,0,0,1,1,1,0,1,1,1,1,1,0,0,9,0}
iv.map[3][10]={9,0,0,0,0,0,0,0,0,0,0,0,0,0,0,9,0,0,0,0,0,0,0,9,0}
iv.map[3][11]={9,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,9,0}  
iv.map[3][12]={9,1,1,0,1,1,0,1,1,1,1,1,1,1,1,0,1,1,0,1,1,0,0,9,0}
iv.map[3][13]={9,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,9,0}
iv.map[3][14]={9,0,1,1,0,1,1,0,1,1,0,1,1,0,1,1,0,1,1,0,1,1,0,9,0}
iv.map[3][15]={9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,0} 


--border control required
--state check required
local collisionDetection = function ()
if(player.image.x<0 or player.image.y<0 or player.image.x>=screenWidth*tileWidth or player.image.y>=screenHeight*tileHeight) then return end
	local i = math.floor((player.image.y - offsetPy) /tileHeight+offsetY)+1
	local j = math.floor((player.image.x - offsetPx) /tileWidth+offsetX)+1

	print(player.image.x, player.image.y,player.directionX, player.directionY,offsetX,offsetY,offsetPx,offsetPy,i,j,iv.map[3][i][j])

	--for now, there's ==1 collision detection only
	--for other collision detections, just simply add elseif case will work
	if player.directionX>0 and iv.map[3][i][j+player.directionX]==1 then
		if player.speedX ~=0 then player.directionX = player.directionX * -1 end
	elseif player.directionX<0 and iv.map[3][i][j]==1 then
		if player.speedX ~=0 then player.directionX = player.directionX * -1 end
	end
	
	if i>0 and i< 15 and iv.map[3][i+1][j]==0 then
	player.directionY = 1
	player.speedX = 0
	elseif i>0 and i<15 and iv.map[3][i+1][j]==1 then
	player.directionY = 0
	player.speedX = 1
	end
	
end   

      
--playermovement / screen relocate
--border control required

local move = function()

if(player.image.x < 0 or player.image.x > screenWidth*tileWidth or player.image.y < 0 or player.image.y > screenHeight*tileHeight) then return end

--handle the horizontal first
if (player.directionX ~= 0 and player.speedX ~= 0) then
	--cases that the screen doesn't move
	if ((focusX-player.image.x)*player.directionX > 0 or   -- moving towards the center
		(offsetX==0 and player.directionX<0) or            -- reaching the left edge
		(offsetX+screenWidth>=mapWidth and player.directionX>0)) then --reaching the right edge
		player.image.x = player.image.x + player.directionX * player.speedX
	else	
		-- screen is moving
		offsetPx = offsetPx + player.directionX * player.speedX
	
		-- caution: using if/else here (instead of while loop), assuming one adjustment only is needed
		if (offsetPx >= tileWidth) then
			-- reload the screen & relocate the images   
			offsetPx = offsetPx - tileWidth
			offsetX = offsetX + 1   
			for i,v in ipairs(screen) do
				for j,vv in ipairs(v) do
					if (j == 1 and vv ~= nil and vv~=0) then
					screen[i][j]:removeSelf()
					end
					if (j < screenWidth) then  
						screen[i][j]=screen[i][j+1]
						if (screen[i][j] ~= 0 and screen[i][j] ~= nil) then
						screen[i][j].x = screen[i][j].x - player.directionX * player.speedX 
						end     
					else      
						local temp=iv.map[1][i+offsetY][j+offsetX]
						if temp>0 then 
						screen[i][j] = display.newImage(pic,temp)
						screen[i][j].x = (j-1)*tileWidth - offsetPx
						screen[i][j].y = (i-1)*tileHeight - offsetPy
						else
						screen[i][j] = 0
						end   
					end
				end
			end
		elseif (offsetPx <0) then
			offsetPx = offsetPx + tileWidth
			offsetX = offsetX -1
			local temp
			for i,v in ipairs(screen) do
				for j, vv in ipairs(v) do
					if (j == screenWidth and vv~=nil and vv~=0) then 
					screen[i][j]:removeSelf() 
					end
					if j>1 then
						local temp2 = vv
						screen[i][j] = temp
						temp = temp2
						if (screen[i][j] ~=0 and screen[i][j] ~=nil) then
						screen[i][j].x = screen[i][j].x + player.directionX * player.speedX
						end
					else
						temp = screen[i][j]
						local temp2=iv.map[1][i+offsetY][j+offsetX]
						if temp2>0 then
						screen[i][j] = display.newImage(pic,temp2)
						screen[i][j].x = (j-1)*tileWidth - offsetPx
						screen[i][j].y = (i-1)*tileHeight - offsetPy
						else
						screen[i][j] = 0
						end
					end
				end
			end
		else
			for i,v in ipairs(screen) do
				for j,vv in ipairs(v) do
					if (screen[i][j] ~=0 and screen[i][j] ~= nil) then screen[i][j].x = screen[i][j].x - player.directionX * player.speedX end
				end
			end
		end   
		
	end
end

--then do the vertical
if(player.directionY ~=0 and player.speedY ~=0) then
	--cases that the screen doesn't move
	if ((focusY-player.image.y)*player.directionY > 0 or   -- moving towards the center
		(offsetY==0 and player.directionY<0) or            -- reaching the top edge
		(offsetY+screenHeight>=mapHeight and player.directionY>0)) then --reaching the bottom edge
		player.image.y = player.image.y + player.directionY * player.speedY
	else
		-- screen is moving
	    offsetPy = offsetPy + player.directionY * player.speedY

		-- caution: using if/else here (instead of while loop), assuming one adjustment only is needed
		if (offsetPy >= tileHeight) then
			-- reload the screen & relocate the images
			offsetPy = offsetPy - tileHeight
			offsetY = offsetY + 1
			for i,v in ipairs(screen) do
				for j,vv in ipairs(v) do
					if (i == 1 and vv ~= nil and vv~=0) then
					screen[i][j]:removeSelf()
					end
					if (i < screenHeight) then
						screen[i][j]=screen[i+1][j]
						if (screen[i][j] ~= 0 and screen[i][j] ~= nil) then
						screen[i][j].y = screen[i][j].y - player.directionY * player.speedY
						end
					else
						local temp=iv.map[1][i+offsetY][j+offsetX]
						if temp>0 then
						screen[i][j] = display.newImage(pic,temp)
						screen[i][j].x = (j-1)*tileWidth - offsetPx
						screen[i][j].y = (i-1)*tileHeight - offsetPy
						else
						screen[i][j] = 0
						end
					end
				end
			end
 		 elseif (offsetPy <0) then
			offsetPy = offsetPy + tileHeight
			offsetY = offsetY -1
			local temp
			for i,v in ipairs(screen) do
				for j, vv in ipairs(v) do
					if (i == screenHeight and vv~=nil and vv~=0) then
					screen[i][j]:removeSelf()
					end
					if i>1 then
						local temp2 = vv
						screen[i][j] = temp
						temp = temp2
						if (screen[i][j] ~=0 and screen[i][j] ~=nil) then
						screen[i][j].y = screen[i][j].y + player.directionY * player.speedY
						end
					else
						temp = screen[i][j]
						local temp2=iv.map[1][i+offsetY][j+offsetX]
						if temp2>0 then
						screen[i][j] = display.newImage(pic,temp2)
						screen[i][j].x = (j-1)*tileWidth - offsetPx
						screen[i][j].y = (i-1)*tileHeight - offsetPy
						else
						screen[i][j] = 0
						end
					end
				end
			end
		else
			for i,v in ipairs(screen) do
				for j,vv in ipairs(v) do
					if (screen[i][j] ~=0 and screen[i][j] ~= nil) then screen[i][j].y = screen[i][j].y - player.directionY * player.speedY end
				end
			end
		end
	end
end
end

local mainLoop = function (event)
--caution: using move&detect here, so try not to set up a map with a collision at first move. It will possibly not be detected
move()
--collisionDetection & state check
collisionDetection()

end

 

local init = function ()
--set player's init parameters
player.speedX=1
player.speedY=1
player.directionX=1
player.directionY=0
player.state = "run"

local imageSheet = graphics.newImageSheet( "greenman.png", { width=128, height=128, numFrames=15 } )
--do a first iteration to find out the starting position, and get the value of offsetX & offsetY
for i,v in ipairs(iv.map[1]) do
	for j,vv in ipairs(v) do
	if vv~=0 then
		if vv==-1 then
		-- A sprite sheet with a green dude
		--local sheet2 = graphics.newImageSheet( "greenman.png", { width=128, height=128, numFrames=15 } )

		-- play 15 frames every 500 ms
		--local instance2 = display.newSprite( sheet2, { name="badguy1.png", start=1, count=15, time=500 } )
		--instance2.x = 3 * display.contentWidth / 4 + 30
		--instance2.y = baseline - 55
		--instance2:play()
--			player.image=display.newImageRect("badguy1.png",tileWidth,tileHeight)
			player.image=display.newSprite( imageSheet, { name="man", start=1, count=15, time=1000 } )--display.newImage(pic,3)
			player.image:play()
			--player.image.imgName="badguy1.png"
			if (j - focusX/tileWidth - 1)<0 then
				offsetX=0
				player.image.x=(j-1)*tileWidth
			elseif (j-1-focusX/tileWidth+screenWidth)>mapWidth then
				offsetX=mapWidth-screenWidth
				player.image.x= (j-offsetX-1)*tileWidth
			else
				offsetX=j-focusX/tileWidth-1
				player.image.x=focusX
			end
			if (i-1-focusY/tileHeight)<0 then
				offsetY=0
				player.image.y = (i-1)*tileHeight
			elseif (i-1-focusY/tileHeight+screenHeight)>mapHeight then
				offsetY=mapHeight-screenHeight
				player.image.y = (i-1-offsetY)*tileHeight
			else
				offsetY=i-1-focusY/tileHeight
				player.image.y=focusY
			end
			print("first it",i,j,offsetX,offsetY)
		end
	end
	end
end    
--do a second iteration to evaluate the screen vector

for i,v in ipairs(iv.map[1])do
	if (i>=offsetY+1 and i<=offsetY+screenHeight) then
	for j, vv in ipairs(v) do
	if (j>=offsetX+1 and j<=offsetX+screenWidth) then
		if vv>0 then
	--	print("second it",i,j,vv,pic[vv])
		screen[i-offsetY][j-offsetX]=display.newImage(pic,vv)
		screen[i-offsetY][j-offsetX].x=(j-offsetX-1)*tileWidth       
		screen[i-offsetY][j-offsetX].y=(i-offsetY-1)*tileHeight
	--	screen[i-offsetY][j-offsetX].imgName=pic[vv]
		end
	end
	end
	end
end

end


init()
Runtime:addEventListener("enterFrame",mainLoop)


return scene