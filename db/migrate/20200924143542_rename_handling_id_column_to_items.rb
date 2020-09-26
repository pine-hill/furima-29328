class RenameHandlingIdColumnToItems < ActiveRecord::Migration[6.0]
  def change
    rename_column :items, :handling_id, :handling_time_id
  end
end