class CreatePublications < ActiveRecord::Migration[5.1]
  def change # rubocop:disable Metrics/MethodLength
    create_table :publications do |t|
      t.string :title
      t.text   :description

      t.string :company
      t.string :shop_title
      t.string :shop_url

      t.integer :offer_id
      t.integer :offer_id
      t.string :url
      t.string :title
      t.string :picture
      t.boolean :available

      t.timestamps
    end
  end
end
