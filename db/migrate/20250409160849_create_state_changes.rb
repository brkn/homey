# frozen_string_literal: true

class CreateStateChanges < ActiveRecord::Migration[8.0]
  def change
    create_table :state_changes do |t|
      t.string :from_state, null: false
      t.string :to_state, null: false
      t.string :author, null: false
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
