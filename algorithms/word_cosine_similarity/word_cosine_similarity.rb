class WordCosineSimilarity
  class << self
    def compute(s, t)
      s_occurences = Hash.new { |hash, key| hash[key] = 0 }
      t_occurences = Hash.new { |hash, key| hash[key] = 0 }

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
