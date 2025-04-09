# frozen_string_literal: true

class RemoveStateFromProject < ActiveRecord::Migration[8.0]
  def up
    remove_column :projects, :state
  end

  def down
    add_column :projects, :state, :string, null: false, default: "todo"
  end
end
