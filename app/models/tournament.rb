class Tournament < ActiveRecord::Base
  validates :name, presence: true, length: { maximum: 255 }
  validates :league_id, presence: true, uniqueness: true
end
