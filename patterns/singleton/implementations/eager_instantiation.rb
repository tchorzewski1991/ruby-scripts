module Singleton
  class EagerInstantiation
    @@_instance = EagerInstantiation.new

    def self.instance
      @@_instance
    end

    private_class_method :new
  end
end
