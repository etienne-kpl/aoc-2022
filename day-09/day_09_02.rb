# frozen_string_literal: true

INPUT = IO.readlines('input.txt', chomp: true)

# INPUT = ['R 5', 'U 8', 'L 8', 'D 3', 'R 17', 'D 10', 'L 25', 'U 20']

# INPUT = ['R 4', 'U 4', 'L 3', 'D 1', 'R 4', 'D 1', 'L 5', 'R 2']

commands = INPUT.map(&:split).each { |el| el[1] = el[1].to_i }

x = 0
y = 0

head_positions = [[x, y]]
commands.each do |command|
  command[1].times do
    case command[0]
    when 'U' then y += 1
    when 'R' then x += 1
    when 'D' then y -= 1
    when 'L' then x -= 1
    end
    head_positions << [x, y]
  end
end
nodes_array = [head_positions]

9.times do
  current_node = nodes_array.last.clone.map(&:clone)
  nodes_array << current_node

  current_node.each_cons(2) do |cur, nxt|
    if (nxt[0] - cur[0]).abs <= 1 && (nxt[1] - cur[1]).abs <= 1
      nxt[0] = cur[0]
      nxt[1] = cur[1]
    end

    if (nxt[0] - cur[0]).abs >= 2
      nxt[0] = cur[0] + ((nxt[0] - cur[0]).positive? ? 1 : -1)
    end

    if (nxt[1] - cur[1]).abs >= 2
      nxt[1] = cur[1] + ((nxt[1] - cur[1]).positive? ? 1 : -1)
    end
  end
end

nodes_array.each { |el| p el.uniq.size }
