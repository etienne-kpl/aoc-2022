# frozen_string_literal: true
require 'json'

INPUT = IO.read('test_input.txt').gsub(/\n+/, ' ').split.map { |el| JSON.parse(el) }

array = INPUT.dup.append([[2]], [[6]])
array.sort_by! { |el| el.flatten }

p array

a = array.find_index([[2]]) + 1
b = array.find_index([[6]]) + 1

p a * b
