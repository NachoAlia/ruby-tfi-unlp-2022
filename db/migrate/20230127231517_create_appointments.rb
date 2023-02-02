class CreateAppointments < ActiveRecord::Migration[7.0]
  def change
    create_table :appointments do |t|
      t.belongs_to :sucursal, foreign_key: true
      t.belongs_to :client, foreign_key: { to_table: :users }
      t.belongs_to :staff, foreign_key: { to_table: :users }

      t.date :appointment_date, null: false
      t.time :appointment_time, null:false, default:"00:00:00"
      t.integer :state, null:false, default:0
      t.string :comment, null:false, default:""
      t.string :reason, null:false, default:""
      t.boolean :deleted, null:false, default:false
      t.timestamps
    end
  end
end
