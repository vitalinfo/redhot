class Tournament < ActiveRecord::Base
  has_many :matches

  validates :name, presence: true, length: { maximum: 255 }
  validates :api_league_id, presence: true, uniqueness: true
end
