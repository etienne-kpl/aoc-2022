# frozen_string_literal: true

INPUT = IO.readlines('test_input.txt', chomp: true).map do |line|
  line.split(' -> ').map do |el|
    x, y = el.split(',')
    { x: x.to_i, y: y.to_i }
  end
end

SOURCE = { x: 500, y: 0 }.freeze
parsed_input = []

INPUT.each do |line|
  parsed_input << line.first
  line.each_cons(2) do |pair|
    until parsed_input.last == pair.last
      parsed_input << if pair.first[:x] == pair.last[:x]
                 { x: pair.first[:x], y: (pair.first[:y] < pair.last[:y] ? parsed_input.last[:y] + 1 : parsed_input.last[:y] - 1) }
               else
                 { x: (pair.first[:x] < pair.last[:x] ? parsed_input.last[:x] + 1 : parsed_input.last[:x] - 1), y: pair.first[:y] }
               end
    end
  end
end

# Some lines might cross, so I get rid of multiple references
parsed_input.uniq!

# More efficient data structure
rocks = {}
parsed_input.each do |el|
  # If the key returns nil, I assign it with an empty array to store the :y locations
  rocks[el[:x]] ||= []
  rocks[el[:x]] << el[:y]
end

# When an unit of sand will reach that point, it'll means we've reach the bottom
lowest = rocks.values.flatten.max + 2

# I store the sands unit in an array containing the rocks
sands = rocks.clone

unit = SOURCE.dup
until sands[SOURCE[:x]].include? SOURCE[:y]
  # find the bottom on the same x axis, without the rocks above the y position
  bottom = sands[unit[:x]].nil? || sands[unit[:x]].select { |el| el > unit[:y] }.min.nil? ? lowest : sands[unit[:x]].select { |el| el > unit[:y] }.min
  # move on top of it
  unit[:y] = bottom - 1
  if unit[:y] == lowest - 1
    sands[unit[:x]] = []
    sands[unit[:x]] << unit[:y]
    unit = SOURCE.dup
  elsif sands[(unit[:x] - 1)].nil? || !sands[(unit[:x] - 1)].include?(unit[:y] + 1)
    unit[:x] -= 1
  elsif sands[(unit[:x] + 1)].nil? || !sands[(unit[:x] + 1)].include?(unit[:y] + 1)
    unit[:x] += 1
  else
    sands[unit[:x]] << unit[:y]
    unit = SOURCE.dup
  end
end

p "lowest point: #{lowest}"
p "Nb of rocks: #{rocks.values.flatten.size}"
p "Nb of sands unit: #{sands.values.flatten.size - rocks.values.flatten.size}"

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
