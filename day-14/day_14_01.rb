# frozen_string_literal: true

INPUT = IO.readlines('test_input.txt', chomp: true).map do |line|
  line.split(' -> ').map do |el|
    x, y = el.split(',')
    {x: x.to_i, y: y.to_i}
  end
end

source = {x: 500, y: 0}
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

# Now I need to find the lowest point, so when an unit of sand will pass that point, it'll means we've reach the abyss
lowest = rocks.max_by { |el| el[:y]}[:y]

p bottom_line

p rocks
p rocks.size

sand_loc = []
# def produce_sand

# end
