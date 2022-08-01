# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

super_admin_email = ENV['SUPER_ADMIN_EMAIL'].to_s
super_admin_name = 'Super Admin'

puts 'READ ENV ::::->>>>'
puts super_admin_email

# User.create email: super_admin_email, name: super_admin_name
