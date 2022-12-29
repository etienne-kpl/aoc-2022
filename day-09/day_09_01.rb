# frozen_string_literal: true

INPUT = IO.readlines('input.txt', chomp: true)

commands = INPUT.map do |el|
  regexp = /(\w) (\d+)/
  [regexp.match(el)[1], regexp.match(el)[2].to_i]
end

x = 0
y = 0

visited_positions = [{ x: x, y: y }]
commands.map do |command|
  case command.first
  when 'U' then y += 1
  when 'R' then x += 1
  when 'D' then y -= 1
  when 'L' then x -= 1
  end
  visited_positions << { x: x, y: y }
end

p x
p y
p visited_positions.uniq.size
