class ChangeStatusToIntegerInItems < ActiveRecord::Migration[7.2]
  def change
    change_column :items, :status, :integer, default: 0
  end
end
