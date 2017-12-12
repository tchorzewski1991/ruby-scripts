module Fibonacci
  module Folding
    # This module implements folding(by mutation) version of
    # Fibonacci algorithm.
    #
    # Example usage:
    #   Fibonacci::Folding::Mutation.compute(5)
    #   => 5
    #
    module Mutation
      extend self

      # upto - inject variant
      def compute(n)
        2.upto(n).inject([0, 1]) do |memo, _|
          # This is where mutation of memo instance happens.
          memo << memo[-2] + memo[-1]
          memo
        end.last
      end
    end
  end
end
