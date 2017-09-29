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
  DEFAULT_BOOST_THRESHOLD = {
    enable: false,
    value: 0.7
  }

  def initialize(source, target, opts = {})
    super(source, target)
    @scaling_factor = set_scaling_factor(opts)
    @boost_threshold = set_boost_threshold(opts)
  end

  def distance(opts = {})
    # 'l' is the length of common prefix at the start of the string up to
    # a maximum of four characters.
    l = 0

    i = 0
    while i < 4
      break if @source[i] != @target[i]
      l += 1
      i += 1
    end

    j = super()
    bt = boost_threshold
    sf = scaling_factor

    bt && (j > bt && (j + l * sf * (1 - j)) || j) || (j + l * sf * (1 - j))
  end

  private
  attr_reader :scaling_factor, :boost_threshold

  def set_scaling_factor(opts)
    opts.dig(:scaling_factor) || DEFAULT_SCALING_FACTOR
  end

  def set_boost_threshold(opts)
    bt = opts.dig(:boost_threshold)
    bt = bt.is_a?(Hash) ? bt.dig(:enable) : false
    bt = bt.respond_to?(:&) ? (bt & true) : DEFAULT_BOOST_THRESHOLD[:enable]
    bt &&= opts.dig(:boost_threshold, :value) || DEFAULT_BOOST_THRESHOLD[:value]
  end
end
