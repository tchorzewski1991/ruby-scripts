module Jaccard
  module Words
    DEFAULT_ROUND = 5

    # The Jaccard coefficient measures similarity between finite sample
    # sets. It is defined as the size of the intersection divided by the
    # size of the union of the sample sets. Algorithm itself is also known
    # as the Jaccard index or the Jaccard similarity coefficient. Algorithm
    # refers to a statistic used for comparing the similarity and diversity
    # of sample collections.
    #
    # Example:
    #   Returns value of similarity between origin and target with
    #   default rounding by 5.
    #
    #   Jaccard::Words.coefficient 'apple', 'applet'
    #   => 0.80000 (unfortunately those 0 will be cutted out.)
    #
    # Example:
    #   Returns value of distance between origin and target with
    #   custom rounding by 2.
    #
    #   Jaccard::Words.distance 'ala', 'ola', round: 2
    #   => 0.33
    #
    # Example:
    #   Returns value of similarity between origin and target with
    #   disabled rounding.
    #
    #   Jaccard::Words.coefficient 'ala', 'ola', round: false
    #   => 0.6666666666666666

    def self.coefficient(origin, target, round: DEFAULT_ROUND)
      # Variables origin_chars, and target_chars refer to temporary containers
      # for unique characters from both words. Iteration occures until both
      # strings will be reproduced in form of arrays. When iteration is
      # finished only thing to do is to produce intersection and union
      # basing on both of collections.

      _round_by_value(round) do
        o_codepoints = origin.codepoints
        t_codepoints = target.codepoints

        intersection = o_codepoints & t_codepoints
        union        = o_codepoints | t_codepoints

        intersection.length / Float(union.length)
      end
    end

    def self.distance(origin, target, round: DEFAULT_ROUND)
      _round_by_value(round) do
        1 - coefficient(origin, target, round: round)
      end
    end

    private

    # _round_by_value method refers to my personal prototyping / searching /
    # learning on various DRYing up techniques. I skipped a little bit of
    # repetitive code by implementing clousure.

    def self._round_by_value(value)
      return yield unless value
      yield.round Integer value
    rescue TypeError
      yield.round DEFAULT_ROUND
    end
  end
end
