FactoryGirl.define do

  factory :tournament do
    name { Faker::Lorem.word }
    sequence(:league_id) { |n| n}
    description { Faker::Lorem.sentence }
    tournament_url { Faker::Internet.url }
  end

end
