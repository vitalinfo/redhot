class Tournament < ActiveRecord::Base
  has_many :matches

  validates :name, presence: true, length: { maximum: 255 }
  validates :api_league_id, presence: true, uniqueness: true

  scope :not_finished, -> {where(finished: false)}
  scope :grabbable, -> {where(grabbable: true)}

  def max_match_id
    matches.maximum(:id).to_i
  end
end
