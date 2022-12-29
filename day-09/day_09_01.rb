# frozen_string_literal: true

INPUT = IO.readlines('input.txt', chomp: true)

array = INPUT.map do |el|
  regexp = /(\w) (\d+)/
  [regexp.match(el)[1], regexp.match(el)[2].to_i]
end

p array
