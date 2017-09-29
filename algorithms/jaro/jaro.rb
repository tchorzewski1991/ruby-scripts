class Jaro
  def initialize(s, t)
    @source, @target = s.length > t.length ? [t, s] : [s, t]
    @window = ([@source.length, @target.length].max / 2).floor - 1
  end

  def distance
    window = @window

    shorter, longer = @source, @target
    shorter_length, longer_length = shorter.length, longer.length

    matches = []
    match = 0
    match_in_window = 0
    match_out_of_position = 0
end
