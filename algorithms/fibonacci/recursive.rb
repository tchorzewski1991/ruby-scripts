module Fibonacci
  # This module implements pure recursive version of
  # Fibonacci algorithm.
  #
  # Example usage:
  #   Fibonacci::Recursive.compute(5)
  #   => 5
  #
  module Recursive
    extend self

    def compute(n)
      return 0 if n == 0
      return 1 if n == 1
      compute(n - 2) + compute(n - 1)
    end
  end
end
