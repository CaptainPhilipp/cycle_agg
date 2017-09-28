class CreateChildrenParents < ActiveRecord::Migration[5.1]
  def change
    create_table :children_parents do |t|
      t.references :children, polymorphic: true, null: false
      t.references :parent, polymorphic: true, null: false

      t.timestamps
    end

    change_column_null :children_parents, :children_type, false
    change_column_null :children_parents, :parent_type, false
  end
end
