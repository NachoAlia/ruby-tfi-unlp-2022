# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Users
User.create(email:"user1@gmail.com", password:"123123", password_confirmation:"123123")
User.create(email:"user2@gmail.com", password:"123123", password_confirmation:"123123")

# Admin
User.create(email:"admin@gmail.com", password:"123123", password_confirmation:"123123", role:'admin')

# Branches
s1 = Sucursal.create(nombre:"sucursal1", direccion:"55 551 p5dt10", telefono:2346617276)
s2 = Sucursal.create(nombre:"sucursal2", direccion:"54 551 p5dt10", telefono:2346617277)

# Branch schedule
sch1 = s1.schedules.create!(day:1, start_time:(Time.parse("09:00").strftime("%H:%M")), end_time:(Time.parse("13:00").strftime("%H:%M")))
sch1 = s1.schedules.create!(day:3, start_time:(Time.parse("09:00").strftime("%H:%M")), end_time:(Time.parse("13:00").strftime("%H:%M")))
sch1 = s1.schedules.create!(day:5, start_time:(Time.parse("09:00").strftime("%H:%M")), end_time:(Time.parse("13:00").strftime("%H:%M")))
sch2 = s2.schedules.create!(day:2, start_time:(Time.parse("09:00").strftime("%H:%M")), end_time:(Time.parse("13:00").strftime("%H:%M")))
sch2 = s2.schedules.create!(day:4, start_time:(Time.parse("09:00").strftime("%H:%M")), end_time:(Time.parse("13:00").strftime("%H:%M")))
sch2 = s2.schedules.create!(day:6, start_time:(Time.parse("09:00").strftime("%H:%M")), end_time:(Time.parse("13:00").strftime("%H:%M")))

# Branch Staff
User.create(email:"staff1@gmail.com", password:"123123", password_confirmation:"123123", role:'staff', sucursal_id:s1.id)
User.create(email:"staff2@gmail.com", password:"123123", password_confirmation:"123123", role:'staff', sucursal_id:s2.id)
