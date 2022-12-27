# frozen_string_literal: true

INPUT = IO.readlines('input.txt', chomp: true).join

def get_marker_position
  array = INPUT.dup.chars
  array.each_cons(4) do |el|
    return el.join if el.uniq.size == 4
  end
end

def get_message_position
  array = INPUT.dup.chars
  array.each_cons(14) do |el|
    return el.join if el.uniq.size == 14
  end
end


p INPUT.index(get_message_position) + 14
