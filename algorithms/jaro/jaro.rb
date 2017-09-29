class Jaro
  def initialize(s, t)
    @source, @target = s.length > t.length ? [t, s] : [s, t]
    @window = ([@source.length, @target.length].max / 2).floor - 1
  end

  def distance
    # Two characters from both strings respectively, are considered
    # matching only if they are the same and not farther than
    # (max(|s|, |t|) / 2)).floor - 1. By considering 'not farther than'
    # we mean difference in index positions between two characters.
    # Variable window refers to 'range' described above.
    # Variable match_in_window is self describing.
    window = @window

    # It's important to know that we always need to start iteration
    # from shorter to longer text. Those two are encountered during
    # initialization.
    shorter, longer = @source, @target
    shorter_length, longer_length = shorter.length, longer.length

    matches = []
    match = 0
    match_in_window = 0
    match_out_of_position = 0

    # To find number of matches we need to start iteration from shorter
    # string. For each specific character in our source we iterate through all
    # target characters. Appropriate  'match' will happen when target character
    # will be found within specified window range. We can divide that process
    # into two separate subprocesses. For performance optimalization - direct
    # match can jump to next iteration without an effort. This refers to first
    # subprocess. Second one is nothing more than finding matches within
    # window. Range boundaries are set for each iteration.
    i = 0
    while i < shorter_length
      s = shorter[i]

      next(
        match += 1
        matches << s
        i += 1
      ) if s == longer[i]

      backward = i - window < 0 ? 0 : i - window
      forward = longer[i + window] ? i + window : longer_length - 1

      while backward <= forward
        if s == longer[backward]
          break(
            match_in_window += 1
            matches << s
          )
        end

        backward += 1
      end

      i += 1
    end

    return 0 if (match += match_in_window) == 0
end
