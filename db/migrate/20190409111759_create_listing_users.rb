class CreateListingUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :listing_users do |t|

      t.timestamps
    end
  end
end
