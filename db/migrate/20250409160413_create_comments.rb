# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[8.0]
  def change
    create_table :comments do |t|
      t.text :content, null: false
      t.string :author, null: false
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
