class KnuthMorrisPratt
  def initialize(source, target)
    @s = source
    @t = target
  end

  def compute
    k, j = s.length, t.length

    cs = nil

    m = 0

    while m < k
      next(m += 1) if s[m] != t[0]

      temp_cs = ''

      i = 0

      while i <= j
        t_char = t[i]

        if s[m + i] == t_char
          temp_cs << t_char
          i += 1
        else
          m += i

          found, x = 0, 1

          while x < i
            break(found = x) if temp_cs[x] == t[0]
            x += 1
          end

          cs ||= temp_cs
          cs &&= temp_cs if temp_cs.length > cs.length

          m -= (temp_cs.length - found) unless found.zero?
          break
        end
      end
    end

    cs
  end

  private
  attr_reader :s, :t
end
