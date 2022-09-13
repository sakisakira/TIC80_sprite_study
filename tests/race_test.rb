# -*- tab-width : 4; indent-tabs-mode : t  -*-

require '../race.rb'

race = Race.new(1, 1600)
p race
6000.times do |i|
  race.simulate
  r=race.runner(0)
  print i, ":", r.position[0], ":", r.speed, "\n"
end

