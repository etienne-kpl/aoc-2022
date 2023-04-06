# frozen_string_literal: true

INPUT = IO.readlines('test_input.txt', chomp: true).map do |line|
  line.split(' -> ').map do |el|
    x, y = el.split(',')
    {x: x.to_i, y: y.to_i}
  end
end

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

SOURCE = {x: 500, y: 0}

sand_loc = []
p INPUT
p rocks
p rocks.size

# def produce_sand

# end
