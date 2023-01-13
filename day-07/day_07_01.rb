# frozen_string_literal: true

INPUT = IO.readlines('test_input.txt', chomp: true)
# INPUT = IO.readlines('input.txt', chomp: true)

commands = INPUT.dup.map(&:split)

commands.each do |command|
  case command
  when ['$', 'cd', '..'] then p 'moving up'
  when ['$', 'cd', dir] then p "moving in #{dir}"
  when ['$', 'ls'] then p 'listing files'
  when ['dir', dir_name] then p "encountered dir #{dir_name}"
  when ['dir', dir_name] then p "encountered dir #{dir_name}"
  when [size, file_name] then p "encoutered file #{file_name} of size #{size}"
  end
end
