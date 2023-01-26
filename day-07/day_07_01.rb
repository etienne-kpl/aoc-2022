# frozen_string_literal: true

# INPUT = IO.readlines('test_input.txt', chomp: true)
INPUT = IO.readlines('input.txt', chomp: true)

commands = INPUT.dup.map(&:split)

# Default value is 0
# dir_sizes = Hash.new { |h, k| h[k] = 0 }
dir_sizes = {}
path = []
commands.each do |command|
  case command
  in ['$', 'cd', '..']
    p 'Moving up'
    path.pop
  in ['$', 'cd', dir]
    p "Moving in #{dir}"
    path << dir
  in ['$', 'ls']
    p 'listing files...'
  in ['dir', dir_name]
    p "- dir #{dir_name}"
  in [size, file_name]
    path.dup.length.times do |x|
      dir_sizes[path[0..x]] = 0 if dir_sizes[path[0..x]].nil?
      dir_sizes[path[0..x]] += size.to_i
    end
    p "- File #{file_name} of size #{size}"
  end
end

p dir_sizes
total_values = 0
dir_sizes.each_value { |v| total_values += v if v <= 100000 }
p total_values
