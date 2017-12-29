require 'benchmark/ips'
require 'string/similarity'

class WordCosineSimilarity
  class << self
    def compute(s, t)
      # Cosine similarity is literally the angular difference between two
      # vectors. Algorithm itself refers to highly preferable solution for
      # measuring similarity of two texts. Cosine similarity is most commonly
      # used in high-dimensional positive spaces, so it fits perfectly into
      # context of information retrival or text mining.

      # Variables s_occurences, t_occurences refers to vector representation of
      # given words. A virtue of using cosine similarity is clearly that it
      # converts a question that is beyond human ability to visualise to one
      # that can be. Simple example will be the best proof.
      # Lets examine words 'bob', and 'rob'. Their vector representation could
      # be considered as two vectors of fixed size. What is beyond human ability
      # to understand is dimensionality. The 'bob' example is quite straight
      # forward. Every letter refers to one new dimension, so it's
      # summerized as 3-dimensions vector of values (2, 1, 0).
      # Little bit more frustrating to visualize could be word 'cosine'. With
      # the prevoius convention it's 6-dimenisional vector with corresponding
      # values (1, 1, 1, 1, 1, 1).

      s_occurences = Hash.new { |hash, key| hash[key] = 0 }
      t_occurences = Hash.new { |hash, key| hash[key] = 0 }

      # First part of the algorithm is fairly simple. We want to populate
      # previously declared hashes (kind of containers) with number of
      # occurences for the each of uniq characters. One interesting part is
      # to use as a hash key integer representation of string. As there could
      # be only one representation of the number in ruby - this is big
      # optimalization improvement.
      s_length = s.length
      t_length = t.length

      ords = []
      i = 0
      while i < s_length
        x = s[i].ord
        ords |= [x]
        s_occurences[x] += 1
        i += 1
      end

      j = 0
      while j < t_length
        y = t[j].ord
        t_occurences[y] += 1
        j += 1
      end

      # Second part is a little bit of math. To compute our dot product we can
      # pay attention at only one set of uniq characters. Therefore [b,o] is
      # enough. It's happening because of multiplication with zeros issue.
      # Lets examine one more time 'bob' and 'rob' example.
      # Dot product: (2,1,0) dot (1,1,1) = 2 * 1 + 1 * 1 + 1 * 0.
      # Last computation could be explained as the ability to use only one set
      # of uniq characters.
      numerator = 0

      k = 0
      while true
        o = ords[k] or break
        numerator += (s_occurences[o] * t_occurences[o])
        k += 1
      end

      s_values = s_occurences.values
      t_values = t_occurences.values

      s_magnitude = 0
      t_magnitude = 0

      l = 0
      while true
        x = s_values[l]
        y = t_values[l]

        x || y || break

        x && (s_magnitude += x**2)
        y && (t_magnitude += y**2)

        l += 1
      end

      s_magnitude = Math.sqrt(s_magnitude).to_f
      t_magnitude = Math.sqrt(t_magnitude).to_f

      (numerator / (s_magnitude * t_magnitude)).round(5)
    end
  end
end

Benchmark.ips do |x|
  # There aren't any limits in terms of usage ruby features.
  x.report 'Existing ruby implementation' do
    String::Similarity.cosine 'bob', 'rob'
  end

  # Just like always in that repo - implementation with minimum
  # effort of ruby built-in features. I thing benchmark results are
  # quite satisfying
  x.report 'Limited ruby implementation' do
    WordCosineSimilarity.compute('bob', 'rob')
  end

  x.compare!
end

# Existing ruby implementation    14.876k i/100ms
# Limited ruby implementation     10.720k i/100ms
# Calculating -------------------------------------
# Existing ruby implementation   164.069k (± 6.6%) i/s - 818.180k in 5.010700s
# Limited ruby implementation    118.625k (± 5.6%) i/s - 600.320k in 5.077530s
#
# Comparison:
# Existing ruby implementation:  164068.8 i/s
# Limited ruby implementation:   118624.6 i/s - 1.38x slower
