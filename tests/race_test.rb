# -*- tab-width : 4; indent-tabs-mode : t  -*-

require '../race.rb'

class Float
    def fmt
        sprintf("%.5f", self)
    end
end

race = Race.new(1, 1600, 1)
p race
(120*60).times do |i|
  race.simulate
  r=race.runner(0)
  print (i/60.0).fmt
  print " d:", r.position[0].fmt, " v:", r.speed.fmt
  print " r:", r.resist_speed_diff.fmt, " a:", r.accel_speed_diff.fmt
  print " ti:", r.target_impact_par_tick.fmt
  print " ri:", r.remained_impact.fmt, "\n"
end

