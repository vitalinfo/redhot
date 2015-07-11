module Firefly
  module Config
    def self.included(klass)
      klass.class_eval { extend Firefly::Config::ClassMethods }
    end

    module ClassMethods
      attr_reader :config

      def init_config(hash)
        @config ||= {}
        @config.merge!(hash)
      end
    end
  end

  include Firefly::Config
end