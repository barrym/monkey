class RemoveFolderIdFromEntities < ActiveRecord::Migration
  def self.up
    remove_column :entities, :folder_id
  end

  def self.down
  end
end
