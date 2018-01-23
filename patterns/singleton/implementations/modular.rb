module Singleton
  # This example refers to 'modular' implementation of
  # singleton object. This is my prototyping on this
  # subject.
  #
  # Adventages
  # - No need to worry about #new method, as this is method of
  #   the Class instance, not the Module instance.
  # - Testable. Singleton::Modular#test method gives us access
  #   and ability to create new, fresh instances of the _klass
  #   class which has already predefined behavior.
  # - _klass class instance is instantiated lazily, which means
  #    it won't be created until the first call to Modular#instance
  #    method happens.
  #
  # Disadvantages
  # - Strongly depends on metaprogramming skills.
  # - Can be included, extend, or prepended as this is
  #   a mixin.

  module Modular
    class << self
      # Returns lazily created instance of _klass class.
      # Note: It will be instantiated once, and unique
      #       for whole system.
      def instance
        @_instance ||= _klass.new
      end

      # Returns lazily created instance of Class with predefined
      # behavior.
      # Note: It is ready for creating new unique instances
      #       within specs.
      def test
        _klass
      end

      private

      # Lazily creates anonymous instance of Class with predefined
      # behavior.
      # Note: This is the place where you can define expected
      #       behavior.
      def _klass
        @_klass ||= begin
          Class.new do
          end
        end
      end
    end
  end
end
