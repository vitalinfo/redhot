class AddFinalApiMatchIdToTournaments < ActiveRecord::Migration
  def change
    add_column :tournaments, :final_api_match_id, :integer
  end
end
