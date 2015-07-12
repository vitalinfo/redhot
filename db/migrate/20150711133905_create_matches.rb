class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.column :tournament_id, :integer, null: false, index: true
      t.column :api_match_id, :integer, null: false
      t.column :league_tier, :integer, null: false
      t.column :spectators, :integer, null: false
      t.column :online, :boolean, null: false, default: false, index: true
      t.timestamps
    end
    add_index :matches, :api_match_id, unique: true
  end
end
