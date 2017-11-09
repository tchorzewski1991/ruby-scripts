module Interpose
  extend self

  def compute(collection = [], **opts)
    separator = opts.fetch(:separator, nil)

    enum = Enumerator.new do |yielder|
      length = collection.length
      k = 0

      while k < length
        element = collection[k]

        next(
          yielder << element
          k += 1
        ) if length == 1

        yielder << element
        yielder << separator if k.succ < length
        k += 1
      end
    end

    enum.to_a
  end
end
