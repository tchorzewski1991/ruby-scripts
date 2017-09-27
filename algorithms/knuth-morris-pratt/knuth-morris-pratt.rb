class KnuthMorrisPratt
  def initialize(source, target)
    @s = source
    @t = target
  end

  def compute
    k, j = s.length, t.length

    # Variable cs (common-subsequence) will refer to the longest
    # common subsequence that has been found
    cs = nil

    # Variable m refers to current index position in our source string
    # that will be searched. It is position where prospective match
    # for our target begins
    m = 0

    while m < k
      # For performance boost we can skip iteration for position
      # within the source which does not match potential begin of
      # our target string
      next(m += 1) if s[m] != t[0]

      # Variable temp_cs refers to temporary common subsequence
      # matched within each provided iteration
      temp_cs = ''

      # Variable i refers to current position in our target string
      # whom common subsequence we would like to find
      i = 0

      while i <= j
        t_char = t[i]

        # Expanding/Looking for common subsequence occure until the same
        # position within source and target are different. When different
        # characters will be encountered, 'else' branch of  the conditional
        # expression is executed, and position relative to the source string
        # is updated with value equals to length of current 'matches'.
        if s[m + i] == t_char
          temp_cs << t_char
          i += 1
        else
          m += i

          # Least but not least there's one more to consider. Within each of
          # temporary submatches (like for example: 'ABCDAB') the same starting
          # sequence could be encountered. It needs to be considered, when
          # setting up new value for our main 'm' variable. In the case above
          # new iteration should be executed from (m = m - 2) position, as it
          # is possible that it could be starting point for new 'better'
          # subsequence. Loop below just tries to figure out uniqueness of
          # each character within temporary subsequence. It is stopped in case
          # of finding duplicate. Appropriate position of duplicate will be
          # returned
          found, x = 0, 1

          while x < i
            break(found = x) if temp_cs[x] == t[0]
            x += 1
          end

          cs ||= temp_cs
          cs &&= temp_cs if temp_cs.length > cs.length

          m -= (temp_cs.length - found) unless found.zero?

          # Each 'falsy' branch will be stopped, as there is no chance for
          # finding more matches within current iteration
          break
        end
      end
    end

    cs
  end

  private
  attr_reader :s, :t
end
