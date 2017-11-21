module SingletonMethods
  def self.from_self
  end

  class << self
    def from_singleton_class
    end
  end

  def SingletonMethods.from_constant
  end

  define_singleton_method(:from_define_singleton_method) do
  end

  instance_eval do
    def from_instance_eval
    end
  end
end
