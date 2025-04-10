# frozen_string_literal: true

class CreateTimelineEntries < ActiveRecord::Migration[8.0]
  def change
    create_table :timeline_entries do |t|
      t.string :type, null: false
      t.references :project, null: false, foreign_key: true
      t.string :author, null: false

      t.text :content
      t.string :from_state
      t.string :to_state

      t.timestamps
    end
  end
end
