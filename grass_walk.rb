# title:   grass walk
# author:  game developer, email, etc.
# desc:    short description
# site:    website link
# license: MIT License (change this to your license of choice)
# version: 0.1
# script:  ruby

class Girl
	BodySpriteId=304
	def initialize(fid)
		@face_id=fid
		@start_tic=0
		@last_x,@last_y=0,0
		@flip=false
	end

	def show(x,y,tic)
		d_x=x-@last_x
		if d_x<0 then f=0
		elsif d_x>0 then f=1
		else 
			f=@flip
			@start_tic=tic
		end
		@flip=f
		d_t=tic-@start_tic
		body_i=d_t/8%4
		body_i=1 if d_x==0 or body_i==3
		body_id=BodySpriteId+body_i*2
		vbank(1)
		spr(body_id,x,y+16,0,1,f,0,2,2)
		spr(@face_id,x,y,0,1,f,0,2,3)
		@last_x,@last_y=x,y
	end
end

$t=0
$x=96
$y=24
$flip=0
$grass=Girl.new(256)
$scarlet=Girl.new(258)

def TIC
	dir=0
	if btn(0) then # up
		$y-=1
	end
	if btn(1) then # down
		$y+=1
	end
	if btn(2) then # left
		$x-=1;dir=-1
	end
	if btn(3) then # right
		$x+=1;dir=1
	end

	_y=$y+40
	_x=$x+40
	vbank(0)
	cls(15)
	vbank(1)
	cls(0)
	$grass.show($x,$y,$t)
	print("Hello, Grass!",_x,$y+20,8)
	$scarlet.show($x,_y,$t)
	print("Hello, Scarlet!",_x,_y+20,8)
	$t+=1
end


# <TILES>
# 001:eccccccccc888888caaaaaaaca888888cacccccccacc0ccccacc0ccccacc0ccc
# 002:ccccceee8888cceeaaaa0cee888a0ceeccca0ccc0cca0c0c0cca0c0c0cca0c0c
# 003:eccccccccc888888caaaaaaaca888888cacccccccacccccccacc0ccccacc0ccc
# 004:ccccceee8888cceeaaaa0cee888a0ceeccca0cccccca0c0c0cca0c0c0cca0c0c
# 017:cacccccccaaaaaaacaaacaaacaaaaccccaaaaaaac8888888cc000cccecccccec
# 018:ccca00ccaaaa0ccecaaa0ceeaaaa0ceeaaaa0cee8888ccee000cceeecccceeee
# 019:cacccccccaaaaaaacaaacaaacaaaaccccaaaaaaac8888888cc000cccecccccec
# 020:ccca00ccaaaa0ccecaaa0ceeaaaa0ceeaaaa0cee8888ccee000cceeecccceeee
# </TILES>

# <SPRITES>
# 000:0000000000000030000000320000003200003333003333330033333303333333
# 001:0000000000000000000000000000000033000000333000003333300033333300
# 002:000000000000003000000032000000320000333900f3339f0093333f03333339
# 003:0000000000000000000000000000000093000000993000009333300099333300
# 016:033337330337373303777773007f977700799277007766730077777300766733
# 017:3333330033333300333333003333330033333200333332003333320033332200
# 018:0332373933373739337222733376d777007dd777007776630077777300766777
# 019:9333320093333200333332003333320033333200333333303333332033333320
# 032:0007773300000333000000300000000000000000000000000000000000000000
# 033:3333220000033200000332000000000000000000000000000000000000000000
# 034:0007777700000000000000000000000000000000000000000000000000000000
# 035:3333332000033320000333200003320000003200000000000000000000000000
# 048:0000000000000aaa0000aaaf0000aaff0000afff0000aa6600000a770000a777
# 049:00000000fffa0000fffa0000ffaa0000ffaa00006aaa0000aaaa0000aaaa0000
# 050:0000000000000aaf0000aaaf0000aaff0000aaff0000aaa600000aa70000aaa7
# 051:00000000ffa00000ffa00000ffaa0000ffaa00006aaa00007aaa00007aaa0000
# 052:0000000000000aaa0000aaaf0000aaaf0000aaaa0000aaaa00000aaa0000aaaa
# 053:00000000fffa0000fffa0000ffff0000ffff0000a66a0000a77a0000aa770000
# 064:0000f77f0000aaaa000fffff0000666000076660022777000222770000022200
# 065:fffff000aaaaa000fffff0000666000007770000077770000077720002222200
# 066:0000fff70000aaa7000ffff70000006600000077000000770000007700000222
# 067:7ffff0007aaaa0007ffff0006000000070000000700000007000000020000000
# 068:0000ffff0000aaaa000fffff0000666000077770022777000222770000022200
# 069:ff77f000aa77a000fffff0000666000006660000077770000077720002222200
# 080:3000000033000000333000000333033300333333003333ee033333ee03333333
# 081:0000000300000033000003333300033033303330e33333003333333033333330
# 082:000300000003000000330000003303330033993303399223039922f903323333
# 083:000300000003300000033000330330003993330023993300f239933032233330
# 096:033337370332272703777777032f977703799777036777770377777703377766
# 097:373333302722333077777330777f923077799730777776307777773066777330
# 098:0333533303337733333222333376d773327dd777336777773277777732077766
# 099:2533333027733333322233333776d733777dd732777776327777773266777022
# 112:0333777700330055003300000003000000000000000000000000000000000000
# 113:7777330055003300000033000000300000000000000000000000000000000000
# 114:3200777732000055200000002000000000000000000000000000000000000000
# 115:7777002255000022000000020000000200000000000000000000000000000000
# 128:00000000000fee0000ffeeaa0ffaeeef0ffaaaaa055aaaaa0770aaaa077aaaaa
# 129:0000000000eef000aaeeff00feeeaff0aaaaaff0aaaaa550aaaa0770aaaaa770
# 144:077fffff777aaaaa77ffffff0000555000007770000077700000777000033330
# 145:fffff770aaaaa777ffffff770555000007770000077700000777000003333000
# </SPRITES>

# <WAVES>
# 000:00000000ffffffff00000000ffffffff
# 001:0123456789abcdeffedcba9876543210
# 002:0123456789abcdef0123456789abcdef
# </WAVES>

# <SFX>
# 000:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000304000000000
# </SFX>

# <TRACKS>
# 000:100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
# </TRACKS>

# <PALETTE>
# 000:1a1c2c5d275db13e53ef7d57ffcd75a7f07038b76425717929366f3b5dc941a6f673eff7f4f4f494b0c2566c86333c57
# 001:000000604e618a5655af7569ba8c6fdfb089f3a6b2f6c7c3fdeae07395c05a2fd8f08c27f6b95bff4200ffffffcfd8ff
# </PALETTE>

