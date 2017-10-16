module Jaccard
  module Words
    DEFAULT_ROUND = 5

    class << self
      # The Jaccard coefficient measures similarity between finite sample sets,
      # and is defined as the size of the intersection divided by the size of
      # the union of the sample sets. Algorithm itself is also known as the
      # Jaccard index or the Jaccard similarity coefficient. Algorithm refers
      # to a statistic used for comparing the similarity and diversity of
      # sample collections.

      def coefficient(s, t)
        # Variables s_chars, and t_chars refer to temporary containers for
        # unique characters from both words. Iteration occures until both
        # strings will be reproduced in form of arrays. When iteration is
        # finished only thing to do is to produce intersection and union
        # basing on both of collections.
        s_chars = []
        t_chars = []

        i = 0
        while true
          t_char = t[i] and t_chars[i] = t_char.ord
          s_char = s[i] and s_chars[i] = s_char.ord

          t_char || s_char || break

          i += 1
        end

        intersection = t_chars & s_chars
        union = t_chars | s_chars


        (intersection.length / union.length.to_f).round(5)
      end

      def distance(s, t)
        (1 - coefficient(s, t)).round(5)
      end
    end
  end
end
