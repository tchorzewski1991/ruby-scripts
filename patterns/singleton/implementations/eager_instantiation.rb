module Singleton
  # This example refers to 'eagerly instantiateable' implementation
  # of singleton object. Very similar example could be found in GOF
  # interpretation of singleton pattern.
  #
  # Adventages
  # - It is quite understandable, what's exactly going on.
  # - It presents the purpose and nature of the object easily.
  #
  # Disadvantages
  # - Eagerly instantiated. It will be loaded even, if we never use it.
  # - Not testable. In case of unit test we should always provide
  #   fresh environment and untouched state of objects. It is not
  #   possible to accomplish that with current implementation.

  class EagerInstantiation
    @@_instance = EagerInstantiation.new

    def self.instance
      @@_instance
    end

    private_class_method :new
  end
end
