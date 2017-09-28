class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.string :ru_title
      t.string :en_title
      t.string :depth
      t.string :short_title

      t.timestamps
    end
  end
end
