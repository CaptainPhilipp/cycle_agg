class CreatePricelists < ActiveRecord::Migration[5.1]
  def change
    create_table :pricelists do |t|
      t.string :attachment

      t.timestamps
    end
  end
end
