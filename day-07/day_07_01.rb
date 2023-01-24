# frozen_string_literal: true

INPUT = IO.readlines('test_input.txt', chomp: true)
# INPUT = IO.readlines('input.txt', chomp: true)

commands = INPUT.dup.map(&:split)

commands.each do |command|
  case command
  in ['$', 'cd', '..'] then p 'moving up'
  in ['$', 'cd', dir] then p "moving in #{dir}"
  in ['$', 'ls'] then p 'listing files'
  in ['dir', dir_name] then p "encountered dir #{dir_name}"
  in [size, file_name] then p "encoutered file #{file_name} of size #{size}"
  end
end
