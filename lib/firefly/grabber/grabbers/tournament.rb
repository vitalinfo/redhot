module Firefly
  module Grabber
    module Grabbers
      module Tournament

        module ClassMethods
          private
          def processing(result)
            return unless result && result[:leagues] && result[:leagues].is_a?(Array)
            result[:leagues].each do |league|
              ::Tournament.create(name:           league[:name],
                                  api_league_id:      league[:leagueid],
                                  description:    league[:description],
                                  tournament_url: league[:tournament_url])
            end
          end

          public
          def grab!
            processing(Firefly::Grabber::Request.get(Firefly::Constants::Grabber::TOURNAMENT_LIST_PATH).result)
          end

        end

        extend Firefly::Grabber::Grabbers::Tournament::ClassMethods
      end
    end
  end
end