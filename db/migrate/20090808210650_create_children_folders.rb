class CreateChildrenFolders < ActiveRecord::Migration
  def self.up
    create_table :children_folders do |t|
      t.references :child, :polymorphic => true
      t.references :folder

      t.timestamps
    end
  end

  def self.down
    drop_table :children_folders
  end
end
