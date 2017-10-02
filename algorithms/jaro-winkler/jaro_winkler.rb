require_relative '../jaro/jaro.rb'

class JaroWinkler < Jaro
  # Scaling factor is a constant for how much the score is adjusted
  # upwards for having common prefixes. It should not exceed 0.25, otherwise
  # the distance can become larger than 1. The standard value for this
  # constant in Winkler's work is p = 0.1
  DEFAULT_SCALING_FACTOR = 0.1

  # In some implementations of Jaro–Winkler, the prefix bonus lp(1 − dj) is
  # only added when the compared strings have a Jaro distance above a set
  # "boost threshold". The boost threshold in Winkler's implementation was 0.7.
  DEFAULT_BOOST_THRESHOLD = 0.7

  def distance(opts = {})
    s, t = @source, @target

    opts = {
      scaling_factor: DEFAULT_SCALING_FACTOR,
      boost_threshold: {
        enable: false,
        value: DEFAULT_BOOST_THRESHOLD
      }
    }.merge(opts)

    sf = opts.dig(:scaling_factor)
    bt = opts.dig(:boost_threshold, :enable) & true
    bt &&= opts.dig(:boost_threshold, :value)

    # 'l' is the length of common prefix at the start of the string up to
    # a maximum of four characters.
    l = 0

    i = 0
    while i < 4
      break if @source[i] != @target[i]
      l += 1
      i += 1
    end

    distance = super()

    prefix = l * sf * (1 - distance)

    distance = bt ?
    (distance > bt && (distance + prefix) || distance) : (distance + prefix)
  end
end
