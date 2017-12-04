module Luhn
  extend self

  # The Luhn algorithm or Luhn formula, also known as the "modulus 10"
  # or "mod 10" algorithm, is a simple checksum formula used to validate
  # a variety of identification numbers, such as credit card numbers.
  #
  # Example: Basic usage
  #   Returns true or false depending on Luhn formula computation
  #
  #   Luhn.valid?(1234)
  #   => false
  #

  class Input
    # I took into account that this is definitely not the necessary step to
    # proceed our computation of Lunh formula, but I want to make sure that
    # my code is protected before malicious duck typing. Input class is simple
    # 'value' object to prevent from using primitives and to provide simple,
    # separated validation step. Please feel free to contribute, and comment
    # on that step, as this only plays role of experiment.

    # Returns new instance of Input class. Ensures input data is converted
    # into string, and assigns appropriate instance variable for future use.
    def initialize(input)
      @input = String(input)
        .delete(' ')
        .delete('_')
    end

    # Returns character specified by index.
    def [](index)
      input[index]
    end

    # Validates input data. Ensures input data contains at least one digit,
    # and refutes input data in case of presence of non-digit characters.
    def valid?
      (input !~ /\D/) & (input =~ /\d+/)
    end

    private
    attr_reader :input
  end

  # Returns true or false depending on internal Luhn formula computation.
  # See https://en.wikipedia.org/wiki/Luhn_algorithm for algorithm description.
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
