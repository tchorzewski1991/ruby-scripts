class Jaro
  def initialize(s, t)
    @source, @target = s.length > t.length ? [t, s] : [s, t]
    @window = ([@source.length, @target.length].max / 2).floor - 1
  end

  def distance
  end
end
