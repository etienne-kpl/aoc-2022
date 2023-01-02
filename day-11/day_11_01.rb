# frozen_string_literal: true

# INPUT = IO.readlines('input.txt', chomp: true)
INPUT = open('test_input.txt').read

commands = INPUT.dup.split(/\n\n/)
commands.map! { |el| el.split(/\n/) }
commands.each {|el| el.map! { |el| el.scan(/\d+/)} }
p commands
#divide by three

class Monkey
  def initialize(attributes = {})
    @id = attributes[:id]
    @items = attributes[:items] || []
    @operation = attributes[:operation]
    @test = attributes[:test]
    @monkey_if_true = attributes[:monkey_if_true]
    @monkey_if_false = attributes[:monkey_if_false]
  end
end
