class AddProcessedToMatch < ActiveRecord::Migration
  def change
    add_column :matches, :processed, :boolean, default: false, index: true
  end
end
