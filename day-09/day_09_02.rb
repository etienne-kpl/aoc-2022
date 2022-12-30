# frozen_string_literal: true

INPUT = IO.readlines('input.txt', chomp: true)

# INPUT = ['R 5', 'U 8', 'L 8', 'D 3', 'R 17', 'D 10', 'L 25', 'U 20']

# INPUT = ['R 4', 'U 4', 'L 3', 'D 1', 'R 4', 'D 1', 'L 5', 'R 2']

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

nodes_array = [head_positions]

9.times do
  current_node = nodes_array.last.clone.map(&:clone)
  nodes_array << current_node

  current_node.map.with_index do |el, i|
    break if current_node[i + 1].nil?

    if current_node[i + 1][:x] - el[:x] == 2
      current_node[i + 1][:x] = el[:x] + 1
    elsif current_node[i + 1][:x] - el[:x] == -2
      current_node[i + 1][:x] = el[:x] - 1
    elsif current_node[i + 1][:y] - el[:y] == 2
      current_node[i + 1][:y] = el[:y] + 1
    elsif current_node[i + 1][:y] - el[:y] == -2
      current_node[i + 1][:y] = el[:y] - 1
    else
      current_node[i + 1] = el
    end
  end
end

p nodes_array.last.flatten.uniq.size
