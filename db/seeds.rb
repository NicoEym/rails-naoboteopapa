
require 'csv'

Food.delete_all
Profile.delete_all
Restaurant.delete_all
# User.delete_all


Profile.create(name: 'Client')
Profile.create(name: 'Owner')





csv_options = { col_sep: ';', quote_char: '"', headers: :first_row }
filesrestaurants = 'db/csv_repos/restaurant.csv'
filesfood = 'db/csv_repos/food.csv'

CSV.foreach(filesrestaurants, csv_options) do |row|

  resto = Restaurant.create(name: row['name'], description: row['description'], address: row['address'], photo: row['photo'] )

  puts resto

end


CSV.foreach(filesfood, csv_options) do |row|

  restaurant = Restaurant.find_by(name: row['restaurant'])
  Food.create(restaurant: restaurant, name: row['name'], price: row['price'], photo: row['photo'] )

  puts "Creating food #{row['name']}"


end



