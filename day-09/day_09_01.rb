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

# tail_positions = head_positions.each_cons(2).map do |cur, nxt|
#   if (nxt[x] - cur[x]).abs >= 2 && nxt[y] = cur[y]

#   end
# end


p head_positions.first(10)
# p tail_positions.first(10)
p head_positions.uniq.size
