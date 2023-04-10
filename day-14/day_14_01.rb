# frozen_string_literal: true

INPUT = IO.readlines('test_input.txt', chomp: true).map do |line|
  line.split(' -> ').map do |el|
    x, y = el.split(',')
    {x: x.to_i, y: y.to_i}
  end
end

SOURCE = {x: 500, y: 0}
rocks = []

INPUT.each do |line|
  rocks << line.first
  line.each_cons(2) do |pair|
    until rocks.last == pair.last
      if pair.first[:x] == pair.last[:x]
        rocks << {x: pair.first[:x], y: (pair.first[:y] < pair.last[:y] ? rocks.last[:y] + 1 : rocks.last[:y] - 1)}
      else
        rocks << {x: (pair.first[:x] < pair.last[:x] ? rocks.last[:x] + 1 : rocks.last[:x] - 1), y: pair.first[:y]}
      end
    end
  end
end

# Some lines might cross, but I only need one reference for each one
rocks.uniq!

# When an unit of sand will pass that point, it'll means we've reach the abyss
LOWEST = rocks.max_by { |el| el[:y]}[:y]

p LOWEST
p rocks.size

SANDS = rocks.dup
def produce_sand
  unit = SOURCE.dup
  until unit[:y] == LOWEST
    if !SANDS.include?({x: unit[:x], y: unit[:y] + 1})
      unit[:y] += 1
    elsif !SANDS.include?({x: unit[:x] - 1, y: unit[:y] + 1})
      unit[:x] -= 1
      unit[:y] += 1
    elsif !SANDS.include?({x: unit[:x] + 1, y: unit[:y] + 1})
      unit[:x] += 1
      unit[:y] += 1
    else
      SANDS << unit
      produce_sand
    end
  end
end

produce_sand

# The size here is not good
p (SANDS - rocks).size
