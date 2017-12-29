module Fibonacci
  # This module implements hash version of
  # Fibonacci algorithm.
  #
  # Example usage:
  #   Fibonacci::Hash.compute(5)
  #   => 5
  #
  module Hash
    extend self

    def compute(n)
      fib = ::Hash.new { |hash, key| hash[key] = fib[key - 2] + fib[key - 1] }
      fib.update(0 => 0, 1 => 1)
      fib[n]
    end
  end
end
