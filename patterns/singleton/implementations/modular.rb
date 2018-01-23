module Singleton
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
