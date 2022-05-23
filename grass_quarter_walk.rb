# title:   grass quarter walk
# author:  SAkira <sakisakira@gmail.com>
# desc:    short description
# site:    website link
# license: MIT License (change this to your license of choice)
# version: 0.1
# script:  ruby

class Girl
	attr_reader(:last_x,:last_y,:direction)
	W_Base=256-256
	WSBase=262-256
	WNBase=320-256
	N_Base=268-256
	S_Base=332-256

	def initialize(base_id)
		@base_id=base_id
		@start_tic=0
		@last_x,@last_y=0,0
		@direction=[0,1]
	end

	def sprite_id(d_x,d_y)
		if d_x.zero? then
			return @base_id+N_Base if d_y<0
			return @base_id+S_Base if d_y>0
			return nil
		end
		return @base_id+WNBase if d_y<0
		return @base_id+W_Base if d_y==0
		return @base_id+WSBase if d_y>0
		return nil
	end

	def show(x,y,tic)
		d_x=(x-@last_x)<=>0
		d_y=(y-@last_y)<=>0
		if d_x==0 and d_y==0 then
			@start_tic=tic
		else
			@direction=[d_x,d_y]
		end
		d_t=(tic-@start_tic)/8%4
		d_t=1 if @start_tic==tic or d_t==3
		flip=if @direction[0]>0 or (@direction[0]==0 and d_t==2)
			then 1 else 0 end
		if d_x.zero? and d_y.zero? then
			sid=sprite_id(@direction[0],@direction[1])+2
		elsif d_x.zero? then
			sid=sprite_id(0,d_y)+d_t%2*2
		else
			sid=sprite_id(d_x,d_y)+d_t*2
		end
		vbank(1)
		spr(sid,x,y,0,1,flip,0,2,4)
		@last_x,@last_y=x,y
	end
end

$tic=0
$x=96
$y=24
$grass=Girl.new(256)
Width=240
Height=130

class GirlStatus
	attr_reader(:girl,:x,:y)
	def initialize(base_id)
		@girl=Girl.new(base_id)
		@x=rand(Width)
		@y=rand(Height)
		@dx=rand(3)-1
		@dy=rand(3)-1
		@duration=rand(60)
		@tic=0
	end

	def update
		@x+=@dx
		@y+=@dy
		@x=[[0,@x].max,Width].min
		@y=[[0,@y].max,Height].min
		if @tic>=@duration then
			@dx=rand(3)-1
			@dy=rand(3)-1
			@duration=rand(60)
			@tic=0
		end
		@tic+=1
	end
end

$girls=[]
30.times do |i|
	$girls << GirlStatus.new(256)
