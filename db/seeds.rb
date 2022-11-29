# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Users
User.create(email:"nachoalianiello@gmail.com", password:"123123", password_confirmation:"123123")
User.create(email:"nachoalianiello2@gmail.com", password:"123123", password_confirmation:"123123")

# Admin
User.create(email:"admin@admin.com", password:"123123", password_confirmation:"123123", role:'staff')
# UserSucursal
User.create(email:"nachoalianiello3@gmail.com", password:"123123", password_confirmation:"123123", role:'admin')
