module Luhn
  extend self

  class Input
    def initialize(input)
      @input = String(input)
        .delete(' ')
        .delete('_')
    end

    def [](index)
      input[index]
    end

    def valid?
      (input !~ /\D/) & (input =~ /\d+/)
    end

    private
    attr_reader :input
  end

  def valid?(input)
    input = Input.new(input)

    if input.valid?
      sum, i = 0, 0

      while c = input[i]
        c = c.to_i
        sum += begin
          i % 2 == 0 &&
            (c = c * 2 and c > 9 ? c -= 9 : c) || c
        end
        i += 1
      end

      (sum % 10).zero?
    else
      false
    end
  end
end
