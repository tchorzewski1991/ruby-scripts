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
    end
  end
end
