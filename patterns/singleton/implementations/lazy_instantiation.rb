module Singleton
  class LazyInstantiation
    def  self.instance
      @_instance ||= LazyInstantiation.new
    end

    private_class_method :new
  end
end
