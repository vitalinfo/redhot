class Match < ActiveRecord::Base
  belongs_to :tournament

  validates :tournament, presence: true
  validates :api_match_id, presence: true, uniqueness: true
  validates :league_tier, presence: true
  validates :spectators, presence: true

  scope :online, -> {where(online: true)}
end
