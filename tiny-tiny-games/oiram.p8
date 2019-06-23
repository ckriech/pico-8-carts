pico-8 cartridge // http://www.pico-8.com
version 18
__lua__
function _init()
 game={}
 game.win=false
 init_player()
 init_round(1)
end

function init_round(n)
 init_falling_shit()
 init_ground()
 game.state="paused"
 game.round={num=n,bldrs=n*n+2,t=30-(n*n),ct=1,per_turn=n}
end
//stop creating builders after ct is up, then end level once all boulders are gone
//remove builder once it is offscreen. Maybe make cool smashing animation
//draw boulder sprite
//draw real floor
//add background
//make some boulders come in at weird angles
//power ups
function _update()
 if (game.state=="paused") then
  if (btnp(4)) game.state="playing"
 elseif (game.state=="playing") then
  game.round.ct+=game.round.per_turn
  if (next_boulder() and game.round.bldrs > 0) then
   create_new_boulder()
   game.round.ct=1
   game.round.bldrs-=1
  elseif(done_with_b() and game.round.num >= 5) then
   boulders.list={}
   game.state="game_over"
   game.win=true
  elseif(done_with_b()) then
   init_round(game.round.num+1)
  end
  update_boulders()
  update_player()
 end
end

function next_boulder()
 return game.round.ct >= game.round.t
end

function done_with_b()
 local l=boulders.list
 x=#l==0 and game.round.bldrs==0
 printh(x)
 return x
end

function _draw()
 cls()
 draw_ground()
 draw_player()
 draw_boulders()
 draw_stage_text()
end

function draw_stage_text()
 if(game.state=="paused") then
  print("press ❎ to start round X!",20,70.5)
 elseif(game.state=="game_over") then
  if (game.win) then
   print("you win, pal!",48,48,11)
  else
   print("you lose, dork!",48,48,8)
  end
 end
end

function init_ground()
 gnd={}
 gnd.top=100
end

function draw_ground()
 rectfill(0,127,127,gnd.top+8,5)
end

function init_falling_shit()
 boulders={}
 boulders.s=7
 boulders.list={}
 boulders.g=0.25
end

function create_new_boulder()
 local b={}
 b.x=flr(rnd(127-8)) //8 for sprite size
 b.y=-10
 b.dy=0
 b.dx=0
 b.hitbox={x=0,y=0,w=8,h=8}
 b.g_multiplier=rnd(1)+.50
 add(boulders.list, b)
end

function update_boulders()
	for b in all(boulders.list) do
		b.dy+=boulders.g*b.g_multiplier
		b.y+=b.dy
  if (collide(b, p)) then
   game.state="game_over"
   game.win=false
  elseif (b.y==128) then
   del(boulders.list, b)
  end
	end
end

function draw_boulders()
	for b in all(boulders.list) do
		spr(boulders.s,b.x,b.y)
	end
end

function collide(obj, other)
    if
        other.x+other.hitbox.x+other.hitbox.w > obj.x+obj.hitbox.x and
        other.y+other.hitbox.y+other.hitbox.h > obj.y+obj.hitbox.y and
        other.x+other.hitbox.x < obj.x+obj.hitbox.x+obj.hitbox.w and
        other.y+other.hitbox.y < obj.y+obj.hitbox.y+obj.hitbox.h
    then
        return true
    end
end

-->8
function init_player()
 p={}
 p.t=0 --tick
 p.f=1 --frame
 p.s=4 --step
 p.x=0
 p.y=100
 p.dx=0
 p.sp={1,2,3,4,5,6} --sprites
 p.speed=1.5
 p.moving=false
 p.flip=false
 p.hitbox={x=0,y=0,w=8,h=8}
 p.moving_last_frame=false
end

function update_player()
 p.dx=0
 p.dy=0
 p.moving_last_frame=p.moving
 p.moving=false
	if(btn(0)) then
 	p.dx-=p.speed
 	p.moving=true
  p.flip=true
 elseif(btn(1)) then
  p.dx+=p.speed
  p.moving=true
  p.flip=false
 end

 animate_player()

 p.x+=p.dx
 p.y+=p.dy
end

 function animate_player()
  if(p.moving and not p.moving_last_frame) then
   p.f=2
  end
  if(p.moving_last_frame) then
   p.t=(p.t+1)%p.s --tick fwd
   if (p.t==0) p.f=p.f%#p.sp+1
  end
  if(not p.moving) then
   p.t=0 --tick
   p.f=1 --frame
  end
 end

 function draw_player()
  spr(p.sp[p.f],p.x,p.y)
 end

__gfx__
00000000000000000000000000000000000000000000000000000000222222220000000000000000000000000000000000000000000000000000000000000000
00000000000882000088220000882200000882000008880000088800222222220000000000000000000000000000000000000000000000000000000000000000
00700700000888800088888000888880000888800008888000088880222222220000000000000000000000000000000000000000000000000000000000000000
0007700000b45b000045b5000045b50000b45b0000bb450000bb4500222222220000000000000000000000000000000000000000000000000000000000000000
0007700000bbbb0000bbbb0000bbbb0000bbbb0000bbbb0000bbbb00222222220000000000000000000000000000000000000000000000000000000000000000
007007000033bb000333bb00e333bb000033bb0000b33b0000b3bb00222222220000000000000000000000000000000000000000000000000000000000000000
000000000b3ebb000ebbbbb000bbbbb00b3ebb003bb3eb000bb33ebb222222220000000000000000000000000000000000000000000000000000000000000000
000000003bbbbbb03bbbbbbb0bbbbbbb3bbbbbb03bbbbbbb3bbbbbbb222222220000000000000000000000000000000000000000000000000000000000000000
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
