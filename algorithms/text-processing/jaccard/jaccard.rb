module Jaccard
  module Words
    DEFAULT_ROUND = 5

    # The Jaccard coefficient measures similarity between finite sample sets,
    # and is defined as the size of the intersection divided by the size of
    # the union of the sample sets. Algorithm itself is also known as the
    # Jaccard index or the Jaccard similarity coefficient. Algorithm refers
    # to a statistic used for comparing the similarity and diversity of
    # sample collections.
    #
    # Example: Basic usage
    #   Returns value of similarity between origin and target
    #
    #   Jaccard::Words.coefficient 'apple', 'applet'
    #   => 0.8
    #
    # Example: Basic usage
    #   Returns value of distance between origin and target
    #
    #   Jaccard::Words.distance 'apple', 'applet'
    #   => 0.2

    def self.coefficient(origin, target)
      # Variables origin_chars, and target_chars refer to temporary containers
      # for unique characters from both words. Iteration occures until both
      # strings will be reproduced in form of arrays. When iteration is
      # finished only thing to do is to produce intersection and union
      # basing on both of collections.
      origin_chars = []
      target_chars = []

      i = 0

      while true
        target_char = target[i] and target_chars[i] = target_char.ord
        origin_char = origin[i] and origin_chars[i] = origin_char.ord

        target_char || origin_char || break

        i += 1
      end

      intersection = target_chars & origin_chars
      union        = target_chars | origin_chars


      (intersection.length / union.length.to_f).round(5)
    end

    def self.distance(origin, target)
      (1 - coefficient(origin, target)).round(5)
    end
  end
end
