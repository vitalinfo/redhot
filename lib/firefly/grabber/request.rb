module Firefly
  module Grabber
    module Request

      module ClassMethods
        private
        def config
          Firefly.config["grabber"]
        end

        def client
          @client ||= RestClient::Resource.new Firefly::Constants::Grabber::BASE_URI
        end

        def _get(path)
          response = nil
          t = Firefly::TimeBenchmark.time do
            begin
              response = client[path].get(params: {key: config["api_key"]})
            rescue
              response = {exception: $!}.to_json
            end
          end
          Rails.logger.debug "Request #{path} time: #{t}"
          response
        end

        public

        def get(path)
          Firefly::Grabber::Response.new(_get(path))
        end

      end

      extend Firefly::Grabber::Request::ClassMethods
    end
  end
end