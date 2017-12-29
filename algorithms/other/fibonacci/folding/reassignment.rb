module Fibonacci
  module Folding
    # This module implements folding(by reassignment) version of
    # Fibonacci algorithm.
    #
    # Example usage:
    #   Fibonacci::Folding::Reassignment.compute(5)
    #   => 5
    #
    module Reassignment
      extend self

      # upto - inject variant
      def compute(n)
        2.upto(n).inject([0, 1]) do |memo, i|
          # This is where reassignment of memo instance happens.
          memo[i] = memo[i - 2] + memo[i - 1]
          memo
        end.last
      end
    end
  end
end
