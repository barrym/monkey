class RenameEntityHashToRef < ActiveRecord::Migration
  def self.up
    rename_column(:entities, :hash, :ref)
  end

  def self.down
    rename_column(:entities, :ref, :hash)
  end
end
