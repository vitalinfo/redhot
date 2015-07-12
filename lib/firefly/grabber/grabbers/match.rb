module Firefly
  module Grabber
    module Grabbers
      module Match

        module ClassMethods
          private
          def processing_live(result)
            return unless result && result[:games] && result[:games].is_a?(Array)
            result[:games].each do |game|
              tournament = ::Tournament.where(api_league_id: game[:league_id]).first
              next unless tournament && Firefly::Constants::Grabber::LEAGUE_TIERS.include?(game[:league_tier].to_i)
              tournament.update_attributes(grabbable: true) unless tournament.grabbable?
              match = ::Match.where(api_match_id: game[:match_id]).first || ::Match.new
              match.update_attributes(tournament: tournament,
                                      api_match_id: game[:match_id],
                                      league_tier: game[:league_tier],
                                      spectators: game[:spectators],
                                      online: true)
            end
          end

          public
          def grab_live!
            processing_live(Firefly::Grabber::Request.get(Firefly::Constants::Grabber::LIVE_MATCH_LIST_PATH).result)
          end

        end

        extend Firefly::Grabber::Grabbers::Match::ClassMethods
      end
    end
  end
end