# frozen_string_literal: true

class CreateParameters < ActiveRecord::Migration[5.1]
  def change
    create_table :parameters do |t|
      t.string :ru_title
      t.string :en_title
      t.string :values_type

      t.timestamps
    end
  end
end
