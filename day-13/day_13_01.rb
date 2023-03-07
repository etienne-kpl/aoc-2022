# frozen_string_literal: true
require 'json'

INPUT = IO.read('test_input.txt').split(/\n\n/).map do |pair|
  l, r = pair.split(/\n/)
  { l: JSON.parse(l), r: JSON.parse(r) }
  # { l: l, r: r }
end

def compare(pair)
  if pair.all? { |el| el.is_a? Array }
    pair.first.zip(pair.last).each do |new_pair|
      compare(new_pair)
    end
  elsif pair.all? { |el| el.is_a? Integer }
    !pair.last.nil? && pair.first <= pair.last
  elsif pair.first.is_a? Integer
    compare([[pair.first], pair.last])
  else
    compare([pair.first, [pair.last]])
  end
end

count = 0

INPUT.each_with_index do |el, i|
  el[:l].zip(el[:r]).each do |pair|
    p pair
    # count += (i + 1) if compare(pair)
  end
end

p count
