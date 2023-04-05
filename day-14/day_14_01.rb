# frozen_string_literal: true

INPUT = IO.readlines('test_input.txt', chomp: true).map do |line|
  line.split(' -> ').map do |el|
    x, y = el.split(',')
    {x: x.to_i, y: y.to_i}
  end
end

SAND = {x: 500, y: 0}
