
require 'csv'

# Food.delete_all
# Profile.delete_all
# Restaurant.delete_all
# User.delete_all


Profile.create(name: 'Client')
Profile.create(name: 'Owner')




# csv_options = { col_sep: ';', quote_char: '"', headers: :first_row }
# filesrestaurants = 'db/csv_repos/restaurant.csv'
# filesfood = 'db/csv_repos/food.csv'

# CSV.foreach(filesrestaurants, csv_options) do |row|

#   Restaurant.create(name: row['name'], description: row['description'], address: row['address'], photo: row['photo'] )

#   puts "Creating Restaurant #{row['name']}"

# end


# CSV.foreach(filesfood, csv_options) do |row|

#   restaurant_id = Restaurant.find_by(name: row['restaurant']).id
#   Food.create(restaurant_id: restaurant_id, name: row['name'], price: row['price'], photo: row['photo'] )

#   puts "Creating food #{row['name']}"


# end



