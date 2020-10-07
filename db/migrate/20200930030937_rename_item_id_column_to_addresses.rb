class RenameItemIdColumnToAddresses < ActiveRecord::Migration[6.0]
  def change
    rename_column :addresses, :item_id, :ordered_item_id
  end
end
