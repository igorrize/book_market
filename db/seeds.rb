# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'factory_bot_rails'

FactoryBot.create_list(:category, 10)

	Category.all.each do |category|
		100.times do 
			category.product.create(name: Faker::Book.title, price: rand(10.0..50.0))
		end
		end