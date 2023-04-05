# frozen_string_literal: true
require 'json'

# I must get rid of all the empty lists, otherwise the flatten will pass through them, hence the gsub
INPUT = IO.read('input.txt').gsub(/\n+/, ' ').gsub('[]', '[0]').split.map { |el| JSON.parse(el) }

array = INPUT.dup.append([[2]], [[6]])
array.sort_by! { |el| el.flatten }

a = array.find_index([[2]]) + 1
b = array.find_index([[6]]) + 1

p a * b
