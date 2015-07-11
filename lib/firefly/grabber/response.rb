module Firefly
  module Grabber
    class Response < Hash

      def initialize(source = "")
        super(nil)
        self.merge!(JSON.parse(source, {symbolize_names: true}))
      rescue
        self.merge!(error: source, exception: $!)
      end

      def result
        self[:result]
      end
    end
  end
end