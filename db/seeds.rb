# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

items = Item.create!([{ name: 'りんご', price: 250 }, { name: 'バナナ', price: 100 }, { name: 'みかん（M3kg）', price: 3000 }])
backet = Backet.create!
backet.backet_items.create!(item: items[0], quantity: 2)
backet.backet_items.create!(item: items[1], quantity: 1)
