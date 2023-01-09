# frozen_string_literal: true

# INPUT = IO.readlines('input.txt', chomp: true)
INPUT = open('test_input.txt').read
#divide by three

class Monkey
  @monkeys = {}
  def self.parse(monkey_data)
    n, i, o, t, tr, fa = monkey_data.split(/\n/)
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

Monkey 0:
  Starting items: 79, 98
  Operation: new = old * 19
  Test: divisible by 23
    If true: throw to monkey 2
    If false: throw to monkey 3
