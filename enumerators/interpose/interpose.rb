module Interpose
  extend self

  # Interpose#compute creates enumerator that allows for separator insertion
  # between each neighbour elements of given collection. It uses nil as default
  # separator.

  # Example: Basic usage
  #   Returns new array with collection elements and nil as separator
  #
  #   Interpose.compute [1, 2, 3]
  #   => [1, nil, 2, nil, 3]
  #
  # Example: With 'separator' given from optional hash
  #   Returns new array with collection elements and 'separator' as separator
  #
  #   Interpose.compute [1, 2, 3], separator: 'separator'
  #   => [1, 'separator', 2, 'separator', 3]
  #
  # Example: For empty collection
  #   Returns new array without any elements
  #
  #   Interpose.compute []
  #   => []
  #
  # Example: For collection with only one element
  #   Returns new array with only one element
  #
  #   Interpose.compute [1]
  #   => [1]

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
