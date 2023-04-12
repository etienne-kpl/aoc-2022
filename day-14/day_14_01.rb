# frozen_string_literal: true

INPUT = IO.readlines('input.txt', chomp: true).map do |line|
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

# When an unit of sand will pass that point, it'll means we've reach the abyss
lowest = rocks.max_by { |el| el[:y] }[:y]

sands = rocks.dup

unit = source.dup
until unit[:y] >= lowest
  if !sands.include?({ x: unit[:x], y: unit[:y] + 1 })
    unit[:y] += 1
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
