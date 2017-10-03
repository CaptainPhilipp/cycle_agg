# frozen_string_literal: true

class CreateSportGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :sport_groups do |t|
      t.string :ru_title
      t.string :en_title
      t.string :short_title

      t.timestamps
    end
  end
end
