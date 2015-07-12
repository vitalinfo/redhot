FactoryGirl.define do

  factory :tournament do
    name { Faker::Lorem.word }
    sequence(:api_league_id) { |n| n}
    description { Faker::Lorem.sentence }
    tournament_url { Faker::Internet.url }
  end

  factory :match do
    tournament
    sequence(:api_match_id) { |n| n}
    league_tier {rand(3)}
    sequence(:spectators) { |n| n}
  end

end
