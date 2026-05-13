class CreateItemImages < ActiveRecord::Migration[7.2]
  def change
    create_table :item_images do |t|
      t.references :item, null: false, foreign_key: true
      t.integer :position

      t.timestamps
    end
  end
end
