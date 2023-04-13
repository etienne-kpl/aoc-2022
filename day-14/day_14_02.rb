# frozen_string_literal: true

INPUT = IO.readlines('test_input.txt', chomp: true).map do |line|
  line.split(' -> ').map do |el|
    x, y = el.split(',')
    { x: x.to_i, y: y.to_i }
  end
end

source = { x: 500, y: 0 }
rocks = []

INPUT.each do |line|
  rocks << line.first
  line.each_cons(2) do |pair|
    until rocks.last == pair.last
      rocks << if pair.first[:x] == pair.last[:x]
                 { x: pair.first[:x], y: (pair.first[:y] < pair.last[:y] ? rocks.last[:y] + 1 : rocks.last[:y] - 1) }
               else
                 { x: (pair.first[:x] < pair.last[:x] ? rocks.last[:x] + 1 : rocks.last[:x] - 1), y: pair.first[:y] }
               end
    end
  end
end

# Some lines might cross, so I get rid of multiple references
rocks.uniq!

# When an unit of sand will reach that point, it'll means we've reach the bottom
# +1 because the rocks are under it
lowest = rocks.max_by { |el| el[:y] }[:y] + 1

sands = rocks.dup

unit = source.dup
def find_bottom(unit, sands)
  sands.select { |el| el[:x] == unit[:x] }.max_by { |el| el[:y] }[:y] - 1
end

until sands.include?(source)
  # It's too slow step by step, so I check the furthest point vertically
  unit[:y] = find_bottom(unit, sands)
  if unit[:y] == lowest
    sands << unit
    unit = source.dup
  elsif !sands.include?({ x: unit[:x] - 1, y: unit[:y] + 1 })
    unit[:x] -= 1
    unit[:y] += 1
  elsif !sands.include?({ x: unit[:x] + 1, y: unit[:y] + 1 })
    unit[:x] += 1
    unit[:y] += 1
  else
    sands << unit
    unit = source.dup
  end
end

p "lowest point: #{lowest}"
p "Nb of rocks: #{rocks.size}"
p "Nb of sands unit: #{sands.size - rocks.size}"
