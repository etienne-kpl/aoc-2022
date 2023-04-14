# frozen_string_literal: true

INPUT = IO.readlines('input.txt', chomp: true).map do |line|
  line.split(' -> ').map do |el|
    x, y = el.split(',')
    [x.to_i, y.to_i]
  end
end

SOURCE = [500, 0].freeze
rocks = []

INPUT.each do |line|
  rocks << line.first
  line.each_cons(2) do |pair|
    until rocks.last == pair.last
      rocks << if pair.first.first == pair.last.first
                 [pair.first.first, (pair.first.last < pair.last.last ? rocks.last.last + 1 : rocks.last.last - 1)]
               else
                 [(pair.first.first < pair.last.first ? rocks.last.first + 1 : rocks.last.first - 1), pair.first.last]
               end
    end
  end
end

# Some lines might cross, so I get rid of multiple references
rocks.uniq!

# When an unit of sand will reach that point, it'll means we've reach the bottom
# +1 because the rocks are under it
lowest = rocks.max_by(&:last).last + 1

# I'll store the sands unit in an array containing the rocks
sands = rocks.dup

unit = SOURCE.dup
until sands.include?(SOURCE)
  # find the bottom on the same x axis, without the rocks above the y position
  bottom = sands.select { |el| el.first == unit.first && el.last > unit.last }.min_by(&:last)
  unit[1] = bottom.nil? ? lowest : bottom.last - 1
  if unit.last == lowest
    sands << unit
    unit = SOURCE.dup
  elsif !sands.include?([unit.first - 1, unit.last + 1])
    unit[0] -= 1
  elsif !sands.include?([unit.first + 1, unit.last + 1])
    unit[0] += 1
  else
    sands << unit
    unit = SOURCE.dup
  end
end

p "lowest point: #{lowest}"
p "Nb of rocks: #{rocks.size}"
p "Nb of sands unit: #{sands.size - rocks.size}"

# INPUT = IO.readlines('test_input.txt', chomp: true).map do |line|
#   line.split(' -> ').map do |el|
#     x, y = el.split(',')
#     { x: x.to_i, y: y.to_i }
#   end
# end

# SOURCE = { x: 500, y: 0 }.freeze
# rocks = []

# INPUT.each do |line|
#   rocks << line.first
#   line.each_cons(2) do |pair|
#     until rocks.last == pair.last
#       rocks << if pair.first[:x] == pair.last[:x]
#                  { x: pair.first[:x], y: (pair.first[:y] < pair.last[:y] ? rocks.last[:y] + 1 : rocks.last[:y] - 1) }
#                else
#                  { x: (pair.first[:x] < pair.last[:x] ? rocks.last[:x] + 1 : rocks.last[:x] - 1), y: pair.first[:y] }
#                end
#     end
#   end
# end

# # Some lines might cross, so I get rid of multiple references
# rocks.uniq!

# When an unit of sand will reach that point, it'll means we've reach the bottom
# +1 because the rocks are under it
# lowest = rocks.max_by { |el| el[:y] }[:y] + 1

# sands = rocks.dup

# unit = SOURCE.dup
# until sands.include?(SOURCE)
#   # find the bottom on the same x axis, without the rocks above the y position
#   bottom = sands.select { |el| el[:x] == unit[:x] && el[:y] > unit[:y] }.min_by { |el| el[:y] }
#   unit[:y] = bottom.nil? ? lowest : bottom[:y] - 1
#   if unit[:y] == lowest
#     sands << unit
#     unit = SOURCE.dup
#     p sands.last
#   elsif !sands.include?({ x: unit[:x] - 1, y: unit[:y] + 1 })
#     unit[:x] -= 1
#   elsif !sands.include?({ x: unit[:x] + 1, y: unit[:y] + 1 })
#     unit[:x] += 1
#   else
#     sands << unit
#     unit = SOURCE.dup
#     p sands.last
#   end
# end

# p "lowest point: #{lowest}"
# p "Nb of rocks: #{rocks.size}"
# p "Nb of sands unit: #{sands.size - rocks.size}"
