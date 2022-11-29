class FixColumnUserRole < ActiveRecord::Migration[7.0]
  def change
    change_table :users do |t|
      t.rename :rol, :role
      t.change :role, :string
      t.change_default :role, "client"
    end

  end
end
