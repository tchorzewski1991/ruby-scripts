class Levenshtein
  def initialize(source, target)
    @s = source
    @t = target
  end

  def distance
    j, k = @s.length, @t.length

    return 0 if j.zero? || k.zero?

    matrix = Array.new(j + 1) { Array.new(k + 1) { 0 } }

    x, y = 0, 0

    while x <= j
      matrix[x][0] = x
      x += 1
    end

    while y <= k
      matrix[0][y] = y
      y += 1
    end

    y = 1
    while y <= k
      x = 1
      while x <= j
        cost = @s[x] == @t[y] ? 0 : 1

        matrix[x][y] = begin
          r = []

          r << matrix[x - 1][y] + 1
          r << matrix[x][y - 1] + 1
          r << matrix[x - 1][y - 1] + cost

          min, i = r.shift, 0

          while c = r[i]
            min = c if c <= min
            i += 1
          end

          min
        end

        x += 1
      end

      y += 1
    end

    matrix[j][k]
  end
end
