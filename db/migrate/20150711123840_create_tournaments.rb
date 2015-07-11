class CreateTournaments < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|
      t.column :name, :string, limit: 255, null: false
      t.column :league_id, :integer, null: false, index: true
      t.column :description, :text
      t.column :tournament_url, :text
      t.column :grabbable, :boolean, null: false, default: true, index: true
      t.timestamps
    end
  end
end
