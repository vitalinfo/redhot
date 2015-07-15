module Firefly
  module Grabber
    module Grabbers
      module MatchDetail

        module ClassMethods
          private
          def processing(match, result)
            return unless result && result[:match_id]
            match.update_attributes(online: false)
          end

          public
          def grab!
            ::Match.online.find_each do |match|
              processing(match, Firefly::Grabber::Request.get(Firefly::Constants::Grabber::MATCH_DETAILS_PATH,
                         match_id: match.api_match_id).result)
            end
          end

        end

        extend Firefly::Grabber::Grabbers::MatchDetail::ClassMethods
      end
    end
  end
end