class CreateSchedules < ActiveRecord::Migration[7.0]
  def change
    create_table :schedules do |t|
      t.belongs_to :sucursal, foreign_key: true
      t.integer :day, null: false, default:1
      t.time :start_time, null:false, default:"00:00:00"
      t.time :end_time, null:false, default:"00:00:00"
      t.timestamps
    end
    add_index :schedules, [:day, :sucursal_id], unique: true 
  end
end
