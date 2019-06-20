pico-8 cartridge // http://www.pico-8.com
version 18
__lua__
function _init()
	set_up_buttons()
	game={}
	game.state="init"
	//start, show, attempt, restart (???)
end

function _update()

 if game.state=="init" then
  printh("init")
 	game.level=1
 	game.state="demo_starting"
 elseif game.state=="demo_starting" then
 	printh("demo_starting")
 	init_demo()
 	game.state="demo_running"
 elseif game.state=="demo_running" then
 	printh("demo_running")
 	printh("anims:"..#game.anims)
 	if #game.anims>0 then
 	 if costatus(game.anims[1]) then
 	 	printh("resuming")
    coresume(game.anims[1])
   else
    printh("del'ing")
    del(game.anims,game.anims[1])
   end
 	end
 end
	update_buttons() 
end

function _draw()
	cls()
	draw_buttons()
end

-->8
function set_up_buttons()
	buttons={}
	
	buttons.n={}
	buttons.n.dimc=8
	buttons.n.litc=14
	buttons.n.lit=false
	buttons.n.lit_delay=-1
	buttons.n.key=2
	//top left corner, might change
	buttons.n.x=50
	buttons.n.y=25
	
	buttons.s={}
	buttons.s.dimc=3
	buttons.s.litc=11
	buttons.s.lit=false
	buttons.s.lit_delay=-1
	buttons.s.key=3
	buttons.s.x=50
	buttons.s.y=75
	
	buttons.e={}
	buttons.e.dimc=9
	buttons.e.litc=10
	buttons.e.lit=false
	buttons.e.lit_delay=-1
	buttons.e.key=1
	buttons.e.x=75
	buttons.e.y=50
	
	buttons.w={}
	buttons.w.dimc=1
	buttons.w.litc=12
	buttons.w.lit=false
	buttons.w.lit_delay=-1
	buttons.w.key=0
	buttons.w.x=25
	buttons.w.y=50
end

function _button(k)
	if k=="n" then return buttons.n
	elseif k=="s" then return buttons.s
	elseif k=="e" then return buttons.e
	elseif k=="w" then return buttons.w
	end
end

function update_buttons()
	buttons.n = light(buttons.n)
	buttons.s = light(buttons.s)
	buttons.e = light(buttons.e)
	buttons.w = light(buttons.w)
end

function light(b)
 if btn(b.key) then
  b.lit=true
 elseif b.lit_delay>0 then
 	b.lit=true
 	b.light_delay=-1
 else
 	b.lit=false
 end
 
 return b
end

function init_anim(b)
	for i=1,10 do
	 printh("i:"..i)
	 b.lit=true
		yield()
	end
	exit()
end

function draw_buttons()
	draw_button(buttons.n)
	draw_button(buttons.s)
	draw_button(buttons.w)
	draw_button(buttons.e)
end

function draw_button(b)
//should be called once per frame
	pal()
	if b.lit then
	 pal(15,b.litc)
	else
		pal(15,b.dimc)
	end
		spr(1,b.x,b.y)
		
	pal()
end
-->8
function init_demo()
 level={}
 
 //level.order=["n","n","s","w"]
 
 local a=cocreate(init_anim(_button("w")))
 
 game.anims={a}
end
__gfx__
00000000006666000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000006ffff600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
007007006ffffff60000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000770006ffffff60000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000770006ffffff60000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
007007006ffffff60000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000006ffff600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000006666000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
