# frozen_string_literal: true

INPUT = IO.readlines('test_input.txt', chomp: true)
# INPUT = IO.readlines('input.txt', chomp: true)

commands = INPUT.dup.map(&:split)

path = []
commands.each do |command|
  case command
  in ['$', 'cd', '..']
    p 'moving up'
    path.pop
  in ['$', 'cd', dir]
    p "moving in #{dir}"
    path << dir
  in ['$', 'ls']
    p 'listing files'
  in ['dir', dir_name]
    p "encountered dir #{dir_name}"
  in [size, file_name]
    p "encoutered file #{file_name} of size #{size}"
  end
  p path
end
