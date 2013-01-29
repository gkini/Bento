-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here
--print("Hello World")

--local textObject = display.newText("Hello World", 50, 50, nul, 24)

--textObject:setTextColor(255,255,255)

local img=display.newImage( "game-tiles.png", 0,0,true )

local tileWidth=32
local tileHeight=32

local x=50

local iv={}

iv.map={}

iv.map[1]={}
iv.map[1].type="tile"
iv.map[1].z_order=1
iv.map[1][1] ={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}     
iv.map[1][2] ={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
iv.map[1][3] ={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
iv.map[1][4] ={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
iv.map[1][5] ={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
iv.map[1][6] ={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,0,0}
iv.map[1][7] ={0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0}
iv.map[1][8] ={0,0,-1,0,2,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0}
iv.map[1][9] ={0,1,1,1,2,0,2,1,1,0,0,0,1,1,1,0,1,1,1,1,2,0,0,0}
iv.map[1][10]={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}   

iv.map[3]={}
iv.map[3].type="tile"
iv.map[3].z_order=1
iv.map[3][1] ={9,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,9}     
iv.map[3][2] ={9,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,9}
iv.map[3][3] ={9,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,9}
iv.map[3][4] ={9,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,9}
iv.map[3][5] ={9,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,9}
iv.map[3][6] ={9,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,9}
iv.map[3][7] ={9,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,9}
iv.map[3][8] ={9,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,9}
iv.map[3][9] ={9,1,1,1,1,0,1,1,1,0,0,0,1,1,1,0,1,1,1,1,1,0,0,9}
iv.map[3][10]={9,0,0,0,0,0,0,0,0,9,9,9,0,0,0,9,0,0,0,0,0,0,0,9}

local player={}

               
local offsetX=0      
local offsetY=5   

local screen= {}
screen[1]={0,0,0,0,0,0,0,0}
screen[2]={0,0,0,0,0,0,0,0}
screen[3]={0,0,0,0,0,0,0,0}
screen[4]={0,0,0,0,0,0,0,0}
screen[5]={0,0,0,0,0,0,0,0}        

--border control required
local collisionDetection = function ()
local i = math.round((player.image.y + player.speedY * player.directionY) /64+offsetY)
local j = math.round((player.image.x + player.speedX * player.directionX) /64-offsetX)

if iv.map[3][i][j]==1 then
player.directionX = player.directionX * -1
print(player.image.x, player.image.y,i,j)
end
if iv.map[3][i+1][j]~=1 then
player.directionY = 1
end
end   

local mainLoop = function (event)
img.y = img.y + 1

--playermovement
--border control required
if not(player.image.x==0 or player.image.y==0)then
player.image.x = player.image.x+player.speedX*player.directionX
player.image.y = player.image.y + player.speedY*player.directionY
end
--collisionDetection & state check
collisionDetection()

--screen relocate

end

 

local init = function ()
local i1=display.newImageRect("wall1.png",0,0)
local i2=display.newImageRect("grassland1.png",64,0)
local i3=display.newImageRect("wall1.png",128,0)
print("i1",i1.x,i1.y)
print("i2",i2.x,i2.y)
print("i3",i3.x,i3.y)
player.speedX=1
player.speedY=1
player.directionX=1
player.directionY=0
for i,v in ipairs(iv.map[1]) do
	for j,vv in ipairs(v) do
	if vv~=0 then
		if vv==1 then
		screen[i-offsetY][j]=display.newImageRect("grassland1.png",tileWidth,tileHeight)
		screen[i-offsetY][j]:setReferencePoint(display.TopLeftReferencePoint)
		screen[i-offsetY][j].x=(offsetX+j)*tileWidth
		screen[i-offsetY][j].y=(i-offsetY)*tileHeight
		elseif vv==2 then
		screen[i-offsetY][j]=display.newImageRect("wall1.png",tileWidth,tileHeiht)         
		screen[i-offsetY][j]:setReferencePoint(display.TopLeftReferencePoint)
		screen[i-offsetY][j].x=(offsetX+j)*tileWidth
		screen[i-offsetY][j].y=(i-offsetY)*tileHeight
		print(i-offsetY,j,screen[i-offsetY][j].x,screen[i-offsetY][j].y)
		print("wall",i,j)
		elseif vv==-1 then
		player.image=display.newImageRect("badguy1.png",tileWidth,tileHeight)               
		player.image:setReferencePoint(display.TopLeftReferencePoint)
		player.image.x=(offsetX+j)*tileWidth
		player.image.y=(i-offsetY)*tileHeight
		end
	end
	end
end
end

init()
Runtime:addEventListener("enterFrame",mainLoop)