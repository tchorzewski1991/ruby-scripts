module Singleton
  module Modular
    class << self
      def instance
        @_instance ||= _klass.new
      end

      def test
        _klass
      end

      private

      def _klass
        @_klass ||= begin
          Class.new do
          end
        end
      end
    end
  end
end
