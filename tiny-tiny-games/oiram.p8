pico-8 cartridge // http://www.pico-8.com
version 18
__lua__
-- function _init()
--  dev_mode=true
--  game_over=false
--  win=false
--  g=0.025 --gavity
-- 	make_player()
-- 	make_ground()
-- end
--
-- function _update()
--  if (not game_over) then
--  	move_player()
--  	-- check_land()
--  else
--  	if (btnp(5)) _init()
--  end
-- end
--
-- -- function check_land()
-- -- 	l_x=flr(p.x)
-- -- 	r_x=flr(p.x+7)
-- -- 	b_y=flr(p.y+7)
-- --
-- -- 	over_pad=l_x>pad.x and r_x<=pad.x+pad.width
-- -- 	on_pad=b_y>=pad.y-1
-- -- 	slow=p.dy<1
-- --
-- -- 	if (over_pad and on_pad and slow) then
-- -- 		end_game(true)
-- -- 	elseif (over_pad and on_pad) then
-- -- 		end_game(false)
-- -- 	else
-- -- 		for i=l_x,r_x do
-- -- 		 if (gnd[i]<=b_y) end_game(false)
-- -- 		end
-- -- 	end
-- -- end
--
-- function end_game(won)
-- 	game_over=true
-- 	win=won
--
-- 	if(win) then
-- 		sfx(1)
-- 	else
-- 		sfx(2)
-- 	end
-- end
--
-- function _draw()
-- 	cls()
-- 	draw_stars()
-- 	draw_ground()
-- 	draw_player()
--
-- 	if (game_over) then
-- 		if (win) then
-- 			print("you win!",48,48,11)
-- 		else
-- 			print("too bad!",48,48,8)
-- 		end
-- 		print("press ❎ to play again",20,70.5)
-- 	end
-- end
--
-- function rnde(low, high)
-- 	return flr(rnd(high-low+1)+low)
-- end
--
-- function draw_stars()
-- 	-- srand(1)
-- 	for i=1,50 do
-- 		pset(rnde(0,127),rnde(0,127),rnde(5,7))
-- 	end
-- 	srand(time())
-- end
--
-- -->8
-- function make_player()
-- 	p={}
-- 	p.x=60
-- 	p.y=8
-- 	p.dx=0
-- 	p.dy=0
-- 	p.sprite=1
-- 	p.alive=true
-- 	p.thrust=0.075
-- 	p.fuel=1000 --percent
-- end
--
-- function move_player()
-- 	p.dy+=g
--
-- 	thrust()
--
-- 	p.x+=p.dx
-- 	p.y+=p.dy
--
-- 	stay_on_screen()
-- end
--
-- function thrust()
--  if (p.fuel >= 1) then
-- 		if(btn(0)) p.dx-=p.thrust
-- 		if(btn(1)) p.dx+=p.thrust
-- 		if(btn(2)) p.dy-=p.thrust
--
-- 		if (btn(0) or btn(1) or btn(2)) then
-- 			sfx(0)
-- 			p.fuel-=5
-- 		end
-- 	end
-- end
--
-- function stay_on_screen()
-- 	 if (p.x<0) then   --left side
-- 			p.x=0
-- 			p.dx=0 end
--  	if (p.x>119) then --right side
--   	p.x=119
--   	p.dx=0
--  	end
--  	if (p.y<0) then
-- 			p.y=0
-- 			p.dy=0
-- 		end
-- end
--
-- function draw_player()
--  draw_fuel()
-- 	spr(p.sprite,p.x,p.y)
-- 	if (game_over and win) then
-- 		spr(4,p.x,p.y-8)
-- 	elseif (game_over) then
-- 		spr(5,p.x,p.y)
--  end
--  if (dev_mode) then
--  	print("p.dx="..p.dx,5,10)
--  	print("p.dy="..p.dy,5,17)
--  end
-- end
--
-- function draw_fuel()
-- 	line(10,10,10, flr(p.fuel/10) + 10)
-- end
-- -->8
-- function make_ground()
-- 	--create the ground
-- 	gnd={}
-- 	local top=96
--
--  for i=0,127 do
--   gnd[i]=top
--  end
--
-- 	--set up the landing pad
-- 	-- pad={}
-- 	-- pad.width=15
-- 	-- pad.x=rnde(0,126-pad.width)
-- 	-- pad.y=rnde(top,btm)
-- 	-- pad.sprite=2
--
-- 	-- for i=pad.x,pad.x+pad.width do
-- 	-- 	gnd[i]=pad.y
-- 	-- end
--  --
-- 	-- for i=pad.x+pad.width+1,127 do
-- 	-- 	local h=rnde(gnd[i-1]-3,gnd[i-1]+3)
-- 	-- 	gnd[i]=mid(top,h,btm)
-- 	-- end
--  --
-- 	-- for i=pad.x-1,0,-1 do
-- 	-- 	local h=rnde(gnd[i+1]-3,gnd[i+1]+3)
-- 	-- 	gnd[i]=mid(top,h,btm)
-- 	-- end
-- end
--
-- -- function draw_ground()
-- -- 	for i=0,127 do
-- -- 		line(i,gnd[i],i,127,5)
-- -- 	end
-- -- 	spr(pad.sprite,pad.x,pad.y,2,1)
-- -- end
--
-- function draw_ground()
-- 	for i=0,127 do
-- 		line(i,gnd[i],i,127,5)
-- 	end
-- end

function _init()
 t,f,s=0,1,4 --tick,frame,step
 sp={1,2,3,4,5,6} --sprites
end

function _update()
 t=(t+1)%s --tick fwd
 if (t==0) f=f%#sp+1
end

function _draw()
 cls()
 spr(sp[f],x,y)
end

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000882000088220000882200000882000008880000088800000000000000000000000000000000000000000000000000000000000000000000000000
00700700000888800088888000888880000888800008888000088880000000000000000000000000000000000000000000000000000000000000000000000000
0007700000b45b000045b5000045b50000b45b0000bb450000bb4500000000000000000000000000000000000000000000000000000000000000000000000000
0007700000bbbb0000bbbb0000bbbb0000bbbb0000bbbb0000bbbb00000000000000000000000000000000000000000000000000000000000000000000000000
007007000033bb000333bb00e333bb000033bb0000b33b0000b3bb00000000000000000000000000000000000000000000000000000000000000000000000000
000000000b3ebb000ebbbbb000bbbbb00b3ebb003bb3eb000bb33ebb000000000000000000000000000000000000000000000000000000000000000000000000
000000003bbbbbb03bbbbbbb0bbbbbbb3bbbbbb03bbbbbbb3bbbbbbb000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000007000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000007000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
00060000096500e600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0010000022070220301b0701b03015070150302207022030000001407018070180400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000003e07037060310502c04025040210301c03016030120200e02008020070200601002010020100101001010010100001000000000000000000000000000000000000000000000000000000000000000000
