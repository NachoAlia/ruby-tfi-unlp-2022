# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_01_27_231517) do
  create_table "appointments", force: :cascade do |t|
    t.integer "sucursal_id"
    t.integer "client_id"
    t.integer "staff_id"
    t.date "appointment_date", null: false
    t.time "appointment_time", default: "2000-01-01 00:00:00", null: false
    t.integer "state", default: 0, null: false
    t.string "comment", default: "", null: false
    t.string "reason", default: "", null: false
    t.boolean "deleted", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_appointments_on_client_id"
    t.index ["staff_id"], name: "index_appointments_on_staff_id"
    t.index ["sucursal_id"], name: "index_appointments_on_sucursal_id"
  end

  create_table "schedules", force: :cascade do |t|
    t.integer "sucursal_id"
    t.integer "day", default: 1, null: false
    t.time "start_time", default: "2000-01-01 00:00:00", null: false
    t.time "end_time", default: "2000-01-01 00:00:00", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["day", "sucursal_id"], name: "index_schedules_on_day_and_sucursal_id", unique: true
    t.index ["sucursal_id"], name: "index_schedules_on_sucursal_id"
  end

  create_table "sucursals", force: :cascade do |t|
    t.string "nombre", default: "", null: false
    t.string "direccion", default: "", null: false
    t.string "telefono", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["nombre"], name: "index_sucursals_on_nombre", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "role", default: "client", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "sucursal_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["sucursal_id"], name: "index_users_on_sucursal_id"
  end

  add_foreign_key "appointments", "sucursals"
  add_foreign_key "appointments", "users", column: "client_id"
  add_foreign_key "appointments", "users", column: "staff_id"
  add_foreign_key "schedules", "sucursals"
  add_foreign_key "users", "sucursals"
end
