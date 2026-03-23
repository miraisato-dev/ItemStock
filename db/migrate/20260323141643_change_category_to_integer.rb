class ChangeCategoryToInteger < ActiveRecord::Migration[7.2]
  def change
    remove_column :items, :category, :string
    add_column :items, :category, :integer
  end
end
