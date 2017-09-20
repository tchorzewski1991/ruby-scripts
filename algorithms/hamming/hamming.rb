class Hamming
  def initialize(source, target, **opts)
    @source = source
    @target = target
  end

  def distance
    j, k = @source.length, @target.length

    return if j != k

    i, diff = 0, 0

    while i < j
      diff += 1 if @target[i] != @source[i]
      i += 1
    end

    diff
  end
end
