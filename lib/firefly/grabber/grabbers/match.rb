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

          def processing_history(tournament, result, max_match_id)
            return unless result && result[:matches] && result[:matches].is_a?(Array) && result[:matches].any?
            result[:matches].each do |game|
              match = ::Match.where(api_match_id: game[:match_id]).first || ::Match.new
              match.update_attributes(tournament: tournament,
                                      api_match_id: game[:match_id],
                                      league_tier: match.league_tier.to_i,
                                      spectators: game[:spectators].to_i,
                                      online: false)
              tournament.update_attributes(finished: true) if match.api_match_id == tournament.final_api_match_id
              return if max_match_id == match.api_match_id
              max_match_id = match.api_match_id
            end
            processing_history(tournament,
                               Firefly::Grabber::Request.get(Firefly::Constants::Grabber::HISTORY_MATCH_LIST_PATH,
                                                             {start_at_match_id: max_match_id + 1,
                                                              league_id: tournament.api_league_id}).result,
                               max_match_id)
          end

          def processing_scheduled
            return unless result && result[:games] && result[:games].is_a?(Array)
            result[:games].each do |game|
              Tournament.where(api_league_id: game[:league_id]).update_all(finished: true) if game[:final]
            end
          end

          public
          def grab_live!
            processing_live(Firefly::Grabber::Request.get(Firefly::Constants::Grabber::LIVE_MATCH_LIST_PATH).result)
          end

          def grab_history!
            ::Tournament.not_finished.grabbable.find_each do |tournament|
              processing_history(tournament,
                                 Firefly::Grabber::Request.get(Firefly::Constants::Grabber::HISTORY_MATCH_LIST_PATH,
                                                               {start_at_match_id: 0,
                                                                league_id: tournament.api_league_id}).result, 0)
            end
          end

          def scheduled_live!
            processing_scheduled(Firefly::Grabber::Request.get(Firefly::Constants::Grabber::SCHEDULED_MATCH_LIST_PATH).result)
          end

        end

        extend Firefly::Grabber::Grabbers::Match::ClassMethods
      end
    end
  end
end