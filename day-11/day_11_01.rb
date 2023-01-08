# frozen_string_literal: true

# INPUT = IO.readlines('input.txt', chomp: true)
INPUT = open('test_input.txt').read
#divide by three

class Monkey
  @monkeys = {}
  def self.parse(monkey_data)
    name = monkey_data.split(/\n/)

  end
  def initialize(attributes = {})
    @id = attributes[:id]
    @items = attributes[:items] || []
    @operation = attributes[:operation]
    @test = attributes[:test]
    @monkey_if_true = attributes[:monkey_if_true]
    @monkey_if_false = attributes[:monkey_if_false]
  end
end

INPUT.dup.split(/\n\n/).each do |monkey_data|
  Monkey.parse(monkey_data)
end
