class CreateListValues < ActiveRecord::Migration[5.1]
  def change
    create_table :list_values do |t|
      t.string :ru_title
      t.string :en_title

      t.timestamps
    end
  end
end
