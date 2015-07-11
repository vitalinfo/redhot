module Firefly
  module TimeBenchmark
    module ClassMethods
      def time
        start = Time.now
        yield
        Time.now - start
      end
    end

    extend Firefly::TimeBenchmark::ClassMethods
  end
end