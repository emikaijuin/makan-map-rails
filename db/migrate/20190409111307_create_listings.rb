class CreateListings < ActiveRecord::Migration[5.2]
  def change
    create_table :listings do |t|
      t.float :latitude
      t.float :longitude
      t.text :address
      t.text :secondary_address
      t.text :zip_code
      t.text :city
      t.text :state
      t.text :country
      t.timestamps
    end
  end
end
