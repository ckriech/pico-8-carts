pico-8 cartridge // http://www.pico-8.com
version 18
__lua__
alive_color=7
width=128
height=128

board_i=1

boards={{},{}}

for y=1,height do
	boards[1][y]={}
	boards[2][y]={}
	for x=1,width do
		boards[1][y][x]=0
		boards[2][y][x]=0
	end
end

cls()

boards[1][60][64]=1
boards[1][61][64]=1
boards[1][62][64]=1

while true do
	for y=1,height do
		for x=1,width do
			pset(x-1,y-1,boards[board_i][x][y]*alive_color) 
	 end
	end
	flip()
end


function get(bi,x,y) if((x<1)or(x>width)or(y<1)or(y>height))then
return 0 end
return boards[bi][y][x] end
-->8
function player_init()
	
end
__gfx__
00000000000000000000000000000000777777770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000a0aa0a00ee00ee0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000009999990eeeeeeeea00a000a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000009000090ee7ee7ee9a090a090000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000009000090e7eeee7e990909990000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
8585858585858585090000900e7777e0989999990000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
58585858585858580900009000eeee00989988980000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
858585858585858500000000000ee000888888880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
