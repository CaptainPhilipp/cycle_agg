class AddPresentTypeToParameter < ActiveRecord::Migration[5.1]
  def change
    add_column :parameters, :present_type, :string

    change_column_null :parameters, :values_type, false
  end
end
