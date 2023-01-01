# frozen_string_literal: false

INPUT = IO.readlines('input.txt', chomp: true)
# INPUT = IO.readlines('test_input.txt', chomp: true)

commands = INPUT.map(&:split)

crt = ''
x = 1
i = 0
commands.each do |el|
  case el[0]
  when 'noop'
    crt << if ((x - 1)..(x + 1)).include?(i)
             '#'
           else
             '.'
           end
    (crt.size % 40).zero? ? i = 0 : i += 1
  when 'addx'
    2.times do
      crt << if ((x - 1)..(x + 1)).include?(i)
               '#'
             else
               '.'
             end
      (crt.size % 40).zero? ? i = 0 : i += 1
    end
    x += el[1].to_i
  end
end

crt.chars.each_slice(40) { |el| p el.join }
