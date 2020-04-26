class CreateRestaurants < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.text :description
      t.float :longitude
      t.float :latitude
      t.string :source_url
      t.string :photo

      t.timestamps
    end
  end
end
