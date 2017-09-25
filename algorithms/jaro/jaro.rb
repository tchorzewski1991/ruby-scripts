class Jaro
  def initialize(source, target)
    @source = source
    @target = target
    @restriction = ([@source.length, @target.length].max / 2).floor - 1
  end

  def distance
    # Two characters from both strings respectively, are considered
    # matching only if they are the same and not farther than
    # (max(|s|, |t|) / 2)).floor - 1. By considering 'not farther than'
    # we mean difference in index positions between two characters.
    m = 0

    # The number of matching (but different sequence order) characters
    # divided by 2 defines the number of transpositions. By defining 't'
    # variable we would like refer to half the number of transpositions.
    t = 0

    i = 0
    while s_char = @source[i]
      j = 0
      while t_char = @target[j]
        next(j += 1) if s_char != t_char

        k = j - i
        k < 0 ? k *=-1 : k
        k <= @restriction ? m += 1 : t += 1

        j += 1
      end

      i += 1
    end

    return 0 if m == 0

    (1/3r * (m / i.to_f + m / j.to_f + (m - t / 4) / m)).round(3)
  end
end
