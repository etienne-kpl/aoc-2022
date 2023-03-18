# frozen_string_literal: true
require 'json'

INPUT = IO.read('test_input.txt').split(/\n\n/).map do |pair|
  l, r = pair.split(/\n/)
  { l: JSON.parse(l), r: JSON.parse(r) }
end

# Got to rethink that part, so it produces 0 or 1 only
def compare(pair)
  p pair
  if pair.all? { |el| el.is_a? Array }
    pair.first.zip(pair.last).each do |new_pair|
      case compare(new_pair)
      when 0
        break 0
      when 1
        break 1
      end
    end
  elsif pair.all? { |el| el.is_a?(Integer) } && pair.first < pair.last
    return 0
  elsif pair.all? { |el| el.is_a?(Integer) } && pair.first > pair.last
    return 1
  elsif pair.last.nil?
    return 1
  elsif pair.first.is_a? Integer
    compare([[pair.first], pair.last])
  else
    compare([pair.first, [pair.last]])
  end
end

count = 0

# Must run, then break and go to next if 0, break and update if 1, update if none of this happened.
INPUT.each_with_index do |packet, index|
  p count
  p ""
  packet[:l].zip(packet[:r]).each do |pair|
    case compare(pair)
    when 0
      count += (index + 1)
      break
    when 1
      break
    else
      count += (index + 1)
    end
  end
end

p count
