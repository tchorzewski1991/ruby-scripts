module KnuthMorrisPratt
  extend self

  def compute(origin, target)
    k, j = origin.length, target.length

    # Variable common_subsequence refers to the longest common
    # subsequence which we would like to find in our origin string.
    common_subsequence = nil

    # Variable m refers to index position in our source string.
    # It is the position where prospective match for our target string
    # begins.
    m = 0

    while m < k
      # For performance boost we can skip iterating through positions
      # where the origin string does not match potential begin of
      # our target string.
      next(m += 1) if origin[m] != target[0]

      # Variable temporary_subsequence refers to string (common
      # subsequence) matched within current iteration
      temporary_subsequence = ''

      # Variable i refers to position in our target string
      # whom common subsequence we would like to find
      i = 0

      while i <= j
        target_char = target[i]

        # Expanding/Looking for common subsequence occure until the same
        # position within origin and target strings are different. When
        # different characters will be encountered, 'else' branch of the
        # conditional statement is executed, and position relative to the
        # origin string is updated with value equals to length of current
        # 'matches'.
        if origin[m + i] == target_char
          temporary_subsequence << target_char
          i += 1
        else
          m += i

          # Least but not last there's one more to consider. Within each of
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
            break(found = x) if temporary_subsequence[x] == target[0]
            x += 1
          end

          common_subsequence ||= temporary_subsequence

          if temporary_subsequence.length > common_subsequence.length
            common_subsequence = temporary_subsequence
          end

          m -= (temporary_subsequence.length - found) unless found.zero?

          # Each 'falsy' branch will be stopped, as there is no chance for
          # finding more matches within current iteration
          break
        end
      end
    end

    common_subsequence
  end
end
