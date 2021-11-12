# frozen_string_literal: true

class CreateScores < ActiveRecord::Migration[6.1]
  def change
    create_table :scores do |t|
      t.string :player, null: false
      t.integer :score, null: false

      t.timestamps
    end
  end
end
