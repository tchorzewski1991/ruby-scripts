module Fibonacci
  # This module implements memoized version of
  # Fibonacci algorithm.
  #
  # Example usage:
  #   Fibonacci::Memoized.compute(5)
  #   => 5
  #
  module Memoized
    extend self

    def compute(n)
      @memo ||= { 0 => 0, 1 => 1 }
      @memo.fetch(n) { @memo[n] = compute(n - 2) + compute(n - 1) }
    end
  end
end
