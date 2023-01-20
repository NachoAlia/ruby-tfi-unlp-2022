class CreateSucursals < ActiveRecord::Migration[7.0]
  def change
    create_table :sucursals do |t|
      t.string :nombre, null:false, default: ""
      t.string :direccion, null:false, default: ""
      t.string :telefono, null:false, default: ""
      t.timestamps
    end
    add_index :sucursals, :nombre, unique: true
  end


end
