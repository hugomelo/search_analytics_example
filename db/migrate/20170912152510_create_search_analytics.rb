class CreateSearchAnalytics < ActiveRecord::Migration[5.1]
  def change
    create_table :search_analytics do |t|
      t.string :key
      t.integer :quantity

      t.timestamps
    end
  end
end
