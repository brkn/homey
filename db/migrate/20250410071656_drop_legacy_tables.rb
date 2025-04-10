# frozen_string_literal: true

class DropLegacyTables < ActiveRecord::Migration[8.0]
  def up
    drop_table :comments
    drop_table :state_changes
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
