# -*- tab-width : 4; indent-tabs-mode : t  -*-

require '../race.rb'

race = Race.new(1, 1600, 1)
p race
6000.times do |i|
  race.simulate
  r=race.runner(0)
  print i, ":", r.position[0], " v:", r.speed
  print " r:", r.adj_resist, " a:", r.adj_accel
  print " pr:", r.power_ratio, "\n"
end

