module Singleton
  class TestableClass
  end

  class SingletonTestableClass < TestableClass
    def self.instance
      @_instance ||= TestableClass.new
    end

    private_class_method :new
  end
end
