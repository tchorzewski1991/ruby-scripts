module Singleton
  # This example refers to 'lazily instantiateable' implementation
  # of singleton object. Pretty congruous example could be found in
  # GOF interpretation of singleton pattern.
  #
  # Adventages
  # - It presents the purpose and nature of the object easily.
  # - It is instantiated lazily, which means instance of the
  #   LazyInstantiation class won't be created until the first
  #   call to LazyInstantiation#instance method happens.
  #
  # Disadvantages
  # - Need for being familiar with '||=' operator.
  # - not testable. In case of unit test we should always provide
  #   fresh environment and untouched state of objects. It is not
  #   possible to accomplish that with current implementation.

  class LazyInstantiation
    def  self.instance
      @_instance ||= LazyInstantiation.new
    end

    private_class_method :new
  end
end
