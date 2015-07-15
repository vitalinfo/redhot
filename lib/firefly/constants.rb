module Firefly

  module Constants

    module Grabber
      LEAGUE_TIERS = [1, 2]

      BASE_URI = "https://api.steampowered.com"

      TOURNAMENT_LIST_PATH = "/IDOTA2Match_570/GetLeagueListing/v0001"
      LIVE_MATCH_LIST_PATH = "/IDOTA2Match_570/GetLiveLeagueGames/v0001"
      HISTORY_MATCH_LIST_PATH = "/IDOTA2Match_570/GetMatchHistory/v0001"
      SCHEDULED_MATCH_LIST_PATH = "/IDOTA2Match_570/GetScheduledLeagueGames/v0001"
      MATCH_DETAILS_PATH = "/IDOTA2Match_570/GetMatchDetails/v0001"
    end

  end

end