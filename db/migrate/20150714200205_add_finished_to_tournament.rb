class AddFinishedToTournament < ActiveRecord::Migration
  def change
    add_column :tournaments, :finished, :boolean, default: false, index: true
  end
end
