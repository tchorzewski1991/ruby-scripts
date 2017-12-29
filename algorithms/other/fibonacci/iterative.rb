module Fibonacci
  # This module implements pure iterative version of
  # Fibonacci algorithm.
  #
  # Example usage:
  #   Fibonacci::Iterative.compute(5)
  #   => 5
  #
  module Iterative
    extend self

    def compute(n)
      i = 2
      numbers = [0, 1]

      while i <= n
        numbers[i] = numbers[i - 2] + numbers[i - 1]
        i += 1
      end

      numbers.last
    end
  end
end
