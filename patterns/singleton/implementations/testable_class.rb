module Singleton
  # This example refers to 'testable' implementation of singleton
  # object.
  #
  # Adventages
  # - It keeps 'behavior' in separate class, which makes it
  #   easily testable in standard way.
  # - It is instantiated lazily, which means instance of the
  #   SingletonTestableClass class won't be created until the first
  #   call to SingletonTestableClass#instance method happens.
  #
  # Disadvantages
  # - It is not unique because of instantiateable TestableClass,
  #   so it doesn't show unique nature of the object anymore?

  class TestableClass
  end

  class SingletonTestableClass < TestableClass
    def self.instance
      @_instance ||= TestableClass.new
    end

    private_class_method :new
  end
end
