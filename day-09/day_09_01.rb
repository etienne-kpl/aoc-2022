# frozen_string_literal: true

INPUT = IO.readlines('input.txt', chomp: true)

commands = INPUT.map do |el|
  regexp = /(\w) (\d+)/
  [regexp.match(el)[1], regexp.match(el)[2].to_i]
end

x = 0
y = 0

head_positions = [{ x: x, y: y }]
commands.map do |command|
  case command.first
  when 'U'
    command.last.times do
      y += 1
      head_positions << { x: x, y: y }
    end
  when 'R'
    command.last.times do
      x += 1
      head_positions << { x: x, y: y }
    end
  when 'D'
    command.last.times do
      y -= 1
      head_positions << { x: x, y: y }
    end
  when 'L'
    command.last.times do
      x -= 1
      head_positions << { x: x, y: y }
    end
  end
end

tail_positions = head_positions.clone.map(&:clone)

tail_positions.map.with_index do |el, i|
  if tail_positions[i + 1].nil?
    el
  elsif (tail_positions[i + 1][:x] - el[:x]).abs == 2 || (tail_positions[i + 1][:y] - el[:y]).abs == 2
    tail_positions[i + 1] = head_positions[i]
  else
    tail_positions[i + 1] = el
  end
end

p head_positions.size
p tail_positions.size
p tail_positions.uniq.size
