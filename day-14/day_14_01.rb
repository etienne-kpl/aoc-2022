# frozen_string_literal: true

INPUT = IO.readlines('test_input.txt', chomp: true).map do |line|
  line.split(' -> ').map do |el|
    x, y = el.split(',')
    {x: x.to_i, y: y.to_i}
  end
end

rocks = []
INPUT.each do |line|
  line.each_cons(2) do |pair|
    if pair.first[:x] == pair.last[:x]
      if pair.first[:y] > pair.last[:y]
        count = pair.last[:y]
        until rocks.last == pair.first
          rocks << {x: pair.first[:x], y: count}
          count += 1
        end
      else
        count = pair.first[:y]
        until rocks.last == pair.last
          rocks << {x: pair.first[:x], y: count}
          count += 1
        end
      end
    else
      if pair.first[:x] > pair.last[:x]
        count = pair.last[:x]
        until rocks.last == pair.first
          rocks << {x: count, y: pair.first[:y]}
          count += 1
        end
      else
        count = pair.first[:y]
        until rocks.last == pair.last
          rocks << {x: count, y: pair.first[:y]}
          count += 1
        end
      end
    end
  end
end

SOURCE = {x: 500, y: 0}

sand_loc = []
p rocks
p rocks.size

# def produce_sand

# end