end

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

	vbank(0)
	cls(15)
	vbank(1)
	cls(0)
	$grass.show($x,$y,$tic)
	print("I'm Grass!",$x,$y+32,8)
	$girls.each do |gs|
		gs.update
		gs.girl.show(gs.x, gs.y,$tic)
	end
	$tic+=1
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
# 000:0000000000000000000000000000003200000032000003320000533300053333
# 001:0000000000000000000000000000000000000000330000003330000033330000
# 002:0000000000000000000000000000003200000032000003320000533300053333
# 003:0000000000000000000000000000000000000000330000003330000033330000
# 004:0000000000000000000000000000003200000032000003320000533300053333
# 005:0000000000000000000000000000000000000000330000003330000033330000
# 006:000000000000000000000000000002000000020000000223000002230000333e
# 007:0000000000000000000000000000000000002000333320003333230033322300
# 008:000000000000000000000000000002000000020000000223000002230000333e
# 009:0000000000000000000000000000000000002000333320003333230033322300
# 010:000000000000000000000000000002000000020000000223000002230000333e
# 011:0000000000000000000000000000000000002000333320003333230033322300
# 012:0000000000000000000000000000300000032000000323330002333300033333
# 013:0000000000000000000000000003000000032000333320003333200033333000
# 014:0000000000000000000000000000300000032000000323330002333300033333
# 015:0000000000000000000000000003000000032000333320003333200033333000
# 016:0003333300333333003325230035f553000fa773004766730077777300766753
# 017:3322200033222000322220002222200022222000222220002222200022222000
# 018:0003333300333333003325230035f553000fa773004766730077777300766753
# 019:3322200033222000322220002222200022222000222220002222200022222000
# 020:0003333300333333003325230035f553000fa773004766730077777300766753
# 021:3322200033222000322220002222200022222000222220002222200022222000
# 022:000333ee003333ee0033333300355355003fa377003aa77f0036677a00377777
# 023:3332233033333330333333303333333035333320a7333320a773332066733320
# 024:000333ee003333ee0033333300355355003fa377003aa77f0036677a00377777
# 025:3332233033333330333333303333333035333320a7333320a773332066733320
# 026:000333ee003333ee0033333300355355003fa377003aa77f0036677a00377777
# 027:3332233033333330333333303333333035333320a7333320a773332066733320
# 028:0033333300333333003333330033333300233333002333330023333300033333
# 029:3333330033333300333333003333320033333200333332003333320033333000
# 030:0033333300333333003333330033333300233333002333330023333300033333
# 031:3333330033333300333333003333320033333200333332003333320033333000
# 032:00077533000003220000333f0000eeef0000aaaf00000f9900007fff0007aaaa
# 033:22222000222200009222000099aa0000999a000095500000f5590000a75a0000
# 034:000775330000032f000033ff0000eeff0000aaff00000f9500000ff70000aaa7
# 035:2222200022220000922200009aaa00009aaa000059900000599900005aaa0000
# 036:000775330000032f000033ff0000eff90000fff90000075500007759000777aa
# 037:222220002222000092220000aaaa0000aaaa00009990000099990000aaaa0000
# 038:0032766700f2e77700ffee550ff9aeff0ff9aaaf007aaaaa077ffffa075aaaff
# 039:77732220773229f05e22ffffeeaaaff9aaaaaff9aaaaaff9aaf99055fffaa077
# 040:0032766700f2e77700faee55009aaeff005aaaaf0077aaaa0077fffa000aaaff
# 041:77732220773229205e22fff0eeaaff90aaaaff90aaaaff90aaf99550fffaa770
# 042:0032766700f2e77700faee5500faaeff00faaaaf0007aaaa000ffffa00aaaaff
# 043:77732220773229205e22ff00eeaaf900aaaff900aaaff900aaf55500fff77000
# 044:0002333200ff33320ff922220ff9aaaa0055aaaa00750fff0075ffff0000aaaa
# 045:333220003332ff0022229ff0aaaa9ff0aaaa9ff099905500ffff5700aaaa7700
# 046:0002333200ff33320ff922220ff9aaaa0055aaaa00750fff0075ffff0070aaaa
# 047:333220003332ff0022229ff0aaaa9ff0aaaa550099905700fff95700aaaa0700
# 048:0007ffff00007755000077500003377000002220000000000000000000000000
# 049:9759000055000000775000005322000022200000000000000000000000000000
# 050:0000ffff00000075000000770000007700000322000000000000000000000000
# 051:9999000050000000500000005000000020000000000000000000000000000000
# 052:00077fff00005557000077500003377000002220000000000000000000000000
# 053:9999000075000000775000005322000022200000000000000000000000000000
# 054:05000aaa00000555000003220000000000000000000000000000000000000000
# 055:aaaaa07755550000777000007770000077700000322000000000000000000000
# 056:00005aaa00007550000077700000322000000000000000000000000000000000
# 057:aaaaa77005550000077700000777000003220000000000000000000000000000
# 058:00055aaa00077500000777000007720000332200000000000000000000000000
# 059:aa77700005570000032200000000000000000000000000000000000000000000
# 060:000fffff0000ffff000075500000775000007750000032200000000000000000
# 061:ffff770005550000057700000322000000000000000000000000000000000000
# 062:000fffff00007550000077500000775000003220000000000000000000000000
# 063:fffff00005550000057700000577000003220000000000000000000000000000
# 064:0000000000000000000000000000000000000200000002030000022300003333
# 065:0000000000000000000000000000200000002000333320003333330033333200
# 066:0000000000000000000000000000000000000200000002030000022300003333
# 067:0000000000000000000000000000200000002000333320003333330033333200
# 068:0000000000000000000000000000000000000200000002030000022300003333
# 069:0000000000000000000000000000200000002000333320003333330033333200
# 076:000000000000000000000000000030000003200000032333000233330003333e
# 077:000000000000000000000000000300000003200033332000e3332000e3333000
# 078:000000000000000000000000000030000003200000032333000233330003333e
# 079:000000000000000000000000000300000003200033332000e3332000e3333000
# 080:00033333003333330033333300055333000a7333000a77330007773300077733
# 081:3322222032222220322222203222222032222220332222203322222033222220
# 082:00033333003333330033333300055333000a7333000a77330007773300077733
# 083:3322222032222220322222203222222032222220332222203322222033222220
# 084:00033333003333330033333300055333000a7333000a77330007773300077733
# 085:3322222032222220322222203222222032222220332222203322222033222220
# 092:0033333e003333330033535500337fa700237aa7002566770025777700237776
# 093:e333330033333300355333007fa732007aa73200776652007777520067773200
# 094:0033333e003333330033535500337fa700237aa7002566770025777700237776
# 095:e333330033333300355333007fa732007aa73200776652007777520067773200
# 096:000672330003333300ffa22200ffaa220ffaaaaa0759aaaa07799faa0770afff
# 097:322222202222220022222ff022aaaff0aaaaa9f0aaaaf990affff570ffaaa550
# 098:000672330003333300ffa2220fffaa220fffaaaa09ffaaaa00559faa0077afff
# 099:322222202222220022222f0022aaaff0aaaaa9f0aaaaa500affff700ffaaa000
# 100:0006723300033333000fa22200ffaa2200fffaaa00fffaaa00559faa00077fff
# 101:322222202222220022222f0022aaaf00aaaaaa00aaaaaa00aafff000fffaa000
# 108:0003257700f33ee50ff93eef0ff9aaaa0ff9aaaa00750fff0075ffff00775aaa
# 109:775232005ee33f00fee39ff0aaaa9ff0aaaa5500fff05700ffff5000aaaa0000
# 110:0003257700f33ee50ff93eef0ff9aaaa0055aaaa00750fff0075ffff0070aaaa
# 111:775232005ee33f00fee39ff0aaaa9ff0aaaa5500fff05700ffff5700aaaa0700
# 112:0000aaff00000aaa000007770000007700000032000000000000000000000000
# 113:aaaff000a5500000222000007000000020000000000000000000000000000000
# 114:0077aaaa00000555000007770000077700000322000000000000000000000000
# 115:aaaff00005570000077700000322000000000000000000000000000000000000
# 116:00077aaa00077555000037700000322000000000000000000000000000000000
# 117:aaaff00005570000077700000777000003220000000000000000000000000000
# 124:00055fff00007550000077500000322000000000000000000000000000000000
# 125:fffff00005550000057700000577000005770000032200000000000000000000
# 126:000fffff00007550000077500000775000003220000000000000000000000000
# 127:fffff00005550000057700000577000003220000000000000000000000000000
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

